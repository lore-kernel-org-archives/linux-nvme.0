Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D0D20672
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jwZWKrQ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="os7AM1F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D0D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vqCcJG3RnUirWZZDbxa+DaPPUF0RyUbGL0/7eqmUqF8=; b=jwZWKrQ+0Wzu5qz+e1yYELZBO
	pVD8ZRGrIrZ+zp5SB8/szXtB94on0fuD/sUVUy/WflHpevoXSb9yhUt2ELl707AgI58kOscpmCFGI
	FOSUHbPRUR8NvoWqLFSy8+Gnf5CWiH2S7ngojBf+pBhI5OhurPQhRL3vNYTMvmDbFthH7A1aIQQCT
	SwDOnqepdB7lSPAdv6KfDpnKHw+eyG/tlHEo6MDEKCMwdF0/BMC6tYkiTgQZMJvbDH14NeC4AK071
	XZpx/WsBkVdVWPq/IXCtUdtMjBuiUqY9jRv8vRLvtKci1t1QQmFtS7ui7QXGfWh26MqB8fMuQj0a7
	efz/4kTAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0bxp-0006DT-VB; Wed, 29 Jul 2020 02:37:06 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bxl-0006Bp-QS
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 02:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595990221; x=1627526221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WQGdDO/z+bY6G0wNHjzIJSeXU3FioBjmoWhDmFz0gKA=;
 b=os7AM1F1VYe9VukZsl1AWW0pDsgctT0vaz1mDt81Jmnz02a+Wk/bmYjL
 O6kXhv1YUllj/WNa8Bez7XReqZAsOj9M0PD2uJNE+cUDj3eqhX6Q7DJz0
 UrE8d6+rMx3HPo602TjKTn63efZ9E/gYyQV1fqJ04Drv2JM+bVzPMpZFz
 Wz4faBeZlcndPIIsBXqDVsdBJRGJ7WWMxMXjqusNbegBUIi5nh713wGBn
 KoVHbNBleOksE6is271QMi1jy3KcNTz6LHT2Xjun8Tk/CkLAOYKDmrpmL
 q4C9iEYHBQZgtFBJbWysX6mKDvwdl+oJTB2QVRsL8JPjHu6nLGNOOki/W g==;
IronPort-SDR: B+NOWL1BvcC9PHd0Z9xYwXQKXuVcGAFcVNZNIUsQWMI6Mu1yFF8UEpAnWTfu9yqQDJ181mDcR3
 mTyeN9edSbOMXUlH0GqNEhIUCtFcQiDlPjyHy3nuYZP4hV4+6v6yfsjX/Mk7Qvwya++ZlYKJVM
 NWqe0r/C2ORKUwCn2KrZ13s6cjgl375B0T+SIsicW11jM7HSwm/WIMOWynFrfuQ8TjGTB0SFPo
 iE1NdRGilGQsjSPEBv8GBGcfFZUBy4N0hkYH5Cpq2k0Kd65PySfUrtIXkMeXcz0DAW0pK9MaQ+
 ieM=
X-IronPort-AV: E=Sophos;i="5.75,408,1589212800"; d="scan'208";a="143706168"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 10:36:55 +0800
IronPort-SDR: w5OK+G4rOiXLuDlWGWFr30dXKjBSJFTGnXZ9dgbh505UJdan/YnXPAGz2uUQsZoLaCJIrEPlce
 IoCASBmKcDhsQAaLhtLPLolW2l1R96ymw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 19:25:04 -0700
IronPort-SDR: k3jzRDzPE0szWDPhE37vNDOlP1kY8k9SLHLlhtMchPkY8v7ollkEfrNA/YlKUtScLSMfMaCFZQ
 TVMcLGvEU1IQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 19:36:56 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-loop: remove extra variable in create ctrl
Date: Tue, 28 Jul 2020 19:36:48 -0700
Message-Id: <20200729023648.38677-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
References: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_223701_992763_C06FD55F 
X-CRM114-Status: GOOD (  13.08  )
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

We can call the nvme_change_ctrl_state() directly and have
WARN_ON_ONCE(1) call instead of having to use an extra variable which
matches the name of the function.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 14d820c9a276..4884ef1e46a2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -444,7 +444,6 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_loop_ctrl *ctrl =
 		container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
-	bool changed;
 	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
@@ -471,8 +470,8 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	blk_mq_update_nr_hw_queues(&ctrl->tag_set,
 			ctrl->ctrl.queue_count - 1);
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE))
+		WARN_ON_ONCE(1);
 
 	nvme_start_ctrl(&ctrl->ctrl);
 
@@ -567,7 +566,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_loop_ctrl *ctrl;
-	bool changed;
 	int ret;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -583,8 +581,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_put_ctrl;
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
-	WARN_ON_ONCE(!changed);
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+		WARN_ON_ONCE(1);
 
 	ret = -ENOMEM;
 
@@ -620,8 +618,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE))
+		WARN_ON_ONCE(1);
 
 	mutex_lock(&nvme_loop_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_loop_ctrl_list);
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
