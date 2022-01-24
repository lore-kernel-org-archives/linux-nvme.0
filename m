Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD784C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vuPHSjOe+4eAwQEcesLY+Wa7EOw2wMiJe0OhHdI7Mw=; b=XWuA3Mh/hIv0QplqcXeMT38HyL
	lEDcG0pCvovXD61kryH9bpuJgdpAd+QUCYnE1pWU6Gp8GyuhoYqY83EztQfe4dH/d2VHOV+aLZWW4
	jfzoHqSynCdzzeZfdRhKJMK4HiAtVk385wPzhRTxZPgPShUcn3r79yIUQNPzgwqxBBpJc0kDU7h9U
	Fh+kdrIO/8yVOQdsBjhWj0wLdmA7gG1Dp/V+d8GpSrhS6GBQi0eqyCGmBg8XOsejoXIYzi+6/SQJm
	gFZC8Py4EiGaCnq7kZx7KHq0lwwkjdAgaa4xSYMo8Q5Vdr+h0A4Mvv1ERGXuADg6JaHrUYBUf+J84
	45DdASQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC1nF-003tOX-4b; Mon, 24 Jan 2022 16:02:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC1mN-003t1w-HZ
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 16:01:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DCBC4614DD;
 Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA25C340E7;
 Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643040074;
 bh=waUMKxOwOX7w/rUT+A2WgjAk79dSTHbN24muCUOw6W0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bezbq5R5pHJsZl3GebLs3aNaqcDKjTd0HyVtc87lJC68avnZgEHV0dCuzzusQ4Dq9
 EB+Nnw/8MMqDUYhLnyZAGyY8TMiVtY0en9T0PCQiJsvzI1jXXDFy5I95SMCzEYnYoN
 rp4fOLQrJaS2FbvwVGdVnpIDqVH/jka4dvEXjz2VQ3wnfm4UYFrRkv25NXxulWes09
 q2snLSzNedTqLVB6X1Zi7rIOvZS4G8EyUKorFV7Wgokk+U5Acd1dZWHi4HaT6XU+pN
 3Kp7tzWh6E7BmNYqP5vRuBwU1Tv8dbJI+ekH3nhKZNrq/odBrDTd7bCNHIzAjoa5pk
 Qq6h5MSnaXUGQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 5/7] asm-generic: introduce be48 unaligned accessors
Date: Mon, 24 Jan 2022 08:01:05 -0800
Message-Id: <20220124160107.1683901-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_080115_645247_8838D1CF 
X-CRM114-Status: GOOD (  10.55  )
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

The NVMe protocol extended data integrity fields with unaligned 48-bit
reference tags. Provide some helper accessors in preparation for these.

Cc: Arnd Bergmann <arnd@arndb.de>
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


