From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 20 Sep 2018 10:36:30 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <1537464689.224533.10.camel@acm.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920170145.GA31127@localhost.localdomain>
 <1537464689.224533.10.camel@acm.org>
Message-ID: <1537464990.224533.13.camel@acm.org>

On Thu, 2018-09-20@10:31 -0700, Bart Van Assche wrote:
> On Thu, 2018-09-20@11:01 -0600, Keith Busch wrote:
> > On Tue, Sep 18, 2018@02:16:48PM -0700, Bart Van Assche wrote:
> > > Hello,
> > > 
> > > If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests
> > > against kernel v4.19-rc4 then a KASAN complaint appears. This complaint does
> > > not appear when I run these tests against kernel v4.18. Could this be a
> > > regression?
> > 
> > Not sure if the following is what you're hitting since it wouldn't be a
> > regression. It looks like removing a namespace path and clearing it as
> > the current path is in the wrong order, such that the very next IO
> > may reference the namespace being deleted.
> > 
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 893f1fcc17cd..a01b6743d62b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3143,8 +3143,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >  	}
> >  
> >  	mutex_lock(&ns->ctrl->subsys->lock);
> > -	nvme_mpath_clear_current_path(ns);
> >  	list_del_rcu(&ns->siblings);
> > +	nvme_mpath_clear_current_path(ns);
> >  	mutex_unlock(&ns->ctrl->subsys->lock);
> >  
> >  	down_write(&ns->ctrl->namespaces_rwsem);
> 
> That patch makes the KASAN complaint disappear on my test setup.

Sorry, I spoke too soon. I didn't see it in the dmesg output because it
disappeared from that buffer but I found the complaint in the system log:

Sep 20 10:17:23 ubuntu-vm kernel: [  144.820073] WARNING: possible circular locking dependency detected
Sep 20 10:17:23 ubuntu-vm kernel: [  144.972667] Call Trace:
Sep 20 10:18:51 ubuntu-vm kernel: [  232.585122] BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
Sep 20 10:18:51 ubuntu-vm kernel: [  232.585146] Call Trace:
Sep 20 10:28:02 ubuntu-vm kernel: [   58.755492] WARNING: possible circular locking dependency detected
Sep 20 10:28:02 ubuntu-vm kernel: [   58.825452] Call Trace:
Sep 20 10:31:44 ubuntu-vm kernel: [  281.520737] BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
Sep 20 10:31:44 ubuntu-vm kernel: [  281.538488] Call Trace:

Bart.
