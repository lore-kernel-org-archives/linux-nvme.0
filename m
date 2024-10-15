Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8D9CFC501
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LuoGDYsPXj8p8f4XfuUqpXhQFNhBY0HBX7WSPxJ6GZA=; b=ceOZD6RKKu9Q0YBPP8n0CKTKrD
	aEormQlnMN/qA/FBwoX7RNaKYBIx720ukhDfGm3iBdhupNBqTDOB0wDjee82ykL/6izu1hJHjDP5A
	+7rEJluOXZZXXyQQ3Y4YJtUMs4Az2CEvX1E4NX3TyGaSkh+mGX39C3qKdo1hcInclZoLR1NtAFywh
	HL/oIsNwiJc1Ji83+isI96NW8k9pD2lPq4Z5kvF/RZBZRQ+/N27XEoMr8K3h8+IERaE9mWxOMZ+F/
	lp4AW+LZH2EFpMgLTsCtJC9gInL/sPXZmnt2tO5GGMoyRu92Y3E8mJRrVVDDLeRuUurEMVEUi7ZTQ
	h+IxGSqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XXa-00000006ut1-3mHq;
	Tue, 15 Oct 2024 02:44:06 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XXX-00000006uqV-2LYd
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 02:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728960241; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LuoGDYsPXj8p8f4XfuUqpXhQFNhBY0HBX7WSPxJ6GZA=;
	b=eT5KuX+kl0p4dlVOiZw/Jkmqy8iptz9npnd94HHp9wkPlrIrYX7X9i3IR1qxFQ4+CNh9Jcaa3OhDHIMgFQEXvJHmICaIhTN24OM/xqymdd3Vs+Int9PvpHSU+r9FgAlb2OQrKJ/Mg1O++UP+52ULCy6z04Or6Gkmi5S/nCw5TVg=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHBZdsX_1728960235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 10:44:00 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v5 1/2] nvme/{md/001,rc,002,016,017,030,052}: introduce --resv_enable argument
Date: Tue, 15 Oct 2024 10:43:49 +0800
Message-ID: <20241015024350.16271-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015024350.16271-1-kanie@linux.alibaba.com>
References: <20241015024350.16271-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_194403_755600_6D2CE59B 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

Add an optional argument --resv_enable to _nvmet_target_setup() and
propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().

One can call functions with --resv_enable to enable reservation
feature on a specific namespace.

And also make _create_nvmet_ns and _create_nvmet_subsystem to parse
for arguments, this makes these functions more flexible to use.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme    | 89 ++++++++++++++++++++++++++++++++++++++++++--------
 tests/md/001   |  4 ++-
 tests/nvme/002 |  3 +-
 tests/nvme/016 |  7 ++--
 tests/nvme/017 | 10 +++---
 tests/nvme/030 |  6 ++--
 tests/nvme/052 |  5 ++-
 tests/nvme/rc  | 11 +++++--
 8 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/common/nvme b/common/nvme
index 9e78f3e..c1aa8d6 100644
--- a/common/nvme
+++ b/common/nvme
@@ -452,32 +452,95 @@ _remove_nvmet_port() {
 }
 
 _create_nvmet_ns() {
-	local nvmet_subsystem="$1"
-	local nsid="$2"
-	local blkdev="$3"
+	local nvmet_subsystem=""
+	local nsid=""
+	local blkdev=""
 	local uuid="00000000-0000-0000-0000-000000000000"
-	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-	local ns_path="${subsys_path}/namespaces/${nsid}"
+	local subsys_path=""
+	local ns_path=""
+	local resv_enable=false
 
-	if [[ $# -eq 4 ]]; then
-		uuid="$4"
-	fi
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				nvmet_subsystem="$2"
+				shift 2
+				;;
+			--nsid)
+				nsid="$2"
+				shift 2
+				;;
+			--blkdev)
+				blkdev="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--resv_enable)
+				resv_enable=true
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	ns_path="${subsys_path}/namespaces/${nsid}"
 
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f "${ns_path}/resv_enable" && "${resv_enable}" = true ]] ; then
+		printf 1 > "${ns_path}/resv_enable"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
 _create_nvmet_subsystem() {
-	local nvmet_subsystem="$1"
-	local blkdev="$2"
-	local uuid=$3
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local nvmet_subsystem=""
+	local blkdev=""
+	local uuid="00000000-0000-0000-0000-000000000000"
+	local resv_enable=""
+	local cfs_path=""
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				nvmet_subsystem="$2"
+				shift 2
+				;;
+			--blkdev)
+				blkdev="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--resv_enable)
+				resv_enable="--resv_enable";
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
 
+	cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	mkdir -p "${cfs_path}"
 	echo 0 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
+			 --nsid "1" \
+			 --blkdev "${blkdev}" \
+			 --uuid "${uuid}" \
+			 ${resv_enable}
 }
 
 _add_nvmet_allow_hosts() {
diff --git a/tests/md/001 b/tests/md/001
index 27df7b3..98da51d 100755
--- a/tests/md/001
+++ b/tests/md/001
@@ -52,7 +52,9 @@ setup_nvme_over_tcp() {
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "/dev/mapper/ram0_big_optio" "${def_subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "/dev/mapper/ram0_big_optio" \
+				--uuid "${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
diff --git a/tests/nvme/002 b/tests/nvme/002
index f613c78..043ab1c 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -34,7 +34,8 @@ test() {
 	local genctr=1
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "blktests-subsystem-$i" "${loop_dev}"
+		_create_nvmet_subsystem --subsysnqn "blktests-subsystem-$i" \
+					--blkdev "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index d1fdb35..1143cab 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -29,10 +29,13 @@ test() {
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "${loop_dev}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${loop_dev}"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				 --nsid "${i}" \
+				 --blkdev "${loop_dev}"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 114be60..5721000 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -29,12 +29,14 @@ test() {
 
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "$(_nvme_def_file_path)" \
-		"${def_subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "$(_nvme_def_file_path)" \
+				--uuid "${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" \
-				 "$(_nvme_def_file_path)"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				 --nsid "${i}" \
+				 --blkdev "$(_nvme_def_file_path)"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/030 b/tests/nvme/030
index b1ed8bc..5db20c0 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -30,13 +30,15 @@ test() {
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
+	_create_nvmet_subsystem --subsysnqn "${subsys}1" \
+				--blkdev "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
 	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
 
 	genctr=$(_discovery_genctr)
 
-	_create_nvmet_subsystem "${subsys}2" "$(losetup -f)"
+	_create_nvmet_subsystem --subsysnqn "${subsys}2" \
+				--blkdev "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
diff --git a/tests/nvme/052 b/tests/nvme/052
index 401f043..1dcda23 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -64,7 +64,10 @@ test() {
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
 		uuid="$(uuidgen -r)"
 
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				--nsid "${i}" \
+				--blkdev "$(_nvme_def_file_path).$i" \
+				--uuid "${uuid}"
 
 		# wait until async request is processed and ns is created
 		if ! nvmf_wait_for_ns "${uuid}" created; then
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 671012e..357cab9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -324,6 +324,7 @@ _nvmet_target_setup() {
 	local subsysnqn="${def_subsysnqn}"
 	local subsys_uuid="${def_subsys_uuid}"
 	local port
+	local resv_enable=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -347,6 +348,10 @@ _nvmet_target_setup() {
 				subsys_uuid="$2"
 				shift 2
 				;;
+			--resv_enable)
+				resv_enable="--resv_enable"
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -361,8 +366,10 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem "${subsysnqn}" "${blkdev}" \
-				"${subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${subsysnqn}" \
+				--blkdev "${blkdev}" \
+				--uuid "${subsys_uuid}" \
+				${resv_enable}
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
-- 
2.43.0


