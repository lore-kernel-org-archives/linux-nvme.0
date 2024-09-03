Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603BACD3448
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=; b=xxH46RhVg+miLpYm/TfIx0IOcS
	TKa8NwThFa50AeIZLv62BfuKPyIAO33Fh9YqQ77mIAZ+06Ff7Oedzf7DUIKT2q+oOVPpqL4soXtBb
	BTrDURf3X6peFNbF+Doo64hVUaqZsTL3InZvK4ZeQIMZMe9MWsFZAddcNWu/pA7pq87OdfaRHKw2q
	EQYmAA9xkoF4QiMOwKFsZYZrqaO34XldZ36iPli5nqvuIb/UJyDBamkJyoMiAqMt9vjgvs7Rla+ya
	AvrnxLd0yf6ZMgNRwNOFNJUyaOHcl8YTfFt7eLXMFQJF68ps/O+HXgezAI/mlr1aCwHeOsOc5DDp8
	jhMcPOww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPk-0000000170u-2lJY;
	Tue, 03 Sep 2024 16:29:56 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPh-000000016yv-3dew
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 16:29:55 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so5906931a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2024 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380991; x=1725985791; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=eAmxcaOMaW6GX4GhisD9WEgXJb99pQKIqm8pPJZI1g1qNDSYSfN7RJY/mVY2zR8V2J
         EwpY3cJ75ClGzpXuHG60ThrngtofnVv36A4e6RoxTKvjvMcjg2GTkzOO6TJWv6li4mqa
         x9KEVQ6fC3lUHbXcXKe3fH7Ke27OI7MnckHWvFHt36NsNCXXxvCKHQAnrmFMLnZxl/rK
         qt/qwLLjpeiZGnBH6u8WitDFAn/EmIP2cqV8YgZRGWJ92Jd92+z8LQju4T4x/pgn9VEi
         O+E/gmeQQu+Ri4bh07zWZSSgC2mWOojV/A66nsI4HjciGXOLoyrbAgaGmrsOyBFJNze5
         mlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380991; x=1725985791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=h+WtYhPgT4pHe0nXX3m44Ez0UZWYWCWFNVfcv410Nu3zwA7b7nL3YHdChf3r4ZCYGO
         gTD6Lry4ZomxcDztanCHpkr3IJLj55ti2iYhsUkPgxeGexwf5guVAgAOBk5Z1pyUISw+
         uTuxdZQInuM1Z3LX5EqgtyKUgCEdxAUlwBZcQmDeOwW3Av6uZ4W56NYMAICleArHa6EN
         xEwMy4nQ5bl5R52HbyQlyYAVEfvySZzXh/1bBQ10X86y/KAFq2Vv37FLzdGRMCvnpc4j
         MBb9zvdtSpBAi2iY12uJ1kHjH6iLIcp42/6XrKNBiIDv87a3tepb8l5l4931eaEw7gY8
         Zs0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ/MSVFY2kJAsw+khfObRW3LqrM2rPVq6n4nfIDiFSovFEHmjo0C3tEL3VKXTfO/+/8yxZVP+Oz4i@lists.infradead.org
X-Gm-Message-State: AOJu0Yxe7kEIsZbKhsqnxqgLezHkUPYepgmSr8vYiejCCmJ4EjC1jfmM
	JpnjpRGdswHsIW3y+So2g0dNqvxz5+cV1b1azGrXcf2L6SoOD6WJLcU1XV9HmQk=
X-Google-Smtp-Source: AGHT+IHtUoACfXNZ0W0C+bZ5247zZGeTkQsGperLhXX0DXaaUPvoiZyijPDr90lFDqYaGmMUUYdyBw==
X-Received: by 2002:a17:907:1c03:b0:a7a:b561:3575 with SMTP id a640c23a62f3a-a89fafab356mr646544266b.56.1725380990545;
        Tue, 03 Sep 2024 09:29:50 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989221df2sm693736566b.203.2024.09.03.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:50 -0700 (PDT)
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
Subject: [PATCH v4 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Tue,  3 Sep 2024 18:29:29 +0200
Message-ID: <20240903162930.165018-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903162930.165018-1-mwilck@suse.com>
References: <20240903162930.165018-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_092953_936768_8D3B910E 
X-CRM114-Status: GOOD (  13.13  )
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
index 5c554b6..b702a57 100644
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
 _require_test_dev_is_not_nvme_multipath() {
 	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
 		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
-- 
2.46.0


