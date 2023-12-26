Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFAAC46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2SJCZR+xXfrrkW69Q+Jwl1q21+9m2/dJjz4Vg7Bqch4=; b=hNoYVnCa4QJFx5V/OV/qTdRRw4
	IyBhoGhd0lrPRV9Alc/1eEkFYi8mgOX+lmzV+CgmyVQ4a/dhKYj4buT5+oiIe5y64Bm4DUWl7Bm9e
	VId9DIVDPe64LvEpguSeZQ4LpUJKvchGLsPcSSeKwIHUqroQAIzBMhbO359YqXvcTc9QmhQhi2O6X
	hoXxTn6NjCZqmKbVs4Fxs0n+lZLv6DQCf28VU1PbT9oAFTQ3QeRoxsbI3gUQ5CVqJcRC/bDImUwwM
	ZccpCJzNwI9kf1PwdJTVJzXWXpxpYDiN6B1dEkd2to4HwI0qGutGOxJ5Lr8EndNrFQCHvtslIcChu
	0qwqMvWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI2ZJ-00BtDH-0V;
	Tue, 26 Dec 2023 08:13:41 +0000
Received: from 213-147-167-40.nat.highway.webapn.at ([213.147.167.40] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI2ZC-00BtD3-0e;
	Tue, 26 Dec 2023 08:13:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kch@nvidia.com
Cc: kbusch@kernel.org,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-tcp: fix a missing endianess conversion in nvmet_tcp_try_peek_pdu
Date: Tue, 26 Dec 2023 08:13:29 +0000
Message-Id: <20231226081329.180017-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

No, a __le32 cast doesn't magically byteswap on big-endian systems..

Fixes: 70525e5d82f6 ("nvmet-tcp: peek icreq before starting TLS")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4cc27856aa8fef..edf3b3d54a9330 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1768,7 +1768,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		 (int)sizeof(struct nvme_tcp_icreq_pdu));
 	if (hdr->type == nvme_tcp_icreq &&
 	    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
-	    hdr->plen == (__le32)sizeof(struct nvme_tcp_icreq_pdu)) {
+	    hdr->plen == cpu_to_le32(sizeof(struct nvme_tcp_icreq_pdu))) {
 		pr_debug("queue %d: icreq detected\n",
 			 queue->idx);
 		return len;
-- 
2.39.2


