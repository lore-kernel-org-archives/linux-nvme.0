Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CB8CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 02:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOf2DKnIbNC3Z++EQlVLboe0+LWsNps+gfHP62HK7zU=; b=nUa2ZYMCc1zUBbaooq09uJjFR5
	wJFKWQcYjwdkfQ1pBP77ol1Y+4HhOlfekPZgzf3ZvHeJBpoKieP47+jcq8GkjkUTd6IhebJpuEvnc
	xERqZGQDuZD9wRfix3SOYBV/QzUq7C9i4+3cYK99wCFQc1oQJlQYwwngKf5tuD9wCFQlp8zBH9RC9
	YTvgzw93V2JsGo3gVYdtUR+JKtJPIxO7meLXqhcdBED2S68D0q8OxQssUe61CqisJxcAp7T3YbKMM
	tAJDN7zwebO/FxADZtEhPlngE9CWykn5Tl68EzH1ye25HjFgK4byEL8UV1w8kB5HBjtcXMMq6N8+J
	KUC+aBYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1b7-0000000CSPI-3ikb;
	Wed, 13 Aug 2025 02:52:17 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1b4-0000000CSNl-3PxP
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 02:52:16 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFV4fHhzYQtHM
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:52:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 440781A1549
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:52:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S5;
	Wed, 13 Aug 2025 10:52:13 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
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
Subject: [PATCH blktests v2 1/3] scsi/010: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:19 +0800
Message-Id: <20250813024421.2507446-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
References: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHwhLQ_ZtoAscBDg--.14424S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13tFy3tr43Ww1kXrWfuFg_yoWrArW3pr
	y0kFZYgrW8XrsrJrs5Cay7Wr13AanYyry7Way7Jryj93ykZr17urs7KFWjqa1fGryfCw40
	qay5XFWSkr1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0piRRR_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_195215_169095_C1116A39 
X-CRM114-Status: GOOD (  13.48  )
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
debug devices. /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
should equal to the write_zeroes_max_bytes if the SCSI device enable the
WRITE SAME command with unmap functionality, and it should return 0
otherwise. /sys/block/<disk>/queue/write_zeroes_unmap_max_bytes should
be equal to write_zeroes_unmap_max_hw_bytes by default, and we can
disable write zeroes support by setting it to zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/scsi/010     | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

diff --git a/tests/scsi/010 b/tests/scsi/010
new file mode 100755
index 0000000..c5152a4
--- /dev/null
+++ b/tests/scsi/010
@@ -0,0 +1,84 @@
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
+setup_test_device() {
+	if ! _configure_scsi_debug "$@"; then
+		return 1
+	fi
+
+	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes ]]; then
+		_exit_scsi_debug
+		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
+		return 1
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# disable WRITE SAME with unmap
+	if ! setup_test_device lbprz=0; then
+		return 1
+	fi
+
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne 0 || $umap_bytes -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(16) with unmap
+	if ! setup_test_device lbprz=1 lbpws=1; then
+		return 1
+	fi
+
+	zero_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_max_bytes")"
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne $zero_bytes || $umap_bytes -ne $zero_bytes ]]; then
+		echo "Test enable WRITE SAME(16) with unmap failed."
+	fi
+
+	echo 0 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_bytes -ne 0 ]]; then
+		echo "Test manually disable WRITE SAME(16) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(10) with unmap
+	if ! setup_test_device lbprz=1 lbpws10=1; then
+		return 1
+	fi
+
+	zero_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_max_bytes")"
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne $zero_bytes || $umap_bytes -ne $zero_bytes ]]; then
+		echo "Test enable WRITE SAME(10) with unmap failed."
+	fi
+
+	echo 0 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_bytes -ne 0 ]]; then
+		echo "Test manually disable WRITE SAME(10) with unmap failed."
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
2.39.2


