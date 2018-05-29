From: igor.j.konopko@intel.com (Konopko, Igor J)
Date: Tue, 29 May 2018 13:55:56 +0000
Subject: [PATCH] Set extended metadata field properly
In-Reply-To: <2cfe0341-612a-5537-d824-776c2f61d28c@mellanox.com>
References: <20180529134515.3452-1-igor.j.konopko@intel.com>
 <2cfe0341-612a-5537-d824-776c2f61d28c@mellanox.com>
Message-ID: <76C92B909A93A84C99173B331AB578DAC7AB5365@irsmsx111.ger.corp.intel.com>

Got it, thanks
Igor

> -----Original Message-----
> From: Max Gurtovoy [mailto:maxg at mellanox.com]
> Sent: Tuesday, May 29, 2018 3:50 PM
> To: Konopko, Igor J <igor.j.konopko at intel.com>; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] Set extended metadata field properly
> 
> Hi Igor,
> I've sent the same patch in my T10-PI support addition to NVMe/RDMA.
> Christoph already reviewed and said he'll merge it to nvme branch.
> 
> On 5/29/2018 4:45 PM, Igor Konopko wrote:
> > When setting extended metadata indicator in namespace
> > structure we take metadata size into consideration.
> > Unfortunately up-to-date metadata size is
> > not yet set during this calculation, which results
> > in incorrect setting of that field in some cases.
> >
> > This patch fixes that issue.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko at intel.com>
> > ---
> >   drivers/nvme/host/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 5e1d6d69b307..553af7531329 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1448,8 +1448,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct
> nvme_id_ns *id)
> >   	if (ns->lba_shift == 0)
> >   		ns->lba_shift = 9;
> >   	ns->noiob = le16_to_cpu(id->noiob);
> > -	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
> >   	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
> > +	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
> >   	/* the PI implementation requires metadata equal t10 pi tuple size */
> >   	if (ns->ms == sizeof(struct t10_pi_tuple))
> >   		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
> >
