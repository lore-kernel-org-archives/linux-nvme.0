From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 17 May 2018 09:24:57 -0500
Subject: [PATCH RFC v2 2/2] nvmet-rdma: support 16K inline data
In-Reply-To: <20180517115203.GB30345@lst.de>
References: <cover.1526505524.git.swise@opengridcomputing.com>
 <e3c4d8a638b989aef554646d235aa45d633d9565.1526505524.git.swise@opengridcomputing.com>
 <20180517115203.GB30345@lst.de>
Message-ID: <76914471-8d8a-cdec-e952-24b1e9a5ed72@opengridcomputing.com>



On 5/17/2018 6:52 AM, Christoph Hellwig wrote:
>> +static ssize_t nvmet_inline_data_size_show(struct config_item *item,
>> +		char *page)
>> +{
>> +	struct nvmet_port *port = to_nvmet_port(item);
>> +
>> +	return snprintf(page, PAGE_SIZE, "%u\n",
>> +			port->inline_data_size);
> Please fir the whole sprintf statement onto a single line.

sure

>> +}
>> +
>> +static ssize_t nvmet_inline_data_size_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct nvmet_port *port = to_nvmet_port(item);
>> +	unsigned int size;
>> +	int ret;
>> +
>> +	if (port->enabled) {
>> +		pr_err("Cannot modify inline_data_size enabled\n");
>> +		pr_err("Disable the port before modifying\n");
>> +		return -EACCES;
>> +	}
>> +	ret = kstrtouint((const char *)page, 0, &size);
> This cast looks bogus.
>
> Also inline_data_size shoul be and u32 as that is closest to what
> is on the wire, and you thus should use kstrtou32 and pass the
> inline_data_size straight to kstrtou32 instead of bouncing it through
> a local variable.

I made it an int so it could be initialized to -1 indicating it is not
set by the config.? This allows the rdma transport to use its default
value if the config does not specify any value.? I did this so the admin
could totally disable inline by specifying 0.?? So I needed a value that
indicates "unspecified".


>> +CONFIGFS_ATTR(nvmet_, inline_data_size);
> The characters before the first _ in the name are used as a group
> by nvmetcli.  So I think this should get a param_ or so prefix
> before the inline_data_size.  Also currently this attribute only
> makes sense for rdma, so I think we still need a flag in
> nvmet_fabrics_ops that enables/disables this attribute.

Ah, so setting it in a port that isn't the rdma transport will cause a
failure.? That makes sense.

> Last but not least please also send a nvmetcli patch to support
> this new attribute.

Will do.

>> +#define NVMET_DEFAULT_INLINE_DATA_SIZE	-1
> 0 makes much more sense as the default, and then we don't even need
> a name for it.

I wanted the user to be able to disable inline by setting it to 0.? Is
that not needed?? Maybe by adding back the nvmet_fabrics_ops field will
alleviate this issue.? Perhaps a default_inline_size field that rdma
sets to PAGE_SIZE.? Then configfs can default it to that.?

>> +#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
>> +#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
> So for 64k pages the minimum is bigger than the maximum? :)

For 64k pages, the default is 64K and the max is 64K.

Steve.
