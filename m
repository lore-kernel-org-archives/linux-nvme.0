Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12D9E7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JPzGd4Gvq9rtmMZqlyD1fq8AOaZ3aKklFzkDaYCHL98=; b=CxdWHJbZpOyhfrsBdCcNGqgzEt
	W5Q7pA3nkM0kpCSCnrTDhIlx72t56bPIV+gg3y3+kfnrmW/YmGhvXEmIjtWk4J/peDypxCYNdPzDZ
	sd4AdkYwL2ZX9c+Em/jST/HT2bgXCV81jvvRLy6QUxxv5odABv0en+rIqJPmVIhiNfAfhtulHUUgp
	eRVctUhI8nzCnQhGB6N/BUlIonSFulbdPNYT5DeDQvhU+rRHdZRKizUznR0TkNBFEqeoXyhVxrIvY
	BpBi1ODhKHP6eI8ZQOKbGKJbZifa1ZrqaKAEauErpFfG4+Jlyz/F2hmrQtEq6Be9eQVEFSFsn7jiS
	K9dOfFgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZeo-00000004TD1-10ip;
	Fri, 20 Dec 2024 09:50:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZem-00000004TAe-0gKk
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:50:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 077E2A40705;
	Fri, 20 Dec 2024 09:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3DC4CEDE;
	Fri, 20 Dec 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688251;
	bh=x9emvNbxppL57XSEYLJvuQyzwgCrDumjN41+fc6H01I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0tyRjEZLFWITcamGoFADYIrJzsW5aGUkryeHnpNnXudVa/YZs9NrknGl1A0vl2Bs
	 1uA7LBUvhd5KDCwEEv++x6up7mVhtSPvRnv51/snaWi6Tmss808vIpyq8g9pXXydhd
	 iaj9LXeDOOf5jF5rPM6ul0Gg7cXN//TW4yaeR5VCi+ha/F6K8/Pq0EXBFxSCJgzJxx
	 +6DVhkZJNaTfz/CEiVlPehoNsAEBIrNQZCGaKfSM52xivXQvdfUVCuGA2C1e6M+zcZ
	 7Gy1aDlq1a2TGavVwgPCwIugmiMR2hGEJaky6A9FDS6T7NiIBcFWixybCtqGp/Q8Dd
	 ATRiDx2d30w7w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v7 04/18] nvmet: Introduce nvmet_get_cmd_effects_admin()
Date: Fri, 20 Dec 2024 18:50:54 +0900
Message-ID: <20241220095108.601914-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_015052_259559_056BE644 
X-CRM114-Status: GOOD (  10.47  )
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

In order to have a logically better organized implementation of the
effects log page, split out reporting the supported admin commands from
nvmet_get_cmd_effects_nvm() into the new function
nvmet_get_cmd_effects_admin().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b73f5fde4d9e..78478a4a2e4d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -230,7 +230,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
+static void nvmet_get_cmd_effects_admin(struct nvme_effects_log *log)
 {
 	log->acs[nvme_admin_get_log_page] =
 	log->acs[nvme_admin_identify] =
@@ -240,7 +240,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->acs[nvme_admin_async_event] =
 	log->acs[nvme_admin_keep_alive] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+}
 
+static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
+{
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
@@ -276,6 +279,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
+		nvmet_get_cmd_effects_admin(log);
 		nvmet_get_cmd_effects_nvm(log);
 		break;
 	case NVME_CSI_ZNS:
@@ -283,6 +287,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 			status = NVME_SC_INVALID_IO_CMD_SET;
 			goto free;
 		}
+		nvmet_get_cmd_effects_admin(log);
 		nvmet_get_cmd_effects_nvm(log);
 		nvmet_get_cmd_effects_zns(log);
 		break;
-- 
2.47.1


