Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E94CF2564
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Oct 2024 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DFeiuL4jI2MzWGWI9sJ7eu2aW8e9t3wrO81YILLR8iM=; b=Qc6a1YtIXDFpUacMdLoH73CMYj
	Y2QFCMZ66AzDh4p7ft+g64brr2CilqOXpJZiB816ygOTymJl4CqA65zUrkpP+SNsiYjSuvKaBBW/C
	30o5mXBCoUWTmgzHu2WXwmga/ZBN8ha9Wl2xh4XqgBdYTERvmEXdbeHbwRqBneZcDM1lvM++QYvA9
	11AF2y5BcCcn2WdBy/HyqvR3iK4RQ39ikJujxKm1jA+csNdCM7mqFheGWF1uri1X+5uCFOPRK/nAX
	LlR2jbFlRaHrNEuptXt40gw+LhENQDV0lH5j/NXrqNgX7/fEdhZLmDJgi4c32uB6qCn/IkXNfh2Vr
	bA6LnbaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szaB0-000000012pL-3NXg;
	Sat, 12 Oct 2024 11:20:50 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sza2k-0000000127o-2MYL
	for linux-nvme@lists.infradead.org;
	Sat, 12 Oct 2024 11:12:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728731536; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DFeiuL4jI2MzWGWI9sJ7eu2aW8e9t3wrO81YILLR8iM=;
	b=mxzx3UX7wk730H8nKLRQYFB0txejZy04XER7xKrqiYWVRAuZO5gk4B2rf/TvbJcDpyiwogbFzjexM6qMiPQwkcX0bqLVs7xYv15LiHZ7gmr6lUNfOCKjtudg3iAH79HT6nJYko/FjyI205kPrGIiSp/V0RBpDzEXta+a4QDuYpk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGvtE9O_1728731527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 19:12:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
Date: Sat, 12 Oct 2024 19:11:57 +0800
Message-ID: <20241012111157.44368-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012111157.44368-1-kanie@linux.alibaba.com>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241012_041218_782932_5F572D56 
X-CRM114-Status: GOOD (  10.64  )
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

Test the NVMe reservation feature, including register, acquire,
release and report.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

diff --git a/tests/nvme/054 b/tests/nvme/054
new file mode 100644
index 0000000..f352c73
--- /dev/null
+++ b/tests/nvme/054
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the NVMe reservation feature
+#
+. tests/nvme/rc
+
+DESCRIPTION="Test the NVMe reservation feature"
+QUICK=1
+nvme_trtype="loop"
+
+requires() {
+	_nvme_requires
+}
+
+resv_report() {
+	local nvmedev=$1
+	local report_arg=$2
+
+	nvme resv-report "/dev/${nvmedev}n1" "${report_arg}" | grep -v "hostid"
+}
+
+test_resv() {
+	local nvmedev=$1
+	local report_arg="--cdw11=1"
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		report_arg="--eds"
+	fi
+
+	echo "Register"
+	resv_report "${nvmedev}" "${report_arg}"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}" "${report_arg}"
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
+		_nvme_connect_subsys
+
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		test_resv "${nvmedev}"
+		_nvme_disconnect_subsys
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
diff --git a/tests/nvme/054.out b/tests/nvme/054.out
new file mode 100644
index 0000000..66e51dd
--- /dev/null
+++ b/tests/nvme/054.out
@@ -0,0 +1,108 @@
+Running nvme/054
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
+  cntlid     : ffff
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
+  cntlid     : ffff
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
+  cntlid     : ffff
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
+  cntlid     : ffff
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
+  cntlid     : ffff
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
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.43.0


