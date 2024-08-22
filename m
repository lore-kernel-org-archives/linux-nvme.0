Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4438AC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3glpGU9x1kcJJgX+l/inQq4k3AYAsir0suA9GFYY2co=; b=ukpe5BQIvYC/6SDGK5PiLfsd75
	loQP0zoSMZs/Oez5CK0GcK0hzBS2UUAmwK8WrilMuHQZoCht4u9zEJyzMzoTlA8R+zf7VzVf5rLgb
	ugMv2mR7xaeXTJBBxyYk9KUt9fd0sM9IP0DvcJWHdsKfcCwa1dmQ4tXppIyUoMsvkwVYuxjzhorW9
	Ccxz/+GKslqKX7fTipkNtY5oJRGOEfs4Tsfj+Z1dRvYT4VB/72gyLuXQyCdqDYcmbliwqFaRIP8Pc
	y4f2cvqhO0AD/mfzupvzjC+wjtLTnHA50dxEGMQhTS5rOEPk5rk7JiDwd1FM1JzGLP5ixuLfw/chO
	DfPcRLLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDdt-0000000E7QE-3me1;
	Thu, 22 Aug 2024 19:38:45 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDdr-0000000E7PP-1Uz7
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 19:38:44 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-52efdf02d13so1735084e87.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355521; x=1724960321; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3glpGU9x1kcJJgX+l/inQq4k3AYAsir0suA9GFYY2co=;
        b=MA1li9hct8s+e34cF7/zcmWrbi5mRtwRyBm4MnFtdPDpQBrI5E3dflV2GAn8Mbb6Wn
         EI//InP8TJC3tg2eKrCaZn366j6kSxDB/WIoXo2QffZI1HlWE+ali/cKqFrjMuKeOzDR
         i0YFPXA5UvNJa0QamJcL/Dn+vB+pZL2IzpHbiX4h5kmTJ8ub48TqdFYAi9guwb6j60Ek
         JhxObfHdjc9Al1N6s8b9cmGvM0qa/jKIwURCk4eFw+9gwSnNCMN1goC0U1paJ/fU/DHu
         19piW6tz5g8mF1yBD4jOlRU7GYgVbLQIKt8jaat8//2zd+K6soIUCEvHnWhcJy8UQYCI
         dz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355521; x=1724960321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3glpGU9x1kcJJgX+l/inQq4k3AYAsir0suA9GFYY2co=;
        b=Px97+C5mtbObNHzF2oBgmyn9GZy98CAOXopuMcXDjCAEkeXs9vTFsyqVngfzuAucle
         QNRxxypqPBYKvsuxCniDtGs9YKuvBWa7sPnRmB0I7K/H8tXgniymIhwdy1JIGhwJ8KlO
         dbU+hz4gjn+hrYypCPAngGE6rKQL6GgHZcq4tVP2bTsxJ2TmLdka1snRwNZuSh/n9XUK
         thGWCc7SnHg2C3Gk9oFZTOnmHvZ1Vnqlv+QymMI5yi57Ef3yFIbPyx0p37tfd4+qKoBX
         f/85ZuFtiIOxd5PDKDdEru8zK6f5ga5A6q1WwiHiJ9Cn3KnnJSuKC67a+oj1OZM9/AiZ
         w6aw==
X-Forwarded-Encrypted: i=1; AJvYcCWKVjcoPmjaBkKt7MZSbclAAqt6LQi09BhkQnsuabsonLtL6w1ei4FU5ONU6wPHDYLYJXoNjcQXtdJo@lists.infradead.org
X-Gm-Message-State: AOJu0Yyl5TFGCUvhMcSgZ4Ov/VuKDKtCx+lwuD9vI8HXEH9InplpfiHz
	s1egS0sjt2cZ1nDakkh4LvMGNVEILRvfuRXPOsbBfA7LYmsWF55d8NxmMu6W82E=
X-Google-Smtp-Source: AGHT+IHqvYbFPPhwdBEjAHOuESxTgY/1gVffG8gG/TzIbACUog4K/qu6fYhtERnRe8AF4PZoWif7ZQ==
X-Received: by 2002:a05:6512:2212:b0:533:45c9:67fe with SMTP id 2adb3069b0e04-534387bad1dmr31454e87.48.1724355520505;
        Thu, 22 Aug 2024 12:38:40 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f4ebdc6sm155987166b.188.2024.08.22.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:40 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 3/3] nvme: add test for controller rescan under I/O load
Date: Thu, 22 Aug 2024 21:38:14 +0200
Message-ID: <20240822193814.106111-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_123843_420551_0B40E880 
X-CRM114-Status: GOOD (  14.57  )
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

Add a test that repeatedly rescans nvme controllers while doing IO
on an nvme namespace connected to these controllers. The purpose
of the test is to make sure that no I/O errors or data corruption
occurs because of the rescan operations.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/053 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc  | 18 ++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/nvme/053

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..41dc8f2
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Martin Wilck, SUSE LLC
+
+. tests/nvme/rc
+
+DESCRIPTION="test controller rescan under I/O load"
+TIMED=1
+: "${TIMEOUT:=60}"
+
+rescan_controller() {
+	local finish
+
+	[[ -f "$1/rescan_controller" ]] || {
+		echo "cannot rescan $1"
+		return 1
+	}
+
+	finish=$(($(date +%s) + TIMEOUT))
+	while [[ $(date +%s) -le $finish ]]; do
+		# sleep interval between 0.1 and 5s
+		usleep "$(((RANDOM%50 + 1)*100000))"
+		echo 1 >"$1/rescan_controller"
+	done
+}
+
+test_device() {
+	local -a ctrls
+	local c
+
+	echo "Running ${TEST_NAME}"
+	ctrls=($(_nvme_get_ctrl_list))
+
+	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
+
+	for c in "${ctrls[@]}"; do
+		rescan_controller "$c" &
+	done
+
+	while true; do
+		wait -n &>/dev/null
+		st=$?
+		case $st in
+			127)
+				break
+				;;
+			0)
+				;;
+			*)
+				echo "child process exited with $st!"
+				;;
+		esac
+	done
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/rc b/tests/nvme/rc
index e7d2ab1..93b0571 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -192,6 +192,24 @@ _test_dev_nvme_nsid() {
 	cat "${TEST_DEV_SYSFS}/nsid"
 }
 
+_nvme_get_ctrl_list() {
+	local subsys
+	local c
+
+	subsys=$(readlink  "${TEST_DEV_SYSFS}/device/subsystem")
+	case $subsys in
+		*/nvme)
+			readlink -f "${TEST_DEV_SYSFS}/device"
+			;;
+		*/nvme-subsystem)
+			for c in "${TEST_DEV_SYSFS}"/device/nvme*; do
+				[[ -L "$c" ]] || continue
+				[[ -f "$c/dev" ]] && readlink -f "$c"
+			done
+			;;
+	esac
+}
+
 _nvme_calc_rand_io_size() {
 	local img_size_mb
 	local io_size_kb
-- 
2.46.0


