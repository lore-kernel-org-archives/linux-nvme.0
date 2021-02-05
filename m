Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229CC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:29:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E10F64FBE
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E10F64FBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w5ZobbaZNnVxsBQfy0sVxvEY/nEJ93qpDqFmjxQn/Jw=; b=hJzSOaL5HDyg4IrROpvmZsfZk3
	oICYnugagNtRpMzVHnk0lWM7EPXtJTzzNd1vyX/2l6mLbB/coWmNJU3hicyBQ74/j3X9rTI7JIVls
	go0zZPebRL6ByNHIcOIH1eHK2QVvX5EFhel54hMGdTtB+j3gz1yfdAc6bYU7laQhIbXEaUp2Xwrj/
	QHbmlRd9KNME9bvLYG1sejgBUNFI8Jzx9ZjMYf1BMCZ83+sF3q9PRy29vh8hR0z56YGle4xL95PUD
	YyIfIQU0mp/AgJZoPn1u8bibMTNd78cOGHdFqTe8FQw9uEeR6L38h8ZvrO/CUbhqYVf5fyLw+VJAT
	mjPUjRmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xQt-000252-39; Fri, 05 Feb 2021 09:29:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xQq-000249-Bv
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:29:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EC476AD0B;
 Fri,  5 Feb 2021 09:29:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmet: per-host namespaces masking
Date: Fri,  5 Feb 2021 10:29:26 +0100
Message-Id: <20210205092926.64161-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_042940_622332_AC398886 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Implement per-host namespaces masking, allowing to expose
different namespaces to different hosts connecting to the
same subsystem.
The original method of adding host nqns to the subsystem
takes precedence over the per-host namespace masking.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 16 +++++++
 drivers/nvme/target/configfs.c  | 82 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 21 ++++++++-
 drivers/nvme/target/nvmet.h     |  4 ++
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 613a4d8feac1..d63fd33200db 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -489,6 +489,13 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
+	if (!nvmet_ns_host_allowed(req->ns, ctrl->hostnqn)) {
+		status = NVME_SC_INVALID_NS;
+		nvmet_put_namespace(req->ns);
+		req->ns = NULL;
+		goto out;
+	}
+
 	nvmet_ns_revalidate(req->ns);
 
 	/*
@@ -566,6 +573,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	}
 
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+		if (!nvmet_ns_host_allowed(ns, ctrl->hostnqn))
+			continue;
 		if (ns->nsid <= min_nsid)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
@@ -613,6 +622,13 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
+	if (!nvmet_ns_host_allowed(req->ns, req->sq->ctrl->hostnqn)) {
+		nvmet_put_namespace(req->ns);
+		req->ns = NULL;
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 635a7cb45d0b..5c85291eb16a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -607,6 +607,85 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
+static int nvmet_ns_allowed_hosts_allow_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(parent->ci_parent);
+	struct nvmet_host *host;
+	struct nvmet_host_link *link, *p;
+	int ret;
+
+	if (target->ci_type != &nvmet_host_type) {
+		pr_err("can only link hosts into the allowed_hosts directory!\n");
+		return -EINVAL;
+	}
+
+	host = to_host(target);
+	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+	link->host = host;
+
+	down_write(&nvmet_config_sem);
+	ret = -EINVAL;
+	if (ns->subsys->allow_any_host) {
+		pr_err("can't add hosts when allow_any_host is set!\n");
+		goto out_free_link;
+	}
+
+	ret = -EEXIST;
+	list_for_each_entry(p, &ns->subsys->hosts, entry) {
+		if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
+			goto out_free_link;
+	}
+	list_for_each_entry(p, &ns->hosts, entry) {
+		if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
+			goto out_free_link;
+	}
+	list_add_tail(&link->entry, &ns->hosts);
+	nvmet_subsys_disc_changed(ns->subsys, host);
+
+	up_write(&nvmet_config_sem);
+	return 0;
+out_free_link:
+	up_write(&nvmet_config_sem);
+	kfree(link);
+	return ret;
+}
+
+static void nvmet_ns_allowed_hosts_drop_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(parent->ci_parent);
+	struct nvmet_host *host = to_host(target);
+	struct nvmet_host_link *p;
+
+	down_write(&nvmet_config_sem);
+	list_for_each_entry(p, &ns->hosts, entry) {
+		if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
+			goto found;
+	}
+	up_write(&nvmet_config_sem);
+	return;
+
+found:
+	list_del(&p->entry);
+	nvmet_subsys_disc_changed(ns->subsys, host);
+
+	up_write(&nvmet_config_sem);
+	kfree(p);
+}
+
+static struct configfs_item_operations nvmet_ns_allowed_hosts_item_ops = {
+	.allow_link		= nvmet_ns_allowed_hosts_allow_link,
+	.drop_link		= nvmet_ns_allowed_hosts_drop_link,
+};
+
+static const struct config_item_type nvmet_ns_allowed_hosts_type = {
+	.ct_item_ops		= &nvmet_ns_allowed_hosts_item_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
@@ -647,6 +726,9 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 	if (!ns)
 		goto out;
 	config_group_init_type_name(&ns->group, name, &nvmet_ns_type);
+	config_group_init_type_name(&ns->allowed_hosts_group,
+				    "allowed_hosts", &nvmet_ns_allowed_hosts_type);
+	configfs_add_default_group(&ns->allowed_hosts_group, &ns->group);
 
 	pr_info("adding nsid %d to subsystem %s\n", nsid, subsys->subsysnqn);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..d62a49f8a6e0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -673,6 +673,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
+	INIT_LIST_HEAD(&ns->hosts);
 
 	down_write(&nvmet_ana_sem);
 	ns->anagrpid = NVMET_DEFAULT_ANA_GRPID;
@@ -1225,9 +1226,24 @@ u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
 	return 0;
 }
 
+bool nvmet_ns_host_allowed(struct nvmet_ns *ns, const char *hostnqn)
+{
+	struct nvmet_host_link *p;
+
+	lockdep_assert_held(&nvmet_config_sem);
+
+	list_for_each_entry(p, &ns->hosts, entry) {
+		if (!strcmp(nvmet_host_name(p->host), hostnqn))
+			return true;
+	}
+	return false;
+}
+
 bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 {
 	struct nvmet_host_link *p;
+	struct nvmet_ns *ns;
+	unsigned long idx;
 
 	lockdep_assert_held(&nvmet_config_sem);
 
@@ -1241,7 +1257,10 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 		if (!strcmp(nvmet_host_name(p->host), hostnqn))
 			return true;
 	}
-
+	xa_for_each(&subsys->namespaces, idx, ns) {
+		if (nvmet_ns_host_allowed(ns, hostnqn))
+			return true;
+	}
 	return false;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..7d2e5814cfa3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -70,6 +70,9 @@ struct nvmet_ns {
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
+	struct list_head	hosts;
+
+	struct config_group	allowed_hosts_group;
 	struct config_group	device_group;
 	struct config_group	group;
 
@@ -518,6 +521,7 @@ extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
 extern u64 nvmet_ana_chgcnt;
 extern struct rw_semaphore nvmet_ana_sem;
 
+bool nvmet_ns_host_allowed(struct nvmet_ns *ns, const char *hostnqn);
 bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
