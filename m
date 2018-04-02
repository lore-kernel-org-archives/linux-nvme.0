From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 2 Apr 2018 23:27:40 +0000
Subject: [RFC PATCH 4/8] nvmet: use const values for id-ctrl
In-Reply-To: <06ee48f5-822c-4fe1-78ca-f8fd22af5d87@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-5-chaitanya.kulkarni@wdc.com>
 <06ee48f5-822c-4fe1-78ca-f8fd22af5d87@deltatee.com>
Message-ID: <46ECB5C6-5B65-44F5-82F7-EE4FEA2015EB@wdc.com>

[CK] In this way we have less number of code changes, may be when
we add more target type we can think of adding helpers for id-ctrl and
id-ns to isolate the common code ?

On 3/30/18, 11:51 AM, "Logan Gunthorpe" <logang@deltatee.com> wrote:

    
    
    On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
    > This patch adds constant values which are used in
    > target identify ctrl.
    > 
    > These values will be used in implementing
    > target passthru identify ctrl to mask the passthru
    > ctrl values with the default target ctrl values.
    > 
    > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
    > ---
    >  drivers/nvme/target/admin-cmd.c | 6 +++---
    >  drivers/nvme/target/nvmet.h     | 4 ++++
    >  2 files changed, 7 insertions(+), 3 deletions(-)
    > 
    > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
    > index 90dcdc40ac71..6b3d20b32187 100644
    > --- a/drivers/nvme/target/admin-cmd.c
    > +++ b/drivers/nvme/target/admin-cmd.c
    > @@ -210,7 +210,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
    >  	 * comands.  But we don't do anything useful for abort either, so
    >  	 * no point in allowing more abort commands than the spec requires.
    >  	 */
    > -	id->acl = 3;
    > +	id->acl = NVMET_ID_CTRL_ACL;
    >  
    >  	id->aerl = NVMET_ASYNC_EVENTS - 1;
    >  
    > @@ -223,8 +223,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
    >  	/* We support keep-alive timeout in granularity of seconds */
    >  	id->kas = cpu_to_le16(NVMET_KAS);
    >  
    > -	id->sqes = (0x6 << 4) | 0x6;
    > -	id->cqes = (0x4 << 4) | 0x4;
    > +	id->sqes = NVMET_ID_CTRL_SQES;
    > +	id->cqes = NVMET_ID_CTRL_CQES;
    
    Hmm, I don't know... maybe see what others think but this doesn't feel
    right to me. Perhaps a helper function to set the common elements wtih
    nvmet_id_ctrl_init_fabircs_fields() of the id struct would be more
    appropriate.
    
    Logan
    
