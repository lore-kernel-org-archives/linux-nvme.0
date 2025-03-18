Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F5FC35FF9
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECmzSNi4N/vPOt8473XBu6s/wnd6AX5N1D8RXvzPLmc=; b=UeN02mAsSZogJ2HW4fuJ+gxHU5
	BMmrMAMwcbkw92HvjPECm4h0HVrNmEi7R/2InT7CpSYRK0UcXJbNxKQ/6ivczaDw4QM0JKGugjkBt
	snkASAzrnBfrHHbzQOTla5y6kHLNlDrOiMhJQh5QP0DuP66yxoYS9JasUu0kGesx/0hZz1iPdZD+M
	OONWFKuGfpQElqypdiOhDj/T7fUcUwulGqqFR+BAwh+mtH1hAKGJHiFgSv70Tm2c0H0x8MqaMFfNs
	HYDrlM3LavoIWwLND/LKAsMIUBq9iF+xmyoKDPYG/FS5gs7zb9zuC3h4Ko0vxuXcJ7BleNtH2pXnS
	djedFOsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTR-00000004vqs-01fd;
	Tue, 18 Mar 2025 07:34:53 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTN-00000004vlk-0j0G
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:34:50 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WL0GW5z4f3kGD
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A40D21A19F8
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S6;
	Tue, 18 Mar 2025 15:34:44 +0800 (CST)
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
Subject: [PATCH xfstests 2/5] generic/765: add generic tests for fallocate write zeroes
Date: Tue, 18 Mar 2025 15:26:12 +0800
Message-ID: <20250318072615.3505873-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
References: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8EItlnJDdYGw--.56140S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1UAF18JrWkKFW8tryfXrb_yoWfAFy5pr
	Wqvw1DCr48Gw4kZa1YkF4rGr97XFsFy3WDur1xuF1Ykry7Kry0kF48Ww4xA342yF1xCF43
	XrZ5A3ZFgr1qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTR_3kZDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003449_609673_9950EE2C 
X-CRM114-Status: GOOD (  11.11  )
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

Add generic tests for the fallocate FALLOC_FL_WRITE_ZEROES command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/generic/765     |  40 +++++++
 tests/generic/765.out | 269 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 309 insertions(+)
 create mode 100755 tests/generic/765
 create mode 100644 tests/generic/765.out

diff --git a/tests/generic/765 b/tests/generic/765
new file mode 100755
index 00000000..4cbef82a
--- /dev/null
+++ b/tests/generic/765
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 765
+#
+# Test fallocate FALLOC_FL_WRITE_ZEROES
+#
+# (generic/008 is a similar test but for fzero.)
+#
+. ./common/preamble
+_begin_fstest auto quick prealloc zero fiemap
+
+# Import common functions.
+. ./common/filter
+. ./common/punch
+
+# Modify as appropriate.
+_require_xfs_io_command "fwzero"
+_require_xfs_io_command "fiemap"
+_require_xfs_io_command "falloc"
+_require_test
+
+testfile=$TEST_DIR/765.$$
+
+# Standard write zeroes tests
+_test_generic_punch falloc fwzero fwzero fiemap _filter_fiemap $testfile
+
+# Delayed allocation write zeroes tests
+_test_generic_punch -d falloc fwzero fwzero fiemap _filter_fiemap $testfile
+
+# Multi write zeroes tests
+_test_generic_punch -k falloc fwzero fwzero fiemap _filter_fiemap $testfile
+
+# Delayed allocation multi write zeroes tests
+_test_generic_punch -d -k falloc fwzero fwzero fiemap _filter_fiemap $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/765.out b/tests/generic/765.out
new file mode 100644
index 00000000..7dd949c4
--- /dev/null
+++ b/tests/generic/765.out
@@ -0,0 +1,269 @@
+QA output created by 765
+	1. into a hole
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	2. into allocated space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	3. into unwritten space
+0: [0..127]: unwritten
+1: [128..383]: data
+2: [384..639]: unwritten
+1aca77e2188f52a62674fe8a873bdaba
+	4. hole -> data
+0: [0..127]: hole
+1: [128..511]: data
+2: [512..639]: hole
+286aad7ca07b2256f0f2bb8e608ff63d
+	5. hole -> unwritten
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..511]: unwritten
+3: [512..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	6. data -> hole
+0: [0..383]: data
+1: [384..639]: hole
+3976e5cc0b8a47c4cdc9e0211635f568
+	7. data -> unwritten
+0: [0..383]: data
+1: [384..511]: unwritten
+2: [512..639]: hole
+3976e5cc0b8a47c4cdc9e0211635f568
+	8. unwritten -> hole
+0: [0..127]: unwritten
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	9. unwritten -> data
+0: [0..127]: unwritten
+1: [128..511]: data
+2: [512..639]: hole
+286aad7ca07b2256f0f2bb8e608ff63d
+	10. hole -> data -> hole
+0: [0..127]: hole
+1: [128..511]: data
+2: [512..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	11. data -> hole -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	12. unwritten -> data -> unwritten
+0: [0..127]: unwritten
+1: [128..511]: data
+2: [512..639]: unwritten
+1aca77e2188f52a62674fe8a873bdaba
+	13. data -> unwritten -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	14. data -> hole @ EOF
+0: [0..639]: data
+eb591f549edabba2b21f80ce4deed8a9
+	15. data -> hole @ 0
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	16. data -> cache cold ->hole
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	2. into allocated space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	3. into unwritten space
+0: [0..127]: unwritten
+1: [128..383]: data
+2: [384..639]: unwritten
+1aca77e2188f52a62674fe8a873bdaba
+	4. hole -> data
+0: [0..127]: hole
+1: [128..511]: data
+2: [512..639]: hole
+286aad7ca07b2256f0f2bb8e608ff63d
+	5. hole -> unwritten
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..511]: unwritten
+3: [512..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	6. data -> hole
+0: [0..383]: data
+1: [384..639]: hole
+3976e5cc0b8a47c4cdc9e0211635f568
+	7. data -> unwritten
+0: [0..383]: data
+1: [384..511]: unwritten
+2: [512..639]: hole
+3976e5cc0b8a47c4cdc9e0211635f568
+	8. unwritten -> hole
+0: [0..127]: unwritten
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	9. unwritten -> data
+0: [0..127]: unwritten
+1: [128..511]: data
+2: [512..639]: hole
+286aad7ca07b2256f0f2bb8e608ff63d
+	10. hole -> data -> hole
+0: [0..127]: hole
+1: [128..511]: data
+2: [512..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	11. data -> hole -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	12. unwritten -> data -> unwritten
+0: [0..127]: unwritten
+1: [128..511]: data
+2: [512..639]: unwritten
+1aca77e2188f52a62674fe8a873bdaba
+	13. data -> unwritten -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	14. data -> hole @ EOF
+0: [0..639]: data
+eb591f549edabba2b21f80ce4deed8a9
+	15. data -> hole @ 0
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	16. data -> cache cold ->hole
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	2. into allocated space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	3. into unwritten space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	4. hole -> data
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	5. hole -> unwritten
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	6. data -> hole
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	7. data -> unwritten
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	8. unwritten -> hole
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	9. unwritten -> data
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	10. hole -> data -> hole
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	11. data -> hole -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	12. unwritten -> data -> unwritten
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	13. data -> unwritten -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	14. data -> hole @ EOF
+0: [0..639]: data
+eb591f549edabba2b21f80ce4deed8a9
+	15. data -> hole @ 0
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	16. data -> cache cold ->hole
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+	1. into a hole
+0: [0..127]: hole
+1: [128..383]: data
+2: [384..639]: hole
+1aca77e2188f52a62674fe8a873bdaba
+	2. into allocated space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	3. into unwritten space
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	4. hole -> data
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	5. hole -> unwritten
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	6. data -> hole
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	7. data -> unwritten
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	8. unwritten -> hole
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	9. unwritten -> data
+0: [0..639]: data
+2f7a72b9ca9923b610514a11a45a80c9
+	10. hole -> data -> hole
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	11. data -> hole -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	12. unwritten -> data -> unwritten
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	13. data -> unwritten -> data
+0: [0..639]: data
+0bcfc7652751f8fe46381240ccadd9d7
+	14. data -> hole @ EOF
+0: [0..639]: data
+eb591f549edabba2b21f80ce4deed8a9
+	15. data -> hole @ 0
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	16. data -> cache cold ->hole
+0: [0..639]: data
+b0c249edb75ce5b52136864d879cde83
+	17. data -> hole in single block file
+0: [0..7]: data
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+0000200 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000400 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
-- 
2.46.1


