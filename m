Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B296DC3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXDZTLeuWuzR4JFBbSliTdNmKT1J60juYffwmH3Ya+w=; b=dwLEfCLpIrug7OxbXElqiE0hlK
	2sV9PDm3FGc1eYUhzcT+9Th+n2jeeDDSUvnlQaHuKKoz7hOqEmlYEDgzECyhHORzypnv9ElIbAGqd
	SyDMEAj4tQ8xwP0qwywfTb2bB3sCKs+1dmyZam0lFVSY1+da6Vf797Pib+n5QrnvUr8WQxRsg+Jj3
	yiN9fkU0/GwggV8V9KmEGQF9b7g43ztKcWW5mGjg5RD/lQW9L+WArgj2OIpk+/HoMyaancarqxmEc
	1DwXOioiS1pytnqdqlXecITVrM8zNfrVnAhXvQlhySFfG345p99yKiHQiu6RkSi+8+1nC1Lhe3Z4m
	ElU4RJbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYc0-000000086OM-0b4p;
	Wed, 26 Jun 2024 19:47:24 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbt-000000086KJ-1cGA
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:47:19 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6b4f7541d7eso32701496d6.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431236; x=1720036036; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXDZTLeuWuzR4JFBbSliTdNmKT1J60juYffwmH3Ya+w=;
        b=VgAOmo2zJGw7hGT6hiq3b8AA/2dE2CAa7Nf+a87F/D1JcFgRo6t/kC84ABrGd/wb/7
         c6n4TeGH8QHoegBcg8QYUZ2VxW1A++jDBHbaRLtANvcpz+BX6+LnaFjKaXPJGgpOLA6g
         QQgWdYYYYT7kjG5f35NsJVNOwMSIgjtpt1fyxVZ8ZrgczpD4TAfbRvKCVNOMcENd2gXT
         q4qU2HUdjMo7fZSxASu/78+svt07J1wUD+hIy1SxeudFu56C9RLOU5owFuE3cG4HvzHr
         XidrvdSBD9zJvVBU4PPxkbRD2pgCAIpv0ARpJ+6T4ra20WET3ruk5+caAG25ewTPTqDu
         jolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431236; x=1720036036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXDZTLeuWuzR4JFBbSliTdNmKT1J60juYffwmH3Ya+w=;
        b=Iocb6hAoKd49SJCdO0PE8pCQQ4zEYED4VUzXy49bwRoJFJEUzruGwEijVv9S0N4Wml
         HyCPcsM3omRGkeVkOGxPjV0XGmje30h3B++ne2Xr6xzEu0iHr4jFQi64FUfqUj5iRNqV
         GsIxNsRo0TQl8H9Vfw9o/LXsdkkbNq6Zx9EQy67gA+oW/Jkf1kDsw/DHMl63gs/iw9q9
         qgoc/mGbD/8z8BEjhj6qs2BgX4RYFqsiwQaGrdyK6XIOH9heVcvjIGmbO2o1YObifNkg
         ojhHXNZjn5ocsCBuBurp7Hq0/nM6EYDSd6hR4ZOgmY8jVy3EPChUB2IlUkWNmu0TGe0R
         tVxA==
X-Forwarded-Encrypted: i=1; AJvYcCWY0dalg/ixqzJLsY0+sgOA3+gpq9B9UALJILg5YUy3WGOu4vQDzHLqx8Z+GO66SR3a4KeAJBQagJtaNhByYds+5G/matuYgNkX/V21KPQ=
X-Gm-Message-State: AOJu0YzjpxDaGWHCbWSVWSvUGfPMsejXSW2XNE6qzWUh6Z4uZtinvLMZ
	yT/zW2zy16RdjrMjZCa0LyvoDmGrcSEnTB2XdTklQAPh0URbNBWI
X-Google-Smtp-Source: AGHT+IFEq2G29a9cZ3CtqTm8lu6M1ohFZCP2KJGvd+Bn8S2ZMURyxwzcnnFwPwWRhHdcNMdssoKpIA==
X-Received: by 2002:a0c:c384:0:b0:6b5:1f3d:c810 with SMTP id 6a1803df08f44-6b5364f79efmr134299206d6.52.1719431236284;
        Wed, 26 Jun 2024 12:47:16 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:15 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v7 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Wed, 26 Jun 2024 14:46:50 -0500
Message-Id: <20240626194650.3837-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124717_910763_1545A08E 
X-CRM114-Status: GOOD (  11.31  )
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

Set the driver default to enable asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..8138e37547c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3531,6 +3531,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


