Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E66C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:29:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9059964F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9059964F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LiuaHF1dKGAHP4tDXQvCEevdbHQK9SLR79SWrJhi/0=; b=LZOcNvYkSFl87SCEm9du+0546N
	FeIGnLoCQRdMaMLDss7UY3O6gJJXYt2sUxWzWYtIzZke79KZqhd8tN7j7xfXG7TGugQHd7w8FjmP3
	Ixu3Ai6I3/GT/o1A4qoN6UdjbGn8IqnkcZwwMvD9CVuZcMsb/3baxNeXLy7gNNo6WN89QqV1OCo+9
	Ucjj0jH1uqzsO9bYX1Bv7/MRSyFkRejobBhVGDUvIG4RCcU6dvMke4kHkmWuNy9XuBT2sjfFqBh8D
	4Jn4LM+0oyx4dnLf696qnFkYd+UWqcn8jaj05Q8YMdQcTEJuEsesYEv1jOaEWWkKPsdoEO5v5SPFg
	tGQ788AA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn6k-008bzj-NV; Thu, 04 Mar 2021 12:29:34 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn4Q-008bY8-9V
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:27:14 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id B920422583;
 Thu,  4 Mar 2021 04:19:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B920422583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1614860396;
 bh=wCZ3H7ZLPiSThrQ66uNolV5ziJoTc2JTxT8ozSdc0SE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VLxiewG1lyQmEcI3LdQlDG0584dQE05qd6vouzbUCVehDHrKy6phXa8GexNt77lY3
 ZjULB6Jgrlt/zE3M5t9M33WVo8RNyVoXdRIdSpReyABb+n5rlGE2k8Gp5PHwgMFM6Y
 5cZO10ygbXQd/vmk90w6OXDCPtp+LrfLOeL6TFkY=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v8 02/16] blkcg: Added a app identifier support for blkcg
Date: Thu,  4 Mar 2021 10:57:12 +0530
Message-Id: <1614835646-16217-3-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This Patch added a unique application identifier i.e
fc_app_id  member in blkcg which allows identification of traffic
sources at an individual cgroup based Applications
(ex:virtual machine (VM))level in both host and
fabric infrastructure.

Added a new function blkcg_get_fc_appid to
grab the app identifier associated with a bio.

Added a new function blkcg_set_fc_appid to
set the app identifier in a blkcgrp associated with cgroup id

Added a new config BLK_CGROUP_FC_APPID and moved the changes
under this config

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v8:
No change

v7:
Modified the Kconfig file

v6:
Modified the Kconfig file as per standard specified
in Documentation/process/coding-style.rst

v5:
Renamed the arguments appropriatley
Renamed APPID_LEN  to FC_APPID_LEN
Moved the input validation at the begining of the function
Modified the comments

v4:
No change

v3:
Renamed the functions and app_id to more specific

Addressed the reference leaks in blkcg_set_app_identifier

Added a new config BLK_CGROUP_FC_APPID and moved the changes
under this config

Added blkcg_get_fc_appid,blkcg_set_fc_appid as inline functions

v2:
renamed app_identifier to app_id
removed the  sysfs interface blkio.app_identifie under
---
 block/Kconfig              |  9 ++++++
 include/linux/blk-cgroup.h | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..03886d105301 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -144,6 +144,15 @@ config BLK_CGROUP_IOLATENCY
 
 	Note, this is an experimental interface and could be changed someday.
 
+config BLK_CGROUP_FC_APPID
+	bool "Enable support to track FC I/O Traffic across cgroup applications"
+	depends on BLK_CGROUP=y
+	help
+	  Enabling this option enables the support to track FC I/O traffic across
+	  cgroup applications. It enables the Fabric and the storage targets to
+	  identify, monitor, and handle FC traffic based on VM tags by inserting
+	  application specific identification into the FC frame.
+
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP=y
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b9f3c246c3c9..9204f8f8a932 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -30,6 +30,8 @@
 
 /* Max limits for throttle policy */
 #define THROTL_IOPS_MAX		UINT_MAX
+#define FC_APPID_LEN              129
+
 
 #ifdef CONFIG_BLK_CGROUP
 
@@ -55,6 +57,9 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+	char                            fc_app_id[FC_APPID_LEN];
+#endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
 #endif
@@ -660,4 +665,55 @@ static inline void blk_cgroup_bio_start(struct bio *bio) { }
 
 #endif	/* CONFIG_BLOCK */
 #endif	/* CONFIG_BLK_CGROUP */
+
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+/*
+ * Sets the fc_app_id field associted to blkcg
+ * @app_id: application identifier
+ * @cgrp_id: cgroup id
+ * @app_id_len: size of application identifier
+ */
+static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
+	int ret  = 0;
+
+	if (app_id_len > FC_APPID_LEN)
+		return -EINVAL;
+
+	cgrp = cgroup_get_from_id(cgrp_id);
+	if (!cgrp)
+		return -ENOENT;
+	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	if (!css) {
+		ret = -ENOENT;
+		goto out_cgrp_put;
+	}
+	blkcg = css_to_blkcg(css);
+	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	css_put(css);
+out_cgrp_put:
+	cgroup_put(cgrp);
+	return ret;
+}
+
+/**
+ * blkcg_get_fc_appid - get the fc app identifier associated with a bio
+ * @bio: target bio
+ *
+ * On success it returns the fc_app_id on failure it returns NULL
+ */
+static inline char *blkcg_get_fc_appid(struct bio *bio)
+{
+	if (bio && bio->bi_blkg &&
+		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
+		return bio->bi_blkg->blkcg->fc_app_id;
+	return NULL;
+}
+#else
+static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len) { return -EINVAL; }
+static inline char *blkcg_get_fc_appid(struct bio *bio) { return NULL; }
+#endif /*CONFIG_BLK_CGROUP_FC_APPID*/
 #endif	/* _BLK_CGROUP_H */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
