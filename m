Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A25C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iUGfvUGZJFkqQvb1BclrKM+Qvg6hWolmp/RDxiXQRbw=; b=IiTUxeznNdPn8E+9w1IJijUjVZ
	0Y4CFsrm0nHgBaB6vn+VpxGmMnFzrs748iPiA4yABYLSf7Xsbno8C2ROxjNohKZ8Tuk7NYWYMy9h9
	aMRJBpe171TZ3FchpWfJKcWCcrG64mMvuw0+f+6byvVgIJs8q5H/l6u59GqgnCjyLLyu/vsr+sRjA
	8tnSBK1pcG6MB1WGWdfpmbbKSQtApQh5oOLZ+eNRkAudYuhvqr0zHau2W17LTtKHaCRQX43514iZr
	pozvrrl8e+U3a908FjjVyeQLe2NTEb3iXhmMvAekvlaPqZzlNW4nCixYYVJTUOFNiRjADH1n++jt9
	6k3BL3rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1XLj-00FqdE-B8; Wed, 15 Jun 2022 18:02:39 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1XLg-00FqcZ-Ho
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 18:02:37 +0000
Received: by mail-wr1-x42b.google.com with SMTP id c21so16432061wrb.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUGfvUGZJFkqQvb1BclrKM+Qvg6hWolmp/RDxiXQRbw=;
        b=AK1QgD+vMnL2s8hn9Rs7Vedj1AIZHfjCE2hIxnYHZJ4lpUmCgjvWKXcbzGC8iVj8MV
         gQzwhhIoRxdRNJBLgJcnwggEFdzOg68MZFxyGd/Gets0UhBNf8F78pDCqYu/2ZIbqvRX
         uQd3LV/cqOjfgOJ1h0a92XH8ALQooef0NKdiWAM4qYi/4rV6h2RA/nCWB5KP9P5vIdy2
         7Hf2EwO8+Dzxpfp1SpMBaG0PT1sbf1laNy0di+tuatKxFTxNSAADG517SvwPo6l+uMJE
         p18g+/3gyt+PkYwF85WZ1Fgq+RDEYbQIdPqAC/3DwyfnpCrtdKLjca+CDPBMTrufkQTK
         ZMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUGfvUGZJFkqQvb1BclrKM+Qvg6hWolmp/RDxiXQRbw=;
        b=Fc5jvKyGmLQHT/MxzuP9iMTLa28ZyIzWvkkpibDQuEyL4UpR1Ax6qUWT18huQhgo6i
         tdsyC3f3pb0TuSZWPt5KL41PK4DaLUv/ZgcunhpUTUcuYo1iwrBtbmUs/Xxa9tDQvXuu
         MDu1jshgpGKepdnSPrkkDX7mfU93EMMR5MEklXIlqy89DmjYiV2PpM5/ZhuF9arFdxFE
         3t8bIeBhBvqbvxZw7HQ7y2eQZf8VJqGs360VLZmSFLwkOm0ZoVThzP0au+nYlAkZhyeO
         lMlWjLXj/gzy0gyf0DHOpmrhQY5MuLSGW/9oQK3s12wVzXS9XE+kTubYpHCN9XtDVUnK
         g1vg==
X-Gm-Message-State: AJIora+jDzJkIFZIlMdrw0LuK+YaVs5GA09wBZ+Q1ADokKCnh9eyZ2Aj
	YDkTNBSh+d0TdSRh7jIovkE=
X-Google-Smtp-Source: AGRyM1v+Y9UjdqeP6KstzWoGGotBF3Gc8+ogji3NL81O9ayyefisQ0VVM/Stqp8PFsrCdpygu6PVCw==
X-Received: by 2002:a05:6000:1f85:b0:21a:14a0:b03b with SMTP id bw5-20020a0560001f8500b0021a14a0b03bmr961332wrb.355.1655316153785;
        Wed, 15 Jun 2022 11:02:33 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id i30-20020a1c541e000000b0039c15861001sm3113050wmb.21.2022.06.15.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 11:02:32 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: Report model,sn,fw,pci device information during init
Date: Wed, 15 Jun 2022 20:02:13 +0200
Message-Id: <20220615180213.760756-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_110236_631163_23D3C3AB 
X-CRM114-Status: GOOD (  12.85  )
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

SCSI-based device get their identify properties being printed when initialized like :

[    1.245357] scsi 0:0:0:0: Direct-Access     ATA      HGST HTE721010A9 A3M0 PQ: 0 ANSI: 5

When initializing nvme devices, no identification message is reported
making difficult to identify them during the boot process. If the system
crashes during boot process or if the init phase fail, it could be very diffcult
to identify the faulty disk.

This patch reports model, serial, firmware version and pci information
as soon as possible making this early identifying task possible.

Reporting the serial has the interest of being able to ensure which
physical drive is concerned if a hardware replacement is required and
host features the exact same drive multiple times.

A typical output looks like:
[    0.383353] nvme nvme0: pci function 0000:00:03.0
[    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
[    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..0922b7a470b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2987,6 +2987,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (!ctrl->identified) {
 		unsigned int i;
 
+		/* Reporting model, serial, firmware and pci info */
+		dev_info(ctrl->device, "MODEL:%.*s SN:%.*s FW:%.*s PCI_ID:%04x:%04x\n",
+				(int)sizeof(id->mn), id->mn,
+				(int)sizeof(id->sn),id->sn,
+				(int)sizeof(id->fr), id->fr,
+				le16_to_cpu(id->vid),
+				le16_to_cpu(id->ssvid));
+
 		ret = nvme_init_subsystem(ctrl, id);
 		if (ret)
 			goto out_free;
-- 
2.35.3


