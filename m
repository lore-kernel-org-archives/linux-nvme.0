Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A181C5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VUudrn7Ii5M81QPfxJwcD4nRJ5I1fQ8gMSvnSKIX/5U=; b=wfOu2bROL+Qe5quEziCfZn7Gsr
	Q5C7uSC1gg1e6AhoTAxwi1AEGcog6R+npBlJj7cw0Y+hWDcldwrjqXKw0DpSJQfcB5/5n11UqL8Hn
	tDYIe5FkbmOZb1jAzgQRmq8KXSvjajfO0r3n+SaFRH44+39lEbdv+uTyPbdQo8BGLAh924v5+siCQ
	JKuKpBwExqsPCJOUpqfDEu+rT5WO3KoyCJwFDERjs53SWQ5FrY6DzLgQwPjKPGjYmHP4U59coyG8w
	REroDMujKNgln9r00i4iBQsuhAZwzJLpXsBHiaBinOz0tYghJDTwqq/cltVUYKwPTntItaGWlQWOn
	jhABCniA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQBc-0000000Buoo-1m4G;
	Mon, 10 Aug 2026 13:37:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQBa-0000000BuhG-1LI7
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 13:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786368962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VUudrn7Ii5M81QPfxJwcD4nRJ5I1fQ8gMSvnSKIX/5U=;
	b=Vttcz8iy8h2HZpkFaZoQSBdqoRhNdKAW5UGaXjsryOQWDqE6x3esumP0jHCtYPLvnWL67d
	p2Eqc2iyLlmrAGZdlRAN/ANNAgpUBHMpU4ShtZpgj5Q7qD7SRZoLURbk+qFogTRvnjvJbs
	6ICAGs5EW2XOEcidTRxEO9cDb2P4smI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-9YiKSSWbO_uM90OzKmzSPA-1; Mon,
 10 Aug 2026 09:33:08 -0400
X-MC-Unique: 9YiKSSWbO_uM90OzKmzSPA-1
X-Mimecast-MFC-AGG-ID: 9YiKSSWbO_uM90OzKmzSPA_1786368787
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C0301800870;
	Mon, 10 Aug 2026 13:33:06 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1148B1800346;
	Mon, 10 Aug 2026 13:33:02 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hare@suse.de,
	hch@lst.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org,
	mlombard@arkamax.eu
Subject: [PATCH] nvmet: fix max_qid race between configfs and controller allocation
Date: Mon, 10 Aug 2026 15:33:01 +0200
Message-ID: <20260810133301.52537-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nn62p8VbaHqYbdXmg9amW4HSEtor5qvmqEd94OoGjKU_1786368787
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_063702_430185_F8CF57D4 
X-CRM114-Status: GOOD (  14.29  )
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

The function nvmet_subsys_attr_qid_max_store() can race against
nvmet_alloc_ctrl() when a subsystem's max_qid limit is modified.

Suppose max_qid is currently 64. If nvmet_alloc_ctrl() executes:
ctrl->sqs = kzalloc_objs(struct nvmet_sq *, subsys->max_qid + 1);
and at this exact point, a userspace process changes max_qid to 128,
nvmet_subsys_attr_qid_max_store() will set the new max_qid value. It
attempts to delete active controllers to force a reconnect, but the
new controller won't be deleted because it hasn't been added to the
subsys->ctrls list yet.

nvmet_alloc_ctrl() then proceeds and adds the new controller to the
subsys->ctrls list. Later, when nvmet_install_queue() is called, it
will see max_qid set to 128, but the memory allocated for sqs is only
sized for 64 entries. This results in a KASAN out-of-bounds warning
and potential memory corruptions.

Fix this by protecting the queue allocations and list insertion in
nvmet_alloc_ctrl() with down_read(&nvmet_config_sem). Because
nvmet_subsys_attr_qid_max_store() acquires down_write(&nvmet_config_sem)
to modify the attribute, this safely prevents the configfs writer from
modifying max_qid during controller creation.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Reported-by: syzbot+2626e846cd2585c9aa67@syzkaller.appspotmail.com
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/core.c | 39 ++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4477c4d6b1ee..4cbc0893eab3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1652,6 +1652,22 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl->changed_ns_list)
 		goto out_free_ctrl;
 
+	/*
+	 * Discovery controllers may use some arbitrary high value
+	 * in order to cleanup stale discovery sessions
+	 */
+	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
+		kato = NVMET_DISC_KATO_MS;
+
+	/* keep-alive timeout in seconds */
+	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+
+	ctrl->err_counter = 0;
+	spin_lock_init(&ctrl->error_lock);
+
+	down_read(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+
 	ctrl->sqs = kzalloc_objs(struct nvmet_sq *, subsys->max_qid + 1);
 	if (!ctrl->sqs)
 		goto out_free_changed_ns_list;
@@ -1669,22 +1685,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
-	/*
-	 * Discovery controllers may use some arbitrary high value
-	 * in order to cleanup stale discovery sessions
-	 */
-	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
-		kato = NVMET_DISC_KATO_MS;
-
-	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
-
-	ctrl->err_counter = 0;
-	spin_lock_init(&ctrl->error_lock);
-
-	nvmet_start_keep_alive_timer(ctrl);
-
-	mutex_lock(&subsys->lock);
 	ret = nvmet_ctrl_init_pr(ctrl);
 	if (ret)
 		goto init_pr_fail;
@@ -1692,6 +1692,9 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
+	up_read(&nvmet_config_sem);
+
+	nvmet_start_keep_alive_timer(ctrl);
 
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
@@ -1721,14 +1724,14 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	return ctrl;
 
 init_pr_fail:
-	mutex_unlock(&subsys->lock);
-	nvmet_stop_keep_alive_timer(ctrl);
 	ida_free(&cntlid_ida, ctrl->cntlid);
 out_free_cqs:
 	kfree(ctrl->cqs);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_changed_ns_list:
+	mutex_unlock(&subsys->lock);
+	up_read(&nvmet_config_sem);
 	kfree(ctrl->changed_ns_list);
 out_free_ctrl:
 	kfree(ctrl);
-- 
2.55.0


