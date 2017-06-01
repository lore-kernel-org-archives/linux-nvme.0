From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:49:12 +0200
Subject: [PATCH v1 4/7] nvme: get list of namespace descriptors
In-Reply-To: <f51d09c4e22189e8979a92a46faa98778034afe6.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <f51d09c4e22189e8979a92a46faa98778034afe6.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601064912.GD16778@lst.de>

> +static void nvme_parse_ns_descs(struct nvme_ns *ns, void *ns_nid)
> +{
> +	struct nvme_ns_nid *cur;
> +	const u8 *p;
> +	int pos = 0;
> +	int len;
> +
> +	p = (u8 *)ns_nid;

No need for the cast.  But we can do void pointer arithmetics in the
kernel anyway, so possible we could just declare this void.

And maybe just call the argument data and operate on that.

> +
> +	for (;;) {
> +		cur = (struct nvme_ns_nid *)p;

	for (pos = 0; pos < NVME_ID_DATA_SIZE; pos += len) {
		struct nvme_ns_nid *cur = data + pos;

> +
> +		switch (cur->nidl) {
> +		case 0:
> +			return;
> +		case 8:
> +		case 16:
> +			break;
> +		default:
> +			dev_warn(ns->ctrl->dev,
> +				 "Target returned bogus Namespace Identification Descriptor length: %d\n",
> +				 cur->nidl);
> +			return;
> +
> +		}

This needs to be verified based on the type.

> +	if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
> +		void *ns_nid;
> +		int ret;
> +
> +
> +		ns_nid = kzalloc(SZ_4K, GFP_KERNEL);
> +		if (!ns_nid) {
> +			dev_warn(ns->ctrl->dev,
> +				 "%s: Identify Descriptors failed\n", __func__);
> +			return 0;
> +		}
> +
> +		ret = nvme_identify_ns_descs(ns->ctrl, ns->ns_id, ns_nid);
> +		if (ret) {
> +			dev_warn(ns->ctrl->dev,
> +				 "%s: Identify Descriptors failed\n", __func__);
> +			 /* Don't treat error as fatal we potentially
> +			  * already have a NGUID or EUI-64 */
> +			return 0;
> +		}
> +		nvme_parse_ns_descs(ns, ns_nid);
> +		kfree(ns_nid);

Please move all this code into nvme_identify_ns_descs().
