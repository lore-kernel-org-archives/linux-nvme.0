Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7193C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tOQ2uBUDLF0h8iyRoUOUMg45l54ag5/2AuUbFTQSgiA=; b=MtqbtXlES6xAtpA6ubA5qV703K
	SOu8Roz/Lb5/DlT+D01NSp3XBnI6BxBUQY2VM3PHBYCr8P/K8YYXgdAixAfq2E7d07hdfh1O9YzLj
	EJ+gQtJulhF83MoAvC1jJ2hU57OxnzOiuIylwDjCcy7b4B3TS2GAB8DNj1fjjPEX7u9VFLAwBjJlY
	YoZ4ygO3HmNB3nOdKEYBNF681e0YiQKT+UJMLZtHYWHD+jWwwS6qw9x6HRTkPB9lE2K7iGkSGIiHu
	YiVYXVWB+KAUVoclySeVygCAE+nrRLEvq2lj8Lxqt63xgtc6HwnaxGBz5ciTHPRZU2VYmEU499gi5
	0TFN5Hdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ougAi-004imc-8D; Mon, 14 Nov 2022 20:35:12 +0000
Received: from resqmta-h1p-028592.sys.comcast.net ([2001:558:fd02:2446::5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ougAf-004ilx-Bx
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 20:35:11 +0000
Received: from resomta-h1p-027908.sys.comcast.net ([96.102.179.197])
	by resqmta-h1p-028592.sys.comcast.net with ESMTP
	id uYh7oyGAgUsT0ugAYohQ4x; Mon, 14 Nov 2022 20:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1668458102;
	bh=tOQ2uBUDLF0h8iyRoUOUMg45l54ag5/2AuUbFTQSgiA=;
	h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
	 Xfinity-Spam-Result;
	b=t2Q088bZaOCJV5ExciDUPbmIRebzmdhPsEmDQoPKTuRMO21eMAjroedLJagLviD/M
	 RSBtdCA23bBJdBmJHi4BO8QHnELSf1SBLvaf4NnvO8SqrZnlbFcnH7NrkzYqqfnp59
	 t7r/ZsUybv8Vd6uJzPr911A0f5f16mF29qRGgUE3LaYmC3jrvai9wAKz/p5IlPHnoy
	 gciv42W0lYbFRIAEM62M6frRQvJWgvAkv7VORokkGnyPfp8WLACxkZgZjYB48KCO3g
	 I9kWxI9jHBpKAlo5ebNlU734hKUrrDhv2usQAeukQXzkqFFHU5wJcRnfiJyTJe+/66
	 l/mrGWPkZGi3w==
Received: from jderrick-mobl4.solidigmtechnology.com ([137.83.219.25])
	by resomta-h1p-027908.sys.comcast.net with ESMTPA
	id ug9moRZwyxQh3ug9ros9eM; Mon, 14 Nov 2022 20:34:38 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpeeugeduvedvffeffedvkeejgfeutefghffgtdeuueefvedtleefudetffdtkeeuveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedufeejrdekfedrvdduledrvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepjhguvghrrhhitghkqdhmohgslhegrdhsohhlihguihhgmhhtvggthhhnohhlohhghidrtghomhdpihhnvghtpedufeejrdekfedrvdduledrvdehpdhmrghilhhfrhhomhepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhinhhitghhihhrohdrkhgrfigrshgrkhhiseifuggtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshgrnhguohhvsehoshgrnhguohhvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From: Jonathan Derrick <jonathan.derrick@linux.dev>
To: <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Omar Sandoval <osandov@osandov.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] tests/nvme: Add admin-passthru+reset race test
Date: Mon, 14 Nov 2022 13:34:12 -0700
Message-Id: <20221114203412.383-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_123509_457119_A1E5ED1D 
X-CRM114-Status: GOOD (  13.30  )
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

Adds a test which runs many formats and reset_controllers in parallel.
The intent is to expose timing holes in the controller state machine
which will lead to hung task timing and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 tests/nvme/046     | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 0000000..4b47783
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Jonathan Derrick <jonathan.derrick@linux.dev>
+#
+# Test nvme reset controller during admin passthru
+#
+# Regression for issue reported by
+# https://bugzilla.kernel.org/show_bug.cgi?id=216354
+
+. tests/nvme/rc
+
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
+DESCRIPTION="test nvme reset controller during admin passthru"
+QUICK=1
+CAN_BE_ZONED=1
+
+requires() {
+	_nvme_requires
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local sysfs
+	local attr
+	local m
+
+	sysfs="$TEST_DEV_SYSFS/device"
+	timeout=$(($(cat /proc/sys/kernel/hung_task_timeout_secs) / 2))
+
+	sleep 5
+
+	if [[ ! -d "$sysfs" ]]; then
+		echo "$sysfs doesn't exist"
+	fi
+
+	# do reset controller/format loops
+	# don't check status now because a timing race is desired
+	i=0
+	start=0
+	timing_out=false
+	while [[ $i -le 1000 ]]; do
+		start=$SECONDS
+		if [[ -f "$sysfs/reset_controller" ]]; then
+			echo 1 > "$sysfs/reset_controller" 2>/dev/null &
+			i=$((i+1))
+		fi
+		nvme format -l 0 -f $TEST_DEV 2>/dev/null &
+
+		#Assume the controller is hung and unrecoverable
+		if [[ $(($SECONDS - $start)) -gt $timeout ]]; then
+			echo "nvme controller timing out"
+			timing_out=true
+			break
+		fi
+	done
+
+	{ kill $!; wait; } &> /dev/null
+
+	# at this point it may have waited hung_task_timeout / 2 already, so
+	# only wait 25% longer for a total of about 75% of allowed timeout
+	m=0
+	while [[ $m -le $((timeout / 2)) ]]; do
+		if [[ $timing_out == true ]]; then
+			break
+		fi
+		if grep -q live "$sysfs/state"; then
+			break
+		fi
+		sleep 1
+		m=$((m+1))
+	done
+	if ! grep -q live "$sysfs/state"; then
+		echo "nvme still not live after $(($SECONDS - $start)) seconds!"
+	fi
+	udevadm settle
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 0000000..2b5fa6a
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,2 @@
+Running nvme/046
+Test complete
-- 
2.31.1


