Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B981CD6E6B
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=axhQa4sfcsucw3XCyeUBd0Qzibedn3bLfPLDnK6n8ow=; b=oeaECmrZuIf3PIHMW2EPvuxOjD
	jmD8bU7r7fcyEwKKgPfyA8LCBfSdSiC4lyN7SLv3Nhc378aTtBnp9eV+/sy5M4qKDra3vZ0vdFdJ0
	u8nNsrD501j6epL7uCbMevl+sHBJhqgAo2MMWqaraAl33k7133pAf3lbVLMKuaM/g6/WTAOjFWwTj
	YsWtEJJcI9V0nJcGP4jvwa08l90QLehhAG7XMNZvmaGMxwbtMPQTfV9btyDPnoCe1RaCxd+4z7NTr
	LhfSqTQWCeGYAERgQRxvnVoKO87dEwbPc+6rFnYGSmO9pvfmZogP8q1G5KX4XIKQ2vyIi+qE7F7NZ
	EZaj+5TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV8M0-0000000Gog0-2MlH;
	Thu, 04 Jun 2026 13:43:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV8Lw-0000000GofW-3mWF
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 13:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=axhQa4sfcsucw3XCyeUBd0Qzibedn3bLfPLDnK6n8ow=;
	b=gq4OCKfPOvQxFDr/mFiCZZP5uykC5z7RTvsgm2PhCzF45b1mOHeOgzlM56e8wT4kSe7dY4
	Rhyt9Qe6qjC+/wLbn0k9EAWnv6DMP1KgRRxcKnxspykk78AtrmUIsrNZ6CjDlPwFK3oHxa
	yU23/1jYvxaLh+YQ3Yk9Tm3COgJCuQo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-kRU4fcrdOIyk0ksmqbgVlg-1; Thu,
 04 Jun 2026 09:43:15 -0400
X-MC-Unique: kRU4fcrdOIyk0ksmqbgVlg-1
X-Mimecast-MFC-AGG-ID: kRU4fcrdOIyk0ksmqbgVlg_1780580593
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE982195608D;
	Thu,  4 Jun 2026 13:43:12 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C21E7195608E;
	Thu,  4 Jun 2026 13:43:09 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu
Subject: [PATCH RFC] nvme: fix crash due to invalid cdev teardown
Date: Thu,  4 Jun 2026 15:43:08 +0200
Message-ID: <20260604134308.192478-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E86tdmQfltsaUEg0NF9RW-2JBUiZAwCwSv37pIyQfes_1780580593
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_064321_006488_8C289F31 
X-CRM114-Status: GOOD (  13.88  )
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

In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
nvme_mpath_set_live(), the error is completely ignored. However, during
teardown, nvme_remove_head() unconditionally calls nvme_cdev_del().
This teardown asymmetry leads to a kernel panic if the character device
was never successfully initialized, which might happen in very rare
circumstances.

BUG: kernel NULL pointer dereference, address: 00000000000000d0
 device_del+0x39/0x3c0
 cdev_device_del+0x15/0x50
 nvme_cdev_del+0xe/0x20 [nvme_core]
 nvme_mpath_shutdown_disk+0x38/0x60 [nvme_core]
 nvme_ns_remove+0x177/0x1f0 [nvme_core]
 nvme_remove_namespaces+0xdc/0x130 [nvme_core]
 nvme_do_delete_ctrl+0x71/0xd0 [nvme_core]

Regarding head namespaces, introduce the NVME_NSHEAD_CDEV_LIVE bit to
track the successful creation of the head character device.
nvme_remove_head() now checks this bit before attempting deletion.
Enforcing rollback here is unsafe, as it triggers kobject_init panics
on the embedded device struct during asynchronous ANA retries.

Regarding non-head namespaces, enforce strict failure by capturing the
return value of nvme_add_ns_cdev() and rolling back the namespace's
creation. Because nvme_alloc_ns() completely frees the nvme_ns structure
on error, rolling back is safe here.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c      | 5 ++++-
 drivers/nvme/host/multipath.c | 5 ++++-
 drivers/nvme/host/nvme.h      | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72c50d5e938d..1e24232c0aac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4213,13 +4213,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		goto out_cleanup_ns_from_list;
 
 	if (!nvme_ns_head_multipath(ns->head))
-		nvme_add_ns_cdev(ns);
+		if (nvme_add_ns_cdev(ns))
+			goto out_del_disk;
 
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 
 	return;
 
+ out_del_disk:
+	del_gendisk(ns->disk);
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
 	mutex_lock(&ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..a786eb18735a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -628,6 +628,8 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 		return ret;
 	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
 			    &nvme_ns_head_chr_fops, THIS_MODULE);
+	if (!ret)
+		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
 	return ret;
 }
 
@@ -672,7 +674,8 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		 */
 		kblockd_schedule_work(&head->requeue_work);
 
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
+			nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ccaed0b9dbf..e8833e56e9fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -567,6 +567,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
+#define NVME_NSHEAD_CDEV_LIVE		2
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.54.0


