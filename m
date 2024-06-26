Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD5EC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7I5XpcvsRoj6UlqpryyIPgKEDrlNW2cI8kXf4Q53ZUU=; b=BXHvS99VoWCxunJy1PayVy9b8u
	vJrPzeWI9bcsz15YqI0L6/CIbkskozjmBo4O3kxiMXodL9KYTmVmonIfIejmRR1X6GI5EzUEArSh+
	UXsSBT5E7aDbMIFjmRYudRP2gleLRbH7eewXdT5PK9kGzEbnqsQ8cG2MdIrMOLpfdiC0vQxHr1G6G
	/Q2lLXBxyDeh/4+7l6AJ6I9tcav9Tih42H8BXPQSkjTLIa7aci8WtTf7P7KFgEQQz7IvTNprUL+TJ
	qtvqWk1t+cbj9yMcjFLUv1Fx8TQ2BdJ6cYYpeVL/ZgwSAmQgokMGMASqzfxN8xfdEn3lp3zQJkz7a
	E6VlwQmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXM-00000006hWL-0KQz;
	Wed, 26 Jun 2024 12:14:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXF-00000006hTV-03Ut
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1982D619F4;
	Wed, 26 Jun 2024 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E52C4AF07;
	Wed, 26 Jun 2024 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404039;
	bh=k5Pd+R/mOhrnSfy6MNw59nKeG7MBZwDOk/dZSp5+Um0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLX2GnGnrCJXHPc9sIWdmwAPtaCrnvGeOtTa+1OaIxPPMKqYDNh1bOFu8oXNcFy7n
	 1Z1/7qEdUOB58cH/wqe7/XL19r2PS5IHfcdIYvZsAnNueskb9zL6tShS0Bwha54ElO
	 +XBaAK4+vOC7WBbclpEHhs+TL25du0u+xOA0jAO6gQa5TLzqGrJGiKqszGLJ38riUV
	 Tn8+gsiv55RUpuG9B5OoUntPUEdpESB5MaEl1LTNokuSL12cj3xMG3YmT79Goewmc4
	 QXqsyo7S1gpPtvuyAZ1uTAUmPS1iJAjmfVA6LfolWu701Bm2rLPmv+isXO45oBUdEr
	 gYTBurujusecg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/7] net: micro-optimize skb_datagram_iter
Date: Wed, 26 Jun 2024 14:13:43 +0200
Message-Id: <20240626121347.1116-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051401_236978_C8E6F75C 
X-CRM114-Status: GOOD (  13.37  )
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

From: Sagi Grimberg <sagi@grimberg.me>

We only use the mapping in a single context in a short and contained scope,
so kmap_local_page is sufficient and cheaper. This will also allow
skb_datagram_iter to be called from softirq context.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 net/core/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e614cfd8e14a..95f242591fd2 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -417,14 +417,14 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
 			struct page *page = skb_frag_page(frag);
-			u8 *vaddr = kmap(page);
+			u8 *vaddr = kmap_local_page(page);
 
 			if (copy > len)
 				copy = len;
 			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + skb_frag_off(frag) + offset - start,
 					copy, data, to);
-			kunmap(page);
+			kunmap_local(vaddr);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.35.3


