Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE29DC47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLUgc2Y0j4HOXBp6u1+lHTxi5ZEQgRPTipjdBQLwt6U=; b=SUeHt1C6zkExkjLxAJ4FkHDc/A
	z5ksvMtDSgUd3oQWZRy18i4OsqzAvIr3xQvaFiME3PCkbzthe2OC6MYCHC14Ji52REMOb6UssIXFx
	eUVvmDcg/LPmKporqLXMHipshUqGWVMCFjwAYxN9Bt49l23x9fHc4PN5jFlaK4Qmw1ariaiN7No4c
	6sYMb07HznTKnpQediQKTNfKQYuDJ6tBEBrC2nMnReaDDTp1emvmqsQGQeWi/4t/fNeOezGQ7Of6+
	82Faz/JKi61QL1r7z3aE8qC7oX+oXNzzJc9ZrygJgknDK8kndFA+nmtzs6tORjYxQwOiVZrR3jWg8
	cZkVbhcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmNs-0000000GSzu-0VQP;
	Tue, 30 Jan 2024 11:34:32 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmNj-0000000GStZ-3HXN
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614461; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eLUgc2Y0j4HOXBp6u1+lHTxi5ZEQgRPTipjdBQLwt6U=;
	b=xe+JAmF8+1hUU2l2YpMlnnOF7TtnCHwNpYPDDMgLz6G5ttr2XfNeh28AC7YP0WOQUhhggaz297sTNxJmM1jxkwwBwRJ2LkZP/Jji0foScMrgF9smXYIX/1hU/ci4nlQhDIILmC45KlbLGjBHYs4g4Ssa0/+wvvx3/OYXLv2JOzI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.g6-zT_1706614455;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.g6-zT_1706614455)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:34:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Date: Tue, 30 Jan 2024 19:34:04 +0800
Message-ID: <20240130113406.8414-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130113406.8414-1-kanie@linux.alibaba.com>
References: <20240130113406.8414-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_033424_308517_66DEC80A 
X-CRM114-Status: UNSURE (   8.11  )
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

Add detailed parse of dsm command to make the trace log more
consistent and human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 95572c85b22a..b383d51c1a0c 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -153,10 +153,12 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
+	u8 nr = cdw10[0];
+	u8 idr = cdw10[4] & 0x1;
+	u8 idw = (cdw10[4] >> 1) & 0x1;
+	u8 ad = (cdw10[4] >> 2) & 0x1;
 
-	trace_seq_printf(p, "nr=%u, attributes=%u",
-			 get_unaligned_le32(cdw10),
-			 get_unaligned_le32(cdw10 + 4));
+	trace_seq_printf(p, "nr=%u, idr=%u, idw=%u, ad=%u", nr, idr, idw, ad);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.43.0


