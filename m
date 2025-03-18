Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D5CC28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VMpROLiyoow3esmZnGDRUg6Osx8itgvnWjJezistNv8=; b=aq7d5W8jhHg/AFLBGQ3YM0Eak0
	lHJc46HT06qeQK4axC3XQSWi9M+5XX6/VBV+yqAKekhmQzypR5D6ld0Ct7FZwwsmpwGOuWtgdZAlc
	CNoZQH3qLGI2p/+lsgJiOOxIC938dP2Z2usWZDB1EcO/YKVuCz47cZhraVhDsk+eZh7mScAUJ9BjR
	IG4slYI/YoDEGgoD/JhDCf79Y8otKC4MUKt9OMUtOTyJHVd7KDR5jfkfJEyZfLn8MTtMmoQfAE1aR
	hlizJHSi7jOwEQkzDm6yvN5poOBNbkmunD1WdLDQAnvVrjlKa/Cpg20DYvwn2aam79Xs07w2MSDgg
	C27UIU9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTO-00000004vny-0hOa;
	Tue, 18 Mar 2025 07:34:50 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTL-00000004vlb-024O
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:34:49 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WH5vQbz4f3m6s
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E2FA11A0AD6
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S5;
	Tue, 18 Mar 2025 15:34:43 +0800 (CST)
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
Subject: [PATCH xfstests 1/5] generic/764: add page boundaries tests for fallocate write zeroes
Date: Tue, 18 Mar 2025 15:26:11 +0800
Message-ID: <20250318072615.3505873-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
References: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8EItlnJDdYGw--.56140S5
X-Coremail-Antispam: 1UD129KBjvAXoWftr4xXF1xJw1fAF13CrWrGrg_yoW8urW5Xo
	Wayw1DGws5CryUCr1UAw12vr45W343W3W3ArW8Zr13tr9rWF47A3W0y3WUJr4kJryI9wn8
	Jr10yrn8C3Z0grn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOc7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
	kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7sR_YFAtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003447_357075_B409DE0E 
X-CRM114-Status: GOOD (  13.55  )
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

Add page boundaries and boundaries that are off-by-one tests for the
fallocate FALLOC_FL_WRITE_ZEROES command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 common/rc             |   2 +-
 tests/generic/764     |  34 ++++
 tests/generic/764.out | 433 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 468 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out

diff --git a/common/rc b/common/rc
index 6592c835..ed70c3c4 100644
--- a/common/rc
+++ b/common/rc
@@ -2780,7 +2780,7 @@ _require_xfs_io_command()
 		testio=`$XFS_IO_PROG -F -f -c "$command $param 0 1m" $testfile 2>&1`
 		param_checked="$param"
 		;;
-	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
+	"fpunch" | "fcollapse" | "zero" | "fzero" | "fwzero" | "finsert" | "funshare")
 		local blocksize=$(_get_file_block_size $TEST_DIR)
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 $((5 * $blocksize))" \
 			-c "fsync" -c "$command $blocksize $((2 * $blocksize))" \
diff --git a/tests/generic/764 b/tests/generic/764
new file mode 100755
index 00000000..0750666b
--- /dev/null
+++ b/tests/generic/764
@@ -0,0 +1,34 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 764
+#
+# Makes calls to fallocate write zeroes range and checks tossed ranges
+#
+# Primarily tests page boundries and boundries that are off-by-one to
+# ensure we're only tossing what's expected
+#
+# (generic/008 is a similar test but for fzero.)
+#
+. ./common/preamble
+_begin_fstest auto quick prealloc zero
+
+# Import common functions.
+. ./common/filter
+. ./common/punch
+
+# Modify as appropriate.
+_require_xfs_io_command "fwzero"
+_require_test
+
+testfile=$TEST_DIR/764.$$
+
+_test_block_boundaries 1024 fwzero _filter_xfs_io_unique $testfile
+_test_block_boundaries 2048 fwzero _filter_xfs_io_unique $testfile
+_test_block_boundaries 4096 fwzero _filter_xfs_io_unique $testfile
+_test_block_boundaries 65536 fwzero _filter_xfs_io_unique $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/764.out b/tests/generic/764.out
new file mode 100644
index 00000000..18bda195
--- /dev/null
+++ b/tests/generic/764.out
@@ -0,0 +1,433 @@
+QA output created by 764
+zero 0, 1
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
+00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000400:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1023
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+000003f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41  ...............A
+00000400:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1024
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000400:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1025
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000400:  00 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  .BBBBBBBBBBBBBBB
+00000410:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 1023, 1024
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000003f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000400:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+000007f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42  ...............B
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 1023, 1025
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000003f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000400:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 1023, 1026
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000003f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000400:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 1024, 1024
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000400:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 512 , 1024
+wrote 1024/1024 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 1024
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000200:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000600:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
+00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 2047
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+000007f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41  ...............A
+00000800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 2048
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 2049
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000800:  00 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  .BBBBBBBBBBBBBBB
+00000810:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 2047, 2048
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000007f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000ff0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42  ...............B
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 2047, 2049
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000007f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 2047, 2050
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+000007f0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 2048, 2048
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 1024 , 2048
+wrote 2048/2048 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 2048
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000400:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000c00:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
+00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00001000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 4095
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00000ff0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41  ...............A
+00001000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 4096
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00001000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 4097
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00001000:  00 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  .BBBBBBBBBBBBBBB
+00001010:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 4095, 4096
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000ff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00001000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00001ff0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42  ...............B
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 4095, 4097
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000ff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00001000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 4095, 4098
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000ff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00001000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 4096, 4096
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00001000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 2048 , 4096
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00001800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 1
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
+00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00010000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 65535
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+0000fff0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41  ...............A
+00010000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 65536
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00010000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 0, 65537
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00010000:  00 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  .BBBBBBBBBBBBBBB
+00010010:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 65535, 65536
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+0000fff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00010000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+0001fff0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42  ...............B
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 65535, 65537
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+0000fff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00010000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 65535, 65538
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+0000fff0:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 00  AAAAAAAAAAAAAAA.
+00010000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 65536, 65536
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00010000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+zero 32768 , 65536
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+*
+00008000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+*
+00018000:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+*
+read 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.46.1


