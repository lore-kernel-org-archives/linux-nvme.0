Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD6C35FFA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SI41VelXXBmsTwBvFh45qkOzfT1jNSmexItc1vD+uZw=; b=dPMRvODSGdbbjijMl3RGPhIL5Z
	fsZ65vuacS562VRQoSrljdsJACf41y1/Cq/0hNFtKa6ffpXJBSd7ZX6+Pl+MfmTcwQxRNupNUtxeN
	dpWmP5xB1WtkPeWKw1bpW6Rn31LoAcQ4wzNMNjdUMNLEuVLHumHQUMBI9ZnPXJtmIqtHVV+A7AIGh
	aYdONL9yLLhSdZW/tMaecrm3Tltv+FM98aKlhLSm+uUCdTKQsJ6hUI5IJzaEu587rpi0ukpV+sdaL
	VjgHPPAvU6ecb7r5cHb6jgcOQ0PW6xGLiz5P9laucWOisJ6TmknoM9uiA29cHpm5ZRzg1Lpq+o3Ri
	DOyuvqbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuReL-000000050G1-0eYP;
	Tue, 18 Mar 2025 07:46:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRcp-00000004zU5-31fP
	for linux-nvme@bombadil.infradead.org;
	Tue, 18 Mar 2025 07:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SI41VelXXBmsTwBvFh45qkOzfT1jNSmexItc1vD+uZw=; b=cZRr8Wo3DnVaQdJ1ULaXEctFNd
	nc+YkmnVfbvjR1qie0XKpda/2V0IUmwcFon1sbC51zc1emU/omj6cbSZTlqc2AXG4tI6PBFxeJ/iO
	oOXOJg8ZqmLPnn8dX9Ux7aZ8IeJft1/sSwVSkU5gUTx1pCpmEZ4SLJ+QYtaS51kbki65AwlTQSGav
	R10UnyTUQryVvoxxZ6kkpp8nn03FVnan9IYsonELKudxazwwL+4+LgPMygfEjTS9XlG6/Hmwr6DnZ
	TaD0YdsiRP0eUW1qe0woCotWvVTOzKspfCcqO3jGZkMTQWwekneIjLp8fMOaLhm18wowqvGTFWxOA
	6Pvu3/UQ==;
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRck-00000003iSA-23Q0
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:44:34 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kF3YJpz4f3m6g
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:43:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 90C921A19AA
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:44:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S10;
	Tue, 18 Mar 2025 15:44:13 +0800 (CST)
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
Subject: [RFC PATCH -next v3 06/10] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Date: Tue, 18 Mar 2025 15:35:41 +0800
Message-ID: <20250318073545.3518707-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH6189JNlnEt1YGw--.55732S10
X-Coremail-Antispam: 1UD129KBjvJXoW7trWfury8AF13GrWUuw1xXwb_yoW8Cr4Up3
	ZrWFWayry5tF47u3Z5WFyxuFy5Ka1YyFy7CrW7Cws8u3W3GryUWF47ta4UX3yDJFy3Xay3
	K3Wjkr9ruF4rGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRitxhPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_074433_169186_468614E6 
X-CRM114-Status: GOOD (  11.92  )
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

Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
default. This feature shall be disabled if any underlying device does
not support it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/md/dm-table.c | 7 +++++--
 drivers/md/dm.c       | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 453803f1edf5..d4a483287e26 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
 static void dm_set_stacking_limits(struct queue_limits *limits)
 {
 	blk_set_stacking_limits(limits);
-	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
+			    BLK_FEAT_WRITE_ZEROES_UNMAP;
 }
 
 /*
@@ -1848,8 +1849,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		limits->discard_alignment = 0;
 	}
 
-	if (!dm_table_supports_write_zeroes(t))
+	if (!dm_table_supports_write_zeroes(t)) {
 		limits->max_write_zeroes_sectors = 0;
+		limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
+	}
 
 	if (!dm_table_supports_secure_erase(t))
 		limits->max_secure_erase_sectors = 0;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5ab7574c0c76..b59c3dbeaaf1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1096,6 +1096,7 @@ void disable_write_zeroes(struct mapped_device *md)
 
 	/* device doesn't really support WRITE ZEROES, disable it */
 	limits->max_write_zeroes_sectors = 0;
+	limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
 }
 
 static bool swap_bios_limit(struct dm_target *ti, struct bio *bio)
-- 
2.46.1


