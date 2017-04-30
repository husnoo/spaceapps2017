
import numpy
from whoosh.qparser import QueryParser
from whoosh.index import open_dir
import bottle
import json

#'''
all_ents = numpy.load("data/all_ents.npz")['arr_0']
the_ents = {}
for ent in all_ents:
    try:
        the_ents[ent['id']] = ent
    except:
        continue
ix = open_dir("data/indexdir")

f = numpy.load("data/index-latlon.npz")
lat1 = numpy.array(map(float, f['lat1']))
lat2 = numpy.array(map(float, f['lat2']))
lon1 = numpy.array(map(float, f['lon1']))
lon2 = numpy.array(map(float, f['lon2']))
ids = f['ids']
print('loaded')

print(len(lat1))
print(len(lon1))
print(len(lat2))
print(len(lon2))
print(len(ids))


def search_latlon(lat_low, lat_high, lon_west, lon_east):
    goodids = []
    for i in range(len(ids)-1):
        if (lat1[i] <  lat_low) and (lat2[i] >  lat_high) and (lon1[i] <  lon_west) and (lon2[i] >  lon_east):
            goodids.append(ids[i])
    return goodids


def search_text(val):
    with ix.searcher() as searcher:
        query = QueryParser("summary", ix.schema).parse(val)
        results = searcher.search(query)
        return filter(lambda x: len(x)>0, map(lambda x: ''.join(x['cid'].split()), list(results)))



@bottle.route('/latlon/<lat1x>/<lat2x>/<lon1x>/<lon2x>')
def latlon(lat1x, lat2x, lon1x, lon2x):
    cids = search_latlon(float(lat1x), float(lat2x), float(lon1x), float(lon2x))
    return json.dumps(cids)


@bottle.route('/word/<word>')
def word(word):
    cids = search_text(word)
    print(cids)
    return json.dumps(cids)


@bottle.route('/entry/<cid>')
def entry(cid):
    for key in the_ents[cid]:
        if type(the_ents[cid][key])==set:
            the_ents[cid][key] = list(the_ents[cid][key])
    return json.dumps(the_ents[cid])


# get: 127.0.0.1:8888/
@bottle.route('/')
def index():
    return '''
<html>
<body>
<a href="http://127.0.0.1:8888/word/tourism">word</a>
<a href="http://127.0.0.1:8888/latlon/50/51/-4/-3">latlon</a>
<a href="http://127.0.0.1:8888/entry/mlml91_Water">Entry</a>
</body>
</html>
'''

bottle.run(host='127.0.0.1', port=8888)













