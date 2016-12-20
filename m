From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:46:12 -0800
Subject: [PATCH v3 1/5] include: Add definitions for sed
In-Reply-To: <1482176149-2257-2-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-2-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220064612.GA13844@infradead.org>

On Mon, Dec 19, 2016@12:35:45PM -0700, Scott Bauer wrote:
> This patch adds the definitions and structures for the SED
> Opal code.

This seems to contain a few things:  userspace ABIs, on the wire
defintions, and prototypes for the code added in patch 2.

The userspace ABIs should be a header on it's own.  For new code
we also usually try to split the protocol definitions from the
in-kernel APIs, although that's not even reflected in the headers
here.  If you think it's reasonable to split those out those should
be a separate new patch, and the actual in-kernel data structures
and protoypes should just go with the actual code in your current patch
2.

> +/**
> + * struct sed_context - SED Security context for a device
> + * @ops:The Trusted Send/Recv functions.
> + * @sec_data:Opaque pointer that will be passed to the send/recv fn.
> + *Drivers can use this to pass necessary data required for
> + *Their implementation of send/recv.
> + * @dev:Currently an Opal Dev structure. In the future can be other types
> + *Of security structures.
> + */

This is missing a couple spaces for the common kerneldoc format.

> +struct sed_context {
> +	const struct sec_ops *ops;
> +	void *sec_data;
> +	void *dev;
> +};

What is the difference between sec_data and dev?  And do your really
need either one when using the container_of trick I pointed out in
response to the other patch.

> +struct sed_key {
> +	__u32 sed_type;
> +	union {
> +		struct opal_key            opal;
> +		struct opal_new_pw         opal_pw;
> +		struct opal_session_info   opal_session;
> +		struct opal_user_lr_setup  opal_lrs;
> +		struct opal_lock_unlock    opal_lk_unlk;
> +		struct opal_mbr_data       opal_mbr;
> +		/* additional command set key types */
> +	};
> +};
> +
> +#define IOC_SED_SAVE		   _IOW('p', 220, struct sed_key)
> +#define IOC_SED_LOCK_UNLOCK	   _IOW('p', 221, struct sed_key)
> +#define IOC_SED_TAKE_OWNERSHIP	   _IOW('p', 222, struct sed_key)
> +#define IOC_SED_ACTIVATE_LSP       _IOW('p', 223, struct sed_key)
> +#define IOC_SED_SET_PW             _IOW('p', 224, struct sed_key)
> +#define IOC_SED_ACTIVATE_USR       _IOW('p', 225, struct sed_key)
> +#define IOC_SED_REVERT_TPR         _IOW('p', 226, struct sed_key)
> +#define IOC_SED_LR_SETUP           _IOW('p', 227, struct sed_key)
> +#define IOC_SED_ADD_USR_TO_LR      _IOW('p', 228, struct sed_key)
> +#define IOC_SED_ENABLE_DISABLE_MBR _IOW('p', 229, struct sed_key)
> +#define IOC_SED_ERASE_LR           _IOW('p', 230, struct sed_key)
> +#define IOC_SED_SECURE_ERASE_LR    _IOW('p', 231, struct sed_key)

I'll need to look at the details again, but it seems like each ioctl
uses exactly one of the structures in the union above, so there is no
real need for that union.
