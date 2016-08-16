From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 16 Aug 2016 13:45:03 -0700
Subject: [PATCH v3 RFC 2/2] nvme: improve performance for virtual NVMe
 devices
In-Reply-To: <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <cover.1471308889.git.helen.koike@collabora.co.uk>
 <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
Message-ID: <1471380303.21107.38.camel@linux.intel.com>

On Mon, 2016-08-15@22:41 -0300, Helen Koike wrote:


> ?
> +struct nvme_doorbell_memory {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__u32			rsvd1[5];
> +	__le64			prp1;
> +	__le64			prp2;
> +	__u32			rsvd12[6];
> +};
> +
> ?struct nvme_command {
> ?	union {
> ?		struct nvme_common_command common;
> @@ -845,6 +858,7 @@ struct nvme_command {
> ?		struct nvmf_connect_command connect;
> ?		struct nvmf_property_set_command prop_set;
> ?		struct nvmf_property_get_command prop_get;
> +		struct nvme_doorbell_memory doorbell_memory;
> ?	};
> ?};

This looks like a new NVMe command being introduced, not found in the
latest NVMe specs (NVMe 1.2.1 spec or NVMe-over-Fabrics 1.0 spec)?

This is a big NACK, the command needs to be part of the NVMe standard
before adding it to the NVMe code base (this is exactly how NVMe-over-
Fabrics standard got implemented). ?I would bring your proposal to
nvmexpress.org.

Jay


> ?
> @@ -934,6 +948,9 @@ enum {
> ?	/*
> ?	?* Media and Data Integrity Errors:
> ?	?*/
> +#ifdef CONFIG_NVME_VDB
> +	NVME_SC_DOORBELL_MEMORY_INVALID	= 0x1C0,
> +#endif
> ?	NVME_SC_WRITE_FAULT		= 0x280,
> ?	NVME_SC_READ_ERROR		= 0x281,
> ?	NVME_SC_GUARD_CHECK		= 0x282,
