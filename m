From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 12 Jun 2017 09:16:54 -0700
Subject: [PATCH] selftests: nvmftests: unittest framework for NVMe Over
 Fabrics.
In-Reply-To: <97992b7c-0b65-31d4-f435-e8c71d26d74a@suse.de>
References: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
 <20170612032610.4176-2-chaitanya.kulkarni@hgst.com>
 <97992b7c-0b65-31d4-f435-e8c71d26d74a@suse.de>
Message-ID: <20170612161654.GA1862@infradead.org>

On Mon, Jun 12, 2017@10:21:17AM +0200, Johannes Thumshirn wrote:
> On 06/12/2017 05:26 AM, Chaitanya Kulkarni wrote:
> > +7. Dependencies
> > +---------------
> > +
> > +    6.1. Python(>= 2.7.5 or >= 3.3)
> > +    6.2. nose(http://nose.readthedocs.io/en/latest/)
> > +    6.3. nose2(Installation guide http://nose2.readthedocs.io/)
> > +    6.4. pep8(https://pypi.python.org/pypi/setuptools-pep8)
> > +    6.5. flake8(https://pypi.python.org/pypi/flake8)
> > +    6.6. pylint(https://www.pylint.org/)
> > +    6.7. Epydoc(http://epydoc.sourceforge.net/)
> > +    6.8. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
> > +
> > +    Python package management system pip can be used to install most of the
> > +    listed packages(https://pip.pypa.io/en/stable/installing/) :-
> > +
> > +    $ pip install nose nose2 natsort pep8 flake8 pylint epydoc
> 
> Do we really need to pull in that many dependencies?

A few of those shouldn't be required at runtime just for developers
I think (pep8, flake8 pylint, epydoc).  So the only real depencies
to run it should be nose2 (we shouldn't need nose when there is nose2
but I need to spend some more time with the code), nvme-cli and python
itself which seems pretty reasonable.
