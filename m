Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF744D78321
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNEOBbFU1E3XJyS99Eb7K/2NLjSGgIaBH3yRyuM/LQw=; b=reL4/x8pW5ktvxfrHQmCwDz/tg
	9sSQXoXmJx+xMdFQ9MUTMJjCqU9TdXBOLnCcOTD5OzG0mdtCC2nJiQtDaEuTAJdjJ5271h0paISuH
	miFEH5oyGHhMuWdnd91WKn0o26U44GuYNiZ9Pj3ClQqaV1dYQa2Fkt+Rkl245fhgMrnYuQeSTdBdu
	zc9U7+BtclXvjf/gF0AUjSOtViXz68jvvfgISTgcfUZ1kIXtmuhXF8XOxfvj9D++8/W7V71R6r++w
	Omrv38Znx9v5u7Cz00bszgnWrAyUmOgBnrRqNXfM5ptHSabdTWeR6nU60HBFUCUeVOy4mkLGE2dXB
	PB0Q36Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI70a-00000006Ksf-2f8e;
	Mon, 02 Dec 2024 14:02:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6yU-00000006KMk-413X
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:00:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAD365C4D09;
	Mon,  2 Dec 2024 13:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186D2C4CEDE;
	Mon,  2 Dec 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148029;
	bh=Xnjsn5CeW974ObCQuqa0Z+CwPGGhRk0jK5nChV5JWhY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gihYJs6sH7FsUEhZ3dC//xkdgTQZEZbG7ECwDNLCsp+1vwwn3L1qyEARC5IajXlRS
	 k/Ij4ocvkgn/mwbu6I9aCr1n6U3p6br1g8/VIZp8Ik+DwO7qxB0Y8djvLO2rKHMZdz
	 Rs5ZemFdzb5wtsiY7rpcpGMi86imiZP1CUCyHDVqIGSQMQIiyJ8xa/ExCoY51MU01z
	 B3Jh4+amo328tKSoSKYQzrGD44+RvZ8hb4AT5RbfyyghHV57B3/Pr4fJzSW5tzQd3M
	 C5fCVO/lB3e4or3al7+CQ/jbVcXN08NYb2WaeXVCfRLzzajbgJq34JRUs16b6n2bYq
	 f80Oqmiwo5Wxg==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:09 +0100
Subject: [PATCH v6 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-1-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_060031_051826_E1EE867D 
X-CRM114-Status: GOOD (  12.13  )
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

Introducing a callback in struct bus_type so that a subsystem
can hook up the getters directly. This approach avoids exposing
random getters in any subsystems APIs.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/device/bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,6 +48,7 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -87,6 +88,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+			unsigned int irq_vec);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);

-- 
2.47.0


