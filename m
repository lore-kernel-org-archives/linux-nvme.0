Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3029FCC6B03
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cUZ/0rsLBJbQhMmFG8iM/Pd0Q+znE7amiW02qbYO3kU=; b=mtZutcyPJ86b3Q54Zoww2mnFeh
	4ejHD/v8ItcILZo/62TShx+rscJu3TqC9prdFCy+94qLqZscyJPNh+vGuAu2IfljtuDzD/dLRFzRC
	xoSlOFDx6lQ3xmepxgchl35z8NlIvrNfInQHMhRxoUtB6oo2R7wA7ZJCkkRk0cQY4XaVQc1K0yTvw
	Idg5r4sDIsiaqx2dIU642P0eOI40EIWd98h7S+ObsTQEZhkcEBasMgznnxsQSZ+VcPSdb9h8WIEdg
	XKKmrpCU6Lf9kMgJto54BI+dASMQEEj5+fRziVB1bn+uoTZMRu4yga+xzfWZsN+oOLHtOWeGGG4mO
	owc9Vhug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGXLn-0000000CGnp-16zb;
	Tue, 13 Oct 2026 07:55:07 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGXLf-0000000CGk3-0HPL
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 07:55:06 +0000
X-UUID: 595d07cac6db11f19a56ed5b684f684d-20261013
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:dfaf408a-01ce-4fb0-b0aa-dc6a4f856394,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:dfaf408a-01ce-4fb0-b0aa-dc6a4f856394,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:657ee0eab7da25c614a7b16497f6def2,BulkI
	D:261013155446RZ4F5XBF,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 595d07cac6db11f19a56ed5b684f684d-20261013
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 482625701; Tue, 13 Oct 2026 15:54:42 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: Yao Sang <sangyao@kylinos.cn>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2] nvme: pass partition flags to passthrough checks
Date: Tue, 13 Oct 2026 15:53:24 +0800
Message-Id: <20261013075324.565535-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_005459_779223_0AB990E1 
X-CRM114-Status: UNSURE (   9.39  )
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

nvme_user_cmd() handles NVME_IOCTL_IO_CMD on namespace block devices,
including partitions. It receives flags identifying a partition, but
passes 0 to nvme_cmd_allowed(), bypassing the partition guard and
allowing unprivileged passthrough commands to access sectors outside
the partition.

Pass flags to the permission check, rejecting unprivileged commands on
partitions.

Fixes: 313c08c72ee7 ("nvme: don't allow unprivileged passthrough on partitions")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
Change in v2:
- Correct the Fixes tag as pointed out by Kanchan. No code changes.

 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6539d4750098..f2904c7fe0ab 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -343,7 +343,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ctrl, ns, &c, flags, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
-- 
2.25.1


