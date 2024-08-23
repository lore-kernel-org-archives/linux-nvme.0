Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56B5C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=; b=OSshF8CZhZna8vsOjQu9EmqN6T
	FFDiiq13pePF5FU6Q2Jy2KUMER+mR3MTU9sz39s+NMStYwVboctTvxSCb9Eiuy8ZBAnYCSKcjuVBG
	gSKsnntoOh/L8bevmwa3wGq/3jZoSGDdH9j4VB2lDU3ksJDg0jEeRcrc+nB817jTmRyHPR1Tav6fs
	sRytFozer/N/brIXCjdj0N+Mvi5g3x8dHLX1RUIGfPtMDp1kjfxRmq1GXenCQ2dPZnjFKYkjdwjkD
	6YzDTj/VWi1JT0ClzMPhfH692Szn7Z3BGVHrTe5mLDw8HIY8ZFxGf9OO7o9fw6A/xINQyKXCD5v+N
	7Jc+RT0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaak-00000000Vbj-1WzP;
	Fri, 23 Aug 2024 20:09:02 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaaf-00000000VYW-2IqY
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 20:08:59 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a868831216cso300920066b.3
        for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443736; x=1725048536; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=HS8hy4A6GsWcfJSbeccwOvaudfE4Ho1t5enlTJ3KOzfLlOn2dt55zDu2xtgYlGn6jO
         vaEhgHXw+w8Sshv12mGLiONIrMRwBUZ/XyHov6MM8hGceo85IWyPjEUeneYArnSjiNhl
         sa31NA03HWHZ3qdwtcPNNUAtm74YQC1bcfEohcdKcVNHP5Ds5kajc9vTU0dYJAB/YvMe
         Bv6o3LNCDBlCxmjVkHatKS2Omr4LgOPlNWrWCD5pVtqeVsFIypfqBGZIGMhxn7voePEO
         fUJr4lYp4sO4QxutEpbopZlSOEHUnD3SLXlDWAq27iMqEGW7glf+SV+Csehpxs6LKSKD
         3iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443736; x=1725048536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=F56Z3RdoqN+5kN6/09GJjhKnZpGT6LxbTqYhNbexGYxld0uLNYUgMLMCsJ7T5aMbZ8
         3H8wOIv6Vj3MYs53hhTX3B7CEVKP2JylNkjivSr+VA/QUYkk5meUbiNrnl5l127Iqt4P
         wjjhxotXd46flk3RsFkWBMcEY1SK8fhWnXhlTekA3x/TsYNCpY7N44QW83vXpghieNDA
         F0YcbTUfH9w0JBk1WTRZyuWiGRjK2IwRCmZFA86yqhsprjPG2A0p2pp7T3UV/+fIx8Tt
         LJ1GnkU4QzKSEcTzMGyvkNiJrjeQ7WjSuibAXoMhY41Thha7fmggBNDeCYkw8qc/XpRF
         sUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMymHRCSZJe50IMk7B2ngjXj+tRGRrcR87QHBtJJ3bm4eOEVVh+xpfXZUC8P2ZLyRmxOpUEoIeqQ8J@lists.infradead.org
X-Gm-Message-State: AOJu0YzWuUKOx+8gXKfngVS8XSiylCNQfausy4DXl3j2WmYHHnVpjWIv
	s34uQihln39mzgrlB07X0UUA1n5u0BBLdw5NQDHyW2YyMkpLZ9UrQD7EXfCpYpPeNISx70HRYWv
	b
X-Google-Smtp-Source: AGHT+IGADpIP4DvJCkCm1/Xu7gk2/E9mDpWF9e4TUjiERBdiNyPX75m2yIkqc4OIg2WNUrh5OfKQew==
X-Received: by 2002:a17:907:e92:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a86a54cf719mr207090766b.60.1724443735545;
        Fri, 23 Aug 2024 13:08:55 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f43367fsm304014866b.115.2024.08.23.13.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:55 -0700 (PDT)
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
Subject: [PATCH v2 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Fri, 23 Aug 2024 22:08:20 +0200
Message-ID: <20240823200822.129867-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823200822.129867-1-mwilck@suse.com>
References: <20240823200822.129867-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_130857_607447_7567B0AC 
X-CRM114-Status: GOOD (  12.53  )
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


