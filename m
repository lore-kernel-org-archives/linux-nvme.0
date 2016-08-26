From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Aug 2016 16:38:15 +0200
Subject: [PATCH WIP/RFC 3/6] nvme_rdma: keep a ref on the ctrl during
 delete/flush
In-Reply-To: <a0c9e6cccbccc1e5893af51a7824c9bad2a62a5a.1472219586.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <a0c9e6cccbccc1e5893af51a7824c9bad2a62a5a.1472219586.git.swise@opengridcomputing.com>
Message-ID: <20160826143815.GA21869@lst.de>

This looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Minor nitpick in case you're going to respin it anyway:

> +	/*
> +	 * Keep a reference until all work is flushed since
> +	 * __nvme_rdma_del_ctrl can free the ctrl mem
> +	 */
> +	kref_get(&ctrl->ctrl.kref);
>  
>  	ret = __nvme_rdma_del_ctrl(ctrl);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	flush_work(&ctrl->delete_work);
> -
> -	return 0;
> +out:
> +	nvme_put_ctrl(&ctrl->ctrl);
> +	return ret;

How about:

	kref_get(&ctrl->ctrl.kref);
	ret = __nvme_rdma_del_ctrl(ctrl);
	if (!ret)
		flush_work(&ctrl->delete_work);
	nvme_put_ctrl(&ctrl->ctrl);
	return ret;

here?
