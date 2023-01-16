Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07623C46467
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHboVp4/n8dg/1mTqeVNMq07d7i55rvCp5cMprWstb8=; b=RD7ZjR0+/22St+mjg6rz7LpOKu
	YRCBn9R/mqWQSeMg38wY9/eBS2nAsMqqpC/JBQTD+lvRZX/SrNz+QIB4z+kzXd5oAwY/dajxeHE4L
	OtUxUAQvQi0ochVpBq1EtmBdJeK/O1hBbpoOu0u/m9aAzHd7uOdGS4lKEAffSC1bN70+2/m4rPaCs
	hUZl9xJytg61LEmHDOSAriue7oRJKLu0Z9Gk6szVQSvl6wUmmLBJoE93uM3e3OWSEnnH3/k7RQFL4
	ZzloiSaH0Buvb9pPFlr28seFIMsUwSs7qg6dFcj4XwBQD4jYgCXrl1quKps/wCA6S6sRfKw7fDOIm
	G9Wk8mXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPHe-00AJiu-2i; Mon, 16 Jan 2023 13:12:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPCW-00AHUt-R4
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 13:07:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6079960F99;
	Mon, 16 Jan 2023 13:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0DFC433F1;
	Mon, 16 Jan 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673874419;
	bh=Z9+KomyeN4vAjModCpaAbKOjkyqP4m8dRccCmgRLn8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPeQnGdMKL0qvPIWYWzLqm//vIJ6xVrQ+zSrw9NRNMJnbSzuJa9VEEYupUejVnt06
	 HRNhIbjJVVOzzBSXSeoUjnDrYIDLqtF3CjSOmEgHFu37MIVWOwUbq/DFyGfdnJ++Yg
	 BvhvBUhhKztQYlOb92vy7VS8Uiq44148kyxwVg4auh30C5QonsBIXdBs6dnWQlVAaH
	 p/08idib6ImCyqQwz1xJ8CyMsMgn2pwOnLcSRdNel6waQkTHTGQTYUJsOWFJsf4Ywz
	 ++JUX3bjsvRlVxxLqSrPNBs7farZKtwyKf2xjpumDEoLbmQvbxXcM2CM0TkhY3sduc
	 8JxubTZg4TsUw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 12/13] nvme: Add crypto profile at nvme controller
Date: Mon, 16 Jan 2023 15:05:59 +0200
Message-Id: <efc8dc5952baa096a14db1761f84a5ab2e76654a.1673873422.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_050700_955043_97F91859 
X-CRM114-Status: GOOD (  14.15  )
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

From: Israel Rukshin <israelr@nvidia.com>

The crypto profile will be filled by the transport drivers. This
is a preparation patch for adding support of inline encryption
at nvme-rdma driver.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/nvme/host/core.c | 3 +++
 drivers/nvme/host/nvme.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51a9880db6ce..f09e4e0216b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1928,6 +1928,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
+	if (ctrl->crypto_enable)
+		blk_crypto_register(&ctrl->crypto_profile, disk->queue);
+
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 424c8a467a0c..591380f53744 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
+#include <linux/blk-crypto-profile.h>
 
 #include <trace/events/block.h>
 
@@ -374,6 +375,9 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+
+	bool crypto_enable;
+	struct blk_crypto_profile crypto_profile;
 };
 
 enum nvme_iopolicy {
-- 
2.39.0


