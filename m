From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:38:27 +0200
Subject: [PATCH v4 5/8] nvme: get list of namespace descriptors
In-Reply-To: <20170604103649.22130-6-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-6-jthumshirn@suse.de>
Message-ID: <20170605053825.GE19480@lst.de>

> +			}
> +			len = NVME_NIDT_UUID_LEN;
> +			memcpy(ns->uuid, data + pos + sizeof(*cur), len);
> +			break;
> +		default:
> +			dev_warn(ns->ctrl->dev,
> +				 "Invalid Namespace Identification Descriptor Type: %d\n",
> +				 cur->nidt);
> +			return;

Please drop the warning and return, the spec says hosts should ignore
unknown types.  This is important to future proof for new types that
could be added.

> +static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
> +{
> +	struct nvme_command c = { };
> +	int status;
> +	void *data;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.nsid = cpu_to_le32(nsid);
> +	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
> +
> +	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, data,
> +				      NVME_IDENTIFY_DATA_SIZE);
> +	if (status)
> +		goto free_data;
> +
> +	nvme_parse_ns_descs(ns, data);

Just merge nvme_parse_ns_descs into the caller?
