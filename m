Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689F606B6DA
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iNaaxBKJ;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DfbTKd0h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WF8tz2VGzlxmux7qLESvzI2gEtLFPUubLy0lnNhCQvw=; b=iNaaxBKJqLd+HO
	uzHLKU+lq1dnWcml9P3W/RDg18skDEXXwigOroROUXjGVsObDSQtp9fNGw+mIjQiOUNSo/zgnMk4H
	K6i3QEe11s4xb6YLTtFLTpuQqGByDCswFVMLkwwXBxujFsuY3ApLKVmjEh6/7CFCApvTOMpjc5b3l
	ZMxZmaCU4koMqFnc+SmLdhG4kBEFraiTH0IWvL5t7xpmjNqfg5wMTKck9Zl1BB4EZoaj6zajYVaWg
	e3c0Qe3IWnjb/Wc1eqk5lc51X76gXVmy8db4adVJNqt4zNAtaiyiygKuclhDnfXrwz5GH/igKXDvR
	RSHHzPgFU0GqNNqrF7wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS460-0000000FAcZ-1BFa;
	Sat, 14 Nov 2026 03:06:28 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45g-0000000FA7q-3oh5
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:17 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1b244fb7fffso1860838c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625568; x=1795230368; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WF8tz2VGzlxmux7qLESvzI2gEtLFPUubLy0lnNhCQvw=;
        b=DfbTKd0hZb26jzPBWgJAw6brJnkKtwWCZkqNwxuAcl4ExlhyT2BwnVJW6QQH5WMhsx
         Mr5IuJ76VV5mSpNEXA+SVwohlAgnTx9uBGQtrmNs4EwJtKi414pf5qF+yd9aj36ZtGwi
         +ixwLVPx5a+zM3FO5J0f/Vaix+D+iHDbsJnjJNkmj7IxaPaLdkSetRkLJRiz4Jj7St3w
         z8caMwFMxoBOvFm3FkWcvpZK8qcGQh9zyPFAjN8bgHnQrnnd4gvRcXzsPLQngYjHR+uY
         dx2VqXcUsEuPf3OIhTeX9Izlum7jkcEO0hNDuYB6SIZ0KAOkiTCKhJw7oxY6CCUQ/xrb
         8f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625568; x=1795230368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WF8tz2VGzlxmux7qLESvzI2gEtLFPUubLy0lnNhCQvw=;
        b=GsVkzb+c34YDvStJJ7DyTezqRu92iRSMXNx3A4SH6IrTCfqCmBtlX5Cp4cgatDtkUX
         rDhfax4Sxdb4/CxcFc4H/d5H6jh/Kvqk3lh7cbmreR8j70SzUCfCpo7Tpog9zkL1B6M1
         gtOv7t0bdGzc0++OLBjiWCnMlXQYyuTMUmon6KNjWjCmDFiYxqoE41netJ1+eCfzlKlC
         1/JbOhFrxRxJVlQgSzQlYqYDQPcH5s/TADIUmtVCXo3pkWWOXxOPylIBVI7uBk+xoBUU
         aYIKzsIA+8iJGYiJPzT+ZT534jjppjfGzmk53r9vbQct8u8Z6HKRPK6Mv6dnj4n2nFjF
         4SWQ==
X-Forwarded-Encrypted: i=1; AL+hErFmjbRKTd+G4zHnIQbeOOTfZkR9miXY6ZFppzEFZPz5iqN7Z1pY1Jl91X+MB1fafYrNSbzPOGhDnxE1@lists.infradead.org
X-Gm-Message-State: APuU4Z+d7bSkhGnLiBx2AlZ9CxCzW+PWJunx+RZLBWCjYDHDM+xUuRzL
	0stEccBcHkt+eDeyvqbudkKcM6VYTwsaXuEiO750r+xSeA89u90rM+YiV1FFX+AxXuo=
X-Gm-Gg: AYBFou0muLGK8Jb1wJ1mkRsg43Sn6Gui2WTUlA6LRsNsKFk76NrWMo4OWXuZJQjti3s
	3TqPY30uoAbc1rETBoMt2ODYgUcy0d3lydE+yOcnIEWa/xvPkLOBRey40oCTqeXotHREAqjU8tj
	IOG1fa0IhJGdjmLaCDNI/gi35b05A4EEBvZZSxOcMyFVnTOUGbuB+c3TwnrAUlGuRQkpnO4glFg
	UT9V4YJaeYBSNx7wx9KHR/Ha5eJKDLO1q/uKSeDMpXFSvlXxpPOanr6k57jPW6sC8EZX8BwQKho
	PxfNbRyg/TnCkPUQCOKq//ctCPM7mUKCK8ZFeDWrL9dkyxTJZN1NoeMyKX08QW+aq4qk93dEV2e
	0mbyi+DFiFABGoavF3QzRujjXU+BUyVnbqYGqa9YBtOtSFFvC17CsfBeXlDGWvFkNygWUk8Zu21
	SJJmnZKvrtSbspTjuX6/18s5Uu57wF8AgdJcCZGj/NMF80DlM3IZgdruSE6etsB+l6I3p0OT49c
	PvTO/t3Xl8ueBNITQ4B+QQheOXz8dTUrwwHXBP5VFJ+hBkW3Szk4RQjKmmfMvGQA28rQ9T3L+/l
	l/Xyr5+mpO+qjBzIKiKojdArfcl0SANEQ+JyYF8OA5RkKQ3oq6FxCA==
X-Received: by 2002:a05:7022:92a:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1b5030e9a6emr5924881c88.11.1794625567732;
        Fri, 13 Nov 2026 19:06:07 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:07 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/17] nvmet: Add support for CQT to nvme target
Date: Fri, 13 Nov 2026 19:04:30 -0800
Message-ID: <20261114030454.2836543-17-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190609_099210_B0CBB7D0 
X-CRM114-Status: GOOD (  18.49  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery. CQT is added as a
subsystem attribute that defaults to 0 to maintain the current behavior.
Changing attr_cqt disconnects the existing controllers of the subsystem
so that hosts reconnect and read the new value.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/admin-cmd.c |  1 +
 drivers/nvme/target/configfs.c  | 36 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 +++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  5 ++++-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e13ffd17669b..76d65cca25dc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -748,6 +748,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = cpu_to_le16(ctrl->cqt);
 		id->ciu = ctrl->ciu;
 		id->cirn = cpu_to_le64(ctrl->cirn);
 		id->ccrl = NVMF_CCR_LIMIT;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index bde94656e4b7..babc4c7101f5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1770,6 +1770,41 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
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
+	if (nvmet_is_disc_subsys(subsys))
+		return -EINVAL;
+
+	if (sscanf(page, "%hu\n", &cqt) != 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	if (subsys->cqt == cqt)
+		goto out;
+
+	subsys->cqt = cqt;
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+out:
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
+
 static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 					      char *page)
 {
@@ -1812,6 +1847,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_cqt,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 12ab522ea5a1..8a3e51d573d4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1794,6 +1794,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	ctrl->cntlid = ret;
 
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->cqt = subsys->cqt;
 		ctrl->ciu = get_random_u8() ? : 1;
 		ctrl->cirn = get_random_u64() ? : 1;
 	}
@@ -2022,10 +2023,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
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
index 2cdfa1165292..911ad2b997f7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -275,6 +275,7 @@ struct nvmet_ctrl {
 	uuid_t			hostid;
 	u16			cntlid;
 	u16			max_qid;
+	u16			cqt;
 	u8			ciu;
 	u32			kato;
 	u64			cirn;
@@ -366,6 +367,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u16			cqt;
 	u16			max_qid;
 
 	u64			ver;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 96b71aaad630..6d413f2ca3d5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,7 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
 #define NVMF_CCR_LIMIT		4
 #define NVMF_CCR_PER_PAGE	511
 
@@ -368,7 +369,9 @@ struct nvme_id_ctrl {
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
-- 
2.56.0


