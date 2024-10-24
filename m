Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB7D0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WhWcUFORwjowGc3T23bqyaeNzS+z5D5qnbwCSb6tYk=; b=sIAWrocFnTJe9x3sBLDhbLmTfC
	LKZ8UZhzlVsEF0SiT+30UU2InK3NOrJzjznhhoHI1IKChMuheqS30/Eo788XWcG0fjvouamMNJ+7w
	Hxz9lI64DwSGOygvdcO2YRib8R65zHickOmMjEDBKyr2Lp94juEh/8peINbA7Dd7x34fSgarixwjD
	cTe7p7SJG0Cf/HG4JnofXvRPm8+21PR1/EYtd7PLdTE+5BGZG1QKynGkjIeeYenHX3PLPbwNFAxxD
	4lCdc+5KVIHp1211xptRfEUn/fy0xYCSlLI9RgT/ppcpfDkCEjjA4XvhQF/94lMBcldHRGa5uoRoG
	doBu0+6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDT-0000000GMgR-370q;
	Thu, 24 Oct 2024 01:00:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDK-0000000GMXt-37Wr
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731634; x=1761267634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5MRhVtTmhCl/+iG+uemoIefDwmQC0MS4qR3wsi+now=;
  b=IjKmhaS74ORZOrPPQ9s5FUMUI+okgxxSpWH4U5r8WX45mysF4GTqKnDj
   ChSmEm94wofwFYhQBFv0NNWWO6VJOZIksirZhCWxS6Y3R44odMzQtCbUT
   sscmuAN0RtukIOEr/Mu65q7o74Hh7fsND6IoXtdWXiSa02/QW2jGrV1dB
   IU6EKCD3/uD6MzQtoRCsIKAipf7Kjd+B0tBwiuNRhJ6Iq+o5deruRlCO6
   O48Fegocg0lbZkk5heycRMKyVeCDguiBOPVMsXNbEeTMLPd+pFtwDw3T7
   dfCLYwK4ov5J1xL7fl//Fb/ft7SObgcERzsvZw4zhVuJZxIOfUnqwCVPm
   Q==;
X-CSE-ConnectionGUID: 51UFsa1hQQ2iRF7gv6bVPQ==
X-CSE-MsgGUID: E74d5s+kSNKt/FAQzCu4RA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211093"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:30 +0800
IronPort-SDR: 67198f16_1iVlVobjHxUj5v5aeoPsZZOJ8at5NyemUwyGZ3W7Cd46Bah
 yRGfmm33MGfruEg66HcGR7YvK5g7IyyU5z3xCSA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 05/15] nvme/{rc,002,016,017,030}: pass port ID to genctr helper functions
Date: Thu, 24 Oct 2024 10:00:15 +0900
Message-ID: <20241024010025.2216242-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180035_098485_EA36E599 
X-CRM114-Status: GOOD (  12.09  )
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

Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
introduced wwnn and wwpn calculation based on port ID for fc transport.
This means that --traddr and --host-traddr options for "nvme discover"
command should reflect the port ID. This change was missing for the
genctr, or Generation Counter, related helper functions and it made
the test case nvme/030 fail.

To avoid the failure, pass the port ID to the genctr related helper
functions and reflect the port ID for fc transport.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/002 |  3 ++-
 tests/nvme/016 |  3 ++-
 tests/nvme/017 |  3 ++-
 tests/nvme/030 | 13 ++++++++-----
 tests/nvme/rc  | 18 +++++++++++-------
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index e5b751d..b87570a 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -39,7 +39,8 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "adding a subsystem to a port")
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/016 b/tests/nvme/016
index 8ab9d22..13d2c46 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -41,7 +41,8 @@ test() {
 	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "$port" "${def_subsysnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "adding a subsystem to a port")
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/017 b/tests/nvme/017
index dd302fc..10ee38c 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -42,7 +42,8 @@ test() {
 	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "adding a subsystem to a port")
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/030 b/tests/nvme/030
index 1ba1274..596e411 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -35,26 +35,29 @@ test() {
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
 	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
 
-	genctr=$(_discovery_genctr)
+	genctr=$(_discovery_genctr "$port")
 
 	_create_nvmet_subsystem --subsysnqn "${subsys}2" \
 				--blkdev "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
 
-	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "adding a subsystem to a port")
 
 	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "adding host to allow_hosts")
+	genctr=$(_check_genctr "${genctr}" "$port" "adding host to allow_hosts")
 
 	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "removing host from allow_hosts")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "removing host from allow_hosts")
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
 	_remove_nvmet_subsystem "${subsys}2"
 
-	genctr=$(_check_genctr "${genctr}" "removing a subsystem from a port")
+	genctr=$(_check_genctr "${genctr}" "$port" \
+			       "removing a subsystem from a port")
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
 	_remove_nvmet_subsystem "${subsys}1"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 5b4629d..64a31e0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -222,15 +222,16 @@ _nvme_calc_rand_io_size() {
 
 _nvme_discover() {
 	local trtype="$1"
-	local traddr="${2:-$def_traddr}"
-	local host_traddr="${3:-$def_host_traddr}"
-	local trsvcid="${3:-$def_trsvcid}"
+	local port="$2"
+	local traddr="$def_traddr"
+	local trsvcid="$def_trsvcid"
 
 	ARGS=(--transport "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
-		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
+		ARGS+=(--traddr "$(_fc_traddr "$port")")
+		ARGS+=(--host-traddr "$(_fc_host_traddr "$port")")
 	elif [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
@@ -463,16 +464,19 @@ _nvmet_passthru_target_cleanup() {
 }
 
 _discovery_genctr() {
-	_nvme_discover "${nvme_trtype}" |
+	local port=${1}
+
+	_nvme_discover "${nvme_trtype}" "${port}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
 
 _check_genctr() {
 	local last=$1
-	local msg=$2
+	local port=$2
+	local msg=$3
 	local genctr
 
-	genctr=$(_discovery_genctr)
+	genctr=$(_discovery_genctr "$port")
 	if (( "${genctr}" <= "${last}" )); then
 		echo "Generation counter not incremented when ${msg} (${genctr} <= ${last})"
 	fi
-- 
2.45.2


