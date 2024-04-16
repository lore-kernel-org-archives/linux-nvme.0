Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C2EC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIidboVkDKZLHL+latroegJ3GXUnj/EJZSx5HN1Pyr0=; b=fzl/LwL9iEFWaSEz3N/P9/FxeC
	ByQgBTQxL6zmQyho2vhY/kDEOtP7XAs5QNOC0uiwARAzIWKkXrdoHlDdjF3GdYDlZAfpOPIhPUx/V
	xGNLSz1XOYW+S069mN1eqsz9456dSiz+vvzdm+m9b/SbskaafXVCfViXPatjAQsiquS8R+lH42p95
	afIKFbiHbXmeRuEt9Usoycutryo+wbSUERA7SeWHwgaPL963dm5hkEhFwRdjmhZCKSqjuLFH+aS4n
	6Nk02OtjIbrvfwv3zUH4Tg4Krby3zXlBwYLd9h9iHuOGWvh8AaAVH7sQTZ0ixjI9rd2RP11L0UYVS
	cPirg/9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg72-0000000Bnlk-3RfD;
	Tue, 16 Apr 2024 10:32:28 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6p-0000000BnZd-0A8c
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263534; x=1744799534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HncKKmC+QVZ0Aq+UWgdlyuRlINtlt7Qu9LbWVThxhGE=;
  b=eLhAXxLPldPRcYqju/owAiU98OXbQjsQDLScmJRv/TghBiTTz1XjFOHU
   ZLSTMxLWD0vyq145gyx//Q+e0W0p27zVM1jJAiyCFPamriccK7l6LLFOJ
   e7nxphceB0zz2fdE7FXknjj1OOk/OJ9GV9Hr9aKdT0Lh7J6Fz9OPfosLi
   +a9gSoFSBnr5QB68E5CjKhiGDTnnshnA84rs5PC7QfsVlNMNgjnCJzOOF
   GlZPnl9VplkY3xz7G1dN5v6NMKHbeng4puWvztpUTb6TAHJg6YpxlMheS
   sPOBSJzT5vHYvrwT7CvZGEX+ewdp9+42Q6lpeNLw/VsudXQ7BP4RcQEEG
   A==;
X-CSE-ConnectionGUID: 0BVSWX+wSX+iriwLzzwZ4w==
X-CSE-MsgGUID: jQRqxUrFRdWVyt/TqQZj2g==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796902"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:13 +0800
IronPort-SDR: jt36+z0zOpYgNJZyyKud949dt9pfwf+aaY1+5K7DQ1vylYWBxDUlRpK3Usk4h+RaLkhCI3H/rr
 bm35bZHWfTyw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:52 -0700
IronPort-SDR: TWn9qJPK8wwIoU3pfmqgYjZgyT2caZ0FA+Uu97wqqnlxYe6AAb9VFPpzeequb7v3j8cnKcrCDB
 QT5GPF7sCcc4y6DkZ2NhXYrpYgGoZ0X7sjgZRdzF3Hu59XoshxpJcum4qvJKPia/HR+eDqs2eR
 tzLrpRQW+gdgudTtnP0WwLiEuDWNA6RcY4M1StY+khtk6QQSOjkmJIZ+oV2RsSu1poep/+fNUn
 VdpY2OpgafU7KhgNSLumFkDvHKJUivjDwyaRPD4Aw9ivVoaYA2uHzblH1AANIEzCagqbE3S396
 G44=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
Date: Tue, 16 Apr 2024 19:32:01 +0900
Message-ID: <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033215_184219_8096B78C 
X-CRM114-Status: GOOD (  13.46  )
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

To avoid the drawbacks, introduce the new configuration parameter
NVMET_TRTYPES. This parameter can take multiple transport types like:

    NVMET_TRTYPES="loop tcp"

Also introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TRTYPES, and set nvme_trtype for each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 11 ++++++++---
 tests/nvme/rc                  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..144acd1 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,13 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
+- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Set up NVME target backends with the specified transport. Multiple transports
+  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
+  tests are repeated to cover all of the transports specified.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+  Run the tests with the given transport. This parameter is still usable but
+  replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
@@ -117,11 +122,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
 
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
index 1f5ff44..34ecdde 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+# Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
+# If neither is configured, set the default value.
+first_call=${first_call:-1}
+if ((first_call)); then
+	if [[ -n $nvme_trtype ]]; then
+		if [[ -n $NVMET_TRTYPES ]]; then
+			echo "Both nvme_trtype and NVMET_TRTYPES are specified"
+			exit 1
+		fi
+		NVMET_TRTYPES="$nvme_trtype"
+	elif [[ -z $NVMET_TRTYPES ]]; then
+		nvme_trtype="loop"
+		NVMET_TRTYPES="$nvme_trtype"
+	fi
+	first_call=0
+fi
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
-- 
2.44.0


