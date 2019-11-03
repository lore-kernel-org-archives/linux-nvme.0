Return-Path: <SRS0=k2Ai=Y3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868CACA9EB0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 20:13:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489AA21744
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 20:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qONZaRkj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rP5/Rzck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489AA21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=htnINh4RxcXav+ar07vHTGL2/0WQtHARV8D18m01BRw=; b=qONZaRkjDsjT3L
	kExlLR9r4qFVZIC1dtrEmgPCYfPFJUkyVgtGuqF17/60AQv2oHMCggfqpntwNTQrNRsZgyUA/yE02
	u4o+SP45KyjbpJm2bwxicbz0IIU+DpWnM/0AAW2Wj0R1Hy4jRlcxK+7avmGEd+/bRq1qQIF8bkGwi
	EX9X7uPIh75MznqjfOzUb1sqlOVZvlv34bh/14PAUUoV1dF4uwF4TfchVd9TnL1NXpaaMvpuqnwNW
	mRRGCr4CmoyKI7aZdEeqWR93UIhhHUrYkTGvdQ/ylKkqe42tKEFtFnvBJx9zJ+CHtlBDQ1/W/Rs1x
	uvIZR5swdDeKl3wjmsAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRMFP-0007un-DN; Sun, 03 Nov 2019 20:13:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRMFM-0007uL-LL
 for linux-nvme@lists.infradead.org; Sun, 03 Nov 2019 20:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572811993; x=1604347993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tVA94PK+XVBrznHo56+t8OWbPVmh5ye7hOnhjjBk/MM=;
 b=rP5/RzcksINrtFXMk2vlPkWQhCFiLuLKKbaccd5Cul2bWK2+47KxPozx
 EKqt6J12zpYiYLuPAZRGEZjyLxMhhHP/NWekM2dOcSgsCY1J9B6Ec+XOP
 bEgH3PDt+CwMwomilP2TnaJuFh3k3LBCytGR/Im4Y6z/CD2ovADok6WYI
 mmJ8BxuuRWAR9/t1aMXWPJHrbH1JBPfzp3Jx0H6n+s5NYjAQDggLij8uW
 22u7hCXSNXxc+Eb6etub+VpfnjQk0uqq5XiOFv/mUg+jTPYS2u78VQ0Pj
 hQDKx4V5trm9j1hLPGccBo8TWn4hfihHaTmjFarqjOwLHjcOYhPBMcjRC w==;
IronPort-SDR: mdvyGIXCujfY9qiHY9cv/2sfkhoRX+B2MIAOkyb3JO8+Ij43X/rxvwQF6BapPOaQ0ZQ0u2kPWa
 fcDgF3HL/ZAlmfttuFkJk61D2SeygBzlUQhXncRPYasNBCwjVjgkVWv8q+nDMAQjO2LRiNW+hB
 GzckshQjCr5+DAkHseTzloKzO28h5rOlUytv+OWx0MktTdljhbE3lxtMBj00/SLR/pIqq/q1lE
 dEI3p4wlkppgH+IyItWkheILFPhdBSUsshE7mjgXUJDbCOtMGJemNh4KBuW6BBCOxU3FhDm/Dn
 Jzc=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; d="scan'208";a="123595373"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 04:13:12 +0800
IronPort-SDR: 4iUFh671MWYAwQsqNpvMxA+20+IfJtY2usE/4C4BjPF0abSQagD8sVSxd9HwooEq/P52yTIddi
 gVlElmhgZ2/fXixpWkdHxqBtjJq6EzfdVpnmwSSQqJJ70xxJukhKIYJmj9XEdLrkUhp7G+W+3g
 r5FAVGbc6T058DyS0r5nKTCtaBMaaWrqvGHbXtCRbFNabXCYHnvGnrqMQxuGCW47KH8tFI3KAP
 kvulvhPAWL/SknA6ruzJ8hh4skvWLLHmo+iHn3pEBgGQ/9jRmsm64Exc7L7jvza6E1E0uB2hIo
 VcHwrY304SBkp2yHtftX4D29
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2019 12:08:28 -0800
IronPort-SDR: GNyMWsxojlLmr28+fOeZ2wjdbEFms6y2v1NSHocnFHlzMEAGHZpn7MM3c29wbyvpBlLqI9SYcv
 9P+Za0uCfKA/muu9qYPASoDFnM2NiSCHEWvsYL4soVRzdKsP5ChVhY3Ofk1CGwM9koEYjTh54Q
 C8S2akLZ2XP/LlzbNi5GcqBABLTDPZ+U65ECLMgoPsT8hkpwBiTTWX7mHddLT31rXNn9F3RGp8
 tzMbE5KW15HpCa/+HpodkyQzMXtsbhlmZduGOC2f+8p16QOTV3/kzPyTMFlYcOlfpTIusVRUmS
 k14=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2019 12:13:11 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Always remove processed AER elements from list
Date: Sun,  3 Nov 2019 12:13:10 -0800
Message-Id: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191103_121312_745268_CFB52BB1 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, jthumshirn@suse.de,
 sagi@grimberg.me, dwagner@suse.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Daniel Wagner <dwagner@suse.de>

All async events are enqueued via nvmet_add_async_event() which
updates the ctrl->async_event_cmds[] array and additionally an struct
nvmet_async_event is added to the ctrl->async_events list.

Under normal operations the nvmet_async_event_work() updates again the
ctrl->async_event_cmds and removes the corresponding struct
nvmet_async_event from the list again. Though nvmet_sq_destroy() could
be called which calles nvmet_async_events_free() which only updates
the ctrl->async_event_cmds[] array.

Add a new function nvmet_async_events_process() which processes the
async events and updates both array and the list. With this we avoid
having two places where the array and list are modified.

When the status value is set != NVME_SC_SUCCESS that implies
nvmet_async_events_process() is called from free events context.
In this case after clearing the aen present on the ctrl->async_list we
also loop over ctrl->async_event_cmds[] for any requests posted by the
host for which we don't have the AEN in the ctrl->async_events list.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

Hi,

I've added the code to loop over and clear out outstanding requests
present in the ctrl->async_event_cmds[] for which aen is not generated.
Also updated the patch description.

I did the basic testing create/delete ctrl and enable/disable ns that
did not produced any hands or errors.

Regards,
Chaitanya

Following is the test log if anyone wants to take a look:-

nvmet: adding nsid 1 to subsystem fs
nvmet: creating controller 1 for subsystem fs for NQN \
nqn.2014-08.org.nvmexpress:uuid:a0b58ccb-6b6a-4045-8ee1-641816bf548d.
nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
nvme nvme1: creating 12 I/O queues.
nvme nvme1: new ctrl: "fs"
# nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
/dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
# cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
1
# nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
/dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
# echo 0 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
# nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
# echo 1 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
# nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
/dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
# echo 0 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
# nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
# echo 1 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 


---
 drivers/nvme/target/core.c | 49 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..5f7f6fd864fb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,11 +129,32 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
 }
 
-static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 {
+	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
 	while (1) {
+		mutex_lock(&ctrl->lock);
+		aen = list_first_entry_or_null(&ctrl->async_events,
+				struct nvmet_async_event, entry);
+		if (!aen || !ctrl->nr_async_event_cmds) {
+			mutex_unlock(&ctrl->lock);
+			break;
+		}
+
+		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+		if (status == 0)
+			nvmet_set_result(req, nvmet_async_event_result(aen));
+
+		list_del(&aen->entry);
+		kfree(aen);
+
+		mutex_unlock(&ctrl->lock);
+		nvmet_req_complete(req, status);
+	}
+
+	while (status) {
 		mutex_lock(&ctrl->lock);
 		if (!ctrl->nr_async_event_cmds) {
 			mutex_unlock(&ctrl->lock);
@@ -146,31 +167,17 @@ static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
 	}
 }
 
+static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+{
+	nvmet_async_events_process(ctrl, NVME_SC_INTERNAL | NVME_SC_DNR);
+}
+
 static void nvmet_async_event_work(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl =
 		container_of(work, struct nvmet_ctrl, async_event_work);
-	struct nvmet_async_event *aen;
-	struct nvmet_req *req;
-
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		aen = list_first_entry_or_null(&ctrl->async_events,
-				struct nvmet_async_event, entry);
-		if (!aen || !ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			return;
-		}
-
-		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		nvmet_set_result(req, nvmet_async_event_result(aen));
 
-		list_del(&aen->entry);
-		kfree(aen);
-
-		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, 0);
-	}
+	nvmet_async_events_process(ctrl, 0);
 }
 
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
