From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 23 Oct 2018 21:59:02 +0200
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <1540324467.66186.10.camel@acm.org>
 (sfid-20181023_215432_845345_964A5C27)
References: <20180927180031.10706-1-sagi@grimberg.me>
 <CAO+b5-oBVw=-wvnWk1EF=RBaZtjX6bjUG+3WABXbvzX9UTu26w@mail.gmail.com>
 <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
 <1539966212.81977.53.camel@acm.org>
 <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
 <1540243046.128590.28.camel@acm.org>
 (sfid-20181022_231730_752241_D589AC78)
 <085ad00de636fd4f3a7c2cccd5d991df11931ead.camel@sipsolutions.net>
 <1540324467.66186.10.camel@acm.org> (sfid-20181023_215432_845345_964A5C27)
Message-ID: <7b03008a1e0e5990ed75c573b20bb9020ea992aa.camel@sipsolutions.net>

On Tue, 2018-10-23@12:54 -0700, Bart Van Assche wrote:
> On Tue, 2018-10-23@21:18 +0200, Johannes Berg wrote:
> > On Mon, 2018-10-22@14:17 -0700, Bart Van Assche wrote:
> > > On Mon, 2018-10-22@10:56 +0200, Johannes Berg wrote:
> > > > On Fri, 2018-10-19@16:23 +0000, Bart Van Assche wrote:
> > > > > On Thu, 2018-10-18@18:08 -0700, Sagi Grimberg wrote:
> > > > > > > It seems like this has not yet been fixed entirely. This is what appeared
> > > > > > > in the kernel log this morning on my test setup with Christoph's nvme-4.20
> > > > > > > branch (commit cb4bfda62afa ("nvme-pci: fix hot removal during error
> > > > > > > handling")):
> > > > 
> > > > FWIW, I'm not sure where to find this tree (it's not on kernel.org,
> > > > apparently, at least none of hch's?). As a result, I don't have the
> > > > correct code here now.
> > > 
> > > Christoph's NVMe tree is available at git://git.infradead.org/nvme.git.
> > 
> > Ok, thanks. I think I'll go off Sagi Grimberg's explanation though
> > rather than try to understand the code myself.
> 
> Are the lockdep annotations in kernel/workqueue.c correct? My understanding
> is that lock_map_acquire() should only be used to annotate mutually exclusive
> locking (e.g. mutex, spinlock). However, multiple work items associated with
> the same workqueue can be executed concurrently. From lockdep.h:
> 
> #define lock_map_acquire(l) lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)

I've talked about this in the other thread, in the interest of keeping
things together, can you ask that again over there?

johannes
