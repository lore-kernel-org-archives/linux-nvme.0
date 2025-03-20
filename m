Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D0C36002
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 07:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Message-ID:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kqonjV6DLiLOY235qVbMSQ3bKyTE+melduLm3U7vTsI=; b=tmVctFmlBLsd4abHgjmbYmr56s
	1Ju429PjRcR24Kw7VL3qruFoZTgftlMN+PRZKLZSKOs+Tge2CceKus8+pNRpkjc1R85Ij1i2seS7I
	WgClzdVnBK8qbJ+9eoMk9mr0PIjVa9cGBShDY66gu6NoUvi7LLBg9uvsX8O5Lsf9IWpFGAQC2TI9e
	5Sh583T/fvVlXC3U42DdU+h5VmVFdJUhTLcdhdBHp3hkW7jYuKBy7MQis/JyM8YkcdT1ymR5Gj0JE
	IP2j/xxpwBhjehbOB2NUlaOVAElbtxXrMvF8xM7lG5EZQ5GD39XQhwXR8CZhE+vcHBo6ynfQWLWe8
	4/yBg9AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvAis-0000000BSsH-2oUk;
	Thu, 20 Mar 2025 07:53:50 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvAiU-0000000BSou-34Ku
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 07:53:30 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZJHr804CBz50FXg;
	Thu, 20 Mar 2025 15:53:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 52K7qwbN070824;
	Thu, 20 Mar 2025 15:52:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 20 Mar 2025 15:53:00 +0800 (CST)
Date: Thu, 20 Mar 2025 15:53:00 +0800 (CST)
X-Zmail-TransId: 2af967dbc95c35f-2e3a9
X-Mailer: Zmail v1.0
Message-ID: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <sagi@grimberg.me>, <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.tao172@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBudm1ldDogcmVwbGFjZSBtYXgoYSwgbWluKGIsIGMpKSBieSBjbGFtcCh2YWwsIGxvLCBoaSk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 52K7qwbN070824
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67DBC968.000/4ZJHr804CBz50FXg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_005328_320441_1A72ACCE 
X-CRM114-Status: GOOD (  10.38  )
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

From: Li Haoran <li.haoran7@zte.com.cn>

This patch replaces max(a, min(b, c)) by clamp(val, lo, hi) in the nvme
driver. The clamp() macro explicitly expresses the intent of constraining
a value within bounds, improving code readability.

Signed-off-by: Li Haoran <li.haoran7@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v1->v2
Swap the arguments into a sane order.
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fcf4f460dc9a..7b8a1483da2d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
+	return cpu_to_le16(clamp(a, 1U, 1U << 16) - 1);
 }

 static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
-- 
2.25.1

