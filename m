From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 24 Dec 2015 16:53:16 +0200
Subject: [PATCH RFC 3/4] nvme: Move IO termination code to the core
In-Reply-To: <20151224142528.GD2646@infradead.org>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
 <1450956241-4626-4-git-send-email-sagig@mellanox.com>
 <20151224142528.GD2646@infradead.org>
Message-ID: <567C06DC.10904@dev.mellanox.co.il>


>> +void nvme_fail_admin_cmds(struct nvme_ctrl *ctrl,
>> +		busy_tag_iter_fn *terminate_io, void *priv)
>> +{
>> +	blk_mq_tagset_busy_iter(ctrl->admin_tagset, terminate_io, priv);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_fail_admin_cmds);
>> +
>> +void nvme_fail_io_cmds(struct nvme_ctrl *ctrl,
>> +		busy_tag_iter_fn *terminate_io, void *priv)
>> +{
>> +	blk_mq_tagset_busy_iter(ctrl->tagset, terminate_io, priv);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_fail_io_cmds);
>
> But I see absolutely no point for these helpers.  These are trivial
> one-liners that can stay in the transport drivers.  And with that we
> also don't need the admin_tagset pointer in the generic controller
> (at least yet..)

I just figured that it'd be nice to have a meaningfully named helpers,
it's not uncommon in the kernel...

I have no problem losing them anyways so unless someone votes to keep
them I'll remove them in v1.
