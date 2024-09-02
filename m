Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0155CD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=; b=Vr9ZRDIDvs3+1bNfdL+7fWj1ce
	yw5zyyhcDb13PAmkYJTFJWszgnidinQW+spiZGQiSwnUiUxmLte1go4kX2tZW8NKPEVw0ohGk71kI
	pMhpaxbFpI3B7xbqn8WIgjSSnZC5nqJUBW1UKvqOWan3SawBefrSd7s/v2l4mYS3wunIvpxYDtr6D
	oBd4D6UDbffb3C65fUdmpfji+e/axqD0zn5vsM7z9etsW3WWjPCYPetLvC53a/V0slwxn0VKHBtL+
	IgJ9ZtjNlTq0mtrpGCezNmFJeSvZcu5ByOGz8SbQ9hQj5KswM2jTp1tEkpuwq4bRwDuDiHMh8bMEi
	3LlrPuSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82H-0000000Ef2e-1kvI;
	Mon, 02 Sep 2024 14:28:05 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82D-0000000Eezh-3i5B
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 14:28:03 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a868d7f92feso480722166b.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287279; x=1725892079; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=IMWvVsWZjVL30EZffdf9x4cfnRjjzXCJMMtrA0gBfTJk/Wq6TCYzLrZJgL3btD8HpL
         Zpg2OKOy+ynW9PVQ7q+XQ11OGgFDxZDFGi6mBQdXdcyGD+TL/sIZvb3uNQzuWG+VHDrU
         cdwyEKYEGhbVKu/mo5Y8hg0p7Mwhz0xW3le0xp+y+cBfDE6DFSyoBHKezEvkIvFWbyhm
         1ZSa2vNXVDfTI5P+wDvAwUghYNM1C7MU06pvqOjgzcuYurmBChIl9Gs2jdci0OQj6+u7
         RsiIgXaMw8lrkSLAN/Sz9tpFKuNg2fCeyDZ2MLaGR8HDYhdKMf8igMupA/iizSoz5ygi
         sgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287279; x=1725892079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=nXlGnC92nxD/FFFPIXxWnQUkJMfoxaGPs/4kvm+n1wEvTZ6ljw3JGeJaljqAzrO4SP
         PAhp0LGxOeMOhAvSOvQeLctuFuOAyrMp8n4cU1E+xWW+1ue3M4SOGFcFPFvCxweJ9Zo0
         N6Bi4IqsKafD7PJdHtmlm5Q8Deq+l8gcZMx3aQxUw4YD2iGcpI6HC1aSFjnF4Aglr4Y4
         m371NdUpecG5tJ4dpk6uLJZc4AqJ11SEpDR9Rvhk0JHYDi1xOMhKH5xBhaYPOA6WYr3A
         5HCGFAvJjYV7zpAR8XVoBKgg4pkTKXNlHvGb+FWn4PlMwONf2mOb3EjIka7MyX1xOJYr
         9kPg==
X-Forwarded-Encrypted: i=1; AJvYcCWLLgPWyUfyAPP9moZHvqjPVze/y43fTOY9/91dvBKQUsAUhytgGPEgnsi3pNrNQIxaMXw0us4erkte@lists.infradead.org
X-Gm-Message-State: AOJu0Yyui+qqArXPq5ccwPLHHe7QwwM2O5tHH/ngS7XcQkPMatX+XVm2
	r0UXFEGAqNRvB277mQehSwgZ9v9GUwvqKmnGeWcKHyRaJCPgdsb7XU2mXNoC9w8=
X-Google-Smtp-Source: AGHT+IFwU1bw/XpVW9MjXzWxGVdxxDsb7XOeZDUlCoaSOFEdDqvAv7ft1RhGTlzuaVlVoB1lmeR00A==
X-Received: by 2002:a17:907:da2:b0:a7d:e857:1490 with SMTP id a640c23a62f3a-a897f8d51dcmr1054688466b.37.1725287278630;
        Mon, 02 Sep 2024 07:27:58 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989022a69sm562225966b.87.2024.09.02.07.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:27:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] blktests: nvme/{033-037,039}: skip passthru tests on multipath devices
Date: Mon,  2 Sep 2024 16:27:45 +0200
Message-ID: <20240902142748.65779-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_072801_945792_F4E3F5D2 
X-CRM114-Status: GOOD (  13.00  )
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


