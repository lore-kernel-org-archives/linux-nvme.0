Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC211C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2dR0LzHq4zjlB+OqKwVJ73IEwnEBWaQlVrVM4hN6+8=; b=jItNG6jgKOdGZzbhwb7lDtHCiw
	jXDcsf/AMkd3gze4Z+zk4LkUpYRo2sF4u5LXI8h5S4chUZ1N+DsFW7l1KyhPyDFOjHLoHruR/MrC2
	+zDpaxewKX0+MMhJ2MKf30BusNSV2bgZOfgxMFIkqcbRHO1vEZF0x6ajn5YT4ay+IZNaigmtBEWxC
	Sxj18zylQLH7wuIUssjqqe41HqniXJR2JAbqsLaqBaerd0Oo1t71ALEPPM+EQtM/t7mcNetPkezm2
	pLC6pgbcU4LgCrzCPkpZPo5z+hUUQxbZs3eoo103fKHA1haq5CMLU5DRkaipUlFcOzIfyl02aDI06
	yOYwxpng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMY2J-0000000810r-2t0L;
	Wed, 26 Jun 2024 19:10:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMY2H-0000000810D-2bHg
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719429028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2dR0LzHq4zjlB+OqKwVJ73IEwnEBWaQlVrVM4hN6+8=;
	b=CAJwafDQKbcceCNjFyiMQ1q522LhBSz98AQYYNGebvvTKfyO7OOw/R+24ynYRHngXaUhxB
	yk2yZmR5YyxCkgJWwuGEPlE2DIlutIPdC6odfXF3eAUFPMTl8PdNO8f42aQ0bDKLMGlVaI
	k1wB+jro4tMYqLzaMDS/+hdh3CHJsxo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-B_UHjjWmPR-Kvm6nbiGVVQ-1; Wed,
 26 Jun 2024 15:10:25 -0400
X-MC-Unique: B_UHjjWmPR-Kvm6nbiGVVQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA154195608C;
	Wed, 26 Jun 2024 19:10:23 +0000 (UTC)
Received: from [10.22.17.122] (unknown [10.22.17.122])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 172461956087;
	Wed, 26 Jun 2024 19:10:21 +0000 (UTC)
Message-ID: <eeca40fa-5510-4db1-a66b-bc1808b398ed@redhat.com>
Date: Wed, 26 Jun 2024 15:10:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] nvme: add reserved ioq tags for cancel
To: sagi@grimberg.me
Cc: emilne@redhat.com, hare@kernel.org, kbusch@meta.com,
 linux-nvme@lists.infradead.org, mlombard@redhat.com
References: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
 <20240626183819.23960-1-jmeneghi@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240626183819.23960-1-jmeneghi@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_121029_820489_180ED375 
X-CRM114-Status: GOOD (  21.96  )
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

This is the patch I wrote to solve this problem while at LSF/MM. Is this what you are thinking about Sagi?

Note: more changes are needed to the error handlers to account for this.  The idea is that the eh will need to be modified to 
keep track of outstanding nvme-cancel command for each io queue.  Following the first command timeout the eh will send one 
single command cancel command to abort the slow command in the controller.  If second command timeout occurs before the CQE for 
the first cancel is returned by the controller the error handler sends a  Multiple Command Cancel to the IO queue with NSID set 
to FFFFFFFFh.  This form of the cancel command will cancel/abort all outstanding commands on the IO queue.

The problem is, in most cases when a command times out due to a problem in the controller not just one command times out but all 
outstanding commands timeout in a thundering herd. There are cases where a single IO will hang up, but those aren't usually 
reads or writes - like a reservation command that gets suck, or a dsm command that's going slow. Usually when reads and writes 
start timing out it's because the storage is just swamped and all IOs start to slow down.

Therefore, with only 2 reserved tags on each IO queue, the host should be able to use the cancel command to abort any and all 
outstanding IOs that time out.

/John

On 6/26/24 14:38, John Meneghini wrote:Multiple Command Cancel:
> If the nvme Cancel command is supported, we need to reserve 2 tags for
> each IO queue. Note that one addition tag is reserved to account for
> the case where this is a fabrics controller.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 691dd6ee6dc3..76554fb373a3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4570,6 +4570,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   		unsigned int cmd_size)
>   {
>   	int ret;
> +	u32 effects = le32_to_cpu(ctrl->effects->iocs[nvme_cmd_cancel]);
>   
>   	memset(set, 0, sizeof(*set));
>   	set->ops = ops;
> @@ -4580,9 +4581,13 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   	 */
>   	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
>   		set->reserved_tags = NVME_AQ_DEPTH;
> +	else if  (effects & NVME_CMD_EFFECTS_CSUPP)
> +		/* Reserve 2 X io_queue count for NVMe Cancel */
> +		set->reserved_tags = (2 * ctrl->queue_count);
>   	else if (ctrl->ops->flags & NVME_F_FABRICS)
>   		/* Reserved for fabric connect */
>   		set->reserved_tags = 1;
> +
>   	set->numa_node = ctrl->numa_node;
>   	set->flags = BLK_MQ_F_SHOULD_MERGE;
>   	if (ctrl->ops->flags & NVME_F_BLOCKING)


