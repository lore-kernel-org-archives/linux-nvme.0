Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FC8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtaQc4ulbF6eXoBCXGLgXo5qWw4sPzJ73lBRx7+ONpY=; b=YyP00f0SXmQnMiRQlUQMwexq9q
	3EIB4McitG218Hoqi8AuCJs9a0Lb6s5WsJieiYKHreITZQEWE7oE/Q3TGsq+X2nA2C9W0kTZFi8rL
	Y5jifxhgsViDtWbF6y73N/kpgjADJgnEjGYUy/pF9r7pqRLVIc1uv0QzqHFv2O6kkd7IEXQSXjI48
	JQBA/1OR9UWhxk7D6jQjLCX056W5C/tjI8eNe/VQQwc30cLynh434GVHA9RW4bpFbGUa9nZHk/4rt
	iTcSqljRM7sAgc6RN7WJj7Q/RRG3uPEtfl8ST1u1tX0F5aKh0kzG79uLeDf71HYx4+aeJkCQGjukx
	Ib5EovOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4Vj-005iK8-VA; Tue, 30 Nov 2021 14:53:36 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4RO-005gGR-Eq
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:49:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id BABEFCE1A5E;
 Tue, 30 Nov 2021 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B67C53FD1;
 Tue, 30 Nov 2021 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283744;
 bh=lT/20zaKCiSCBeJ0jORGKZ/l29y9w6y6dHCRyITHpLU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bhvGJRf4gsOcv65vZ5fGH8Camyg2HCVYfWGq3QhvUGASa1rlXiVWg0m2oaPV2FlmM
 DpKnXUZradXm4lmju0s7+nwM56EMe3qhPSGQdgHbA+haxbAl8Iu2ur8kpdx5XCGQ4V
 zwEl3YMgTSRFR6d1XPZNjn1XAVEYv/pJJcN2D33C/djivUQyQurs8aADih2NUXhIG5
 0RgdkWhvkn9lUvuGhEF7Li9DyScXwa+p+/gNGglCtnACFetEtgWIKHkydIxJWWZs8s
 NLaOjJvuAgzePLXW3UOQjxSJ05MMRYBcaV31/O9lus+NpV17KSp7vD/WTelAydbeYr
 jcvLzTFBCMimA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Klaus Jensen <k.jensen@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 47/68] nvme: fix write zeroes pi
Date: Tue, 30 Nov 2021 09:46:43 -0500
Message-Id: <20211130144707.944580-47-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064906_719718_E32C23B8 
X-CRM114-Status: GOOD (  15.05  )
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

From: Klaus Jensen <k.jensen@samsung.com>

[ Upstream commit 00b33cf3da726757aef636365bb52e9536434e9a ]

Write Zeroes sets PRACT when block integrity is enabled (as it should),
but neglects to also set the reftag which is expected by reads. This
causes protection errors on reads.

Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
not check the reftag).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ff75d7031110..cb795f99f0fcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -898,10 +898,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	if (nvme_ns_has_pi(ns)) {
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			cmnd->write_zeroes.reftag =
+				cpu_to_le32(t10_pi_ref_tag(req));
+			break;
+		}
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.0


