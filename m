Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1B7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWy1LCv+SyNCVkNOUgdu9HnKb/vfBVCn/0P7dOpjoqA=; b=vDYmvklvT1yTKahRgSQT6LhRJ1
	DNN6MZhY2HUj09BvEpSdqEs1jTO2CeyewRzZMlPZ3RFQ98lR57wFPseOuDDsPLFXltUCKy5etG4YV
	1OaANuxLf9vtVXJAdM47nV5h25Owq5DrbnUSyDFWRLcjYKstOOOpl/bvlC+p20YW30iaKZWxHk+iM
	DnPHCm1srJFJ6SRVXFstApKrH6WQY79IdFlmMC5MC9why4H9mjlV3teHms0+FqhGSH4HJZXQ66OYV
	ulGe4m8nGcSp7ClXcTQzw+Yyd6PI/zZyL8vSAsoRyibv/HBv19sgtcqQS4x/HOTo+3GR/XJ0UcDN4
	+UOWC4JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2CY-005lKA-2m; Thu, 29 Sep 2022 22:40:18 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2CS-005lGv-AL
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:40:13 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 15:40:10 -0700
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Date: Thu, 29 Sep 2022 15:39:54 -0700
Message-ID: <20220929223955.3275715-2-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220929223955.3275715-1-clay.mayers@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_154012_385007_A4D69E82 
X-CRM114-Status: GOOD (  14.56  )
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

There are AENs from alternate command sets that include
extra data in their AEN's CQE.DW1.  For example, the ZNS
Zone-Descriptor-Changed AEN uses it to indicate the NSID
of the event's log page.

NVME_AEN uevent now includes the value of CQE.DW1 as a new
property.  It is only included when non-zero to keep previously
existing uevents unmodified.

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/core.c | 17 ++++++++++++-----
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66446f1e06cf..4fcc7aec5a8c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4615,17 +4615,22 @@ static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
 
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
+	if (aen_data)
+		envp[1] = kasprintf(GFP_KERNEL, "NVME_AEN_DATA=%#08x", aen_data);
+	if (envp[0] && (envp[1] || !aen_data))
+		kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+
+	kfree(envp[1]);
 	kfree(envp[0]);
 }
 
@@ -4799,8 +4804,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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


