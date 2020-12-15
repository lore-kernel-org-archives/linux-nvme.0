Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8EFC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CA720791
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CA720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g8g7wD/Wy0sdwa7XBdOFuwM5wVb4JmIv2Dwaq/YugNk=; b=GUucR/LBMatyK1IPeNTX6Ehju
	B9JeV1h9DhZHhO2ldqn6e3V7549MvQNZjDuvS4dE2zUT8di9bznSLvgJDjIMfmhUq1VVtlzIRjaEd
	HRz3lTkWk5XM/PzD3msVWy3vL7eAbb8wTDD5AfMELk7BIp9vpCV0SQC1X0WtXR0FDLr0G4gvFXeBN
	iJRTyZJ3RBPVWn2raTUrtys/FalU9sejSreFmSr19AOT2e0VLcPAuOYvrzimGDJ2OFhRB3t/BiOVD
	pYhrv1EUTFSFMaojUMgF/75q661Y6SMoblNBJFwE7qtw0bWGnJ6xZBoLXIXrnX4QFrDbZeCiaaye4
	Q2yYSGlaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp3R2-0007jc-Jn; Tue, 15 Dec 2020 06:03:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp3R0-0007j2-N1
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 06:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608012836; x=1639548836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mQ0mk9gOb3GueQDoqDxI+x/4JSzU9z3SWA8da78K+fM=;
 b=aLhFZYKhF/Yl3C0F1ebmfrA7EIIAQBfSTwftEF+3b6PcW8YtnttYC1aE
 TjO1zUn3mdi34tNZ5bw5IeZmx6VPp/eeqd5duJgabJFyS0LN7g6jy3q69
 TdahHBKR78GmKND1KlL8OTgtENoUYWsbmPQE8Fs8Nc4RwpNaPW9GnUJJt
 jItje7piBp97IlNz4ilZwbWkNHU3LIp+PnOEaepAU0WY0780r9NOi6D3y
 JkFegfr5hpexzjnZ1gFw2x10zzgJ2cfe8G6YLjA0uK5GMZUf5G+dqbKGe
 VzU60urHNgVqe+F7hUWVJm/46HuokZFOOUpyAj9boSISA6GbtFUz9jC+D Q==;
IronPort-SDR: PklgoGIq+YgzzV136zobIon2XEANQQNrJKnntEtt3cHSp9U3v2vUct5bWAMGD1cUuZD4P+wPt1
 +B5yGiSkBlmmFjPNM0DuW7ylcoX9baXL/FnbCIhdjdNn9Z/Vfg3K/QQ54xk1FA+G1Oanott9ry
 yhSYs4iOEDWlvc56T7yvYbOXEb5SpNp7rNVQw9hq9FduXRiXXm3mdeNdyFVuMRYWgUYGfZ6WhH
 h8TXUb3OKYNRHDzssBWiRnMe+GgEt05lJN5m0Ug/jKq1F4RKjP9kW9j3/04hGR95PfL0xOhtyw
 M0M=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; d="scan'208";a="258923105"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:13:53 +0800
IronPort-SDR: 0B43eoFvVz7OSLa1CHp2baKPxqWqUxAO7Qef+GFHLkGHB63AQZzqPs67KNeWoVqKn6n6yIDqtA
 glf/2/dFJggYovRtIZPWPK5S1rkA9w+YvKz19qaFk6u+WEj7hUGFYzqEyjy4EPWkVLnMvWE8fm
 ipwfc/9KyjziEZbhZZTRs5ucK2z1XNiSQTP3Bvy3UW8mSjXrMO9H1gXDufzRSOWDNuwmlMRqo4
 JCuIx3Tx4Uaf1F8w+yx3uUtJjLoNdQusoGT6bVC3iaCZcCO+0lFx2w35SsEp8IVdcN/X+PGkJw
 kocTuBuiV1EkuPhZZXxIhmNd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:47:23 -0800
IronPort-SDR: wamrKfPWR01aYsCEvUChlhXQ38kBLloCi3TywL6gkp2uCy1laa+Yz+CrxmZxbBkD/mCbWkGvhJ
 B3o72mRtzgl6nx2/R07pRcbxNMiRtTClh5GhgZ3QXnVio9HRRw0ujfD9asAm0JwuZn0oyeN7J6
 W7CYQiTkdDyBe57p1DGw8hWue6plmUD7zgt2aBUqnF+dlIXmqnz4IkHQFb6023oPSYkLflIHMK
 MKvs15RpgoCJdrgZDhqQYtrADKbBJ1skIsKSgSVA58YcHuH+6yb4CiUexkGMcptkySD7keybiZ
 EN4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:41 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V7 3/6] nvmet: add NVM command set identifier support
Date: Mon, 14 Dec 2020 22:03:02 -0800
Message-Id: <20201215060305.28141-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_010342_893019_71D6A024 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe TP 4056 allows controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch we adjust the code such that it can now
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++++++++-------------
 drivers/nvme/target/core.c      | 13 ++++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 74620240ac47..f4c0f3aca485 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,19 +176,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	if (!log)
 		goto out;
 
-	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
-
-	log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+	switch (req->cmd->get_log_page.csi) {
+	case NVME_CSI_NVM:
+		log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
+
+		log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		break;
+	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..672e4009f8d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -681,6 +681,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
@@ -1103,6 +1104,16 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_cc_css_check(u8 cc_css)
+{
+	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_NVM:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
@@ -1111,7 +1122,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
 	    nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_cc_css_check(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..476b3cd91c65 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
