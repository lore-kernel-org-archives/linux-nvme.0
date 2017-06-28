From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 20:29:37 +0200
Subject: [PATCH] resync nvme.h with the kernel.h
In-Reply-To: <20170628182757.10173-1-hch@lst.de>
References: <20170628182757.10173-1-hch@lst.de>
Message-ID: <20170628182937.GA12703@lst.de>

Meh, the subject should just say:

resync nvme.h with the kernel

On Wed, Jun 28, 2017@11:27:57AM -0700, Christoph Hellwig wrote:
> Copy over the current nvme.h from the for-4.13 block tree, and adjust
> a few callers.  The biggest tweak is that we can't use the kernel uuid.h
> and either need to use libuuid or our own definition.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  fabrics.c    |   2 +
>  linux/nvme.h | 140 +++++++++++++++++++++++++++++++++++++++++++++++++----------
>  nvme-print.c |   8 +---
>  nvme.c       |   4 --
>  nvme.h       |  19 ++++----
>  5 files changed, 129 insertions(+), 44 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 87cdba2..da4e04e 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -44,6 +44,8 @@
>  
>  #include "common.h"
>  
> +#define NVMF_HOSTID_SIZE	36
> +
>  static struct config {
>  	char *nqn;
>  	char *transport;
> diff --git a/linux/nvme.h b/linux/nvme.h
> index d1a322b..291587a 100644
> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -16,6 +16,7 @@
>  #define _LINUX_NVME_H
>  
>  #include <linux/types.h>
> +#include <linux/uuid.h>
>  
>  /* NQN names in commands fields specified one size */
>  #define NVMF_NQN_FIELD_LEN	256
> @@ -23,7 +24,6 @@
>  /* However the max length of a qualified name is another size */
>  #define NVMF_NQN_SIZE		223
>  
> -#define NVMF_HOSTID_SIZE        36
>  #define NVMF_TRSVCID_SIZE	32
>  #define NVMF_TRADDR_SIZE	256
>  #define NVMF_TSAS_SIZE		256
> @@ -102,6 +102,7 @@ enum {
>  	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
>  	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
>  	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
> +	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
>  };
>  
>  #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
> @@ -249,7 +250,10 @@ enum {
>  	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
>  	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
>  	NVME_CTRL_ONCS_DSM			= 1 << 2,
> +	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
>  	NVME_CTRL_VWC_PRESENT			= 1 << 0,
> +	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
> +	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
>  };
>  
>  struct nvme_lbaf {
> @@ -289,6 +293,17 @@ struct nvme_id_ns {
>  };
>  
>  enum {
> +	NVME_ID_CNS_NS			= 0x00,
> +	NVME_ID_CNS_CTRL		= 0x01,
> +	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
> +	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
> +	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
> +	NVME_ID_CNS_NS_PRESENT		= 0x11,
> +	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
> +	NVME_ID_CNS_CTRL_LIST		= 0x13,
> +};
> +
> +enum {
>  	NVME_NS_FEAT_THIN	= 1 << 0,
>  	NVME_NS_FLBAS_LBA_MASK	= 0xf,
>  	NVME_NS_FLBAS_META_EXT	= 0x10,
> @@ -308,6 +323,22 @@ enum {
>  	NVME_NS_DPS_PI_TYPE3	= 3,
>  };
>  
> +struct nvme_ns_id_desc {
> +	__u8 nidt;
> +	__u8 nidl;
> +	__le16 reserved;
> +};
> +
> +#define NVME_NIDT_EUI64_LEN	8
> +#define NVME_NIDT_NGUID_LEN	16
> +#define NVME_NIDT_UUID_LEN	16
> +
> +enum {
> +	NVME_NIDT_EUI64		= 0x01,
> +	NVME_NIDT_NGUID		= 0x02,
> +	NVME_NIDT_UUID		= 0x03,
> +};
> +
>  struct nvme_smart_log {
>  	__u8			critical_warning;
>  	__u8			temperature[2];
> @@ -549,12 +580,42 @@ enum {
>  	NVME_DSMGMT_AD		= 1 << 2,
>  };
>  
> +#define NVME_DSM_MAX_RANGES	256
> +
>  struct nvme_dsm_range {
>  	__le32			cattr;
>  	__le32			nlb;
>  	__le64			slba;
>  };
>  
> +struct nvme_write_zeroes_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd2;
> +	__le64			metadata;
> +	union nvme_data_ptr	dptr;
> +	__le64			slba;
> +	__le16			length;
> +	__le16			control;
> +	__le32			dsmgmt;
> +	__le32			reftag;
> +	__le16			apptag;
> +	__le16			appmask;
> +};
> +
> +/* Features */
> +
> +struct nvme_feat_auto_pst {
> +	__le64 entries[32];
> +};
> +
> +enum {
> +	NVME_HOST_MEM_ENABLE	= (1 << 0),
> +	NVME_HOST_MEM_RETURN	= (1 << 1),
> +};
> +
>  /* Admin commands */
>  
>  enum nvme_admin_opcode {
> @@ -573,6 +634,7 @@ enum nvme_admin_opcode {
>  	nvme_admin_download_fw		= 0x11,
>  	nvme_admin_ns_attach		= 0x15,
>  	nvme_admin_keep_alive		= 0x18,
> +	nvme_admin_dbbuf		= 0x7C,
>  	nvme_admin_format_nvm		= 0x80,
>  	nvme_admin_security_send	= 0x81,
>  	nvme_admin_security_recv	= 0x82,
> @@ -620,10 +682,14 @@ struct nvme_identify {
>  	__le32			nsid;
>  	__u64			rsvd2[2];
>  	union nvme_data_ptr	dptr;
> -	__le32			cns;
> +	__u8			cns;
> +	__u8			rsvd3;
> +	__le16			ctrlid;
>  	__u32			rsvd11[5];
>  };
>  
> +#define NVME_IDENTIFY_DATA_SIZE 4096
> +
>  struct nvme_features {
>  	__u8			opcode;
>  	__u8			flags;
> @@ -633,7 +699,16 @@ struct nvme_features {
>  	union nvme_data_ptr	dptr;
>  	__le32			fid;
>  	__le32			dword11;
> -	__u32			rsvd12[4];
> +	__le32                  dword12;
> +	__le32                  dword13;
> +	__le32                  dword14;
> +	__le32                  dword15;
> +};
> +
> +struct nvme_host_mem_buf_desc {
> +	__le64			addr;
> +	__le32			size;
> +	__u32			rsvd;
>  };
>  
>  struct nvme_create_cq {
> @@ -809,7 +884,7 @@ struct nvmf_connect_command {
>  };
>  
>  struct nvmf_connect_data {
> -	__u8		hostid[16];
> +	uuid_t		hostid;
>  	__le16		cntlid;
>  	char		resv4[238];
>  	char		subsysnqn[NVMF_NQN_FIELD_LEN];
> @@ -842,6 +917,16 @@ struct nvmf_property_get_command {
>  	__u8		resv4[16];
>  };
>  
> +struct nvme_dbbuf {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__u32			rsvd1[5];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__u32			rsvd12[6];
> +};
> +
>  struct nvme_command {
>  	union {
>  		struct nvme_common_command common;
> @@ -854,29 +939,17 @@ struct nvme_command {
>  		struct nvme_download_firmware dlfw;
>  		struct nvme_format_cmd format;
>  		struct nvme_dsm_cmd dsm;
> +		struct nvme_write_zeroes_cmd write_zeroes;
>  		struct nvme_abort_cmd abort;
>  		struct nvme_get_log_page_command get_log_page;
>  		struct nvmf_common_command fabrics;
>  		struct nvmf_connect_command connect;
>  		struct nvmf_property_set_command prop_set;
>  		struct nvmf_property_get_command prop_get;
> +		struct nvme_dbbuf dbbuf;
>  	};
>  };
>  
> -#define NVME_IDENTIFY_CMD_LEN 4096
> -#define NVME_ID_CNS_NS_DESC_LIST 0x3
> -enum {
> -	NVME_NIDT_EUI64		= 0x1,
> -	NVME_NIDT_NGUID		= 0x2,
> -	NVME_NIDT_UUID		= 0x3,
> -};
> -
> -struct nvme_ns_id_desc {
> -	__u8 nidt;
> -	__u8 nidl;
> -	__u16 reserved;
> -};
> -
>  static inline bool nvme_is_write(struct nvme_command *cmd)
>  {
>  	/*
> @@ -958,6 +1031,7 @@ enum {
>  	NVME_SC_BAD_ATTRIBUTES		= 0x180,
>  	NVME_SC_INVALID_PI		= 0x181,
>  	NVME_SC_READ_ONLY		= 0x182,
> +	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
>  
>  	/*
>  	 * I/O Command Set Specific - Fabrics commands:
> @@ -984,23 +1058,41 @@ enum {
>  	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
>  
>  	NVME_SC_DNR			= 0x4000,
> +
> +
> +	/*
> +	 * FC Transport-specific error status values for NVME commands
> +	 *
> +	 * Transport-specific status code values must be in the range 0xB0..0xBF
> +	 */
> +
> +	/* Generic FC failure - catchall */
> +	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
> +
> +	/* I/O failure due to FC ABTS'd */
> +	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
>  };
>  
>  struct nvme_completion {
>  	/*
>  	 * Used by Admin and Fabrics commands to return data:
>  	 */
> -	union {
> -		__le16	result16;
> -		__le32	result;
> -		__le64	result64;
> -	};
> +	union nvme_result {
> +		__le16	u16;
> +		__le32	u32;
> +		__le64	u64;
> +	} result;
>  	__le16	sq_head;	/* how much of this queue may be reclaimed */
>  	__le16	sq_id;		/* submission queue that generated this entry */
>  	__u16	command_id;	/* of the command which completed */
>  	__le16	status;		/* did the command fail, and if so, why? */
>  };
>  
> -#define NVME_VS(major, minor) (((major) << 16) | ((minor) << 8))
> +#define NVME_VS(major, minor, tertiary) \
> +	(((major) << 16) | ((minor) << 8) | (tertiary))
> +
> +#define NVME_MAJOR(ver)		((ver) >> 16)
> +#define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
> +#define NVME_TERTIARY(ver)	((ver) & 0xff)
>  
>  #endif /* _LINUX_NVME_H */
> diff --git a/nvme-print.c b/nvme-print.c
> index dca4a19..637c695 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -3,10 +3,6 @@
>  #include <string.h>
>  #include <stdlib.h>
>  
> -#ifdef LIBUUID
> -#include <uuid/uuid.h>
> -#endif
> -
>  #include "nvme-print.h"
>  #include "json.h"
>  #include "nvme-models.h"
> @@ -622,7 +618,7 @@ void json_nvme_id_ns_descs(void *data)
>  
>  	root = json_create_object();
>  
> -	for (pos = 0; pos < NVME_IDENTIFY_CMD_LEN; pos += len) {
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
>  		struct nvme_ns_id_desc *cur = data + pos;
>  
>  		off = pos + sizeof(*cur);
> @@ -680,7 +676,7 @@ void show_nvme_id_ns_descs(void *data)
>  	__u8 eui64[8];
>  	__u8 nguid[16];
>  
> -	for (pos = 0; pos < NVME_IDENTIFY_CMD_LEN; pos += len) {
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
>  		struct nvme_ns_id_desc *cur = data + pos;
>  
>  		if (cur->nidl == 0)
> diff --git a/nvme.c b/nvme.c
> index f746b74..4cb7d63 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -45,10 +45,6 @@
>  #include <sys/stat.h>
>  #include <sys/time.h>
>  
> -#ifdef LIBUUID
> -#include <uuid/uuid.h>
> -#endif
> -
>  #include "nvme-print.h"
>  #include "nvme-ioctl.h"
>  #include "nvme-lightnvm.h"
> diff --git a/nvme.h b/nvme.h
> index 397a1a5..b796961 100644
> --- a/nvme.h
> +++ b/nvme.h
> @@ -21,6 +21,15 @@
>  #include "json.h"
>  
>  #define unlikely(x) x
> +
> +#ifdef LIBUUID
> +#include <uuid/uuid.h>
> +#else
> +typedef struct {
> +	__u8 b[16];
> +} uuid_t;
> +#endif
> +
>  #include "linux/nvme.h"
>  
>  struct nvme_error_log_page {
> @@ -45,16 +54,6 @@ struct nvme_firmware_log_page {
>  /* idle and active power scales occupy the last 2 bits of the field */
>  #define POWER_SCALE(s) ((s) >> 6)
>  
> -enum {
> -	NVME_ID_CNS_NS			= 0x00,
> -	NVME_ID_CNS_CTRL		= 0x01,
> -	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
> -	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
> -	NVME_ID_CNS_NS_PRESENT		= 0x11,
> -	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
> -	NVME_ID_CNS_CTRL_LIST		= 0x13,
> -};
> -
>  struct nvme_host_mem_buffer {
>  	__u32			hsize;
>  	__u32			hmdlal;
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
