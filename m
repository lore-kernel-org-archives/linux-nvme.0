From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Sun, 29 Oct 2017 11:52:37 -0600
Subject: [PATCH 2/2] nvme-rdma: Add remote_invalidation module parameter
In-Reply-To: <1509295101-14081-3-git-send-email-idanb@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-3-git-send-email-idanb@mellanox.com>
Message-ID: <20171029175237.GD4488@ziepe.ca>

On Sun, Oct 29, 2017@06:38:21PM +0200, idanb@mellanox.com wrote:
  
> +static bool remote_invalidation = true;
> +module_param(remote_invalidation, bool, 0444);
> +MODULE_PARM_DESC(remote_invalidation,
> +	 "request remote invalidation from subsystem (default: true)");

Please no module options.

If your device has a performance anomaly that makes
SEND_WITH_INVALIDATE slower than local invalidation, then we need to
talk about having a new verbs flag for this situation so all the ULPs
can avoid using SEND_WITH_INVALIDATE..

Sagi, is this really an apples to apples comparison?

When I was talking with Chuck on NFS there were some various issues on
that side that made the local invalidate run faster, but it wasn't
actually working properly.

Does nvme wait for the local invalidate to finish before moving on?

Jason
