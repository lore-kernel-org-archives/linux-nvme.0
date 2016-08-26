From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 26 Aug 2016 09:41:32 -0500
Subject: [PATCH WIP/RFC 3/6] nvme_rdma: keep a ref on the ctrl
 during	delete/flush
In-Reply-To: <20160826143815.GA21869@lst.de>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <a0c9e6cccbccc1e5893af51a7824c9bad2a62a5a.1472219586.git.swise@opengridcomputing.com>
 <20160826143815.GA21869@lst.de>
Message-ID: <02cd01d1ffa7$f03c9ae0$d0b5d0a0$@opengridcomputing.com>

> 
> This looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> Minor nitpick in case you're going to respin it anyway:
> 
> > +	/*
> > +	 * Keep a reference until all work is flushed since
> > +	 * __nvme_rdma_del_ctrl can free the ctrl mem
> > +	 */
> > +	kref_get(&ctrl->ctrl.kref);
> >
> >  	ret = __nvme_rdma_del_ctrl(ctrl);
> >  	if (ret)
> > -		return ret;
> > +		goto out;
> >
> >  	flush_work(&ctrl->delete_work);
> > -
> > -	return 0;
> > +out:
> > +	nvme_put_ctrl(&ctrl->ctrl);
> > +	return ret;
> 
> How about:
> 
> 	kref_get(&ctrl->ctrl.kref);
> 	ret = __nvme_rdma_del_ctrl(ctrl);
> 	if (!ret)
> 		flush_work(&ctrl->delete_work);
> 	nvme_put_ctrl(&ctrl->ctrl);
> 	return ret;
> 
> here?

That looks cleaner.
