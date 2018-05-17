From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 13:52:04 +0200
Subject: [PATCH RFC v2 2/2] nvmet-rdma: support 16K inline data
In-Reply-To: <e3c4d8a638b989aef554646d235aa45d633d9565.1526505524.git.swise@opengridcomputing.com>
References: <cover.1526505524.git.swise@opengridcomputing.com>
 <e3c4d8a638b989aef554646d235aa45d633d9565.1526505524.git.swise@opengridcomputing.com>
Message-ID: <20180517115203.GB30345@lst.de>

> +static ssize_t nvmet_inline_data_size_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%u\n",
> +			port->inline_data_size);

Please fir the whole sprintf statement onto a single line.

> +}
> +
> +static ssize_t nvmet_inline_data_size_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	unsigned int size;
> +	int ret;
> +
> +	if (port->enabled) {
> +		pr_err("Cannot modify inline_data_size enabled\n");
> +		pr_err("Disable the port before modifying\n");
> +		return -EACCES;
> +	}
> +	ret = kstrtouint((const char *)page, 0, &size);

This cast looks bogus.

Also inline_data_size shoul be and u32 as that is closest to what
is on the wire, and you thus should use kstrtou32 and pass the
inline_data_size straight to kstrtou32 instead of bouncing it through
a local variable.

> +CONFIGFS_ATTR(nvmet_, inline_data_size);

The characters before the first _ in the name are used as a group
by nvmetcli.  So I think this should get a param_ or so prefix
before the inline_data_size.  Also currently this attribute only
makes sense for rdma, so I think we still need a flag in
nvmet_fabrics_ops that enables/disables this attribute.

Last but not least please also send a nvmetcli patch to support
this new attribute.

> +#define NVMET_DEFAULT_INLINE_DATA_SIZE	-1

0 makes much more sense as the default, and then we don't even need
a name for it.

> +#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
> +#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)

So for 64k pages the minimum is bigger than the maximum? :)

> +	int			inline_data_size;

u32
