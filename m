Return-Path: <SRS0=EXTw=NF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A7FC4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 12:29:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42A460EE4
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 12:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C42A460EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WxVZ74dBCerQ+V2iYGJ4TUbMcDgdcOh/S5wholfkpx8=; b=iBdQtb2OmVfhqx
	4EFlVx2BubWK66RA2c5Q2fDD4tZm7LfQ/wLXzz23/Z0lYOmk/tGi7t8c5HmMudHkDCoiksUMgWAwW
	fpnzdCt6HPNI5sNb5ncxXJj6RjLlyhIuj70vKvTz39wOZ1RAP4pZxuppmVZFG7660o3X0LhyPOyhP
	TJCmhmKothmJrZj6JVFP5PJ7UEkN+ZSCMwhJ4hsxvzehbK0nD4r7QTGWLVOWCZ7E5mWgtrRQXW9X9
	GSl6v54vlXazrNUmDZgp7lsl2T7yMGaHQtUTog4NKutUtlFsf/BbE32/W7yM2cChSMIIJg94zCwjM
	kIZkxk3Bjsm+Goak7EBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEsmo-00E8uo-Lf; Sat, 14 Aug 2021 12:29:14 +0000
Received: from m12-18.163.com ([220.181.12.18])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEsmj-00E8uU-6W
 for linux-nvme@lists.infradead.org; Sat, 14 Aug 2021 12:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=FEBAb
 0z41a69uH02VlQueHPqb/m3hbUpfZuD7jmfF4M=; b=W6s2iiCR2b/71xhhp4dc0
 BIsULaHHcrfGsnhYR6NS93k6QRQFaZgVsGJS/w7C4BqbGT6q69/GHesjLUfBAMDt
 llRh2MlVLUZrziU8mIjSPBPfAEEbDx1vjzdbsVov6mEAHWQoLcCFuJpsCOFgQ2t3
 PRLctEUTSPPd4xWVc0+a9I=
Received: from nilus-desk (unknown [120.229.1.29])
 by smtp14 (Coremail) with SMTP id EsCowAB3MPvythdhvqorzw--.41063S3;
 Sat, 14 Aug 2021 20:28:35 +0800 (CST)
Date: Sat, 14 Aug 2021 20:28:34 +0800
From: Nil Yi <teroincn@163.com>
To: james.smart@broadcom.com, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: target: clean assoc pointer after releasing its refcnt
Message-ID: <20210814122834.GA67764@nilus-desk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CM-TRANSID: EsCowAB3MPvythdhvqorzw--.41063S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU45fHUUUUU
X-Originating-IP: [120.229.1.29]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiqxPuElUMahkUqAAAsS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210814_052910_601175_3B7634ED 
X-CRM114-Status: UNSURE (   8.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After releasing the refcnt of iod->assoc, we should assign
NULL to it.

Signed-off-by: Nil Yi <teroincn@163.com>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 22b510816..c6c1839b4 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1780,6 +1780,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 
 			/* release get taken in nvmet_fc_find_target_assoc */
 			nvmet_fc_tgt_a_put(iod->assoc);
+			iod->assoc = NULL;
 		}
 	}
 
-- 
2.17.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
