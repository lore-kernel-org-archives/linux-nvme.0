Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA0C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smUK96GfHNhW4nnEQrMriqXUm6CLT/nreQ76GHs/vIM=; b=aPxzNsy1YxIWBGGGBUdLPEYS6p
	tLofzqfvIwbK5FLPUGwu/qlYvwLBDpqNMDNz78SPnomBeJC6xJVR90sT3nq/LkUpelcir0qAQtZjt
	w1x4oqA4BgQKIPFgfS7n+TN9uI1Hd8573CxNK70g7fCWVouKIZi0VCk6aIK1yKt7bqMIPHYZ6wY8d
	seHHVTIzYFLOGzjOe3Hjdy+m2Rnjj0/tDQtgHZ8YtIVrvK1gYV4N2zTiy4YnLiWLxG1bpV4z3RiUB
	q8FqjKOGBJZgz3QlNw+ClblqSVTTL5RfhLh66C9voxfv4B+F+yoCcKb1py9wdl+NwElBtPzoFOv/C
	4SdgeC8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMvK-0000000Bkni-0r3v;
	Mon, 29 Jan 2024 08:23:22 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMvH-0000000BkmD-2Haa
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 08:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706516597; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=smUK96GfHNhW4nnEQrMriqXUm6CLT/nreQ76GHs/vIM=;
	b=bDs0vvXGZHhjYEx+5k05wuYIZgGFDQgkWpi5YyFtK5h5BlF0ab+iMZBtY4A/44DpFDAQ3cu1PZx+bfZVy3ki7/yz6gQWx/p4zNOtFUuVteuukomL3REcX1iKCgXOwfhiy3Irv9MJzLah/MNYF+35L5L3SWGDkRBRhpj+rA/ILis=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.YTt4u_1706516591;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.YTt4u_1706516591)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 16:23:16 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: parse format command's lbafu when tracing
Date: Mon, 29 Jan 2024 16:22:56 +0800
Message-ID: <20240129082256.63239-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129082256.63239-1-kanie@linux.alibaba.com>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_002319_847079_C2077154 
X-CRM114-Status: UNSURE (   8.13  )
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

Add the parse of format command's lbafu to calculate lbaf.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index b383d51c1a0c..3ccb33646794 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -119,7 +119,9 @@ static const char *nvme_trace_get_lba_status(struct trace_seq *p,
 static const char *nvme_trace_admin_format_nvm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	u8 lbaf = cdw10[0] & 0xF;
+	u8 lbafl = cdw10[0] & 0xF;
+	u8 lbafu = (cdw10[1] >> 4) & 0x3;
+	u8 lbaf = (lbafu << 4) | lbafl;
 	u8 mset = (cdw10[0] >> 4) & 0x1;
 	u8 pi = (cdw10[0] >> 5) & 0x7;
 	u8 pil = cdw10[1] & 0x1;
-- 
2.43.0


