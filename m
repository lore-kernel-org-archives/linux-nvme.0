Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0876C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7375F6529E
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7375F6529E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ONXxzBg/4tZA43EgWre/Y6SA17tdOzRENXdtYJyd32U=; b=NsBUtxx56YyQkFfbJkBiWtS3j
	gAptTTCskw+y/kWlWSt53oqJ1JDTOhCGEw1ZPSYSI8msgaJm3zwSaHTWodCzfp/iezkdm0J+63BvW
	dFVzy9yMb1zdtEFHhF0laOwO74YIQ+4/6tApQe/OpwmV22UTJfuUWjr9X+zJqDxpVZnbnSw3AxpMJ
	zPNtr/2d4zpmzYFFuboaVxZkBCkjq0rh7f/IyjOWKyMimm+iG5vHC/Pa8Zc4ciJ2infZlloB4EBZI
	dHQZW/sHICqgp4pXeS6R6iROooq+L5byeqPv4oxf2q/nfFe7lofV3jHTorGpaig1r6kKqVw2jG/aC
	X2Mh5V9EQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUSX-003lE5-IL; Tue, 09 Mar 2021 04:59:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUSE-003lBh-Dr
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265926; x=1646801926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NDYzXDjDnj7nD3rcOLKFiqNSa1K74ud1dHPF3bJ9cdk=;
 b=pCFbwOAQByUa8tiiC3pzBQDGtYvysDMKSgcbgmVzilGCMX0nujdjyjXE
 4sohk74auAEuZ2P9Av5g+Wr6fTMvakusPWDmnt/p7X2CjNJYLAAZdIG09
 aqPu5MjI/6uHIzA7ZVbNZum4TUu8c/FbkN/iQQXlKv/LOCh8U6RC7UUZi
 KLjpFGPzIsJx1OfCSUvzl2PERWQ3wRe7NYGTOP2RwtJK8/AmlkoWEffWf
 nJd+w4AXmrwe6ix4FiaBQFtpubnEQqd0pa3Xloz/ndy8Bj7+OqGtZ7GQj
 NaE7mkKz2bC66FEx++O8OzrvBkFyRrG59f5eT8BzbZmx/K2i2sXeTFqHL w==;
IronPort-SDR: ZxV1QlpYuiVH2c8jK3XHJq/nrzET1o8J0N9XCPrGsjASq3UGaaHDFkk+4Xo9p421OgeUgVeQz5
 5Q7sNjs6118h/ILBZX35dvmGSpGGMkaYChTaow4WUJrR7FCh+3wZ6jsfsquo1XVPgRCJwnSxKK
 xpg4ZbzIgzS6YUICDZrQd0TrF1OdQZvCnHfvmP5kz/SYY9hqDJ34yNmMYvmfcTH1nknjeoKsMu
 rAHEIsD573ZV69v9RrMMfNZ20t2ezYSIC+Uce1Umg8Ozu4IVzcDIbp71OmyQRWdynbWz124BLl
 R+M=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="166175661"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:58:43 +0800
IronPort-SDR: Hof3bqmoJzRIeZAaOWWks6Gr4Xl1Qe23kdHOFtFzVPTztUs5c328iFB8l7mj3JYTnLm1jSAhO2
 h7Ax44JdTuec7hVrKHTtI05AphuKrkYwXT4N1hOTm57CnHigHE4JTI+Aa9kUarvof8209DvDh3
 atyGy9WbmeesshuxApTyNKAsE2tdPZX6YHdvyzqiHUjp1fPfGFPwrMOeeY6ibJJTFhck9eJX8m
 61HYsDLdngiLuTYmiepvweOw5nP46J/ZNspN4peabi3N+enjDaMgw2PQ+mtWTIIiywVAvYwjrr
 KGhrwMFn1u4XrhldqzagWPqK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:39:41 -0800
IronPort-SDR: HBTurPBySOS6Y6Ks7UeGsL1+IbzKQQRug8QIYWqSqgFl3u/Y8Eaci6D9ptOjl6EVHfu/+p1nua
 K+QpXDtR7+AvVm1ZkuO6EBdbuRdmEH0kL8n8KrGQtIvI2tB0qhdXZRrwJHOofql+Z5uu1lt3iM
 rNrbwiNqgiYXVyHzx9BZ5ZxoQek7HZOig/izBrnrYYTKuYLjcvvnkZEBiluNBpBI+a7Y4zzYdf
 bBDyL8LApit4pnSlXh04QWG1PUt96d/35KCuftYhmLOOKBe4S7lreD7BZHU6ao3eUX0bVqtdXa
 0lA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:58:44 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 2/8] nvmet: add NVM Command Set Identifier support
Date: Mon,  8 Mar 2021 20:58:17 -0800
Message-Id: <20210309045823.18545-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045846_951019_F36C8816 
X-CRM114-Status: GOOD (  17.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe TP 4056 allows controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is a value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now
support default command set identifier. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to the different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 78 +++++++++++++++++++++++++++++----
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  1 +
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e6caa35db4d5..76d9fc0f48c2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -162,15 +162,8 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+static void nvmet_set_csi_nvm_effects(struct nvme_effects_log *log)
 {
-	u16 status = NVME_SC_INTERNAL;
-	struct nvme_effects_log *log;
-
-	log = kzalloc(sizeof(*log), GFP_KERNEL);
-	if (!log)
-		goto out;
-
 	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
@@ -184,8 +177,45 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+}
 
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+static u16 nvmet_set_csi_zns_effects(struct nvme_effects_log *log)
+{
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		return NVME_SC_INVALID_IO_CMD_SET;
+
+	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+
+	return NVME_SC_SUCCESS;
+}
+
+static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+{
+	struct nvme_effects_log *log;
+	u16 status = NVME_SC_SUCCESS;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	switch (req->cmd->get_log_page.csi) {
+	case NVME_CSI_NVM:
+		nvmet_set_csi_nvm_effects(log);
+		break;
+	case NVME_CSI_ZNS:
+		status = nvmet_set_csi_zns_effects(log);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		break;
+	}
+
+	if (status == NVME_SC_SUCCESS)
+		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
 out:
@@ -606,6 +636,11 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, off_t *off)
 		desc.nidt = NVME_NIDT_NGUID;
 		id = &req->ns->nguid;
 		break;
+	case NVME_NIDT_CSI:
+		desc.nidl = NVME_NIDT_CSI_LEN;
+		desc.nidt = NVME_NIDT_CSI;
+		id = &req->ns->csi;
+		break;
 	default:
 		return NVME_SC_INTERNAL;
 	}
@@ -623,6 +658,27 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, off_t *off)
 	return 0;
 }
 
+static u16 nvmet_execute_identify_desclist_csi(struct nvmet_req *req, off_t *o)
+{
+	u16 status;
+
+	switch (req->ns->csi) {
+	case NVME_CSI_NVM:
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
+		break;
+	case NVME_CSI_ZNS:
+		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+			return NVME_SC_INVALID_IO_CMD_SET;
+
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
+		break;
+	default:
+		status = NVME_SC_INVALID_IO_CMD_SET;
+	}
+
+	return status;
+}
+
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
 	off_t off = 0;
@@ -643,6 +699,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_execute_identify_desclist_csi(req, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index be6fcdaf51a7..7c3dee21474e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -693,6 +693,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4b84edb49f22..f017b1c70a49 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..f09fbbb7876b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1494,6 +1494,7 @@ enum {
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
 	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
+	NVME_SC_INVALID_IO_CMD_SET	= 0x2C,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
