Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA12C3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yp1N/VMjARrm9g3ra9l/3Gb9KqCB07p0sd+UGqij1no=; b=2G3+IQxO056BBh7WODbC1M23Ys
	mwgeR8rO4FqBSITdOFrvOIKixqgxqGoEgR6JLK4oBHOn76mcYZPl2TPu2uvHeUmrnPI5jI9Ajfd2E
	lOyp5uAcimXgou12D3BYAd0ofm1VDzjnhviq3cCRvSPKa8vnGAcxEw9WBBgJJ7pRYoamqUi4uy6YU
	OTmAzh06z7qp1WZVCeYqAeqnGCAbiMtaeXbJYgKS1Ho0z91Xz7/NvGc/dHBEIKubdww39jIzewhSk
	pQsI3k55WF04dkkXP6uaFVa9nCIaTBotNwt8QhLE5BnGWxh5CY1BqT45LozdifW1xMQOB4rxRGVMK
	pVhrqxaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rt-0000000DYmo-1iq8;
	Wed, 17 Jul 2024 11:03:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rm-0000000DYkO-2bhz
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 11:03:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF7BF616DD;
	Wed, 17 Jul 2024 11:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F730C4AF0E;
	Wed, 17 Jul 2024 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721214225;
	bh=4HLZ2/jXJ7o8YU/0t2OrpwJqyzf/P6fLI0BTvqk/WWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsTIhipxZJGWgWKX8aN1SLbu2/MuPIJb0ltyPkyAGyDpciC8T4UnBkp7zP8ZsRiXl
	 PevrkHSZHMrbumCIA5jkByRt1L4fjsGXDDXW6Khwi5UnA92iHpT+vVHr8Fo15lobUy
	 axE9BpFWFUp7kJxiyBeh/JTWz8m40q0uAdURvelHiEdDn/c38NZcNnfnqsDzxxB7QI
	 FIkfQRfwAcHPLzcI4WgJdFQgPAIqaTtefpASnQutojP2WWeTb7pCnNEYor/f2dq2eE
	 RRy6AHnwqKeI4jkgg1273pkoG1/zzYd2Ca+3u87i5jraXxQ+sRIjouQWKp46tH3+9M
	 obxFEiRUOPF3Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvmet: Implement 'admin_only' authentication
Date: Wed, 17 Jul 2024 13:03:38 +0200
Message-Id: <20240717110338.27332-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717110338.27332-1-hare@kernel.org>
References: <20240717110338.27332-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_040347_308091_E255EE8E 
X-CRM114-Status: GOOD (  16.77  )
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

It might be sufficient to run authentication on the admin queue only,
as this speeds up reconnection quite significantly. So add a configfs
attribute 'dhchap_admin_only' for the 'host' configfs entry to enable
this mode.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c             | 11 +++++++----
 drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
 drivers/nvme/target/fabrics-cmd.c      |  7 +++++--
 drivers/nvme/target/nvmet.h            |  2 ++
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 560321df5bf6..d5aae8d8cc92 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -189,6 +189,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
+	ctrl->dh_admin_only = host->dhchap_admin_only;
+
 	/* Skip the 'DHHC-1:XX:' prefix */
 	nvme_auth_free_key(ctrl->host_key);
 	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
@@ -279,10 +281,11 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 
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
index bd87dfd173a4..807b0904ea88 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2134,11 +2134,34 @@ static ssize_t nvmet_host_dhchap_dhgroup_store(struct config_item *item,
 
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
@@ -2178,6 +2201,7 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
 #ifdef CONFIG_NVME_TARGET_AUTH
 	/* Default to SHA256 */
 	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
+	host->dhchap_admin_only = false;
 #endif
 
 	config_group_init_type_name(&host->group, name, &nvmet_host_type);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 4c392488c451..4af10a78ce69 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -62,6 +62,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
 		}
 		ctrl->concat = true;
+		ctrl->dh_admin_only = true;
 	}
 
 	if (data->napd != 1)
@@ -248,6 +249,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
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
index 1aabf55ef0a8..212fe271c8a4 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -203,8 +203,11 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	bool needs_auth = nvmet_has_auth(ctrl, req);
 
-	/* Do not authenticate I/O queues for secure concatenation */
-	if (ctrl->concat && req->sq->qid)
+	/*
+	 * Do not request authentication for I/O queues for secure concatenation
+	 * or when only the admin queue should be authenticated.
+	 */
+	if (req->sq->qid && (ctrl->concat || ctrl->dh_admin_only))
 		needs_auth = false;
 
 	pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9486b43ab822..129b1cb8a4d1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -249,6 +249,7 @@ struct nvmet_ctrl {
 	u8			dh_gid;
 	u8			*dh_key;
 	size_t			dh_keysize;
+	bool			dh_admin_only;
 #endif
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 	struct key		*tls_key;
@@ -325,6 +326,7 @@ struct nvmet_host {
 	u8			dhchap_ctrl_key_hash;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
+	bool			dhchap_admin_only;
 };
 
 static inline struct nvmet_host *to_host(struct config_item *item)
-- 
2.35.3


