Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35EDC4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAkODHh3ihFXeXOgHpzWRhgwYGF5G4H2P4ExD4DiJ2o=; b=WYX/9klzVA6cX1G1o/MNWL6csn
	MU/pCuWtR8yqetuEh17oCcxETWLgibgKyUdYM7ixNT8HpWAuNJiasvvWDprr7jQ6oXOmjtu07S45A
	FznolWFSe5klRPh/2F8aoZR6L3Y/XlRPCXx1PcJ9YJd/7TfKw8BfWgZfbt3IPACO/dO76irBsak0K
	D8J7I18vzuWwcmuAelM56Nvu+t0VsQA+Q1SKfNoPIGL8huA1sbbM9XFLEDLNNEtlJsJGeBJBHFETv
	XOL+jXTC+ZfmGa/4qLHqFHcCbpMAAyzB/1hXD/Lzbyr3HC/34DvJ+GNvqMMZQIk/guu2B8e+ziyk3
	5mjkhmDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AY6-00000001Z2H-23NK;
	Sat, 04 May 2024 08:15:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXs-00000001YnF-2mxt
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810500; x=1746346500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/S5dT+MmOcmngKIjal3kSxx82g8KSdp+1ofILTNgUo=;
  b=aDScaU6DwTE/HNeysOq7CGhT4Q5U0ubTSepED5wsj7e4xZ3p+218EMj1
   UWFCVFNCDlMKc/4gfcepSvYb9aUUt7MFEJDrio0gMVlgI9u/ITPyYivMh
   kb1G0bas8DwH55h8MpBz2mBrxEu6iox1VV2TlAcrEw/yyq8ajn+70rgeu
   e6/aIVH3PCXL166JIG+OhqHWPbwnilikW4mVNd2Zn+SoPuP5ZLsFfUr2e
   qX2xYhQ7r/rkCWZfpTa96x6uAOFo+2m57Ckr3ZUTlGENPVYsBhRn5Y4uR
   u+21ji8lETd3XHpjpfR+QjSuWIeLPbrQIo0Fcp2vXI5s0XhD3xiwvMlQv
   Q==;
X-CSE-ConnectionGUID: 3rRWUiiLTmi9GcIy1z0Pdg==
X-CSE-MsgGUID: z9cVjR94SxmmdIodT6/ZIQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540316"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:00 +0800
IronPort-SDR: 7hijC3Ecx3iWmfUEnVwShOpaLhm6nSSitz/JSCQw/6dqVtdZQN9FqxVHMwhjcy7I73zwDjub6h
 wjYlrMXIDXhEVBIeN50vTHow1tHkQsodnmNtn9nlI4OVEP0j/hhOfeSJD3kD3SymmzZQwNAlYZ
 x0hzzfpRAEc1qxZ8lCSpFvcEKpCLmqjOSj2l0pwytRGiPqDfMZV6YGoZo60TOdVMaUzgv/z+Xx
 ESHKJwGGn4dTup5iSOrCmh5Ns9v6ieD7B/cwXMchYtrLzWNJEfrkH50whqrRp1eJsDAvUlWaO4
 F4s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:58 -0700
IronPort-SDR: uuJPZ7b7RDTfsZyUkbBq8OQ/RXajTUQ6eKuSamn3sOblFhkwB0kgEOs6dgVABsdYMAorLsr/42
 IqzbRFHnFlC8SnesGTEhjAwPkDejHiWk0Mft5BiGZ0DbiyoXAVNAc1ZLm9JvghOsDi3RZ82sfZ
 E5BtFrFP9XQbAAQJ9dGVjZsIuf/Ku8DssoZh/wbYREjpJcr0XV7i5fpyDrzftO9gRwPjPkmJRr
 8W6vH4FgsKKpgAPHSPolqEhF9/lhTN6cQaa04UNJwH102zObQrdylhpOl2mprn8sIq3KGaaxKi
 oew=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 08/17] nvme/rc: introduce NVMET_TRTYPES
Date: Sat,  4 May 2024 17:14:39 +0900
Message-ID: <20240504081448.1107562-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011500_827674_48BAD1A4 
X-CRM114-Status: GOOD (  16.15  )
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
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


