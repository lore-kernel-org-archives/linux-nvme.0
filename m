Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA4BC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1el02iUk0200SGhOLa3Aie872dT1lHaSMV4HS5bPfTE=; b=PXYoBXNduGMr6NHKRDFqn4jt8y
	ZpEfRkpuP2bRkakA7f98KknIx7BVbH9745/K7Lu+ISEN1sZJUMV4gV3v9QLX24ZuP3XtVSnQGMMPq
	fGO7/iWEXIlHpYBziW37ihWT6E6XB7hKg/FGb/CD7QLcgTXuWjZEkXPyHqMj7lpT5YnqlkGQMf9Dk
	sOEI27n8K+Aw7kjq2OVFRUtJ/A5CxAQPMbEWIBNHJWth6+QgClPSuRZ0sBwOgM6JfHPo7oB74PCpu
	/xUf7GHrunmeYFNPBvGc4dV7ByTg2qrULVhtn0jgRPnZPg215fFXYZEh9sKhEmPe/P92u3CCtQA2Y
	GdTjuV/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMd-00000005NRM-41X8;
	Thu, 16 May 2024 15:49:51 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMY-00000005NN1-47Yk
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 15:49:48 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-24542b8607fso428508fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 May 2024 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874585; x=1716479385; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1el02iUk0200SGhOLa3Aie872dT1lHaSMV4HS5bPfTE=;
        b=Yb6UR04hHLrnVwgQp28C0kcNJBkrStoz2VTfOZ5XG/HViIf3eY6kFDilSTMCfOmakf
         LVor1yBNyWvS+HLyhZyLWAdmDw5iP6gwJ38aaFwPVsitGAjZtkAeZiq6bvwWxpP774VN
         YgxOgQgcHzPwzohWleB6LmmDbOH163OrhMmRjySKb2Ute5Z/Ygta6s/mEjoTGargqtEr
         HIA81KzSzN+TwzUUk7BUKTMSzGD3F52mC64UabU4NXQd96DGNAzoAsClEp2bRIkJLofV
         +djWZvCrKAgkXb35UbbuvMqwhwL3+y6YVIOAzdkT06NWCuqFo/CrqYU42GH4ZJMTdcld
         Ie4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874585; x=1716479385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1el02iUk0200SGhOLa3Aie872dT1lHaSMV4HS5bPfTE=;
        b=fFVoTw+LI/d9a961J7j+wXfY2Vs/JIunkOe1v5WtPTgdyr/EAoD+Zzmg3EIn9+/CLI
         GMHUn8LEcciqQgyufeYKC8FIkm+QKLj+iz/0L0t9xesPZU6SuOi1bC9as1SLh2JBtxTB
         7vwkwn6fdLV4RynnHe4OKpfq5KgRjG8/uyYHvBcumNrG/l1j08ojFvuTxSXJzc1eFuDF
         yStLTKetXDdvCOALQOgihpj08r8E+BXiXqVH+RAy3+ZwlwOGVccmnNVFarVxIMOVLtw7
         QQeuJUpAKgwFNswewL1wP8G2lxrdt40mcg1BKqQ/DUNGufY28Kk5yJOdnutStY6/i9tg
         uxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2jCcrFBNCkAo/ws46G7v9gZ1XAT69qeNSMaPcVN3/9EWQNdPDIP8zpOzRHFyYeEtrNZmpDWwuwObW3qhMMW5Iwr8EPEQEwfFjo++Qwq0=
X-Gm-Message-State: AOJu0YwDnXQr3tHvxuFgQbywufiBcJQGf+eszTBILo9l59Q7cRkznWmu
	fdH8R6FkyK5iuB1v/S3uZE26xBvm6pxYsybMCBGvlbjzW4OTsFcS
X-Google-Smtp-Source: AGHT+IFWbadnjHt9POkdmHGXGH0+QHLuxmZCux8kZhdMRGGI66+uLqte4Wr/PibsSmfHW7ga2az1Pw==
X-Received: by 2002:a05:6870:1715:b0:240:f3ee:6fd8 with SMTP id 586e51a60fabf-24172be01aamr22432820fac.43.1715874584773;
        Thu, 16 May 2024 08:49:44 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:44 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v6 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Thu, 16 May 2024 10:49:20 -0500
Message-Id: <20240516154920.221445-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_084947_104347_D3890743 
X-CRM114-Status: GOOD (  11.45  )
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

Set the driver default to prefer asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..df7bd88f50f2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3530,6 +3530,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.shutdown_type	= SHUTDOWN_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


