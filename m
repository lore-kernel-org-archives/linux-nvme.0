Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD2CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhCpLayUGOnOt0f/hABKAI5rK6v2Q7kEHEjeUTi8lwM=; b=yxFSkuyT6E4RYdUhtpIm07Kq4g
	VRPTSWIztq7rnZfUSTqSRtnfLS9tHIEn0Kx7s11vi3UEOrwgaQ4FLtUf6yZhWSJZyanu6cd5jMYjY
	Js1hVKakzSD2gZR5OI3gSKHNPlZ/wOBqtvlopXOphg5sn98sUSbZUoXjqLSSHWEBHPnbb52OZBDwp
	iIKLKK2s6avAFQm1o0gPt+OlqD88pcg6g4FabWnr4IZpEv3EH4B0VNzsG4z7hsZ7tpM7A2iILb2Mt
	N0cdBl4Ibb7yo06IDDO4e+t4mYU8OeAtW77XyTZ3BaN8eUmsFDKGH/m/W3oNUVmn1X1Auicfq2TFl
	tCObn/Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMN-0000000Bfgy-2Sjl;
	Thu, 11 Apr 2024 11:12:51 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMB-0000000BfV0-2ssQ
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833959; x=1744369959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dEVP8079QDShYaAiKf9wK3Q+gWxerIusvSgNLm1mn0=;
  b=Wb4R1sTTnVsEry7BwMrbLmKutWEloM++uhaJzmZo28XOTmswkkEE0sRW
   OYoTb5DQLPeZkGqe1W55JbUPLK3YNxvWI+PeBQMsd8SLuzWr4xiipeygt
   ZGAzXhqXvvmuTvuuU+OgKtm4wvFwnD/fRXt6AKtx6ZjLRHm0ZLtxjpgD1
   MFJspdxSQjy4quNrg+dhLNQZSDsPAgg5q6EkpV7LRw3Jv2J9hdejb6SIn
   HZd6wUM6XDE41zmJA8EIx7zTp+7tHqXkCS0DwQKaR1b1miv5PsxVJv72b
   KCBq6kugBv5IpGffSPljOU7OHdG6cQO5W2D0MoEkd6gOEM+iy3OJ5Smz6
   w==;
X-CSE-ConnectionGUID: 1/OU4/3NTdG7N2ysq7323w==
X-CSE-MsgGUID: f3F/XJrdQFCYXh+Canp/9A==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13226491"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:36 +0800
IronPort-SDR: 2aDX+QNG66E3jH/uk3DFV6R5e9CPQtYDOBVexu8bnD3OUd7NRrpTYYa9LLZrdXy6iYRJGPzuDO
 wjethFGiUq0g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:21 -0700
IronPort-SDR: RoaQMkeK6dYXYX5Q91RFE2NFWnktHdoz9Uwq9S9w8aNWtgVnSBuReyoFEjn9iXC6uQ3YCqq/5p
 DHVU8bNfZqQQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:36 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Thu, 11 Apr 2024 20:12:24 +0900
Message-ID: <20240411111228.2290407-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041239_897877_805B34F2 
X-CRM114-Status: GOOD (  13.03  )
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

Some of the test cases in nvme test group do exact same test for two
blkdev types: deice type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, still it is required to control which
condition to run the test.

To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This is an
array to hold default values (device file). Also add the helper function
_set_nvme_trtype_and_nvmet_blkdev_type(). It sets up nvmet_blkdev_type
variable for each test case run from NVMET_BLKDEV_TYPES. It also sets
nvme_trtype from NVMET_TR_TYPES.

When NVMET_BLKDEV_TYPES and NVMET_TR_TYPES are set as follows, the test
case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
is called 2 x 3 = 6 times.

  NVMET_BLKDEV_TYPES=(device file)
  NVMET_TR_TYPES=(loop rdma tcp)

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  3 +++
 tests/nvme/rc                  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ede3a81..ca11f58 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,9 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
   Run the tests with the given transport. This parameter is still usable but
   replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
+- NVMET_BLOCK_DEV_TYPES (array)
+  Set up NVME target backends with the specified block device type.
+  Valid elements are 'device' and 'file'. Default value is '(device file)'.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d51f623..c1a14a1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+[[ -z $NVMET_BLKDEV_TYPES ]] && NVMET_BLKDEV_TYPES=(device file)
 
 # Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -51,6 +52,21 @@ _set_nvme_trtype() {
 	COND_DESC="nvmet tr=${nvme_trtype}"
 }
 
+_set_nvme_trtype_and_nvmet_blkdev_type() {
+	local index=$1
+	local bd_index=$((index / ${#NVMET_TR_TYPES[@]}))
+	local tr_index=$((index % ${#NVMET_TR_TYPES[@]}))
+
+	if [[ -z $index ]]; then
+		echo $(( ${#NVMET_BLKDEV_TYPES[@]} * ${#NVMET_TR_TYPES[@]} ))
+		return
+	fi
+
+	nvmet_blkdev_type=${NVMET_BLKDEV_TYPES[bd_index]}
+	nvme_trtype=${NVMET_TR_TYPES[tr_index]}
+	COND_DESC="nvmet bd=${nvmet_blkdev_type} tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0


