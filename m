Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC94AD6EC08
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVJj/i7Xzvy3xuEXZue78efQPjxVl8GHsxBjH8RTsW4=; b=LrQ1tJBKUnEvGPS2bRJrK6zy7/
	u5ohrwAMGSDXL/EAIDwQr+s9fQ5p24nBX/9XXfV3kcJ97OPHrACmzvn0xTyFh+AG8WPlNHw+HPzsY
	DVABzd5eXRnBsTEKsIwV/sZwoOETqq8ST24S7sPRZ1WsppG6oj2iH70CG1ZwRXTEvZ+3H/Iv6co48
	TQmy4C1y19o1gM3urvQtpaZw/ynaK/56NK/xbAIa4Q/i7Peb0QSe4y49y9lwuVlcAQxqgv4vA+mdX
	75S2rBoSUvZ/3vRTGIBcSHzfXk+yFrYcN7H8IOgT+7PU2jPDOYhIJJcdwrEPjZrDn59kt03IeOyUF
	0tjOo7mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10w-00000000BOJ-0wIc;
	Fri, 29 Nov 2024 13:26:30 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10r-00000000BIH-1mXP
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886785; x=1764422785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WS/q1monsk/N/exQ8TlNy/jvToRLuZl8SfL8Y7BAPaM=;
  b=fkGaTozMBExdxX4dKwOw50IdmrDNEVsEVlWTprGH6piyb8mRsSz2BZHJ
   ZiMgXPn/6vjCb2qdBVFq66xZm+/iGf0nKWT7IzdN+slD0cDAYddjKaF/u
   9aZoKhA4nMiKq6rLU8/MF10Y1rC3ybcraE5DSPtBGuEkFYBtff1HycgFC
   m4Ov7QInhOsxg04wlssVXId6/9WTo6ufE/n2pc1iCs4AI1GwC5rLHAEY6
   cGwNKrSTyPs7ThHHiMUasFfFqhMKDIFt0MVvU39VDQxIoTVAPKcqUbAJa
   ERWrLZHjgBYIwZYwrElvpoKBKnl1ejDCnR4U8gPORZGQyNQyoN25rzKYb
   g==;
X-CSE-ConnectionGUID: Urvxz7i7QSShAMNPrydYJA==
X-CSE-MsgGUID: QowOkgeBSk6KYcWPXu9OKQ==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015180"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:23 +0800
IronPort-SDR: 6749b261_C34xbRPjRtZ5NjkuwwCDGApJ+TxJgc01tIFO0dl4qkBN/2z
 U5s7t/IgslDDue22x2oT54hzBdu4HvmEOrfbwuA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:24:01 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:24 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/7] test/nvme: add test for basic ANA support
Date: Fri, 29 Nov 2024 22:26:16 +0900
Message-ID: <20241129132617.400429-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052625_527127_AF796A58 
X-CRM114-Status: GOOD (  14.91  )
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

From: Hannes Reinecke <hare@suse.de>

Add a test for basic ANA support by creating 4 paths, run a fio
process to generate load, and then switch port states to check
if I/O continues uninterrupted.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: renumbered the test case from 054 to 055]
[Shin'ichiro: fixed a fio option typo]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/055     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |  5 +++
 2 files changed, 102 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..525193c
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Hannes Reinecke (SUSE) <hare@suse.de>
+#
+# Test nvme fabrics controller ANA failover during I/O
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme fabrics controller ANA failover during I/O"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+failback() {
+	local portno=0
+
+	for port in "$@"; do
+		if (( portno == 0 )); then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+		elif (( portno == 1 )); then
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+		else
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+		fi
+		portno=$(( portno + 1 ))
+	done
+}
+
+failover() {
+	local portno=0
+
+	for port in "$@"; do
+		if (( portno == 2 )); then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+		elif (( portno == 3 )); then
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+		else
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+		fi
+		portno=$(( portno + 1))
+	done
+}
+
+test() {
+	local fio_pid
+	local -a ports
+	local port
+	local ns
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup --ports 4
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	failback "${ports[@]}"
+
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}"
+	done
+
+	# start fio job
+	ns=$(_find_nvme_ns "$def_subsys_uuid")
+	_run_fio_verify_io --filename="/dev/${ns}" \
+			   --group_reporting --ramp_time=5 \
+			   --time_based --runtime=1m &> "$FULL" &
+	fio_pid=$!
+	sleep 5
+
+	# switch port status
+	echo "ANA failover"
+	failover "${ports[@]}"
+
+	sleep 10
+
+	# switch back to original state
+	echo "ANA failback"
+	failback "${ports[@]}"
+
+	sleep 10
+
+	{ kill "${fio_pid}"; wait; } &> /dev/null
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/055.out b/tests/nvme/055.out
new file mode 100644
index 0000000..9937d40
--- /dev/null
+++ b/tests/nvme/055.out
@@ -0,0 +1,5 @@
+Running nvme/055
+ANA failover
+ANA failback
+disconnected 4 controller(s)
+Test complete
-- 
2.47.0


