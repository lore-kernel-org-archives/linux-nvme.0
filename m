Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CCC4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Woy6I2XvgArQlKd7ImGqbWwwF5NmLOJ8xxnqlse7eZg=; b=4tLRIZzrPHnQl8w8xMW5yRwOHb
	ZlUMw5Ry+72i9LruQ4xgJyOtvFbtGSG213PC+PXPTiYbXOzYilqlJ1SlI70UfrIKknKF+Qn7shfoD
	dp3NKOFNWgq6BuUz3k4KLigG9AmOsG9PLxVcG/AV4gPF+4LYGT6sZ4xdEc+Q5oUyIYnr1dn7OyCb4
	MMQ34PulyNoo+V7+EKfcBaMSJbG9m1+81bUUg7XZZIVWvorxUfyLy9ZfFLS211M5Q1GhtfSa0BLsy
	1LZpqmMCvvNWbxOYsQ401TmfjKv9EE8TUgjzbFJawONzxJmjq30pt2SxDbRTv8z4cg7nOVPUA+p2x
	u0QK5NzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AYG-00000001ZAd-2sId;
	Sat, 04 May 2024 08:15:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXu-00000001YnF-3YeZ
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810502; x=1746346502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPBXHvjYsktcEJAin3E7drsL+wdn5WXd98VqCO/B/8Y=;
  b=IpzTJhUw5EypmFJ5l7Pjbq8Hbh4fY08DXppN/kenk9eIOGxGxAtj68Qg
   CPKy+yjJU/BjqFCjDJJkAm5+3JIacowbw+w3ddfyA4M+iECzxCNqxcODd
   M236xMHj/2u3t4npH2RyXPdxMvSLKm/uAiQMorNgc4t3PhHhqVKLzVUgq
   tmzMXyDfHF1VjHhQmukguc5l/OO0GGP/WQgdFrY9MReNJsErXIvx9K5K3
   kXd/At0Tu376flw/LlsMM2L04Mqg9btuVqHjDg+RZSRF71ixnVWqMc/6l
   v+RxCq93T7TLfrAHF7YkHGFNsUddSHkqxv5t4WAi00ou3ZuB+ugynzN6l
   A==;
X-CSE-ConnectionGUID: 2dSeupXxTim8yAkh8JmGOw==
X-CSE-MsgGUID: rXQCAa69RbCViMZEpEIUrA==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540321"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:02 +0800
IronPort-SDR: qqiRG+UXI2RS4Uml1jgIeDCeqg2hAKovRHhRXH7JtjtVl0N3/EImP1J78VBODimtj6mEbls357
 SPHRovMIgCBTEPORK6b9U37XG4uJuPN0WYoo8figHZ/gJgdYUzQyYem1VrWWjtb/QSCmymEP0/
 GuIu90U3nXeRyVd3Q2EyyBsB6A+CVdJe/id4JM7YoiT9Hmgcmhzdo4kDdhZo5FH+nI50syd15d
 ESSTLTxVgqIT6F/4ageatOQwHQ3CpRkw5lXd1tPTsFRCAsRc+2fPYCd4lD38nqtMVJ9IXtZUrY
 vvQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:00 -0700
IronPort-SDR: Lt8Abm8RaM8kghAclX4IO3o1TbXo/mNXltdINu6ndonA/DnTn2eIzAfTsU5tZ5GYX+HDYqtkBQ
 n+SxtizaBtl0PoY/t/MjT0WsVigpxVr4IfJDxeaCqnPZRXsSIpNxB1SpWAe+1dEFjMIAhmZi+M
 UdkAhpy4QkC6pv4inC1/0u6znLqKvbw5U6Dfy4ApRlp3ufLphU+QvjwHEEAroXBjxqemsAY4JL
 SYWWq6uKA87BNQCXL8Jbn7KVUxmOD1V8CkfcWdF61BFbbZLUTRc9Nox2Nn5iv6dYdRWJDHaZ2D
 GGg=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 10/17] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Sat,  4 May 2024 17:14:41 +0900
Message-ID: <20240504081448.1107562-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011503_061048_C21C93B1 
X-CRM114-Status: GOOD (  16.73  )
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

Some of the test cases in nvme test group do the exact same test for two
blkdev types: device type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, it is required to control which
condition to run the test.
    
To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
parameter specifies which blkdev type to setup for the tests. It can
take one of the blkdev types. Or it can take both types, which is the
default. When both types are specified, the test cases are repeated
twice to cover the types.
    
Also add the helper function _set_nvmet_blkdev_type(). It sets up
nvmet_blkdev_type variable for each test case run from
NVMET_BLKDEV_TYPES.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 571ee04..64aff7c 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,11 @@ The NVMe tests can be additionally parameterized via environment variables.
   tests are repeated to cover all of the transports specified.
   This parameter had an old name 'nvme_trtype'. The old name is still usable,
   but not recommended.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec54609..27d35e9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -22,6 +22,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -51,7 +52,22 @@ _set_nvme_trtype() {
 	fi
 
 	nvme_trtype=${types[index]}
-	COND_DESC="nvmet tr=${nvme_trtype}"
+	COND_DESC="tr=${nvme_trtype}"
+}
+
+_set_nvmet_blkdev_type() {
+	local index=$1
+	local -a types
+
+	read -r -a types <<< "$NVMET_BLKDEV_TYPES"
+
+	if [[ -z $index ]]; then
+		echo ${#types[@]}
+		return
+	fi
+
+	nvmet_blkdev_type=${types[index]}
+	COND_DESC="bd=${nvmet_blkdev_type}"
 }
 
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
-- 
2.44.0


