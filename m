Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3A2CCFA18
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Nov 2025 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDlym4E47nHmf72D9TAcgTMeuiY8lX4btOrhkJ8Nb8Q=; b=rsB7FHt8imTG4unFqEY4eK37db
	Idc6FMVbCqHQdIB7henBTDSi47qjPueMn7v3mAd5PXtOYWSpUJTAJmk7Ey71krcXCZof7th7QznTh
	rGAJBM4nAy8oVaqOUF07tQbt86lF4RGbI/YfpBbCrXTd+XUe/V1KyjcBeb78BZt44JPQakj4RSYCH
	2FryQ2dFVg+vBpqypMPVspIfCl/alEbw7lFO6QgLnbofJqiDTL/n82BZVtrb1rDY7an3mmnlOZt3q
	IvtRjApdBj1lSpYuVb9R3EmdBZ9Z1F1bJaChvv328jOGj+SbYoi8tCXuIEm5ARtKn3buC+40SixJr
	fgJhduIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHfkQ-000000030Yp-3Zwk;
	Sat, 08 Nov 2025 10:00:42 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHfkO-000000030Xe-1bw0
	for linux-nvme@lists.infradead.org;
	Sat, 08 Nov 2025 10:00:42 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-793021f348fso1108193b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 08 Nov 2025 02:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762596039; x=1763200839; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDlym4E47nHmf72D9TAcgTMeuiY8lX4btOrhkJ8Nb8Q=;
        b=P1LqGS6cANitt1hl8aGMVYbxJWyjAQ0XLqsGVcm3xrqx+DTrHIIC9rPqhys3Wn/JIA
         qL0998SbGv2gAcdUw6SdUhar8tS94x+XoFHlaq/yMUezgPwpmavK7OJDTNovfmUaO3qJ
         qQf+k4iGWzOEMmesxJOWcn4ssgCjHLJIO1C/dEUgzWCjzmno36OMm2nzqYmaOPS5GYqS
         ctQO6DJbnUyEJsSXq4BbaqtzgNeiPP3LiP1CycJF9bdNQVhZEesC9Nk1J2yOpnpdJ33H
         YaAdYzfDJwhFwPUm2nuqIuINSPhsh7g7eQ/7r+qe7NYanxAu1tW2i0CMJyzKnjHSdvCD
         f3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596039; x=1763200839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JDlym4E47nHmf72D9TAcgTMeuiY8lX4btOrhkJ8Nb8Q=;
        b=LHIs6eU5QrDaPaW0gjzRSq0W+Zr3QpxJmsUItYeek6r3Ci0TBqThZqMKpr8qlzv4mQ
         H4xdvseaWzjW64Rhw/3WLi00a5voE5n/aUh+i+yRhlLkNbdNtirRmqqI6oX4SwVWrXHV
         8bueQ2IytLTxW3qx4pTti53LIVf5XT7lO8Uc4Fp8LBmCROimYun8Nmmk6YRTxFeuny+y
         Q4TxQ4zKr3+ba8EchFpLwbvNF0t2EtoyRkR/YWzxt1JaVNcg+oRJXA6zIsY3wqUOR361
         BQW0Xpt/wt4lFWunIineBYSfO5iMUuDd99z8rWqeodjQd5sYQawNdfRx87Zl0ZskEKXU
         9oIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/5havsRL5B9vRagfE7K9DF1GTXQOhCXKEjv7n8aKRQbgdfP4z7212hKY5XB3e+L16muv2R6/Mub5@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7lduF8Qze35Mm91hcAN1hlRo2FLHqM1bXac17zDjZLpJLkfi6
	NR3UIYSCBlogHx/MQ6rPKyVNHI7whuvqhX5Lg52ZwYxsFQPIMR7NMF9p
X-Gm-Gg: ASbGncu7Ga+KWCb2M/9WbkGc/uGYNgP6f0IrsyCycLnO6Ulk3Qe5RwzDnBGECUJJJQT
	FbsocWMzN92sv7zfyTm9V6d8wVx5HwI3cABHxVnSMlwsogDFabONWjinc+CxBzDxSfm3mw5xLRP
	WSM+dHkCwWm/X9HTTFIZ3QuagckkGx1kCjhBlmY2wptFVtToASQHDZQsVWByi1ZqyISTilVNGuc
	OHEvdSVMqoaSN2tOwdtxaSGKozUCtlDI/s0afmQhkJjwgFT3OduMvc9aX+V38b1saurRSaWwStz
	W3/pdgg2QEd/+ugaeKU9S+iGKI3F7fMNGBRT66O27WqFdffQXAwa73BMWTnRfYVf7JgJP13wadU
	ikj0iu5gUiAJXtmS1JZtqz2mwPGskYHjpHTX2DDztl+FN33MtXDh3G1OurRFlX8Xs7EBMlK8vtk
	fCA/Of+fltuJiS4C2HOqYnP63nKUxJ8We+RjDOopGH+wzz2VWGHtDirspI/A==
X-Google-Smtp-Source: AGHT+IESr4XaESE49/E7bLBplJ8hskZEJU18QFSxGMQShkt+7RBImDuO4PCHfUM0Kg7sbEkDUSlBvg==
X-Received: by 2002:a05:6a20:244a:b0:351:fbe0:986c with SMTP id adf61e73a8af0-353a13a6733mr2792811637.2.1762596039289;
        Sat, 08 Nov 2025 02:00:39 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm5468677b3a.65.2025.11.08.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:00:38 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com,
	wagi@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktests 2/2] nvme: convert tests to use _have_kernel_options
Date: Sat,  8 Nov 2025 02:00:34 -0800
Message-Id: <20251108100034.82125-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
References: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_020041_031220_8B8EDFD5 
X-CRM114-Status: UNSURE (   8.64  )
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

Convert multiple _have_kernel_option calls in nvme tests to use the new
_have_kernel_options helper function for more concise code.

Modified tests:
nvme/039: FAULT_INJECTION, FAULT_INJECTION_DEBUG_FS
nvme/041: NVME_AUTH, NVME_TARGET_AUTH
nvme/042: NVME_AUTH, NVME_TARGET_AUTH
nvme/043: NVME_AUTH, NVME_TARGET_AUTH
nvme/044: NVME_AUTH, NVME_TARGET_AUTH
nvme/045: NVME_AUTH, NVME_TARGET_AUTH
nvme/050: FAIL_IO_TIMEOUT, FAULT_INJECTION_DEBUG_FS
nvme/062: NVME_TCP_TLS, NVME_TARGET_TCP_TLS
nvme/063: NVME_AUTH, NVME_TCP_TLS, NVME_TARGET_AUTH, NVME_TARGET_TCP_TLS

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 tests/nvme/039 | 3 +--
 tests/nvme/041 | 3 +--
 tests/nvme/042 | 3 +--
 tests/nvme/043 | 3 +--
 tests/nvme/044 | 3 +--
 tests/nvme/045 | 3 +--
 tests/nvme/050 | 3 +--
 tests/nvme/062 | 3 +--
 tests/nvme/063 | 6 ++----
 9 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index ab58f3b..98e5d28 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -14,8 +14,7 @@ QUICK=1
 
 requires() {
 	_have_program nvme
-	_have_kernel_option FAULT_INJECTION
-	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
 }
 
 device_requires() {
diff --git a/tests/nvme/041 b/tests/nvme/041
index 6855a47..8f908c5 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/042 b/tests/nvme/042
index 17d8a73..34d6684 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/043 b/tests/nvme/043
index 7f9e67e..616f7e7 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/044 b/tests/nvme/044
index 1352910..4727dbf 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/045 b/tests/nvme/045
index 4dd0f94..bf38824 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -13,8 +13,7 @@ requires() {
 	_nvme_requires
 	_have_fio
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/050 b/tests/nvme/050
index ba55c6e..91f3564 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -16,8 +16,7 @@ nvme_trtype=pci
 requires() {
 	_have_fio
 	_nvme_requires
-	_have_kernel_option FAIL_IO_TIMEOUT
-	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_options FAIL_IO_TIMEOUT FAULT_INJECTION_DEBUG_FS
 }
 
 test_device() {
diff --git a/tests/nvme/062 b/tests/nvme/062
index 7c88719..19275f8 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_TCP_TLS
-	_have_kernel_option NVME_TARGET_TCP_TLS
+	_have_kernel_options NVME_TCP_TLS NVME_TARGET_TCP_TLS
 	_require_kernel_nvme_fabrics_feature tls
 	_require_nvme_trtype tcp
 	_require_nvme_cli_tls
diff --git a/tests/nvme/063 b/tests/nvme/063
index 5bfe8be..bded9a3 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -12,10 +12,8 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TCP_TLS
-	_have_kernel_option NVME_TARGET_AUTH
-	_have_kernel_option NVME_TARGET_TCP_TLS
+	_have_kernel_options NVME_AUTH NVME_TCP_TLS NVME_TARGET_AUTH \
+		NVME_TARGET_TCP_TLS
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_kernel_nvme_fabrics_feature concat
 	_require_nvme_trtype tcp
-- 
2.40.0


