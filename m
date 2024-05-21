Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B95C25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yr8eJr4k0O7521k0nDTej/YaEV4/rfT5HkA4kSAVa8E=; b=WYdCqtVq8hkyVcrEgt2hN9F9Wh
	lJGa0V4iMUiqxCpf4TCWxj2zFzVNvBuYUHB6W7B3qNrKRzRCfILrFGp9AvtM0POpJ3F/CaVGWsXKz
	KJ/9xxEN3TUmu/g/BNWyo4ILvfzaW4/hbULYQioQgZKtFKX/TT3YvRm9aqpFwVyJ3LvtxexeOwJRt
	qatCOhrGjZJAf7TFhU5Shmo/M/7P90/v8mu9ppWYOtEZ22Wgh2zshjfggU43Fm/tohMgSORB0JRrZ
	DWNOPpLOHvofXh2zJjlEhceJcsfMIDQaYa16g2gy2ALTlWWLRv81YF4G6y7bc7pjWgcCrD/0kRVc5
	4BxFFr9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9LIN-0000000GppR-2pSM;
	Tue, 21 May 2024 08:56:31 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9LIK-0000000GpoU-3Df6
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 08:56:30 +0000
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e1e8c880ffso9088451fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 01:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716281786; x=1716886586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr8eJr4k0O7521k0nDTej/YaEV4/rfT5HkA4kSAVa8E=;
        b=s0edG+rDE9IsVjdn2EEYK3dOGbfD7yE2Dn60/4hpCgZONNcP6w73wkrtEcGf2u2GYt
         xMFWSJVtlutkFT6fZ7Hji+SEF4zq101BhkxvA5xx0XGcJKxTVM5siiNLtt9B8aoAHBTA
         jdRPj2UMEU9wekWoRJBGsnsEe4X+BVQ23Wr4Bf/WCT53daajnu2nSLBNvYk9RvF1IMKU
         jh8BHZEjOEouIGWdsg2qD3NzNa72yj3etNrBvhyKsijprmXG8Sm4d1u+C0NuBPoiETuQ
         8Vy1qPPqkhL0WYkjM1vAV/yeoQl/0YWPSA9nsZHXjLu/8avWPaSZXwLJNoKgSpF3Ypr6
         9AbA==
X-Gm-Message-State: AOJu0YxLC6YaEfbT57heM6JuhkX27BsXi/2ONSfe8GIAAYGndU4AjFDO
	rfhG4gD9gtopE1XjY6RYTDUCxxbiwqcv6vR/USEeJUJN+UZGdnAxzJUMYQ==
X-Google-Smtp-Source: AGHT+IFf2GJ0jkDkNKTK5480CcknvIsqWTSzLf6IMlezmrRpMBATxzp6ES8y/AtTWrW4sgdgaNxsOA==
X-Received: by 2002:a05:6512:3a6:b0:523:81ae:91aa with SMTP id 2adb3069b0e04-52381ae974cmr11313643e87.2.1716281785410;
        Tue, 21 May 2024 01:56:25 -0700 (PDT)
Received: from localhost.localdomain (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a1dsm31219337f8f.32.2024.05.21.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:56:25 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests] nvme: add regression test for concurrently enable/disable nvmet ns
Date: Tue, 21 May 2024 11:56:22 +0300
Message-Id: <20240521085623.87681-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_015628_901455_2923FE4C 
X-CRM114-Status: GOOD (  14.34  )
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

Reproduce a hang in nvmet when concurrently disabling/enabling
an nvmet namespace.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/051     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/051.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/nvme/051
 create mode 100644 tests/nvme/051.out

diff --git a/tests/nvme/051 b/tests/nvme/051
new file mode 100755
index 000000000000..ddc097310dd7
--- /dev/null
+++ b/tests/nvme/051
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Sagi Grimberg
+#
+# Regression test for kernel hang when enabling/disabling nvmet
+# namespace concurrently
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvmet concurrent ns enable/disable"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+ns_enable_disable_loop() {
+	local ns="$1"
+	local iterations=200
+	for ((i = 1; i <= ${iterations}; i++)); do
+		echo 0 > $ns/enable
+		echo 1 > $ns/enable
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
+
+	# fire off two enable/disable loops concurrently and wait
+	# for them to complete...
+	ns_enable_disable_loop $ns &
+	ns_enable_disable_loop $ns &
+	wait
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/051.out b/tests/nvme/051.out
new file mode 100644
index 000000000000..156f0687aab2
--- /dev/null
+++ b/tests/nvme/051.out
@@ -0,0 +1,2 @@
+Running nvme/051
+Test complete
-- 
2.40.1


