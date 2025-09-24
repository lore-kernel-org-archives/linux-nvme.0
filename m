Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB7ACAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBt9/S+ucUJehadzp0Q+G5xyDA6C8S/cVQKajE1S4rM=; b=DOqm8g4MOmbmE8hmOXA0QwsQjc
	alB/pUCQwycfrKOJr9PuOKHvakCdXeLoDW70rgb0ZvmDQASLbqQ7Gg/+HHx+qa5LUu4afIdkn5LSJ
	7e4TyI733CF3xkDFnmOR6gM9kuPWRa6nMNbeD3ttfxglkJxL+B1L9uruFKvO6XseNihcrRt8u41Mf
	my+RtfkVlRjDoWnlBo6cSItlhJJ+PNqvQaJ3JwSRA24n9Bs00Q8iHiw+FT1wkvuaN/gAVunn+/QfT
	RlIy5YnoHH2YEDGhc12W+kNlsgD9jLCIHfAmH/BBsJqTKbMtAnUDuIt6bLx5BMr1C4Wa9DQz2rFNe
	khY84c9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YVj-00000004VVc-16zN;
	Wed, 24 Sep 2025 23:02:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YVi-00000004VUm-2Q0h
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 23:02:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0431F60145;
	Wed, 24 Sep 2025 23:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C51C4CEE7;
	Wed, 24 Sep 2025 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758754973;
	bh=WL1YIeZxrOhfyEJEdvA3ieauQEgRVeScvPkQdXGhVWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDCUt4ISdcKLqRhChVQuATgGVDG9Iu7chqvIJwl0FQIScgIdT/C/E/IdW5S1pC+qo
	 H6Lm8CUHGJTIsIeaDLf1aRrL7uzkeQd2vky5g2cT6AmytuMrrgb1142qIyooRD+Hza
	 6vtL/nFqevylvyn6ofsLMb9/US5bbLEMzIQneveP4I/XKlS6ERpgSZ1saHQRRpvlDb
	 Bu9myQlpp45lLNUQjhCruSXnYU1eGlVldBY9f02/VF4j9iv9XARlMcfZ/KQV2Er4Oy
	 XmEhH3y3ndzO4CNMFSpSZD5qbLq8E0ldO5P5sBiiJxAHRqVoUymORQQa10GC2gECa+
	 d715yui9TN66w==
Date: Wed, 24 Sep 2025 17:02:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Amit Chaudhary <achaudhary@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, mkhalfella@purestorage.com,
	randyj@purestorage.com, jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <aNR4m9wrO5cgFZIe@kbusch-mbp>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924224319.4557-1-achaudhary@purestorage.com>
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

On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
>  static inline void nvme_start_request(struct request *rq)
>  {
> -	if (rq->cmd_flags & REQ_NVME_MPATH)
> +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
>  		nvme_mpath_start_request(rq);
>  	blk_mq_start_request(rq);
>  }

Using "retries" is bit indirect as a proxy for multipath active counts.
Could this be moved to the mpath start instead, directly using the flag
that accounts for the path? This also helps to keep track if the command
gets retried across a user toggling the policy to "qd".

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d91..1c630967ddd40 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
        struct nvme_ns *ns = rq->q->queuedata;
        struct gendisk *disk = ns->head->disk;

-       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
+           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
                atomic_inc(&ns->ctrl->nr_active);
                nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
        }
--

