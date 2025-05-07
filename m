Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C14BC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zl440QNTwl3qXGlrC0tQjC1TXYY7ZVBCn0pP0LMJL4Q=; b=dzwOB6u8jyZaK7q9lf81+xWrKf
	mvLExjdRlKWdftbin56AH8gFhlt79Z5SyLdpGuF3hQvyHnu3a6S0nuSBuDIm/FtyMNI4IPWKpyTFH
	BG2cTHV3AVRMSr9eKDehx0093Dnd6PUTH7IDUjZSfYFNkEqAGeQnFxVF8qaVXdhllQFQOQOvOpO5O
	GxxuVPDEL986VFiqUXiH+iKg3WHvpDmbq0g6k2R26EpZsEc3CrmxFLOgpKj7sJRnGNdp9MpNZAWzb
	GPZ2kRBDzrhpv/rmoVcz+iV9NnSu//Lqc4vPb85gtJ/y9pcc6UYYoI//Ljbez7bERD9t0TmimJFX2
	OSUAhHGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCk3S-0000000GXus-0SMy;
	Wed, 07 May 2025 19:03:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCk3O-0000000GXts-10m3
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 19:03:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D7319A4DC7E;
	Wed,  7 May 2025 19:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F963C4CEE2;
	Wed,  7 May 2025 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746644616;
	bh=60ZvJgBlzuqhPVKO7oJJDJaqUW98+Gbt7VLuZ0uJ2Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdO2RmQAA1sXDsFxysShaJt+nqUdq5HSxGS7d5nxvSRJE2rpdKWsFQN0ZfCndh4hY
	 aEU+PlzoAFFICy8axNiVUwXaK17+r32tG/gYd67w5zHVZL/3ZHBzMhZyaA/U3Mn/jD
	 CAhWFZvaseSr4b4qQucA2qX+rz9SjnihG1scBhsrAj/4wAxasxZxI9A/rFvg53DZna
	 7PoSHCrcbY+RU7fOzicKN40qs+EjlobaHIycKE0ZgwWd9ERfMg0uclfjriUErIPYVq
	 o5vBlLF4Pt7yO2f2PLQ9YoA3nFavrfhHDsjQU2UQN9X6gK6DH66M53kP6ULznugiOt
	 1IYlTbN4juaYQ==
Date: Wed, 7 May 2025 13:03:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer
Message-ID: <aBuuhRBR8qieVW28@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507153759.1199895-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507153759.1199895-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_120338_345257_9FA5150B 
X-CRM114-Status: GOOD (  10.25  )
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

On Wed, May 07, 2025 at 08:37:59AM -0700, Keith Busch wrote:
> @@ -412,6 +415,8 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
>  	struct bvec_iter bviter;
>  	struct bio_vec bv;
>  
> +	if (bi->flags & BLK_INTEGRITY_NOVERIFY)
> +		return;
>  	/*
>  	 * At the moment verify is called bi_iter has been advanced during split
>  	 * and completion, so use the copy created during submission here.

I think this may not be the best place to check this flags. This
function is called from a workqueue that defers completing the bio until
after the verification. But since verify is disabled, the deferred
completion isn't necessary and just adds latency, so I'll a send a v2
real quick to short cut that completion handling.

