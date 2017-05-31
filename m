From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 31 May 2017 22:13:41 +0300
Subject: [PATCH v1 4/7] nvme: get list of namespace descriptors
In-Reply-To: <f51d09c4e22189e8979a92a46faa98778034afe6.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <f51d09c4e22189e8979a92a46faa98778034afe6.1496237370.git.jthumshirn@suse.de>
Message-ID: <60cf348d-45cb-5bd1-9f75-7b9e22f30826@mellanox.com>



On 5/31/2017 4:32 PM, Johannes Thumshirn wrote:
> If a target identifies itself as NVMe 1.3 compliant, try to get the
> list of Namespace Identification Descriptors and populate the UUID,
> NGUID and EUI64 fileds in the NVMe namespace structure with these
> values.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 89 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7b254be16887..9acbf56c8796 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -643,6 +643,71 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>  	return error;
>  }
>
> +static void nvme_parse_ns_descs(struct nvme_ns *ns, void *ns_nid)
> +{
> +	struct nvme_ns_nid *cur;
> +	const u8 *p;
> +	int pos = 0;
> +	int len;
> +
> +	p = (u8 *)ns_nid;
> +
> +	for (;;) {
> +		cur = (struct nvme_ns_nid *)p;
> +
> +		switch (cur->nidl) {
> +		case 0:
> +			return;
> +		case 8:
> +		case 16:

consider using the length defines from <linux/nvme.h> instead of 8/16,
it's more intuitive code this way.
Actually, to be safer, you can check the length inside the second 
switch/case per case.

> +			break;
> +		default:
> +			dev_warn(ns->ctrl->dev,
> +				 "Target returned bogus Namespace Identification Descriptor length: %d\n",
> +				 cur->nidl);
> +			return;
> +
> +		}
> +
> +		switch (cur->nidt) {
> +		case NVME_NIDT_EUI64:
> +			len = NVME_NIDT_EUI64_LEN;
> +			memcpy(ns->eui, cur->nid, len);
> +			break;
> +		case NVME_NIDT_NGUID:
> +			len = NVME_NIDT_NGUID_LEN;
> +			memcpy(ns->nguid, cur->nid, len);
> +			break;
> +		case NVME_NIDT_UUID:
> +			len = NVME_NIDT_UUID_LEN;
> +			memcpy(ns->uuid, cur->nid, len);
> +			break;
> +		default:
> +			dev_warn(ns->ctrl->dev,
> +				 "Invalid Namespace Identification Descriptor Type: %d\n",
> +				 cur->nidt);
> +			return;
> +		}
> +
> +		pos += sizeof(struct nvme_ns_nid) + len;
> +		if (pos >= SZ_4K)
> +			return;
> +		p += pos;
> +	}
> +}
> +
