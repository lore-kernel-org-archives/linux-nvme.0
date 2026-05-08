Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A32CD3447
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8pR3Xi1w/njBbvukbsT0Kf6IsgNDSrXrPXmpJ4ZFVA=; b=cKzdFniu6xVWkPrlgUsyRxWZCj
	9Cmo9lVrun+7oKSdqyVRCnlwJCpT+puuN6DIqKm1uXFTmA0Zfso5IYx2ORGR/LH0LwpDZawgopj7n
	8bt6dFFDvP4TeA/7dgoF6Vp8W1Nb852CVRdOitcX+55B1aGzTdz5nkNgj7SfLXpNJeVnRxJ5JR0Ey
	ctCbDlinnJXjhvNCCs+T/unV1NZXRMKg0hFoJlrW+v1hkKrtZqOwPsyaegCo+CkeScncw+sRRNfKx
	17a1XfB4tvYvUJZMeJw1HqRtEdXvERMQQJeVNfRJHoFb3JmiqwQ2lhkYifJa2owa1wUcBgUxKATNB
	jiWnkItQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHzN-00000006BAI-27Du;
	Fri, 08 May 2026 09:59:21 +0000
Received: from out28-44.mail.aliyun.com ([115.124.28.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHzJ-00000006B9L-3mkJ
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 09:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778234354; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=T8pR3Xi1w/njBbvukbsT0Kf6IsgNDSrXrPXmpJ4ZFVA=;
	b=su1bPDvs+T2qlu+k3sub+FE5xh3FWZOk5NLYMfxmXpufCYyXNLBr/f3veQXxFnMBhJXfJ6OJhLMWzeq7muZOMwZR3ZVjF/56B6KZNhiFg776jqXtlCoDwQnSERumsys61aiuzyPHFgGYyjgw8rUj9RzY25oC5HaXfyKX3/43LE/TuoDKwp3gAL2fR+jaRnF64sIBXzksblJL8DsOcvNWPPGMKzLNEFRgcTM3RFvFoiWONzQDg5rk0CT1pS30K2vP1STGGFauGyCZpexb81xSldTcTKMybtb0X62BPY3ZYvx68mtQ2uHCr8jgk9Zh6mvs1zZMN0kuaoymrSu4JmUAeA==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9074157|0.1235179;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.0236421-0.000461084-0.975897;FP=964337513750189831|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hSQR4DY_1778234352;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hSQR4DY_1778234352 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 17:59:13 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"
Date: Fri, 08 May 2026 17:59:12 +0800
Message-ID: <eYKCZ9GBQrCNXs6p0IUx7w@alancui.cc>
In-Reply-To: <af2YtHjq3mhWiyJA@kbusch-mbp>
References: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc> <af2YtHjq3mhWiyJA@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_025918_114076_3BB28D73 
X-CRM114-Status: GOOD (  10.55  )
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

This reverts commit 7f991e3f9b8f044640bcb5fa8570350a68932843 ("nvme: add quirk
NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808")

The incorrect implementations of SUBNQN is a known issue in a massive number of
NVMe units.  However, the warning "nvme nvmex: missing or invalid SUBNQN field."
is usually appropriate and will not affect performance or behavior etc.  That is
because the support for SUBNQN is mandatory if the controller supports NVMe
revision 1.2.1 or greater, and it reported itself without a SUBNQN field which
breaks compliance with the specification. It should be not quirked by the Linux
Kernel.

Signed-off-by: Alan Cui <me@alancui.cc>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..2850fd55894b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4107,8 +4107,6 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c5f, 0x0555),	/* Memblaze Pblaze5 adapter */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
-	{ PCI_DEVICE(0x144d, 0xa808),	/* Samsung PM981/983 */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
-- 
2.54.0





