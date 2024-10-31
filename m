Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A351FE6896F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qzHplSxURxi+8Vizphw5VSlBIcRe+HIYQs7hf52FWtc=; b=vn3UfByrBBV/TCni+feTJ8RhcA
	+bO7Vl1xQKE9nijVb3XgoVs1gqV1sZBPAGufqB7zx+wIC7XcTviR7n/fPpRdHS4cyxAdQb8/ekuk+
	7a76CxhuAF9bMYlBZx5l+2xGEDFKVtNJ5j1Lcxqp5KhAmBQqZP8Mx93Jk131EerirWBX8brYnH1C7
	ZVZArwkpRWTE1tRyeFN4Py44zJTO3OJy8D8s5XS/CMGXdPSxW5QI37gHs64uiK1sNMX3JLRjSyB05
	jzJuhgOo0iF7ErxB5U7v7qDt/4oOEnEDHZB5Q9fLhcGLHqiXpUmUWUN+vDWwvzAf+jxGUaUBsDedL
	IINTOw8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6SCn-00000003CUs-1ejt;
	Thu, 31 Oct 2024 10:15:05 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6SCk-00000003CT2-1w8K
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 10:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730369700; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qzHplSxURxi+8Vizphw5VSlBIcRe+HIYQs7hf52FWtc=;
	b=yWOTpZthBtGUWtP1WpdIyfFjA5ZM+55ecVcG2KYtTt6QUSKK7oAJUSjvnOUpzgEjJn1Q2Q1BgtctYNJZ66bPXbPdLkbc6X+vbVRcbXsuKkEZZJjjggPFxLLjm7Ehr2E3mYnPypR64gXrWzjCBM0Fvj4yk/0aZjq8GHXYVlYUTJ0=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIIEdbd_1730369695 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 18:14:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3] nvme/{common/nvme, 016, 017, 051, 052}: introduce def_nsid
Date: Thu, 31 Oct 2024 18:14:55 +0800
Message-ID: <20241031101455.29273-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_031502_809335_8591FEF6 
X-CRM114-Status: GOOD (  12.19  )
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

Use def_nsid instead of hard code, the default of def_nsid is 1.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Changes from v2 to v3:
- Fix 016, 017, 052 do nothing when the def_nsid is set to
biger than iterations.(Shinichiro Kawasaki)
- Fix "make check" error in 052.(Shinichiro Kawasaki)

Changes from v1 to v2:
- change the hard code in _remove_nvmet_subsystem() to fix
the nvme/004 fail if change def_nsid to 2.(Shinichiro Kawasaki)
- Add RB tags from Chaitanya Kulkarni and Daniel Wagner (thanks!)

 common/nvme    |  5 +++--
 tests/nvme/016 | 10 ++++++----
 tests/nvme/017 | 10 ++++++----
 tests/nvme/051 |  2 +-
 tests/nvme/052 | 21 +++++++++++----------
 5 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/common/nvme b/common/nvme
index c1aa8d6..99c2911 100644
--- a/common/nvme
+++ b/common/nvme
@@ -16,6 +16,7 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+export def_nsid="1"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
@@ -537,7 +538,7 @@ _create_nvmet_subsystem() {
 	mkdir -p "${cfs_path}"
 	echo 0 > "${cfs_path}/attr_allow_any_host"
 	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
-			 --nsid "1" \
+			 --nsid "${def_nsid}" \
 			 --blkdev "${blkdev}" \
 			 --uuid "${uuid}" \
 			 ${resv_enable}
@@ -588,7 +589,7 @@ _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
-	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	_remove_nvmet_ns "${nvmet_subsystem}" "${def_nsid}"
 	rm -f "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
diff --git a/tests/nvme/016 b/tests/nvme/016
index 1143cab..b655d1d 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -32,9 +32,10 @@ test() {
 	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
 				--blkdev "${loop_dev}"
 
-	for ((i = 2; i <= iterations; i++)); do
+	for ((i = 1; i <= iterations; i++)); do
+		nsid=$((def_nsid + i))
 		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				 --nsid "${i}" \
+				 --nsid "${nsid}" \
 				 --blkdev "${loop_dev}"
 	done
 
@@ -46,8 +47,9 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${def_subsysnqn}" "$i"
+	for ((i = iterations; i >= 1; i--)); do
+		nsid=$((def_nsid + i))
+		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 	done
 
 	_remove_nvmet_subsystem "${def_subsysnqn}"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 5721000..ae335d0 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -33,9 +33,10 @@ test() {
 				--blkdev "$(_nvme_def_file_path)" \
 				--uuid "${def_subsys_uuid}"
 
-	for ((i = 2; i <= iterations; i++)); do
+	for ((i = 1; i <= iterations; i++)); do
+		nsid=$((def_nsid + i))
 		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				 --nsid "${i}" \
+				 --nsid "${nsid}" \
 				 --blkdev "$(_nvme_def_file_path)"
 	done
 
@@ -47,8 +48,9 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${def_subsysnqn}" "$i"
+	for ((i = iterations; i >= 1; i--)); do
+		nsid=$((def_nsid + i))
+		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 	done
 
 	_remove_nvmet_subsystem "${def_subsysnqn}"
diff --git a/tests/nvme/051 b/tests/nvme/051
index 624b42f..4757b80 100755
--- a/tests/nvme/051
+++ b/tests/nvme/051
@@ -33,7 +33,7 @@ test() {
 	_setup_nvmet
 
 	_nvmet_target_setup
-	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
+	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/${def_nsid}"
 
 	# fire off two enable/disable loops concurrently and wait
 	# for them to complete...
diff --git a/tests/nvme/052 b/tests/nvme/052
index 1dcda23..574903a 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -57,35 +57,36 @@ test() {
 
 	_nvme_connect_subsys
 
-	# start iteration from ns-id 2 because ns-id 1 is created
-	# by default when nvme target is setup. Also ns-id 1 is
+	# start iteration from def_nsid+1 because def_nsid is created
+	# by default when nvme target is setup. Also def_nsid is
 	# deleted when nvme target is cleaned up.
-	for ((i = 2; i <= iterations; i++)); do {
-		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
+	for ((i = 1; i <= iterations; i++)); do {
+		nsid=$((def_nsid + i))
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).${nsid}"
 		uuid="$(uuidgen -r)"
 
 		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
-				--nsid "${i}" \
-				--blkdev "$(_nvme_def_file_path).$i" \
+				--nsid "${nsid}" \
+				--blkdev "$(_nvme_def_file_path).${nsid}" \
 				--uuid "${uuid}"
 
 		# wait until async request is processed and ns is created
 		if ! nvmf_wait_for_ns "${uuid}" created; then
 			echo "FAIL"
-			rm "$(_nvme_def_file_path).$i"
+			rm "$(_nvme_def_file_path).${nsid}"
 			break
 		fi
 
-		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 
 		# wait until async request is processed and ns is removed
 		if ! nvmf_wait_for_ns "${uuid}" removed; then
 			echo "FAIL"
-			rm "$(_nvme_def_file_path).$i"
+			rm "$(_nvme_def_file_path).${nsid}"
 			break
 		fi
 
-		rm "$(_nvme_def_file_path).$i"
+		rm "$(_nvme_def_file_path).${nsid}"
 	}
 	done
 
-- 
2.43.0


