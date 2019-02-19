From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Feb 2019 09:55:02 -0700
Subject: [PATCH 6/6] nvme: Avoid that deleting a controller triggers a
 circular locking complaint
In-Reply-To: <20190219151655.GB4121@lst.de>
References: <20190214225057.195397-1-bvanassche@acm.org>
 <20190214225057.195397-7-bvanassche@acm.org>
 <20190219151655.GB4121@lst.de>
Message-ID: <20190219165501.GC16341@localhost.localdomain>

On Tue, Feb 19, 2019@04:16:55PM +0100, Christoph Hellwig wrote:
> Keith, Sagi,
> 
> can you look over this as you two have been most involved with the state
> machine lately?

This looks correct. I had to double check 'ret' was initilized to 0
outside what the diff is showing, so maybe it'd be more obvious if
nvme_do_delete_ctrl() was in an 'else' condition. Beyond that nit,
the series looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
 
> On Thu, Feb 14, 2019@02:50:57PM -0800, Bart Van Assche wrote:
> > @@ -191,9 +191,10 @@ static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
> >  	 * can free the controller.
> >  	 */
> >  	nvme_get_ctrl(ctrl);
> > -	ret = nvme_delete_ctrl(ctrl);
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
> > +		ret = -EBUSY;
> >  	if (!ret)
> > -		flush_work(&ctrl->delete_work);
> > +		nvme_do_delete_ctrl(ctrl);
> >  	nvme_put_ctrl(ctrl);
> >  	return ret;
> >  }
