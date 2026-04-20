Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E68F588E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VCVERsDtmIopjD09l3h5stga/fyWZhlsmzJ76dH1UA=; b=BRRZCeFb6rplo+MD/vena6eA+0
	v5CktpEzx426ldtxzdfHfNXJQrF5ypoD4dM7hzjqJX5dfWXVFquKkIlFdUtwUB4yNi61v4VSY1AXn
	0j+o1E1EyJWpH+ALkuTHG/brxuyr9YD6XtDLFWBWf6XDbsYstpZNekXaMX7X2e6bLiGlfoASKWGBg
	lXoOuwU+XNzk6xo6Tq89Tm0HYp7eZ4koyIrKYHHCUuvUrCOeGFXVlyea/NIVIwId5ayefZNMs9kJT
	k7Q4QJFirUj2WknYL/R5hB2ROXObzEq/jk3oMr7RcVXhQtwTuxjM3Ebu+OYCTNuzu5NcSpCrXsG0Z
	4RQgAQ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpy1-00000007CHS-0ibY;
	Mon, 20 Apr 2026 14:51:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpxy-00000007CH5-3cpN
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 14:51:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71553419CB;
	Mon, 20 Apr 2026 14:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5984C19425;
	Mon, 20 Apr 2026 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696673;
	bh=8UoUFrvUJb5Thy6ctrITs58pMyDxujdI0HAy+0ogeVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6y50vLXRB+Lqv96OF0AqvjMcDtJWtzzpvZBKZwdptikQvPeVPipvWpelAypa2RQ7
	 DRiLeiZB7M1GFAds3Y5tm/ioQRnxvLD+0KleMhAcI/krJJp+eiRuiCWvFfte7dCGBh
	 F996n9wYaXDJgfbVhEgGTsHaJ4FDidu2gGSwYD5h7q9kUkuhKHsFudV0KTjfbOQoU0
	 /nPPkDWaHrPnVEKnP9W0rWValPPbpz4SJnFS5xGodENCV2xSCaRyyV99tJGtRFr9Ao
	 r+v8cig1EcmZgX5mc/8T9YhUoX1iCtASgX3AHkGXqND6XGRHQbkPM0i90veseshnpa
	 P8dPlWJicuqXw==
Date: Mon, 20 Apr 2026 08:51:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify
 Namespace
Message-ID: <aeY9X1jEZrITd6mw@kbusch-mbp>
References: <20260418042835.420281-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418042835.420281-1-coshi036@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_075114_924483_65A519F3 
X-CRM114-Status: GOOD (  11.86  )
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

On Sat, Apr 18, 2026 at 12:28:34AM -0400, Chao Shi wrote:
>  	memflags = blk_mq_freeze_queue(ns->disk->queue);
> +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> +	    check_shl_overflow(le64_to_cpu(id->nsze),
> +			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
> +			       &capacity)) {
> +		dev_warn_once(ns->ctrl->device,
> +			"invalid LBA data size %u, skipping namespace\n",
> +			id->lbaf[lbaf].ds);
> +		ret = -EIO;

I think ENODEV is more appropriate errno.

> +		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> +		goto out;

I don't see any particular reason why we shouldn't validate this value
before starting the queue updates and freezing the queue, like we for
the ncap field up higher. Doing that would make the error case much
simpler. Case in point, you're missing the corresponding
queue_limits_cancel_update() for this error case.

> +	}
>  	ns->head->lba_shift = id->lbaf[lbaf].ds;
>  	ns->head->nuse = le64_to_cpu(id->nuse);
> -	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
>  	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
>  	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
>  	nvme_set_chunk_sectors(ns, id, &lim);
> -- 
> 2.43.0
> 

