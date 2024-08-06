Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC5BC3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=; b=1YI+a07jJm5PX1zTREMvXtl+yR
	3QYINvN4ticoDRNnhAwh3E0y8qSSnbJYEtpB4cqeEJ+fCCI4x2B4o6dqhnDfYs/LvFcaSwUgTeDPV
	kb+2H2iO91sw6463nRJw9PB0nV5AUk+vzuKiM4Od2A5MQj3hDLmX9NzZuOu7GFe6CP0xTZd3keym7
	QkwXudkltGRwK1oiWXnTuvx99zdhE5R5oA3VXbdo+9xYa8jEtuXpiBYaHJhSKJK1RtGk9NNmJsYME
	eTLaHDPsXDaA2XFKcnfcXAK1I4IVkM8VFG8auRJTKT2wOummfjZhSTSkIK5Tq5TxmWmRa8iq+3w7M
	uE3j0Yhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJZI-00000001Xs8-0nYJ;
	Tue, 06 Aug 2024 12:45:36 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZM-00000001N8f-0fC5;
	Tue, 06 Aug 2024 11:41:55 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-428243f928fso5057405e9.0;
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944494; x=1723549294; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=SZxGN3wgJT2WbE3uRNfYMVT8qXmaf2QmXNq8P/bAM+gW5+JxzSe8qLSGX8csc88Z8H
         tc7baN0NC02+kbZrIfIBg01sWVVznI7t3GaychKKuoOAVKyIbKByGts3UVP/wPk8d8S/
         9l+8D0w8PIVuVXZyGyCP3PDtPko9y3vqI6rrtYiMQpnbELpiq6aP2/MjTw2NucmmjzRS
         5Y1g52Uf+/GIUEHfielzRLeTJ1esRL+/Prf1C0lCQEmghUBQF+Rp8bKSrFZXByQjLJp7
         OsKMg8iMV04aUFrmpHBiZHBPdwzlo3xIg5dNrtaIGobeEGqrfSZfpZt6FYuoIxOCgOxf
         lmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944494; x=1723549294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=TgsQpWbD+exffrWr8PQibcJw6EQrU/P2zIPk5OUJN5fZEPHEm3MxBL1qOk2Vgf+38x
         l4f4AX0bGgV4iIjZsI9uz9csEkS36UH/d9xUG7aIrTirlCtDxJwImwAvbjpfWlw79SEV
         aIS0EDr5g565YcuRB7SwVABeHwT0t1lO547Y1k1RdIUjZ6HDne6HplQrM4mS5dTGXZhz
         mOfGDvMR5FU9VLNPX8i6qfOgbwuMXjkcKsuIYxPkMhNnQTNMotKYmzWa40e/V+CbzvuF
         W14DjRMYGrD8UAqTxG9qbEQoe4hRAPcF/HrME7qVNPfBfT4eUqL3EY03dKSAtaGODBm7
         J6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/unMB+Wmrx4qH6UKtsif3FK+zcyaXXRes19swzxS/FwrvSQDnmHp7B0qORnt82YdrUVEf0I60ghrPgLx5Im0SV61B2kHgeR5qNhzlSeGntakzsQhG3/2jRz55gwLpUc7BRxsHLN/kmdZ8XY1w
X-Gm-Message-State: AOJu0YwSymbUVw7bzLwruk+Q6QV5tugiTKHZEzf5tki4iE2tq9oErTDi
	E0+V7Lkqg3H8LtjBVlMSDSYEhREoJ7XgZbwnFnUV/U7VHRu+EbpD
X-Google-Smtp-Source: AGHT+IFGVYMjIkc1rf+t9JbyTCPhrBWsc7Ju4jzCOzjNnzD1sS+oEYPY0w7XNI1EwLNMTIC2ME3gng==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428e6b0274emr117918275e9.11.1722944493977;
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/6] block2mtd: attach device OF node to MTD device
Date: Tue,  6 Aug 2024 13:41:14 +0200
Message-ID: <20240806114118.17198-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044136_267782_3861FAE1 
X-CRM114-Status: GOOD (  16.61  )
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


