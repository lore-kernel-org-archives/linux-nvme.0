From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 May 2018 09:27:46 +0200
Subject: [PATCH 2/5] nvme: Add ANA base definitions
In-Reply-To: <20180504112845.38820-3-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-3-hare@suse.de>
Message-ID: <20180509072746.GB20363@lst.de>

On Fri, May 04, 2018@01:28:42PM +0200, Hannes Reinecke wrote:
> Add definitions from the ANA TP errata.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  include/linux/nvme.h | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 4112e2bd747f..40c2d08ee761 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -242,7 +242,11 @@ struct nvme_id_ctrl {
>  	__le32			sanicap;
>  	__le32			hmminds;
>  	__le16			hmmaxd;
> -	__u8			rsvd338[174];
> +	__u8			anatt;
> +	__u8			anacap;
> +	__le32			anagrpmax;
> +	__le32			nanagrpid;
> +	__u8			rsvd338[164];

SANICAP is at bytes 328 to 331, the HMM field go from 332 to 337,
so we really need to reserve bytes 338, 339, and 340 before starting
the ANA fields.  Note that this is already hinted at by the naming
for the rsvd338 field.  So the new post-ana rsvd field should also
be named rsvd352

>  	__u8			rsvd1024[768];
>  	__le32			ioccsz;
> @@ -312,7 +317,8 @@ struct nvme_id_ns {
>  	__le16			nabspf;
>  	__le16			noiob;
>  	__u8			nvmcap[16];
> -	__u8			rsvd64[40];
> +	__u8			rsvd64[36];
> +	__le32			anagrpid;
>  	__u8			nguid[16];

nguid is at offset 104, so if you please anagrip just before
it it is in the wrong offset.

> +	NVME_ANA_STATE_OPTIMIZED = 0x01,
> +	NVME_ANA_STATE_NONOPTIMIZED = 0x02,
> +	NVME_ANA_STATE_INACCESSIBLE = 0x03,
> +	NVME_ANA_STATE_PERSISTENT_LOSS = 0x04,
> +	NVME_ANA_STATE_CHANGE_STATE = 0x05,

Please make this a separate 'enum nvme_ana_state'

> +/* Asymmetric Namespace Access log page entry */
> +struct nvmf_ana_group_descriptor {
> +	__le32 groupid;
> +	__le32 nsid_num;
> +	__le64 chgcnt;
> +	__u8 ana_state;
> +	__u8 resv1[7];

Pleae encode the offset of the reserved field in the name:

	__u8 resv17[7];

> +	__le32 nsid[0];

Please use C99 flexible arrays:

	__le32 nsid[];

> +struct nvmf_ana_rsp_page_header {
> +	__le64 chgcnt;
> +	__le16 grpid_num;
> +	__le16 resv[3];
> +	struct nvmf_ana_group_descriptor desc[0];
> +};

Same here.

also we use _hdr for the discover log name, maybe match that here.
