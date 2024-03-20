Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F86C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSZvOT50qksTiAoSxjtajjbAwhzGlqYsVO4Ue7ADtjE=; b=np6kOSHwf9at0KAYtsB+L7pt9r
	FQjBx2r/Jh8xdKoYzegrmh71swQ2mwXaBryaFBmzc//iVygcoRLLMFW/BymJGPBIPXOvdnJ5h5emm
	ZxBMSYZFA75s9U0HVdxKuybeXcN59b+YKXWrwkUJKly2jwL21LFZ1o9B+0QpPveilo2Z7+ksZp9cw
	jbUwxAYzjdGxQImQNHuXpYgk/Qs9ns3OjaF1wSGvIQuT9AcspvJhIFNUH65xtHFf5ujSrDCjxlaKz
	/qLPHxH+ztiQfpnQqV5eE/I+eyWMfj0HsQvpwS7g5DNz+Ng4Dj4UOZjK/TcjfwpsCrAeyxSXFhPZX
	yZPT6IJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7X-0000000HTwf-1XzO;
	Wed, 20 Mar 2024 14:40:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7P-0000000HTrZ-3eoW
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F3A86100E;
	Wed, 20 Mar 2024 14:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F676C433B1;
	Wed, 20 Mar 2024 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945638;
	bh=eqfje5zlXCW82vNVQi6jKDJRq0OSIEGDnFLuGfLr/fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUZHa3xTDcLsjUU/6okS5Rtasd7CfgBNYf7pD/bPCVIa/s8TfHubxLG9voQQd6tTi
	 G4FGiy+TZC5FGCPtuQhwYvzsYEGJ285mwH4KqoerJBzEfzdiamG/9Qaty7Yr9FIq36
	 8rByQwE1ODCxO/rkVH9ArESZSebOp8+hDCGZ3mUHNk8z4jANnwlpV2WM55nakIb9Ap
	 ilBum/QowDG1RckmjjKB/TxB6Ft988kqQcXmxiEohHPKHxfO06Q+qCnY7GIyrMo7az
	 9RICN9rB4/5GoVTxH0YYPfRKQesipGM41a24T0Yxg9Eeb7YZGoUoJK/hig5zgWPV6W
	 Pvsh9wxMGI68w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/7] lpfc_nvmet: implement 'host_traddr'
Date: Wed, 20 Mar 2024 15:40:17 +0100
Message-Id: <20240320144017.106283-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074040_400730_DEF6BAED 
X-CRM114-Status: GOOD (  10.03  )
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

Implement the 'host_traddr' callback to display the host transport
address for nvmet debugfs.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 425328d9c2d8..f927be625966 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1363,6 +1363,17 @@ lpfc_nvmet_ls_abort(struct nvmet_fc_target_port *targetport,
 		atomic_inc(&lpfc_nvmet->xmt_ls_abort);
 }
 
+static ssize_t
+lpfc_nvmet_host_traddr(void *hosthandle, char *traddr, size_t traddr_size)
+{
+	struct lpfc_nodelist *ndlp = hosthandle;
+
+	return snprintf(traddr, traddr_size,
+			"nn-0x%08llx:pn-0x%08llx",
+			wwn_to_u64(ndlp->nlp_nodename.u.wwn),
+			wwn_to_u64(ndlp->nlp_portname.u.wwn));
+}
+
 static void
 lpfc_nvmet_host_release(void *hosthandle)
 {
@@ -1413,6 +1424,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.ls_req         = lpfc_nvmet_ls_req,
 	.ls_abort       = lpfc_nvmet_ls_abort,
 	.host_release   = lpfc_nvmet_host_release,
+	.host_traddr    = lpfc_nvmet_host_traddr,
 
 	.max_hw_queues  = 1,
 	.max_sgl_segments = LPFC_NVMET_DEFAULT_SEGS,
-- 
2.35.3


