Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6941C5321E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1+D94YGyMzhZFJZje/FHtM2e5+UTeORpDSLLRuDCMU=; b=Q0chD2KLYpX94oC6ERBNN4CTEV
	7iRN2OJGKIvwLb8JLyReX5BKi4bqdx3GDqo1wM5Y0CmMvz3DWsv8Ynfo7bSuUYC+ZwfmoO7QfDr/J
	N9bakNUnSfB8zZBzrcBAzDQawkBmNdZcbWUCqHFIS/BktOYuQQwx0mepBGQ1panpbg4lpraVvXLxI
	ugA4cWTnHUhZqb7yJ3o74u18zjE7gTtdCS+9BXnbun30XZ4KPf5fmD0j+RIHafyPFgyP/1YnkHBvn
	1e587ORYQyEBI9Uj1F1YU8ks8IlU71ou60wT6LWkDv4PReN0LhTSa1+6Jn3hP+MZmsmxXbdf+oE89
	9XKCn4Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaal-00000000VcX-0viL;
	Fri, 23 Aug 2024 20:09:03 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaag-00000000VZ8-2YPC
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 20:09:00 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a86984e035aso250833866b.2
        for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443737; x=1725048537; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1+D94YGyMzhZFJZje/FHtM2e5+UTeORpDSLLRuDCMU=;
        b=Jwp+czVO9WqHqBMX2siCJxwBYqJ/CMp6ltKOOUAKV9QOGVUcytzxhGajzzQjyuBbMD
         EA3xZddetC1rhVZ1F0nMJ84jkfyYXkf1MmjNC5gpwohehzckgZB881DmeGtiwR8nJspH
         tGB6vuVj4cQi968p1Y02f2icmsD1DRGKgKzW5l0E+94P36pukuif0RvkF20VWcImRUb+
         uqPtujmEOUQMUTyaT2rF/VGgt/0kE8vsIY95pusFtg++QDOYZsYEaIUhBcFY0MK6FPC1
         1Ho8lXAYHr7cPUwDrD9rSyrqB3+3s+IiffoS9SsXpcm32pk3IuBVAxIcdFA74z6hvJUF
         Q+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443737; x=1725048537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1+D94YGyMzhZFJZje/FHtM2e5+UTeORpDSLLRuDCMU=;
        b=SeRobxMN6Q7ir8vMKap5kiE0XpTbF9jhACpfs4jnXISRWu/xzVPWC0sXzwxyOg+zwg
         RTAGZv5j3yDosLFs94AWfStC1q0IT0Xj4HHwOGgixnV6WKYtu0HX2NHMbrRUqczawbla
         FD1ffASu1pEav5IQF0nBL4HBSB0+UlXekFPnnrcbAnbFvEfzbpLikknqDgwQjt0kUM6n
         bYqzNhZpRG5eN9aV5NXbIDztAq8d9RhhPIfol2jpL67xwTj5niHhdSauWqTDlW61txH6
         QDPUorFfB7rUHzIwJ9FYZ0VjUp1T0JdIRi/ICso7iJ/FSzaloebidp+KcaWiCO9VRfGS
         Vv3A==
X-Forwarded-Encrypted: i=1; AJvYcCVbR+JyBSynxypWVpCeCxnM5/Kw6ll1MM5LKNRxvBIfuWtpWloLqEkLawA7IbB2C7ra3HM3l4uaR/mq@lists.infradead.org
X-Gm-Message-State: AOJu0YwrG1XJpHOevVfM0Jj6yzrM4SG//FhXyF9dFhwkoZ/V7rR+AZBc
	RSfd0mqZcjv4x58351SyoLiTfigcBVoxngbyes9pBAAlasoYklovLrqvpgxxcgQ=
X-Google-Smtp-Source: AGHT+IFTEcqm6AeAQsCYJW/AsXIRPNiC5zHTUMGCgWM5PRToWM/ZU1C2AMgsUZExfSWobemNMXrsrg==
X-Received: by 2002:a17:907:9407:b0:a7a:ae85:f24d with SMTP id a640c23a62f3a-a86a548c9f6mr250931566b.51.1724443736669;
        Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f299d9asm303522066b.60.2024.08.23.13.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
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
Subject: [PATCH v2 3/3] nvme: add test for controller rescan under I/O load
Date: Fri, 23 Aug 2024 22:08:21 +0200
Message-ID: <20240823200822.129867-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823200822.129867-1-mwilck@suse.com>
References: <20240823200822.129867-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_130858_673642_24A3CBDE 
X-CRM114-Status: GOOD (  16.57  )
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
occurs because of the rescan operations. The test uses sub-second
sleeps, which can't be easily accomplished in bash because of
missing floating-point arithmetic (and because usleep(1) isn't
portable). Therefore an awk program is used to trigger the
device rescans.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 ++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..d32484c
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,70 @@
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
+	local path
+	path="$1/rescan_controller"
+
+	[[ -f "$path" ]] || {
+		echo "cannot rescan $1"
+		return 1
+	}
+
+	awk -f "$TMPDIR/rescan.awk" \
+	    -v path="$path" -v timeout="$TIMEOUT" -v seed="$2" &
+}
+
+create_rescan_script() {
+	cat >"$TMPDIR/rescan.awk" <<EOF
+@load "time"
+
+BEGIN {
+    srand(seed);
+    finish = gettimeofday() + strtonum(timeout);
+    while (gettimeofday() < finish) {
+	sleep(0.1 + 5 * rand());
+	printf("1\n") > path;
+	close(path);
+    }
+}
+EOF
+}
+
+test_device() {
+	local -a ctrls
+	local i
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	ctrls=($(_nvme_get_ctrl_list))
+	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
+
+	for i in "${!ctrls[@]}"; do
+		rescan_controller "${ctrls[$i]}" "$i"
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
diff --git a/tests/nvme/053.out b/tests/nvme/053.out
new file mode 100644
index 0000000..e8086ce
--- /dev/null
+++ b/tests/nvme/053.out
@@ -0,0 +1,2 @@
+Running nvme/053
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b702a57..a877de3 100644
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


