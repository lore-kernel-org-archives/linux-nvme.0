From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 30 May 2019 19:20:44 +0900
Subject: [PATCH 1/2] nvme: prepare for fault injection into admin commands
In-Reply-To: <CAC5umyityGQyO+kCZ+LHqxGugKPQGv1tgrTc==x=6EjfgJkOqQ@mail.gmail.com>
References: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
 <1559063018-3682-2-git-send-email-akinobu.mita@gmail.com>
 <20190529144624.GA28274@minwooim-desktop>
 <CAC5umyityGQyO+kCZ+LHqxGugKPQGv1tgrTc==x=6EjfgJkOqQ@mail.gmail.com>
Message-ID: <20190530102042.GB8843@minwooim-desktop>

On 19-05-30 01:39:38, Akinobu Mita wrote:
> 2019?5?29?(?) 23:46 Minwoo Im <minwoo.im.dev at gmail.com>:
> >
> > On 19-05-29 02:03:37, Akinobu Mita wrote:
> > > Currenlty fault injection support for nvme only enables to inject errors
> > > into the commands submitted to I/O queues.
> > >
> > > In preparation for fault injection into the admin commands, this makes
> > > the helper functions independent of struct nvme_ns.
> > >
> > > Cc: Thomas Tai <thomas.tai at oracle.com>
> > > Cc: Keith Busch <kbusch at kernel.org>
> > > Cc: Jens Axboe <axboe at fb.com>
> > > Cc: Christoph Hellwig <hch at lst.de>
> > > Cc: Sagi Grimberg <sagi at grimberg.me>
> > > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > > ---
> > >  drivers/nvme/host/core.c         |  4 ++--
> > >  drivers/nvme/host/fault_inject.c | 28 +++++++++++++++-------------
> > >  drivers/nvme/host/nvme.h         | 20 ++++++++++++--------
> > >  3 files changed, 29 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 26c8b59..9fca8457 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3698,7 +3698,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> > >       device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
> > >
> > >       nvme_mpath_add_disk(ns, id);
> > > -     nvme_fault_inject_init(ns);
> > > +     nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> > >       kfree(id);
> > >
> > >       return 0;
> > > @@ -3723,7 +3723,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> > >       if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
> > >               return;
> > >
> > > -     nvme_fault_inject_fini(ns);
> > > +     nvme_fault_inject_fini(&ns->fault_inject);
> > >       if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
> > >               del_gendisk(ns->disk);
> > >               blk_cleanup_queue(ns->queue);
> > > diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
> > > index 4cfd2c9..e8d8da9 100644
> > > --- a/drivers/nvme/host/fault_inject.c
> > > +++ b/drivers/nvme/host/fault_inject.c
> > > @@ -15,11 +15,10 @@ static DECLARE_FAULT_ATTR(fail_default_attr);
> > >  static char *fail_request;
> > >  module_param(fail_request, charp, 0000);
> > >
> > > -void nvme_fault_inject_init(struct nvme_ns *ns)
> > > +void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
> > > +                         const char *name)
> >
> > Hi Akinobu,
> >
> > Just a simple proposal here.  Can we have a name for the disk name with:
> >         const char *disk_name ?
> > I think the name of variable "name" can make some confusions to whom want
> > to use this feature at later time :)
> 
> As long as ns->disk->disk_name is passed to this argument, 'disk_name' is
> good.
> 
> However, dev_name(ctrl->device) will be passed to the argument in the patch
> 2/2.  It's not 'disk_name' anymore, so I think 'name' or 'dev_name' is
> better than 'disk_name'.

Then can we have it "dev_name"?

> 
> > Otherwise, in the perspective of this single patch, looks good to me.
> >
> > Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
