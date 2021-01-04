Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFFC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66F12087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66F12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FeBgJ9/O9QPGXaNJxv2S3HhIjOT6LQpurUjobt1NX30=; b=g4IaDSGGj/hVda4jTASP2/DpO
	m1fiLPZuRfVfrrmXRpsxM3SVMNFiTt/7mQqoe2lhS1xqGQ+IZjzT8v3qdnqaSfRTcAa9kY3z0+4ZG
	h6h3/BxpA7DA9SpvdZXRuZA/SpttGhaerYmkMqoRbVRiVGxSJZfineZpguDQZYrRQL+6fKOI+H8bM
	8hSPTgmMRr60Z/i7NcaQBFAhZa7bdfABhnmE5vIxFztc1aZRfRyhWaz5VWoiQmHUnfs+w0wEwx3Go
	GIhR2L54JfjnoNIc/pTKNJlStjKMIyRT6bSus7QYYoj07bnvBAbOAZX5ZNPbAX2Kex7hIT2weT0lB
	+L24GgJpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI8E-0002w1-1O; Mon, 04 Jan 2021 05:10:14 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8C-0002uv-4J
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737012; x=1641273012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yner/x6lkLzolBMe5kY+SSSvdlIMjf3bOkqdD/jfpq8=;
 b=j2KKp51sQb6vLHoXnLYjAUxqiT91aDX4aPSuWWzIqBIZuUwOZTg/Itzo
 fNYZaqZXdtlKpzwrzAsApwXs/G/KoqCIUTFeNfMMGG5eX/WMdOkLu5d5F
 s0jf5SLtuL6MdQLqx0QP5FIZNzRZLP9CLkYzq/v19AXtPQFPp0p9m6BpH
 lUqj9Czkx0v9GMKfTnDqERuIievrZOoAYg/ndm5DixPKIfbJHARS2O43n
 KRaEVKfKzZYUx5sJMU+fOntt5vIeANEJZjgJ59OlMYbuganup0tSXjqWO
 Hbjn9e9kUQeM/JUo0cFOBviMsIv6ycAI9wfN7DCCeAbDpoIrSHch4Jzuc g==;
IronPort-SDR: 4JjkXNs1W94pDqiZeoGbMXnmz1kKS7DvLg9L3zJR6+D310qx9Jm5kv012vQ1E9K49qLgAV8ef9
 MXK9yF+/UFDuD7HE5pQkf/f4VIUcMnqzzy5YYYj9Q6wN6d76nsy/ZszDEtoxawtj8VUIgnnBSp
 IeVFI+YyfEZk78MMseOO48oDuqSy7VkmZwBXn24dvks/EsCitccYYJj4vVg5lUrNp8ck1JPrww
 lTpblcVogREnUczY3kIFzBC1YYsiDcu12a2C6ZwI2LTc308lP9elnYE+3Mj3CDfvnFI1nGzLih
 CbY=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="160878654"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:10:10 +0800
IronPort-SDR: t7r4fzkb8wFjksnHc/NCnsIIjeySKcBkLRElA1JJ7ma+tXpwrI3SSLrLT1TotZcjZjNiRXIGXg
 8OBtc/gu9jmSd4GI6NbfqWS02CNTRw4X2kJONrtzUFfNKN9HHnUiWLJLzdH+wGZNlo3oQcqlq5
 sfU1yPOdF4EY4yBViAwFEVtDeAUcJ1IK9FqZfaKuVHsY3KpGtrJihSknDIsU24FKZT7QKJBThy
 9NDgEUiXVV/GQfjlHnCduAfifEg+yRTPMG8+AIENuuYi2f+Ohy9tQEntAY0Dtca40Jz/tZxzvJ
 gHxTIa1a8TOi1MY7gZ4rXO0E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:53:19 -0800
IronPort-SDR: r4kC7UXmLVGHfPIAUDkPACHQfw+Ld4Gm89ldnMdfvizuReDQwQ+KAtTma0eOOzvYGbrwf4LKyY
 cENC4Ep6knCLQyaJzGsHhyaD4OtbXjwQH9c7+bxJUZtu6B8mj9D1htdCvTl6JN9rjuEvvbZeAs
 eKVqK1NOpruX1jeReHzpzHiFeuH5MDuYIIIl/LJsLwUZxQCPr9VaUV8MB49drfsGaEZs64YzE0
 HcgESCDQA2GnBP6fzleIOlLPXof+oiYDOViJ8/p9etYK/Bqpl8OBQbiffUKl9ns2iAnzAtFvkV
 L3o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:11 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 3/9] nvmet: add NVM command set identifier support
Date: Sun,  3 Jan 2021 21:09:32 -0800
Message-Id: <20210104050938.25745-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001012_563495_D4ED9FB3 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
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

In this preparation patch, we adjust the code such that it can now 
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS 
interface, since ZNS commands belongs to the different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++++++++-------------
 drivers/nvme/target/core.c      | 13 ++++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 220edacfccfb..2e865bff893f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -175,19 +175,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
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
