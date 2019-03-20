From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 14:50:04 +0200
Subject: [PATCH 7/9] nvme/core: add mdev interfaces
In-Reply-To: <20190320114621.GC5542@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319144116.400-8-mlevitsk@redhat.com>
 <20190320114621.GC5542@stefanha-x1.localdomain>
Message-ID: <f55b768e86e77fd9dc36aa7e2602c4f1fd7cd3b1.camel@redhat.com>

On Wed, 2019-03-20@11:46 +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2019@04:41:14PM +0200, Maxim Levitsky wrote:
> > +int nvme_core_register_mdev_driver(struct nvme_mdev_driver *driver_ops)
> > +{
> > +	struct nvme_ctrl *ctrl;
> > +
> > +	if (mdev_driver_interface)
> > +		return -EEXIST;
> > +
> > +	mdev_driver_interface = driver_ops;
> 
> Can mdev_driver_interface be accessed from two CPUs at the same time?
> mdev_driver_interface isn't protected by the mutex.  The state_changed
> functions below also don't protect mdev_driver_interface.

It can be for sure.
However the only time it is updated is when the mdev core module load/unload
routines.

On module load the interface flips from NULL to a pointer to inside of the
module, so this should be safe, and when mdev module unloads, its reference
counter is 0, and all the callers first try to increase it and fail, they don't
call using this interface.

I might still be wrong with this reasoning though.

Best regards,
	Maxim Levitsky
