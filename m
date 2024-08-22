Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF8DC52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T9cnv+MdXwy4zAHoFrkb8mhAg31ASXI3YdjEyMyWEjg=; b=GmUzdllAAxuve1TLbGW4C/ANvQ
	IzY/0Yl8MffO1Kr6SIgD8M2ekcevzFAaT2/uW/QBxERqYJTSSq2+yh6L2PanahSFeIia7KNwGfa3v
	0yhSafEk5e2rx0XMtSdNT1q5c0kTuXL+GZ0fzjxXeYeQ51oYuq2pT9JpVRfWCLxeRcCKaFlehMgfE
	qfllFR2OwxIm7w2N9suGTm3XYwH0RzUhroqSxzB8ribC8FXGK7olygJFlM0VmfvXg6ymYr/gcVCYH
	g5h+pj5roqFYGSMBqFQEEDgvVkRFcNKTBuuSkXnwX8V5Kyp4W6l2yk+KYcizLTjAN73cJV4mwauPP
	TRuiJKgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDdt-0000000E7Q5-15Kv;
	Thu, 22 Aug 2024 19:38:45 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDdp-0000000E7Ov-0UFc
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 19:38:43 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso1635642a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355518; x=1724960318; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9cnv+MdXwy4zAHoFrkb8mhAg31ASXI3YdjEyMyWEjg=;
        b=KUG+mD64YU2nrGjjaPCt+po+FJ2fUYeINd7El0ZIGOO6WtI258YQ16dL5kcg5TCNEx
         Nn7m1Rn7b10VzHFBug7xjWiobVj9g6JfU6coizmMZAXfjDEdFe3286n35T0bRoLsZTei
         L3eaLGfrb0QzlCP4OlMUu2Rj9t+AGHz96kqhmDv8AR5P4JWRFwMDI+DOCENy5etT7U6A
         uYRgXjx+2nZqUq34H+R+QXVTvOOsvpqM+e+LOJKqk5jlPnmDah0kMSHkfO1pMXM2TK+T
         lFVgoi1/8Ga+OuaIB0yGGKf20wHi8vW17W1VAtZ0wj+Y20XxWiRoWQDdFPAzu47/Wc6d
         Mk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355518; x=1724960318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9cnv+MdXwy4zAHoFrkb8mhAg31ASXI3YdjEyMyWEjg=;
        b=Lh5Ei8bnx/MbknCn80GFlJJwDFN1zw26r//eN7mWgYp6LBSGUh/9imCLRkjhNfQgvB
         56pfUr18yL6xnsIbIxW6bgSOGQWXglMunGR5/CSph5flKePF7knOjh8kaUMEKNdA+lj7
         6KJAs2hxtM680k4LKbVDdayN7wvzhLLQ/62zcldFf/byfY9JSC6jjvqKJoEITWz2yTbf
         wj9F4Mxgj1ALr3SIjmYCjfYCKXs9l2pYHmFZy9Ns44xlYOMsR99xMHU02tlTjrM/5Hdv
         1JIJb1cP58vr+d9FyfiKo7lx/cc0+CjChZS0rMV3NT5rMyjcG+lCe4kPOjblaRjxWwC3
         vo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWkp/x3aQNfvgBqrwNUlVpEBkxuqHXWiWYsCFAbbuHGBTEMVuFX2h+ShRiPJDSUvy2a6HBNwv4KGQvo@lists.infradead.org
X-Gm-Message-State: AOJu0YyWCuIalkW6UeCTEZ0xelm6TUZV1ekMEGgvn4n0oh6qeSn5xeFm
	pqjg6IVF+Gb0rMpRTecLbcO+lIMm+PhKHx+dgZJGfmkKA6jmR1yA8lq+oWp7kJ8=
X-Google-Smtp-Source: AGHT+IH9qlKGYHZCb4YNYmE00kgmI8xojuOxfpDY7bV3fdw2VD8FzFJOuPsUodin3Se8Inlu8aJP4Q==
X-Received: by 2002:a17:907:7251:b0:a86:993a:93db with SMTP id a640c23a62f3a-a86993adc45mr136738766b.39.1724355518045;
        Thu, 22 Aug 2024 12:38:38 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f2202fdsm156968666b.13.2024.08.22.12.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:37 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath devices
Date: Thu, 22 Aug 2024 21:38:12 +0200
Message-ID: <20240822193814.106111-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_123841_181545_9277DE91 
X-CRM114-Status: GOOD (  12.34  )
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

NVMe multipath devices have no associated character device that
can be used for NVMe passtrhu. Skip them.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/033 | 4 ++++
 tests/nvme/034 | 4 ++++
 tests/nvme/035 | 1 +
 tests/nvme/036 | 4 ++++
 tests/nvme/037 | 4 ++++
 tests/nvme/039 | 4 ++++
 tests/nvme/rc  | 8 ++++++++
 7 files changed, 29 insertions(+)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 7a69b94..dda0763 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 239757c..41f1542 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8286178..4357efa 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,6 +17,7 @@ requires() {
 }
 
 device_requires() {
+	_require_test_dev_is_nvme_no_mpath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index ef6c29d..3a28cb7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index ef7ac59..557d491 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -12,6 +12,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/039 b/tests/nvme/039
index a0f135c..ff8c1eb 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -18,6 +18,10 @@ requires() {
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 # Get the last dmesg lines as many as specified. Exclude the lines to indicate
 # suppression by rate limit.
 last_dmesg()
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dedc412..b3b1149 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_nvme_no_mpath() {
+	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
+		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb
-- 
2.46.0


