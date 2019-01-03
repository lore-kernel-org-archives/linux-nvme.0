From: rajur@chelsio.com (Raju Rangoju)
Date: Thu, 3 Jan 2019 22:59:36 +0530
Subject: [PATCH v2] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <2874ee1e-a205-44c5-ae91-7ddf039d76f4@mellanox.com>
References: <20190103103336.6343-1-rajur@chelsio.com>
 <2874ee1e-a205-44c5-ae91-7ddf039d76f4@mellanox.com>
Message-ID: <20190103172935.GA23880@chelsio.com>

On Thursday, January 01/03/19, 2019@18:15:55 +0200, Max Gurtovoy wrote:
> 
> >  	spin_unlock_irqrestore(&queue->rsps_lock, flags);
> >  	if (unlikely(!rsp)) {
> >-		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
> >+		int ret = -EINVAL;
> >+
> 
> no real need to initialize ret variable (sorry I didn't see it in
> first review).
> 
>

No problem. I'll post v3.

> >+		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
