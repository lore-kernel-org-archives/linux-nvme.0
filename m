Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758CED0BB4B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRRoxQFmi7HvxgkOlMSEyIcHcHjvnRHTYTKLtnENaI4=; b=vuhV03QT9JEJ2szHcNMR3PPhUR
	Q/c72VUzKMDEyGC5GxmbLAYZJMgg62SZq2rQbvNjjp1CBqYxy9eqk2zOJ1vgSTuZ84x/W5GiGP517
	dGYxH9hQMED8+XLDVS4S6XrpkNV8TRAQ1FwmDUmRccnk8Xw4oBKWvAlnvpET3ax1viugFwCE68Moe
	9X1KW4wVPLYXLVV8pZYPTYyXBRHmqtxCase3XT4fSj8WQwdvb3R2JFjTRieRTJeeWiudSHDmKuX/8
	eRus9N5NBuQ0GJfwnxEtqrbOeCKSh8Y0Pi7Ddayrs2cbmDaEWbviKtNXDQZ1PWg6A+WSPl0whiLIS
	4G6owDzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDr-0000000GMzf-1znc;
	Thu, 24 Oct 2024 01:01:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDP-0000000GMXt-3VMu
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731639; x=1761267639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVzbnP4FiT+1XGzKwAw7lBs70ektQXY73rBvvTJ9vW8=;
  b=NHO6TYaf6Ue/rU/WI4B3pBvPmrEAJavjJSgD93epF3ZWMnADkpxLlVLA
   Lmaya4/HYCXHRggYvbZysYkkplXqGCgcn+SLDREQZK7Gy9n728heEMn5K
   AUX4r8A8fzdhTHKDQCJ4ga+z3E10ETCA42Ymq3XlaaC4uqKsypdBCuGr8
   c4Q0s7c1DDUYXFihEsKvtcHNUKHaGeJGdE7F7bz3bK0bpOu+51vOGA382
   SXuGOpRFz5SuYSGsb86JJbGzWwAq0HIQoFXyeO76PWgGifprDvDVNcSoW
   MRqcVaqvhR5vRXHfE5n9t1cAVYTcvCzsmYRaL0vJQXGdtF7aJD1dPq53y
   Q==;
X-CSE-ConnectionGUID: +LX/kv/qRQKeAvAbSXy6aw==
X-CSE-MsgGUID: HfH1NhkVTda37pXeWJb6Qg==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211161"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:38 +0800
IronPort-SDR: 67198f1e_eA7HQRT4niHEMb75y54af6tpwDvRIPhRTeirGNcnWVGu1kc
 hS9uFX8mY+3bQ8Az0oRX/JRe4D5zW/VMOcsPXfw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:46 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 14/15] common/nvme, nvme/{016,017,052}: improve _create_nvmet_ns()
Date: Thu, 24 Oct 2024 10:00:24 +0900
Message-ID: <20241024010025.2216242-15-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180040_203946_0C5B8B1B 
X-CRM114-Status: GOOD (  13.51  )
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

Add --grpid option to pass ANA group id. If no UUID is passed the kernel
will generate a UUID, so return the UUID to allow the caller to identify
the generated namespace. Allow to call _create_nvmet_ns() without
--subsysnqn option by using def_subsysnqn as its default value.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 47 ++++++++++++++++++++++++++++++++---------------
 tests/nvme/016 |  5 ++---
 tests/nvme/017 |  5 ++---
 tests/nvme/052 |  8 +++-----
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/common/nvme b/common/nvme
index 6cdff13..ae37350 100644
--- a/common/nvme
+++ b/common/nvme
@@ -518,18 +518,19 @@ _remove_nvmet_port() {
 }
 
 _create_nvmet_ns() {
-	local nvmet_subsystem=""
-	local nsid=""
-	local blkdev=""
-	local uuid="00000000-0000-0000-0000-000000000000"
-	local subsys_path=""
-	local ns_path=""
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="1"
+	local grpid="1"
+	local blkdev
+	local uuid
+	local subsys_path
+	local ns_path
 	local resv_enable=false
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
 			--subsysnqn)
-				nvmet_subsystem="$2"
+				subsysnqn="$2"
 				shift 2
 				;;
 			--nsid)
@@ -548,6 +549,10 @@ _create_nvmet_ns() {
 				resv_enable=true
 				shift 1
 				;;
+			--grpid)
+				grpid="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -555,16 +560,23 @@ _create_nvmet_ns() {
 		esac
 	done
 
-	subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	subsys_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	ns_path="${subsys_path}/namespaces/${nsid}"
-
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
-	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
 	if [[ -f "${ns_path}/resv_enable" && "${resv_enable}" = true ]] ; then
 		printf 1 > "${ns_path}/resv_enable"
 	fi
+	if [[ -n "${uuid}" ]]; then
+		printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	else
+		uuid=$(cat "${ns_path}/device_uuid")
+	fi
+	if (( grpid != 1 )); then
+		printf "%d" "${grpid}" > "${ns_path}/ana_grpid"
+	fi
 	printf 1 > "${ns_path}/enable"
+	echo "${uuid}"
 }
 
 _create_nvmet_subsystem() {
@@ -573,6 +585,7 @@ _create_nvmet_subsystem() {
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local resv_enable=""
 	local cfs_path=""
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -602,11 +615,15 @@ _create_nvmet_subsystem() {
 	cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	mkdir -p "${cfs_path}"
 	echo 0 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
-			 --nsid "1" \
-			 --blkdev "${blkdev}" \
-			 --uuid "${uuid}" \
-			 ${resv_enable}
+	ARGS+=(--subsysnqn "${nvmet_subsystem}")
+	ARGS+=(--blkdev "${blkdev}")
+	if [[ -n "$uuid" ]]; then
+		ARGS+=(--uuid "${uuid}")
+	fi
+	if [[ -n "$resv_enable" ]]; then
+		ARGS+=("${resv_enable}")
+	fi
+	_create_nvmet_ns "${ARGS[@]}" > /dev/null
 }
 
 _add_nvmet_allow_hosts() {
diff --git a/tests/nvme/016 b/tests/nvme/016
index 4b01c0a..53e3f2e 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -33,9 +33,8 @@ test() {
 				--blkdev "${loop_dev}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				 --nsid "${i}" \
-				 --blkdev "${loop_dev}"
+		_create_nvmet_ns --nsid "${i}" \
+				 --blkdev "${loop_dev}" > /dev/null
 	done
 
 	port="$(_create_nvmet_port)"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 8f57579..d4fca2f 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -34,9 +34,8 @@ test() {
 				--uuid "${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				 --nsid "${i}" \
-				 --blkdev "$(_nvme_def_file_path)"
+		_create_nvmet_ns --nsid "${i}" \
+				 --blkdev "$(_nvme_def_file_path)" > /dev/null
 	done
 
 	port="$(_create_nvmet_port)"
diff --git a/tests/nvme/052 b/tests/nvme/052
index 1dcda23..5cdabb1 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -52,6 +52,7 @@ test() {
 	_setup_nvmet
 
 	local iterations=20
+	local uuid
 
 	_nvmet_target_setup
 
@@ -62,12 +63,9 @@ test() {
 	# deleted when nvme target is cleaned up.
 	for ((i = 2; i <= iterations; i++)); do {
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
-		uuid="$(uuidgen -r)"
 
-		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				--nsid "${i}" \
-				--blkdev "$(_nvme_def_file_path).$i" \
-				--uuid "${uuid}"
+		uuid=$(_create_nvmet_ns --blkdev "$(_nvme_def_file_path).$i" \
+					--nsid "${i}")
 
 		# wait until async request is processed and ns is created
 		if ! nvmf_wait_for_ns "${uuid}" created; then
-- 
2.45.2


