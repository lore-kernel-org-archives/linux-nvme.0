Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC74C4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5lqlzQnTmXf8GExyc/KWwEdwzw+MRjqV5LJQ+UH4cg=; b=iYkqcDvx1WmDpI6gb+ThKrdDi7
	RGhaPmLK0jceWgRM2FQ90NOPPBbjLxJoMbuQJWuSHJLb2h0GTd8Bf7178WyAotPI/KH2fmM6Fu/TR
	4KbQdDJztArQWPZFHM24kSt8D8UHMM1wVMdx2NB6s2AQsDJ6X9zv7tg6sgCJSQpmOKDIOD+vZXmL7
	Xzygehd+PAU37LJ95S/Yjc9EFKnN2mW+hriCfSm6WPv1iZVDT/aT09ScAkB3QXRRg7RW5OgRZNZcO
	oQAQTGrMr8ViSzB1/cUddNNDRPFOTQiLwrPrYeimH/jaV1PHVQkhWBsVXfP8PR/SM8kVx+Z1J3vY6
	tFQF2RsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AYL-00000001ZFu-122E;
	Sat, 04 May 2024 08:15:29 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXw-00000001YrU-0Mv5
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810503; x=1746346503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sLUU92HlqI7uQ9oXxDhbvXA5yCtDZlU1fVCBorHb+ik=;
  b=jaxa/DArWbyPjwrMpH50gjHUsn2LitpP3SRHK3Bn2opxWdGtVNecG4ra
   YUhOgDFY1uADaElEQpW3/jhBzKBvI4Y6z+TBP9lJswfwa00WEmehosESQ
   63pwwZZxAoz2Y8Uyd5uKExqBrahFtm6TWhhd4OtNhl0SDkm2a9eiZ/dbm
   qdbCfETd4DunWjDAWCuRNOfWEvXw3Ap/gVH+Czr8UCvDPEthcjjQo/6ri
   rvH9b5VoTQFaOTINGEhZ1o8uUBdu8amkSQeATF4oXbF6p6Tbh2SMtQ30+
   xAqaJf5j0NjsG0qnstWkHZdCnmpRLOmk0iF7Jbw/RKKEqxI5w410c3ocK
   Q==;
X-CSE-ConnectionGUID: xEOdZQMFSwCnfu0FUepLLA==
X-CSE-MsgGUID: a4ihL7AdRY2MCzGooehMjQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540325"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:03 +0800
IronPort-SDR: hw0it0nuQvkmcCaOrf66v48BJxS0xtTrN3CUaPR5Ju/THbnhMARFEz+nj/KTGqOnGm1P2INxIv
 aL/cg8loXRk8v7DCtME4/6Gho9GYm7WupbRy4oVcVW+GjG4/C5B2BWJ0/nBaEJbf/Yh3jSKPC+
 xEjWaVNJiPb1lu84cXxIIDDd+5oVZz5a9MKq+MqBqxAcwCtSwnc6oUD+3+ow6Ma/Yh6+mcvWm5
 dw6FhymCSR1d4unkWQPh0zH1SRRjWb3hpWAzQHcAbcZhIsG9IPzK66SoBzXG1/cmCkHgly3kRB
 KXg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:01 -0700
IronPort-SDR: 9sW6vw7z19eWa6DlnzZJqTeSMOfGkP4W/b5GKw4MhDVcdXUjdomeC2o1Fcjs3cVGac7RPWGy8n
 cxbZKOXFoW9p5E+7qvndkDLZ3fCkeczVfceHusoTGuE8eg08/hrWC/pieVJuCnWIjDVieS7iI7
 0GhK/6irt8mD6Ogb22sCGAeZlGDHlAB5XWkLSacM7LNWp60EWG2//7tkuwk1aseWSuAg4AlIIK
 Std6EXE5KewQXArRigyvfQQY77pq0m6AEsOaGG6YZW2LNGaUBtSd1D8bvziFgIJP3S8m+9Vkga
 YNI=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:02 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 11/17] nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
Date: Sat,  4 May 2024 17:14:42 +0900
Message-ID: <20240504081448.1107562-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011504_362179_32A7DBD0 
X-CRM114-Status: UNSURE (   9.94  )
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

Add set_conditions() hook and call _set_nvme_trtype() so that the test
cases are repeated for NMVET_TRTYPES.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/002 | 4 ++++
 tests/nvme/003 | 4 ++++
 tests/nvme/004 | 4 ++++
 tests/nvme/005 | 4 ++++
 tests/nvme/006 | 4 ++++
 tests/nvme/007 | 4 ++++
 tests/nvme/008 | 4 ++++
 tests/nvme/009 | 4 ++++
 tests/nvme/010 | 4 ++++
 tests/nvme/011 | 4 ++++
 tests/nvme/012 | 4 ++++
 tests/nvme/013 | 4 ++++
 tests/nvme/014 | 4 ++++
 tests/nvme/015 | 4 ++++
 tests/nvme/016 | 4 ++++
 tests/nvme/017 | 4 ++++
 tests/nvme/018 | 4 ++++
 tests/nvme/019 | 4 ++++
 tests/nvme/020 | 4 ++++
 tests/nvme/021 | 4 ++++
 tests/nvme/022 | 4 ++++
 tests/nvme/023 | 4 ++++
 tests/nvme/024 | 4 ++++
 tests/nvme/025 | 4 ++++
 tests/nvme/026 | 4 ++++
 tests/nvme/027 | 4 ++++
 tests/nvme/028 | 4 ++++
 tests/nvme/029 | 4 ++++
 tests/nvme/030 | 4 ++++
 tests/nvme/031 | 4 ++++
 tests/nvme/033 | 4 ++++
 tests/nvme/034 | 4 ++++
 tests/nvme/035 | 4 ++++
 tests/nvme/036 | 4 ++++
 tests/nvme/037 | 4 ++++
 tests/nvme/038 | 4 ++++
 tests/nvme/040 | 4 ++++
 tests/nvme/041 | 3 +++
 tests/nvme/042 | 3 +++
 tests/nvme/043 | 3 +++
 tests/nvme/044 | 3 +++
 tests/nvme/045 | 3 +++
 tests/nvme/047 | 4 ++++
 tests/nvme/048 | 4 ++++
 44 files changed, 171 insertions(+)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 6b84848..f613c78 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_loop
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/003 b/tests/nvme/003
index bb96d1d..36c0753 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -17,6 +17,10 @@ requires() {
 	_have_writeable_kmsg
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/004 b/tests/nvme/004
index b751746..a6b4949 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -17,6 +17,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index f17174d..66c12fd 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -16,6 +16,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index ccf752c..ff0a9eb 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/007 b/tests/nvme/007
index b92f5d9..cb2637e 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -14,6 +14,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index a5d0681..1877d8a 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index a1655d4..d7b1307 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -14,6 +14,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 6feb391..34914a7 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 4810459..bd29129 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 64cb6ec..e06bf8d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -19,6 +19,10 @@ requires() {
 	_require_nvme_test_img_size 350m
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 24fc910..91da498 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -18,6 +18,10 @@ requires() {
 	_require_nvme_test_img_size 350m
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 839b91f..ff0ebfb 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index f0621da..b5ec10c 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 908abbd..a65cffd 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -13,6 +13,10 @@ requires() {
 	_require_nvme_trtype_is_loop
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index c8d9b32..9410cdc 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -13,6 +13,10 @@ requires() {
 	_require_nvme_trtype_is_loop
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index b8c1635..5b0f57b 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -16,6 +16,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 1cd5378..31020d9 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 0364c4e..4993e36 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -14,6 +14,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 7ee1f07..270d90e 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 7ce33dd..adaa765 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index d8f17ae..da99406 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index a512194..cab1818 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 3f9a615..224492b 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 28fd151..6ee6a51 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 053fd58..a63e42b 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 9f4a905..65c52a9 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 559c0b4..10acc58 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -16,6 +16,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test_user_io()
 {
 	local disk="$1"
diff --git a/tests/nvme/030 b/tests/nvme/030
index 9251e17..b1ed8bc 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -15,6 +15,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 0bf823d..b98630a 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -23,6 +23,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/033 b/tests/nvme/033
index 70a73b8..7a69b94 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 nvme_info() {
 	local ns=$1
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 409324a..522ffe3 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index ecf6b72..cfca5fd 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -20,6 +20,10 @@ device_requires() {
 	_require_test_dev_size "${nvme_img_size}"
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index 36ea792..ef6c29d 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index 66d6656..ef7ac59 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -12,6 +12,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/038 b/tests/nvme/038
index 007b5f4..8435415 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -18,6 +18,10 @@ requires() {
 	_nvme_requires
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index bb9ed5e..9536f35 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -16,6 +16,10 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index f1fa00c..aa44f04 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -19,6 +19,9 @@ requires() {
 	_require_nvme_cli_auth
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
diff --git a/tests/nvme/042 b/tests/nvme/042
index a9e79c6..70c9056 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -19,6 +19,9 @@ requires() {
 	_require_nvme_cli_auth
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
diff --git a/tests/nvme/043 b/tests/nvme/043
index 4589423..cf99865 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -20,6 +20,9 @@ requires() {
 	_have_driver dh_generic
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
diff --git a/tests/nvme/044 b/tests/nvme/044
index 8b88590..9ed46c9 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -20,6 +20,9 @@ requires() {
 	_have_driver dh_generic
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
diff --git a/tests/nvme/045 b/tests/nvme/045
index f387ead..be81316 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -21,6 +21,9 @@ requires() {
 	_have_driver dh_generic
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
diff --git a/tests/nvme/047 b/tests/nvme/047
index 9bbe84d..1ab68f8 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -17,6 +17,10 @@ requires() {
 	_have_kver 4 21
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index 0b299a9..bd41fae 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -15,6 +15,10 @@ requires() {
 	_require_min_cpus 2
 }
 
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
 nvmf_wait_for_state() {
 	local def_state_timeout=5
 	local subsys_name="$1"
-- 
2.44.0


