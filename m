Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCEC43381
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE84230F9
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE84230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sEBm5e+2rWg4FCoAnUVTk6ZdiX6npIfafIIhftEJ7fs=; b=yIpAyCb7NQq6wBv6fsXm0ZkSU7
	avhWcWwzTukXnGohX5N8aVNW3pgL5P/ePGDkiEPs94DUJ46270YphPJkG1iBI5a0rU7gqMSBrC8Ay
	vGKbh7i8dl998v764iogsgLXHaQMdLY6yGWeeAgKk/VnBA/026fpZASXotWadWRZGLgHDHN+f3N0n
	Q6HyKwlXWxodStfOJZlgt1VWay/ehuxcFgfelYAtAzY2aU1mPGJjtPNKs8yrJiffzXiS0osvYJ4JF
	D7zzTTYjYvcoYzpxC0sajetjWcAZcH0BVX7O+ZzHXm63Bj50khOot/6ELmMJFXkna581vVue5aKi4
	l6blm8Ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxNJc-00080h-8j; Thu, 07 Jan 2021 04:54:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxNJa-0007zL-AR
 for linux-nvme@merlin.infradead.org; Thu, 07 Jan 2021 04:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zG04wH8sasoNYYt9y3PZwGqToDwq8zfHtAw7WaN2IAM=; b=ualtBYjkEuZm2DOvLAnwlpSqwP
 j2h3WVlINxNIBtBJBAYf4x+goRtroojfiR8t5yg1bpWY8OdzKKWeaaMqzlGbjDi+qwnWeONZFWO80
 ABl4SsqaFOVZwnIfRAU196FNtH6/lYT+2zxgawwHvuJXYrEkN0kffqbvHmEKEthXXXXnzE5wUn+FF
 T1gAS0K2+38n2KFIvySLWADqNN3t0DeyGRjXEBApNJYU96XP/Wk2+HkuxZlc6tley0qrIihfDQDIG
 fO68ngpaLMYeRrw/0u7zLNKkiXixPGFFdXUP8cECkYvMPf6cuYExExIxTW3qiY7Y/0Qom70uv/w15
 k9yMooKA==;
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1kxNIw-0032qp-2z
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 04:54:13 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 874042E5EE;
 Wed,  6 Jan 2021 20:53:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 874042E5EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1609995200;
 bh=3YgHGFl18felZ83kME842i5SM4PeeI4/YnHCFSMqkJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CmivVvUAD+Wy8eaomDVbXCVbY5SB6sW+zB+oBM6Dy5FOXOf1TSTOegdgAk3BxMa/u
 urN8hSebE/6Ltr2PFoYQHaKAZTaNQAMMkyHEZh26asX1jtpA7tEVi5SsOrhAjYDmWn
 WRh73OAY9zn450bTwr3p5He054zUTVCv386Zub8Q=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v7 01/16] cgroup: Added cgroup_get_from_id
Date: Thu,  7 Jan 2021 03:30:15 +0530
Message-Id: <1609970430-19084-2-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_045413_292607_2313D5BC 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Muneendra <muneendra.kumar@broadcom.com>, jsmart2021@gmail.com,
 mkumar@redhat.com, emilne@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Added a new function cgroup_get_from_id  to retrieve the cgroup
associated with cgroup id.
Exported the same as this can be used by blk-cgorup.c

Added function declaration of cgroup_get_from_id in cgorup.h

This patch also exported the function cgroup_get_e_css
as this is getting used in blk-cgroup.h

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v7:
No change

v6:
No change

v5:
renamed the function cgroup_get_from_kernfs_id to
cgroup_get_from_id

v4:
No change

v3:
Exported the cgroup_get_e_css

v2:
New patch
---
 include/linux/cgroup.h |  6 ++++++
 kernel/cgroup/cgroup.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 618838c48313..da31b14db198 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -696,6 +696,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
+struct cgroup *cgroup_get_from_id(u64 id);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -743,6 +744,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 
 static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {}
+
+static struct cgroup *cgroup_get_from_id(u64 id)
+{
+	return NULL;
+}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e41c21819ba0..34ebfbeba098 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -580,6 +580,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
@@ -5805,6 +5806,31 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 	kernfs_put(kn);
 }
 
+/*
+ * cgroup_get_from_id : get the cgroup associated with cgroup id
+ * @id: cgroup id
+ * On success it returns the cgrp on failure it returns NULL
+ */
+struct cgroup *cgroup_get_from_id(u64 id)
+{
+	struct kernfs_node *kn;
+	struct cgroup *cgrp = NULL;
+
+	mutex_lock(&cgroup_mutex);
+	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	if (!kn)
+		goto out_unlock;
+
+	cgrp = kn->priv;
+	if (cgroup_is_dead(cgrp) || !cgroup_tryget(cgrp))
+		cgrp = NULL;
+	kernfs_put(kn);
+out_unlock:
+	mutex_unlock(&cgroup_mutex);
+	return cgrp;
+}
+EXPORT_SYMBOL_GPL(cgroup_get_from_id);
+
 /*
  * proc_cgroup_show()
  *  - Print task's cgroup paths into seq_file, one line for each hierarchy
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
