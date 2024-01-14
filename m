Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19037C47077
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jan 2024 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/WCkx3X+/OeJEwPW8X3Vx61rRFx8x5Ah7CYl7+TdZHs=; b=CV1UVTIdD5o7DyLD0XYm9HAONk
	nozTvQCRwwHFDtPCSS6eIcrS/s46BOoLCNJohaEDa2eGnfG4bFundl4n37t6BUuO6sq2sB8k9sdbr
	Mp7K4fcSbPnhHst7HFcA3a0LgFgDHDaTHAlQMSDhcsrbhIf2MKmG4GdnNM958onXp07DHvFc0+sN2
	dFPcShtzqhehvEvQc4ewwwzeTl3ee+czueU5U67Kq71eI361Jph0j7Tv8+vWXbmn9mWvCe5JySpfe
	k1f0zG46KH2vvAmPU3SAFR9HngUOr958lgspu0H+Id0Tgs+DTzlJyP7TuDd7MwedIJoFE4jhKWcwS
	wIjfRPOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwl6-006Ns2-3C;
	Sun, 14 Jan 2024 09:26:25 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwl4-006NrE-0J
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jan 2024 09:26:23 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W-XgLn-_1705224371;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-XgLn-_1705224371)
          by smtp.aliyun-inc.com;
          Sun, 14 Jan 2024 17:26:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH blktests] test/nvme/050: test the reservation feature
Date: Sun, 14 Jan 2024 17:26:11 +0800
Message-ID: <20240114092611.69075-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240114_012622_272373_CD6A41CF 
X-CRM114-Status: GOOD (  10.82  )
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

Test the reservation feature, includes register, acquire, release
and report.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/050     |  67 ++++++++++++++++++++++++++
 tests/nvme/050.out | 114 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      |   3 ++
 3 files changed, 184 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 0000000..a499f66
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the reservation
+#
+. tests/nvme/rc
+
+DESCRIPTION="test the reservation"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+
+	_nvmet_target_setup --blkdev file
+
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+	echo "Register"
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
+
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..3be417d
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,114 @@
+Running nvme/050
+Register
+
+NVME Reservation status:
+
+gen       : 0
+rtype     : 0
+regctl    : 0
+ptpls     : 0
+
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 1
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Replace
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 2
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 5
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Unregister
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 3
+rtype     : 0
+regctl    : 0
+ptpls     : 0
+
+Acquire
+NVME Reservation  success
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 4
+rtype     : 1
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Preempt
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 5
+rtype     : 2
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Release
+NVME Reservation Release success
+
+NVME Reservation status:
+
+gen       : 5
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Clear
+NVME Reservation  success
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 6
+rtype     : 1
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b0ef1ee..8de59e2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -670,6 +670,9 @@ _create_nvmet_ns() {
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f "${ns_path}/resv_enable" ]]; then
+		printf 1 > "${ns_path}/resv_enable"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
-- 
2.30.1 (Apple Git-130)


