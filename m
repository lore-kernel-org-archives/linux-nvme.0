Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1E2C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XKKYG5kA3cx3G1MTuX6QxgWuS6xYl4PcBrY6eWoyfhw=; b=T0inL1uSRJSP7LicEQDVqBZPYM
	58VY1aaJ1sU6yw3Q91le/PAWOWggvsZ91XEz1rqR+DCnHTQAK35QzaDhhD2Ej1wLXHPuPqme7IkF8
	sGrSSz+OKf1kklNZUMFqR/WYcGetVLMCPs3H3ML372bSxXc+MRbGm7ChvxcpKSWv8DfBr75/b4M/4
	1P+U9cJ3HrnHh/UZWf1+3iELz7HxMVuUFZA3YWDMvXSZIppOpcjLjNErIykjzgdHYD40hAkISTGkU
	rhBhayXOFbs+FKReZBgQ7re9y+y8I81MCMe/0T2E2r8F0BxrNqlceOrT7q2pLEwbnp1DW9KoIoTfn
	NgZ41bfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuPgG-0000000HZlH-3pI8;
	Thu, 13 Aug 2026 07:16:48 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuPgA-0000000HZks-0tgu
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 07:16:47 +0000
X-UUID: e35b901096e611f1aa26b74ffac11d73-20260813
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_UNTRUSTED
	SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED
	SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9ef97314-f75b-4a55-90fc-c394ae00e88c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:9ef97314-f75b-4a55-90fc-c394ae00e88c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:166c79d5bd959a94ac7d243c0e46d992,BulkI
	D:260813151627D4SSDGPS,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|136|86
	5|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e35b901096e611f1aa26b74ffac11d73-20260813
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(36.112.176.146)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1358199554; Thu, 13 Aug 2026 15:16:22 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH] nvmet-rdma: fix queue leak when connect backlog is exceeded
Date: Thu, 13 Aug 2026 14:42:01 +0800
Message-ID: <nvmet-rdma-backlog-leak.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_001642_563971_699C4450 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

When pending disconnecting queues exceed the backlog limit, the
connect path only drops the device reference and leaks the newly
allocated queue and its IB resources.

Fixes: badc53620fe8 ("nvme: target: rdma: fix ndev refcount leak on queue connect")
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/target/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bdd28ce99..6273d26cd 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1606,19 +1606,13 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		mutex_unlock(&nvmet_rdma_queue_mutex);
 		if (pending > NVMET_RDMA_BACKLOG) {
 			ret = NVME_SC_CONNECT_CTRL_BUSY;
-			goto put_device;
+			goto free_queue;
 		}
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
-	if (ret) {
-		/*
-		 * Don't destroy the cm_id in free path, as we implicitly
-		 * destroy the cm_id here with non-zero ret code.
-		 */
-		queue->cm_id = NULL;
+	if (ret)
 		goto free_queue;
-	}
 
 	mutex_lock(&nvmet_rdma_queue_mutex);
 	list_add_tail(&queue->queue_list, &nvmet_rdma_queue_list);
@@ -1627,6 +1621,11 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	return 0;
 
 free_queue:
+	/*
+	 * Don't destroy the cm_id in free path, as we implicitly
+	 * destroy the cm_id here with non-zero ret code.
+	 */
+	queue->cm_id = NULL;
 	nvmet_rdma_free_queue(queue);
 put_device:
 	kref_put(&ndev->ref, nvmet_rdma_free_dev);
-- 
2.53.0


