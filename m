Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D783C4727E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E8A221E2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmoOUjpE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n/hLPwt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E8A221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LnpOmDKJUUPPNKSqU5zHpEkG2mmZPXFFgefIL/ntKR0=; b=jmoOUjpE54PxEJsBPDIe26qMK
	ekOxhRkACyEdLvr8SD35lTSQjcxFNIWpL7Te/LZT686HlA2y40xK7lG+MPMlO9RVo110tT5N9vfTF
	aglHGM/r71ppxundufdlvJloDU8SQV6QxPF713/h2hFpVH0A0ASJVd//I9sc+W5hcEPYQ4+LLEfWF
	tLo985G9fy9hXqUaYL8KjfTVJzwhHF9xShxVlSeEv4FmiOosZInBfvVXXI0Cr7xFM4AfnyIJDYk1w
	rxGriCbzAgXrep2OVSeWkFX3yKRp0KYw4NAGSrq1LqNa12C0KGW+VK03AXzbrJRW6n12+NAVfp3+c
	NOi9GYZ3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLb1b-0005Ky-Bi; Thu, 24 Sep 2020 23:51:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLb1Y-0005KW-Ps
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 23:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600991501; x=1632527501;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gRjj5mT7TCSSZhAEtb3yoLiWGTMRh45+tpDD+ENMeqQ=;
 b=n/hLPwt3th6vCNk0Jp3vQdMKIGi2TSTcBDEYDdDyIhi5Jjk+OiBl5B2D
 4zQ0LvtI0AdVz1QnfrmZd2v8VQBY0ZQ84+3rWegRSYUf6qAVhBdLer7os
 5tsGiYZ9QpAyO8FXMC6zGk7LJzTfrNKfhroSA+6FPjFmtuFGSDBVqWhjO
 umY5STXnaMy3+X7dynTnqJXmvlMJ5qZHAnbeXJrRRRQ2L4WMmaIbRFi5i
 OHxg1HOdFEvhRXys/Qke9He3glY7MMrlwsfi18Xq+P5z/5oLkIzAwoEhN
 vSQ+1E2aP6kpnvry6WhqNveojRJE30fyCknK6n5lVbZvMNhnFh7M8BLXK Q==;
IronPort-SDR: iyH1oSW5YHnvmA+PCcGX6z0tr3Yj1nVs1os1STAtjRFWVT3DpHpa5Pfpv8gwGB0L52bIqL2UW0
 w89iOqaVhPFGf9vUkK8ggStMaAZ1w0P6XvfVwN77/mx+EgKpnsLrWUIlj22BhKDEtu9pTUfjCw
 v39tOKWfubYtc97jiCd4mFFZfzd5duALNzF4a/xmMvkUkilw56BI4LXq0fU8mz12kdA6UfUvkD
 Px1TSa4OfUOEz1a86wXZ4R2SQMbiaMJgb5t8wv2EoYUPJx1imrVW7jz8dP9QLMrxpJDzcRqN8J
 5lQ=
X-IronPort-AV: E=Sophos;i="5.77,299,1596470400"; d="scan'208";a="148246936"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 07:51:39 +0800
IronPort-SDR: FJ8+GM+u9TQ1P5vSSUe0/mdNdYgX3lx8y+OZ/XW7ipTpF9Y/B6wuibjToBqIEpMdzYYybvOqY0
 Lofh2XQRpY2w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 16:38:37 -0700
IronPort-SDR: g4c1NPhUvjFZgTsPlLDNtDXR96WtZz4dwqeHUFbmNxmNUDaGRTDEH0NxrxvgQ183STd5vCWo+k
 FGhbHUUxAbSw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Sep 2020 16:51:38 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-loop: use xarray for loop ctrl tracking
Date: Thu, 24 Sep 2020 16:51:29 -0700
Message-Id: <20200924235130.50565-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200924235130.50565-1-chaitanya.kulkarni@wdc.com>
References: <20200924235130.50565-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_195140_997427_3961B90E 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvme-loop ctrls are tracked with nvme_loop_ctrl_list. This requires
an extra locking just for list operations.

The Xarray data structure provides a clear API which handles locking
implicitly so we can get rid of the locking and the list loops if any.

Replace nvme loop ctrl list and its lock nvme_loop_ctrl_mutex with
nvme_loop_ctrls XArray.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 44 ++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d6008cf66a2..1d8e5c4fd293 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -31,7 +31,6 @@ struct nvme_loop_ctrl {
 
 	struct blk_mq_tag_set	admin_tag_set;
 
-	struct list_head	list;
 	struct blk_mq_tag_set	tag_set;
 	struct nvme_loop_iod	async_event_iod;
 	struct nvme_ctrl	ctrl;
@@ -58,8 +57,7 @@ struct nvme_loop_queue {
 static LIST_HEAD(nvme_loop_ports);
 static DEFINE_MUTEX(nvme_loop_ports_mutex);
 
-static LIST_HEAD(nvme_loop_ctrl_list);
-static DEFINE_MUTEX(nvme_loop_ctrl_mutex);
+static DEFINE_XARRAY(nvme_loop_ctrls);
 
 static void nvme_loop_queue_response(struct nvmet_req *nvme_req);
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *ctrl);
@@ -262,12 +260,10 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
+	if (!xa_load(&nvme_loop_ctrls, nctrl->cntlid))
 		goto free_ctrl;
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_del(&ctrl->list);
-	mutex_unlock(&nvme_loop_ctrl_mutex);
+	xa_erase(&nvme_loop_ctrls, nctrl->cntlid);
 
 	if (nctrl->tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
@@ -430,14 +426,10 @@ static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
 {
-	struct nvme_loop_ctrl *ctrl;
+	struct nvme_loop_ctrl *ctrl = xa_load(&nvme_loop_ctrls, nctrl->cntlid);
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_for_each_entry(ctrl, &nvme_loop_ctrl_list, list) {
-		if (ctrl->ctrl.cntlid == nctrl->cntlid)
-			nvme_delete_ctrl(&ctrl->ctrl);
-	}
-	mutex_unlock(&nvme_loop_ctrl_mutex);
+	if (ctrl)
+		nvme_delete_ctrl(&ctrl->ctrl);
 }
 
 static void nvme_loop_reset_ctrl_work(struct work_struct *work)
@@ -572,7 +564,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
-	INIT_LIST_HEAD(&ctrl->list);
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_loop_reset_ctrl_work);
 
@@ -599,6 +590,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_free_queues;
 
+	/* unusual place to update xarray, makes unwind code simple */
+	ret = xa_insert(&nvme_loop_ctrls, ctrl->ctrl.cntlid, &ctrl,
+			GFP_KERNEL);
+	if (ret)
+		goto out_remove_ctrl;
+
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
@@ -621,16 +618,14 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE))
 		WARN_ON_ONCE(1);
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_add_tail(&ctrl->list, &nvme_loop_ctrl_list);
-	mutex_unlock(&nvme_loop_ctrl_mutex);
-
 	nvme_start_ctrl(&ctrl->ctrl);
 
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
 	nvme_loop_destroy_admin_queue(ctrl);
+out_remove_ctrl:
+	xa_erase(&nvme_loop_ctrls, ctrl->ctrl.cntlid);
 out_free_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
@@ -693,20 +688,23 @@ static int __init nvme_loop_init_module(void)
 	if (ret)
 		nvmet_unregister_transport(&nvme_loop_ops);
 
+	xa_init(&nvme_loop_ctrls);
+
 	return ret;
 }
 
 static void __exit nvme_loop_cleanup_module(void)
 {
-	struct nvme_loop_ctrl *ctrl, *next;
+	struct nvme_loop_ctrl *ctrl;
+	unsigned long idx;
 
 	nvmf_unregister_transport(&nvme_loop_transport);
 	nvmet_unregister_transport(&nvme_loop_ops);
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_for_each_entry_safe(ctrl, next, &nvme_loop_ctrl_list, list)
+	xa_for_each(&nvme_loop_ctrls, idx, ctrl)
 		nvme_delete_ctrl(&ctrl->ctrl);
-	mutex_unlock(&nvme_loop_ctrl_mutex);
+
+	xa_destroy(&nvme_loop_ctrls);
 
 	flush_workqueue(nvme_delete_wq);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
