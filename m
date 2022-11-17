Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D4C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZFnTdm2gyyk3AIYG+7WjvGTFAbvC92e2yMedMg6h24U=; b=PRZgA7jM9S5G6H1uMPaAGGFQ1e
	iEbPXekaJWapA/7bgs5YmuCcJ3Db3LAHEooBtGP89r0XVUJ9PHCiRxcHdK7mFjKGPJ0eTHtfUD/AG
	tFxzH/eIBeOT6+ElxxztU5uTswd8QLiyMbuGuKg0lIbcKESX1XX8sRxjr068KyXweOvgr9ONSzw72
	aGazeqYxVHvl/2Bfr1S8XABFnxZGTPOaRremUqU0g+HL7Oz7yJCb8Qx4yddJ+TUCPpdVSO5VFyvj4
	mqrXqPCAdSSwUTGIQkWGiRnVJHluhbC0ouwk94TBJKzpig9Y53WaEU6DqrDEnHC9+AfQNw8ap93mM
	xqJwg2KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovmLX-0001Eo-FG; Thu, 17 Nov 2022 21:22:55 +0000
Received: from resqmta-c1p-023461.sys.comcast.net ([2001:558:fd00:56::a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovmLT-0001Dm-Ha
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 21:22:53 +0000
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
	by resqmta-c1p-023461.sys.comcast.net with ESMTP
	id vjoSovDCbnfOrvmLKo2Em1; Thu, 17 Nov 2022 21:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1668720162;
	bh=ZFnTdm2gyyk3AIYG+7WjvGTFAbvC92e2yMedMg6h24U=;
	h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
	 Xfinity-Spam-Result;
	b=yND7SStiRjI7dhM1g4J8xxImD9MKnT2HKigiB7SsAHuz6DJUVvDSVsnPNhTnO58Ge
	 SXC8qXOIU28/JQZzQbtS4I7AqsBmfVIO8tbUUTyxLGavLbb9BPY4tP2nKJS5IOvBBt
	 vsTLs+l/KCYZ7XTh2GQvquXeltRjyPPzN0GFt6JzaslRFg3eX2zUH33J9Hu2tonacV
	 15TiRfSNdQSaxsl7CMSJJ23y9EjW3cW8pW7bQ+59YVwVuyXm1YrkY88ECgMRRWy8Va
	 QnZzisdaTWbqOLACR3IayVJysWIi2eHJQB/Y17KAtbdrLPTUmQIvXPScDJr6b1GTPH
	 wEzVVYWNQphtw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
	by resomta-c1p-023269.sys.comcast.net with ESMTPA
	id vmKqoGUS3xf0xvmKvowVoN; Thu, 17 Nov 2022 21:22:21 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpeeugeduvedvffeffedvkeejgfeutefghffgtdeuueefvedtleefudetffdtkeeuveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejuddrvddthedrudekuddrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepjhguvghrrhhitghkqdhmohgslhegrdgrmhhrrdgtohhrphdrihhnthgvlhdrtghomhdpihhnvghtpeejuddrvddthedrudekuddrhedtpdhmrghilhhfrhhomhepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhinhhitghhihhrohdrkhgrfigrshgrkhhiseifuggtrdgtohhmpdhrtghpthhtoheptghhrghithgrnhihrghksehnvhhiughirgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From: Jonathan Derrick <jonathan.derrick@linux.dev>
To: <linux-nvme@lists.infradead.org>
Cc: <linux-block@vger.kernel.org>,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Date: Thu, 17 Nov 2022 14:22:10 -0700
Message-Id: <20221117212210.934-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_132251_739923_2B02F2CB 
X-CRM114-Status: GOOD (  18.50  )
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
which will lead to hung task timeouts and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
reliably segfaults my QEMU instance (something else to look into) and I don't
have any 'real' hardware to test this on at the moment. It looks like several
passthru commands are able to enqueue prior/during/after resetting/connecting.

The issue seems to be very heavily timing related, so the loop in the header is
a lot more forceful in this approach.

As far as the loop goes, I've noticed it will typically repro immediately or
pass the whole test.

 tests/nvme/047     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 2 files changed, 123 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..fb8609c
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,121 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Jonathan Derrick <jonathan.derrick@linux.dev>
+#
+# Test nvme reset controller during admin passthru
+#
+# Regression for issue reported by
+# https://bugzilla.kernel.org/show_bug.cgi?id=216354
+#
+# Simpler form:
+# for i in {1..50}; do
+#	nvme format -f /dev/nvme0n1 &
+#	echo 1 > /sys/block/nvme0n1/device/reset_controller &
+# done
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
+RUN_TIME=300
+RESET_PCIE=true
+
+requires() {
+	_nvme_requires
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+remove_and_rescan() {
+	local pdev=$1
+	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+	echo 1 > /sys/bus/pci/rescan
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local pdev
+	local blkdev
+	local ctrldev
+	local sysfs
+	local max_timeout
+	local timeout
+	local timeleft
+	local start
+	local last_live
+	local i
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	blkdev="${TEST_DEV_SYSFS##*/}"
+	ctrldev="$(echo "$blkdev" | grep -Eo 'nvme[0-9]+')"
+	sysfs="/sys/block/$blkdev/device"
+	max_timeout=$(cat /proc/sys/kernel/hung_task_timeout_secs)
+	timeout=$((max_timeout * 3 / 4))
+
+	sleep 5
+
+	start=$SECONDS
+	while [[ $((SECONDS - start)) -le $RUN_TIME ]]; do
+		if [[ $(cat "$sysfs/state") == "live" ]]; then
+			last_live=$SECONDS
+		fi
+
+		# Failure case appears to stack up formats while controller is resetting/connecting
+		if [[ $(pgrep -cf "nvme format") -lt 100 ]]; then
+			for ((i=0; i<100; i++)); do
+				nvme format -f "$TEST_DEV" &
+				echo 1 > "$sysfs/reset_controller" &
+			done &> /dev/null
+		fi
+
+		# Might have failed probe, so reset and continue test
+		if [[ $((SECONDS - last_live)) -gt 10 && \
+		      ! -c "/dev/$ctrldev" && "$RESET_PCIE" == true ]]; then
+			{
+				echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+				echo 1 > /sys/bus/pci/rescan
+			} &
+
+			timeleft=$((max_timeout - timeout))
+			sleep $((timeleft < 30 ? timeleft : 30))
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				echo "failed to reset $ctrldev's pcie device $pdev"
+				break
+			fi
+			sleep 5
+			continue
+		fi
+
+		if [[ $((SECONDS - last_live)) -gt $timeout ]]; then
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				break
+			fi
+
+			# Assume the controller is hung and unrecoverable
+			if [[ -f "$sysfs/state" ]]; then
+				echo "nvme controller hung ($(cat "$sysfs/state"))"
+				break
+			else
+				echo "nvme controller hung"
+				break
+			fi
+		fi
+	done
+
+	if [[ ! -c "/dev/$ctrldev" || $(cat "$sysfs/state") != "live" ]]; then
+		echo "nvme still not live after $((SECONDS - last_live)) seconds!"
+	fi
+	udevadm settle
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 0000000..915d0a2
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.27.0


