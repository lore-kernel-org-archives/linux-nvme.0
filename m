Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0442ED2C13E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KP3CTny6X4EF5DpZpN8B26kZWuQaY04gUk1NU+oW06I=; b=guHEQXjKZNteWSlQRfyW2eP1Ye
	aPUVCiWz8BZVgMzsSyc8vZ3/c4ETeN9LSOO1tHHZZRvnypgbO0uBBCQk/LVzR8KYeWb25741I7fZv
	qECsmRlk66BfOoR1RV6T5AJ/Dg0Cn1yu36qiqC39FpaD89scRopr3QnFNfkpZlaThY9UE5c5YTtWT
	Rx5+Ny9WrQP7vWjqHzSsHKo2AriNVnMNwPP44HL8QEhF35+SXDLR62ThscQHKpLqXZjxFYnds5+Ff
	YYvRzD3ozPXpQuyxg7FIdjD/OCqOlmsN/7nlAacx7SI+RCuG6TPfuaFc3KwAZ2R2gj8NNBys/IazU
	J6eoeRKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Lo6-0000000HUEr-1F3y;
	Tue, 05 Nov 2024 15:49:26 +0000
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln3-0000000HU7n-0kSS;
	Tue, 05 Nov 2024 15:48:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: max_hw_zone_append_sectos fixes
Date: Tue,  5 Nov 2024 16:48:10 +0100
Message-ID: <20241105154817.459638-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
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

Hi Jens,

this series has a fix and a cleanup for the max_hw_zone_append_sectors
change.

Diffstat:
 block/blk-settings.c          |    2 +-
 drivers/nvme/host/multipath.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

