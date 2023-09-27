Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4EAE80AA1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0Fs0ahFjo0BrEWWf3jv8DZ7sYwRtpLPt9gIwrdj4uw=; b=UgjQmGU8TSTAbQrKjidiamOqCm
	wkmM4gGxPaOYpDnsae2WuvjBB3gxS+uykHfDv9iHIKl7Hllphnl/UvCVP/OGTxq3KfqSyv2+tM7MU
	dxLDi4hU5xLgQnwjcYzvKBcWGIJ5n9T1GjA6ofXMh5aNLUKLNiF2GMIucwwpv0dxOzOZk1E8FopzW
	2RZSxIe7EuXdg8bLmNWUS+NViUdwo2iJfjBCtkqwoIWY0ne+8Cg1Hz3AHNv1+zGDgzJ73ryD8hQ5S
	RGqc02k3QPdMmQSW6Vsyi64mSABCV7P2rnYuZOUGM9QCWCfGyXQ3cha6b+ytawZgGUMnX+DUbIKzB
	Mhl0eJgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlP8G-000CmQ-2k;
	Wed, 27 Sep 2023 07:38:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlP8E-000Cly-0G
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 07:38:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66AA1F8AB;
	Wed, 27 Sep 2023 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695800328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Fs0ahFjo0BrEWWf3jv8DZ7sYwRtpLPt9gIwrdj4uw=;
	b=mVYpeT47sAwBz3hsj4/gOxyCB8SzNvF7lC/6sFJhn3258nI8NmnHvGQCUPuiAjiyuDHPXx
	7S+Tl0RL1EpgNLOZMCrWHUDEwpdwi3PlvxrB2H3O3bWKpb0gnikTTkkW/OBGlbwI4PCCGs
	XJRIIkiToC0Bs9REgQ6YYecAy1SebCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695800328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Fs0ahFjo0BrEWWf3jv8DZ7sYwRtpLPt9gIwrdj4uw=;
	b=rB/lYJ6H9211EdoCzilGeKeUATzpAPD9XqwMPXDTyFDbI5Me93omd4lFHn7cVnT1FsPPU1
	R7FOC3TMyWIhmjCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5854B1338F;
	Wed, 27 Sep 2023 07:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IX8sDQfcE2XbTAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 27 Sep 2023 07:38:47 +0000
Message-ID: <2f021d5f-22e3-4dea-b8c7-418d5a5f0d90@suse.de>
Date: Wed, 27 Sep 2023 09:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: Implement new iopolicy "queue-depth"
Content-Language: en-US
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-3-emilne@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230925163123.16042-3-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_003850_263750_880072F5 
X-CRM114-Status: GOOD (  22.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/25/23 18:31, Ewan D. Milne wrote:
> The existing iopolicies are inefficient in some cases, such as
> the presence of a path with high latency. The round-robin
> policy would use that path equally with faster paths, which
> results in sub-optimal performance.
> 
> The queue-depth policy instead sends I/O requests down the path
> with the least amount of requests in its request queue. Paths
> with lower latency will clear requests more quickly and have less
> requests in their queues compared to "bad" paths. The aim is to
> use those paths the most to bring down overall latency.
> 
> [edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>        and compilation warnings, updated MODULE_PARM description
>        and changed to use new blk_mq_queue_nr_active() instead of adding
>        additional atomic counters.]
> 
> Co-developed-by: Thomas Song <tsong@purestorage.com>
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>   drivers/nvme/host/multipath.c | 48 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  1 +
>   2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0a88d7bdc5e3..deea7fd4aa95 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>   static const char *nvme_iopolicy_names[] = {
>   	[NVME_IOPOLICY_NUMA]	= "numa",
>   	[NVME_IOPOLICY_RR]	= "round-robin",
> +	[NVME_IOPOLICY_QD]      = "queue-depth",
>   };
>   
>   static int iopolicy = NVME_IOPOLICY_NUMA;
> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>   		iopolicy = NVME_IOPOLICY_NUMA;
>   	else if (!strncmp(val, "round-robin", 11))
>   		iopolicy = NVME_IOPOLICY_RR;
> +	else if (!strncmp(val, "queue-depth", 11))
> +		iopolicy = NVME_IOPOLICY_QD;
>   	else
>   		return -EINVAL;
>   
> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>   	&iopolicy, 0644);
>   MODULE_PARM_DESC(iopolicy,
> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>   
>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>   {
> @@ -329,6 +332,41 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>   	return found;
>   }
>   
> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head,
> +		int node)
> +{
> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (nvme_path_is_disabled(ns))
> +			continue;
> +
> +		depth = blk_mq_queue_nr_active(ns->queue);

That would require an 'atomic_read' on each path for each I/O.
Which absolutely sucks for performance.

Considering that we really are only interested in a rough idea about 
path usage, wouldn't it be better to use READ_ONCE()/WRITE_ONCE()
for accumulating the nr of requests per queue?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


