Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E2D74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nR8CiJCsyRS0Yn2v+B79duo0YO1osnk7HTsH8JWfuKA=; b=1wAgaiBwo9URPgo1gbH84WbmTW
	2VvC/bTnq2ROqvr8eVzXcDLwPsmF06PAIu38SwRcJotjEZDD1MzX0kHBEwXVFR7RqiFdGWz/meEzs
	lS/+79ekq2kZFwMbo2sN9QS6Gd+3OSndNz+zkBmydAC0e3FN32OOffj7q9oxD/hU8oulTn6B+klE4
	kUr76N34nG4/8LI8ZrVYjVtE4FxqM+pYD+1AEyzJ0ap0qkwXP3oNdOVS4Fj0mw0qh5eoCAAfg5ZtM
	jvU4phFsfNGKZAmAY1qVTL2TC4VQtbnzES6J3aUV22YkCva3bIuxzoaFJn1vf8SaI2on271IQfVLe
	VMjlI7Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Z6-0000000H2Xx-3Vqv;
	Wed, 30 Oct 2024 06:52:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yj-0000000H2Dc-2hKA
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271121; x=1761807121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nL5zmfKHm2jr3fNYKijj0Rp5n3aU/thM+WyK9oE+Wi8=;
  b=CluioTbr0HBnIat6jLsVS7oMNYTQh2GSdveOC1ioCcZSgY1ImjphjhLi
   VFjWIVeMMTERyoCGIhbGY5v+GJ1W/CtviOcLJ/k++FcwqAOY4KkYaG7e/
   7BKF6TVp/BeTCtcwjep/dJ/3WeiGqJza0iqQ0njdbTuHbOE6odsraCPvC
   5wJnC281VPEhuurikAxaugsxBlWD1D3Y958LfGlAsAJx77xiFzqYhdNJA
   3uIixzYhOvjLqYpm/4fOlgRVGSZvMEYxB1IVjy+9kVq63jPzutILu5wmc
   hy6MpPd+odHNtYTC8+F7PFBZFOAzq/xVP0meU3tjxNsfK+szS6/tQ7u16
   A==;
X-CSE-ConnectionGUID: lzCB/KCbRTGfN43OsWaQEg==
X-CSE-MsgGUID: xWSAFNEGS6mMAQReZl8KNg==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:52:01 +0800
IronPort-SDR: 6721ca63_uQ5QaKetf2YgBmbXSW2r7I8o6vpSPa6Gxs3cQEPupYTbY/8
 JZO2QM5ZyWoP1ma1RFpHLGAeOBGU3ZlkmTWWq2g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:52:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 12/13] common/nvme, nvme/{016,017,052}: improve _create_nvmet_ns()
Date: Wed, 30 Oct 2024 15:51:48 +0900
Message-ID: <20241030065149.2297405-13-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235201_752881_FB672737 
X-CRM114-Status: GOOD (  14.01  )
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
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 47 ++++++++++++++++++++++++++++++++---------------
 tests/nvme/016 |  5 ++---
 tests/nvme/017 |  5 ++---
 tests/nvme/052 |  8 +++-----
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/common/nvme b/common/nvme
index 3a2bb35..bc5019a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -511,18 +511,19 @@ _remove_nvmet_port() {
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
@@ -541,6 +542,10 @@ _create_nvmet_ns() {
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
@@ -548,16 +553,23 @@ _create_nvmet_ns() {
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
@@ -566,6 +578,7 @@ _create_nvmet_subsystem() {
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local resv_enable=""
 	local cfs_path=""
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -595,11 +608,15 @@ _create_nvmet_subsystem() {
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
index 13d2c46..56f1477 100755
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
index 10ee38c..edd70ca 100755
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


