Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A29C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/xV6ABkk0UpUK7XenASy1v0PUp6lRTEoeHIFFktzGs=; b=qyLYqjg6yL+KdcCA41ZiAz2DkS
	tR4jTqinEdunDNkM922ZYDQi8n8awpeDcH1cLcpRTJVzK+t1NQMIIaaKJJkwkHstxzYzRVwP5h+0m
	eCePL2ZZyCeeoKKJp53NOl8kRoO85YmJptBlwKs2RqHVbjDL88RtRYHNzKZNsN60qhwIyz13jVZQZ
	wDMk0gpmbjrD8952qLwuxmmCcHUT3aqiz/dLRPIfoAufGHbiXrA4e4/9p6/7puM+n/xjd7XhBWcsn
	WJEhdl7DHqWeIZqmSIn9cKU06xIpKAeA51o5lMO0Ja36zBVbmxGKZf8jSPsyTQ0kg/2Bn6+gL+nT3
	p0AMmWIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ17d-00EqDP-0s;
	Wed, 17 Jan 2024 08:18:05 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ17Z-00Eq91-1w
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:18:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-ogcXo_1705479472;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-ogcXo_1705479472)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:17:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] test/nvme/050: test the reservation feature
Date: Wed, 17 Jan 2024 16:17:42 +0800
Message-ID: <20240117081742.93941-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117081742.93941-1-kanie@linux.alibaba.com>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_001801_808888_298703A6 
X-CRM114-Status: GOOD (  10.77  )
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
 tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 0000000..7e59de4
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,96 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the NVMe reservation feature
+#
+. tests/nvme/rc
+
+DESCRIPTION="test the reservation feature"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+resv_report() {
+	local nvmedev=$1
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		nvme resv-report "/dev/${nvmedev}n1" --eds | grep -v "hostid"
+	else
+		nvme resv-report "/dev/${nvmedev}n1" --cdw11=1 | grep -v "hostid"
+	fi
+}
+
+test_resv() {
+	local nvmedev=$1
+
+	echo "Register"
+	resv_report "${nvmedev}"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	resv_report "${nvmedev}"
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${nvmedev}"
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	resv_report "${nvmedev}"
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}"
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${nvmedev}"
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${nvmedev}"
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	local skipped=false
+	local subsys_path=""
+	local ns_path=""
+
+	_nvmet_target_setup --blkdev file --resv_enable
+	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	ns_path="${subsys_path}/namespaces/1"
+
+	if [[ -f "${ns_path}/resv_enable" ]] ; then
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		test_resv "${nvmedev}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
+	else
+		SKIP_REASONS+=("missing reservation feature")
+		skipped=true
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..2a46b32
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,108 @@
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
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.30.1 (Apple Git-130)


