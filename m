Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F47CEE339
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjdY2kbsntsJxkIY+YoEwppZ+eHyqiNWOeFPHP9zjwU=; b=XAFxzoEqHuqW3Icl/hvdM68EQb
	ihaoIXTVohuQdzGbrF/++Cb7FA0YBhG+YymU8RmjKyODu1s4d6CvUKCqX2+bQd2PLHTBfhEJ0g2jd
	w5LMwMj3etilFwvBVkqkE9bv0gxHH5fXVXRlU/CjNLpP8Yn3JRzemFGQpFZ99ahMlxwtr1643MPjk
	5HEmC0kJykGfXbTx59gzGgRTcY/u3bVvymyp8WkD7GVUcAks9OegbnrLSBCQ9K/nIvbc2ft8go/57
	XYYd7Isq9OjwkqOTWY1/YhFk1t2Vouc6LttvA0bzpaCLJ67oe7sNevEzMDaGtKQ2xG8qSxkzADvBY
	5DgTRGQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syaxd-0000000AIUB-46SP;
	Wed, 09 Oct 2024 17:58:57 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawj-0000000AIDS-0kvM
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:58:02 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3e3e7dcf7b3so57745b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496680; x=1729101480; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjdY2kbsntsJxkIY+YoEwppZ+eHyqiNWOeFPHP9zjwU=;
        b=JZ4QjbB7syFGDkLdTSWo8IOAqJ5IZKRIebi9mxk/1dNNWziHNgqpO29OIgAwnrkAUc
         FIeaGJ+l9Yvp2hY4Jr2p1C6K2kjcaWa847ICdSjHS656kA23GY24Pl3c0cnq5ImJvC37
         fmizUSawQD+AqzLXTfpw2t48eZV01O7X5SR1hSJPrhnHl9Rge/xHeaqmvPBfYeapSjwh
         WCoEIuvtrS1x7JTbmTOkSWeMb0BGJg16hD0me5mEXKBaKqZrA3q01OkHTZOYCm3hx1UG
         GKNTkNExfpc2C4aZUjIpz3rsG6tNdd7Cz2ICO7PQPZURlrn61dxWrMg7rgnt96vbF78U
         V7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496680; x=1729101480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjdY2kbsntsJxkIY+YoEwppZ+eHyqiNWOeFPHP9zjwU=;
        b=AEFtYqVKZ3ctQVRe1RKFYU+V+xidSwEn9xwh5vnaq5+h3+jpyUIyILeaSJcRIYNy4V
         YP5WMr/5RtC6mdKZ8WivYYxwZ8tAWkIrKwwXciPDAM6VyWASf8PasoB9mtzCDmSh36Mb
         JW9t0gHv8J24b2d/rwnQEcm86VOYgGOgjLYZReXEKcl6zzv+3/bge4iNXM6N8qOfMadi
         C3G2i+dsuWVCgNaCvqNkJJdwUKmvnBYnY5NcSHkpR87Nq2+mKo4xIfN8tZnowjHe/4cn
         37U8HJ8mFPkQ9HS0BlolO2vsQOHLd/eWxIkICNAkgoMY6FrXliABdPWmeyLqBg3vLqKv
         HQvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxp8L+tu5olDnPQsRmk0GPF16CeyxyiQVtcboOT4Yi1HSdUx8srFSZ55ZKJ8pxRFWH9dQ1gkE82xX5@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4ES11n6VKVvUIDloEVgX9PfJ/6gvVjYXQ8w9Wu1mxkt9a8q49
	sEoZPmHJjfdXlFx9sXqYfIEeXdq28qwXQU0cfDBQOpMjdJKMpW0x
X-Google-Smtp-Source: AGHT+IE2oGK/MSVHYCoJinOlidq5VY3r6qCb0/MqDXQTbVF1E62v1vJwCGEoMCNIzqsr8vGUNFmhFg==
X-Received: by 2002:a05:6808:219e:b0:3e0:3b50:6fcd with SMTP id 5614622812f47-3e4d7526e1dmr367763b6e.5.1728496679791;
        Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Wed,  9 Oct 2024 12:57:46 -0500
Message-Id: <20241009175746.46758-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_105801_255687_5ABAD4C6 
X-CRM114-Status: GOOD (  11.29  )
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
index 7990c3f22ecf..1cbff7537788 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3597,6 +3597,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


