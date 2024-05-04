Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5864AC10F1A
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKOPjG6KMj1YH0pEwHx037DLB7y1P/Cx39jcsk+lMLc=; b=LoiyB17daRx3YTKzR2HUx6Q9p/
	uy5tAn76MbnC+vwMG8sGRRcVkEUAFhuwznRrDZG6R1dJPBRnWibavgwhFQAlacKLbyylzMYOHotdu
	HHPySYlYVj+EXCZb5wf2Eigz3Lst5vXjTco4QA7hd6lR4AKiVpVVRbdj/IQ+oY7WPSTWc9CcSfZX8
	L2mrV59bkkCemKLxl7IDSDUEjRH3OiHjtlEERy4Hx9QQ1ZuyppHV5/Yo+3K3ZwjRUwcOm4Y/reyCg
	zVKaQc8Fe2gGUBxLe5Lx4u9m+3DEaFz0791gwjF4rijW7BtsQT0lX9iJEDy5l8vRuWntRVvKJZtA2
	+Ir5xEUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXw-00000001Ytt-3xNI;
	Sat, 04 May 2024 08:15:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXp-00000001Yo8-3EOj
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810497; x=1746346497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
  b=DrFp8TR372nIfG3JT39WeRA/QlX6Q1GsxFmIibRQbg6U7HHjDeJYMpct
   iIug4h8g28fYvGbjv9Lr7mtcWj+nvoFWPTw93MriBvbn4XDaMjAgexCFO
   qCO5/QiC27biSIr/wNBYvOpXY+W/ARXKkf6T6j7Rou9nMAywf/aIqOaWN
   xBXxArY/dBqsL8Rh1YsZHo7jR74JNbWLlJZzKSDikt2ahrr7axXku5Ylv
   +X8nclWL7u/QtBAo90EXvlXuGIYAyXB5gWSrxDcI9CMWV7R2q8JD9xD1P
   bh6/bQUokYDFUY366p+5LUu9w82Nm8yI7X7cOij/4znK/O0mhAmH0zDY+
   A==;
X-CSE-ConnectionGUID: +s55AYwgRuy0ZH4GfirU1w==
X-CSE-MsgGUID: 0e33ENIgS3iQuf9WjIsvXw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540303"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:55 +0800
IronPort-SDR: pFYA0NxZnAHgPXKXDYGgQVvRHmjfEaQL9bseTF7Wm/2pDgaYmgXk42gKbrfj80s2EAdUPe28b0
 e9J5ErCt/4mnye5PVqZBIWtz7xSUojrb7laPOuqFtynA8O6huYJq6gv/oDycBbMpzQRmpZ41de
 5b2ThCOHjCHVhcghiTECPW37jhZzxeSkTI+lnkamYc7CcxtjlnisKpENu8U2FcBnnIhNCe/ng7
 W1M7MaygWiKpEVWQQOrxLDoiDht8DYDG3lw5JaCnt58KxZDSf0bSvvwY0IN22uNYqmCD3Y4fvx
 XSU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:53 -0700
IronPort-SDR: RMXPPeVNTWfKYFpWcZbwf4Grcr0pwykG/6Buw98+qScc/vTanYcj+uhpgrg0fankKuBP2qa7ao
 DTfYsOnK7FTVCLXWVP9CNJdI7EAWdu0X91Evr94BkNg4yINe2OonRejotts/tMsZkF57WUl1Id
 UTORGJWWHMlk5H0aGWtaPDbtEoTYlWZzzbGvRUDrzFFUg731ElOE1+3yQJV9qhcrwRr9tQSAeU
 CSHScQTRXdq95p3SGH7+L2r0RdXyi7CS27hJIoAAF/QUGEwlGH878pZbOzVmKO/mJASJDvRUGY
 gnE=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 04/17] meta/{016,017}: add test cases to check repeated test case runs
Date: Sat,  4 May 2024 17:14:35 +0900
Message-ID: <20240504081448.1107562-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011457_926392_93B51C69 
X-CRM114-Status: GOOD (  15.15  )
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
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


