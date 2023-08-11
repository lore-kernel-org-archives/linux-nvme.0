Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C23DC04A94
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=df83PlrpQO+wkpNfoXRvZpbfBGN59BeiFRQrl22F+08=; b=rbaJoHR301Kl3rZuMRjtj1S8Dj
	VNxh8eKyX7Y6HJO/Z2bNKzrpbqwMy6zyZNfzKoTistC7oiu6jE6q/9+gxLnPhLX0vE5f1lTr0Mezt
	QSuQ3BSatnQB+TIEWYAsWfO4b/ei7z0CbVf9BhykUQVK5hfK4Ulf5GA+1KB9Pap+QSGAjhrPkYIHk
	TxKXxt15N1j7VScixJH3aemD+ve/6DnlYJ/S7tZB5PKIDx2RRKp0br1sm68GIHC3XoekEaumprdIW
	DtgCODY5X3XMTPrwR/nTOQ8gwJKyKj+WNCRlmF8rsfmVB4t1q3wMZ8+slQOE371gaRFSG55jY4TmB
	NZjVp3Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGsV-0093Zq-1N;
	Fri, 11 Aug 2023 01:23:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGsS-0093Yo-0D
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 01:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691717024; x=1723253024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lQkrLEJOnEmWSUncnB7H5JsGyGJ220SolBqq4n6SNa4=;
  b=nOwrNvjgNvq6g1GMCwtpFQE/w1Ou4jb6uruR9qEBIf/QgWeCHD+JUzDG
   35wze4fh/bM7fdznE/rdTKgbkGdmVbpH89wcTszywebALobpOczRDsYj/
   I+dy7nCpBrc2x9YLu5Pxy3MtsVhKUW8FXbILCqEybu2pzSV7CLWw15NwS
   TXRMAkbsf0cTNL+CYn5Ibe5lUE9LD5qLk4VWz2ypeByonMGwg+dTSH7Fc
   bUKoj/5OSTXyfrJYebT9L4GN7aeNX55exUIuh2LgVBqMuWSrvv93At0SK
   g63MQR9c8cCQXfAR5kGT4Nx1SsNBuCTLkmiTyd76wXH2PSywyWExCdrFq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="345840660"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 09:23:38 +0800
IronPort-SDR: nD2MwrBn1ONdHIqaInPmgoiBHS37w6k62UoeS/8Zj/G0i2A4ur0BSPyFXJ9Pad4doBuXMKIK4q
 LuGlH7QosNMptOfNs5qYtftJGqBh0MnAOThOiPk9wLX1GWrCxn3yPh6D6CUq2UsCRPK68ym/mV
 /i5oWYsJLIjMcP5sWjVpRcdm9NwkcTF7azkmiEg0qjxwT/ffi7hdBPT6UVvzbSVlr1kYcPPZ8t
 asPKnKE5gZfqrZo49uK3mdnV1mQd5N4IoTd1u4IkxcGbZv9v91KKZW3D0plDVaaC8b7j7ZcSZ8
 3Zw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2023 17:31:22 -0700
IronPort-SDR: EBD7Zsap+FTYB854yNdN2NfsiEr1MfXNc30Bu1vU1Muqxhttsk3sdWS5ZND/JMPiilMneIE3xq
 cnvliOtwiuF9JLsx6oh7NpCOA4eOAFv+UDJ9yLC0S9cN9/fNlwEe2D93QHgHf2jS073tiJxoVD
 51j1CyO+1WfJKvs/f5gzlT4G8CCQA6g9i2RJhpSjp+bsPxX9yc4U3BmkkI5qoAbIRjiLyVv7l6
 YoR+WS32iYxcvJXxbgR3ksumW+34nZwmvzcIuh1UfApVsM2N6Q4zuDSznm20C807iBTKjhwWHd
 L4o=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2023 18:23:35 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date: Fri, 11 Aug 2023 10:23:34 +0900
Message-Id: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_182344_187810_D40FA55B 
X-CRM114-Status: GOOD (  17.83  )
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
the device with tcp transport [1]. Fix this by moving the code for
device readiness wait from _find_nvme_dev() to _nvme_connect_subsys().

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix the paths by adding the namespace index.

On top of the checks for sysfs attributes, add check for the created
device file. This ensures that the create device is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4f3a994..d09e7b4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -425,6 +425,7 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local dev i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -529,6 +530,16 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	dev=$(_find_nvme_dev "$subsysnqn")
+	for ((i = 0; i < 10; i++)); do
+		if [[ -b /dev/${dev}n1 &&
+			      -e /sys/block/${dev}n1/uuid &&
+			      -e /sys/block/${dev}n1/wwid ]]; then
+			return
+		fi
+		sleep .1
+	done
 }
 
 _nvme_discover() {
@@ -739,13 +750,6 @@ _find_nvme_dev() {
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
-- 
2.40.1


