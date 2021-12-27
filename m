Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6F3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Dec 2021 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nv64gD+bKJT28ST3gvHJab/00Ty5R7cdCjVdZBd6Fkg=; b=DfoRbdAk3BJd+IwKBXbb4OVVkb
	yKE24hosjbQHuex7n/80IinKYlQi8X5eVCzaMKFZsmWwUZ160UgZe4j1IWHbWmfUQIFOjI8pYZrp8
	UNQqLBivQQshNjEj+ghJC54c2Jt8wb2nsiBNPBaLcYJpL4m3Pe+8miXecuiDLQn2kXAXf4hguKgSE
	fKjJwR0Fb/eAmajHSngc7/Viz63DkslZOgiZicGfZjzzLpoHOJ55IdWyOdTgmurd8OPnnSYdIORyt
	65weHB8+y460N8m0wGduUKsGZ3zv3igEv+cYm5aIkvXgbOwE/zmOBtnjejFxWxlB15TN5N0fMzrWj
	+VSlhGDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n1t4R-00H06Q-De; Mon, 27 Dec 2021 16:41:59 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1t4F-00H03w-OG
 for linux-nvme@lists.infradead.org; Mon, 27 Dec 2021 16:41:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 75D00B81022;
 Mon, 27 Dec 2021 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A9AC36AEA;
 Mon, 27 Dec 2021 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640623305;
 bh=NMZpTEU3icRfs1ElfRY3y8Ulxx03wQHJS6DyTS42Uyw=;
 h=From:To:Cc:Subject:Date:From;
 b=i0D2XQE/qSUFYTjLBn4G9SD5wz3NohQK9lEsHBk+E9FaMJhhUVwGiHZwT2UYw7kvF
 zlqenAJEFzfZdcUjuvA6bRkZz3Wd4hYYpNCQsgxUkgLm9R/j2inijXmbDUQr8ijRi+
 7V+nJUT65X8/umwVjqT/wtjbtFoYusbWDGpoZfeNWiTC+o30jRWRXZJw/2dEeExT3s
 939IiS7U8K4UMVZMLxhmIBQaImxGSG93yO+nyVgZTI9DCazvL86v669UDIN89mJ329
 g44aRtxGmzPXDcn41js8aj5+sBs0D72iTKo9YN4rKwB0o+16rCxeNqsw339d+ypZNt
 PV9nupABeqhhA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Date: Mon, 27 Dec 2021 08:41:36 -0800
Message-Id: <20211227164138.2488066-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211227_084147_944657_B99127A0 
X-CRM114-Status: UNSURE (   9.76  )
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

While iterating a list, a particular request may need to be removed for
special handling. Provide an iterator that can safely handle that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22746b2d6825..c4597ccdaf26 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1365,6 +1365,10 @@ struct io_comp_batch {
 #define rq_list_for_each(listptr, pos)			\
 	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
 
+#define rq_list_for_each_safe(listptr, pos, nxt)			\
+	for (pos = rq_list_peek((listptr)), nxt = rq_list_next(pos);	\
+		pos; pos = nxt, nxt = pos ? rq_list_next(pos) : NULL)
+
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
-- 
2.25.4


