Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7287C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cQroW7ZYb2QrhV7KPquGWTR/wglFs53YyNcndiEfH7k=; b=CgRrf790ciWQMirzQ7R1XVMRCB
	mx8T/UAEMZ/T0AIPyhP/EnApY1TGAwAlKhcllAVgp5yGFi4LLFtfWPR3rN7Xv2o7MoNeEv20sHQIy
	I/3oPASPZyfaSOeuL5ophJrj8gs8jsMXTBQOokeGisDebzL7VxeM9mhy36srJQ+PB2vlPkIKxsmaW
	cqGz2AHJyp8unvBlRB++8mGeFRyzIU9oyPp2Floo2/E+VaSizGxWuftVW+zE/Q55ebpqFQ60SGvQm
	5wJ3c19uMeDpn5J2fUCeOEsz+tC020vRZfgCPIkutZ5EE3OB9XkxtvB9vO9WSjs8LUmlj5LZq9tXa
	I3Zvhd2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJ4z-00B0dM-75; Mon, 18 Jul 2022 05:14:01 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJ4x-00B0cn-IO; Mon, 18 Jul 2022 05:14:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH] nvme-pci: print the command name of aborted commands
Date: Mon, 18 Jul 2022 07:13:57 +0200
Message-Id: <20220718051357.232697-1-hch@lst.de>
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

To allow for slightly better debugging, print the command name when
aborting an command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e465902e0b752..1f229dabbe7aa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1434,8 +1434,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
 
 	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d QID %d timeout, aborting\n",
-		 req->tag, nvmeq->qid);
+		"I/O %d (%s) QID %d timeout, aborting\n",
+		 req->tag,
+		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
+		 nvmeq->qid);
 
 	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
 					 BLK_MQ_REQ_NOWAIT);
-- 
2.30.2


