Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3948FC072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QeTpp/d5uA4tveS34BaH4CrNLmK1RtW5DiY0v8RxqU4=; b=h34CO0nKZZBlwAdGnMitfa8G29
	scy56dBSDzNSDrwXmBeX8jJ4fVbcsa8qgsgsqWy/7IhE13l8//Rlh099uJ5XsfAxxiD4gIVMMLskE
	WMTNTHQEs8smG9THDevUvRLdbYFR/BTIRZ1jjDIx5XZKZY9RC5jzj9tDF0mca9Y6RQIs/KLEIxn6M
	C/i4UpXVNMLdZdyfgWL37lHuE75bcQjP9uSbCW6esFlGXkMqi/+/lvJOBWt3Jn9uHYlHaRZIThm4l
	eFBDe26pTbr43hnLhWD1iOlCTlA4ip6GdH3vgr+MtilGK+gD7mJKBDlJeGDgoROPhV06hS4mK1uPZ
	5h5yzwPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbl-006VNa-0s;
	Fri, 17 Nov 2023 12:06:01 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbh-006VLh-1u
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 12:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700222757; x=1731758757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoDdgE4bhMmuho+xy7QlTB3wwCTEc4zFfqdlizVAqtg=;
  b=LK7jMBfRrqdZLsrnIi3bu3YJu8PNmZvfuPvvI9purIcWN/9Ro/cyT745
   pCPA5ZhPU/Ysny9PiTyZVHBb7rxXTsHZigW2wk+gNi+/1s4KfglkJ7dQt
   ReqCN7a2d6OxUrZEj9ityiOKfEwp4LxY9PqJS6bYtHM8bRwpi6RG4DQmw
   v05vEnMgyWyLQ4ueBUUsRp2e4w45VdnlgRk93roSzfuS1HZpuJwzISncT
   fMm95YUH454GaziCX19+Sa8G6USUvgzP6gA2OXEIqORyroldufs34DF/D
   7x+amwAy8oip/4tv1SPuPU2tuRqOxwdZH6D386iuMv2H9IS7KqG2YSkVr
   w==;
X-CSE-ConnectionGUID: Y3bAbjVGQsyfiFMnhQHE4w==
X-CSE-MsgGUID: QGYOhqe9TcyrfY5WTJ5Bdg==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2616486"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 20:05:52 +0800
IronPort-SDR: +e358bbJFMc1kC9j8XmWfcjksfTbNvN2yBUhoNWu2uT9Ao81nYRsz30eO4SxE5An/MOUgWYwYr
 L4qcPtup7rp9Li9I/Mb62RrGWD1psR35tcBT3sAmAamJa+6z2LNVvQ7VRir0lfD6U90JBDdKC2
 c0O9acP57UEU6polRsaLBYmqyoEV4n0JqKqEuLdnuvCEY9b3GSAeSydRmBvUBsZrzyqbX/mpyF
 BBWuzkjwDbRMDpZPMICArxkbTPF4ZVFvD0t0k4TD9n9YIWebxQJE6JNH5gT+/dwGTEqxt8o7kt
 8Lo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 03:17:17 -0800
IronPort-SDR: nYGy4+6WL4QNZPq3VVdR8swCdRY+/UogRvf0sP05xx8cPeP0CZL/De4IxfPdWOusbwprlwnA87
 ZOOzMkiDsEaNkqqutOdlVhn017XDDaanMiW0lF/yOYgRbif5rSNVhZcJSVLXfywzszQJas813i
 7V1kWJGpz42jEvHBT45ISR1ZAgq872CaxQXL5nmCdRrU8pjW4qNvg0Zn8OU0/n/3x/PI75RR1t
 G4Pm69X6zPqtGO4e7sOoESE4VCxm5srSpp5YmMuqp4G7MHGN5/93PuLb/3vINVm0T4PGG+YWmk
 hS4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2023 04:05:52 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] nvme: do not print UUID to log files
Date: Fri, 17 Nov 2023 21:05:49 +0900
Message-ID: <20231117120550.2993743-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
References: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_040557_656491_380E3048 
X-CRM114-Status: GOOD (  13.04  )
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

The UUID/wwid of a namespace might be assigned externally, so
we shouldn't register it in the 'out' files.
The current checks for UUID/wwid are just there to ensure that
if a UUID is present is should match the wwid setting.
So rather add a function _check_uuid() which does exactly that
and don't register the actual UUID in the 'out' files.

[Shin'ichiro: added check against def_subsys_uuid in _check_uuid()]
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  2 --
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  2 --
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  2 --
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  2 --
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  2 --
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  2 --
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  2 --
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  2 --
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  2 --
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  2 --
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  2 --
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  2 --
 tests/nvme/021     |  3 +--
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  3 +--
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  3 +--
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  3 +--
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  3 +--
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  3 +--
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  3 +--
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  3 +--
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  3 +--
 tests/nvme/029.out |  2 --
 tests/nvme/rc      | 24 ++++++++++++++++++++++++
 43 files changed, 45 insertions(+), 84 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 31af873..cc5310e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -29,8 +29,7 @@ test() {
 
 	local nvmedev
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys ${def_subsysnqn}
 
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 51f6052..2559905 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,5 +1,3 @@
 Running nvme/004
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/008 b/tests/nvme/008
index f4b45b2..6ff3362 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/008.out b/tests/nvme/008.out
index b05b46d..62342e7 100644
--- a/tests/nvme/008.out
+++ b/tests/nvme/008.out
@@ -1,5 +1,3 @@
 Running nvme/008
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/009 b/tests/nvme/009
index 905de03..4ea0063 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -26,8 +26,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
index 7fd27ff..853663f 100644
--- a/tests/nvme/009.out
+++ b/tests/nvme/009.out
@@ -1,5 +1,3 @@
 Running nvme/009
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/010 b/tests/nvme/010
index e782a9b..5ed6cb5 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
index 788ea96..90468f5 100644
--- a/tests/nvme/010.out
+++ b/tests/nvme/010.out
@@ -1,5 +1,3 @@
 Running nvme/010
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/011 b/tests/nvme/011
index 56658f4..f9150e0 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
index ab29fa2..a780def 100644
--- a/tests/nvme/011.out
+++ b/tests/nvme/011.out
@@ -1,5 +1,3 @@
 Running nvme/011
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/012 b/tests/nvme/012
index 6072eed..c5e0eb9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -31,8 +31,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
diff --git a/tests/nvme/012.out b/tests/nvme/012.out
index 581e686..ec4bea8 100644
--- a/tests/nvme/012.out
+++ b/tests/nvme/012.out
@@ -1,5 +1,3 @@
 Running nvme/012
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/013 b/tests/nvme/013
index 60441ca..3ec280f 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
index f7285a9..10b78ec 100644
--- a/tests/nvme/013.out
+++ b/tests/nvme/013.out
@@ -1,5 +1,3 @@
 Running nvme/013
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/014 b/tests/nvme/014
index d49e8f3..31bfeb7 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
index 0285826..c431864 100644
--- a/tests/nvme/014.out
+++ b/tests/nvme/014.out
@@ -1,6 +1,4 @@
 Running nvme/014
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe Flush: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/015 b/tests/nvme/015
index 0813bcf..4315ffa 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
index 23763f1..829cf40 100644
--- a/tests/nvme/015.out
+++ b/tests/nvme/015.out
@@ -1,6 +1,4 @@
 Running nvme/015
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe Flush: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/018 b/tests/nvme/018
index 00531cf..e901730 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -28,8 +28,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	local sectors
 	local bs
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
index 68a0194..6b0e814 100644
--- a/tests/nvme/018.out
+++ b/tests/nvme/018.out
@@ -1,5 +1,3 @@
 Running nvme/018
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/019 b/tests/nvme/019
index 15e98c4..a1035ff 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -29,8 +29,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
diff --git a/tests/nvme/019.out b/tests/nvme/019.out
index 3e649a4..a52325f 100644
--- a/tests/nvme/019.out
+++ b/tests/nvme/019.out
@@ -1,6 +1,4 @@
 Running nvme/019
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe DSM: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/020 b/tests/nvme/020
index 59c1179..ba3f4c8 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -28,8 +28,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
index 113c177..9e293ab 100644
--- a/tests/nvme/020.out
+++ b/tests/nvme/020.out
@@ -1,6 +1,4 @@
 Running nvme/020
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe DSM: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/021 b/tests/nvme/021
index 2277fe5..7dc6a41 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme list 2>> "$FULL" | grep -q "${nvmedev}n1"; then
 		echo "ERROR: device not listed"
diff --git a/tests/nvme/021.out b/tests/nvme/021.out
index b6b1a7c..c86ee74 100644
--- a/tests/nvme/021.out
+++ b/tests/nvme/021.out
@@ -1,4 +1,2 @@
 Running nvme/021
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/022 b/tests/nvme/022
index a74eba3..c70fbba 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme reset "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: reset failed"
diff --git a/tests/nvme/022.out b/tests/nvme/022.out
index 1d393db..dace761 100644
--- a/tests/nvme/022.out
+++ b/tests/nvme/022.out
@@ -1,4 +1,2 @@
 Running nvme/022
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/023 b/tests/nvme/023
index c8d1e46..4e4d838 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log bdev-ns failed"
diff --git a/tests/nvme/023.out b/tests/nvme/023.out
index 47c99ca..aa5d290 100644
--- a/tests/nvme/023.out
+++ b/tests/nvme/023.out
@@ -1,4 +1,2 @@
 Running nvme/023
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/024 b/tests/nvme/024
index d21bcce..2535a9a 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
diff --git a/tests/nvme/024.out b/tests/nvme/024.out
index 0b1a350..76c3e29 100644
--- a/tests/nvme/024.out
+++ b/tests/nvme/024.out
@@ -1,4 +1,2 @@
 Running nvme/024
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/025 b/tests/nvme/025
index 5912e5d..46f6197 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme effects-log "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: effects-log failed"
diff --git a/tests/nvme/025.out b/tests/nvme/025.out
index f15ff2f..66d646e 100644
--- a/tests/nvme/025.out
+++ b/tests/nvme/025.out
@@ -1,4 +1,2 @@
 Running nvme/025
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/026 b/tests/nvme/026
index b6bc779..5a7d992 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme ns-descs "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: ns-desc failed"
diff --git a/tests/nvme/026.out b/tests/nvme/026.out
index c934cac..69a05de 100644
--- a/tests/nvme/026.out
+++ b/tests/nvme/026.out
@@ -1,4 +1,2 @@
 Running nvme/026
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/027 b/tests/nvme/027
index 3993fb5..82b77a9 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
diff --git a/tests/nvme/027.out b/tests/nvme/027.out
index 5c6ed26..621a404 100644
--- a/tests/nvme/027.out
+++ b/tests/nvme/027.out
@@ -1,4 +1,2 @@
 Running nvme/027
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/028 b/tests/nvme/028
index e522381..0b49e20 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
diff --git a/tests/nvme/028.out b/tests/nvme/028.out
index 536067f..7cfd2d3 100644
--- a/tests/nvme/028.out
+++ b/tests/nvme/028.out
@@ -1,4 +1,2 @@
 Running nvme/028
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/029 b/tests/nvme/029
index bbc4814..caed0f7 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -60,8 +60,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	local dev="/dev/${nvmedev}n1"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
index 0021003..745f142 100644
--- a/tests/nvme/029.out
+++ b/tests/nvme/029.out
@@ -1,4 +1,2 @@
 Running nvme/029
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522..4452274 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -959,6 +959,30 @@ _check_genctr() {
 	echo "${genctr}"
 }
 
+_check_uuid() {
+	local nvmedev=$1
+	local nr_nsid=0
+
+	for ns in "/sys/block/${nvmedev}n"* ; do
+		[ -e "${ns}/wwid" ] || continue
+		nr_nsid=$((nr_nsid + 1))
+		[ -e "${ns}/uuid" ] || continue
+		uuid=$(cat "${ns}/uuid")
+		wwid=$(cat "${ns}/wwid")
+		if [ "${uuid}" != "${wwid#uuid.}" ]; then
+			echo "UUID ${uuid} mismatch (wwid ${wwid})"
+			return 1
+		elif [ "${uuid}" != "${def_subsys_uuid}" ]; then
+			echo "UUID ${uuid} mismatch with ${def_subsys_uuid})"
+			return 1
+		fi
+	done
+	if [ $nr_nsid -eq 0 ] ; then
+		echo "No namespaces found"
+		return 1
+	fi
+}
+
 declare -A NS_DEV_FAULT_INJECT_SAVE
 declare -A CTRL_DEV_FAULT_INJECT_SAVE
 
-- 
2.41.0


