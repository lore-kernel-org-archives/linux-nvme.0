From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Oct 2018 14:17:26 -0700
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
References: <20180927180031.10706-1-sagi@grimberg.me>
 <CAO+b5-oBVw=-wvnWk1EF=RBaZtjX6bjUG+3WABXbvzX9UTu26w@mail.gmail.com>
 <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
 <1539966212.81977.53.camel@acm.org>
 <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
Message-ID: <1540243046.128590.28.camel@acm.org>

On Mon, 2018-10-22@10:56 +0200, Johannes Berg wrote:
> On Fri, 2018-10-19@16:23 +0000, Bart Van Assche wrote:
> > On Thu, 2018-10-18@18:08 -0700, Sagi Grimberg wrote:
> > > > It seems like this has not yet been fixed entirely. This is what appeared
> > > > in the kernel log this morning on my test setup with Christoph's nvme-4.20
> > > > branch (commit cb4bfda62afa ("nvme-pci: fix hot removal during error
> > > > handling")):
> 
> FWIW, I'm not sure where to find this tree (it's not on kernel.org,
> apparently, at least none of hch's?). As a result, I don't have the
> correct code here now.

Christoph's NVMe tree is available at git://git.infradead.org/nvme.git.

Bart.
