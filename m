Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D375BC001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1q8uHk3Oo5GGHXqkt0h0v8JELhpf9Nflj/4QaA5Es9c=; b=YRxIXb3rG4Zb6BMZ9kp3F08HJ0
	WhnEoeBy5NCG+Ih6Nt3pmzgymxyAzvu7Qkl5c+Yuj9SYOaOJkiBJ8EMnituTBMVGJidGglt3vYKv9
	peIee5PJfTiihvAb7bu8rB6Dsf7KCrYFDZ1pYdtFx0IZG1LFhLcCSBnYwasiKSffw/6F8saAlqDVs
	RBHC/jkVAZ9x+eBC5Ff8mLpvDNKtbMqxisWtKAtBPVcl93k5R7SmuDZsheId+/ZAoZoDOzJDPtHNU
	3a0ZjxK6MJv9DH58Qq1M/BjoCUh5BH3cKMN9FltsAOoKARLGbwvwu2MUcSExndxYOOJqd48yXyzic
	m50lDLFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWrIR-007gRS-2u;
	Fri, 18 Aug 2023 04:41:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWrIO-007gQF-1o
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 04:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692333672; x=1723869672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S5ymVNujHDKKAiN5sqGAayD/JOzweF2ZXKdxqx2iBU8=;
  b=mFwLoeBaPbrfG3ZV+fvS0nnlunb5dZ2rJfphmorya13jbH2kWYAbfsjF
   9cidGwmhgpfwOgS3mHWgbOF0Qj5LiwYyqQ8dA8b1t0rz3Tq9bFBH8Vg1G
   Gja/PvzjsE+TNvTS3G4VpTmIC3J/4GqHZwjQRzXhKQ26n6E3tTQL7hZmu
   uOe/5Dz1QIG4JQj259l6HHEEOTyTfEJzzZZp9OThv21Tb/5cwKiRwq21Y
   AsTfJ6u6NVSimxuEl40HBNWVe+g+cV8UUqsYZltaRUnhKhL9BNE3lbb6T
   wsrKnc4zkUhM4rb+9QcFEmFZAfVvBMFRON4W3v7l/ozpE5yBO1tloALXS
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="241793464"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 12:41:00 +0800
IronPort-SDR: 5ijPKUk3cVTWA54RavUwlYxbm2VcyvsWx5BQJQVTBZmx5u6D8Y/3tyfDhADmAcsYaYJ33vFwG7
 Fz82yQoLt2yOnKEvetlYM/8PJJxG1E4Ilpm9L9tYSrMosFnKkOaZg9NFQoWpScqfZASftPNjup
 zHiqPPsHBrhmRejoOIxUXKrxFe/PFmR7XIE8cdKo8IHuC3icOZaDafo2jQBkr7dbx/1uMub5kB
 hvGEpLU5CD+fGu/iFH6bHmnRu5GoMY6TYarbZJYoCArfoB34I0l0Qb9/X3ikXwT3IHr3HTw4H0
 yHA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2023 20:48:36 -0700
IronPort-SDR: cAF+r+dTuJWOWihuAcnPCYclBGzKNFfNPmLrxAq6SSUESV24cFIWNgLCvTv2/wcSn2NvUOL3lb
 iL5oDxWbbteCjaCDtTrEygD4gLaYQxo+OCGap8oEpa+KtaIGE7qF0zIeOg0a/OPWc84yY373MX
 UkvwliQAThJkGXM7mSCyWhO401F3a2GfhyHFLNxze5sdp6yrM6wWxCLlYnZpcchVMdbLpzl/wO
 FnrnpzgHhwRYcfpUfLRTII7DCpXdfAMHc0J69MSBVwZ6Vd3juhdfRq4KJZG6GKfjdmDUyUzmAQ
 5vo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Aug 2023 21:40:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 1/2] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date: Fri, 18 Aug 2023 13:40:56 +0900
Message-Id: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_214112_717332_180E6BCE 
X-CRM114-Status: GOOD (  21.05  )
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
add --no-wait option to _nvme_connect_subsys(). It allows to skip the
wait in _nvmet_passthru_target_connect() which has its own wait for
device readiness.

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix this by checking sysfs paths with the namespace index. Get list of
namespace indices for the sub-system and do the check for all indices.

On top of the checks for sysfs attributes, add 'udevadm settle' and a
check for the created device file. These ensures that the create device
is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Renamed --wait-for option to --no-wait
* Modified to check all namespaces

Changes from v1:
* Added --wait-for option to _nvme_connect_subsys()
* Added 'udevadm settle' before readiness check

 tests/nvme/rc | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b964e9..92eac06 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,6 +428,8 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local no_wait=""
+	local i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -483,6 +485,10 @@ _nvme_connect_subsys() {
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
+			--no-wait)
+				no_wait=true
+				shift 1
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -532,6 +538,33 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	# Wait until device file and uuid/wwid sysfs attributes get ready for
+	# all namespaces.
+	if [[ -z ${no_wait} ]]; then
+		udevadm settle
+		for ((i = 0; i < 10; i++)); do
+			_nvme_ns_ready "${subsysnqn}" && return
+			sleep .1
+		done
+	fi
+}
+
+_nvme_ns_ready() {
+	local subsysnqn="${1}"
+	local ns_path ns_id dev
+	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
+
+	dev=$(_find_nvme_dev "$subsysnqn")
+	for ns_path in "${cfs_path}/namespaces/"*; do
+		ns_id=${ns_path##*/}
+		if [[ ! -b /dev/${dev}n${ns_id} ||
+			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
+			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
+			return 1
+		fi
+	done
+	return 0
 }
 
 _nvme_discover() {
@@ -758,13 +791,6 @@ _find_nvme_dev() {
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
@@ -794,7 +820,7 @@ _nvmet_passthru_target_connect() {
 	local trtype=$1
 	local subsys_name=$2
 
-	_nvme_connect_subsys "${trtype}" "${subsys_name}" || return
+	_nvme_connect_subsys "${trtype}" "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.40.1


