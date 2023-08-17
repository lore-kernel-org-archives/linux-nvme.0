Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC06DC27C7A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4t4bFhGUB6fJAIS8Slv/VZbslz8wju1yeC0TRcppncE=; b=gNXERBOsMr0cOFP2MzQ5UMpxCJ
	RgYziwPeaPvQd4pkwhutVLw9c8BpvUdCiLsPM6woznkCE5zlyy/kaDOCVvDWL5jNf7NoKuV2Rtkzo
	27DJuRExdE5GKx70E3jpY13aZcp1nwVxXat3+RDzvJ7qnNtNkNDfQXU56FN4sUUAMP01ijWMKxlnz
	s9aa8Scfv0lTlHlirX3jLal0Za1X34V/91HBlRASO4Ob3GemJb+jsw1ZopErtstlw+nGCVfMZMDzR
	OxFe7ZGwOnDuw6SC9J/2tklq7iiAZs1tS+oANqTLwwKURgvxFP7zpvVIUdBzZjS8rLrdEp+PNL6LL
	dxZGPJCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXSu-005ipM-0H;
	Thu, 17 Aug 2023 07:30:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXSr-005ioo-0r
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 07:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692257441; x=1723793441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWnODAqt0Mw2BZKaBie2yj1ClUJdr2nuftoERPO8Oi4=;
  b=afx2Va098tFx4/eva2E1tf/x4aEiVQ5khGfJ6P6IOmFhq4F5uQcyISG2
   MZi2t6PSA2ofZzjn+lIy3TXd72YgeirrEas04oAPpB+if53VQlFTqgbaU
   a4bJDjmZxwIk8rbK7Xbq9fjjvxbf0oafH2JehnbYt60rsyullqPLIaspW
   oSsekxE9iXjLr6n1IJCn8kRb3afJevMugstnZiaGv4QbC4ffnfyURuxjo
   TX8gTcEKppZbborQm8lQs4w9VIRztZa5vEY/hhQV5tntA0cA281ZspnGM
   IcxZeddhXM7KvDjGYS/iPAY3vcGAzV6uZZ15V7tWOJIAE6WK28oKND6zJ
   A==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="241697900"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 15:30:26 +0800
IronPort-SDR: uWSFXAn+/01ykUGdPt/JpZpgxGhu4Fzrq/zrZhNBpF8v24PY0Mw6hvBk7PiWTzlQRyEcQRK7XF
 Q8MqgQrBxfQiDrJG+TKpgoZ1mMEANLFR3msmAlTYH8ArouJW76w4aM3irWaNVgV+CYmrW1cQNv
 ecgENMwecAQ77Gbu0gm0vDZv3OX2XG16GZ8LScF/7YHEwAmDGMBcJf2bd0uoFYiYNgXO8fFocX
 UvDlM19yLVd6A+kqEKEK1a4QZ9sagBQw5SIj5d6uj4Xg31hBqspdYOYfeQIJlPDRgPmqQZKDI/
 VMo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2023 23:43:43 -0700
IronPort-SDR: LAr0+QMRHuwnWLVYg6EaJ+VLplf4pxXvEatSUgI4U3v9CFhhYDtJ3Nn//+eb8hsbFgBimh1EzD
 7DxhSAi9se9Q6P9OB3zB/Coc2TdNflkJAAz2moDjTScg1dId40qB92ekl/7OQkdtbXDswp6FXU
 WiEZR5FzrEfR/aL1IctiboqG+ApjcU4eDKaj3AvDlRQun2Os/4vxM8TthoiyMNNhCCL/f3nSgT
 JkACwd9+Edof+HCK1FEIyXSkgGIT2zbu4VrOdVjtqoxis6TSUPnNrLFaaJM3TJHRxOUMDDUalx
 61E=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2023 00:30:22 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date: Thu, 17 Aug 2023 16:30:20 +0900
Message-Id: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_003041_372876_DC1D4CE4 
X-CRM114-Status: GOOD (  19.91  )
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

The helper function _nvme_connect_subsys() creates a nvme device. It may
take some time after the function call until the device gets ready for
I/O. So it is expected that the test cases call _find_nvme_dev() after
_nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
the created device, and it also waits for uuid and wwid sysfs attributes
of the created device get ready. This wait works as the wait for the
device I/O readiness.

However, this wait by _find_nvme_dev() has two problems. The first
problem is missing call of _find_nvme_dev(). The test case nvme/047
calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
for the first _nvme_connect_subsys() call. This causes too early I/O to
the device with tcp transport [1]. Fix this by moving the wait for the
device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
add --wait-for option to _nvme_connect_subsys(). It allows to skip the
wait in _nvmet_passthru_target_connect() which has its own wait for
device readiness.

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix the paths by adding the namespace index.

On top of the checks for sysfs attributes, add 'udevadm settle' and a
check for the created device file. These ensures that the create device
is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Added --wait-for option to _nvme_connect_subsys()
* Added 'udevadm settle' before readiness check

 tests/nvme/rc | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b964e9..797483e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,6 +428,8 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local wait_for="ns"
+	local dev i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -483,6 +485,10 @@ _nvme_connect_subsys() {
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
+			--wait-for)
+				wait_for="$2"
+				shift 2
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -532,6 +538,21 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	# Wait until device file and uuid/wwid sysfs attributes get ready for
+	# namespace 1.
+	if [[ ${wait_for} == ns ]]; then
+		udevadm settle
+		dev=$(_find_nvme_dev "$subsysnqn")
+		for ((i = 0; i < 10; i++)); do
+			if [[ -b /dev/${dev}n1 &&
+				      -e /sys/block/${dev}n1/uuid &&
+				      -e /sys/block/${dev}n1/wwid ]]; then
+				return
+			fi
+			sleep .1
+		done
+	fi
 }
 
 _nvme_discover() {
@@ -758,13 +779,6 @@ _find_nvme_dev() {
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
-			for ((i = 0; i < 10; i++)); do
-				if [[ -e /sys/block/$dev/uuid &&
-					-e /sys/block/$dev/wwid ]]; then
-					return
-				fi
-				sleep .1
-			done
 		fi
 	done
 }
@@ -794,7 +808,8 @@ _nvmet_passthru_target_connect() {
 	local trtype=$1
 	local subsys_name=$2
 
-	_nvme_connect_subsys "${trtype}" "${subsys_name}" || return
+	_nvme_connect_subsys "${trtype}" "${subsys_name}" --wait-for=none ||
+		return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.40.1


