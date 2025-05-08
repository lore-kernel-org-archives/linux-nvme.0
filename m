Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40EFC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ko4pauh3uuh5Q1D4+7Jf3X67t3Uv+0ATxrGei1xV+6k=; b=QEDVZqpo5ZCu4dSvBW25xOblkh
	6ZKBj+faie5yedAJfrPchpCiu9hwlSzeLR2Kxb85dzdb4kwHV4mSiDNxZiqfaoja5ySodpy/btmb9
	F/jYunJ+M4oruTyBz0b6we2/dFHYJ82CsMCWu7bxEYNoVfKjWiujnvsnwGNzbGqduU5CeO5DTEFhd
	Ecc+ZmNnpovwFuzAkw4LKwVSbYYpJSgEOQp5lO6+iKDzjwYuqSor2FhB7qk++2P69jkK10W8LPw13
	lEFgJ6gHirHpBtj2yS6bkTIzo+wUFDYOXOP3ZkwGosd9YUrFT3TapZd2/BBjTGnHParOo2iT1LlGC
	9QZ8GlOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD3k4-00000001EN7-1dfE;
	Thu, 08 May 2025 16:05:00 +0000
Received: from 2a02-8389-2341-5b80-263b-3d6a-277e-2269.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:263b:3d6a:277e:2269] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2qk-000000013Xj-1Qkv;
	Thu, 08 May 2025 15:07:50 +0000
Date: Thu, 8 May 2025 17:07:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aBzIw5ojzLmaen2g@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit db492e24f9b05547ba12b4783f09c9d943cf42fe:

  block: only update request sector if needed (2025-05-06 07:45:59 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-08

for you to fetch changes up to 650415fca0a97472fdd79725e35152614d1aad76:

  nvme: unblock ctrl state transition for firmware update (2025-05-07 09:01:20 +0200)

----------------------------------------------------------------
nvme fixes for linux 6.15

 - unblock ctrl state transition for firmware update (Daniel Wagner)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

