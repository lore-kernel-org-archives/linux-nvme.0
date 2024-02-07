Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D23C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ir0lAfExrc119qZIeaqs/VzjfHBOC+cMp4lHnmCGp/M=; b=tqckCBRA66GCtHKTSXstmKV4bU
	4UXJjHSRMg2wdv5Wkmo+dFB3LWImpg1+4uZZF1yb8Xyss6KksPwKWhGgSlsiFlFRTYgfRJBrqINbf
	VXO7lWiup4A6Vu4BfNwjXUCmNE9gqFhVkzKxKS2qXXTuObP6jq43XU8t7VljldYbqZ6bqBbLA4oNg
	EgsWMpLwMGGA1DmVvqJOZy0rWzGKVE9ohPUTmMoXwRu/LOx1GFvZsgcPVubAD5E8dc4j00sPGoqU7
	sKcDG0XEL9gp9V3lqW6QcRHr6FiPFj+tc5GUDjWi3TllAZ48jmM2jqokevLMAflzBRYYv4TRgZY6B
	nxfblvSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPU-0000000Brl1-1jnR;
	Wed, 07 Feb 2024 21:24:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPS-0000000Brjn-0r7W
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Ir0lAfExrc119qZIeaqs/VzjfHBOC+cMp4lHnmCGp/M=; b=SdaO+GnYKgVBhE//SxtgFlY5Zf
	q1AxC1wxrvP/D1Zp9oMbKqh+/VX2GRDgh8PRQEolGie3I6TKIxTwPRpFjhanP1NA+KmVfz+hGcZ54
	grhvDZqaDBH2WXMM42kzStWNazeYCtWo4/Ya6YlfhWKelcIQZn526Ebjam0mh7n1taRKisUWuU3cY
	p9fwA98md/TBF77bgi6TRad+lVFtsbk346k5wFqNdOckI5kkOeySZ5yuN/kFu07qTeGXDn1foTZ9i
	suyleOIHEjS0pDYe2kRwISfyOdFQEq7JofIuml6PAIjmD8WAoeZIGmEW9E6WDA2OI8tu5I9dYNN73
	i6B2xdiQ==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPL-0000000D7tP-3N7V
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D9F3CE1B22;
	Wed,  7 Feb 2024 21:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4F5C433F1;
	Wed,  7 Feb 2024 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341074;
	bh=EcW0Uvd1iH6MqSOaWYHMXY9UZQX3irxIhUIQ0VTQ0ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+tXltMgTeQcMjczGrETaHPTzOprUUNTYMj+e8mhmqsqxJfCxO2vbgDrRuhSXCST/
	 tHnP3VDcMHlYWMSR1JRXWyDOGZmieDqejmYOd2RSH1aa1yGk7pR0T/XqtMgTc4rarD
	 +e4qXSm4uG3V/UJs5NvkeQXuG6vduHwdDpx4YHUKnR+syMqt2bSDYu8YGhBAyQnn1a
	 oCcAyd4gAPl2NwOGv7NhZqzcBpOPSjtbn6m/6xpLMJGtCJfhfLVUXgSjtJef8JAc9s
	 Wv+/N2X/QJ75ZhD9LzQ/k+5eCRpaX8Ug5fMzNCHOS9AvbU6nri0ALJAw9u3kRRgb5S
	 +DA0yD9WEfabQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 27/38] nvme-fc: do not wait in vain when unloading module
Date: Wed,  7 Feb 2024 16:23:13 -0500
Message-ID: <20240207212337.2351-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212443_092076_6F917318 
X-CRM114-Status: GOOD (  16.83  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 70fbfc47a392b98e5f8dba70c6efc6839205c982 ]

The module exit path has race between deleting all controllers and
freeing 'left over IDs'. To prevent double free a synchronization
between nvme_delete_ctrl and ida_destroy has been added by the initial
commit.

There is some logic around trying to prevent from hanging forever in
wait_for_completion, though it does not handling all cases. E.g.
blktests is able to reproduce the situation where the module unload
hangs forever.

If we completely rely on the cleanup code executed from the
nvme_delete_ctrl path, all IDs will be freed eventually. This makes
calling ida_destroy unnecessary. We only have to ensure that all
nvme_delete_ctrl code has been executed before we leave
nvme_fc_exit_module. This is done by flushing the nvme_delete_wq
workqueue.

While at it, remove the unused nvme_fc_wq workqueue too.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 47 ++++++------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 46cce0ec35e9..cdb1e706f855 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -221,11 +221,6 @@ static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
-static struct workqueue_struct *nvme_fc_wq;
-
-static bool nvme_fc_waiting_to_unload;
-static DECLARE_COMPLETION(nvme_fc_unload_proceed);
-
 /*
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
@@ -255,8 +250,6 @@ nvme_fc_free_lport(struct kref *ref)
 	/* remove from transport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_del(&lport->port_list);
-	if (nvme_fc_waiting_to_unload && list_empty(&nvme_fc_lport_list))
-		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	ida_free(&nvme_fc_local_port_cnt, lport->localport.port_num);
@@ -3893,10 +3886,6 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
-	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
-	if (!nvme_fc_wq)
-		return -ENOMEM;
-
 	/*
 	 * NOTE:
 	 * It is expected that in the future the kernel will combine
@@ -3914,7 +3903,7 @@ static int __init nvme_fc_init_module(void)
 	ret = class_register(&fc_class);
 	if (ret) {
 		pr_err("couldn't register class fc\n");
-		goto out_destroy_wq;
+		return ret;
 	}
 
 	/*
@@ -3938,8 +3927,6 @@ static int __init nvme_fc_init_module(void)
 	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
 	class_unregister(&fc_class);
-out_destroy_wq:
-	destroy_workqueue(nvme_fc_wq);
 
 	return ret;
 }
@@ -3959,45 +3946,23 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 	spin_unlock(&rport->lock);
 }
 
-static void
-nvme_fc_cleanup_for_unload(void)
+static void __exit nvme_fc_exit_module(void)
 {
 	struct nvme_fc_lport *lport;
 	struct nvme_fc_rport *rport;
-
-	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
-		list_for_each_entry(rport, &lport->endp_list, endp_list) {
-			nvme_fc_delete_controllers(rport);
-		}
-	}
-}
-
-static void __exit nvme_fc_exit_module(void)
-{
 	unsigned long flags;
-	bool need_cleanup = false;
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
-	nvme_fc_waiting_to_unload = true;
-	if (!list_empty(&nvme_fc_lport_list)) {
-		need_cleanup = true;
-		nvme_fc_cleanup_for_unload();
-	}
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list)
+		list_for_each_entry(rport, &lport->endp_list, endp_list)
+			nvme_fc_delete_controllers(rport);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
-	if (need_cleanup) {
-		pr_info("%s: waiting for ctlr deletes\n", __func__);
-		wait_for_completion(&nvme_fc_unload_proceed);
-		pr_info("%s: ctrl deletes complete\n", __func__);
-	}
+	flush_workqueue(nvme_delete_wq);
 
 	nvmf_unregister_transport(&nvme_fc_transport);
 
-	ida_destroy(&nvme_fc_local_port_cnt);
-	ida_destroy(&nvme_fc_ctrl_cnt);
-
 	device_destroy(&fc_class, MKDEV(0, 0));
 	class_unregister(&fc_class);
-	destroy_workqueue(nvme_fc_wq);
 }
 
 module_init(nvme_fc_init_module);
-- 
2.43.0


