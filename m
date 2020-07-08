Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E2C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 15:18:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39EF207DA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MoGTBLuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39EF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r0HdL4rQRVvOvtEuk3F2eg2+jYdzTdMjWTIr0MHKdBg=; b=MoGTBLuNF6M4j8l8dgusdTMU7
	ILZvCoTWmQtT+Uc5qheCHLUTSgrcy0ej1Le+k1NLPKG66l2JCt3P8Ik9+0C+GdmRGiYIsvToeHJZs
	3X7zRpBv93XqTrd5rSbGm2MljngVzaqnvwl1KAdBYzSZffoGcucV+78jxxKcBbSfvbIwGbQSFmqNI
	pvYLYPDNDlIkdZYC8XHuY3ZUUpb+xxJHNefwSraYDk8s/dHR2aPbN9rPvh47q4jOzJgjfvgv4p1FP
	yUPJ6DoEfA0x+LoYMZ6l1pMQX2LeT7WCtkdrbVifyyQijPktF2i8oMPLjO5eXkN/yzNVImnlfoD52
	IGDTAEJTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtBpf-0004Dr-Mh; Wed, 08 Jul 2020 15:17:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBpc-0004D4-VL
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 15:17:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 211F868BEB; Wed,  8 Jul 2020 17:17:53 +0200 (CEST)
Date: Wed, 8 Jul 2020 17:17:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 rfc 1/3] nvme: split nvme_remove_namespaces
Message-ID: <20200708151752.GA26154@lst.de>
References: <20200705075935.506535-1-sagi@grimberg.me>
 <20200705075935.506535-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200705075935.506535-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_111757_241596_237BFEDB 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


I find the split rather confusing.  So I looked into alternatives
and found that the state change should just be a no-op for the PCIe
reset case.

So what about something like this ontop of your series?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b3bd9b85656e5..feee55903b1968 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -168,9 +168,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 
 	flush_work(&ctrl->reset_work);
 	nvme_stop_ctrl(ctrl);
-	nvme_prep_remove_namespaces(ctrl);
-	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
-	nvme_do_remove_namespaces(ctrl);
+	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
 	nvme_uninit_ctrl(ctrl);
 }
@@ -4104,8 +4102,16 @@ static void nvme_scan_work(struct work_struct *work)
 	up_write(&ctrl->namespaces_rwsem);
 }
 
-void nvme_prep_remove_namespaces(struct nvme_ctrl *ctrl)
+/*
+ * This function iterates the namespace list unlocked to allow recovery from
+ * controller failure. It is up to the caller to ensure the namespace list is
+ * not modified by scan work while this function is executing.
+ */
+void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
+	struct nvme_ns *ns, *next;
+	LIST_HEAD(ns_list);
+
 	/*
 	 * make sure to requeue I/O to all namespaces as these
 	 * might result from the scan itself and must complete
@@ -4124,13 +4130,9 @@ void nvme_prep_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
-}
-EXPORT_SYMBOL_GPL(nvme_prep_remove_namespaces);
 
-void nvme_do_remove_namespaces(struct nvme_ctrl *ctrl)
-{
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(ns_list);
+	/* this is a no-op when called from the controller reset handler */
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
@@ -4139,18 +4141,6 @@ void nvme_do_remove_namespaces(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
 }
-EXPORT_SYMBOL_GPL(nvme_do_remove_namespaces);
-
-/*
- * This function iterates the namespace list unlocked to allow recovery from
- * controller failure. It is up to the caller to ensure the namespace list is
- * not modified by scan work while this function is executing.
- */
-void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
-{
-	nvme_prep_remove_namespaces(ctrl);
-	nvme_do_remove_namespaces(ctrl);
-}
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
 static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1e74e0d62e2b11..900b35d47ec7ba 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -168,16 +168,17 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	/*
-	 * We don't treat NVME_CTRL_DELETING as a disabled path
-	 * as I/O should still be able to complete assuming that
-	 * the controller is connected, otherwise it'll fail
-	 * immediately and return to the requeue list. only fail
-	 * for NVME_CTRL_DELETING_NOIO
+	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
+	 * still be able to complete assuming that the controller is connected.
+	 * Otherwise it will fail immediately and return to the requeue list.
 	 */
-	return (ns->ctrl->state != NVME_CTRL_LIVE &&
-		ns->ctrl->state != NVME_CTRL_DELETING) ||
-		test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
-		test_bit(NVME_NS_REMOVING, &ns->flags);
+	if (ns->ctrl->state != NVME_CTRL_LIVE &&
+	    ns->ctrl->state != NVME_CTRL_DELETING)
+		return true;
+	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+	    test_bit(NVME_NS_REMOVING, &ns->flags))
+		return true;
+	return false;
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ba5d0cee6df25..c22117cd9b41e2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -552,8 +552,6 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
-void nvme_prep_remove_namespaces(struct nvme_ctrl *ctrl);
-void nvme_do_remove_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0f974f932ac4e0..74cced620b0484 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2620,7 +2620,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->online_queues < 2) {
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
 		nvme_kill_queues(&dev->ctrl);
-		nvme_remove_namespaces(&dev->ctrl);
+		nvme_remove_namespaces(ctrl);
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
@@ -2899,9 +2899,7 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
-	nvme_prep_remove_namespaces(&dev->ctrl);
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING_NOIO);
-	nvme_do_remove_namespaces(&dev->ctrl);
+	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
