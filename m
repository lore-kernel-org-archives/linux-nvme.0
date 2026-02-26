Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A778DFD8FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJHqYVztNDOkHT7btaMD+t9Zn3XeJkoZ8/2aa8ZvXlY=; b=H060uggjOaPlI7sy/S64g5xMCT
	6G7OlIdQs5TEhJ5/rA/QfQAf9siRggD/thfyq4iT52DPqCKeJclvn8w7cGT5o4y9ZBdTELroMNGGJ
	KZ2jJu7+/DG83bflbXLGI36gpnDr/y5aCQ0rUdhU1Hmv9ujx+EwZfd6xiycRz2z2oWl/iyIAcv7Rx
	9iv3zYtVr+jLEELZ2p8Rv6UaaiakgJceUTfea1O2JKo8FwDyETofqkL6rAfF4qVkKlMdbrPaV4zdq
	eTutTvBfwyPiZ3s/EoI66o5tNesy8Of9MNBjaRzsrN1gjFpb46WdSd7DRnNh5lJSecU+jzMVhzi9j
	xfhxt+BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdQw-00000006WtY-0AAB;
	Thu, 26 Feb 2026 15:37:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdQt-00000006Wt0-2WHo
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:37:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9641C68C4E; Thu, 26 Feb 2026 16:37:40 +0100 (CET)
Date: Thu, 26 Feb 2026 16:37:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path
 deletion
Message-ID: <20260226153740.GB31615@lst.de>
References: <20260225202109.447144-1-kbusch@meta.com> <20260225202109.447144-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225202109.447144-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_073743_784495_437A39EA 
X-CRM114-Status: GOOD (  19.05  )
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

On Wed, Feb 25, 2026 at 12:21:09PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The NVMe controller is allowed to reuse an NSID for a new namespace after
> deleting the previous namespace that had been using it. The delayed removal may
> have the stale namespace head in the subsystem list pending the timer, which

Overlong lines.

> +	bool retry = IS_ENABLED(CONFIG_NVME_MULTIPATH);
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_ns_head *head = NULL;
>  	int ret;
> @@ -4008,6 +4009,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
>  	}
>  
> +again:
>  	mutex_lock(&ctrl->subsys->lock);
>  	head = nvme_find_ns_head(ctrl, info->nsid);
>  	if (!head) {
> @@ -4033,6 +4035,22 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  			goto out_put_ns_head;
>  		}
>  		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
> +			/*
> +			 * A newly created namespace can reuse an NSID that was
> +			 * previously deleted. If the head has no active paths,
> +			 * it is pending delayed removal and still occupying
> +			 * this NSID in the subsystem list. Flush the removal
> +			 * work to clear the stale head and retry.
> +			 */
> +			if (retry && list_empty(&head->list)) {

I find the retry logic a bit odd and different from other places
do in similar areas.  What I'd expected is either a "nr_retries" or
"did_retry" variable initialized to 0/false, then checked here to
be not set (plus the IS_ENABLED() for multipath) and incremented/set
below.

But independent of that, the actual logic looks fine.


