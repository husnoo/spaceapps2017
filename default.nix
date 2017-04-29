with import <nixpkgs> {};

(let


nbsphinx = pkgs.pythonPackages.buildPythonPackage rec{
  name = "nbsphinx-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://pypi.python.org/packages/ec/89/0e170282547362e4cd3648a85fb326ae0e8bcbaea54241c73bda6ac36bfb/nbsphinx-0.2.13.tar.gz";
    sha256 = "20f4bca5f45ffe65fff4d616c2caf365375e8f8768a73d63905bd5d0664176bd";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    pythonPackages.sphinx
    pythonPackages.nbconvert
    pythonPackages.numpydoc
    pythonPackages.nbformat
  ];
};

nltk = pkgs.pythonPackages.buildPythonPackage rec{
  name = "nltk-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://pypi.python.org/packages/13/ce/cba8bf82c8ab538d444ea4ab6f4eb1d80340c7b737d7a8d1f08b429fccae/nltk-3.2.2.tar.gz";
    sha256 = "1b37db344770021c9be3d68f48d1667a8dae6eeff0e502b7bfb01638d288a88e";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    pythonPackages.numpy
    pythonPackages.six
    
  ];
};



textblob = pkgs.pythonPackages.buildPythonPackage rec{
  name = "textblob-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://pypi.python.org/packages/34/0f/b9db726a778ed1fc0651f8f44876526ab2d7c13b4d036eb2e42999ee7bdb/textblob-0.12.0.tar.gz";
    sha256 = "088349d5d742ff5c73dc863f4d0c40c9f347e52825f95027fe544daf29bdc3ab";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    pythonPackages.numpy
    pythonPackages.six
    nltk
  ];
};











apiai = pkgs.pythonPackages.buildPythonPackage rec{
  name = "apiai-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://github.com/api-ai/apiai-python-client/archive/0.0.6.tar.gz";
    sha256 = "fa0701cdeebcce00858fd6b1b698819e561fad68a5e791d478f392d00632fa18";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    pythonPackages.numpy
    pythonPackages.scipy
  ];
};






patsy = pkgs.pythonPackages.buildPythonPackage rec{
  name = "patsy-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://github.com/pydata/patsy/archive/v0.4.1.tar.gz";
    sha256 = "411fed41d318cadd81e4704cbea23413d703743512482fe4e465261a2280c750";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    pythonPackages.six
    pythonPackages.numpy
  ];
};





pymc3 = pkgs.pythonPackages.buildPythonPackage rec{
  name = "pymc3-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://github.com/pymc-devs/pymc3/archive/v3.0.tar.gz";
    sha256 = "11a0aac548bbf639686ea3155e25de3dde77fa7218bbc76dc084ca96d871b638";
  };
  doCheck = false;
  setupPyBuildFlags = [];
  propagatedBuildInputs =  [
    nbsphinx
    pythonPackages.numpy
    pythonPackages.scipy
    pythonPackages.matplotlib
    pythonPackages.TheanoWithoutCuda
    pythonPackages.pandas
    patsy
    pythonPackages.joblib
    pythonPackages.tqdm
    pythonPackages.CommonMark_54
    pythonPackages.recommonmark
    pythonPackages.sphinx
    pythonPackages.six
    pythonPackages.h5py
  ];
};




cartopy = pkgs.pythonPackages.buildPythonPackage rec{
  name = "cartopy-${version}";
  version = "";

  src = pkgs.fetchurl{
  url = "https://github.com/SciTools/cartopy/archive/v0.15.1.tar.gz";
    sha256 = "c2221eaf8cb3827b026a398374f3b2e9431aa77fdf95754229232ef5236221ed";
  };
  doCheck = false;
  setupPyBuildFlags = ["-I${geos}/include" "-L${geos}/lib"];
  propagatedBuildInputs =  [
    gcc
    pkgs.geos
    proj
    pythonPackages.numpy
    pythonPackages.cffi
    pythonPackages.cython
    pythonPackages.shapely
    pythonPackages.six
    pythonPackages.pyshp
  ];
};

pymunk = pkgs.pythonPackages.buildPythonPackage rec{
  name = "pymunk-${version}";
  version = "5.1.0";

  src = pkgs.fetchurl{
    url = "mirror://pypi/p/pymunk/pymunk-${version}.zip";
    sha256 = "83b3c6db9b556af215d5cb858b88745924afab53f0025f20e89491e65f606424";
  };

  propagatedBuildInputs =  [ chipmunk pythonPackages.cffi ];
  
};

pynanomsg = pkgs.pythonPackages.buildPythonPackage rec{
  name = "nanomsg-${version}";
  version = "1.0";

  src = pkgs.fetchurl{
    url = "mirror://pypi/n/nanomsg/nanomsg-1.0.tar.gz";
    sha256 = "843be41258219d9d319cf434a68cac7669834ab9c993ea4bab5b3d87f62a7a13";
  };
  doCheck = false;

  propagatedBuildInputs =  [ nanomsg pythonPackages.cffi ];
  
};

pybullet = pkgs.pythonPackages.buildPythonPackage rec{
  name = "pybullet-${version}";
  version = "1.0";

  src = pkgs.fetchurl{
    url = "https://github.com/20tab/pybulletphysics/archive/master.zip";
    sha256 = "af83414cbaa7a164fbc49af57d34a9ecabfc1d9809fafe35ed3d09336a4b437a";
  };
  doCheck = false;

  buildInputs = [pkgconfig bullet];
  propagatedBuildInputs =  [ bullet pythonPackages.cffi ];
  
};



keras = pkgs.pythonPackages.buildPythonPackage rec{
  name = "keras-${version}";
  version = "2.0.3";

  src = pkgs.fetchurl{
    url = "https://github.com/fchollet/keras/archive/2.0.3.tar.gz";
    sha256 = "6b9b66282a894b816ceee5a5fb56e57cf6de22858a7c2b54b1e24c58665ae31a";
  };
  doCheck = false;

  buildInputs = [
      pkgs.pythonPackages.TheanoWithoutCuda
      pkgs.pythonPackages.pyaml
      pkgs.pythonPackages.pyyaml
 ];
  propagatedBuildInputs =  [
      pkgs.pythonPackages.TheanoWithoutCuda
      pkgs.pythonPackages.pyaml
      pkgs.pythonPackages.pyyaml
  ];
  
};



in python.buildEnv.override {
  extraLibs = [
    #apiai
    #pkgs.nodejs
    nltk
    textblob
    pkgs.pythonPackages.requests

    pkgs.pythonPackages.whoosh

    pkgs.pythonPackages.bottle
    

#keras
#pymc3
cartopy
#pymunk
#pynanomsg
#pybullet
#pkgs.pythonPackages.Keras
#pkgs.pythonPackages.msgpack
#pkgs.pythonPackages.pygments
#pkgs.pythonPackages.hug
#pkgs.pythonPackages.pyaml
#pkgs.pythonPackages.markdown
    pkgs.pythonPackages.numpy
    pkgs.pythonPackages.scipy
    #pkgs.pythonPackages.tables
    #pkgs.pythonPackages.sqlalchemy
#pkgs.pythonPackages.scikitlearn
#pkgs.pythonPackages.sympy
    pkgs.pythonPackages.pyqt4
    #pkgs.pythonPackages.shapely
    #pkgs.pythonPackages.pyshp
    #pkgs.pythonPackages.tensorflowWithoutCuda
    #pkgs.pythonPackages.gnureadline
    #pkgs.pythonPackages.h5py
    #pkgs.pythonPackages.pandas
#pkgs.pythonPackages.dask
    #pkgs.pythonPackages.scrapy
    pkgs.pythonPackages.matplotlib
    #pkgs.pythonPackages.statsmodels
#pkgs.pythonPackages.seaborn
#pkgs.pythonPackages.bokeh
    #pkgs.pythonPackages.requests2
    #pkgs.pythonPackages.jupyter
#pkgs.pythonPackages.ipython
    #pkgs.pythonPackages.cffi
#pkgs.pythonPackages.imageio
    #pkgs.pythonPackages.TheanoWithoutCuda
    #pkgs.geos
    #proj
    #pythonPackages.libgpuarray-cuda

    #pythonPackages.jupyter_core
    #pythonPackages.notebook    
    #pythonPackages.jupyterlab
    #pythonPackages.jupyter_client
    #pythonPackages.jupyter_console

];
  ignoreCollisions = true;
}).env







