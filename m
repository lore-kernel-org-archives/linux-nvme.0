From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Mon, 28 Aug 2017 18:10:44 +0000
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
In-Reply-To: <859a5a5d-9aa1-44e6-7d67-42fed0339a8b@grimberg.me>
References: <1503922057-1141-1-git-send-email-omri@excelero.com>
 <859a5a5d-9aa1-44e6-7d67-42fed0339a8b@grimberg.me>
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8872735FF@FMSMSX103.amr.corp.intel.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Sagi Grimberg
> Sent: Monday, August 28, 2017 6:44 AM
> To: Omri Mann <omri at excelero.com>; linux-nvme at lists.infradead.org
> Cc: Mike Christie <mchristi at redhat.com>
> Subject: Re: [PATCH] nvmet: Add support for HOST_ID feature.
> 
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index e3b244c..841f35d 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -132,6 +132,7 @@ struct nvmet_ctrl {
> >
> >   	char			subsysnqn[NVMF_NQN_FIELD_LEN];
> >   	char			hostnqn[NVMF_NQN_FIELD_LEN];
> > +	u64			host_id;
> 
> I'd move it to the first cacheline given it will be accessed
> in the hot path.
> 
> Other than that, looks fine,
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

The specification says that NVMe-oF must use a 128-bit host ID - from NVMe 1.3, 5.21.1.19.2:

"The Host Identifier is a mandatory feature in NVMe over Fabrics.  The Host Identifier shall be an extended 128-bit Host Identifier." 

The target should also check the EXHID bit in the Get Features - Host Identifier command.

Thanks,
-- Daniel Verkamp
