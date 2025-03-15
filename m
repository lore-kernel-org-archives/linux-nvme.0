Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B52C282EC
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Mar 2025 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Message-ID:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VK0YWR5I/UAgXEgDv7J5VzYXThmvxXcvSlDLQYzVHvQ=; b=dlKhR6dICC5VBgny4ubUZZ78kl
	TIIHsLXMslTZpCGtDiCp/ATJlbKNPEmMsorMl3UCOP65XqDXkT28GiI/dpvwO6OvGnnsK9/OtcebN
	kZS4p4e2orKRs+6voSj0Eyc7crUz+67VBwV67j21726g3WhC+9kruVtGX5C1Cs1GvpZeJqb9GcuS4
	Zf/7Q/g6tY25fQbstRpUq8+8CtvnrvT329MqXGzHW6q6K511esrQ6CYpxfFfYI3I79pgePBNQDdJ2
	RW/jA80aMQghC8tpXf0a0osrYB3fLfbdIvu0+ptfRavcoQjPUcQIfXfJxfBi7jf/YZkF/DEwseNxR
	veOXLPSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttHsn-0000000Fjby-42Oz;
	Sat, 15 Mar 2025 03:08:17 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ttHsh-0000000FjZH-2AH9
	for linux-nvme@lists.infradead.org;
	Sat, 15 Mar 2025 03:08:13 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZF5lR0N6jz501gV;
	Sat, 15 Mar 2025 11:08:03 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52F37wl5041226;
	Sat, 15 Mar 2025 11:07:58 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 11:08:00 +0800 (CST)
Date: Sat, 15 Mar 2025 11:08:00 +0800 (CST)
X-Zmail-TransId: 2afb67d4ef10249-a60fe
X-Mailer: Zmail v1.0
Message-ID: <20250315110800107off32dfmFxS4oTSqBr20T@zte.com.cn>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <james.smart@broadcom.com>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lLWZjOiBSZXBsYWNlIG5lc3RlZCBtaW4oKSB3aXRoIHNpbmdsZSBtaW4zKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 52F37wl5041226
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D4EF13.000/4ZF5lR0N6jz501gV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_200811_709935_04BF871B 
X-CRM114-Status: UNSURE (   9.10  )
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

From: FengWei <feng.wei8@zte.com.cn>

Use min3() macro instead of nesting min() to simplify the return
statement.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e..fbb11962894f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2858,7 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
-- 
2.25.1

