Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93878CCA47B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlV3dIPvaKWA7+M0tIEoBUCgebgsvn7zaaO4PhXs6fo=; b=KRFs7fWBOpyQWKnfZomkX8Mb+Y
	0nr4L8uXYkRqgVwhZSFRY96Y6pQPSMRF4uTUltihekO58hBuHpfuP1s++Tto98G09wCltY5zaM9Lk
	vR8NZOT0RXfAeVCBochA4DHcO57IdolOQSif6uLy2jnQLWmBOqi78RxxrXPFVwhlo12if0CWMcyON
	7hBhb9lAeHZIchmTPikFFPrv3Pw4P/9rDuWJH6FULMCUZx1TMbJt40AsgrjPborBJpM4RCEFLRdlb
	zGBb2ptzqb03B4I4t6N708EWOG26/YtxKcGchMG2uR8jGfeA96WtvsZ/tTE1SCu3hjb1T51/vp9Ja
	I64AQFxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzY7d-0068xi-LZ; Fri, 10 Jun 2022 06:27:53 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzY7a-0068vt-IF
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 06:27:51 +0000
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1293610pjq.2
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcfc-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=rlV3dIPvaKWA7+M0tIEoBUCgebgsvn7zaaO4PhXs6fo=;
        b=cARfW3uLjeQWAfAbHIi6Ol7bEqyyKoi+dfCFzQiA01cojWhIgATxAC/3wlr5O5re8X
         +Oz9G9wb8sJMLPIhnNggbv2fYJLUkwFcpEwGf15j2RYkPHNDBKuCQnEnF2bka/JLhSSh
         0KH4QRk5hfj7B+EZlawiLKwxU9etmj5jhIX4wUYipgPoTTNMWVzpdtQ4PqswjI0SLpf2
         ta1hvSqO8qgQQ7nThc7Zc5ojC7ghurxUWUQ6RjNNCJZig9JfXumQBYKmtonIfmH8BT/R
         G5tpSWg94QIuctDowK6S6+bGkE8hl2rXet1AWhCPbh/+vTO7EwII1Y1Knwvt5f65NSOQ
         9WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=rlV3dIPvaKWA7+M0tIEoBUCgebgsvn7zaaO4PhXs6fo=;
        b=v31+86xILbcJUz3JO2s5he23Z0V9l0EtynLi47W4AJ1hxogKEhXulkvxgXmNBDZr5f
         MeLJnVYHUofMCVIzqioxBptuDGSb7NfS1K4JJGjmkYV61yQRFvzFj8LaFDGphWr4d1tY
         hxqfLZfd/orRusbZMVUznXrv802oZ7b8tt8UwDZdJAMWubngWfmgPCqoJG5ckeEkSeCk
         uZinKrzOjU1lHWezRW0oBnXv8YksrWqzL7zC7nS+g4YwzVH5vrfmCd/j2sdogpXAKO3m
         Hu8vQ/jX5mYbIpq0rgG5Va2bvHMvmdKkZ9Akar9w2aLjQU+LjWnKJtAlerXyByNAu/p3
         jXbg==
X-Gm-Message-State: AOAM530MtqCwjnPIU2oZnrvGQVhTILQ/yHfoNpdh6B0RkbqqQgq47zLD
	u8q/y5ezaN5PsblDlZcWj1eyWA==
X-Google-Smtp-Source: ABdhPJy+HnP1U3vBdekMtJ7cnKxj2DpnCawinXE+s2NcRqUQ2jTvUOyjZgC944UNKUxZxK/MFa3N1g==
X-Received: by 2002:a17:90b:1e47:b0:1e6:7d04:2f4 with SMTP id pi7-20020a17090b1e4700b001e67d0402f4mr7100684pjb.93.1654842466115;
        Thu, 09 Jun 2022 23:27:46 -0700 (PDT)
Received: from rasheed-i7-P52.LCFutureCenter.com (211-23-25-187.hinet-ip.hinet.net. [211.23.25.187])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a578400b001dc37aef4ffsm817511pji.48.2022.06.09.23.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:27:45 -0700 (PDT)
From: "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Rasheed.Hsueh@lcfuturecenter.com,
	wuxy23@lenovo.com,
	gwendal@chromium.org,
	rasheed.yh@gmail.com,
	"rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC and Samsung SSDs
Date: Fri, 10 Jun 2022 14:27:34 +0800
Message-Id: <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
References: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_232750_643741_69A3F0F0 
X-CRM114-Status: GOOD (  10.96  )
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

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), UMIS and Samsung has the same issue:
[ 6305.633887] blk_update_request: operation not supported error,
dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0
phys_seg 0 prio class 0

So also disable Write Zeroes command on UMIS and Samsung.

Signed-off-by: rasheed.hsueh <rasheed.hsueh@lcfc.corp-partner.google.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..cddafeaa9fe2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3453,6 +3453,14 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
-- 
2.17.1


