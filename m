Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0213EC282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Message-ID:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n3kbDJPMp5K8Ot4DyRYE8Xg658b4ZsN55SOsDzy+u1w=; b=Sen6iLE3RkOjkbDgCNNX3LfKJ1
	ShcYZNspv/dlrM3ImhmyNGcxwSqq7jxytJOIoet+rVzHozhSof7m1SPVfhA9JJA/3OUDbDPrLLgJA
	LhJ5vF0KSacvmWnLLOLJQYkav5kxdayY2fOaCNnXphDJ8QSqb13+pdJ93pbc72jkyOtwFH7A/41hg
	3JtgRmS0/vtn2QqUPDXPtnE2aPlom6qRJwmTzU0JpoR6e6D9neKwFaVuqT9rPo4IocnM5YoyE+ijv
	ztHPfO/dW7ckY9EhHWEYU2qOb6/tUGXN785W4MAvZn8oHRqhEqhQ7/OAEO6ADwXYvJVCVMR77edts
	RF19+MDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu54S-00000001bvw-0Pvu;
	Mon, 17 Mar 2025 07:39:36 +0000
Received: from mxhk.zte.com.cn ([63.216.63.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu54O-00000001buA-3SRC
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 07:39:34 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGRgb1jRbz5B1Dq;
	Mon, 17 Mar 2025 15:39:23 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52H7d7qA050121;
	Mon, 17 Mar 2025 15:39:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:39:09 +0800 (CST)
Date: Mon, 17 Mar 2025 15:39:09 +0800 (CST)
X-Zmail-TransId: 2af967d7d19dffffffffea4-7e28c
X-Mailer: Zmail v1.0
Message-ID: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <sagi@grimberg.me>, <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.tao172@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lOiByZXBsYWNlIG1heChhLCBtaW4oYiwgYykpIGJ5IGNsYW1wKGIsIGEsIGMp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 52H7d7qA050121
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D1AB.001/4ZGRgb1jRbz5B1Dq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_003933_015511_F76D1A56 
X-CRM114-Status: UNSURE (   9.41  )
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

From: LiHaoran <li.haoran7@zte.com.cn>

This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
driver. This improves the readability.

Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fcf4f460dc9a..30804b0ca66e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
+	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);
 }

 static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
-- 
2.25.1

