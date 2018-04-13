From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:28:19 +0200
Subject: [RFC PATCH 4/8] nvmet: use const values for id-ctrl
In-Reply-To: <06ee48f5-822c-4fe1-78ca-f8fd22af5d87@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-5-chaitanya.kulkarni@wdc.com>
 <06ee48f5-822c-4fe1-78ca-f8fd22af5d87@deltatee.com>
Message-ID: <20180413172819.GB23674@lst.de>

On Fri, Mar 30, 2018@12:50:45PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
> > This patch adds constant values which are used in
> > target identify ctrl.
> > 
> > These values will be used in implementing
> > target passthru identify ctrl to mask the passthru
> > ctrl values with the default target ctrl values.
> > 
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> > ---
> >  drivers/nvme/target/admin-cmd.c | 6 +++---
> >  drivers/nvme/target/nvmet.h     | 4 ++++
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 90dcdc40ac71..6b3d20b32187 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -210,7 +210,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >  	 * comands.  But we don't do anything useful for abort either, so
> >  	 * no point in allowing more abort commands than the spec requires.
> >  	 */
> > -	id->acl = 3;
> > +	id->acl = NVMET_ID_CTRL_ACL;
> >  
> >  	id->aerl = NVMET_ASYNC_EVENTS - 1;
> >  
> > @@ -223,8 +223,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >  	/* We support keep-alive timeout in granularity of seconds */
> >  	id->kas = cpu_to_le16(NVMET_KAS);
> >  
> > -	id->sqes = (0x6 << 4) | 0x6;
> > -	id->cqes = (0x4 << 4) | 0x4;
> > +	id->sqes = NVMET_ID_CTRL_SQES;
> > +	id->cqes = NVMET_ID_CTRL_CQES;
> 
> Hmm, I don't know... maybe see what others think but this doesn't feel
> right to me. Perhaps a helper function to set the common elements wtih
> nvmet_id_ctrl_init_fabircs_fields() of the id struct would be more
> appropriate.

Or just keep it open coded, the numeric values should be pretty obvious
from the (public) spec.
