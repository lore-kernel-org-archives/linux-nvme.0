Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F8AD74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CdxOFJh2iHotxK3gkx2ve3+aturnQOl/7iORIhbawE=; b=mkgBXQdNMpFpHrbZdPLmOBAo30
	lpvHjkYJRU70yf/F1dRscl8vl8muTFOB3g0juLT0WOXfWqWs1gV3niEMRWGjRoryn7Z9iljpA1Q4F
	MultO5rO0FEXyDpzaqd2lJRIKIhmAj5cYVS6Co3EwPDr6IPZdIasbVa7KbX7KpAf+f9+KwJL3Wa3W
	M0sWd+wQ1mDYWvE0JpCJsYo3pB7Fd/opAHTPg4XCOI6HIWj0wvi4Cv3wkDxYOJEL3spblMWgDcC2o
	jJVm54S1RbD+oqiceHkgZ6zEql3QOBUWBpQgTvfnCO7XI1T4Zd+mJ9Y7hwDaEh97/Ieu+P0+EIRSK
	zA/e1gog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62ZB-0000000H2bg-3fMp;
	Wed, 30 Oct 2024 06:52:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yn-0000000H2IH-0VUe
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271125; x=1761807125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Q2axc4EsOT7hNJUTEoPIh61s90NuV/Ny/3Al+Ih7GQ=;
  b=Dwgj751dUVDLcqJZmB5+UML81rtZTYvWWVXXiQ6lp04yl64kH9SejYBw
   IaDE5MrWruMiTjksbfwIamrl9ff+/k3Uj86YM4obuWcPotI56uBdbUrXU
   PoJWS4pxBV6pEZjhyo3Ln5nrPw7jmGxHq0CHcKE7rJKlz//Mt6I93bi9z
   jmXvW0WpLBzBUIzzvArAjOgJXhPyJE5CVr+MmsjW8UBuebWHp8i5Fo3mf
   aC85wKE8Whqs4iNdsAPbbXOaX85FW1W6UTIUB426OD27IL8S1FskeIQBb
   IjwhF98aHItc3FsOr9/FMp14aKMBPNtSMOUdYdBetHmDnc7n4QUucNZoT
   g==;
X-CSE-ConnectionGUID: ay1y/R/cSrmJIIgPibUOCw==
X-CSE-MsgGUID: +Qk1GEtKS1CP3AYOkaRH9w==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314350"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:52:03 +0800
IronPort-SDR: 6721ca64_5RidnFEtNALInGvqvM1tpzGLEWh3L/oGlZMqOyiWnNPIHoq
 1YK9JpyniYUKldKMBieQ/2/wObirt8FTnoZZmBw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:48 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:52:02 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 13/13] nvme, md/001: support only long options for _create_nvmet_subsystem()
Date: Wed, 30 Oct 2024 15:51:49 +0900
Message-ID: <20241030065149.2297405-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235205_192933_730308D8 
X-CRM114-Status: GOOD (  12.12  )
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

Most callers use the default settings anyway, so simplify them
by using long options for _create_nvmet_subsystem().

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 19 +++++++++++--------
 tests/md/001   |  4 +---
 tests/nvme/016 |  3 +--
 tests/nvme/017 |  4 +---
 tests/nvme/rc  | 19 ++++++++++++++-----
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/common/nvme b/common/nvme
index bc5019a..cbfdd2d 100644
--- a/common/nvme
+++ b/common/nvme
@@ -573,17 +573,17 @@ _create_nvmet_ns() {
 }
 
 _create_nvmet_subsystem() {
-	local nvmet_subsystem=""
-	local blkdev=""
-	local uuid="00000000-0000-0000-0000-000000000000"
-	local resv_enable=""
-	local cfs_path=""
+	local subsystem="${def_subsysnqn}"
+	local blkdev
+	local uuid="${def_subsys_uuid}"
+	local resv_enable
+	local cfs_path
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
 			--subsysnqn)
-				nvmet_subsystem="$2"
+				subsystem="$2"
 				shift 2
 				;;
 			--blkdev)
@@ -605,10 +605,13 @@ _create_nvmet_subsystem() {
 		esac
 	done
 
-	cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	cfs_path="${NVMET_CFS}/subsystems/${subsystem}"
 	mkdir -p "${cfs_path}"
 	echo 0 > "${cfs_path}/attr_allow_any_host"
-	ARGS+=(--subsysnqn "${nvmet_subsystem}")
+	if [[ -z "${blkdev}" ]]; then
+		return 0
+	fi
+	ARGS+=(--subsysnqn "${subsystem}")
 	ARGS+=(--blkdev "${blkdev}")
 	if [[ -n "$uuid" ]]; then
 		ARGS+=(--uuid "${uuid}")
diff --git a/tests/md/001 b/tests/md/001
index 5d0752f..f1d92c8 100755
--- a/tests/md/001
+++ b/tests/md/001
@@ -52,9 +52,7 @@ setup_nvme_over_tcp() {
 	local port
 	port="$(_create_nvmet_port)"
 
-	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
-				--blkdev "/dev/mapper/ram0_big_optio" \
-				--uuid "${def_subsys_uuid}"
+	_create_nvmet_subsystem --blkdev "/dev/mapper/ram0_big_optio"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index 56f1477..8e4fc8b 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -29,8 +29,7 @@ test() {
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
-	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
-				--blkdev "${loop_dev}"
+	_create_nvmet_subsystem --blkdev "${loop_dev}"
 
 	for ((i = 2; i <= iterations; i++)); do
 		_create_nvmet_ns --nsid "${i}" \
diff --git a/tests/nvme/017 b/tests/nvme/017
index edd70ca..adebea1 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -29,9 +29,7 @@ test() {
 
 	local genctr=1
 
-	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
-				--blkdev "$(_nvme_def_file_path)" \
-				--uuid "${def_subsys_uuid}"
+	_create_nvmet_subsystem --blkdev "$(_nvme_def_file_path)"
 
 	for ((i = 2; i <= iterations; i++)); do
 		_create_nvmet_ns --nsid "${i}" \
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 64a31e0..f03851c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -323,9 +323,10 @@ _nvmet_target_setup() {
 	local ctrlkey=""
 	local hostkey=""
 	local subsysnqn="${def_subsysnqn}"
-	local subsys_uuid="${def_subsys_uuid}"
+	local subsys_uuid
 	local port
 	local resv_enable=""
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -367,10 +368,18 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem --subsysnqn "${subsysnqn}" \
-				--blkdev "${blkdev}" \
-				--uuid "${subsys_uuid}" \
-				${resv_enable}
+	ARGS=(--subsysnqn "${subsysnqn}")
+	if [[ -n "${blkdev}" ]]; then
+		ARGS+=(--blkdev "${blkdev}")
+	fi
+	if [[ -n "${subsys_uuid}" ]]; then
+		ARGS+=(--uuid "${subsys_uuid}")
+	fi
+	if [[ -n "${resv_enable}" ]]; then
+		ARGS+=("${resv_enable}")
+	fi
+	_create_nvmet_subsystem "${ARGS[@]}"
+
 	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
-- 
2.45.2


