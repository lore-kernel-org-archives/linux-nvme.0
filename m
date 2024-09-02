Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB2CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQ9LsPTxm+VbQGotIboa4weytFmVBj0/VPIq2l60SY0=; b=xXbxfXar9Fpa1ZzyNnfz6iBL2e
	wWxEEU/lzC83VfNu8PF0BS5gsqKL+j2tTeLGyZ6g2nULpqjU9xWy5OqMdKiz504Eq0L6X1Gkxms3r
	LPodQdGQOs9EKh4yHvdKp5IzLghGN5tP1mKq4GqwRvmK9ehQtVhYexgoryLFpLfNx+YZOF+gwGSaT
	GEkYr01LiDmqSad4/qq5STYNOu+7ZnxEa9LbypHUG/f9tmk0F4A+MCT4FVzuR6AyCBpHnjHSQC/xK
	LOgdlxcn8nwc00lxdG7UjhSkyiWlvInxnIJII7/q7+wPfWxahU979vz9AFGSG98OUsq09pplCVHId
	mjTKmtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82J-0000000Ef3H-2qTm;
	Mon, 02 Sep 2024 14:28:07 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl82E-0000000Eezz-3aVj
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 14:28:05 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a86984e035aso527512466b.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287281; x=1725892081; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ9LsPTxm+VbQGotIboa4weytFmVBj0/VPIq2l60SY0=;
        b=L3tps9GURjzpAAipZB2jSuv09a5ZmZJAWRKQbk/qN06ir0wYhR0UNXFI9Ipzy6uIB3
         E2BXBprlGfvHARuI5EsQsOBigpfIL3Lk+7Nfl3WClAkkrpjpAXOq34/EtGnQiG+2lxTI
         8KqWkTFiqlZbbd5pYXyiTbrpEORb24yS/iZYhxDYXVOT1Cqfuc6lKzkazbwE6SZiTbj+
         q/fSLD6fi0BzTi8fyOEqX7QpZ+p05ink5KP+39WGpj1DbfInjYxIdlsPYytYNj88UEAC
         c5NascoshQ+p8BY472ZJNYi4JGyiIemwWng3Tf4H6qmOka9P2N80ebkXXoklLc9lNw34
         QLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287281; x=1725892081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ9LsPTxm+VbQGotIboa4weytFmVBj0/VPIq2l60SY0=;
        b=HH9IfCT90i0QLIW1tN85YgXZh/PH2Fu8C/qKcfHzV+CAiyvRHApR4kg9WlCIAyZOcC
         lix0mr7OMWOtVuDPrySA0PHNkI1Jbxl3ls+8tfoe6fxELuRcv8Ou+MbxarbHwPB8bZmf
         WKS1Punm373Hqu8OHdEOZfqOcZGQN5Siu2gryGz1hvL02LtJNzO+0DEqVqfSYbdiFaZ5
         U+YJI0UEBbEv2HUiJ7cg1BW4BlRJmPGV430c8KbB55QEWdxSqzCeYB/t0o4yLwK+jzLU
         HudGgj6C1/pQm9p5UMR4SrssHECWySmXLplQv8H3TIez0+QvWM/KdXZH1QmaGklXAyI7
         x2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9T9Uk5caC1RFhEdrDq6UVHgnQA6yYq57QCjIkJjn3cEdzoTujw+fA/knawR5jE8IamoZk9N2aNSp2@lists.infradead.org
X-Gm-Message-State: AOJu0Ywhk9HixNvxWLwXAJzUz9UE6ziu9+jlhsFVxhPmaqqKOoWFAJNl
	Dx2ITz1AWRCHdn+fYiI+AGfB3EA7AIwtncnV8WSJOSIdRLS0NncDi7nZDIXV4xY=
X-Google-Smtp-Source: AGHT+IFNo+U6H0njqtK5FYf7X4oDFyjmGEpzlRSMX+ycejfBh12MlSOr41SNUtIdm7WPwSAjc412zg==
X-Received: by 2002:a17:907:d8f:b0:a7a:b781:60ed with SMTP id a640c23a62f3a-a89a35a1159mr655497466b.17.1725287280917;
        Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989222fa8sm565950366b.213.2024.09.02.07.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
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
Subject: [PATCH v3 3/3] nvme: add test for controller rescan under I/O load
Date: Mon,  2 Sep 2024 16:27:47 +0200
Message-ID: <20240902142748.65779-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
References: <20240902142748.65779-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_072802_917086_2F42FC13 
X-CRM114-Status: GOOD (  18.34  )
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

Link: https://lore.kernel.org/linux-nvme/20240822201413.112268-1-mwilck@suse.com/
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)
---
v3: (all changes suggested by Shinichiro Kawasaki)
    - add "Link:" tag
    - add comment with patch description
    - declare variable "st" local
    - use "mapfile -t" for array assignment
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 +++++++++++
 3 files changed, 94 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..df643ec
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Martin Wilck, SUSE LLC
+#
+# Repeatedly rescans nvme controllers while doing IO on an nvme namespace
+# connected to these controllers, and make sure that no I/O errors or data
+# corruption occurs.
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
+	local i st
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	mapfile -t ctrls < <(_nvme_get_ctrl_list)
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


