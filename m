Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCCC4727F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D993D20791
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2tCNtlC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h4XKXAfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D993D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ysh3NF7I8JDXpDIWjiX1MKuNxHi545/IXqPjHfLEFrw=; b=g2tCNtlCnwuEO9+uVbIASncID
	K8D/B7jJJ7yKVu7YyuRkIMX+ZeCOLwkI1vNxZ+05au5Ev1QplKpoST+s1EDwBwdV4wNuuWsdyAQF7
	B5SRYoAbXEHnW60npv34rkk5rncpF+amaBKk695Vh1hh0D3OLuaSZkWGniK1P6LD27Md4ddBRa4sR
	KX8n/ore2U1wuOTXPPDdmFk0tRMUPmTJV58V2PhaNg5sPD3Y7bbNiPBr3OoMEDdcKSMzLrKQHXJmv
	4fhvJA9x3/JzlquCqLF8ZYM4uX6nWFekmr3XTdrLXH6rTs2K7KbzMptaS2CmQiXb+7bwTYx6IY6dZ
	dtBdeWE9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNU9x-0005rI-3Q; Wed, 30 Sep 2020 04:56:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNU9u-0005qo-Fi
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 04:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601441767; x=1632977767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3+c+kxtVfDdaXqzBBknirxmVkGbaQD1kxCHQ9vdPemA=;
 b=h4XKXAfze2YGq1E8XJgWrp/b4ium0d9pcu62dkrE2qyloEIcni9rQIJP
 ViZkZ4OoT7htTg7TACaDxI+zxCyMGcs049wMzfkgqqEnPa5+m5linoVwX
 YK5sNLfUfp37fouckrLoN6bXnCByRgz3EdOVlWOkrX9KtnIT0IdvpLkzI
 o4RWEW3Qj0dEdGS7Y9xhLFbOmviBUK78KrLmQt3M5kxF+BxU67BGy4TZs
 LAIMmC5kWpstZQZ5s20IYVaiP5Mn3/R2nrZxa+TJZClrmZ//mu+rc+TTp
 LPI/t1c/RFP8DPab/cfjT43G8CvZoNByly0p+W6JBFKfyVGV4v41rSlqJ A==;
IronPort-SDR: SdRpRnOoI/HWil1OUxq61LsGbaut1+BOrfH8f0F5RO46dh0hGmQB/I0VHgQmVN3kU8aD5AXvpD
 GJtRMYWd7GuSb0fnP/Hktf3Nbk3RuxW/orI1zJLZuxnbrMbcNp3Ga6kV6P3Vf+yvEG2XmiG03O
 KPqOPS2rtIWx3L8X8I5+LQOuLbgYQ6aK1rK8ak59wnq9aipNOintcBt4zExsY1Lr6TnCpzpMFx
 +ntfG76SchlIUMSr7VogD9GM7+9IPBswelM2F1mQ0iPAzZAPFsBxt+08AF/+o1lN4jQw6HJRIK
 2XI=
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; d="scan'208";a="148654586"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 12:56:06 +0800
IronPort-SDR: ss46bgRESHNLT7sT6Mcecx0N9B4VXcDedWoYhrD00VQqp6mj+zuWE1QTNmtlMXfH5gPGT7JVnU
 HiybSdbZ9YSQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 21:42:58 -0700
IronPort-SDR: RI1eAriTiHVQPJArPXFNN5V7BQKjTZ2AH3sRYMDtjzioj+KETPzXXFRd9K1w9gH1jY2p/HcJg8
 dFH71msHhiXw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Sep 2020 21:56:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme-loop: use xarray for loop ctrl tracking
Date: Tue, 29 Sep 2020 21:55:56 -0700
Message-Id: <20200930045557.53669-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
References: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_005606_697068_47828DC1 
X-CRM114-Status: GOOD (  18.20  )
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
 drivers/nvme/target/loop.c | 46 ++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f6d81239be21..2f2e16fb9f29 100644
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
@@ -678,7 +673,7 @@ static struct nvmf_transport_ops nvme_loop_transport = {
 	.name		= "loop",
 	.module		= THIS_MODULE,
 	.create_ctrl	= nvme_loop_create_ctrl,
-	.allowed_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
 };
 
 static int __init nvme_loop_init_module(void)
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
