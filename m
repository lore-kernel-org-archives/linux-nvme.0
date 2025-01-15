Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055FC02185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rip1luAcu3LoMrY0f6rNIKkj2ymroMPq9rw/eYL4eKQ=; b=rTR13VOWHI1pd/8CnD60aokZl9
	Z8bpzj82cW8nddAf8TUinzmXs1PreBk2kYNEOO60k3GjDk3rYT9Y6MLaIHttylXggClQMqdkGlmrO
	wclGHCkDd5CqK942F0CEtbLJ7izhoQgm5vs1hmiOMrgRjQM8mcl/1DBif2uKRfrovhotwbxlmdYWE
	ArGHE2QTE3/1ceax1HU2aBJ0X/pqqRceYEnasJrWZGDdvzWRE07FKFwjXokfHVr4UCxiVx1MPwaZj
	QLKNn2UWvnDaQ5QNJKSRWv5AhQX6OdzOF0fu5de4eGKOIpgi/uRodVzN1xtzJP2NDbDQSkW0asXT6
	NYQ6eAqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1xe-0000000Bkpu-1Izr;
	Wed, 15 Jan 2025 11:53:26 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1wY-0000000BkR6-0adn
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:52:20 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY4952Ytsz4f3jks
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:51:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E71B1A0DB0
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:52:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S6;
	Wed, 15 Jan 2025 19:52:08 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 2/8] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
Date: Wed, 15 Jan 2025 19:46:31 +0800
Message-Id: <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Gl9aoYdnvK0ZBA--.21959S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8Ar4xJF4kuF15CrWUCFg_yoW8CFW5pF
	W3Xa42k348WF47C3sxXw47AFy5Gw1kGa4UWF1xK345Wr15A34Fgr1Fka43XrWkX3s3WayY
	yF4DK3srCa15XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_035218_491502_87044B8A 
X-CRM114-Status: GOOD (  12.11  )
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

From: Zhang Yi <yi.zhang@huawei.com>

When the device supports the Write Zeroes command and the DEAC bit, it
indicates that the deallocate bit in the Write Zeroes command is
supported, and the bytes read from a deallocated logical block are
zeroes. This means the device supports unmap Write Zeroes, so set the
BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a970168a3014..8a359370154d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2210,22 +2210,25 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
-	ret = queue_limits_commit_update(ns->disk->queue, &lim);
-	if (ret) {
-		blk_mq_unfreeze_queue(ns->disk->queue);
-		goto out;
-	}
-
-	set_capacity_and_notify(ns->disk, capacity);
-
 	/*
 	 * Only set the DEAC bit if the device guarantees that reads from
 	 * deallocated data return zeroes.  While the DEAC bit does not
 	 * require that, it must be a no-op if reads from deallocated data
 	 * do not return zeroes.
 	 */
-	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
+	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
 		ns->head->features |= NVME_NS_DEAC;
+		if (lim.max_write_zeroes_sectors)
+			lim.features |= BLK_FEAT_WRITE_ZEROES_UNMAP;
+	}
+
+	ret = queue_limits_commit_update(ns->disk->queue, &lim);
+	if (ret) {
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		goto out;
+	}
+
+	set_capacity_and_notify(ns->disk, capacity);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
-- 
2.39.2


