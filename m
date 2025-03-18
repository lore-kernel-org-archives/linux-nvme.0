Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED9AC28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PTokjUOJvbrAsoWwumEr6T0cIjbHS8Tf+94u8tBaslQ=; b=BX5MtQrbV0UBywXAebknML3L4X
	nCZQTbpzNLDkDxsqSeVTKMCDkFMNDAv3CUrXPvfTWSMydg3/KHDgbVYfIkuMwKtBz5K0BQhh/QhpZ
	fdsyhIUkIXyUWx3IE/dwa2xe7LGBokOm066O1IZ424jzAEVTe+NxKzpYNRnwW0xFoPySP0Y/tye8j
	DIKhpkIUpziGSXCCk59N37tMMdG8vYDC65i30OYOWXMYVYJCvLCboDTHwjrlj2W2+F2a8xn/uuUut
	kSQblhuc25R/BWptgahLC6rzlIS+QPEWIrAxru+45JvyXiXyo39few1o30763p08Jz/5XpE9XJYVS
	R/WC3SuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRWm-00000004xLQ-1DNx;
	Tue, 18 Mar 2025 07:38:20 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRVW-00000004x1d-2zyN
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:37:04 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Z23Tkkz4f3jtt
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:36:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA61E1A1940
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:36:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S5;
	Tue, 18 Mar 2025 15:36:59 +0800 (CST)
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
Subject: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:33 +0800
Message-ID: <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXu1+PItlnS19YGw--.63204S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5GrykJFy7XF48JF1DKFg_yoW8Krykp3
	48K3ZYkr4Iqw17G3WS9F47Wr13GaykAr17ZayxW34jvrykZryakw1IgFyUJFZ3Jr93Ww4F
	vFs5XFWFkr9rtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRb4SwUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003703_054242_0E1F0143 
X-CRM114-Status: GOOD (  11.85  )
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

Test block device unmap write zeroes sysfs interface with various SCSI
debug devices. The /sys/block/<disk>/queue/write_zeroes_unmap interface
should return 1 if the SCSI device enable the WRITE SAME command with
unmap functionality, and it should return 0 otherwise.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

diff --git a/tests/scsi/010 b/tests/scsi/010
new file mode 100755
index 0000000..27a672c
--- /dev/null
+++ b/tests/scsi/010
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Huawei.
+#
+# Test block device unmap write zeroes sysfs interface with various scsi
+# devices.
+
+. tests/scsi/rc
+. common/scsi_debug
+
+DESCRIPTION="test unmap write zeroes sysfs interface with scsi devices"
+QUICK=1
+
+requires() {
+	_have_scsi_debug
+}
+
+device_requries() {
+	_require_test_dev_sysfs queue/write_zeroes_unmap
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# disable WRITE SAME with unmap
+	if ! _configure_scsi_debug lbprz=0; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(16) with unmap
+	if ! _configure_scsi_debug lbprz=1 lbpws=1; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME(16) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(10) with unmap
+	if ! _configure_scsi_debug lbprz=1 lbpws10=1; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME(10) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/010.out b/tests/scsi/010.out
new file mode 100644
index 0000000..6581d5e
--- /dev/null
+++ b/tests/scsi/010.out
@@ -0,0 +1,2 @@
+Running scsi/010
+Test complete
-- 
2.46.1


