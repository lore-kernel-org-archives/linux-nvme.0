Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2CDC44500
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=odZi3J3pcdjUTPi1MshSb9GhTjgHgTpmLkTRrf7I94Y=; b=jBE16XvxjHgMVnQhWT+sWpuDdU
	wdUVk2Rch4e1yk1XD9tqN41fqOD1Qa0g3hGOV8iX8I+MyJNDHH/3EFORsomiu7/kItOlyWPZ2pqTv
	YfutmwduHH9Q6/c57n0IR+x6kI3cz0gd6pUWu4cxKnYlUPj+2qgvgLepgrodJgV9ZheNg0BAVx0aJ
	9bJv9sGekillvGxH0MjKZH7rpUpkIEVmUpZKIdTanko7l1YAJhShpQD9Zd9/va7K3SM7Xjjd541ij
	gc5Ku3USLvoSji8bx3NeXPsthH5UgLYVzH7RbLxKPOKTWpe6ShvCFQntTYNlSlVVQBx4tjyHESofm
	SpXHcM7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh6Je-0000000F6Nx-0gPy;
	Tue, 07 Jul 2026 13:58:26 +0000
Received: from out-186.mta1.migadu.com ([95.215.58.186])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh6Ja-0000000F6NZ-40tS
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 13:58:24 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783432699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odZi3J3pcdjUTPi1MshSb9GhTjgHgTpmLkTRrf7I94Y=;
	b=QB1pkt1n6qPdkNSYmaehmYjF7HsIdeCcG7lHfthUSU7NmFTcuXxaKbvIWs30kR2E48ipCR
	2KxYHVjcbsOR3G8MwaCwnUjwjHmmfJEKHCKx0+BRTARAUHmMRYsnl/2fdTfxfNdodhAKYJ
	hla7SDsoqvZmml2eOG8hqyBARjVjHNc=
From: John Garry <john.garry@linux.dev>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	nilay@linux.ibm.com,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: swap synchronization ordering in nvme_remove_head()
Date: Tue,  7 Jul 2026 14:57:44 +0100
Message-ID: <20260707135744.1470014-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_065823_171668_BB26526C 
X-CRM114-Status: GOOD (  10.39  )
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

From: John Garry <john.g.garry@oracle.com>

sashiko bot reported a potential issue in the requeue handling in [0] -
the code there is same as the NVMe driver.

The issue is that when we schedule the requeue work, if a bio is added to
the requeue list afterwards in nvme_ns_head_submit_bio(), it is missed by
the requeue worker.

This issue can be recreated by hacking a large delay in the bio submission
requeue path:

        } else if (nvme_available_path(head)) {
                dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");

+               msleep(30000);
                spin_lock_irq(&head->requeue_lock);
                bio_list_add(&head->requeue_list, bio);
                spin_unlock_irq(&head->requeue_lock);


Then if we issue a write after removing all paths, a hang can be seen:

# echo 20 > /sys/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n1/delayed_removal_secs
#
# ./ini_nvme_teardown.sh
[   25.877224] nvme nvme1: Removing ctrl: NQN "nvme-test-target"
[   25.939569] nvme nvme2: Removing ctrl: NQN "nvme-test-target"
#
# xfs_io -d -C "pwrite -b 64k -V 1 -D 0 64k" /dev/nvme1n1p1
[   29.883653] block nvme1n1: no usable path - requeuing I/O

Fix by re-ordering the SRCU synchronization and scheduling the requeue
work.

[0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m72af1f29deb0ebfb2973464207f201f1be1f660c

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I am not sure if we still require the synchronize_srcu() after nvme_cdev_del().

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 016b6b0128c7..0b017eeb82b2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -690,14 +690,15 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 {
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		/*
-		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
-		 * to allow multipath to fail all I/O.
+		 * Requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O. First synchronize to
+		 * add any bios to the requeue list.
 		 */
+		synchronize_srcu(&head->srcu);
 		kblockd_schedule_work(&head->requeue_work);
 
 		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
 			nvme_cdev_del(&head->cdev, &head->cdev_device);
-		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
-- 
2.43.0


