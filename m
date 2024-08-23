Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690EC5321D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a3Vv04OoDmGvCyY5JEu/XjI0RpiXwnV7QLorDDNwgdQ=; b=Vrm8XETvqfIGjCU45aIcVCT36U
	2sOX9iSBm356Tnr0T32FOT0pL1LL2vPHThfDQdBbS5qhBZZHGISI3Byl4TfiHgt6ERhogxwAmwmAS
	gVLur2bnWiCjhrNJCFzKVKl2o1tm4VA5ExA2f009/OpX8v30o1orS32bHPtymWb0gi2BqVSRdXDQP
	QNr0/CpplGs9i8DIrehw5kg/PEQ1eDpLaHXAqdUf6lewuRhZd4ZR3QptEHXIf/7GyPpYyYI7w2L+q
	UrJhgDDm7HLLGVNiP1TUoYpqcImyuH2BQJZgz6ISkChlWM+gaY31y1moTN+OGNvUbQEuwj1t2LkMz
	w6c8ZoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaai-00000000VaF-1P6j;
	Fri, 23 Aug 2024 20:09:00 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaaf-00000000VYC-1AuA
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 20:08:58 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso1498849a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443735; x=1725048535; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Vv04OoDmGvCyY5JEu/XjI0RpiXwnV7QLorDDNwgdQ=;
        b=fsYad8bs+66bm7mdkRcIkvsz9euMxkUI4x78I/bETw3PJt3D0EBPSdZedUTDsxZWxA
         Dr9KO5fZ4xyWEfkVgVT71wB70S5bJLYqJVeUkDKMVPMLqqiAyKPjPtHwP9zAI8Z8kYke
         /7gpp/jjOy3o35iwI3EQBM/i9xo4yytUili1cQmkePC4vYNHD7vBWAyHPuF34axWPxQo
         0qmXs9G+wQHy9T/YEft+fZ1wlGJ3ie0Mq9UKZzqJT78yEQmUJznDDH5U6fAqeg438brU
         QhtHEBtGTOe0E86R+FnP827LQhMbRucVPz2v9oxIs1zA0pplR7C0zc3Sk6+aEJkY8pr/
         Hn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443735; x=1725048535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3Vv04OoDmGvCyY5JEu/XjI0RpiXwnV7QLorDDNwgdQ=;
        b=GONsbfp4FIsRd9ms1SK4TpZFrX4ZIMO95Lb5mV45zfvKdiWAPN/+H10TVgJLDBMjjR
         VSSFij1CHXzTb10FUEKHZnDjqhgqnrhTAL11vt26CU1Pf5txxT+MlGwWKnsySgYRbccC
         q5YcI8fGCRdw6azjFq3R8qOmHFYrJZS+K5LyMaDZWn58d/ML7euKKsrQQlklqaCuRAMp
         G6HLqpK38w8dcDCYcWtE99Rkaavm2YCLpAF6+Q/3QOC0Y7smmjLhcEQbhC9DmrHJjpf+
         TfPVxdsbo6DzFS71dsDnWD7XB5mdvtg9DiqenJLtn6xJa6PuhzH1+lm2N5AtgpG4u8Pm
         WqhA==
X-Forwarded-Encrypted: i=1; AJvYcCV4oFs5cvqN7ZHP3p3AMlHLfGmFNE7EaS4NHrTyiu092x1Oy/iaXKe3MQJKTU1442zaAVIgH3RXq5PL@lists.infradead.org
X-Gm-Message-State: AOJu0YwuaA7QXeSMMRnKcLs3rw1SY9kppJB5T08yBObTpl8OOc9zi4JW
	KMRmkpr1W+4RL1yexcPQXCWOvgf8uoId8vx6SZpYwZ2uixHFeokSKVcCRuuj+yQ=
X-Google-Smtp-Source: AGHT+IGClPfTCHc7n+m5CdeWaJky+vTETP0m9NfS+oQScewpdaxHfr5SPi59VdpVqXT26F9sE1p9uw==
X-Received: by 2002:a05:6402:4312:b0:5a2:c1b1:4d3 with SMTP id 4fb4d7f45d1cf-5c0891a8227mr3088448a12.28.1724443734496;
        Fri, 23 Aug 2024 13:08:54 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c04a3c8615sm2520618a12.23.2024.08.23.13.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:54 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 1/3] blktests: nvme: skip passthru tests on multipath devices
Date: Fri, 23 Aug 2024 22:08:19 +0200
Message-ID: <20240823200822.129867-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_130857_340867_E18DF997 
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

NVMe multipath devices have no associated character device that
can be used for NVMe passtrhu. Skip them.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v2: used more expressive function name for non-multipath test (Daniel Wagner)

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
index 7a69b94..5e05175 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 239757c..154fc91 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8286178..ff217d6 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,6 +17,7 @@ requires() {
 }
 
 device_requires() {
+	_require_test_dev_is_not_nvme_multipath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index ef6c29d..442ffe7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index ef7ac59..f7ddc2d 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -12,6 +12,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/039 b/tests/nvme/039
index a0f135c..e8020a7 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -18,6 +18,10 @@ requires() {
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 # Get the last dmesg lines as many as specified. Exclude the lines to indicate
 # suppression by rate limit.
 last_dmesg()
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dedc412..5c554b6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_not_nvme_multipath() {
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


