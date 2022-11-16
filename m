Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F1C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoZA1ds+nSlUQELDnijHztRk8OszhLqYcwDjQ/V3moA=; b=3jmEpjnzQRnEeymZu1nDSQDZH1
	qUMj4Xxv7IPzeCP+Dw7FxqDYVnA5WXZg0L4lA0t7ol45EHDUyqPrJu0Oa0C847hWTqV4N1iwU4Wk8
	7JJ6PckVoj4SBH8GtT3aXxs7rwB4ScuGKIkJJqrEls1Y0GRY1qU0NikjLcCkPa5sdgA8hx+fWTmh2
	wfuah2YqH3pBt6nUeLu/e0ec29JaG5JEdetS90li+1ourfgYEQ0CFeJ9EailXADeJaPr86qSeHuSC
	C9mIKjVoNavOmdapKoZWMEDj2bk8LDOqKVoe45WlVx3avXzUTKa/3Y5TKQvHZL3VYAh9LyEfI2s98
	orUM81hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2Y-003dnG-EL; Wed, 16 Nov 2022 13:01:18 +0000
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2U-003dlm-K4; Wed, 16 Nov 2022 13:01:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: don't allow user space to send fabrics commands
Date: Wed, 16 Nov 2022 14:01:02 +0100
Message-Id: <20221116130104.2186334-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
References: <20221116130104.2186334-1-hch@lst.de>
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

Fabrics command are used to set up and control the NVMe over Fabrics
connection.  We can't let user space programs interfer with that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9a2f0f5ccef57..badbc55d29350 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -11,15 +11,29 @@
 static int nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		fmode_t mode)
 {
+	/*
+	 * Do not allow anyone to send vendor fabrics commands as they are
+	 * used to manage the fabrics transports and we can't let user space
+	 * processes interfere with that.
+	 */
+	if (c->common.opcode == nvme_fabrics_command) {
+		dev_warn_ratelimited(ns->ctrl->device,
+			"rejecting passthrough of fabrics command 0x%x by %s\n",
+			c->common.opcode, current->comm);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allow privileged processes to pass through any other command.
+	 */
 	if (capable(CAP_SYS_ADMIN))
 		return 0;
 
 	/*
-	 * Do not allow unprivileged processes to send vendor specific or fabrics
-	 * commands as we can't be sure about their effects.
+	 * Do not allow unprivileged processes to send vendor specific commands
+	 * as we can't be sure about their effects.
 	 */
-	if (c->common.opcode >= nvme_cmd_vendor_start ||
-	    c->common.opcode == nvme_fabrics_command)
+	if (c->common.opcode >= nvme_cmd_vendor_start)
 		return -EACCES;
 
 	/*
-- 
2.30.2


