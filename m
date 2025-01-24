Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A9C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SKyks/XcI82NvgAffSKpPLMx3U9B5xsJtFlskW/m+8=; b=xyVJlv6woJuTM4yiHABCisHnxR
	iefTAHOahxZhOOTDq0wU9A71AYkxk2Fvtm7UrolkVGAweqfoVrgatGR4XMlTgExLIonWWFx93hZPp
	LwyGt9Feh9FnnUejY6xOwwaY3fWzZnqY/dM/7ZBj7CdiwYQYvWS1Lonr2yofYo6+pXr6sCJ4lhLeF
	ns/zzVVkbGEnj1vWoq1VqfmpQNY01zxSMF8lDiFNPyjNMrsYzPx7PpspoE5c6BZcKM5GG75FaxJWt
	dWZIN7l609uUd8i+RVapTyU97ki3rZE/1QhlyqguyCXGZVTMVZt5XqXKSgwi8l6WNtCZYCei61ETf
	2oMjXagw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA9-0000000EbLb-1Jnt;
	Fri, 24 Jan 2025 11:47:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA4-0000000EbJg-3wo8
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:47:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DB19C5C5E94;
	Fri, 24 Jan 2025 11:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFCBC4CED2;
	Fri, 24 Jan 2025 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737719263;
	bh=dAenMzb8Xx+yuqMgxLah03sZflXskvPadaVPLdox1kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6Ig1XmO/VXnmLIyieZ0ZZe3fbwUe8uUP4mz/hdfHoX5aKkSUF2qVuKkKaufMbA5D
	 HwVTkizZi+FpsLtMcFQ2Bz6YacT53d6CP0YocLblbpG+5m1mm4NYn8d0y2kNfwZviM
	 1m4xgsHnvyt7DsG6l4z6WYx6UUFY2fds2Ex/mTrwaYSnG4ybDPPR9SfO8H7OXLQOT1
	 3Jw+9UKMHLvxXC1RdBoHsPg/ezrSw/J2wcZ8UbbO2F4YwVY0GvUqP104W0fZ6qUazk
	 aCS8a8hpGK1sb4gCyl9mOHPuPuvRpNllCRa2MSX3HhGsLn3plVDsMsFHpBp4jCHFXm
	 iD2L+wJhDmhWg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvmet: Implement 'admin_only' authentication
Date: Fri, 24 Jan 2025 12:47:37 +0100
Message-Id: <20250124114738.115882-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250124114738.115882-1-hare@kernel.org>
References: <20250124114738.115882-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_034745_076626_C0E56EA6 
X-CRM114-Status: GOOD (  17.48  )
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

From: Hannes Reinecke <hare@kernel.org>

The spec allows for authentication to run on admin queues only, and secure
concatenation even requires it. So add a configfs attribute 'dhchap_admin_only'
to the target configuration to allow for testing independently of secure
concatenation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c             | 11 +++++++----
 drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
 drivers/nvme/target/fabrics-cmd.c      |  4 ++--
 drivers/nvme/target/nvmet.h            |  2 ++
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 0b0645ac5df4..70c8ad25277f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -190,6 +190,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
+	ctrl->dh_admin_only = host->dhchap_admin_only;
+
 	/* Skip the 'DHHC-1:XX:' prefix */
 	nvme_auth_free_key(ctrl->host_key);
 	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
@@ -280,10 +282,11 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 
 bool nvmet_check_auth_status(struct nvmet_req *req)
 {
-	if (req->sq->ctrl->host_key &&
-	    !req->sq->authenticated)
-		return false;
-	return true;
+	if (!req->sq->ctrl->host_key)
+		return true;
+	if (req->sq->qid && req->sq->ctrl->dh_admin_only)
+		return true;
+	return req->sq->authenticated;
 }
 
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index f59598766fce..9fd98395f219 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2219,11 +2219,34 @@ static ssize_t nvmet_host_dhchap_dhgroup_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
 
+static ssize_t nvmet_host_dhchap_admin_only_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_host *host = to_host(item);
+
+	return sprintf(page, "%d\n", host->dhchap_admin_only);
+}
+
+static ssize_t nvmet_host_dhchap_admin_only_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_host *host = to_host(item);
+	bool val;
+
+	if (kstrtobool(page, &val))
+		return -EINVAL;
+	host->dhchap_admin_only = val;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_admin_only);
+
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_ctrl_key,
 	&nvmet_host_attr_dhchap_hash,
 	&nvmet_host_attr_dhchap_dhgroup,
+	&nvmet_host_attr_dhchap_admin_only,
 	NULL,
 };
 #endif /* CONFIG_NVME_TARGET_AUTH */
@@ -2263,6 +2286,7 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
 #ifdef CONFIG_NVME_TARGET_AUTH
 	/* Default to SHA256 */
 	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
+	host->dhchap_admin_only = false;
 #endif
 
 	config_group_init_type_name(&host->group, name, &nvmet_host_type);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index a7135b90f915..96d56ab2465f 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -62,6 +62,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
 		}
 		ctrl->concat = true;
+		ctrl->dh_admin_only = true;
 	}
 
 	if (data->napd != 1)
@@ -253,6 +254,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			offsetof(struct nvmf_auth_send_command, tl);
 		goto done;
 	}
+	if (req->sq->qid && ctrl->dh_admin_only) {
+		pr_debug("%s: ctrl %d qid %d reject authentication on I/O queues\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
+		goto done;
+	}
 	if (!nvmet_check_transfer_len(req, tl)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
 		return;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 9c01a4b6e543..068494616a3e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -239,8 +239,8 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	bool needs_auth = nvmet_has_auth(ctrl, sq);
 	key_serial_t keyid = nvmet_queue_tls_keyid(sq);
 
-	/* Do not authenticate I/O queues for secure concatenation */
-	if (ctrl->concat && sq->qid)
+	/* Disable authentication on I/O queues if requested */
+	if (ctrl->dh_admin_only && sq->qid)
 		needs_auth = false;
 
 	if (keyid)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4dc7ba5d02a7..49e964b321c0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -301,6 +301,7 @@ struct nvmet_ctrl {
 	u8			dh_gid;
 	u8			*dh_key;
 	size_t			dh_keysize;
+	bool			dh_admin_only;
 #endif
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 	struct key		*tls_key;
@@ -379,6 +380,7 @@ struct nvmet_host {
 	u8			dhchap_ctrl_key_hash;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
+	bool			dhchap_admin_only;
 };
 
 static inline struct nvmet_host *to_host(struct config_item *item)
-- 
2.35.3


