Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33201E6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6koEg3ORYOvIi3e26txsgR/nhwrNI8Ae21Mw02k0to=; b=uqi8IMwSCmw/jV17cIYqNK52nM
	edj96xuNX4EU36RDmaMj4esmLHj02CkY+npXVYR0vSP6YZbY5lJdWfTaaQvp4niLe33islzjdcJPt
	WoMONfHWrv6w6IZJ01ulQiFOsXgxeaVcY2PlhHVdZG04U7bIcqwcVQFKuw+GiU+mZ7gEQ8WTGqJnl
	HvjYDjMxri2iZ2IqV+SCAA5L5Ek1kaPTxTaRCjaL/lPiejzxXZ/H63cxxDBE7O/oIt6Aio9cSZJn+
	lC02Ml9ydP2WupZ2fyD3KaUwXkble7lIE49AmdJAW8KcZRt7ePXrguONdrXw99SC6RKQxRnl0Xe8r
	hJT+SPtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6K-000000022hS-29A7;
	Fri, 30 Jan 2026 22:36:28 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6H-000000022fv-3fGA
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:27 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-124b117776fso2025542c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812585; x=1770417385; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6koEg3ORYOvIi3e26txsgR/nhwrNI8Ae21Mw02k0to=;
        b=Z5ZlrsryNGY/l+PQR4YixjcxUd4cfMvgfXGSdwIArCnfy8kNXbg1h2kvUC9ZWcQ9e3
         +stRGDYGCvUG3oSUzxwtkctiCPlak8c7kWBCcZluQoWrEAVnGeDqy9dm4RPFIv1yp063
         CmkogxEIXTV+T19bEpAwukghefYIJJP50Ay2m+wefwpB7qYCw06payBtj0wHmUVUlUA3
         MYFJLOOS7yRJcwAarCMrYixcJvZwpHqZiIynwfkE4iJSrIFVtxOSJb4l3oIeAdzA2oQ0
         m8iX9IuQtUDmpi+U9CBkX4u6+H2rfLs0eWxBTeJTntelyZ3OEOfRDysgcKVydp9ExBBu
         3MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812585; x=1770417385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6koEg3ORYOvIi3e26txsgR/nhwrNI8Ae21Mw02k0to=;
        b=FgaRq0Pgu4lj4/ZMqyIjnkgjPTkDm8aOqIQqtwzZ0UlPF5kFMACUuohNbGntw85DpI
         vzXRMGVld7TXB4V4J0MzCJLfsiyeQGrPyEnfbBToJHNIAQoRZDY/ji1ONkTW+Ij8IYiT
         A2XI2O33sZjjJbw8k8XJGCa/hQsVDN0qEDT/ppRwScQPE2KZYq7/n6y3CPHEBcF82K/Z
         h9kCcFNlGA/OW4qTkVcPVTx8PI15Eke0SnKeR/N0H9efoqGT5IMiGh1L8W17uEICXvO1
         8uBE2JkUpvuqXo3IomilB3XPQjHlcHql8zmO8CfH9x7ADs4Xao6K2R8WuJo78AVRvApv
         uIrg==
X-Forwarded-Encrypted: i=1; AJvYcCW3mkLKwm4ikaVfuWePW9a7zAwKq4b7VhX/rZbs8mhfbWlnR1iOLKqwRo5H527VWAzMmFNlwIifS71H@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+tsZoUK1Sahn7E0ZBbhWPcoNAlO7zUpzRv5dGMOuSNoJQdNT5
	ISE2ZRq/8FOjYnj0N5nPB929hjAtjbhpdcH7yAvtHAZif81Ws4/Y35+X21+vNBDEqRM=
X-Gm-Gg: AZuq6aKl4j/VnUIOrES0YSkGfKZ4YisXpuq/ejhjPTvbiQ/KSnde2qNuLN01qbaXKPq
	H3c/Ce/aXP74yg0eQzUdwaGOAp4H00cMtHS+eHsGCyXnt4Yq82dDSB7+gSB9Kx5gyGHXvE01lPR
	SoAMigpvs5rbrxPlr9XpLFOt2QGwloq1abNL/+hYLTl5ZBkFL/5h+4IGrbGC4sm3OMZ0sDJ+r7i
	1sWItmtCmeS4D4v8Pjq7MUxiLflC/T9Vt+TVL+eVsEk3Icw45K1yXQ43o8G53+W462O0ks8vrMP
	qFo+iHdUVyj7GhcKF4I2UWVCsyGpzWeKm1b9eaLkPa//yX0YfdJrYhLu4xW+7V6Qi5NjiOlug+F
	5dxdUjfixSXjWp+8xTfItWxWs7ooQGm9YUjhPbTWzEluDEyxrfsHprKvrCWRLInQ/6PeL9L0e9I
	rWDK1arxBHJt6Tn1rHLWZyKwuToLKG9T+o6Q==
X-Received: by 2002:a05:7022:f103:b0:11d:f44d:401d with SMTP id a92af1059eb24-125c0fab3b7mr2177552c88.22.1769812584699;
        Fri, 30 Jan 2026 14:36:24 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:24 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Fri, 30 Jan 2026 14:34:05 -0800
Message-ID: <20260130223531.2478849-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143625_916317_00EFD0E2 
X-CRM114-Status: GOOD (  20.76  )
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

TP8028 Rapid Path Failure Recovery defined new fields in controller
identify response. The newly defined fields are:

- CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
is assigned a random value when controller first created. The value is
expected to be incremented when RDY bit in CSTS register is asserted
- CIRN (Controller Instance Random Number): is 64bit random value that
gets generated when controller is crated. CIRN is regenerated everytime
RDY bit is CSTS register is asserted.
- CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
maximum number of in-progress controller reset operations. CCRL is
hardcoded to 4 as recommended by TP8028.

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery. For NVME subsystem
CQT is set to 0 by default to keep the current behavior. The value can
be set from configfs if needed.

Make the new fields available for IO controllers only since TP8028 is
not very useful for discovery controllers.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ++++++
 drivers/nvme/target/configfs.c  | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 12 ++++++++++++
 drivers/nvme/target/nvmet.h     |  4 ++++
 include/linux/nvme.h            | 15 ++++++++++++---
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3da31bb1183e..ade1145df72d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -696,6 +696,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = cpu_to_le16(ctrl->cqt);
+		id->ciu = ctrl->ciu;
+		id->cirn = cpu_to_le64(ctrl->cirn);
+		id->ccrl = NVMF_CCR_LIMIT;
+	}
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44ef69dffc2..035f6e75a818 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1636,6 +1636,36 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
 #endif
 
+static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
+					  char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
+}
+
+static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
+					   const char *page, size_t cnt)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
+	u16 cqt;
+
+	if (sscanf(page, "%hu\n", &cqt) != 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (subsys->cqt == cqt)
+		goto out;
+
+	subsys->cqt = cqt;
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+out:
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
+
 static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 					      char *page)
 {
@@ -1676,6 +1706,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_cqt,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc88e5a28c8a..0d2a1206e08f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1393,6 +1393,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1661,6 +1665,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->cqt = subsys->cqt;
+		ctrl->ciu = get_random_u8() ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
+
 	/*
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
@@ -1853,10 +1863,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	switch (type) {
 	case NVME_NQN_NVME:
+		subsys->cqt = NVMF_CQT_MS;
 		subsys->max_qid = NVMET_NR_QUEUES;
 		break;
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		subsys->cqt = 0;
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b664b584fdc8..f5d9a01ec60c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -264,7 +264,10 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u16			cqt;
+	u8			ciu;
 	u32			kato;
+	u64			cirn;
 
 	struct nvmet_port	*port;
 
@@ -331,6 +334,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u16			cqt;
 	u16			max_qid;
 
 	u64			ver;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..5135cdc3c120 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,9 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
+#define NVMF_CCR_LIMIT		4
+
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_NSID_ALL		0xffffffff
@@ -328,7 +331,10 @@ struct nvme_id_ctrl {
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
-	__u8			rsvd134[122];
+	__u8			rsvd134[1];
+	__u8			ciu;
+	__le64			cirn;
+	__u8			rsvd144[112];
 	__le16			oacs;
 	__u8			acl;
 	__u8			aerl;
@@ -362,7 +368,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -389,7 +397,8 @@ struct nvme_id_ctrl {
 	__u8			msdbd;
 	__u8			rsvd1804[2];
 	__u8			dctype;
-	__u8			rsvd1807[241];
+	__u8			ccrl;
+	__u8			rsvd1808[240];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.52.0


