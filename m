Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D65DC369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzMix/558tb0Pnf3yfKNegpZVixRI3VTnv7Crsvh33M=; b=cImoJ3/8DI746ic0vVjG1EDJDj
	/cRN5NjHi4bROZsybQfSyWRxEo2XisR8VP1AOL3Qs9H8i0hsHmTRPFTNa2Whcryu8s5DTGIGVYyzK
	FxcBAOA85OHrYvC2FXU1pMbQ8Zxr7ZBQpsAs7Y5DZSOhWKQ9n0U/YTldD1I08FDdwTEAes0/h/CDo
	+9i+P/AMYOJb+HSU22k1TSL66irfTAkWWBG9WTAkRVy9IS45v2J41oKaskgcCM1T/WOuR+kvSMUqY
	8DEZj125ezgKJhE7lSZmTqilPGvGhbNJvN+ke5Fg/APJlrh6JKA6TAXD6W+Bw505eP/EWWoMGsAaO
	cDFJCkcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jpa-000000027QL-3gVk;
	Mon, 14 Apr 2025 13:26:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JpZ-000000027Pt-2lKm
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A7426116E;
	Mon, 14 Apr 2025 13:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812BBC4CEE9;
	Mon, 14 Apr 2025 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637192;
	bh=CJepgFajH+uEClC5+Nr4xS6NXi18SZs+QeUfB+qxRhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbr/INEDDGfdA/i82DvLsznRYDPI65L2AGnSHDHvkqjZTNb7KHmRd1Vs8JVvImk54
	 C3OKQExiyAWYiZYLb1qeX/nZldvwXM5sf10WVwcEmEchGJwHhsftFmlfKii/aGl3yQ
	 +8xBf6HcE2VyB0Qdueg50nWi9u5YM01pGBqxuIZ+O6DMywHJZG+uyEUXVdY64ro2gz
	 hq0ZmKaJ8M+8cGZv+zFdTMGvtG5YOkvnXBCaMTjip8+gc4fWqaJ+bjTVGY7u7Ayi7c
	 PmKVVM9Xfuj6fHgDLK+1ZGw4MOPlmsfhdPqWcbqRXcDUmdrQTA9fmILNFj37Q84rzI
	 PcHXSETHdxAuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 10/34] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:25:46 -0400
Message-Id: <20250414132610.677644-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8359d0aa0e44b..70f9c2d2b1130 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4292,6 +4292,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5


