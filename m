Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5CC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:37:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1C861027
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C861027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4g/YVb3Fw3eES6mIqhci9aTLLdFQKabSkSrC3mPyttI=; b=A92cGwVGe7w0qUpWVP49A68dW0
	cqKygJz+7JBNVFE01rlrhyFX+hIVuIczQzfPvgozGLriUyMCCXKnph9kfVFxGPmkSZEFVFcGWcIMt
	/O7lHdb1zOgvvMu1UzfowtOxIHJpAwVkJRsG5K90sAtZwB14v7grPyBPBekkCpHLkokOJJkx6w2A2
	LDwEvGBpzQo+pGPlmaArYDMCrWBatyKCDpicR+wvs8XKMj9KAIXd+FuESERZMAl9VGYhC/IJYxt1H
	F/PSeAH3N5BuIyEINGLNTTOhLOqn4BVrqmJEJqOdKlJBxmEko0DpUk+6qRUHG/zM9vPq5/ps87tME
	sA7Hvs0A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbctC-002psW-V1; Wed, 28 Apr 2021 05:37:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrN-002pcN-6n
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 05:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WhZjUz1XcK5Dt0k1qJLyNR5D00bTpEGzQuZPSMdZyJ4=; b=x8YcNvLZn2w+2AJKCg5+e02LRA
 cb4elI5ppAjzB4GzgctnkJJIi3arUQfMAjj0b/4mQbk0HQi+nYmy8sYxK54aRgrpsaKfsKy+zOwmo
 ymE6NfGO2dnhNoN2VgZRZZsgVZS5Po/bwN2OeJhuc/ZfyDSLT6TTMYwcezARKYyfkRYMOEg5+TC9Y
 ar4ZTgjC7G/dhpqE3yC3dE+HC2QjB8RUgca1P2UNzGm3DSeIEQsmwzEBAnmwVXaKnySYJ6Ocr0gkb
 lwCxFilAvxkwiogfwWzNs//ypuBAddeGgqH41cUBq8tIuqpCYrTKYBU1JZ4dILlAMclgjvV9Klr/S
 vSxfhfyg==;
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrK-00HBi0-70
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 05:35:39 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id B335AE9273;
 Tue, 27 Apr 2021 22:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B335AE9273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1619587633;
 bh=zx08FqUZMxPf1wzkIAWqIUYpLbrkGxW8GDEFeG8vI5c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LrTqjFs4cwko+TLHu7vieUtABblVkTwG4GjXH4W38yhCPbHf5CW+OvdzhpzYjwlCv
 GJm988pOKQmfdCS3KSaoa7/D4tqrG5wLY1Ik/vLaUkvkCIwgXGQrGLNKbzqfY3Ktk7
 uycMuoJfNHc8NEBzXBx1+PdoErQuL/e0haPR7+Tc=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v10 01/13] cgroup: Added cgroup_get_from_id
Date: Wed, 28 Apr 2021 04:04:45 +0530
Message-Id: <1619562897-14062-2-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_223538_514943_A3DD7A62 
X-CRM114-Status: GOOD (  15.27  )
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

Added a new function cgroup_get_from_id  to retrieve the cgroup
associated with cgroup id.
Exported the same as this can be used by blk-cgorup.c

Added function declaration of cgroup_get_from_id in cgorup.h

This patch also exported the function cgroup_get_e_css
as this is getting used in blk-cgroup.h

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v10:
No change

v9:
Addressed the issues reported by kernel test robot

v8:
No change

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
index 4f2f79de083e..d2eace88d9d1 100644
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
+static inline struct cgroup *cgroup_get_from_id(u64 id)
+{
+	return NULL;
+}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5cc6..20e5424a8227 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -577,6 +577,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
@@ -5768,6 +5769,31 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
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
