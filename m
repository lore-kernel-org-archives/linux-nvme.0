Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633EFC52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFs61gq37YkVZz7WirFZIsP//0+vKUsSxKZKnV0KhqU=; b=LthQ21Nh0/J7feKIHQqsHRYhBk
	rzum/YEa8yyQd2MQsrEasqEMfBJjD0Xg4uOU2k9YEMV2LPYwgO6gFO4b+Uo0CHgyu/KHjWnswbLyO
	0vGeR/iZCvfN35aPIqCqZoWO8bIwO/k/BQk+K8pCwdBIVsfO8fDXDcHPWTKqOn8dnXhMpdkfZnXQe
	ssiQu6TtlddkRWtgQxBuiQHR7aYupOm1qv/Kk47dLCFwBDPKOG1ql2itDl+QlEPKCWGml7/YLzTgz
	7b35or27ejp0AUm/qOa16y/63wQLhBJqLkFkk+zd2+0RC2ta2OyMJCw8W5rXIkJ/LpQ803e1NZrNw
	dUABvYJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPv-0000000EDel-039c;
	Thu, 22 Aug 2024 20:28:23 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPr-0000000EDcZ-439r
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:28:21 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7094468d392so928947a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358498; x=1724963298; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFs61gq37YkVZz7WirFZIsP//0+vKUsSxKZKnV0KhqU=;
        b=gOtiZRUhs/WP9sygQB5dH9tgKeaiiJUvTkFYYMTvB9YjscjH9ctPY7gxJ23eJ1ZhYc
         a6KUXj01xa+XpOlttrK5JVnCIK2OSZngz1dsD8R/8qFoJrmrt2+pFcbxm7km7yqQJDDh
         Gsp8I3+y6/iPuNNopJnlvZCkGqhJKS7Sbr0caoMJ9daeYwNyypAtoik5Z8chPkFoyRkR
         q+bJpFVeGEJc0S0NltF0qJAGOuOd3FjiG29XzN2ODYN7Bq911sLf8uYy2DjJKFc+K6+M
         28leIqQWPcg2k74vJLrD/28cfoarsqmz6gGQwrX94J5S6rpxmyq+Ystlftk0wp7Tq3QX
         sAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358498; x=1724963298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFs61gq37YkVZz7WirFZIsP//0+vKUsSxKZKnV0KhqU=;
        b=QJ8G07cXB7dFTunDOCj+UaJo+mKd8POqWZb/Z2vMz0rLX+hSn0j3nXxb9NHI/coFFF
         X36N6ZUs8yd/A8mBSq8zok2M2QOluVqscHIssTfBs/8R3yoUm6Q7CYpj+Ja8SOVSUWKS
         jz70ud59fooH12A2DN6O1O2mKWgbkStUy3aRD4dechsZ+ztwwBCgnhOmTXXFp1fVZ0MH
         V7HbePTS1VYgSn7jsmaT4CIwB1rKmCKKhxfD4d37WlzqYU4jzMBeS/7tFmYfkXkjnPq7
         BdV0ADij8ZEHIyBKy3fB483ZTn4OzJbYC6RdRt/hmzil1gn8I4pFcf3WK9ByWaFHC9C0
         cMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL3KfUYgtnAVs794f/iNDzXFNnXh24jTZgshW2SyaLtzWjCjYFna3jAnypfkmsI80tJTQrZj1AkHjX@lists.infradead.org
X-Gm-Message-State: AOJu0YxX7zVj1J3JPefq1xYjUnqftYIXZo9JS3rLLtcLD+GYPZxmCREU
	WA+mOS9Lb6M7YFlaBwAm1Aqv+HhIGbD36LHPcx6MjVM/fyPyuBAi
X-Google-Smtp-Source: AGHT+IFrVRHrCiCi5cIp28BTyotzWR1lcgkXpE435Imqtgm8r2l4jvzH3zyAhCus82rF+WPtcyribA==
X-Received: by 2002:a05:6808:1b22:b0:3dd:3651:d2eb with SMTP id 5614622812f47-3de2a8932bamr10861b6e.22.1724358498688;
        Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
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
Subject: [PATCH v8 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Thu, 22 Aug 2024 15:28:05 -0500
Message-Id: <20240822202805.6379-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_132820_032913_377B124A 
X-CRM114-Status: GOOD (  11.65  )
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
index 6cd9395ba9ec..58d0d517fead 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3580,6 +3580,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


