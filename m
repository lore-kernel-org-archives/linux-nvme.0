Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBE8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=og/Ct2QWBY5AtdonvNUKN8lZhwb7jCOsRzP2yu3cDPs=; b=DrfQ+t6zQkSVJWFjqIZ54Y0QQ9
	QPzK+I8f5Z8buXhokEx+bIwnLTQTR1KTZX67t2LI3oqrpEA6rsATPx0Y2CFKc6KmymutexeaI6BcJ
	HeLJj1m+KhT+Po32wMy8wqsrv41bmc1nhRzPhqPVBv+CO6jN1BigqG3kh6GxoSj6fyJvqlaLmjjv3
	RsB45KbRFN+NwDl0/gaQVMpU+hRH3Lv32ra/TSYzV+E6zH1ArOx0NWJs3DnJvMfcogzw7Aas25l7C
	Hx9QhNIu1fu+CCn2PDbT3TAO3ikcAKbIt3mn2yxAICC6h9fm87fUbKKnq50woC5Y/0BUzGawZYjgE
	8tse03mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK0GT-003WY0-1m; Tue, 15 Feb 2022 16:01:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJztJ-003LCW-NQ
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:37:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2701161694;
 Tue, 15 Feb 2022 15:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E4CC340ED;
 Tue, 15 Feb 2022 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644939440;
 bh=i2xSXFG6LVaf+fT/X3b4DH34J4VBpJKMOyJDnY+S3W4=;
 h=From:To:Cc:Subject:Date:From;
 b=jsqLzFyzopKHXIudfLE/b4aWOsAzgVG6n0SNeeTKj80/Sze72VjnFvBfPKbV7ij3H
 rDGIyCiNUuQNA25zt0D8JWxB8c23GgJIB5DBSjC6tw/U+wloD8kKLypPeMIo29mm2N
 FdTe13RAdeLEaki4zCnzV+OvpCdDT5+9BQ60Gw3kelK6AozmDSnEk82rPwlByJhrvc
 PL/bkwNrBLyNaO3LwJZdnyb8gi1IQu7Ox0I2PUjRwGpRDKfTu+IBTHZFydJCFiGbUu
 q3FuM9Ra6IAoebQ9hWuPj7UvGo+j21iNxmbob8jOHWSxCHGUZbaYf5l0EAHcmMYDkD
 kvxsJuFkDj8iQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: remove nssa from struct nvme_ctrl
Date: Tue, 15 Feb 2022 07:37:19 -0800
Message-Id: <20220215153719.1934484-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_073721_860354_902B9659 
X-CRM114-Status: GOOD (  15.29  )
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

The reported number of streams is not used outside the function that
gets it, so no need to stash it in the controller structure. Use a local
variable instead.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 9 +++++----
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fda837ce67ce..7d5e8b6f7d46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -758,6 +758,7 @@ static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
 static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 {
 	struct streams_directive_params s;
+	u16 nssa;
 	int ret;
 
 	if (!(ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
@@ -773,16 +774,16 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	if (ret)
 		goto out_disable_stream;
 
-	ctrl->nssa = le16_to_cpu(s.nssa);
-	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
+	nssa = le16_to_cpu(s.nssa);
+	if (nssa < BLK_MAX_WRITE_HINTS - 1) {
 		dev_info(ctrl->device, "too few streams (%u) available\n",
-					ctrl->nssa);
+					nssa);
 		/* this condition is not an error: streams are optional */
 		ret = 0;
 		goto out_disable_stream;
 	}
 
-	ctrl->nr_streams = min_t(u16, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
+	ctrl->nr_streams = min_t(u16, nssa, BLK_MAX_WRITE_HINTS - 1);
 	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
 	return 0;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..69796f96dc8c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,7 +280,6 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
-	u16 nssa;
 	u16 nr_streams;
 	u16 sqsize;
 	u32 max_namespaces;
-- 
2.25.4


