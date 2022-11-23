Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C944C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Nov 2022 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hQzLNxeVwxXXcietcYnNiJmhzt78/d1Q4sA4HI+a4es=; b=IUnRb/nBJ32Nzwv8I3+hQDm6LT
	WyXJIkShfEz+kU0sS7sP/qX44d/gQ0OMaqcsHxyXfeRlNMRb+FQkYVL8Xm0KDEN0rD5NeRnmcO4NB
	lTitk/9P8t/yuW/Mom/M+cOwWYzLY1x8GPj+gBJmaoedyvol8rhgAu3WGrsnvQA8Ux9BgseI5aXvJ
	XNFf+4shAAWb0cxotQ9wGvUJJ10DAQOTK2vQYpPPLczpoN3XHbfbYT5BAJO0teTwBWXI0je/X1jz6
	YJ6eF4UrhPULnF5JaNv1qKnRcUZ1lID+q+lhlDkeYiVdPhcYK0Hi2KGGsptkr8vglaQ5tIPbCTrGs
	vvfX5s6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxgag-00DZjj-Da; Wed, 23 Nov 2022 03:38:26 +0000
Received: from resqmta-h1p-028596.sys.comcast.net ([2001:558:fd02:2446::4])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxgad-00DZh6-Gr
	for linux-nvme@lists.infradead.org; Wed, 23 Nov 2022 03:38:25 +0000
Received: from resomta-h1p-027914.sys.comcast.net ([96.102.179.199])
	by resqmta-h1p-028596.sys.comcast.net with ESMTP
	id xgRno0BzGF3KUxgaTo1rOr; Wed, 23 Nov 2022 03:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1669174693;
	bh=hQzLNxeVwxXXcietcYnNiJmhzt78/d1Q4sA4HI+a4es=;
	h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
	 Xfinity-Spam-Result;
	b=Ksv6NXko7Q5Nn34P23ih/SCNvJIl3mSUr70JUW26x00PZBvi0I4Saqr0Cf5fCD3SO
	 KZd2Q7IsHKyPULebeFYVl0xHThQ+12jee2ckWTU7194tMHIXjZXL3zoItfmlHM/kcb
	 Pu8mS2jtc4rNF4qvzxBjRuXVKmHSa9S7F47ed+RBPZ12TNTamA/DJUsf6ZxlZ6JkQz
	 5+W8VEpM4oCQ9RCTQuIznWLy9/AiZNmNhXgPpYXxdOiOHkDg3cFi64m9a/a1czdG9p
	 5L4PQtK9I0NCZCQQlZfUdPUr1yd+xEvqNKI6OPKpFXDAG3c8xq9yVhO5YY5EKUOG9y
	 kNX6WZzCSVdQQ==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
	by resomta-h1p-027914.sys.comcast.net with ESMTPA
	id xgZxoyAM5eZC2xga2o0O5J; Wed, 23 Nov 2022 03:37:51 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnrghthhgrnhcuffgvrhhrihgtkhcuoehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvheqnecuggftrfgrthhtvghrnhepueegudevvdfffeefvdekjefgueetgffhgfdtueeufeevtdelfedutefftdekueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhihhnihgthhhirhhordhkrgifrghsrghkihesfigutgdrtghomhdprhgtphhtthhopegthhgrihhtrghnhigrkhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From: Jonathan Derrick <jonathan.derrick@linux.dev>
To: <linux-nvme@lists.infradead.org>
Cc: <linux-block@vger.kernel.org>,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Klaus Jensen <its@irrelevant.dk>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v3] tests/nvme: Add admin-passthru+reset race test
Date: Tue, 22 Nov 2022 20:37:39 -0700
Message-Id: <20221123033739.1122-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_193823_624314_DF3A3715 
X-CRM114-Status: GOOD (  17.66  )
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

Adds a test which runs many formats and controller resets in parallel.
The intent is to expose timing holes in the controller state machine
which will lead to hung task timeouts and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
v3:
I noticed I couldn't rely on checking state within the loop because it was
constantly on 'resetting', so I moved the last_live declaration to update when
a reset completes.

I updated the kernel in my QEMU instance to origin/nvme-6.2 (it was on a
previous origin/nvme-6.2), and applied Klaus' format fix to QEMU. This doesn't
crash my QEMU anymore, but now gets stuck in 'connecting'.

 tests/nvme/047     | 137 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 2 files changed, 139 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..76b7fdf
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,137 @@
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
+RESET_MISSING=true
+RESET_DEAD=true
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
+	local pdev
+	local blkdev
+	local ctrldev
+	local sysfs
+	local max_timeout
+	local timeout
+	local timeleft
+	local start
+	local i
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	blkdev="${TEST_DEV_SYSFS##*/}"
+	ctrldev="$(echo "$blkdev" | grep -Eo 'nvme[0-9]+')"
+	sysfs="/sys/block/$blkdev/device"
+	max_timeout=$(cat /proc/sys/kernel/hung_task_timeout_secs)
+	timeout=$((max_timeout * 3 / 4))
+
+	get_state() {
+		state=$(cat "$sysfs/state" 2> /dev/null)
+		if [[ -n "$state" ]]; then
+			echo "$state"
+		else
+			echo "unknown"
+		fi
+	}
+
+	tmp=$(mktemp /tmp/blk_tmp_XXXXXX)
+	lock=$(mktemp /tmp/blk_lock_XXXXXX)
+	exec 47>"$lock"
+	update_live() {
+		flock -s 047
+		date "+%s" > "$tmp"
+		flock -u 47
+	}
+
+	last_live() {
+		flock -s 47
+		cat "$tmp"
+		flock -u 47
+	}
+
+	now() {
+		date "+%s"
+	}
+
+	sleep 5
+
+	update_live
+	start=$(now)
+	while [[ $(($(now) - start)) -le $RUN_TIME ]]; do
+		# Failure case appears to stack up formats while controller is resetting/connecting
+		if [[ $(pgrep -cf "nvme format") -lt 100 ]]; then
+			for ((i=0; i<100; i++)); do
+				nvme format -f "$TEST_DEV" &
+				( echo 1 > "$sysfs/reset_controller" && update_live; ) &
+			done &> /dev/null
+		fi
+
+		# Might have failed probe, so reset and continue test
+		if [[ $(($(now) - $(last_live))) -gt 10 ]]; then
+			if [[ (! -c "/dev/$ctrldev" && "$RESET_MISSING" == true) ||
+			      ("$(get_state)" == "dead" && "$RESET_DEAD" == true) ]]; then
+				{
+					echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+					echo 1 > /sys/bus/pci/rescan
+				} &
+
+				timeleft=$((max_timeout - timeout))
+				sleep $((timeleft < 30 ? timeleft : 30))
+				if [[ ! -c "/dev/$ctrldev" ]]; then
+					echo "/dev/$ctrldev missing"
+					echo "failed to reset $ctrldev's pcie device $pdev"
+					break
+				fi
+				sleep 5
+				continue
+			fi
+		fi
+
+		if [[ $(($(now) - $(last_live))) -gt $timeout ]]; then
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				break
+			fi
+
+			# Assume the controller is hung and unrecoverable
+			echo "nvme controller hung ($(get_state))"
+			break
+		fi
+	done
+
+	if [[ ! -c "/dev/$ctrldev" || "$(get_state)" != "live" ]]; then
+		echo "nvme still not live after $(($(now) - $(last_live))) seconds!"
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


