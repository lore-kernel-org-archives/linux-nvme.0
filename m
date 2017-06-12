From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Jun 2017 18:19:24 +0200
Subject: [PATCH v6 05/10] nvmet: implement namespace identify
 descriptor list
In-Reply-To: <MWHPR04MB10088151BCB7D7A209A739E686CD0@MWHPR04MB1008.namprd04.prod.outlook.com>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-6-jthumshirn@suse.de> <20170608074414.GD13953@lst.de>
 <ac55e56a-a47e-1e53-c537-b940de99c746@suse.de>
 <20170608075209.GA14359@lst.de>
 <MWHPR04MB10088151BCB7D7A209A739E686CD0@MWHPR04MB1008.namprd04.prod.outlook.com>
Message-ID: <20170612161924.GA30742@lst.de>

On Mon, Jun 12, 2017@03:33:11AM +0000, Chaitanya Kulkarni wrote:
> Right now I'm keeping the framework under "${KDIR}/tools/testing/selftests/", please let me know if that is not a desirable directory.

Heh, Johannes and I just had a discussion on the test framework
locations last weekend over a beer.

Both of us agree that a separate repository would be much preferable,
mostly due to two reasons:

 - it allows people that backport changes (e.g. distros) to always
   run the latests test suite without having to backport it as well,
   and have one test suite config for all branches
 - ease of running it from a VM or initramfs instead of having to
   download the whole kernel tree or copying things out

Last but not least it also seems a little easier to get started that
way.
