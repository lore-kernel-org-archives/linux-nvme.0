Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BC4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24IAngo+bD2HSBUlrO4nERVRbQ2t0uWM5QNfYLmPjKE=; b=J9Gzio1zuYpkHvPICO8yUg/lbi
	dUwwKUlAC+CuM2J3emKTjlCEGDbML0huxJnS8qh1G7DzoSqUpe2n4ifaEkhARUgHNq5vHhGdilClX
	hdc68K8o0UVJrkG0nmIBAAyur+1NSypFgKbtoHyjALAZLEb9N4BW9eArSQICUhPQfPchtoZcoLQa5
	mSwFIx/XQJoRLuPClo5UuedXNAML47J4GOq7uF2prjV+mzg1NVsRJ/YX+1o4BwF1WwivOi/2uUMT6
	lNyoSe+FA8A64BNm751wcPEvlZCeUq02JpdIe+DIE/q/Ypvt+XiXDMKBnO371IAs8JrQ27Xz8V02Q
	ipHfmIUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPrpa-007fR5-Up; Thu, 03 Mar 2022 20:13:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPrpA-007fEf-J7
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:13:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C41061CAF;
 Thu,  3 Mar 2022 20:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B94C340EF;
 Thu,  3 Mar 2022 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646338399;
 bh=uwWraMZ+5Vaez+GGmc7m6MVYPejhXxGHYaXXvWLHTok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SqDpKXEnnVm1pcu9Vb7UDMyyjjnqmmM6a0nP8DBYapDyPZ3nSkxMqppRg/VmAb7DQ
 9/B5lJjOf9n8PKVlJwtZb0odjITWc1ixslPWHwXFhGYyeo4sERjsGZtBmpOyp67W9r
 S+gV+4bsSWPexz+2SpdWxxXMUjx5YqRRdkqeTRoexl0gm9YOF18Qj2R7WKiC0E26AZ
 M1mvuHsjXLZkfXEuX0ZB8bsBFsw7BPDYTOqjf0T13e4fUjXBr1M90vJ6bwjIKgJ/Sd
 XAfSwD21vt1cp4tSY6V4p1oj81Sg4YW0I3xytSy1WkcG1MhW5TlNO29VjVPmjG+psa
 SRom+IVOSdFKA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Date: Thu,  3 Mar 2022 12:13:07 -0800
Message-Id: <20220303201312.3255347-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_121320_688127_6AC3A16D 
X-CRM114-Status: GOOD (  11.17  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


