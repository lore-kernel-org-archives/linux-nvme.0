Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0227C28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaGJ43SbcNtdC2qn1wX4P8h4jPrDgI1B1I1fi9IkH3M=; b=Ux4v0xdVeZ28X6pRUphW7063t/
	DS+qFuIneLDmGqQz+2Xj+iJGO8BDI7EM+ZTM1P1/HD031+PptG7M3wxJMdcz646SdpLaLltEVRFCW
	W3cnI+7EYRel4Zlbl1foQ9SEDOMm+sOsKRdzY+cKcVURznwZej2kf26MjfCfdl23JUms80T0Mfvgk
	c4JLE5EJUw4+axBEfbsjmPJN2aubGOQjjHP4WLGqOdsBfWW8eLQhT7v58dfC5vJZli/e/6MC0/P6a
	crgluF9pdrzi/MoMFsqNc41aYWPDT1ftkDMVI/BsbVdWYcrYSUteVtdeqwWUdre4hMMKSW2Vbm1on
	7ODvTYKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuReJ-000000050Dz-40wM;
	Tue, 18 Mar 2025 07:46:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRcn-00000004zRY-0FwM
	for linux-nvme@bombadil.infradead.org;
	Tue, 18 Mar 2025 07:44:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kaGJ43SbcNtdC2qn1wX4P8h4jPrDgI1B1I1fi9IkH3M=; b=H/tFi6GnpX/yGFkUowWFWaBPeT
	dZPYopwSa+20UgN3QwGGEBQntEfMHocLRv5426TO+4sCJvEMuJn2zkzZbFUZM8Ral58b/i5ZOsMSg
	ufYD9exBtKMy3uOhQsTCe94FFegaZoHNc8rtYacmebQhN5dqEzGBMYQaHuZz2hJ8OkP4sEaeQ9YXP
	uM/RcB7jLTdhMc7pz+V6HtNNDqvIV7V7KCkIsriIXSa3lwGLCsaC12Vzunlb+S8vFBdpGv72mxyWk
	oBH58bvSzVZNSWjKV6/D5DZNBA/htGZJoNuNmChv338DRpQNCwQfR7z3PkAHAeyV/5+grj97unLx3
	h0S9zEGg==;
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRcj-00000003iSC-0jMu
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:44:31 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kH4xj2z4f3khR
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:43:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4714C1A19AA
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:44:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S11;
	Tue, 18 Mar 2025 15:44:14 +0800 (CST)
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
Subject: [RFC PATCH -next v3 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Date: Tue, 18 Mar 2025 15:35:42 +0800
Message-ID: <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH6189JNlnEt1YGw--.55732S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrGFW7Jr18Aw1kArW3GFg_yoWrWryxpF
	W3GF1rGrW0ga4rC3s3Can7ur98Zws5Wr43ZrW2gr1UZr45tr1xKFsFgFyYva4xJrW7AF4Y
	qrnIgr98ua47A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250318_074430_102760_DB158F2F 
X-CRM114-Status: GOOD (  20.02  )
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

Users can check the disk support of unmap write zeroes command by
querying:

    /sys/block/<disk>/queue/write_zeroes_unmap

Finally, this flag should not be specified in conjunction with the
FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
not permitted, and filesystems that always require out-of-place writes
should not support this flag since they still need to allocated new
blocks during subsequent overwrites.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/open.c                   |  1 +
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index bdbf03f799a1..03b30613d7dc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -278,6 +278,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
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
index 5810371ed72b..265aae7ff8c1 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -78,4 +78,22 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
+ * zeros by issuing a zeroing operation. Blocks should be allocated for the
+ * regions that span holes in the file, and the entire range is converted to
+ * written extents. This flag is beneficial for subsequent pure overwriting
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


