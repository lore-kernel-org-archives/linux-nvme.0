Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408DCC02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R9eAjJ4t7im4A1K/cc9xt7vD4pFD+mUNQ0KMuBOQaNw=; b=AdaRQsfq6LeA7IEvivC+8WKzQ/
	BrOBipu/WIV/NDLa85ip/CNeT+8ekP+K2AfdIV+CnagwRh3XPczMY+MiopL1QAGlSkfqltwnokSsx
	+5UV7Xwrd9yzzFb97VEHGDbS1E6YcE5ruKxFU1DFUm6sKm3VRjHADzeDyR2rkM3QcEJeibJxOe0/D
	beI2krOfR8Jx387l/pe9Cxeh1MiC9F0/2dRTtL/MUosox0kVEhEVmRlRk/oCnLWkoToOXyNe9Vqyi
	34M0IySSJi1+vOfmNbrh02FGDrK+ORHmA/DSGFxGwpZWSLUVUxb+BRrGUx3j1IxmvHRnBBg7GxEev
	X1PAWBQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgNh6-00000009Xxq-1pxz;
	Fri, 07 Feb 2025 12:42:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgNfz-00000009XqD-3P7r
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 12:41:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1B05B5C5E58;
	Fri,  7 Feb 2025 12:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E313C4CED1;
	Fri,  7 Feb 2025 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932102;
	bh=PiBLBtIHGu5qB7UMvHsFOUPUwnT3adQ5VTbE/0DrFMc=;
	h=From:To:Cc:Subject:Date:From;
	b=vNsg6+lfN5Q6EzJLpakM9LRCRsox/m/UvPDW/ixLv/7GxFVddGdVhbkq0Ivpbxtcl
	 siGpjDK3zL9MSMFfK6rhQ9rkuShAHofJnSh9izt0QdUqKTlqHxbBicdwlCZCrtUWx4
	 kWrBU+uEyczet7uJ3WqLn+GwndxvuVZkrme8Yqlchsdg5Oh3Wh5HDKDYmSPPSGaMY/
	 VDNiM4LYvsfwR6U2sjMDjpDWFB9C49EBqkYhOnJSiqyQ9N+2MR8CQELdPTFccM9JXU
	 FZZQQ4i6STyk5vzbo7BoA4K71dp8SJGZsMCkM1ARex8X4TvY/hobZ8VA2rN/q6EARK
	 Wwhaul5ZjUI9Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Date: Fri,  7 Feb 2025 13:41:34 +0100
Message-Id: <20250207124134.114622-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_044143_938217_AA012713 
X-CRM114-Status: GOOD (  12.80  )
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

The namespace percpu counter protects pending I/O, and we can
only safely diable the namespace once the counter drop to zero.
Otherwise we end up with a crash when running blktests/nvme/058
(eg for loop transport):

[ 2352.930426] [  T53909] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
[ 2352.930431] [  T53909] KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
[ 2352.930434] [  T53909] CPU: 3 UID: 0 PID: 53909 Comm: kworker/u16:5 Tainted: G        W          6.13.0-rc6 #232
[ 2352.930438] [  T53909] Tainted: [W]=WARN
[ 2352.930440] [  T53909] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[ 2352.930443] [  T53909] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
[ 2352.930449] [  T53909] RIP: 0010:blkcg_set_ioprio+0x44/0x180

as the queue is already torn down when calling submit_bio();

So we need to init the percpu counter in nvmet_ns_enable(), and
wait for it to drop to zero in nvmet_ns_disable() to avoid having
I/O pending after the namespace has been disabled.

Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cdc4a09a6e8a..2e741696f371 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -606,6 +606,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 			goto out_dev_put;
 	}
 
+	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
+		goto out_pr_exit;
+
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
@@ -613,6 +616,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+out_pr_exit:
+	if (ns->pr.enable)
+		nvmet_pr_exit_ns(ns);
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
@@ -638,6 +644,19 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
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
 
@@ -660,22 +679,6 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	if (ns->nsid == subsys->max_nsid)
 		subsys->max_nsid = nvmet_max_nsid(subsys);
 
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
 
@@ -705,9 +708,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 
-	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
-		goto out_free;
-
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = nsid;
 
@@ -730,8 +730,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 out_exit:
 	subsys->max_nsid = nvmet_max_nsid(subsys);
-	percpu_ref_exit(&ns->ref);
-out_free:
 	kfree(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
-- 
2.35.3


