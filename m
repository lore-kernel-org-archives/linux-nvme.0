Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19468C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 00:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B118F603E7
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 00:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B118F603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sguv+UuKhihdO8JYq3VPTflugM8YlozwMMRA6xODfjU=; b=SfS+dI+r3C6hRC
	QHOKlpQWfBSn/Ut/hAJBZGW3XcEXtqnp1EmLG6O4QYpB1wzXeSJmvfrE7/yBflF5qILpd8RXl+Xch
	1OmttiCV+xb4R8zIin7AhFdcUJTjYLUAeUdp3saUoYQNuEVZCUtnrF0Wv5KaG/eAc159uw7VbHBy5
	vrS8BszoVcVuKdmZhZVRnHK1edpNkYjvG/6V78DxwOTIXmcp7/F1tIIAwEGJzmhYyUL/yu2Z4bh8E
	SzUw5Be0v2zBzKM5bOfDBiUVD9v59Km0JelWTMhUyyMzejREsMc3ZZZP/0un9xJTyqvlk1zjD83Rh
	NeezWoADx5YftV/8Jzcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mALlu-00EUAc-Dr; Mon, 02 Aug 2021 00:25:34 +0000
Received: from mo-csw1515.securemx.jp ([210.130.202.154]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mALlT-00EUA8-Hs
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 00:25:09 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1720Oenj025785;
 Mon, 2 Aug 2021 09:24:40 +0900
X-Iguazu-Qid: 34ts0Afxgte1HvvDCT
X-Iguazu-QSIG: v=2; s=0; t=1627863879; q=34ts0Afxgte1HvvDCT;
 m=Z7EySAtOE1bn94zu5SpC2UkEWj1b/5Yfv0uz/zexrj8=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
 by relay.securemx.jp (mx-mr1513) id 1720ObZc002024;
 Mon, 2 Aug 2021 09:24:37 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
 by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id B8D4931B1E;
 Mon,  2 Aug 2021 09:24:37 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
 by Switcher-Post_Send (Postfix) with ESMTP id 96B4A190467A2F;
 Mon,  2 Aug 2021 09:21:24 +0900 (JST)
Received: from localhost [127.0.0.1] 
 by CNN1ESTR04.kioxia.com with ESMTP id 0003KAAAAAA025KH;
 Mon, 2 Aug 2021 09:21:24 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com
 [10.232.20.151])
 by Switcher-Pre_Send (Postfix) with ESMTP id 8BCCBA0093D81;
 Mon,  2 Aug 2021 09:21:24 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 09:24:37 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Mon, 2
 Aug 2021 09:24:37 +0900
From: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Index: AdeHNEBfLn7U7T5+SsyG/rbRVH2ESA==
Date: Mon, 2 Aug 2021 00:24:37 +0000
Message-ID: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.97]
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210801_172507_842318_DCBF71E7 
X-CRM114-Status: GOOD (  14.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently the connection between host and NVMe-oF target gets
disconnected by keep-alive timeout when a user connects to a target
with a relatively large kato value and then sets the smaller kato
with a set features command (e.g. connects with 60 seconds kato value
and then sets 10 seconds kato value).

The cause is that keep alive command interval on the host, which is
defined as unsigned int kato in nvme_ctrl structure, does not follow
the kato value changes.

This patch updates the keep alive interval in the following steps when
the kato is modified by a set features command: stops the keep alive
work queue, then sets the kato as new timer value and re-start the queue.

Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
---
 drivers/nvme/host/core.c  |  3 ++-
 drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66973bb56..3e821a0be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1242,13 +1242,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 }
 
-static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
 
 	nvme_queue_keep_alive_work(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9557ead02..574f956f0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -225,6 +225,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return -EFAULT;
 	}
 
+	/*
+	 * Keep alive commands interval on the host should be updated
+	 * when KATO is modified by Set Features commands.
+	 */
+	if (!status && c.common.opcode == nvme_admin_set_features &&
+	    ((u8)c.common.cdw10 & 0xFF) == NVME_FEAT_KATO) {
+		/* ms -> s */
+		unsigned int new_kato = DIV_ROUND_UP(c.common.cdw11, 1000);
+
+		dev_info(ctrl->device,
+			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
+			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
+		nvme_stop_keep_alive(ctrl);
+		ctrl->kato = new_kato;
+		nvme_start_keep_alive(ctrl);
+	}
+
 	return status;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0015860ec..150ad6d4d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -666,6 +666,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-- 
2.25.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
