From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 7 Sep 2017 15:01:15 +0000
Subject: [PATCH 2/3] nvme: introduce nvme_reinit_tagset
In-Reply-To: <1504711832-28425-3-git-send-email-sagi@grimberg.me>
References: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
 <1504711832-28425-3-git-send-email-sagi@grimberg.me>
Message-ID: <1504796474.2646.4.camel@wdc.com>

On Wed, 2017-09-06@18:30 +0300, Sagi Grimberg wrote:
> +int nvme_reinit_tagset(struct nvme_ctrl *ctrl, bool admin)
> +{
> +	struct blk_mq_tag_set *set = admin ?
> +			ctrl->admin_tagset : ctrl->tagset;
> +
> +	if (!ctrl->ops->reinit_request)
> +		return 0;
> +
> +	return blk_mq_tagset_iter(set, set->driver_data,
> +			ctrl->ops->reinit_request);
> +}
> +EXPORT_SYMBOL_GPL(nvme_reinit_tagset);

Hello Sagi,

Have you considered to pass a tag set pointer as second argument to this
new function instead of a boolean? I think that would not only make this
function shorter but also that it would make the callers easier to read.

Thanks,

Bart.
