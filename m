From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Feb 2015 21:23:38 +0000 (UTC)
Subject: [PATCH] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <1424701860-3492-1-git-send-email-sunad.s@samsung.com>
References: <1424701860-3492-1-git-send-email-sunad.s@samsung.com>
Message-ID: <alpine.LNX.2.00.1502242105400.32385@localhost.lm.intel.com>

On Mon, 23 Feb 2015, Sunad Bhandary S wrote:
> From: Sunad Bhandary S <sunad.s at samsung.com>
> +struct nvme_write_uncor_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u32			rsvd2[8];
> +	__le64			slba;
> +	__le32			nlb;
> +	__u32			rsvd13[3];
> +};

NLB should be a __le16 followed by a reserved __u16. It turns out the
translation requires it always be set to 0, so it doesn't have much
affect in this translation, but just saying.

Otherwise this looks pretty reasonable.
