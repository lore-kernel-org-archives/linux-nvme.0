From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2019 08:26:48 -0600
Subject: [PATCH] Revert "nvme-pci: use host managed power state for
 suspend"
In-Reply-To: <156596473180.11610.10618280744615593681@skylake-alporthouse-com>
References: <20190816121549.8754-1-chris@chris-wilson.co.uk>
 <20190816122644.GA21797@lst.de>
 <156595862897.11610.6852982219615959799@skylake-alporthouse-com>
 <20190816123850.GA22923@lst.de>
 <CAOSXXT54LyxmF7sAgfxYr7G_vnvDjhiEiHnVm7Zrm1vjS7zLQA@mail.gmail.com>
 <156596473180.11610.10618280744615593681@skylake-alporthouse-com>
Message-ID: <20190816142648.GA6849@localhost.localdomain>

On Fri, Aug 16, 2019@07:12:11AM -0700, Chris Wilson wrote:
> Quoting Keith Busch (2019-08-16 13:46:41)
> > Could you please try Rafael's solution? These two commits here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=xps13-9380-20190812&id=accd2dd72c8f087441d725dd916688171519e4e6
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=xps13-9380-20190812&id=4eaefe8c621c6195c91044396ed8060c179f7aae
> 
> Which indeed work, thank you.

Great! A pull request inlcuding these fixes was sent to Linus earlier
today. We should expect to see its inclusion in the next -rc.
