From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 07:54:41 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <BN7PR06MB4033AEEF34ABC70C71175B6992650@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de>
 <BN7PR06MB4033AEEF34ABC70C71175B6992650@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <20180607075441.638efcd6@pentland.suse.de>

On Wed, 6 Jun 2018 19:02:16 +0000
"Popuri, Sriram" <Sriram.Popuri@netapp.com> wrote:

> Looks like __nvme_find_path is pretty basic one.
> Let's say if there are 2 NVME_ANA_OPTIMIZED paths. However it looks
> like the first found path is chosen. That means having more than one
> NVME_ANA_OPTIMIZED paths doesn't help much. Any plans to round robin?
> 
> > -	/* XXX: try an inaccessible path as last resort per
> > 8.18.3.3 */
> > +	if (!ns)
> > +		ns = __nvme_find_path(head,
> > NVME_ANA_INACCESSIBLE);  
> 
> Also if there are multiple NVME_ANA_INACCESSIBLE paths and only a
> few(or one) is changing ANA state from INACCESSIBLE to OPTIMIZED and
> if that happens to be the last entry in your list, then trying above
> doesn't really help.
> 
That patch has been retracted; I'll be sending an updated patch series
for implementing ANATT handling soon.

Cheers,

Hannes
