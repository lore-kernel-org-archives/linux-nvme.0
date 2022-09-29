Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D3C32771
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2sfwxmwd7276rBgUvLAB8Rw9GgNdHCAabFirw6ONDv4=; b=RaQololIW9DpIuVHVvercumYj/
	26sgq1FuJ3rIwofUXZgiJ//DUOf8Mp6n9puJHmzmi5Jsx6OJViX9UBXTxR1/05t2LWL15J1Dj/9Fa
	MwKJVRLa8GUn0adJsO7UDw3IPNXcfWAaj+Ji1Y7s1O0jjw2fSmPJSzX692VYyj5iYt0kfQ/2WFeu1
	gVlCyPUnZ/NH3tlK3/Q3f6IlbtiMCx995nIPHSifLRMjtrOqSFTRq6mCYZXoutXb6wZ62vxdYrH2q
	/QQWy5+hCLBFYTHCFz6Qubv61hdc6Psbn8fSy9mkjtPPW9PBbfRp3nZz1c9VzMY5194v2gkTO01nZ
	wuZMMFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odhEX-000iRd-N9; Thu, 29 Sep 2022 00:16:57 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odhEU-000iQv-K9
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 00:16:56 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 17:16:41 -0700
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: Support user mode processing of ZNS Zone Changed AEN
Date: Wed, 28 Sep 2022 17:16:29 -0700
Message-ID: <20220929001629.2024067-1-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_171654_687285_9B0AB2B9 
X-CRM114-Status: GOOD (  15.69  )
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

From: Clay Mayers <clay.mayers@kioxia.com>

The ZNS Zone-Descriptor-Changes AEN is of type notify and uses CQE.DW1
to convey the namespace of the log page to read. Unhandled notify AENs
now generate an NVME_AEN uevent and include the value of CQE.DW1 as a
new property when non-zero.

All unhandled notify events are include to avoid command set specific
code in the aen handling.  This support is planned to be used by both
zone based applications and another unreleased device with an alternate
command set.

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++--------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66446f1e06cf..fa865b8da1d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4615,17 +4615,20 @@ static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
 
 static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 {
-	char *envp[2] = { NULL, NULL };
+	char *envp[3] = { NULL, NULL, NULL };
 	u32 aen_result = ctrl->aen_result;
+	u32 aen_data = ctrl->aen_data;
 
 	ctrl->aen_result = 0;
+	ctrl->aen_data = 0;
 	if (!aen_result)
 		return;
 
 	envp[0] = kasprintf(GFP_KERNEL, "NVME_AEN=%#08x", aen_result);
-	if (!envp[0])
-		return;
-	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+	envp[1] = kasprintf(GFP_KERNEL, "NVME_AEN_DATA=%#08x", aen_data);
+	if (envp[0] && envp[1])
+		kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+	kfree(envp[1]);
 	kfree(envp[0]);
 }
 
@@ -4748,11 +4751,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		queue_work(nvme_wq, &ctrl->ana_work);
 		break;
 #endif
-	case NVME_AER_NOTICE_DISC_CHANGED:
+	default:
 		ctrl->aen_result = result;
 		break;
-	default:
-		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
 	return requeue;
 }
@@ -4799,8 +4800,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		break;
 	}
 
-	if (requeue)
+	if (requeue) {
+		ctrl->aen_data = le64_to_cpu(res->u64) >> 32;
 		queue_work(nvme_wq, &ctrl->async_event_work);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e..a1bab447dc65 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -299,6 +299,7 @@ struct nvme_ctrl {
 	u16 cctemp;
 	u32 oaes;
 	u32 aen_result;
+	u32 aen_data;
 	u32 ctratt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
-- 
2.27.0


