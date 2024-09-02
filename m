Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51AFCD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=; b=JgsdPmhNphx+eOnyFX0wuwdlJ/
	x+JtCy3nfo+MLfmg7GIolzarLcU1rTInZlmJNNtEsL0EfuVG91g3CiNGIB+EPSCl+e8hRFeR4J4hw
	7xk7B3JCZuF5tUtIEf8SEVjABvadVhpbCGPFrjzVD0h6gbnfFlSgcg4UFp1g/652oyHvKOa0jt+C3
	0xuODf4tEPR+BCTt0AZNXlhq4jWl//vkI3fEbfUhW58XBZnMYifZB0zHKPuzfKCnE38HJaQ1MmPbI
	C3oNlTEpZ9cel5IblmLpZ747DdSPyeD7qJtZIHaCf61sDZ08U6Xb+RgD8Wu4PqAgc0t+RibQ2SASD
	bklN5MHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82J-0000000Ef2o-0L0M;
	Mon, 02 Sep 2024 14:28:07 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82D-0000000Eezl-49Li
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 14:28:04 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a8679f534c3so445901966b.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287280; x=1725892080; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=CNk+9wbutH8rxQhHi33Rra0+cU/qdcyoCjXsrSy6ZTUXv7ALiQq8MIDdnP1uMtV6mt
         +ykcZBbaTaMNOi22FIOmkH4xPA2dVrI83KAQevZtwvvtIpx+wlJNAUbKxEKOpkvR9vA0
         E+RtcczwgQHV7OJjMQzuFpd/f042i82r2L3hoIAr73fUOgiGTQ6KkzVpZSH3LQCIPA84
         JgUxgH23f3Ci2zK+/weheJ7bADWPJ3Sy6FDby+NThnJoWHiT1qhMJa9QYwWVbO/8gvSL
         OX/hp9WkpQBlE38Cd4mYWdGBHcKJ1wZFUTNJq7isOga3fvSVDM2SeBXGcz4JAbiTRykF
         NLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287280; x=1725892080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=EXk5ZpH4YNuYTLgmD98RE50wcechjxZxxnuNLLM2I1SatddAXQho/e+XmNAyDiPv6P
         Tk0B/3djKB4CV1pN2VpXc2NNibuylKUIqhYv3pCi3m7OVB2r9pXZI/Mpi2+vNbkHj+pN
         loW1/6immkofhiBfOUa59fSXYKxLwzxoIDcBCE7wz7VY1sV26uteG4uzFhKdS9CnEIsb
         wZiSaH2PTdqps1MOd7uac7ORWJ/gojL9Z2JA6zgz+tIWBrshtaWHI5fCBvfeK9ocM8qB
         JInF/LDx1QKwrtkpcsbrHS/1b1XguXqiiaoY2U2638qoGPshgomFYULz66cBElWGSjnf
         mxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK2uTzPJ21eSuMlqJ/JpC6u3FUKfPI3fHapC+guVc5dryfftm5lJ1pczxHTxJnhez482qIL3qjY53Z@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4Gg1qpZ1BXxW9kw59cCD5pnfva1nlosZyZYidgJg33vb/LRyR
	mjwp0WrBPO6IIbvst5c9xXqzgmp3Lfgh0u8RZrDy3J0Qxv2laRgggwWnuJuiUbk=
X-Google-Smtp-Source: AGHT+IHzmM/02a8X0RvNaEpE3DTRzM83VRKSxFjouuZ9q9FeyTnRWM8bE3z6odD+9nYtgHRAaJIUnw==
X-Received: by 2002:a17:907:26c2:b0:a86:92a5:247a with SMTP id a640c23a62f3a-a89d8781d07mr538729566b.17.1725287279800;
        Mon, 02 Sep 2024 07:27:59 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989196bc4sm564753866b.125.2024.09.02.07.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:27:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Mon,  2 Sep 2024 16:27:46 +0200
Message-ID: <20240902142748.65779-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
References: <20240902142748.65779-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_072802_047781_6539E503 
X-CRM114-Status: GOOD (  13.36  )
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


