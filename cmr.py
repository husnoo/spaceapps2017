

import requests
import numpy
import xml.etree.ElementTree as ET
from textblob import TextBlob


def parse_one_entry(c):
    d = c.getchildren()
    try:
        e = d[0].getchildren()
    except Exception as e:
        print(c)
        print(e)
        return {}
    entry = {'category': set(), 'topic': set(), 'term': set()}
    for f in e:
        if 'Entry_ID' in f.tag:
            entry['id'] = f.text
        elif 'Entry_Title' in f.tag:
            entry['title'] = f.text
        elif 'Spatial_Coverage' in f.tag:
            g = f.getchildren()
            for h in g:
                if 'Southernmost_Latitude' in h.tag:
                    entry['lat1'] = h.text
                elif 'Northernmost_Latitude' in h.tag:
                    entry['lat2'] = h.text
                elif 'Westernmost_Longitude' in h.tag:
                    entry['lon1'] = h.text
                elif 'Easternmost_Longitude' in h.tag:
                    entry['lon2'] = h.text
        elif 'Parameters' in f.tag:
            for p in f.getchildren():
                if 'Category' in p.tag:
                    entry['category'].add(p.text)
                elif 'Topic' in p.tag:
                    entry['topic'].add(p.text)
                elif 'Term' in p.tag:
                    entry['term'].add(p.text)                        
        elif 'Summary' in f.tag:
            entry['summary'] = f.getchildren()[0].text
        else:
            pass    
    return entry


# fetch xml
if 0:
    collections = []
    for page in range(1,18):
        url = "https://cmr.earthdata.nasa.gov/search/collections.native?page_size=2000&page_num="+str(page)
        print(url)
        data = requests.get(url).text
        with open('data/batches/batch-'+str(page)+'.xml', 'w') as f:
            f.write(data.encode('utf8'))

# xml to npz 
if 0:
    all_ents = []
    for page in range(1,18):
        print(page)
        tree = ET.parse('data/batches/batch-{}.xml'.format(page))
        root = tree.getroot()
        c = root.getchildren()[2:]
        all_ents += map(parse_one_entry, c)
        numpy.savez("data/all_ents.npz", numpy.array(all_ents))


# Full text search - create index
if 0:
    from whoosh.index import create_in
    from whoosh.fields import *
    schema = Schema(cid=TEXT(stored=True), summary=TEXT, title=TEXT)
    ix = create_in("data/indexdir", schema)
    writer = ix.writer()
    all_ents = numpy.load("data/all_ents.npz")['arr_0']
    n = len(all_ents)
    for i, ent in enumerate(all_ents):
        print(i, n)
        try:
            ent['summary'] = ' '.join(ent['summary'].replace('\n', ' ').split())
        except:
            continue
        #print(ent['id'])
        #print(ent['title'])
        #print(ent['summary'])
        #print('-----')
        writer.add_document(cid=unicode(ent['id']),
                            summary=unicode(ent['summary']),
                            title=unicode(ent['title']))
    writer.commit()


# search by latlon
if 1:
    all_ents = numpy.load("data/all_ents.npz")['arr_0']
    n = len(all_ents)
    lat1 = []
    lat2 = []
    lon1 = []
    lon2 = []
    ids = []
    
    for ent in all_ents:
        try:
            x = (ent['id'], ent['lat1'], ent['lat2'], ent['lon1'], ent['lon2'])
        except:
            continue
        ids.append(ent['id'])
        lat1.append(ent['lat1'])
        lat2.append(ent['lat2'])
        lon1.append(ent['lon1'])
        lon2.append(ent['lon2'])

    numpy.savez('data/index-latlon.npz', ids=numpy.array(ids), lat1=numpy.array(lat1), lat2=numpy.array(lat2),
                lon1=numpy.array(lon1), lon2=numpy.array(lon2) )
    

# Word frequency
if 0:
    all_ents = numpy.load("data/all_ents.npz")['arr_0']
    for ent in all_ents:
        try:
            print(ent['summary'])
        except:
            pass
    
    


###############################################################################
# Demonstration

if 0:
    import numpy


    # data by id
    all_ents = numpy.load("data/all_ents.npz")['arr_0']
    the_ents = {}
    for ent in all_ents:
        try:
            the_ents[ent['id']] = ent
        except:
            continue
        
    # Full text search
    from whoosh.qparser import QueryParser
    from whoosh.index import open_dir
    ix = open_dir("data/indexdir")

    with ix.searcher() as searcher:
        query = QueryParser("summary", ix.schema).parse("Municipality")
        results = searcher.search(query)
        print(list(results))

    # search by latlon
    f = numpy.load("data/index-latlon.npz")
    lat1 = numpy.array(map(float, f['lat1']))
    lat2 = numpy.array(map(float, f['lat2']))
    lon1 = numpy.array(map(float, f['lon1']))
    lon2 = numpy.array(map(float, f['lon2']))
    ids = f['ids']
    cond1 = numpy.logical_and(lat1> 40, lat2 < 60)
    cond2 = numpy.logical_and(lon1>-10, lon2<10)
    cond = numpy.logical_and(cond1, cond2)

    goodids = filter(lambda x: len(x)>0, map(lambda x: ''.join(x.split()), ids[cond]))
    for aid in goodids:
        print(the_ents[aid])



    
    
    


    
    
