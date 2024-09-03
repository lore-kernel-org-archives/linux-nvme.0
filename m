Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F02ACD379F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=; b=4harnzXYJSkefxUGisHysNlcAn
	BCK5gtC8PixYdeJpjn/TYT7oRqeGEKde25MAmibVgBgT8DSdDbvbq/3y3nlrA/DXr35F0zEO3qCI/
	u76G7AWw8BP/b2Gb4FAQSRTbGy8jhx9q/+NVFmbzDN16783UPOpMV0Db8HexqnunCEohyLgjhGvvV
	/fFkr/rB5YhOHh3aH4PNnw0719Y8oG/qU2GcOfXZSC4icnclBza0UwBEaByzbomPPwNTLXeojyu17
	3cBtlTSZTnvfL9seG1aj64doqsehjT/NF2h2ulZqHng9bjzc+PGmOdn/VWkOquoRQ5lF4Ed9WP+D/
	R3ruKlUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPj-0000000170X-34ca;
	Tue, 03 Sep 2024 16:29:55 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPg-000000016yG-1SrB
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 16:29:53 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a86a37208b2so645151766b.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380990; x=1725985790; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=IpqpjYc6xKOaGVbTqhXLqWYX7a2VF2OW1AWi70Kcdt4lN+H0YwFGQhxCpQEPErtNut
         ta7syEnrmRytvJ78FdWQ0x28VwR5OB+89UmV4AAqmbVAW5uj5u9ck2ff5ZUCc5ISUM1M
         DPd4Tu4ru/VI320k6yzUztLYMZI0GAxmzJy0zVFQsem7aqEOznk+6INUv/O6xAfurqeb
         8fnL00OGnWuGmA4Xq8XaTwNz2r0zmtvOwx+3k6tJHMsDh0Uqml6z7hjlXURk15q+/Z0c
         WGvo7SnnlB7D0BhSFLp1UvlcmIZ+fuLVBnjuaOyxCbmaTqjC5HakvxfCB9n/wMbse74M
         PBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380990; x=1725985790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=EY7wEe6k345UKe2PSYA2qKSyeQTicg+24ssvA65UfLzKazdvCLXeUj6T24JGM0zLdU
         GPTb5EovPVkS0NfiSwT6NooiCP/1uJTyvuZ9q89ClXxGm1l3drwlax6lt1WCvlCcUMzJ
         MPuEPeiTtgX4EM106x+fbykqtbIwgwgJs8gxp9jTl//dHvw68t7tq5RWhVdouV4lIJMB
         OtsoMCm1qDueOlfzG4MLMm9MyIn8K3klpYJ2D/Ly/Unh++RQcIfVFlOz3QhaX7qKjeNW
         WIEhm6BOFnPRc75ZIU5F4g6ePHUa8X6RJTRQYc5/US4B8KC5Odg5f2S0OarhO5crKnBG
         zAzw==
X-Forwarded-Encrypted: i=1; AJvYcCW2E6kR460oeVl5qUmt1WXBovNYCER8RMXGd/SeJrfq+nrm4UsuVks71BtPHKKVDriPubBLU4VG6/sr@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp70ZCbIMNnXk26+tDSmtQcQQJEX92VX1d7YXWNV5ts9xEnf2x
	6/AzSp71WcmK4wuSbY6dgSL7BcEx7JnimTWQNhyA+zfAMIqz04LgJ/6CM0B92aU=
X-Google-Smtp-Source: AGHT+IH7yYKLPVeQag7fEGv6/SszKPesauA8u1JjO4CePX3FkM/7vdP8YQ5ERcROMsGS34x+/fJVDw==
X-Received: by 2002:a17:907:72d3:b0:a88:a48d:2b9a with SMTP id a640c23a62f3a-a897fa74459mr1319001366b.52.1725380989485;
        Tue, 03 Sep 2024 09:29:49 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a898922259esm701051966b.209.2024.09.03.09.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:49 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 1/3] blktests: nvme/{033-037,039}: skip passthru tests on multipath devices
Date: Tue,  3 Sep 2024 18:29:28 +0200
Message-ID: <20240903162930.165018-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_092952_394676_DABCA2B8 
X-CRM114-Status: GOOD (  12.78  )
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
v3: improve patch subject (Shinichiro Kawasaki)
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


