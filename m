Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41554C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NietwLRkqCBQRAeEYaawoF3UW9Iw+wAqznNnyRyQaNg=; b=tnlhYxXdrEkIeH24XiAUbTQi/W
	zv3RgAbMeR7gSJT8r1UToLB1a2gLRu9u57ca8DfCIUxJ/LdraCfR7uut1ReUXMSu/V3ZORgBGrEl4
	IIYauVsnGkOdC2t8khiTA20xTUMx9y+xuOd1dILHhKVOa+/D28C1unh6eDwSEAgmQymvfgH8G0J1M
	ONBHH9Wpt58NQU2ubkhZAVTJtV9qF3bDostsp9Uc/R9S8A47ZgkE307WllVPtSVfTQM1hj+FtHpwN
	RdwxP22PgVgN801Cpuv1Ha6QiMrTiNhkcm2LppNBjL52EpRscHdrM5sy4rdc+Xu+L36jwX1bZLCFI
	DbZfnH+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7b-0000000HTzO-2hzy;
	Wed, 20 Mar 2024 14:40:51 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7Q-0000000HTr4-0Y8n
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AAB7DCE1158;
	Wed, 20 Mar 2024 14:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE2C433F1;
	Wed, 20 Mar 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945636;
	bh=JGVz1LUbgrtcxu6xStLwMLbIErl2EjCz/G7eCefQ2+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFQGmWqSK9Ta70tHZsoeumfNWQmNTTfbJUIgdVFYd6JvrDSwBTYPr2Tf65z8hhcyT
	 hpDLn5NgTPPsDi+Q4HDLaNBJ7D9hnruZ7182Znl6i4phY9f1yX45GTAe8f08wcdWzx
	 QqFWUw1YuyVqNIvTJWegfQBCO2NQolJmmvsg7kRILtz1G+k8HhmzxdutG+VA0HfsjH
	 Jzcj3B+ulQtHjdKQKiWgLQAALDmhQ0Lsq9JGLBgpWWRHk/3tqHbWjaneLiFrzIZQpR
	 KY9bybtE7E9ZSM3L9YQ/dC7yjfThsfujk2q88HD6bOfPPnqIbylOIwBszPGVJ4/Uc/
	 QUzghoaspugbQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/7] nvme-fcloop: implement 'host_traddr'
Date: Wed, 20 Mar 2024 15:40:16 +0100
Message-Id: <20240320144017.106283-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074041_204059_1243A5D3 
X-CRM114-Status: GOOD (  10.98  )
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
 drivers/nvme/target/fcloop.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 913cd2ec7a6f..7a32fb54a7c8 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -492,6 +492,17 @@ fcloop_t2h_host_release(void *hosthandle)
 	/* host handle ignored for now */
 }
 
+static ssize_t
+fcloop_t2h_host_traddr(void *hosthandle, char *traddr, size_t traddr_len)
+{
+	struct fcloop_rport *rport = hosthandle;
+
+	return snprintf(traddr, traddr_len,
+			"nn-0x%llx:pn-0x%llx",
+			rport->lport->localport->node_name,
+			rport->lport->localport->port_name);
+}
+
 /*
  * Simulate reception of RSCN and converting it to a initiator transport
  * call to rescan a remote port.
@@ -1074,6 +1085,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.ls_req			= fcloop_t2h_ls_req,
 	.ls_abort		= fcloop_t2h_ls_abort,
 	.host_release		= fcloop_t2h_host_release,
+	.host_traddr		= fcloop_t2h_host_traddr,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
-- 
2.35.3


