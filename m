Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F4C3ABC3
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Px8B7BYCvCW579cNy41LRy9+L0/LQjhznnTSVJnvXbk=; b=sG3gHdOo6o3NS2O97RSMYDA1XT
	UGrAxjbv6l8XmxFiJ7ajCC/jGCwzuJ7Z/OKKNxm7ltdIpRBObsBwkEb0N/gMdKbqCla8i/78f9Aes
	ljV3SDmFBBPvcmpfAF7hDo9j0fgjw6qcdc1F5XcHSzcgdw5NCO62PRVZibg4iOWqjv6tsfUFQKSlc
	AEJZ2rObx7yxwK2IA870NL/O/G072/R/UbnATaaX0Y3P6oYOA1hhVoC/cOtLlLrEw1gEnkYt/R3IU
	SRiES3BLxxca8tQuv93Hw4zNTqwyC36q6pSq4I1IhgE8x5IMoFhpxSK1TrzlMsfTy3e83tn8zdHjq
	Ouv9NhgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul9-00000006Xbd-2K7M;
	Sun, 11 May 2025 00:41:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul3-00000006XXY-0Ovq
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 274C14A874;
	Sun, 11 May 2025 00:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3EDC4CEEF;
	Sun, 11 May 2025 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924092;
	bh=dQ3McGhqu8bezBUWJWiJB1iEsbKs9gFTYUnJ6baxEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa7T7OxnnKAOtnHbW67Yh3SN6VEFAghG5iuSecCjaRjWK2H5ZFnqd3ruXmX1WCyPj
	 lMGthlluCIWNDUYdw8q/r4ByWc+TU+nj/oVY0GvbUT8XmBr/Gh8OYwcGF1QzHPlXFI
	 RDaackghdGL9dFfrsqWe9NGfMk//qkLqMk1/UGCTqlIXPt7H3DpmtQqS/4uT2bZlr8
	 rR1BreDqMu+yp9bSA0rtgY/IDR9iPUBpoNV5AhN/RaYk9lk3ajZJWWQq0N3VIdBV17
	 YFQd37j3IMwjX3/cZkWZvCi4PNEJ5rwtSSo72l6hVio6ufFY3Rk+EXMMvad4l7chNY
	 964mQbVB+pA5Q==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH net-next 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
Date: Sat, 10 May 2025 17:41:03 -0700
Message-ID: <20250511004110.145171-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174133_152817_6B4253DA 
X-CRM114-Status: UNSURE (   9.89  )
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

From: Eric Biggers <ebiggers@google.com>

Instead of calling __skb_checksum() with a skb_checksum_ops struct that
does CRC32C, just call the new function skb_crc32c().  This is faster
and simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/core/dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 51606b2d17bb..1eda2501f07b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3595,11 +3595,11 @@ int skb_checksum_help(struct sk_buff *skb)
 EXPORT_SYMBOL(skb_checksum_help);
 
 #ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
-	__le32 crc32c_csum;
+	u32 crc;
 	int ret = 0, offset, start;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		goto out;
 
@@ -3623,14 +3623,12 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 
 	ret = skb_ensure_writable(skb, offset + sizeof(__le32));
 	if (ret)
 		goto out;
 
-	crc32c_csum = cpu_to_le32(~__skb_checksum(skb, start,
-						  skb->len - start, ~(__u32)0,
-						  crc32c_csum_stub));
-	*(__le32 *)(skb->data + offset) = crc32c_csum;
+	crc = ~skb_crc32c(skb, start, skb->len - start, ~0);
+	*(__le32 *)(skb->data + offset) = cpu_to_le32(crc);
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_crc32c_csum_help);
-- 
2.49.0


