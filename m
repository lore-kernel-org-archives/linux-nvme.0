Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F2CC47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3E+YI20/9FxILYIDuFJMbdKgt/K4xZrFGqP/LjG7SU=; b=nqIpqqetMnDPQ6LTsvuSnG7g9n
	ySIazsWPLkRQXeXXUq0LwxNYQNCrMyOy3NtUGIEY02iF5jdz/5V0gKA8pDp04RiCo8bdBOPAwTSjh
	3Cay/+Ti/Sl76bFqebijXxhMh/E66sUCaaGE0T1Nc29oQ1/83keG+NbRZlIJX340PO+v3XB6tuyH+
	xonji1EhhHb/C4TWSkIsruCv88c70LeBJbGUJTV9kiaf6bz+P91D1+cySanUsGBG8YBIte0lLIGG8
	dC8biEd/fsr9mPzz36xVEnInia9Or/xsYB+r+UPUFwyl+KIhCygHlBxlf0ZRSMnSMLacwFa6k7641
	i9VU2upg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8oe-000000036rO-3dpc;
	Wed, 31 Jan 2024 11:31:40 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6eC-00000002MqF-46MS
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 09:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706692361; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j3E+YI20/9FxILYIDuFJMbdKgt/K4xZrFGqP/LjG7SU=;
	b=bBAU9gUw6qrErvAA6W+rZ7tZLEVWJS7h9cFtwL8y6wYwskQ8NsVja56Hkjgr3bxjDRtOC01sEXZYO04uuCWckEmS5pNOitD4GZuu+AKc+4Jtw9zA5RywbUhIdUF19V0NRM5Ul0dcLpPX9hVqCEMXtdKqHNtuyhhNPTBNcnot3uM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.iyaJo_1706692356;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.iyaJo_1706692356)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 17:12:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/3] nvme: parse format command's lbafu when tracing
Date: Wed, 31 Jan 2024 17:12:22 +0800
Message-ID: <20240131091222.116190-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131091222.116190-1-kanie@linux.alibaba.com>
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_011245_196150_668DD512 
X-CRM114-Status: GOOD (  10.20  )
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

Add the parse of format command's lbafu to calculate lbaf.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 4b8924abb4e1..7b752ee47f36 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -119,7 +119,10 @@ static const char *nvme_trace_get_lba_status(struct trace_seq *p,
 static const char *nvme_trace_admin_format_nvm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	u8 lbaf = cdw10[0] & 0xF;
+	/*
+	 * lbafu(bit 13:12) is already in the upper 4 bits, lbafl: bit 03:00.
+	 */
+	u8 lbaf = (cdw10[1] & 0x30) | (cdw10[0] & 0xF);
 	u8 mset = (cdw10[0] >> 4) & 0x1;
 	u8 pi = (cdw10[0] >> 5) & 0x7;
 	u8 pil = cdw10[1] & 0x1;
-- 
2.43.0


