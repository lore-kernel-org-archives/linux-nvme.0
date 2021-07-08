Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A5C07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 04:14:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E123761CD1
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 04:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E123761CD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ojab.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UNSvaZY5aXkhrjnhTSvvF1/SBg54RROsr+LdESPmlmk=; b=ELDGsnX/ZEsSMm
	NRzk9IQjJU4YEkf3OrsGXOACCqmzHcPhwF/nOhDK3QBUfhGL2zbcdZIo9/mv9q/cNTstQYsHFqm8S
	a0ZZxH1+KBOXuoaD+AN25V3/tN9K1c9ItQarvJq4PlAJ/G9ZXS2quUs2SCF2Pkr0IK0q3Ou7vsvGU
	BwPgccXbRjSSMd3wJPTQeVJAxUZ5Y9LP98meezcDIAGrwAyWPz80zCUWwx5TscbwUVnoVBBlOmBES
	G9Z66AF5/2ibj3f2mJRSKssk+inldUD5PdTfUIuLz4jYCslWvFYwOMoLq0bOoALr/rJbPwNKPx8XR
	twvKddGriRQmFG5ngQAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1LQB-00G2XR-2g; Thu, 08 Jul 2021 04:13:55 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1LQ7-00G2Wx-Ev
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 04:13:53 +0000
Received: by mail-ed1-x532.google.com with SMTP id l2so6513299edt.1
 for <linux-nvme@lists.infradead.org>; Wed, 07 Jul 2021 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ojab.ru; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8DC/5W7a2ZjGRW72pS9Wz9Hu4dpSMZWy1zKFKxRwSo=;
 b=fRTPQaLWBNlNZg14xejxo9sJQ93B7Q3d1Sq6q9jpD8HeN9jXB9lsd5xU1+siE8qEnA
 KarSt6BNAAAFM9nC7Ft96P1Cr1J88qEZUfogpTn9UQvz2oe57/GEkKzl3whrweBqnpW9
 AbYtxaASkxEcw4VMx6MsDH1HLTntJD+4gdUw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8DC/5W7a2ZjGRW72pS9Wz9Hu4dpSMZWy1zKFKxRwSo=;
 b=WU+TWGRykFImeoaZ6dIW74JVaJPmUohHlrkgak1azPceBVmM2u+vRkVbbH2XKTMVaP
 hu2OSPSdacU94WeLH6O9yObujdydkRNymt8x5+cMiraNCHV+ArGO8n3htGGes1zYiLSx
 GS698NOYZxNoR83d9h82a4OdnznsWEmMlHZafN3dIPLfHvyWILVDpoQ+w6XZbTHVo6Up
 hU6KRYwPPpwh8SwBlGVM4LwQIeHczMT6BrKLSJnflnTHBenNr+1eyCo3x/sFmWz2cCeu
 VZG8rqEgDHqWGHu7GIDOSRYemA+xWlhv7mQVfZgY10Fb7gjOgCWWgz+9326PnbQRBJ6H
 TR5w==
X-Gm-Message-State: AOAM532EwrxxTPU7wePkufxT6VLM8avKCM+K9LGX5Smnd721cVZR46I0
 o93DrhjWBY1DKvDxJL9k94pzmtk+Wsh4Vg==
X-Google-Smtp-Source: ABdhPJy10IYjoMX8MWqF4z8foxMwS5JVW2IDmA57YWTeZlwa/i9he3qSpc9HwZFR39ioPAgVGM3KDQ==
X-Received: by 2002:aa7:d38d:: with SMTP id x13mr34965095edq.23.1625717623404; 
 Wed, 07 Jul 2021 21:13:43 -0700 (PDT)
Received: from ojab.ru ([2a03:e2c0:1ce::2])
 by smtp.gmail.com with ESMTPSA id a22sm271447ejr.53.2021.07.07.21.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 21:13:42 -0700 (PDT)
From: ojab <ojab@ojab.ru>
To: linux-nvme@lists.infradead.org
Cc: ojab <ojab@ojab.ru>
Subject: [PATCH] nvme-pci: Ignore SUBNQN on Samsung 970 EVO Plus
Date: Thu,  8 Jul 2021 04:12:43 +0000
Message-Id: <20210708041241.9177-1-ojab@ojab.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_211352_149783_10D2D3A6 
X-CRM114-Status: GOOD (  10.64  )
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

$ nvme id-ctrl /dev/nvme0  | grep nqn
subnqn    :
$ dmesg | grep NQN
[    2.503640] nvme nvme0: missing or invalid SUBNQN field.

Signed-off-by: Slava Kardakov <ojab@ojab.ru>
---
Not sure if marketing or lspci name should be used, probably doesn't matter


 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..2307fb473e27 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3239,6 +3239,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung SM981/PM981/PM983 */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
--
2.32.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
