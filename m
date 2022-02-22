Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kEE4KruJzHqjvNB2cbLiWEdnzqFge898O/8Z2Y7FxP8=; b=1JBg1DS0sC2L3nx1/bqxdLtkik
	pyNeDoRwJexTCJs2pYBFGzL26gpd+NajnWzvN4lG+aR5us4XSqsqo1iycx40II3J5YnkxNjqsHH1O
	P2tp1xje8a9+cgE94WAhcVNb7k62X1Yf1C7oS4FFNHIzNnH8lKdR/kJu/VEhY3uYG0I2AfWzDFu0+
	nItktCarydGqYZWwLjKG37ojoQkRynLLDX9vES6SmNmBMJLU5mBbIecO0WzwIMI2P23oCTz1KsD8x
	bFjKXG/Mv4Lj6laZRt9FDYQSueBxzLq+K07P4p453nsuy90fBYf+3/jZ0NRuYyvQ5M/kvgsdxHAIE
	S5AF+0xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMY81-00AfM5-G6; Tue, 22 Feb 2022 16:35:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMY5O-00Adpj-Va
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:32:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF3E60AE7;
 Tue, 22 Feb 2022 16:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B68C36AE2;
 Tue, 22 Feb 2022 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645547542;
 bh=MB+r43dHRQMNdHaSJDC4o0kmCFx0xqnueQmd65wbpGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XlZupw4ZY2oOYsUOkYHoTFbN8+l6bNfE7kmstGFv7bqhAUWzu4IUm4/f1aD2TL8OH
 VXMLQq/+Mww0HTf9KVkjd91K0hvk3SR+O5zYSx2XlLZV4s01yoKcBMRxKIavFnT9Zt
 rdsq8t7+CheArB5z99foKVy/uLcPOnFrslQN89TciB6tM0i/CIAhiMfgDc+uwnON3A
 wrVSqtPDpwRqP3nH201SzpRKUalKqXIyxbBJh16VA8s0rXtXy51Q+QiOXN/wVvXzWo
 Wffd8XVxl2qxl/FqLlu2oMtqJ1DMcC3QGGWehCKtiKYJqkPQank7vkSOebzd8axVbw
 82jondGoqs4MA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Date: Tue, 22 Feb 2022 08:31:37 -0800
Message-Id: <20220222163144.1782447-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_083223_127974_AC4D47B3 
X-CRM114-Status: GOOD (  10.81  )
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

The NVMe protocol extended the data integrity fields with unaligned
48-bit reference tags. Provide some helper accessors in
preparation for these.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/asm-generic/unaligned.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..8fc637379899 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -126,4 +126,30 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 	__put_unaligned_le24(val, p);
 }
 
+static inline void __put_unaligned_be48(const u64 val, __u8 *p)
+{
+	*p++ = val >> 40;
+	*p++ = val >> 32;
+	*p++ = val >> 24;
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void put_unaligned_be48(const u64 val, void *p)
+{
+	__put_unaligned_be48(val, p);
+}
+
+static inline u64 __get_unaligned_be48(const u8 *p)
+{
+	return (u64)p[0] << 40 | (u64)p[1] << 32 | p[2] << 24 |
+		p[3] << 16 | p[4] << 8 | p[5];
+}
+
+static inline u64 get_unaligned_be48(const void *p)
+{
+	return __get_unaligned_be48(p);
+}
+
 #endif /* __ASM_GENERIC_UNALIGNED_H */
-- 
2.25.4


