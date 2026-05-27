Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B79ACD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4QEnaB1YKMNznE8JURm5dAvLVvKUDZmzbsmnh3wi9g=; b=V92N4IZpjw+alnXzcQfGb81DSM
	ceqygtvuQCiBbLw0ZDDAU/joclVCboNw4LfvRk7/C7LbXHcSUlmE7Rg9Ix2DjTfgMpb0nA0YNMjNw
	wxyRgHdvN0S4pSb0F1hFXwlQ/4byshjoi2a3n6y2I4nk5PlIzSNpMc+2dW/75DqbVzLzcHfbWO4G3
	PtHcdpUj5wIQd+Y1SoXbJ1V3h6P4aDmPjfaj6UPbmrBvcuF752G8xrEyBWVIfQzRGQr9dal76MU+u
	koWIPwxGvYXJmhr51BrejIwn6RpBVIzwEQT3cwc/KF1w3PIBer82UxaPBFFZAlR7wK78/ElRza9y4
	J4djAs6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF6K-00000004HTn-2mRo;
	Wed, 27 May 2026 14:19:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF6H-00000004HSz-16K8
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:19:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D72D68B05; Wed, 27 May 2026 16:19:09 +0200 (CEST)
Date: Wed, 27 May 2026 16:19:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
Message-ID: <20260527141909.GA13578@lst.de>
References: <20260522153034.2168862-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522153034.2168862-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_071913_442867_940236A9 
X-CRM114-Status: GOOD (  20.36  )
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

On Fri, May 22, 2026 at 11:30:34AM -0400, Chao Shi wrote:
> nvme_find_rq() resolves a device-supplied command id to a request with
> blk_mq_tag_to_rq(), which returns whatever request last used that tag -
> possibly one that is no longer in flight (freed, or never dispatched and
> thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
> command_id with a genctr for use-after-free validation") guards against
> this, but its generation counter is only 4 bits wide and can be matched
> by a malfunctioning or malicious device replaying command ids.  The
> driver then completes a request that is not outstanding, dereferencing a
> NULL rq->mq_hctx or double-completing a command:

I don't think an intentionally malicious device is part of the threat
model here.  This was added to protect against buggy devices.

> +	/*
> +	 * blk_mq_tag_to_rq() returns whatever request last used this tag, which
> +	 * may no longer be in flight if the device reports a bogus command id.
> +	 * Completing it would deref a NULL rq->mq_hctx or double-complete a
> +	 * command; the 4-bit genctr below only narrows the window.
> +	 */
> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"completion for request %#x not in flight\n", tag);
> +		return NULL;
> +	}

Although this check looks cheap enough that it should not hurt to add
it.  So I think this should be ok, but maybe respin with your planned
commit message update.


