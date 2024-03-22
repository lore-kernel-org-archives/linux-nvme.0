Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98742C47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zd/5Z8C+y+U19Nejkh41Eltpl0oVA1gwNATrljAVQf8=; b=PUXRrhOpn7R3RLrigcFUbKrrRd
	CBCL1nwk8F/uxbQ6uaAjGdRrBx5baPaXh7/aHZ+7WXX1Pq5QxMkDW0fyrRE7agxdNad5qEyeBQm0F
	2vXNFoBVfGoAF6mt3ebOurqEdq+VDppLWUEL64HRpYnm6fjBW8a+F20ia2RvQzT92lDyKNCQvYFW5
	ko8UItSvSHfj4tVvf6D3+l3wNvsvr78W6qpFms7RrMQ0vf+wm2u9MBk5pLiLOwYLncPRpEQENhH+M
	Xv+EWh8VCO7qAzQUW8wNSgx4zAt+bahK14jEWhU/HgCsSPzGzJXF4195MWdu/azI7jVcXrWfzuNu5
	OW14DTrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwa-000000067YY-0I8F;
	Fri, 22 Mar 2024 07:04:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwP-000000067QV-31le
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2AF2161368;
	Fri, 22 Mar 2024 07:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FFC433F1;
	Fri, 22 Mar 2024 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091028;
	bh=F7rOKSzAzDnN+aQiv8DCFDJwM+6jcADEXGwdV14qrcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYySFjqXQ9zt22p3R/w2Fk105Z6T0SqY4jk6wlpxLkLQ/JEGs+sZRIBqQQoKWqikh
	 WT4Bywmd/vvmZQMV0sMmr5Ivuv0mP415dhhjuPvRZ/AGZNVDEFnc3fDTuxfIZGbnsp
	 fWHAlZi6FAT2CSV4zh+bjnLJk235pqNBHaX0L8K/MDX2VhRKVBe6Nzj7pOPaFs0caW
	 5FSHXHSggmpR11/2I8nABO/SzZXYopoTA0c3bCiKCHqVHN3lfb4LJVVm4JdfiUE5AR
	 yd4amCes0N9erghj+D/GMHAuVB5CRxTz9ckhi18nuXV+YQ0rujmk8OMb6eExjt3Cez
	 CuKhc4BqC9a7w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/8] nvme-fcloop: implement 'host_traddr'
Date: Fri, 22 Mar 2024 08:03:31 +0100
Message-Id: <20240322070333.3820-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000349_866148_1E1E1828 
X-CRM114-Status: GOOD (  11.09  )
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
 drivers/nvme/target/fcloop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 913cd2ec7a6f..e1abb27927ff 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -492,6 +492,16 @@ fcloop_t2h_host_release(void *hosthandle)
 	/* host handle ignored for now */
 }
 
+static int
+fcloop_t2h_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
+{
+	struct fcloop_rport *rport = hosthandle;
+
+	*wwnn = rport->lport->localport->node_name;
+	*wwpn = rport->lport->localport->port_name;
+	return 0;
+}
+
 /*
  * Simulate reception of RSCN and converting it to a initiator transport
  * call to rescan a remote port.
@@ -1074,6 +1084,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.ls_req			= fcloop_t2h_ls_req,
 	.ls_abort		= fcloop_t2h_ls_abort,
 	.host_release		= fcloop_t2h_host_release,
+	.host_traddr		= fcloop_t2h_host_traddr,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
-- 
2.35.3


