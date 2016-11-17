From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 17 Nov 2016 10:56:31 -0800
Subject: [PATCH] nvmecli-tests : update the list of dependencies
In-Reply-To: <CAK0tqinhd3jeasr5+3dtPFB149wREcBwwAw0UrpfNuqpE3Uheg@mail.gmail.com>
References: <CAK0tqinhd3jeasr5+3dtPFB149wREcBwwAw0UrpfNuqpE3Uheg@mail.gmail.com>
Message-ID: <1479408991.3774.7.camel@linux.intel.com>

On Thu, 2016-11-17@00:48 -0800, chaitany kulkarni wrote:
> README file is updated with complete list of dependencies
> required to setup the environment for unitttests.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
> ---
> ?tests/README | 13 +++++++++++--
> ?1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/README b/tests/README
> index 70686d8..686bd04 100644
> --- a/tests/README
> +++ b/tests/README
> @@ -12,8 +12,17 @@ nvmetests
> ?------------------------------
> 
> ?????1. Python(>= 2.7.5 or >= 3.3)
> -????2. nose2(Installation guide http://nose2.readthedocs.io/)
> -????3. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
> +????2. nose(http://nose.readthedocs.io/en/latest/)
> +????3. nose2(Installation guide http://nose2.readthedocs.io/)
> +????4. pep8(https://pypi.python.org/pypi/setuptools-pep8)
> +????5. flake8(https://pypi.python.org/pypi/flake8)
> +????6. pylint(https://www.pylint.org/)
> +????7. Epydoc(http://epydoc.sourceforge.net/)
> +????8. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
> +
> +????Python package management system pip can be used to install most
> of the
> +????listed packages(https://pip.pypa.io/en/stable/installing/) :-
> +????$ pip install nose nose2 pep8 flake8 pylint epydoc
> 

Readme looks good, seems to address Keith's point on dependencies.

Though Keith mentioned there was a 'doc' folder referenced in the
README that appeared to be missing from the commit. ?Maybe that is a
future patch?

Reviewed-by: ?Jay Freyensee <james_p_freyensee at linux.intel.com>
