Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D54DC0219B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b91yEcDqKDBZPQaflTto1Jhkc/s+UAP+sysg3GnR3xs=; b=Hx98cpXZSrHkr/ZrnwOxQ/99hQ
	6wSfmJxiNjFc1HvTyIV6c2sttsgVztcqYMs4gx+whi1QtQEptbJr/6YxhG8ZSh/J5KQ5IgJxIk2xn
	zOnHoCLflHl8bFHHU+GTknxPEmFuRI13k5VUNzPi3Ml2rx7VI2+g28/oRSbGCU6tbWohQSeR1uv/5
	EFQOovmjKf+xpD7s65qA+RFzGVI4lV4FImU6MbwFi9KqDSSfeNG1naKO+WRGig7ZeIJwu2Mcd82Kx
	GLWYZvhdZvUXKrLdKZNJhZtEhnLVqA/V1W47iLT+AOq3dEOh1KJ4338CPmM6Ve1S0M9KyrlENS6h1
	hSwAANDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhD-0000000FqUE-0QXY;
	Mon, 10 Feb 2025 00:30:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhA-0000000FqRe-1p4G
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 00:30:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 11702A40096;
	Mon, 10 Feb 2025 00:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FBC4CEDD;
	Mon, 10 Feb 2025 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739147439;
	bh=TyvmGHqq53u17awGjlNZrKlPxrnUNpmfRCMxaHeisMM=;
	h=From:To:Subject:Date:From;
	b=LFPXoqkBNf9P0s3FjC3sq4DnklGpHd4NLV/33IRT3XWe/XrCODNbpk7cRj73kKMSW
	 FNbh54q6ZPcX0EaWKoSaaBUTBqWRAuM6/QNNYWBZ5nx28e+PRzvJrP6jUfG1qtZobk
	 2FK9LgON3IHr6kf18xKA6FkP/jHR0/pusEMu0q90ZQedojJtrEtdiSIldR2G+kzPrs
	 uBmfI5WwSeFfSPXc8MnLwN9+PKRqvcSo/+Kx/sdG+L/MFiqdBDaHj8zIgnfTHINRBH
	 wtdYfv+91YdvynnPrChEU25AQT4yFXomRO0+ioEQChR3y3XibcZDsYtH6o00bQz7r1
	 yE0c+kTTTVHYw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/2] Cleanup controller configuration register handling
Date: Mon, 10 Feb 2025 09:29:33 +0900
Message-ID: <20250210002935.1744249-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_163040_538609_C27FE78E 
X-CRM114-Status: UNSURE (   6.59  )
X-CRM114-Notice: Please train this message.
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

A couple of patches to cleanup the definition and handling of the CC
register. No functional changes.

Damien Le Moal (2):
  nvme: Cleanup the definition of the controller config register fields
  nvmet: Use enum definitions instead of hardcoded values

 drivers/nvme/target/nvmet.h | 14 +++++++-------
 include/linux/nvme.h        | 25 ++++++++++++++++++-------
 2 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.48.1


