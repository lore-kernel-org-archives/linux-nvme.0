Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641DAC4828D
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Hpa69UtNasj9GNrnbVsnkUtB1qdHMeQs8dfjG870qE=; b=4bDebekMM0uMLXsMvycC/PmhrT
	1X7yBJ2Nz3JJHBSwbtSJa0p2u1NXYL8RmFzb/iOGy9uLEfue+RaeAyq+FMDm6ccmZlh3z7qCZlFIz
	w8ybJARBPecO2g8+5wD+JgLAobSZ2bMcp9xnMNoMsx0lWSjtCyKeiUpObAZNg8qLenk7qIhqm9OMP
	MgOl/mCqhtK+beSaRr2gHqx5ZFvYlY5xutrY/KEbzdnDvrCCBc8DITUwG3IDP1Qk+M8QD3HJQUiHJ
	cgpDU0QIC/Kf6YuzJOUVbaLh33PajVfzx0vgIEbteDDeoGc0YJMiFUFoS4Ctx3+BgMJ3RxMwXLnWJ
	4GVRRbyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7eA-00000002j2o-1cOP;
	Wed, 31 Jan 2024 10:16:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6eT-00000002Myk-0pTU
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 09:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4Hpa69UtNasj9GNrnbVsnkUtB1qdHMeQs8dfjG870qE=; b=HMkYDkW2G+JTvIPWMV6zyZZe8X
	JdZw3aMFvM+im5Tx7VW9sSzHOOCX2zHPVZVcdyKi5xsM5tev7aTB+w1PdaRxwl17ncTYzqGzZoZJE
	nYZ47lXUbFP9zy5lhZL74072ken+cQkLPNxw1qz/Nrx8+/Wyw9+/5VITI9tm3YW4PuAY/RUzHLeA2
	b1op1fmYEcrEd6hu5R1QepQJSVT40mGM/Umimrv2r20G8pUNdUSiNpkFIvLeymzXyrn3GKt7at1/T
	oCLkZEV4OXvbZ4GWCinWtQ2EEh2pk3yTrUGwFmKuOdOMDqMwVwOhiccGo3ZH7wUKE80nihGkRcVz7
	K4h/QY6Q==;
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6eH-00000008tZS-0Aji
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 09:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706692356; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4Hpa69UtNasj9GNrnbVsnkUtB1qdHMeQs8dfjG870qE=;
	b=nm5LZ+qZWFVqI0JjEIhQsWeDAsfbMByoV0apa/BB3Ox6KmGU0bkcqpZaDQZX2C/ckZ2IDMfCO8Bfg0PcinvxM+zo5p0ISXjDGdF2ZZEq46Hh5iOeBPRZIyVDY3xQJhREvJ72g0lL9IgzwZ68fI27GhnCuAMCzXJFi62bjSA9RKE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.ixUFT_1706692351;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.ixUFT_1706692351)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 17:12:36 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/3] nvme: parse dsm command's attr deallocate when tracing
Date: Wed, 31 Jan 2024 17:12:21 +0800
Message-ID: <20240131091222.116190-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131091222.116190-1-kanie@linux.alibaba.com>
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_091251_697821_056D27D6 
X-CRM114-Status: UNSURE (   8.38  )
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

Add parse of dsm command's attr deallocate to make the trace log
more consistent and human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 95572c85b22a..4b8924abb4e1 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -153,10 +153,10 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
+	u8 nr = cdw10[0];
+	u8 ad = (cdw10[4] >> 2) & 0x1;
 
-	trace_seq_printf(p, "nr=%u, attributes=%u",
-			 get_unaligned_le32(cdw10),
-			 get_unaligned_le32(cdw10 + 4));
+	trace_seq_printf(p, "nr=%u, ad=%u", nr, ad);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.43.0


