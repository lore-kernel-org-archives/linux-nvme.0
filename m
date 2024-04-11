Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27272CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQjh629a4+s74hC/OFexwwhMfABwnDaZeJ5TUTH1nxo=; b=u8aAiCqhj56g5YCMgpCmk5udcr
	dhWPApkMZCXHdKdSm5s///mn5oE+XA7UmFdrRXDCAOMDycgY8UpzkZ6dQVWlXwdHhnZp1e3b599zL
	8X0qySBn8ptIXJAmQBA2oyVWYotAxLxOD0urG8/Sj+z6WnuMH8iXmifotG0r9mCP0qBbxJj1q8RgQ
	+eQDcFRbYH5V3dbH9MU8IOYfwh73k92j+cW2kx+KK62QEmknuJ5ZTRklRoh97SjM0WFey9347trY5
	FUkXzhpCUAK0W6oSx1aOi0kCkbRD/mZxyxAX0lxIe1SaXuRxatleAXdEHo6A2z6IOC5e3P/ZuMlh5
	cUwT/OhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMI-0000000Bfca-1ecr;
	Thu, 11 Apr 2024 11:12:46 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusM9-0000000BfVA-3AiF
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833957; x=1744369957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oT1EVAZJnb4NrCk2dPNj7oAwzDeLFZ2N2iueMe6JpfU=;
  b=fBmut+BXW9/GM7jsEqfSjJ1h9XLsomSYlZQ47m8hKiWlYJu15h5MOaCN
   yF+sD2xt6bmw2+53Or4GTePLkxssebbkMvwd5Ep8pE6hAtH3nA2JlNryq
   Mpn7yiWQ/cC04cWZfYCOYHj65v7Ao2LfRcxcuWRDDHMmifJNVntyU4Kvq
   EP9Tp0eNg/ebdYsfdPqEvDvXvIjQesBAoti7KQ5IvQaf5FtnPJ7fsiajN
   brg4e8bppr3oNmrvphA8zS4seLGA/srNBWYHxKM+jo5ExqSwWefIxiwPO
   KXyof/ydMP2+ZT0narpRao+sqeT9U/SA1pD6M3MijDLyokun9zTRKlInH
   Q==;
X-CSE-ConnectionGUID: ccDw+eQgTsGr3wu3QXabsA==
X-CSE-MsgGUID: 0chgI1deR1GtdEZ4Mzy8yg==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13226489"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:35 +0800
IronPort-SDR: SpPs2089zISaalp842Zn/j2S4hSWKMnt1rY6Du6cxhl7MkiZBRl05muE4fSkQhLimrx3f5+zDA
 498ey+F9H2dA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:21 -0700
IronPort-SDR: bGUrxeWPs8AWgdiANTGQ3QrQgvAC6b12cva/q/4Cv2N4RHhLlS26xLEn1TIk2m1QF3fVQInAjQ
 JsK/kzVItxKg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Date: Thu, 11 Apr 2024 20:12:22 +0900
Message-ID: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041237_866280_3BD8B260 
X-CRM114-Status: GOOD (  13.05  )
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

To avoid the drawbacks, introduce new configuration parameter
NVMET_TR_TYPES. This is an array, and multiple transport types can
be set like:

    NVMET_TR_TYPES=(loop tcp)

Also introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TR_TYPES, and set nvme_trtype for each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  6 +++++-
 tests/nvme/rc                  | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..ede3a81 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,12 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
+- NVMET_TR_TYPES (array)
+  Set up NVME target backends with the specified transport.
+  Valid elements are 'loop', 'tcp', 'rdma' and 'fc'. Default value is '(loop)'.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+  Run the tests with the given transport. This parameter is still usable but
+  replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1f5ff44..df6bf77 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,38 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+# Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
+# If neither is configured, set the default value.
+first_call=${first_call:-1}
+if ((first_call)); then
+	if [[ -n $nvme_trtype ]]; then
+		if [[ -n $NVMET_TR_TYPES ]]; then
+			echo "Both nvme_trtype and NVMET_TR_TYPES are specified"
+			exit 1
+		fi
+		NVMET_TR_TYPES=("$nvme_trtype")
+	elif [[ -z ${NVMET_TR_TYPES[*]} ]]; then
+		nvme_trtype="loop"
+		NVMET_TR_TYPES=("$nvme_trtype")
+	fi
+	first_call=0
+fi
+
+_set_nvme_trtype() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo ${#NVMET_TR_TYPES[@]}
+		return
+	fi
+
+	nvme_trtype=${NVMET_TR_TYPES[index]}
+	COND_DESC="nvmet tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0


