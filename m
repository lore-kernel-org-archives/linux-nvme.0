From: sunad.s@samsung.com (Sunad Bhandary)
Date: Tue, 03 Mar 2015 09:34:24 +0530
Subject: [PATCH] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <alpine.LNX.2.00.1502242105400.32385@localhost.lm.intel.com>
References: <1424701860-3492-1-git-send-email-sunad.s@samsung.com>
 <alpine.LNX.2.00.1502242105400.32385@localhost.lm.intel.com>
Message-ID: <008a01d05567$23cbb6d0$6b632470$@samsung.com>

Hi Keith,

Sorry for the late reply as I was on leave.

I will make the necessary changes and send out the new patch .

Thanks and regards,
Sunad

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Wednesday, February 25, 2015 2:54 AM
To: Sunad Bhandary S
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: write_long SCSI to NVMe translation
implementation

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
translation requires it always be set to 0, so it doesn't have much affect
in this translation, but just saying.

Otherwise this looks pretty reasonable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
