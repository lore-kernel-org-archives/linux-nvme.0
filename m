Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C704ACFC52A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udq7pcCctGr3Sx5CeKGqMrVTo2htOSu7TSWvRa2n8Yk=; b=q7GLDR0QBC/pL+S+T8K7SqAbzO
	GgpAjgBG6VWdWkHcRdtNL6mRAQEElCyypHsnunwdlq2DQmlY/mvOUgc6sB+O30H015CjQjqQG6pUN
	WEVcg4tyA2Yy/wczr96QFSNRT7dt6WYmBdBQ+q01IwEiioxhArHb7grTqHYBR2YcUBOxqOOKRwkC5
	KdY+eFKzZpl53CEs9Nwo7xpeWn/dzXTsb5uLBpKvkQX3n7FgjR9q9vnVeXI6qdM6X4RlPHZFW4hQ4
	QEPZQJbnqToluC+1PKuzmmuIIZWH7qrbG7TxvYPfrxH0gd2pI3ieFbe6w3/oVsP8XnYMz8Omfv6P2
	ExreFYmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0HDz-00000004TmR-1BIj;
	Mon, 14 Oct 2024 09:18:47 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GxK-00000004PRV-2gxb
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 09:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728896492; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=udq7pcCctGr3Sx5CeKGqMrVTo2htOSu7TSWvRa2n8Yk=;
	b=KtwHSOVw1U7FKOzd4G1/pNe2X10bZ4sLUFD45BdYIWp8gldvtG8t/xzNrxNs5ZsboHjjzUNupcid7/KapCmw0ZJokKEpiYg9/2F5pvXTt0+3v0qtdlz/IgJI8PlrufQg7stpvZlYgWieSadYKvH3YIGRwe7LKgOiAz4Ww6YkGug=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3Sv3x_1728896486 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 17:01:31 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v4 2/2] nvme: test the nvme reservation feature
Date: Mon, 14 Oct 2024 17:01:16 +0800
Message-ID: <20241014090116.125500-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014090116.125500-1-kanie@linux.alibaba.com>
References: <20241014090116.125500-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_020134_849728_47FDD7C5 
X-CRM114-Status: GOOD (  11.51  )
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

diff --git a/tests/nvme/054 b/tests/nvme/054
new file mode 100644
index 0000000..dc674a7
--- /dev/null
+++ b/tests/nvme/054
@@ -0,0 +1,101 @@
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
+	local test_dev=$1
+	local report_arg=$2
+
+	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
+		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
+}
+
+test_resv() {
+	local nvmedev=$1
+	local report_arg="--cdw11=1"
+	test_dev="/dev/${nvmedev}n1"
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		report_arg="--eds"
+	fi
+
+	echo "Register"
+	resv_report "${test_dev}" "${report_arg}"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Replace"
+	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Unregister"
+	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Acquire"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Preempt"
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Release"
+	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Clear"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${test_dev}" "${report_arg}"
+	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
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
index 0000000..5adb30d
--- /dev/null
+++ b/tests/nvme/054.out
@@ -0,0 +1,68 @@
+Running nvme/054
+Register
+gen       : 0
+rtype     : 0
+regctl    : 0
+NVME Reservation  success
+gen       : 1
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
+Replace
+NVME Reservation  success
+gen       : 2
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 5
+Unregister
+NVME Reservation  success
+gen       : 3
+rtype     : 0
+regctl    : 0
+Acquire
+NVME Reservation  success
+NVME Reservation Acquire success
+gen       : 4
+rtype     : 1
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+Preempt
+NVME Reservation Acquire success
+gen       : 5
+rtype     : 2
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+Release
+NVME Reservation Release success
+gen       : 5
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
+Clear
+NVME Reservation  success
+NVME Reservation Acquire success
+gen       : 6
+rtype     : 1
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.43.0


