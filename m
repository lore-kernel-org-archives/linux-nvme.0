Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23667C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:50:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD27E64E75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD27E64E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K37yRvoE+TffioAA0OGHYtzEpbFmX10sti0JTKfG+1I=; b=nTRrKAHZ+h2gFiHIQrnwUysqcy
	R0YenndpEC9WISQZDIgDlU0Nz3WITwTKbKqtYE4HXMjpOZ/za9Lxfx7TSmSJZz6zvP2PLykMKNLq/
	PLnumUbkXmWlpqbIlljlp5fzV9Gf3kffoR873UWVeElfrvaSAWd2qyqqpj4Odit+eRLSNj+8yI1VC
	uj9ilxOJq+26xx8SU8YtG8+ubUkwgy8i6UtlnHSoNCPX1oDTbpikCjReLkeLb/2Z0VC0OrNECG9nU
	l8V2pr7LQ5KZEhOOj+la2abc37ySWMu159gqmmrmPZapg0E+lUxKNGw0xeYyjAaZOmrqYsZ941Oja
	gZcPolSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l877J-0004Hx-AW; Fri, 05 Feb 2021 19:50:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l877G-0004HW-VY
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 19:50:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8D2D64FB7;
 Fri,  5 Feb 2021 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612554605;
 bh=VpC+Bg5C8z0Vic6LE9Y/yVktqj5Y3k4XdZobPw5+Czg=;
 h=From:To:Cc:Subject:Date:From;
 b=Dmzhmv6+8+Pm6ng5anegtA0qgiCwIGrs9VIPbyNLHSGy/xKOuBA2/ZivuiszVstDD
 sg+IUBBluyF+Be/FSdO6Vb2UN3X4T9WPXOKZZqsLnpLwugdxiFnGGZN2V21Z18pcZb
 sR1B+MyL5ymGw2/9sivu9CpKrG+WhtPFYh9d+E98I8Cv6HdFTw4Aa0ChOGmnsWXi/v
 VSj9egCCIZOgx2ghcOKDS161+Sr0IeAAkXYYVDGLPKBZ1AIGQvFR1F9lvy45yw4sNw
 bgHGebdmEdgEJc7UomMyooqz9l6mdKvJp1SDtQ4Cw3UE+wFaRMLqjkzKPP/6ZIEj/z
 Iw3/y7RNG2niw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Date: Fri,  5 Feb 2021 11:50:02 -0800
Message-Id: <20210205195002.2657209-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_145007_079493_D9FB55B8 
X-CRM114-Status: UNSURE (   8.51  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The bio based drivers only require the request_queue's nr_zones is set,
so set this field in the head if the namespace path is zoned.

Reported-by: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/multipath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1427c9555cef..a1d476e1ac02 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -677,6 +677,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
 				   ns->head->disk->queue);
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
+		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
+#endif
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
