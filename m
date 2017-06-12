From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 12 Jun 2017 10:21:17 +0200
Subject: [PATCH] selftests: nvmftests: unittest framework for NVMe Over
 Fabrics.
In-Reply-To: <20170612032610.4176-2-chaitanya.kulkarni@hgst.com>
References: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
 <20170612032610.4176-2-chaitanya.kulkarni@hgst.com>
Message-ID: <97992b7c-0b65-31d4-f435-e8c71d26d74a@suse.de>

On 06/12/2017 05:26 AM, Chaitanya Kulkarni wrote:
> +7. Dependencies
> +---------------
> +
> +    6.1. Python(>= 2.7.5 or >= 3.3)
> +    6.2. nose(http://nose.readthedocs.io/en/latest/)
> +    6.3. nose2(Installation guide http://nose2.readthedocs.io/)
> +    6.4. pep8(https://pypi.python.org/pypi/setuptools-pep8)
> +    6.5. flake8(https://pypi.python.org/pypi/flake8)
> +    6.6. pylint(https://www.pylint.org/)
> +    6.7. Epydoc(http://epydoc.sourceforge.net/)
> +    6.8. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
> +
> +    Python package management system pip can be used to install most of the
> +    listed packages(https://pip.pypa.io/en/stable/installing/) :-
> +
> +    $ pip install nose nose2 natsort pep8 flake8 pylint epydoc

Do we really need to pull in that many dependencies?


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
