From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 14:13:16 +0200
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <BN7PR06MB40333AEEF5E96A05DC6B925592650@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
 <BN7PR06MB40333AEEF5E96A05DC6B925592650@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <20180606121316.GA13227@lst.de>

On Wed, Jun 06, 2018@12:01:04PM +0000, Popuri, Sriram wrote:
> +	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
> +			GFP_KERNEL);
> 
> You are assuming anagrpmax is a small value. I guess it can go upto ffffffffh.

In theory it could.  In practice that is going to get you very large
data transfers for the ANA log, which we can't chunk.

At some point we might want to look into using the page allocator here,
but for now I'd like to keep it simple.
