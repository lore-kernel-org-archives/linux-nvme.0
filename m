From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 3 Sep 2013 13:05:08 -0400
Subject: [PATCH] Add data transfer length check for admin commands
In-Reply-To: <1378141276-4356-1-git-send-email-prasadjoshi.linux@gmail.com>
References: <1378141276-4356-1-git-send-email-prasadjoshi.linux@gmail.com>
Message-ID: <20130903170508.GZ4707@linux.intel.com>

On Mon, Sep 02, 2013@10:31:16PM +0530, Prasad Joshi wrote:
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h

I think you generated this patch against Linus' tree rather than the NVMe
tree (http://git.infradead.org/users/willy/linux-nvme.git).  The __KERNEL__
ifdefs are gone due to the separation of this file into the uapi and non-uapi
versions.

> +/*
> + * The 2 LSB bits of NVME Admin command opcode are called as data transfer bits.
> + * These two bits define where a command should include data transfer
> + * information.
> + */
> +#define NVME_ADMIN_CMD_DATA_XFER_MASK (0b11)
> +

Binary constants are a GCC extension, which I would prefer to avoid.
They're only available from gcc 4.3 onwards, and apparently we still
support gcc versions as old as 3.2.

The bits aren't just for admin commands (so we should correct both the
comment and the name of the constant).  How about adding:

	NVME_DATA_XFER_NONE	= 0,
	NVME_DATA_XFER_READ	= 1,
	NVME_DATA_XFER_WRITE	= 2,
	NVME_DATA_XFER_BIDI	= 3,
	NVME_DATA_XFER_MASK	= 3,

to the 'enum nvme_opcode' definition?
