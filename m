Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C0C28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AlygZq8HqYrT8bCWCc9fk/FAvA5IJmtWLWfH3sh/BEg=; b=QQahkMhIPmoLmqqv2E5KOmJFf3
	i00c1ML01UlVpzFk61dl1NCwt7SshQqleVXlJJ0WrSp8fQPl5C58cb7IqOi9nVOegh7K/EZ+9NLKy
	bxAYoNaKjHIDlYapivze02U83urw51nfoMV9CGrP5O7wQZD89MyNC97JSOfCpny8yeXst4lgTNbfJ
	xEsAOafxnUKVLbwnBtqIiLWbkLxG90WWZ+9nWBx1Md0rf/ZjyXMWUq7Tzch6ugq54AuzkQZAanc/V
	vjWPxCowwEE7tBs61VudOwTg4M9tK/cl1MUPSX8n2+CuYfthJkK31Nq5XFqZlV2UyqWXKtu/e8ewn
	9PNo9ynw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuReH-000000050Al-2DHO;
	Tue, 18 Mar 2025 07:46:05 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRcV-00000004z8Q-25Bd
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:44:18 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kD0pZpz4f3m6g
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:43:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 31B171A12D5
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:44:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S8;
	Tue, 18 Mar 2025 15:44:12 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH -next v3 04/10] nvmet: set WZDS and DRB if device supports BLK_FEAT_WRITE_ZEROES_UNMAP
Date: Tue, 18 Mar 2025 15:35:39 +0800
Message-ID: <20250318073545.3518707-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH6189JNlnEt1YGw--.55732S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DCrW5tFyrXw4UXw1UKFg_yoW8Ar48pF
	ZrGFWxAFWxKFWUWws5Zw47ZFy5Xw4kKa47C34Ik3s5uFWUtrW8WFn5G34avrs7J3yfWF45
	JFW7Cryj93y5Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRL0eQUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_004415_889342_E7F945E4 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

Set WZDS and DRB bit to the namespace dlfeat if the underlying block
device supports BLK_FEAT_WRITE_ZEROES_UNMAP, make the nvme target
device supports unmaped write zeroes command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++++
 include/linux/blkdev.h            | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 83be0657e6df..0e8b35732492 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
+
+	/* Set WZDS and DRB if device supports unmapped write zeroes */
+	if (bdev_unmap_write_zeroes(bdev))
+		id->dlfeat = (1 << 3) | 0x1;
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5d280c7fba65..836738ab1fa6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1344,6 +1344,11 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
 
+static inline bool bdev_unmap_write_zeroes(struct block_device *bdev)
+{
+	return bdev_limits(bdev)->features & BLK_FEAT_WRITE_ZEROES_UNMAP;
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
-- 
2.46.1


