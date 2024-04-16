Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11EBC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZFXHaGXn6yrag7c66Jd39t4cbkP9NsjNSH+d33RCI4=; b=GHxnRmQez2ovuh9hK/60+RWUBd
	IH6FwxmWQSHvVkmVOBT8vddbsQteAZa8Hs/Nb5quPiocWj0LCtT+vfrqOdzmHv8rD4mL3MbPpOnDO
	Oyu+8SBYi1qQF0mvcZnarovtBImaJcEOm/z3wV41evRL62DbTvy5qOC6wiAwW3uLnQNxIk13AVVFO
	8xqGPYMEiq+eSmnZ90fvoIrrpfRt8l/+DAdBcOyuaSbwJKib8b4/OoBm+NvW7Q21vYwUsUsH2+LL1
	m1NB5E3GFFrFsOWAzQeSwYXRn+H11Xct/Kb1oSvtBw8qr7IosGHlp6eNoVQbqqHjiHaJdB46qa5U2
	WYZxV48w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6w-0000000BngY-2Kbg;
	Tue, 16 Apr 2024 10:32:22 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6o-0000000BnZ6-0NH4
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263533; x=1744799533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
  b=ZSD7MQuZRhmWsqTQhOm0D4Yl0s7WTRlAMw6pM6u92TAzBXYSHZ26GG7W
   B7XmdNmqbMk6p5k4idAURyeI/+0mygquiuf4FMpB+e1TggkblqiplyLHR
   iOjQjPbvPXDGMiUfrdqbF7vqvrKI9afl0rI29cbB7c8G5sOlydzK2ZI7M
   /5OB/dX0xme7xmca9M1JvWgCMtXr9QEA5m6MaDVZo0eCGm/H+O5w4qIyV
   jPQ7AABPK+13MjqDWBRN6I/XbHbYfUPWOuWOyKiDPQC5qqRfLNag54zEy
   60tz3MXixqJMbFpI2iryJJYbpyeWqbNnEWqFr3JLdubsOXRFCrRAuF7uB
   g==;
X-CSE-ConnectionGUID: C02AOCyaS0mIkUdZYN61uA==
X-CSE-MsgGUID: i4LMdLSbRT2Tf2FMmnEygQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796899"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:12 +0800
IronPort-SDR: XlcdsLZiPeXGbV8qOQJu4Zi2BiplDhqtfMKxkT83gRJI0OVNYiypz8JV4tbIp2VHu6419J8rfT
 whqvS6VfN0/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:51 -0700
IronPort-SDR: L5ID6y2Q1evLzQ/zMTOCtLSa3e1X2AwMG+baz6+K+5WsER991wuHNF63C47ggf+WQN2VZj6J8t
 jDyGKHiqD4ocCL8CyQiDxO0CUrJt1sbJdossf4m5BU43T47WvKdlxwsSIj2HoxjRTokz8kjZIK
 +E4uAvyUJv+nqu+4i0IA997HHtFFRLgUg3OiUtV1XNq8NreVS6L7IOHJi+kMlZvsfX0GtGplvs
 JguOLi2+bcrvrsx0hgQ4qFvKCOl/4YBcZROhlDIWxGuqSULjCw5Xlh82IkRvWv4l7oyvvCHC6I
 EOc=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 04/11] meta/{016,017}: add test cases to check repeated test case runs
Date: Tue, 16 Apr 2024 19:32:00 +0900
Message-ID: <20240416103207.2754778-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033214_236081_DE3D9730 
X-CRM114-Status: GOOD (  13.46  )
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

Add test cases to confirm the feature to repeat test case runs with
different conditions is working.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/016     | 29 +++++++++++++++++++++++++++++
 tests/meta/016.out |  2 ++
 tests/meta/017     | 29 +++++++++++++++++++++++++++++
 tests/meta/017.out |  2 ++
 4 files changed, 62 insertions(+)
 create mode 100755 tests/meta/016
 create mode 100644 tests/meta/016.out
 create mode 100755 tests/meta/017
 create mode 100644 tests/meta/017.out

diff --git a/tests/meta/016 b/tests/meta/016
new file mode 100755
index 0000000..caf876d
--- /dev/null
+++ b/tests/meta/016
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/016.out b/tests/meta/016.out
new file mode 100644
index 0000000..cccfec4
--- /dev/null
+++ b/tests/meta/016.out
@@ -0,0 +1,2 @@
+Running meta/016
+Test complete
diff --git a/tests/meta/017 b/tests/meta/017
new file mode 100755
index 0000000..03f92d6
--- /dev/null
+++ b/tests/meta/017
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test_device() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test_device()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/017.out b/tests/meta/017.out
new file mode 100644
index 0000000..7fc55ff
--- /dev/null
+++ b/tests/meta/017.out
@@ -0,0 +1,2 @@
+Running meta/017
+Test complete
-- 
2.44.0


