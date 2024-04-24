Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E725C07E8E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4huwBV2fwwCBh7UgqFjvAG+/EFc5V/fuyLnmWFk604=; b=txdBYsJiMI716H/8tV4hu4qOX+
	qDcUyYBrX/bb0crP91iekp/qSWwJ2gqpxbYhf2hQ4CGc5VZjv7/OX4WGPNYyzPlA0aJsL15Jef074
	2Qf/GQWDeBaGTaBLkGrVMUWG7tFpu1wF+UJstbnIKjDTr+CfMg++9uRcjpvS2t7FRpIRQxI5nUH3F
	W9kz6TuBn9lF0ceky2FmPXZ1RKXSjyRn/K1i7Tf+nfboail433IoGxplIyfxKs6d8sGPfqFvUXjDO
	uU63KArP/NYW+GFES7pKlAlMh7o8mdOZ0z1dtirxQAN2Bkof1UeEKEVMfrL/BKepBjxB7b6BDmClP
	tjC8vmiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYH-00000003C9R-2Nzk;
	Wed, 24 Apr 2024 08:00:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXw-00000003BnK-17Jz
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945604; x=1745481604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AhslQoyHiXqPtsxsMjtks4PAsu+KungIzCjBimCEE8=;
  b=BSso0pTXCRaRWyQ7Dopx3v9IKZzY5Oj/pP6vr06ky1lBUVGrci3+Gb5n
   NpJu7QQPjR+0ycZJwxB0tjSvBgrkp78fdE9yUpJQqzLwkg5XC//2zmGJ2
   GRPix9uY/saYbswopaPyTC1VBJ30q4WJxMNfby7QgvLAK2ekjyqcggJ6n
   NbMtY/7S/GMzYy96B4MDFfT0PQtob5o1JGQR5fHNjsdaGCaNT/sgmMWlO
   lQm3HR6m6r9azdb8IYCPfDISlfza+L3SoAAIRyUOm/uFt4lwUcVB2RS2E
   qTG8vQud3HpPVesCYTLslQ9nnKnzbY9YeiGzV3maFxY/3H/QeS22KkTtA
   A==;
X-CSE-ConnectionGUID: g5eaizZuR4+IduJckUs8jw==
X-CSE-MsgGUID: w4+1feGQRcy3iYOhfPPMVQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738265"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:03 +0800
IronPort-SDR: IyxjjBjVq0ESBEYRv+LWSN/UsR6t5iij3KkaOU4MtAgDEhFk1q4zRgInBntI5r66fTG2NodMrz
 EZuOADCWf4InpwA4CaiVFpM09FkB/khVa3X+IkAKpF5S9tNF9mPgjOCnFUnCkPCkVwh7ZkUp4E
 XFrIMZHC0Brw6C8IhQVjU4aVLu1GvpwuHGMMz1cjRbcQS+CsetOB81aDP8pkgxYHkhwVMgWu4e
 AmaeoNRKHQIVKAGVhNqSm1u4XksrnrVTCsu2KMo/EfrdBfCbOMNsJxU2V3WP1ZIftvdHAKipte
 IDY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:13 -0700
IronPort-SDR: e0zR8Jg61eGL9i1fBhmIbWTW9FM4CMn0LqyDQfnL42ZXSJhoi2lr25xY7HzzVrN8K5B5QoAo2K
 cnB9tSNstd130Kw0qnZusqpO4NFgR/xwxkYJbPPhchd5vDhwSRf2ynUdziBL+WWFIyEs+zHodv
 Inngov/pQ8rDEMEMgM4CoYGC4iIcWzoFmfUkrsDjJVesLz7Qi39NtLkkYLeWWfWbcE+scpKCUf
 1Fdr8tZmeu0xwARefHb/65whGNsirXbZa44JxWueb9jnzuYow2uD2jejhulE/4uf9CUUgqHBq2
 oo8=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:02 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 06/15] nvme/rc: introduce NVMET_TRTYPES
Date: Wed, 24 Apr 2024 16:59:46 +0900
Message-ID: <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010004_501570_F1620E94 
X-CRM114-Status: GOOD (  14.86  )
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

Some of the test cases in nvme test group can be run under various nvme
target transport types. The configuration parameter nvme_trtype
specifies the transport to use. But this configuration method has two
drawbacks. Firstly, the blktests check script needs to be invoked
multiple times to cover multiple transport types. Secondly, the test
cases irrelevant to the transport types are executed exactly same
conditions in the multiple blktests runs.

To avoid the drawbacks, allow setting multiple transport types. Taking
this chance, rename the parameter from nvme_trtype to NVMET_TRTYPES to
follow the uppercase letter naming guide for environment variables.
NVMET_TRTYPES can take multiple transport types like:

    NVMET_TRTYPES="loop tcp"

Introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TRTYPES, and set nvme_trtype for each test case run.

Also introduce _NVMET_TRTYPES_is_valid() to check NVMET_TRTYPES value
before test run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 12 +++++++----
 tests/nvme/rc                  | 37 ++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..571ee04 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,12 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
-- nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Set up NVME target backends with the specified transport. Multiple transports
+  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
+  tests are repeated to cover all of the transports specified.
+  This parameter had an old name 'nvme_trtype'. The old name is still usable,
+  but not recommended.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
@@ -117,11 +121,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
 
 ```sh
 To use the siw driver:
-nvme_trtype=rdma ./check nvme/
+NVMET_TRTYPES=rdma ./check nvme/
 ./check srp/
 
 To use the rdma_rxe driver:
-use_rxe=1 nvme_trtype=rdma ./check nvme/
+use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
 use_rxe=1 ./check srp/
 ```
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1f5ff44..f35ed09 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
+_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+_NVMET_TRTYPES_is_valid() {
+	local type
+
+	for type in $NVMET_TRTYPES; do
+		case $type in
+		loop | rdma | tcp | fc)
+			;;
+		*)
+			SKIP_REASONS+=("Invalid NVMET_TRTYPE value: $type")
+			return 1
+			;;
+		esac
+	done
+	return 0
+}
+
+_set_nvme_trtype() {
+	local index=$1
+	local -a types
+
+	read -r -a types <<< "$NVMET_TRTYPES"
+
+	if [[ -z $index ]]; then
+		echo ${#types[@]}
+		return
+	fi
+
+	nvme_trtype=${types[index]}
+	COND_DESC="nvmet tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
@@ -61,9 +92,6 @@ _nvme_requires() {
 		_have_configfs
 		def_adrfam="fc"
 		;;
-	*)
-		SKIP_REASONS+=("unsupported nvme_trtype=${nvme_trtype}")
-		return 1
 	esac
 
 	if [[ -n ${nvme_adrfam} ]]; then
@@ -92,6 +120,7 @@ _nvme_requires() {
 
 group_requires() {
 	_have_root
+	_NVMET_TRTYPES_is_valid
 }
 
 group_device_requires() {
-- 
2.44.0


