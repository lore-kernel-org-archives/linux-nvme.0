From: m@bjorling.me (Matias Bjorling)
Date: Tue, 05 May 2015 20:51:03 +0200
Subject: [PATCH v3 7/7] nvme: LightNVM support
In-Reply-To: <1429712816-10336-8-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
 <1429712816-10336-8-git-send-email-m@bjorling.me>
Message-ID: <55491117.6080902@bjorling.me>

> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -39,6 +39,7 @@
>   #include <linux/slab.h>
>   #include <linux/t10-pi.h>
>   #include <linux/types.h>
> +#include <linux/lightnvm.h>
>   #include <scsi/sg.h>
>   #include <asm-generic/io-64-nonatomic-lo-hi.h>
>
> @@ -134,6 +135,11 @@ static inline void _nvme_check_size(void)
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
>   	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_hb_rw) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_l2ptbl) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_bbtbl) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_set_resp) != 64);
> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
>   }

Keith, should I move the lightnvm definition into the nvme-lightnvm.c 
file as well?

>   static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
>   							struct nvme_ns *ns)
>   {
> @@ -888,12 +937,29 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		}
>   	}
>
> +	if (ns->type == NVME_NS_NVM) {
> +		switch (nvm_prep_rq(req, &iod->nvm_rqdata)) {
> +		case NVM_PREP_DONE:
> +			goto done_cmd;
> +		case NVM_PREP_REQUEUE:
> +			blk_mq_requeue_request(req);
> +			blk_mq_kick_requeue_list(hctx->queue);
> +			goto done_cmd;
> +		case NVM_PREP_BUSY:
> +			goto retry_cmd;
> +		case NVM_PREP_ERROR:
> +			goto error_cmd;
> +		}
> +	}
> +

Regarding the prep part. I'm not 100% satisfied with it. I can refactor 
it into a function and clean it up. There is still a need for the 
jumping, as it depends on the iod.

Another possibility is to only call it on lightnvm capable controllers. 
With its own queue_rq function. It would be global for all namespaces. 
The flow would then look like

register -> nvme_nvm_queue_rq

nvme_nvm_queue_rq()
   if (ns is normal command set)
     return nvme_queue_rq();

   __nvme_nvm_queue_rq()

Any thoughts?

> index aef9a81..5292906 100644
> --- a/include/uapi/linux/nvme.h
> +++ b/include/uapi/linux/nvme.h
> @@ -85,6 +85,35 @@ struct nvme_id_ctrl {
>   	__u8			vs[1024];
>   };
>
> +struct nvme_nvm_id_chnl {
> +	__le64			laddr_begin;
> +	__le64			laddr_end;
> +	__le32			oob_size;
> +	__le32			queue_size;
> +	__le32			gran_read;
> +	__le32			gran_write;
> +	__le32			gran_erase;
> +	__le32			t_r;
> +	__le32			t_sqr;
> +	__le32			t_w;
> +	__le32			t_sqw;
> +	__le32			t_e;
> +	__le16			chnl_parallelism;
> +	__u8			io_sched;
> +	__u8			reserved[133];
> +} __attribute__((packed));
> +
> +struct nvme_nvm_id {
> +	__u8				ver_id;
> +	__u8				nvm_type;
> +	__le16				nchannels;
> +	__u8				reserved[252];
> +	struct nvme_nvm_id_chnl	chnls[];
> +} __attribute__((packed));
> +
> +#define NVME_NVM_CHNLS_PR_REQ ((4096U - sizeof(struct nvme_nvm_id)) \
> +					/ sizeof(struct nvme_nvm_id_chnl))
> +
>   enum {
>   	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
>   	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
> @@ -130,6 +159,7 @@ struct nvme_id_ns {
>
>   enum {
>   	NVME_NS_FEAT_THIN	= 1 << 0,
> +	NVME_NS_FEAT_NVM	= 1 << 3,
>   	NVME_NS_FLBAS_LBA_MASK	= 0xf,
>   	NVME_NS_FLBAS_META_EXT	= 0x10,
>   	NVME_LBAF_RP_BEST	= 0,
> @@ -146,6 +176,8 @@ enum {
>   	NVME_NS_DPS_PI_TYPE1	= 1,
>   	NVME_NS_DPS_PI_TYPE2	= 2,
>   	NVME_NS_DPS_PI_TYPE3	= 3,
> +
> +	NVME_NS_NVM		= 1,
>   };
>
>   struct nvme_smart_log {
> @@ -229,6 +261,12 @@ enum nvme_opcode {
>   	nvme_cmd_resv_report	= 0x0e,
>   	nvme_cmd_resv_acquire	= 0x11,
>   	nvme_cmd_resv_release	= 0x15,
> +
> +	nvme_nvm_cmd_hb_write	= 0x81,
> +	nvme_nvm_cmd_hb_read	= 0x02,
> +	nvme_nvm_cmd_phys_write	= 0x91,
> +	nvme_nvm_cmd_phys_read	= 0x92,
> +	nvme_nvm_cmd_erase	= 0x90,
>   };
>
>   struct nvme_common_command {
> @@ -261,6 +299,74 @@ struct nvme_rw_command {
>   	__le16			appmask;
>   };
>
> +struct nvme_nvm_hb_rw {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd2;
> +	__le64			metadata;
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le64			slba;
> +	__le16			length;
> +	__le16			control;
> +	__le32			dsmgmt;
> +	__le64			phys_addr;
> +};
> +
> +struct nvme_nvm_l2ptbl {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__le32			cdw2[4];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le64			slba;
> +	__le32			nlb;
> +	__u16			prp1_len;
> +	__le16			cdw14[5];
> +};
> +
> +struct nvme_nvm_bbtbl {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd[2];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le32			prp1_len;
> +	__le32			prp2_len;
> +	__le32			lbb;
> +	__u32			rsvd11[3];
> +};
> +
> +struct nvme_nvm_set_resp {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd[2];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le64			resp;
> +	__u32			rsvd11[4];
> +};
> +
> +struct nvme_nvm_erase_blk {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd[2];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le64			blk_addr;
> +	__u32			rsvd11[4];
> +};
> +
>   enum {
>   	NVME_RW_LR			= 1 << 15,
>   	NVME_RW_FUA			= 1 << 14,
> @@ -328,6 +434,13 @@ enum nvme_admin_opcode {
>   	nvme_admin_format_nvm		= 0x80,
>   	nvme_admin_security_send	= 0x81,
>   	nvme_admin_security_recv	= 0x82,
> +
> +	nvme_nvm_admin_identify		= 0xe2,
> +	nvme_nvm_admin_get_features	= 0xe6,
> +	nvme_nvm_admin_set_resp		= 0xe5,
> +	nvme_nvm_admin_get_l2p_tbl	= 0xea,
> +	nvme_nvm_admin_get_bb_tbl	= 0xf2,
> +	nvme_nvm_admin_set_bb_tbl	= 0xf1,
>   };
>
>   enum {
> @@ -457,6 +570,18 @@ struct nvme_format_cmd {
>   	__u32			rsvd11[5];
>   };
>
> +struct nvme_nvm_identify {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd[2];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le32			cns;
> +	__u32			rsvd11[5];
> +};
> +
>   struct nvme_command {
>   	union {
>   		struct nvme_common_command common;
> @@ -470,6 +595,13 @@ struct nvme_command {
>   		struct nvme_format_cmd format;
>   		struct nvme_dsm_cmd dsm;
>   		struct nvme_abort_cmd abort;
> +		struct nvme_nvm_identify nvm_identify;
> +		struct nvme_nvm_hb_rw nvm_hb_rw;
> +		struct nvme_nvm_l2ptbl nvm_l2p;
> +		struct nvme_nvm_bbtbl nvm_get_bb;
> +		struct nvme_nvm_bbtbl nvm_set_bb;
> +		struct nvme_nvm_set_resp nvm_resp;
> +		struct nvme_nvm_erase_blk nvm_erase;
>   	};
>   };
>

All these could be moved into the nvme-lightnvm.c file. Taking the 
previous discussion with Christoph regarding exposing user headers with 
the protocol. It maybe shouldn't be exposed.

Should I push it into nvme-lightnvm.h? (there is still a need for 
struct nvme_nvm_hb_rw. The other defs can be moved)

Anything else?
