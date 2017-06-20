From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Jun 2017 02:29:17 -0700
Subject: [PATCH nvme-cli] nvme-cli: add ns-descs subcommand
In-Reply-To: <20170620092028.5083-1-jthumshirn@suse.de>
References: <20170620092028.5083-1-jthumshirn@suse.de>
Message-ID: <20170620092917.GA17947@infradead.org>

> +int nvme_identify_ns_descs(int fd, __u32 nsid, void *data)
> +{
> +
> +	return nvme_identify(fd, nsid, 0x3, data);
> +}

This should use NVME_ID_CNS_NS_DESC_LIST.  nvme-cli doesn't currently
have that, but that's just a sign it needs a resync with the kernel
nvme.h.

Also personally I find the nvme_identify_* wrappers rather pointless,
and thin kthey should be removed instead of adding more.

> diff --git a/nvme-print.c b/nvme-print.c
> index 2da5acd5c9b8..582d15a7c5e8 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -3,6 +3,8 @@
>  #include <string.h>
>  #include <stdlib.h>
>  
> +#include <uuid/uuid.h>

libuuid usage in nvme-cli is conditional on LIBUUID.  Not that I
particularly agree on stubbing this depdency out..

> +enum {
> +	NVME_NIDT_EUI64		= 0x1,
> +	NVME_NIDT_NGUID		= 0x2,
> +	NVME_NIDT_UUID		= 0x3,
> +};

Should use values from the updated nvme.h:

> +	struct nvme_ns_id_desc {
> +		__u8 nidt;
> +		__u8 nidl;
> +		__u16 reserved;
> +	};

Same here.

> +	for (pos = 0; pos < 0x1000; pos += len) {

Same here for the magic constant.

> +		switch (cur->nidt) {
> +		case NVME_NIDT_EUI64:
> +			memset(eui64, 0, sizeof(eui64_str));
> +			memcpy(eui64_desc, data + off, sizeof(eui64_desc));

What's the point of this memcpy?  Alignment?
