Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1460CA5FEC
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8MeU89wcR1F3Q/A0tK1tn1RvHdQqhCgRtFNHu+sOdI=; b=09M+OXxDLtVzF8KUVhsMExlj/8
	qUvC4L3HWXMKIXwkBcObWt3fPg4QpRTRRniWUwT0DXlX/iNB4Png4DkbMyYfR+hSU3zi5ULbS4cAF
	nMbLKrOC7aaVKaSfCgN/LBRYr0Y6O/mzvnibhc8Zn2pyb3SoQfRClaFdd+xQZ+x1LTgMwDsGX76Pc
	5LmAUf07kOiqExhHquLenLUDR/msbwP1FTMq4YhRFns18tp25OZvr9/CX5U0sQa/jIxYp5bW9VMM+
	lsU2Zy9634qaMC/4fpsp4Odse6drTtqyyBrBWSwtDaBEI8Jr7MhTbjcar4pPbWSw3OuRL1N3kabOe
	i9ALS1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD8Ol-0000000E8AV-3rgb;
	Sat, 03 Oct 2026 22:40:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD8Ok-0000000E89p-3djP
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 22:40:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 537A043729;
	Sat,  3 Oct 2026 22:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1991F0089B;
	Sat,  3 Oct 2026 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067206;
	bh=Q8MeU89wcR1F3Q/A0tK1tn1RvHdQqhCgRtFNHu+sOdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3WDAGnI9Lw+UgNeDqI5ja0zj9FSFrLzRroxMtd4X87xTibBEZh8/mxbMaINZvfUN
	 b+O1Giu/i1cbKE+cdoWGxd4xmuXS/+LA8mawZFb8L4A+9KpFugp7qP6cK+mcRZ1JcN
	 EqNRmufXEAuM21bkNXM3TfLSOmsmzFhWy3bQKAYrW73vd0kUKvY26xhG/o1TJ6aHvl
	 AXLZy3yuRG92uXTqDotMuwX22w7THSaD2Q2/QlcFwqrX8nQaQyGWqF3i+ELfuDK+L4
	 Wfsou2i+VOunaAAKf2WLZk2ToEaWDvHEx5LwtnaQRd6jbSfRTTKxtkwIpvOiYA3LOu
	 j0hC8wiQuOjUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] nvme-fabrics: use reserved tag for reg read/write command
Date: Sat,  3 Oct 2026 18:33:07 -0400
Message-ID: <2026-10-03-1-daily-reply-0026-re-nvme-fabrics-reserved-tag-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002204646.26451-1-artem@trailofbits.com>
References: <20261002204646.26451-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> [ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

Queued for 6.1, thanks. I moved the backport note below Keith's Signed-off-by,
as Harshit suggested.

-- 
Thanks,
Sasha

