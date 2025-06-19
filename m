Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10934C7115A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbUBKZkio7y6BwOo6dQcbw+mnypSGRLE9+kBWy985uc=; b=wc/z8tMg78OUpaBt0BcUFsggn3
	HVMG93vayJFW0FX1c/NWLNLvoPkDw0ml5FhL+jnb+buVxeSC1csiFxpY7u/vhcVOp5mHtPdwL9tR0
	cjTdTd3Xjow6XEohnJYzl5vurShG+650mOlnfBvQDBEszZvweN4M4WvxQM18RpQ8qZG456LY0l76r
	am/5X//8Z36o46dvrdhAJjruuVnQzMQ7kWEC641n42d7e8pHYmrINYnXGdOgBmzGHz0adyfei3k7D
	DJp1wKYgFrTvkN5w8Kpa3OZOhEml5L//cVREzvvJNrfA+s/DH7i3umXbXxDYW+ZrYRDKxvWTRsqPe
	i29r8SaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHSK-0000000DSp6-44wv;
	Thu, 19 Jun 2025 15:45:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDV4-0000000Ct8i-0w0F
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Jun 2025 11:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NbUBKZkio7y6BwOo6dQcbw+mnypSGRLE9+kBWy985uc=; b=WSEGe1Y5PkVc4qqjvonbYQrAf6
	AJ8pZM26zYjQdSEjVl2aBXgU28UJJO+vn3+NXH5ye3/JirA8UGAEqUcHa/jvFyFXpwYlhgvtJvK1Q
	3BMAfEErwk6+50nPtCXW+2DSnHOSna/h5trKg1C5wEoizDi+qTv/Ebvd9q7Ptja8BR/ImqDWKwu+G
	eTIuQi5RyoQgLT11gw/vfHBSS3Ckfb0EKFLwB/Cgb7pP9XAjWMDQQjrac6f/g+1NWJ+htbXAMm1iV
	KesDazcoRw9npiGEaiqdBtdNYBH9/Om1GfYKFga5WiPLZaUkF+IaDZK/iTc3JYJMrh0zFxKthwIfR
	RTaO+FJQ==;
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDUz-00000004QoS-1QsU
	for linux-nvme@lists.infradead.org;
	Thu, 19 Jun 2025 11:32:09 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNS02C5zYQvLt
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA1291A193E
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S10;
	Thu, 19 Jun 2025 19:31:50 +0800 (CST)
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
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 6/9] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Date: Thu, 19 Jun 2025 19:18:03 +0800
Message-ID: <20250619111806.3546162-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH618Y9VNoihn_Pw--.51230S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrGFW7Jr18Aw1kArW3GFg_yoWrCF1xpF
	W3GF1rKrWvgF1rC3s3Can7ur98Zws5Gr43urWIgr1UZr45Jr1IgFsFgFyYva4xXrW3Aa1F
	qFnI9r98ua47A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_123207_090146_D8136F6D 
X-CRM114-Status: GOOD (  19.50  )
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

With the development of flash-based storage devices, we can quickly
write zeros to SSDs using the WRITE_ZERO command if the devices do not
actually write physical zeroes to the media. Therefore, we can use this
command to quickly preallocate a real all-zero file with written
extents. This approach should be beneficial for subsequent pure
overwriting within this file, as it can save on block allocation and,
consequently, significant metadata changes, which should greatly improve
overwrite performance on certain filesystems.

Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
fallocate. This flag is used to convert a specified range of a file to
zeros by issuing a zeroing operation. Blocks should be allocated for the
regions that span holes in the file, and the entire range is converted
to written extents. If the underlying device supports the actual offload
write zeroes command, the process of zeroing out operation can be
accelerated. If it does not, we currently don't prevent the file system
from writing actual zeros to the device. This provides users with a new
method to quickly generate a zeroed file, users no longer need to write
zero data to create a file with written extents.

Users can determine whether a disk supports the unmap write zeroes
feature through querying this sysfs interface:

    /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes

Users can also enable or disable the unmap write zeroes operation
through this sysfs interface:

    /sys/block/<disk>/queue/write_zeroes_unmap_max_bytes

Finally, this flag cannot be specified in conjunction with the
FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
not permitted. In addition, filesystems that always require out-of-place
writes should not support this flag since they still need to allocated
new blocks during subsequent overwrites.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 fs/open.c                   |  1 +
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..b777e11e5522 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -281,6 +281,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		break;
 	case FALLOC_FL_COLLAPSE_RANGE:
 	case FALLOC_FL_INSERT_RANGE:
+	case FALLOC_FL_WRITE_ZEROES:
 		if (mode & FALLOC_FL_KEEP_SIZE)
 			return -EOPNOTSUPP;
 		break;
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 3f49f3df6af5..7c38c6b76b60 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -36,7 +36,8 @@ struct space_resv {
 				 FALLOC_FL_COLLAPSE_RANGE |	\
 				 FALLOC_FL_ZERO_RANGE |		\
 				 FALLOC_FL_INSERT_RANGE |	\
-				 FALLOC_FL_UNSHARE_RANGE)
+				 FALLOC_FL_UNSHARE_RANGE |	\
+				 FALLOC_FL_WRITE_ZEROES)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 5810371ed72b..1f9ca757d02d 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -78,4 +78,21 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_WRITE_ZEROES zeroes a specified file range in such a way that
+ * subsequent writes to that range do not require further changes to the file
+ * mapping metadata. This flag is beneficial for subsequent pure overwriting
+ * within this range, as it can save on block allocation and, consequently,
+ * significant metadata changes. Therefore, filesystems that always require
+ * out-of-place writes should not support this flag.
+ *
+ * Different filesystems may implement different limitations on the
+ * granularity of the zeroing operation. Most will preferably be accelerated
+ * by submitting write zeroes command if the backing storage supports, which
+ * may not physically write zeros to the media.
+ *
+ * This flag cannot be specified in conjunction with the FALLOC_FL_KEEP_SIZE.
+ */
+#define FALLOC_FL_WRITE_ZEROES		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.46.1


