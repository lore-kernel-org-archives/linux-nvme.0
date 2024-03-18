Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA7DC54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PN+yXbWLSR5Br48RHAm+E5NzZraaCOCSZjyYpz6xQaU=; b=2GmU29XE5joOMM8MsZRLM5jqkb
	XT49FueLe2AqTBEooNADRnhvI7v50LdYsxb4/QM/7bc6EQJvzg2fpNhYh3NFUFgFenKrIYjWaiIBO
	2g5vfTb7Kd4Vx269//DT/ElNeV49rG487cF/35b5QEohcX5HTy+e+ygtF9sYn8cgENvLR464R8wOc
	lPGFEifVjwiXyfyP2m0aha83ZfMiC+VCx/gjVX1DoDjFahuj3lMQqloYFajsyCIOKkbaHOTEzHc7C
	NpAQ6epE7T6o2XlPISgC7DoB9RMbjiDD27cxHKkDQ4qpsOY8h7JD1K5+cSr8L9KYw/4hjr+3BeJgk
	GrBUVpCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXg-00000008v4t-0Anj;
	Mon, 18 Mar 2024 15:04:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWs-00000008uVM-0zaz
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:04:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 943AE60C5F;
	Mon, 18 Mar 2024 15:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0464C433C7;
	Mon, 18 Mar 2024 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774237;
	bh=j0leztnoqjvfFV7aipumVTN4QCfGHC5vtRNT/I+NQwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6uCgSXIMWYkrSea2GSlOvHUF6XUcSus39k567JVucVBBrJMN+BYcy2U/RLMnKqEh
	 jjN2nL3TW72xSdElSMbQUcuwB/cnYipc3H0CeJw+FFMaDbwLcGQTD6hXMBaXA3Y4N6
	 3TYZ74der1j3TGpyhK5rjclUY9PXTx/OtmbS/sXKFlSy+eHIr6BRl/uyPXp8MXs7yL
	 VvUwXEbGC4XiX8mTNZZLsoqNXnWdysi8Y438F3NC1hV1KRSCDt3vcXXJGsX/ic4xjh
	 S2rF7FtAVgIjllb6O7pvANMRaDw4/+dF3qhsJzpYdp0brOkuG4oB/dnWk4GlAxSup6
	 3d7GKsEEU2hBw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/17] nvme-target: do not check authentication status for admin commands twice
Date: Mon, 18 Mar 2024 16:03:14 +0100
Message-Id: <20240318150316.138501-16-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080358_729223_24BABD26 
X-CRM114-Status: GOOD (  11.12  )
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

nvmet_check_ctrl_status() checks the authentication status, so
we don't need to do that prior to calling it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f5b7054a4a05..936194de4a52 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1005,8 +1005,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_admin_cmd(req);
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
-- 
2.35.3


