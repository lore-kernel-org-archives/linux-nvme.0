Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3604DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b9cLarJJzKnv4+fO0slqNEJa7vvIPk0fZSzjFrZ7k0Y=; b=mbq0TViNxvW4CRcc0yQKkwDkWG
	nQmdQBvHCJ/5jOmZO2M+XI0X2xo9R7dspKXU7xTpPra54wSt9oCahW9pPkRugfwl9zkHoP+FArqB9
	NtLfCwfwz8o+D8X//KizYi07IGwKNg19/fB3OMEptaEIzjyWCrw5fSFeP6zPWpYbLNhvNjHZMSxne
	YZTWHkT5siPmhzx/ofKM2M3nOa1B8J0Iek5gYevCfi7Vxiphjvyd08/uRLjz4Of9wjnVaB5l0PIoJ
	AVFSI+9A8oYUfScB7D+TiJPQtWAhNaAwoSMMAYISeix05g3BEX3RdsZo4xExjcVE0vPjw9lIXRsjR
	uFTu3gQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwTW-007d0Q-22; Tue, 29 Nov 2022 09:00:22 +0000
Received: from [2001:4bb8:192:26e7:2e6b:fea:4668:9e6f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwTS-007cww-5F; Tue, 29 Nov 2022 09:00:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough on read-only FDs
Date: Tue, 29 Nov 2022 10:00:16 +0100
Message-Id: <20221129090016.1311006-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

Unfortunately Write Zeroes is coded as a no data transfer opcode in NVMe,
so don't allow it on a read-only FD for unprivileged users.

Fixes: 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9550a69029b368..8aefe9c904dc9a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -45,7 +45,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * special file is open for writing, but always allow I/O commands that
 	 * transfer data from the controller.
 	 */
-	if (nvme_is_write(c))
+	if (nvme_is_write(c) || c->common.opcode == nvme_cmd_write_zeroes)
 		return mode & FMODE_WRITE;
 	return true;
 }
-- 
2.30.2


