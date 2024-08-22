Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA32C52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GrI6YvPwrcq19wxadBi4aL0IQgdlikB2v8gTv3oD1Yg=; b=bOCoVFGMjZtYWlHQEt65lf4ShA
	+Go54Y3kegwrGTYRma0hsRFd12QrmSv7mt4nf24VuTz7xopQXM3D94FUh/R3gexPWojad1IqUJnF6
	ciqt5ZLuSqS1hHDe2WNmNcggJdi8NIODAe12OtkjZks3lGYSmDw/0yMClD49eqOlrCsULoz2AQC52
	P4rv7/F0IPkojT+KCBsAiFzIC3o+K8WSldp5Dla8FTmD/NdnjuijRJ1JWKr12J7ULD6iguAP6+J5f
	WZJ4loizzEJwwwi0s5zPDAmpTl61fCLe0w4XXlcO5ZcW93Nk9kG0HCD+SB7eWmdJBYmCmQ2n7/9u9
	r4IuDUYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDds-0000000E7Pt-2Txm;
	Thu, 22 Aug 2024 19:38:44 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDdp-0000000E7Ox-3FUQ
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 19:38:43 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so1690452a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355520; x=1724960320; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrI6YvPwrcq19wxadBi4aL0IQgdlikB2v8gTv3oD1Yg=;
        b=BXDU73wyvlhpek0Zf1Jj5rOx3byOBjPEYZwHwNUKpYkJzPRQpT1b09GdtjQeQBCNs7
         0Ze8H77koERo8EtMTpU1TuNYgmslRHCoJEEEPP5tIVDdjPCapAF3iXhusUVyoKOC5G2p
         rsIv9e/bE4/SaGWxzWzWTxV4pTEXoQOdS5Z2HloG014NmdrsJ7SZZMo6BGezoC2Z7FP1
         lJVXASul7LkNQ5zMA8xs9XvR53ubbTYM7Gbba24L7IOztFGWMTjP/pz6klnk3jicG3VR
         5vlLt+tGuNOpzN8v0lJCVw49Xbmht5fa4+tB8/DWTE1/MRPyqYnO3ybfoiffOltK8+Zo
         YN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355520; x=1724960320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrI6YvPwrcq19wxadBi4aL0IQgdlikB2v8gTv3oD1Yg=;
        b=vJO3zXTcQ6u76QdCmmbaov7r7adfKlsHJ+WbHQhrPMdjmIpPEDlv+fs/pXMiS0jS9n
         pY+MqACHhc92ytPm77mDLyHw62UromLnN7IdR2zUVr++CwOwrJ9bm2nXXGEvX4BKQdAz
         UcF7xaAGOLRjjtXRasTWzQtFl6S5cgsHEiNlaIs0HsxzfZzm5NqFEaPO4KNkm3kH96/O
         R+Nz3xIxEOt7epSH0g4Ao80WzGYDtzl0FH9GU6ObMKZt+Z6vEKPw5NIN516g8LC8cWkA
         R8K4hjNx03ajuWfABycVNUSsufPfvafa0GNdo+A4ebFiukI/J90JM3zPYc7aZADHkZa9
         K13w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6NYdyOUU7RZwZpgCtGlRsOhgrfeb/r+iJfNnd1XMPTdF9REX9B/FoUazBqwJs0qIoMlZDK9bFX8E@lists.infradead.org
X-Gm-Message-State: AOJu0YwP4vdtwbyuKZglOxL+mZ/MPYGJYS6GdcQQMZrPdsaBF6u3VjnX
	osl8ooOAqgHFRbpX9ZhkToBFlNqqGqSolaQGP5rfBGkxjKwSrVipDQkQ2NLWtWM=
X-Google-Smtp-Source: AGHT+IGzlmYJLVymI/kyifxveNK/LfgQ+Xnjpvu8Tjcs/wSWITIV+fhUxqMJXvR2teMx2nC851dxiA==
X-Received: by 2002:a05:6402:2743:b0:5be:ec27:f304 with SMTP id 4fb4d7f45d1cf-5bf1f0dcafemr4222212a12.15.1724355519317;
        Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c04a4ca7fbsm1218344a12.67.2024.08.22.12.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Thu, 22 Aug 2024 21:38:13 +0200
Message-ID: <20240822193814.106111-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_123841_831776_905B6C64 
X-CRM114-Status: GOOD (  12.91  )
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

nvme/032 is a PCI-specific test.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/032 | 2 +-
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 5353e96..512d7ea 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -24,7 +24,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_is_nvme
+	_require_test_dev_is_nvme_pci
 }
 
 test_device() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b3b1149..e7d2ab1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_nvme_pci() {
+	if [[ ! "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ devices/pci ]]; then
+		SKIP_REASONS+=("$TEST_DEV is not a PCI NVMe device")
+		return 1
+	fi
+	return 0
+}
+
 _require_test_dev_is_nvme_no_mpath() {
 	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
 		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
-- 
2.46.0


