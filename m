Return-Path: <SRS0=8bm+=4Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F2C10DCE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 10:57:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6A2206D7
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVkFdeBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6A2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=83IEt9J3k8kRK8yFwOfZ2bM6dTBtm3ogTyup+g9TgRM=; b=nVkFdeBdZGCXSg
	YpWx7Q8MSrO/EBajQeh60nFhgsM/8TBDI2AVTCZKoi1V3bPyr4JQPw0fF5Yn5e/L0ryhQk0WdpDwW
	GeWFdlmtGKQd709rLZp4MuxHGpmvKUkA818fmaf2xCcUWsYXW8hMYZQwQudXhZPQ7pgLzO364sTdP
	sSzXgfL3hkUxBQbuvRRmehvM+fQD0OvLAocyNw2Kq7bJKMX0Ahacq2k0HN4ZNIi5+jQzA+3DyPBLD
	1eV8LyI9WMBbyWjxM03iCyCzN/KJPUEV8hixKGnTaY+jjlzhhJ1yFqYhJ5M1dvRaFtL11Z2aUQW+C
	MA/rUzap9qRP7oS70FNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jAtcA-0002YY-1a; Sun, 08 Mar 2020 10:56:58 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jAtaU-0000Oi-HR
 for linux-nvme@lists.infradead.org; Sun, 08 Mar 2020 10:55:20 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 8 Mar 2020 12:55:05 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 028At5GN004210;
 Sun, 8 Mar 2020 12:55:05 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: jgg@mellanox.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org
Subject: [PATCH V3 1/3] nvmet: Add get_mdts op for controllers
Date: Sun,  8 Mar 2020 12:55:03 +0200
Message-Id: <20200308105505.14305-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200308_035515_004297_FAFC5AE9 
X-CRM114-Status: GOOD (  11.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: bvanassche@acm.org, vladimirk@mellanox.com, bharat@chelsio.com,
 nirranjan@chelsio.com, shlomin@mellanox.com, krishna2@chelsio.com,
 Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some transports, such as RDMA, would like to set the Maximum Data
Transfer Size (MDTS) according to device/port/ctrl characteristics.
This will enable the transport to set the optimal MDTS according to
controller needs and device capabilities. Add a new nvmet transport
op that is called during ctrl identification. This will not effect
transports that don't implement this option. The return value of the new
op is according to the NVMe spec definition for MDTS.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---

changes from V2:
 - added Reviewed-by signature (Sagi)

changes from V1:
 - renamed set_mdts to get_mdts (Bart)
 - added const for ctrl argument (Bart)
 - updated commit message to explain return value of the new op (Bart)

---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 drivers/nvme/target/nvmet.h     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c0aa9c3..b9ec489 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -369,8 +369,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* we support multiple ports, multiples hosts and ANA: */
 	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
 
-	/* no limit on data transfer sizes for now */
-	id->mdts = 0;
+	/* Limit MDTS according to transport capability */
+	if (ctrl->ops->get_mdts)
+		id->mdts = ctrl->ops->get_mdts(ctrl);
+	else
+		id->mdts = 0;
+
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 42ba2dd..421dff3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -289,6 +289,7 @@ struct nvmet_fabrics_ops {
 			struct nvmet_port *port, char *traddr);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
+	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
