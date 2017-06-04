From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:06:02 +0300
Subject: [PATCH v4 5/8] nvme: get list of namespace descriptors
In-Reply-To: <20170604103649.22130-6-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-6-jthumshirn@suse.de>
Message-ID: <4f10963d-2d05-dfa1-1c4f-99b0202f38db@grimberg.me>



On 04/06/17 13:36, Johannes Thumshirn wrote:
> If a target identifies itself as NVMe 1.3 compliant, try to get the
> list of Namespace Identification Descriptors and populate the UUID,
> NGUID and EUI64 fileds in the NVMe namespace structure with these
> values.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7b254be16887..37047841da0e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -643,6 +643,85 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>   	return error;
>   }
>   
> +static void nvme_parse_ns_descs(struct nvme_ns *ns, void *data)
> +{
> +	int pos;
> +	int len;
> +
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> +		struct nvme_ns_identifier_hdr *cur = data + pos;
> +
> +		if (cur->nidl == 0)
> +			break;
> +
> +		switch (cur->nidt) {
> +		case NVME_NIDT_EUI64:
> +			if (cur->nidl != NVME_NIDT_EUI64_LEN) {
> +				dev_warn(ns->ctrl->dev,
> +					 "Target returned bogus length: %d for NVME_NIDT_EUI64\n",
> +					 cur->nidl);

Hmm, "target" is not a spec'd entity in NVMe AFAIR, and we try to avoid
using this language in the host too, lets call it "ctrl".
