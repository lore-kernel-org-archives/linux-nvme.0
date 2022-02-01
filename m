Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA743C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZpyNf+L5zMk2ms7a1aAx+i6+b91a8Er9PIFNT1alKc=; b=nu+vOj1RITMGyqxhk74/wdtK7X
	iak/58eTwVFnPlOJx0h3WRUIoDIbB7RR9oKmAHVJKUyq3wM6sNsUWlIC4ZVMiAJKsRbeAr2SJlDHD
	MVJcnkrF2BGB0OEyxxEvUQIIl4j1BdbpvkbqEo2vYFuOm9FYZqqqnE+tB3AEU+1xMXgulosdkaKcm
	y1A4KTNTxQSvaJeSHVZS4nrsh3ywDeIYtsCoMcckrrd8lAnXY4gY3f/WXvGjgpOaf92b1VBNHQik8
	N5+1frtIPQoY78m5JlLN9GxW1yWPKDnFsjV1vVI9zAdBVkfW3MGZTJ0uxbPDxZM7nxaZQqklqEVzg
	ci1fQVfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyQK-00DT6N-V3; Tue, 01 Feb 2022 19:02:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPK-00DShC-VQ
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id ADC23B82F78;
 Tue,  1 Feb 2022 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683C7C340F1;
 Tue,  1 Feb 2022 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742097;
 bh=I5Ksu7TSv5OlmgMa0WaJLxD3mrYm2dJm/MON3Czbzb4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jQ82qm84m11Nng41jofXckgW27OfA/w2Hm4edQErKgZLb4z6UpZyBy+n5cVpzibpp
 Abi8XyCVEp2+PtlRd+6iNXAh9Yvs9mQjFJcnANc9zg/XJVm7BcFu60Ga68e0YiZ/Xi
 ngxXYR5CsuKYtPtG0lr+hvr5D+s5ZbFCe6/STaqkdtEnqyzdxPP5A3tk1sFZOuUdXv
 Cke9uxy8QG9Fm8Tkeyw+HUQdaPc+DoZvrdE0oQN/K5jfvjdm/3kWUQwA99uaUJqL5E
 6hczOpd6kOuAYY5gmz0QKjT1Wx5Vu0pixs4oHmuqrDS6Gzg49FiAJ4uNa03yKrfgMx
 bCm5frnH6HIgQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2 5/7] asm-generic: introduce be48 unaligned accessors
Date: Tue,  1 Feb 2022 11:01:26 -0800
Message-Id: <20220201190128.3075065-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110139_165887_0C4277EE 
X-CRM114-Status: GOOD (  10.77  )
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


