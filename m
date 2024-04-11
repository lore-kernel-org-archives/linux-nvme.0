Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8C5CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZFXHaGXn6yrag7c66Jd39t4cbkP9NsjNSH+d33RCI4=; b=WCI3UduYyJVfRCd/Ez/wRswjkB
	XBU9xHBc0fbbaMDee931ZPgMQf2+TITVdUtxN72vjTwjlCKqNWPLMD+fwxqF6iSFGw/xGN9Py5HeC
	5YshFxHIKvasx+WXkIIY5XndhK/MD8+10Gfunvr+YECWlpohMq230GwWni8oQ11Cw+In/viVe0J8U
	maRmtbzinyKHgmwiG5k0+hFumrU6BuFz9zvsQaLV7O4lcaSM+wSnBzMKcQSj0rGOxm9eArPD7AZBu
	2zU6xVmSnGyH5Q/JHNX3GgrybrCXZ3b+OXaH1SuG5SeIqQsPBaex8MDbLSsA4ObwDBWF28DYp3xhh
	bilF8A1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMF-0000000BfaS-2wfy;
	Thu, 11 Apr 2024 11:12:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusM9-0000000BfV0-3AxQ
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833957; x=1744369957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
  b=nMYaiCfB1v2Jdrd4BuT3gbT+7ghdk6Ifx+pnV3ox260woMVktZ0Nim+T
   qg3/9874sDJF+4tA1uRvxDIsL0yrSEm8A+2/ssxzVydEHaWud6jjKhnPO
   C2c2ia0rGcz1qBupa5DwmKxIJ/YHOu3hFudz1HC/Ey4vtWHqavsA/1vrd
   uoPC7ndC5OA1QcVQWSpbKXc8R4XLG3d0lav2EIX7KTINU3TiL1R5rq1/Z
   kgRi9KsdeiSoYBcqqWxclFRYIgsrE+GB95fHOZLOATb+AWom2sOd3ptc4
   AFUfSN3IpUnWhZqA/cUE5wCNVGYbzmh/Z97O7tKOefsvWVyciIh85COta
   g==;
X-CSE-ConnectionGUID: Nli7bmdeT2itUIyF7bl6zA==
X-CSE-MsgGUID: IRUL8+/FSbKhIEr1qZz3GA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13226488"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:35 +0800
IronPort-SDR: jK3IGzqzrA5E1mMgPIG/EXK8aDdb1MG1e3bymeEVmzDciXPeuvDrOcZDwsFf7j01o7vg+spHrA
 KPjUD1YSBcSg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:20 -0700
IronPort-SDR: 1zk0oZJf3QWQAPE0yL/TvZMIPs5Y9ahKHOaEJP6SM6VRM7P5RJTo8NRwuMTGAahkL5jUDcRXhX
 SE94E2prLikg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 04/11] meta/{016,017}: add test cases to check repeated test case runs
Date: Thu, 11 Apr 2024 20:12:21 +0900
Message-ID: <20240411111228.2290407-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041237_864712_85920AFA 
X-CRM114-Status: GOOD (  13.49  )
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


