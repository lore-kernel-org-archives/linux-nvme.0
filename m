From: Sriram.Popuri@netapp.com (Popuri, Sriram)
Date: Wed, 6 Jun 2018 12:27:43 +0000
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180606121316.GA13227@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
 <BN7PR06MB40333AEEF5E96A05DC6B925592650@BN7PR06MB4033.namprd06.prod.outlook.com>
 <20180606121316.GA13227@lst.de>
Message-ID: <BN7PR06MB40338ED9C7EC6D89D2CD7A9E92650@BN7PR06MB4033.namprd06.prod.outlook.com>

" In theory it could.  In practice that is going to get you very large data transfers for the ANA log, which we can't chunk."
I don't think so. ANA log is based on num ana grps. NANAGRPID can be small, but ANAGRPMAX could be large if a sparse id space is chosen.

Regards,
~Sriram

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Wednesday, June 6, 2018 5:43 PM
To: Popuri, Sriram <Sriram.Popuri at netapp.com>
Cc: Christoph Hellwig <hch at lst.de>; linux-nvme at lists.infradead.org; Hannes Reinecke <hare at suse.de>; Meneghini, John <John.Meneghini at netapp.com>; Knight, Frederick <Frederick.Knight at netapp.com>
Subject: Re: [PATCH 5/9] nvme: add ANA support

On Wed, Jun 06, 2018@12:01:04PM +0000, Popuri, Sriram wrote:
> +	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
> +			GFP_KERNEL);
> 
> You are assuming anagrpmax is a small value. I guess it can go upto ffffffffh.

In theory it could.  In practice that is going to get you very large data transfers for the ANA log, which we can't chunk.

At some point we might want to look into using the page allocator here, but for now I'd like to keep it simple.
