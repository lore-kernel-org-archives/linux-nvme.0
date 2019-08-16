From: keith.busch@gmail.com (Keith Busch)
Date: Fri, 16 Aug 2019 06:46:41 -0600
Subject: [PATCH] Revert "nvme-pci: use host managed power state for
 suspend"
In-Reply-To: <20190816123850.GA22923@lst.de>
References: <20190816121549.8754-1-chris@chris-wilson.co.uk>
 <20190816122644.GA21797@lst.de>
 <156595862897.11610.6852982219615959799@skylake-alporthouse-com>
 <20190816123850.GA22923@lst.de>
Message-ID: <CAOSXXT54LyxmF7sAgfxYr7G_vnvDjhiEiHnVm7Zrm1vjS7zLQA@mail.gmail.com>

On Fri, Aug 16, 2019@6:38 AM Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Aug 16, 2019@01:30:29PM +0100, Chris Wilson wrote:
> > Quoting Christoph Hellwig (2019-08-16 13:26:44)
> > > Please, report the actual problem.  Blindly reverting a patch without
> > > even an explanation of your regressions is not the way to do it.
> >
> > As stated, the system doesn't suspend.
> >
> > If you would like to wait, you will get test results from our CI
> > giving the current failed state and the outcome of the patch.
>
> Platform type, SSD vendor and type, firmware version?

Also not a fan of knee-jerk reverts. Even if it may turn out to be
necessary, let's at least start with a bug report for an opportunity
to fix first!

Could you please try Rafael's solution? These two commits here:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=xps13-9380-20190812&id=accd2dd72c8f087441d725dd916688171519e4e6
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=xps13-9380-20190812&id=4eaefe8c621c6195c91044396ed8060c179f7aae
