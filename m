Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796E2C5320C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=; b=kfBhd7WY07JM1s0Dxn0jYNt8xJ
	RQAWCjQZCCTnaSmoJlt6vAJoUmpEUgXMGKd1X+h5LT5qgQ0KX9OrZejKJn8Bjvt2NydllPb4TEuVV
	I3cuS9DRF+uYvOCJtbsHi2gPFiJScu2ExHRGoV63AgOth46x5QLK5Ft/CoKXbfBvVIH1Y4RcWZ6Wm
	0/lsFh6tiOepRyeNzYlPEQ0n4I64/tm0mJPkHqRHjZhfkVf5oPnMgpvl2f5mJwBJuUe/YB2hneyGi
	13+QsJEOvo+p1gVqwzvrS2xJq2Ii2RPOaotcHMk9gBQ7Nqex6Ut0m7aXDKnag0pz/Cfqq5GkQRHmj
	CUGqK27A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd8-0000000Ci7m-3anm;
	Fri, 09 Aug 2024 23:02:42 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd1-0000000Ci1l-2smt;
	Fri, 09 Aug 2024 23:02:37 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2f189a2a841so24625481fa.3;
        Fri, 09 Aug 2024 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244554; x=1723849354; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=MALSuVfP+BuZ+QaXPYYhyWhFBAOeMAX1c2o9m1SDDL1YY0cR4uF+Xbm/nOy8/kWCbG
         cKzlxZo2XGOmfE+wx/o10Q4wmQ1tjZ2LxaeEyyL0maTQMZz6hbgRdfViIidOmvGBB79x
         BnmZvkcV2m/ZI642TzoWIrGutHIMJuoy0iEWZ1yIhzGRoTZdXODnTYoUYY1D31i3DD2K
         KUMVhRKesbAs4dEZXKTbkEwJGlLxJJwDnWMXSBDzOKWWqts5BmLJiG4AWjL6StFFQR+Q
         pjY7dRM89Om7t5vB4R4bcBZ0sEAZtQfJv1jH2XuYeYepXGfOQmho3gX6O6PhUwv9yCDB
         SFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244554; x=1723849354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=RmHwfzBll3j2DINsYpbWT4fK17qvGvtUYMaZWiZ5yl4GiH1QlWj0LMu91vDUY5xQio
         /9LNn9+amY1c0GGLINjut5gyoaDQnF7Ylhdlet4SyEyaAbWGb3ylMukjw5l+VxTcorLl
         YOBJ0Dus7i3oV+wDg1PQj2E5pMQ+wL7pRmncChLK3mB7JyD+WqjSMADDbuwq0ZZL/107
         6IxGzo2AUeYVCxm7wTeSCEX7LYBq5sLnZPAqrhyOJWVrWH3JKYxZ+8nCu56Ifd70srBK
         gIy8SrzD986GQyNxOmMSGug8MZxlFZQZKUbQcJXuzSGaylpsTMzF1DUqfSgzQsQLgMNY
         pJrg==
X-Forwarded-Encrypted: i=1; AJvYcCUGThQB8YkPikbnimlpaIH9IFl135gxBfdIQYmYS6RsVD5nM+vOpXkhVqI9aB8ljY/MZLWHqcoJRnZwfpaVdsjsfM9zqCUl6aHthCCghDmoST4t2ZFYod06Z1Q6nd/mN7tYyPp23LNA3jbpcRgy
X-Gm-Message-State: AOJu0Yw0CfRs8ERyiEsD+qnDaKHC0YsUVPBpm06sRXk/assP55medtA6
	JNKvsXswLoVKNYxgvfAnei8uYPweND+tHiIV89L3HBN1Is1GCH8A
X-Google-Smtp-Source: AGHT+IEF0Y3NVeo/gUFLIVY34RZUu3ByxZUGMianP0w6Y0uhOo40dlxWIt5krkPxbZ2lUqfhtQM47Q==
X-Received: by 2002:a2e:a589:0:b0:2ef:228a:1b86 with SMTP id 38308e7fff4ca-2f1a6c6b8b6mr20863381fa.21.1723244553325;
        Fri, 09 Aug 2024 16:02:33 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 4/7] block2mtd: attach device OF node to MTD device
Date: Fri,  9 Aug 2024 19:21:02 +0200
Message-ID: <20240809172106.25892-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160235_768729_D942AB4E 
X-CRM114-Status: GOOD (  16.98  )
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

Attach device OF node to MTD device if defined and the root blockdev is
being used to add support for partitions defined in DT node.

This permits the usage of fixed-partition or alternative parser with the
use of block2mtd module.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/devices/block2mtd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index b06c8dd51562..8ff9787edc24 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -265,6 +265,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	struct file *bdev_file;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
+	struct device *ddev;
 	loff_t size;
 	char *name;
 
@@ -324,6 +325,15 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	dev->mtd.priv = dev;
 	dev->mtd.owner = THIS_MODULE;
 
+	/*
+	 * Check if we are using root blockdev.
+	 * If it's the case, connect the MTD of_node to the ddev parent
+	 * to support providing partition in DT node.
+	 */
+	ddev = disk_to_dev(bdev->bd_disk);
+	if (ddev == &bdev->bd_device)
+		dev->mtd.dev.of_node = of_node_get(ddev->parent->of_node);
+
 	if (mtd_device_register(&dev->mtd, NULL, 0)) {
 		/* Device didn't get added, so free the entry */
 		goto err_destroy_mutex;
@@ -337,6 +347,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	return dev;
 
 err_destroy_mutex:
+	of_node_put(dev->mtd.dev.of_node);
 	mutex_destroy(&dev->write_mutex);
 err_free_block2mtd:
 	block2mtd_free_device(dev);
@@ -515,6 +526,7 @@ static void block2mtd_exit(void)
 		struct block2mtd_dev *dev = list_entry(pos, typeof(*dev), list);
 		block2mtd_sync(&dev->mtd);
 		mtd_device_unregister(&dev->mtd);
+		of_node_put(dev->mtd.dev.of_node);
 		mutex_destroy(&dev->write_mutex);
 		pr_info("mtd%d: [%s] removed\n",
 			dev->mtd.index,
-- 
2.45.2


