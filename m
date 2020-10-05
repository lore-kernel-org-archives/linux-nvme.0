Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD99C4727D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:29:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9D72064C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ODeHWr6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9D72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gZF5x0j8+RtRb+PZzKcIVwUI/kfUqZbBmAAeX531BmM=; b=ODeHWr6HnWMYL261x0IFu4ZhT
	TKrxPmBIWn6Fia8idp5/SX2R8FyrQhNJbRnNGQu64XiRIk8XKrNCx3uAdXbj/+CMZx+rXoQu4CFAl
	nHR8DteqI+ygduBWAKsHRINDtcDLs29Ke7OAbacPecrFpZy+yumhvMGCGEda/3NuVEYwMth5inJIj
	k/AnlAjgnzyb3XfOS6fUV/hpJcxB0xbqbLzd5iGOg///3qwPcW7oEGLo/T/wIt+eWolyhTBQQqS5k
	/RlVtJ3oAnPrKEhNmQACXFs+e9hHRRvndh6nxvCf85xuV8iH1PI3F5khg/PxIfQPb/x2//8fSLsv0
	6yBZ217Gw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPOgE-0008BD-S8; Mon, 05 Oct 2020 11:29:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPOgA-0008AI-QK
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 11:29:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3B81567373; Mon,  5 Oct 2020 13:29:17 +0200 (CEST)
Date: Mon, 5 Oct 2020 13:29:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201005112916.GB26872@lst.de>
References: <20201005094256.49358-1-hare@suse.de>
 <20201005094256.49358-3-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005094256.49358-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_072919_028912_6B496764 
X-CRM114-Status: GOOD (  21.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 05, 2020 at 11:42:55AM +0200, Hannes Reinecke wrote:
> Instead of reverting the handling of the 'last' path for all
> setups we should be restricting it to the non-fabrics case.
> So add a 'queue_if_no_path' flag which will switch to the
> current behaviour; disabling this flag will revert to the
> original (pre-fabrics) behaviour.
> And set this flag per default for fabrics.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      | 7 ++++++-
>  drivers/nvme/host/multipath.c | 4 ++++
>  drivers/nvme/host/nvme.h      | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af950d58c562..79b88b4c448f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -474,8 +474,11 @@ static void nvme_free_ns_head(struct kref *ref)
>  	struct nvme_ns_head *head =
>  		container_of(ref, struct nvme_ns_head, ref);
>  
> -	if (head->disk)
> +	if (head->disk) {
> +		if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
> +			nvme_mpath_remove_disk(head);
>  		put_disk(head->disk);
> +	}

This needs to be in a helper in multipath.c so that it an compile fine
for the non-multipath case.

> @@ -3686,6 +3689,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	head->subsys = ctrl->subsys;
>  	head->ns_id = nsid;
>  	head->ids = *ids;
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);

This needs a comment at very least.  In fact I'm not sure we should
mess with defaults here. 

How will this bit get set for the non-fabrics case?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
