Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848FAD0BB4B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1P/hVZPt1jexFh9LtjHnhw7me8O2LjomPnwoP9bTpko=; b=SJNLCAivXZ1MuuLq8ZZwoxF9SI
	KRFWJaASl+oGynrYFA2EH89Pzd4DYStMAJo0xpCX2FfV2tTEo+OktfnRFFstyrb5ve5QzN1ACmIQ7
	0lm/RUbxlwlvtVr0ZKs7YnB+56UVyA/xacJPoKZKkdDQbbo6QolHUodezwWJ2mcViXEW8mHSDv7ZV
	vbvDshgrMzX6q4T15QsakrwtU4cpwMOqhRbpBuEsXnCpFVhTOPI4iujxqFFjLmuYyB8I2BVd2xqzP
	gsXdU4lQfAq6ExBEgn58SxJB3nlYwe8U3a1BOzH59IU9M2zGiHoyJOvPZNGn0IGOYIyoN5/C1rvbg
	wxe1iGYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDl-0000000GMwP-3O4U;
	Thu, 24 Oct 2024 01:01:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDP-0000000GMX3-40PP
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731639; x=1761267639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRXh40Uh+xwX+n1rwiJlHK84/WbZC3dqhp4Fz657ZUo=;
  b=Szp4AppWbugcOwIEw2JrmEVVUFPg8urzijkGA7uJ6Lbsl3LI/aN7lT0U
   TkSsr81zeEvdG5uRDNXJyfA/RI2DcO4uZcl0SKaml8mhPIS8sCpHes4gh
   LRkRA2tYbJOgezvXEWvK64lOXvZURnjM5c5/GETsCLpQb7wsWOuvAOGFP
   p6x63f8WlHlmk/tILFE3uZT7SVFezhiW+0CBpKLb5D0EmVNJgU2b/doGT
   xt/wrfJQyrcnWCkoRYSUkl+qbsjqHM/MPPJNcw/gb4xIgMXdyS4pKnTU5
   GkNj5oFs0XItbh3opQarVfMY2FFQgyXhd3/pSrv7B5NjObSiLGtGfmN5s
   A==;
X-CSE-ConnectionGUID: DV2ODFIrQZC+U6CfPxsbyA==
X-CSE-MsgGUID: VeXSXgi2Tcmu+0RQXHqb0Q==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211167"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:39 +0800
IronPort-SDR: 67198f1f_EouJsIGD+88g7OBokcbpi5FgzRV3f0hKAOsOB6h4nULuLg3
 fajQawAaTbN5OvzsouMlj+crjPSFUe7iSpe07Qw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:39 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 15/15] nvme, md/001: support only long options for _create_nvmet_subsystem()
Date: Thu, 24 Oct 2024 10:00:25 +0900
Message-ID: <20241024010025.2216242-16-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180040_365218_6FEC8EB5 
X-CRM114-Status: GOOD (  11.35  )
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
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 19 +++++++++++--------
 tests/md/001   |  4 +---
 tests/nvme/016 |  3 +--
 tests/nvme/017 |  4 +---
 tests/nvme/rc  | 19 ++++++++++++++-----
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/common/nvme b/common/nvme
index ae37350..d5091cf 100644
--- a/common/nvme
+++ b/common/nvme
@@ -580,17 +580,17 @@ _create_nvmet_ns() {
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
@@ -612,10 +612,13 @@ _create_nvmet_subsystem() {
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
index 53e3f2e..ef894bb 100755
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
index d4fca2f..13a1b73 100755
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
index 167e085..4fea739 100644
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


