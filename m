Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9964E68948
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 02:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sQcQ7gw0wbAfmhW6s56dlJhG/XT4YVYzEtUTl2JYIbk=; b=28khkwLgcS7+IKo3jgAmGu8PTg
	EwvvcDAqMzrdFF1JK2SP+onN9JA2iYmmBNyxhCH9i+mf/PX5LIVq2HVnU2jFLI790q3W47Xt1EutB
	MpfhyxvMc1PsjEv9orBFSoEyl9OWoY6YTbDeH9L2qSOfWKHcaqHgSLIxVYB9RO/GW39bO18IXiIHc
	0aKjSo05SB0Nb1kLXD1gejfDLZcfE69DIMrPe1xL9MO+t6tIQsBqIUCAl+HkEljEKy4S/DnhAhW6h
	78OX5SM92Df47IQMr9xNrZX7F2T30cNje0ggQoJbbY3rP/gh5pL58nSihovEdYcH1PgLU0tJMt5Xv
	sVyH1zvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6L3L-00000002MQF-1Ceb;
	Thu, 31 Oct 2024 02:36:51 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6L26-00000002MNA-0C85
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 02:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730342130; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sQcQ7gw0wbAfmhW6s56dlJhG/XT4YVYzEtUTl2JYIbk=;
	b=pzMEGaixHcCl3a0E6fw0JjB/fLPDbSDdBSXRxcXMp7ScQA3FzHcu3wA7gBOmLjHtOdPiA2mSjBM6xO8o7XZigOKSXReyTYE5SoqF6dcqaW6JIcetY3zHv5/3yh9zXkS3w7oWNyn683abS7ehB50Fde3tveMycPeyEByZNFxzlzo=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIGam6T_1730342121 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 10:35:27 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2] nvme/{common/nvme, 051, 052}: introduce def_nsid
Date: Thu, 31 Oct 2024 10:35:21 +0800
Message-ID: <20241031023521.36012-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_193534_261680_EB05BF7A 
X-CRM114-Status: GOOD (  10.46  )
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
Changes from v1 to v2:
- change the hard code in _remove_nvmet_subsystem() to fix
the nvme/004 fail if change def_nsid to 2.

 common/nvme    | 5 +++--
 tests/nvme/051 | 2 +-
 tests/nvme/052 | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

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
index 1dcda23..781a9f0 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -57,10 +57,10 @@ test() {
 
 	_nvme_connect_subsys
 
-	# start iteration from ns-id 2 because ns-id 1 is created
-	# by default when nvme target is setup. Also ns-id 1 is
+	# start iteration from def_nsid+1 because def_nsid is created
+	# by default when nvme target is setup. Also def_nsid is
 	# deleted when nvme target is cleaned up.
-	for ((i = 2; i <= iterations; i++)); do {
+	for ((i = $((${def_nsid})) + 1; i <= iterations; i++)); do {
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
 		uuid="$(uuidgen -r)"
 
-- 
2.43.0


