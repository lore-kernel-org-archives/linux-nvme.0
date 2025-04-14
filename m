Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9845C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9neUaLY2aJdrCmuiUNlY46o5tskoxZYhFRLQacPo4wQ=; b=e1Nn6AvGAF48rReqM3zwtjCn/k
	HYBia88D/nZYD1P2F2x1zsBajNV/3i3hs0GWRx7jPwPBcynzASNmribuMheW46PftQik1hWgPVtWi
	R1fS4l6k1seusJ+1Y+DB7KwBmSUFP01szhwqakGLEmkXQfGYFAsyB5jlaOc86B/MXqRN1snkWWwDD
	TBD5RsBMkkNIGOuu0Pg1iQfDYn5yIw77hxkHk5EhBWVlsffC4reZr+qqQbLlLFkJKH3YQAQrX9AdO
	DU6AOJxmRHxqwwjGOQ5xkM9qVbVFFtwtUVccGzxT8pcZC1pH/4hLUDUxL1zXhw+vuSpvctpfMPRQI
	NJNTFKdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Iwe-00000001wag-3F0A;
	Mon, 14 Apr 2025 12:29:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Isr-00000001w91-3g0s
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 12:25:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 439655C410D;
	Mon, 14 Apr 2025 12:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83303C4CEE2;
	Mon, 14 Apr 2025 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744633553;
	bh=9flmqn9zkSIBK2KR3c8WUVb5DQuDsgQHG3iMKRUkr7U=;
	h=From:To:Cc:Subject:Date:From;
	b=CN15qK8kZLw0Er2N8fn61itIAIPQm2a5jAE16yNYrNrii+hR+lIAEH0gL6cPD9IqJ
	 GXJ7+NUSaoFzgHXALsyT/54CP1IujeVGwNhJOtELQZkCm9HYiViy+YQ/m/l+cSTJ7k
	 tgXxj40hx0kEPqM0LCH4+d+UssRdr8F8swma4V/A0Hhsa/YhHTnuU6PHgKSqodyDEp
	 Y1S4U72RBQwLiAp2TD9nKjdk7nSmRxwYa7N9BOM5EtpQVwoyFmpr+4sP6X3Si32N1j
	 PeOAdwwMOl9K13OPaz39oUMeeB2Y28HYh8Qqfob9fo3NVBwQP0cxZ3MfV0xeRB2MZu
	 yCRfHbARJB1wQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-multipath: clear NVME_NS_SYSFS_ATTR_LINK when disk is not added
Date: Mon, 14 Apr 2025 14:25:45 +0200
Message-Id: <20250414122545.140531-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_052553_961266_13AA7650 
X-CRM114-Status: GOOD (  11.51  )
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

If the namespace disk is not added we need to clear NVME_NS_SYSFS_ATTR_LINK,
otherwise the link will never be created upon rescan.

Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 05eccd96d34a..5c28f0dc6fad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1069,8 +1069,10 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
 		 * Ensure that ns path disk node is already added otherwise we
 		 * may get invalid kobj name for target
 		 */
-		if (!test_bit(GD_ADDED, &ns->disk->state))
+		if (!test_bit(GD_ADDED, &ns->disk->state)) {
+			clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
 			continue;
+		}
 
 		target = disk_to_dev(ns->disk);
 		/*
-- 
2.35.3


