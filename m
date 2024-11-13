Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC03D462B0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2GqyUZ+DoOYXIaIGrRa/jrUQaI4W1R+p6agPX1jA4QI=; b=bq194yRt/NyQbHM2CIeof544MD
	0uTL7Wofm6vcAM7SnaYGGilp2Mx8fy7hAGs71ZY7vqUuGo9EZ0sRbppJGXYGK8AGcH3WCvQYC9d0f
	BkmqndYmVg5JMYGS35SohrFrzM7V3Z1h1D2dhtPR96QuRLjJl000VwPW0EEDN7Lu0PjhrflRU+WzJ
	fw/tbd/8tVSyPRpsfRT9KZv/nMjfFXi26OMyFnsasq51cNtTv3v9d8w7Dw4XI07XuDxTXOryipP5b
	ebgnUEJaFYPZpFgApp0dy15adBLD0Ycl6pqLuqLGc7T8PV1vKUuQ05d3R2k5BAdwcL1FyEzKmNZE7
	98FIa/bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKL-000000077px-3Kfi;
	Wed, 13 Nov 2024 14:26:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKI-000000077nM-287U
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A3B085C01E3;
	Wed, 13 Nov 2024 14:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C6C4CEC3;
	Wed, 13 Nov 2024 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507993;
	bh=75UYmyTYuXcBh21qnxL8a7xEYVI0TRKMVuk8+5dIe0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZpZ2ihZjYywFiKV3/cRgPCdS8RYQSWApYb62AnXJE2Lzxj3NQum7QCIZxYW4Mq43s
	 e2P2YpmeHIV5S7vXbe5vc/dLKC4Uz5h9pxIXwAn8DPkxWDrwUSKnQJ6Dtg3/p/rtbv
	 A0QsZyQbD47QweEnMeYYeOYdSqzsDOO9P9sUdHZ7XbN23LqMt09unrh9tX7lNfAY9v
	 XwWXExgqJSRb7JPHFmY3UWp81lrebBnhfNMFRArM+It13Twy7Z18+UdieImjU+z6Vs
	 ltul7jBybBHLjfOL7bWCjvy70Lt395urjLj3o1aS/eLJ7Up7e747yTUO+1Bgs0s3vE
	 F6Xi7QwqUO0Iw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:16 +0100
Subject: [PATCH v4 02/10] driver core: add irq_get_affinity callback
 device_driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-2-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062634_754096_C595EEA5 
X-CRM114-Status: GOOD (  11.61  )
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

Introducing a callback in struct device_driver so that a device driver
can hook up the getters directly. This approach avoids exposing random
getters in drivers.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/device/driver.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5c04b8e3833b995f9fd4d65b8732b3dfce2eba7e..0d1aee423f6c076ae102bdd0536233c259947fac 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -74,6 +74,7 @@ enum probe_type {
  * @suspend:	Called to put the device to sleep mode. Usually to a
  *		low power state.
  * @resume:	Called to bring a device from sleep mode.
+ * @irq_get_affinity:	Get IRQ affinity mask for the device.
  * @groups:	Default attributes that get created by the driver core
  *		automatically.
  * @dev_groups:	Additional attributes attached to device instance once
@@ -112,6 +113,8 @@ struct device_driver {
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+			unsigned int irq_vec);
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 

-- 
2.47.0


