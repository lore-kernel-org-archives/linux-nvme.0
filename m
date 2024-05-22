Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA5BC25B77
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AQEgoHq2Ef+3nj8kds9/k6oI4sPT8Dw8D2npVcm6CUg=; b=CObF5C4YjXa4YHQrnXrNz28j2p
	sZ0CxdlSyecTfLGtHCdZE5lUbFhaW913J/LC2rDh9IT4339n2CeXLnNG4V9PnPROpKgutECH+gppv
	hMe2UWTk6HFTqF9t9QvARtolo85JNmbzfHRzWY60ffr4fwsmBzLBlJdfJKOFNHxhTrzLtZjgyVaOe
	L93Tx9pqPmBe90VQSiboYyvQ11CksE2qF6Pmtf8W69FHWBya5UCPztuUmH27/07XmXdxA8K2yuFj7
	LerIU5fc7kLFHZL/EOaCyO6IPqRXZn3wG9hIR22BFaFjkDggj5GZ6HIGB3oJyenKQLtd6g7KM8Ojj
	YUbTKsEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9i4U-00000002TOE-1xiN;
	Wed, 22 May 2024 09:15:42 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9i4R-00000002TNe-3Djm
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 09:15:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34ef40fae25so167068f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 02:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369336; x=1716974136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQEgoHq2Ef+3nj8kds9/k6oI4sPT8Dw8D2npVcm6CUg=;
        b=XGc+g4ct/A2xJFnKPex/UQWgvxgpn1j1UERy0r4BJILCls1NTKR8Ca6LIutpU40oDz
         EHEmtGrDCeVag9IwPsujDo0MKRDE+WR2GSgXPAgE2g1ITKbmMEKXk6YpXr+ISwwK66Oo
         kTZL2JxM9us40zSErgAFGSMRoKP7ZF2aKL0L5/2kiRK3b3E/sfA4SDQEdGRC0eEFI/tf
         iAI3mbOMeIoapBr/70y0oxAyhA9OxFWEma0nO28XmJtPqxtlic41fUECXwWS+AyEPuP+
         9+esfZcKCPldXVStQzl4i9L6QQdPfyhO3GRCDZK0qoC6SKL0MyzrcZSNQ1I0pYJehfjM
         KXRw==
X-Gm-Message-State: AOJu0YwGd5HyIfnJDX/H6HS1YspIkLmK+fo9q5yn7D4SKBxmdIfk0tzY
	qCs2cFpeJzNW65wXsHJpjjsrx1Kds/yp2rDj7GZcj/E4KfcCgP4Wru48OA==
X-Google-Smtp-Source: AGHT+IFQIPnI9IiGqt7bQijlpkY5j+K7rsEeJX1EEp7aH6P0PKeOMAEsztsGK5ttRy+Jvb3iiXSwuw==
X-Received: by 2002:a5d:5f48:0:b0:34d:9d4c:53ec with SMTP id ffacd0b85a97d-354d8da59c7mr1179421f8f.5.1716369336128;
        Wed, 22 May 2024 02:15:36 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c58c1768sm7828619f8f.52.2024.05.22.02.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:15:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme-pci: silence a lockdep complaint
Date: Wed, 22 May 2024 12:15:34 +0300
Message-Id: <20240522091534.472449-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_021539_830491_229FDECF 
X-CRM114-Status: GOOD (  13.98  )
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

lockdep complains about the timeout handler running concurrently with
the reset work which is syncing the IO request queues (which in turn
flushes the timeout work).

We know it cannot be the case because the ctrl state machine prevents
the timeout handler from disabling the ctrl when the reset work is
running (changing ctrl state to RESETTING will fail, and the state is not
terminal). If this assumption happens to break in the future, we won't
have lockdep to assist, but for the time being we are simply seeing
false-positive complaints from it...

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..4a85b83b78f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2718,7 +2718,18 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
+	/*
+	 * lockdep complains about the timeout handler running concurrently
+	 * with this call. We know it cannot be the case because the ctrl state
+	 * machine prevents the timeout handler from disabling the ctrl when
+	 * the reset work is running (changing ctrl state to RESETTING will
+	 * fail, and the state is not terminal). If this assumption happens to
+	 * break in the future, we won't have lockdep to assist, but for the
+	 * time being we are simply seeing false-positive complaints from it...
+	 */
+	lockdep_off();
 	nvme_sync_queues(&dev->ctrl);
+	lockdep_on();
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
-- 
2.40.1


