Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB16C0218B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDoh3i8dpHUu0bvHElCyj+EDEBKjCy2F8ouEiVOk0VU=; b=jQWSHALWQohPk2VEH8/EXLFq2B
	ljtzCZEDhfIgMp6PbbTE0C58z0nPQ2byPm4b/HB6a/e12kTxuydkG2zyn9NyvNvii1YnNvsbZjasl
	MhU3uAtqEeO617fHPTgUxZ+6Qv9MYE8fMnWOXP/VFMW2QtbXZgMYe7nXo3BVv58pZkVF+el7Cqg+U
	+amq1EgxAEhF/EuDa54CZKEa1LgxEIiiXlWHOEQ09YjoH6vAYS3yUNROYPpJiGN3XKHccd3fAUlCG
	LRChR8J7AgZGv+ttz/JbYVpBwEvXE8G5HIQSgkKydA2AJXn4+TTkwV9NQ327S1hTSSfcKtZ2OfUsb
	R0tFcZ+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF1d-0000000EEug-0HAw;
	Fri, 24 Jan 2025 08:26:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF0B-0000000EEcw-1Vgu
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 08:25:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 91B175C5C9A;
	Fri, 24 Jan 2025 08:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D0C4CEE2;
	Fri, 24 Jan 2025 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737707118;
	bh=X71xUrnZf49v5gFjV9szcQZxNbgGeh5wbJw4Ntf1weQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BRfmwz1oJDaVGp7Unq43e4kdGiw1+6WukZdbtDJcNEbqK1Dv3PiBKpj3K0TbpRtVm
	 NpuvUhSFY1KhUpOLuZkYWOAPx5UPJRqqu87GUi1m9/QX7o0UW4ar+CNf3VvFgDrQDb
	 aZ2Uyi+QPiNh/TldHVJk/FMXM518n9sqMPjAlFUWoL8nwaH7ecIzYYCt+r5pPss5Uv
	 mDxwM9mkyD8osbkFyw8itGv+MLmrUAchZ7qqp98vaT/wBszqoMJASpaf3oBeEMP4Ve
	 CU9GMxjsrLw6a10EsQdBzCcjkyTyhULMlV7nPyCr9l2AZ/U8HWFjglMM4y9NyMCUwy
	 zy9KYWAnmhfCg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: move percpu handling into nvmet_ns_{enable,disable}
Date: Fri, 24 Jan 2025 09:25:05 +0100
Message-Id: <20250124082505.140258-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_002519_486920_19634403 
X-CRM114-Status: GOOD (  11.93  )
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

The namespace percpu counter protects pending I/O, and we can
only safely diable the namespace once the counter drop to zero.
So we need to init the percpu counter in nvmet_ns_enable(), and
wait for it to drop to zero in nvmet_ns_disable() to avoid having
I/O pending after the namespace has been disabled.

Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/core.c | 44 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5f7b5d1f78c0..cdf8e16c1c6d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -611,6 +611,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 			goto out_dev_put;
 	}
 
+	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
+		goto out_pr_exit;
+
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
@@ -618,6 +621,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+out_pr_exit:
+	if (ns->pr.enable)
+		nvmet_pr_exit_ns(ns);
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
@@ -643,6 +649,19 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
 	mutex_unlock(&subsys->lock);
 
+	/*
+	 * Now that we removed the namespaces from the lookup list, we
+	 * can kill the per_cpu ref and wait for any remaining references
+	 * to be dropped, as well as a RCU grace period for anyone only
+	 * using the namepace under rcu_read_lock().  Note that we can't
+	 * use call_rcu here as we need to ensure the namespaces have
+	 * been fully destroyed before unloading the module.
+	 */
+	percpu_ref_kill(&ns->ref);
+	synchronize_rcu();
+	wait_for_completion(&ns->disable_done);
+	percpu_ref_exit(&ns->ref);
+
 	if (ns->pr.enable)
 		nvmet_pr_exit_ns(ns);
 
@@ -660,25 +679,7 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	nvmet_ns_disable(ns);
 
 	mutex_lock(&subsys->lock);
-
 	xa_erase(&subsys->namespaces, ns->nsid);
-
-	mutex_unlock(&subsys->lock);
-
-	/*
-	 * Now that we removed the namespaces from the lookup list, we
-	 * can kill the per_cpu ref and wait for any remaining references
-	 * to be dropped, as well as a RCU grace period for anyone only
-	 * using the namepace under rcu_read_lock().  Note that we can't
-	 * use call_rcu here as we need to ensure the namespaces have
-	 * been fully destroyed before unloading the module.
-	 */
-	percpu_ref_kill(&ns->ref);
-	synchronize_rcu();
-	wait_for_completion(&ns->disable_done);
-	percpu_ref_exit(&ns->ref);
-
-	mutex_lock(&subsys->lock);
 	subsys->nr_namespaces--;
 	mutex_unlock(&subsys->lock);
 
@@ -708,11 +709,8 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 
-	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
-		goto out_free;
-
 	if (xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL))
-		goto out_exit;
+		goto out_free;
 
 	subsys->nr_namespaces++;
 
@@ -728,8 +726,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->csi = NVME_CSI_NVM;
 
 	return ns;
-out_exit:
-	percpu_ref_exit(&ns->ref);
 out_free:
 	kfree(ns);
 out_unlock:
-- 
2.35.3


