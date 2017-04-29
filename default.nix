with import <nixpkgs> {};

(let



nltk = pkgs.python35Packages.buildPythonPackage rec{
    name = "nltk-${version}";
    version = "";
    src = pkgs.fetchurl{
     	url = "https://pypi.python.org/packages/13/ce/cba8bf82c8ab538d444ea4ab6f4eb1d80340c7b737d7a8d1f08b429fccae/nltk-3.2.2.tar.gz";
	sha256 = "1b37db344770021c9be3d68f48d1667a8dae6eeff0e502b7bfb01638d288a88e";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        python35Packages.numpy
        python35Packages.six
    ];
};

textblob = pkgs.python35Packages.buildPythonPackage rec{
    name = "textblob-${version}";
    version = "";

    src = pkgs.fetchurl{
    url = "https://pypi.python.org/packages/34/0f/b9db726a778ed1fc0651f8f44876526ab2d7c13b4d036eb2e42999ee7bdb/textblob-0.12.0.tar.gz";
        sha256 = "088349d5d742ff5c73dc863f4d0c40c9f347e52825f95027fe544daf29bdc3ab";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        python35Packages.numpy
        python35Packages.six
        nltk
    ];
};

apiai = pkgs.python35Packages.buildPythonPackage rec{
    name = "apiai-${version}";
    version = "";
    src = pkgs.fetchurl{
    url = "https://github.com/api-ai/apiai-python-client/archive/0.0.6.tar.gz";
        sha256 = "fa0701cdeebcce00858fd6b1b698819e561fad68a5e791d478f392d00632fa18";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        python35Packages.numpy
        python35Packages.scipy
    ];
};



opsdroid = pkgs.python35Packages.buildPythonPackage rec{
    name = "opsdroid-${version}";
    version = "";
    src = pkgs.fetchurl{
        url = "https://github.com/opsdroid/opsdroid/archive/v0.7.1.tar.gz";
        sha256 = "8ee7f83c74bf9f87677b3f3eaa50a4afb4cba77eafc220072bc2f78aec5d4bc2";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        aiohttp
        pycron
        pkgs.python35Packages.pyyaml
    ];
    buildInputs = [aiohttp];
};


aiohttp = pkgs.python35Packages.buildPythonPackage rec{
    name = "aiohttp-${version}";
    version = "";
    src = pkgs.fetchurl{
        url = "https://github.com/aio-libs/aiohttp/archive/1.3.1.tar.gz";
        sha256 = "6a29090bb1e4dfdd27e72b68e1901d21fa7c70d27f5160ea3498be375df57a54";
    };
    doCheck = false;
    setupPyBuildFlags = [  
   ];

    buildInputs =  [
        pkgs.python35Packages.async-timeout
        pkgs.python35Packages.chardet
        pkgs.python35Packages.multidict
        yarl
    ];

    propagatedBuildInputs =  [
        pkgs.python35Packages.async-timeout
        pkgs.python35Packages.chardet
        pkgs.python35Packages.multidict
        yarl
    ];
};


yarl = pkgs.python35Packages.buildPythonPackage rec{
    name = "yarl-${version}";
    version = "";
    src = pkgs.fetchurl{
        url = "https://pypi.python.org/packages/e4/aa/bc97551a2eb0c25711da61e16940decefdcc41b7bb8897b3c24e1623ef74/yarl-0.10.0.tar.gz";
        sha256 = "d92947434946bf47e3ee2123f4ea785ea4c7d5ba37c93fd2142470868dc2a01b";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        pkgs.python35Packages.multidict
    ];
};

pycron = pkgs.python35Packages.buildPythonPackage rec{
    name = "pycron-${version}";
    version = "";
    src = pkgs.fetchurl{
        url = "https://pypi.python.org/packages/ce/2f/ff88c5bda53aee33196f97832686c973bcf72a5f0f207af44f570626af34/pycron-0.40.tar.gz";
        sha256 = "817ec1d7328b42e18b695145983b4f634ffa703bac48c248c08b498034897ae5";
    };
    doCheck = false;
    setupPyBuildFlags = [];
    propagatedBuildInputs =  [
        pkgs.python35Packages.multidict
    ];
};





in python.buildEnv.override {
    extraLibs = [
        apiai
        opsdroid
        aiohttp
        pkgs.nodejs
        nltk
        textblob
        pkgs.python35Packages.bottle
        pkgs.python35Packages.hug
        pkgs.python35Packages.markdown
        pkgs.python35Packages.scrapy
        pkgs.python35Packages.requests2
    ];
    ignoreCollisions = true;
}).env







