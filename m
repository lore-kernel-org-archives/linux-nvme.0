Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF0AC48285
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3E+YI20/9FxILYIDuFJMbdKgt/K4xZrFGqP/LjG7SU=; b=V1XPFguhIsv82vG780/3tqMQtQ
	k1kGatzhdwKgTkxVcDb7sUiiuJnpki+sKkixCNQgWqg0m8ORSIz+sam1FS0GMo8jNAPYJmeq1kDoa
	NIWNUoyVG38q93XOK6vEb5FSIv+Sq70YWINbXgD1pX8DxXArMjfHuYxKYvZIEuD4Nw5pNvz28C8ZT
	NQ2zinx7/DLctz/yjyk6JeHMvQ5rdqddbgsRs1B40KaOJ6U5wEcBXb4JefF+1M0s16Ijm4yDLD+9/
	Phl5GOI+XQMf7MWTXFPG/uXuRc83mOoZwIXG5Yh05KyV+O0q+qnY+Dr6cPQ0trLNvwNOilNx0X5zo
	hQegsEKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmOK-0000000GTEo-082I;
	Tue, 30 Jan 2024 11:35:00 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmO0-0000000GT1o-0fS5
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:34:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614474; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j3E+YI20/9FxILYIDuFJMbdKgt/K4xZrFGqP/LjG7SU=;
	b=CImEYaafRPSPBy+N+s6pFdFfuNJb/FwfgqfF5UmlbE/yVs4qD+kf4swI8AEF4FVysMubt1U+fPGgRMr+Yxpnc4GQRplMW0UQBBvzxUU3faiMqRwuFh98ORT8SAqQPL+ObO+LIKxbA9itVWM7hNk5qpvAVvxl4RaRot4vHerv9xk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.g4tuC_1706614464;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.g4tuC_1706614464)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:34:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/3] nvme: parse format command's lbafu when tracing
Date: Tue, 30 Jan 2024 19:34:06 +0800
Message-ID: <20240130113406.8414-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130113406.8414-1-kanie@linux.alibaba.com>
References: <20240130113406.8414-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_033440_403066_8A3CA081 
X-CRM114-Status: GOOD (  10.06  )
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


