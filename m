Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6248BCD37A7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjBQiSI/EgBU6FriPosIOGq+TtZhMJPpr3ANm85z/c4=; b=FNMH4zcuj4CzMbzYbTCWudSoB1
	d7weLaA7Y7eu/C3ZtwCP2ZX1AwjEznJXIbsf4ZuDJ9cwB+HpReWNSufUVvP2V1RsNcxbcv2s4pgYX
	2T/MCH3ahbrPpXvv6qKhcTSVLYT0GzTM4fAdSihoR4FDi7lpHWYNFsk40YDE/00S8d1sEzKSuc0H+
	kPwSnz/gsPm9sIwAGny1Yw9B8sQDidddciJNZMkA9xwMr6cDwiiqpr/fsup7FPEA+KSJZvVJA6QV3
	YfVczYSfEf9mZYOWf91Sy7856FtEpq3OHrCT3pjGpO785iVgkSDyrNIg0L/ngm3D4hQkDOwuhQGzf
	KihRru/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPl-00000001716-1FfA;
	Tue, 03 Sep 2024 16:29:57 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWPi-000000016yx-0pTM
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 16:29:55 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a86b46c4831so622433966b.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2024 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380992; x=1725985792; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjBQiSI/EgBU6FriPosIOGq+TtZhMJPpr3ANm85z/c4=;
        b=HRwk71APfxPx8XkUZp+9fItIVZWtwVp1pezWldieFlyw1G89mukUQELMDlu8vvBfpc
         9b7NxN7oqSXjJyZ5T9EDyIPanybJdrtPDlTA/hxdb4ff0S0axbcIypE0lWuaSOWaV2ME
         ytupLd50Cu7abBtpr68VN+KKqC0N8Bp4lj3usF87V1ygjbw4M4U457xYYP+VKZ++0+kP
         EYcd307fP5/2LsyEeN3Kn2c3aJdY2WSwM/FDtvjrCaiTogFx72G4eRacjaM2oOBe1JLb
         fj8i4L9sAARv1bZkiY6h5U4qAd4l3SK9DTI/DxHvhTkdAPeFhwyKyk7N5OQ9Tx0qvmKx
         SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380992; x=1725985792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjBQiSI/EgBU6FriPosIOGq+TtZhMJPpr3ANm85z/c4=;
        b=ZqkSOg1nX0sdZdnDEgW2Nu86lU6gfZ8D33H6cA+nLxTAdd9IvBVxoaBMcCT+Ttip2+
         KSvTAsvexGxypYF2GvJQs2mlwiCEVWS4S6C4Z6XI7AMVq0l23B0d48xBUQBwrfEzJ+Pf
         7VmvIErchzwrc2hmnjazvGYBFwqHfb6WOX4EHAsUDIew2kiuc0vlDvOMaop1Y0uXSGrp
         9LBEuGXHb41Z3eah3FdXFE10L654+2VAKhIsGeVdc0R/IUZ3kAAjKwlkjrrsAqeD6ld2
         qwrH4xD6ugoL5FtsnfbFtLCMP1AtD40gf2qGCraQvq3SsAQMwYjZXteOqQsZBd1Cy23g
         OPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW579Gpjzu00eH7ZrNq3WcPJJK25a4KPv3h6lSSVW+pr4S6IZbo1ln8M7RkGFKlhqB9hUOXBYTNXmh/@lists.infradead.org
X-Gm-Message-State: AOJu0YzEGbn4TRVxDJl4pnzFV+T5dx5vAnUZ408T82NvNmKD3yOvb3kt
	sj9q8I2FletiDXFMPAmvhKmlc8eNqlpSco5C+5kOGZJgXSXr22NmWXRkYzwBUYk=
X-Google-Smtp-Source: AGHT+IHlZUobr/C0J2+/9pQ8nTa5nQhyGcKMEPbg1UP4/CUKEz9Hj/g76GDCLJIKRO6LyPd+J7Bumw==
X-Received: by 2002:a17:906:f590:b0:a86:f960:411d with SMTP id a640c23a62f3a-a89d872464emr757306466b.2.1725380991815;
        Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a89891d7368sm701977566b.168.2024.09.03.09.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
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
Subject: [PATCH v4 3/3] blktests: nvme: add test for controller rescan under I/O load
Date: Tue,  3 Sep 2024 18:29:30 +0200
Message-ID: <20240903162930.165018-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903162930.165018-1-mwilck@suse.com>
References: <20240903162930.165018-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_092954_264678_6FA5C215 
X-CRM114-Status: GOOD (  18.27  )
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
---
v4: - use while loop for array assignment (Shinichiro Kawasaki)
    - add "blktests" to subject line
v3: (all changes suggested by Shinichiro Kawasaki)
    - add "Link:" tag
    - add comment with patch description
    - declare variable "st" local
    - use "mapfile -t" for array assignment
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 +++++++++++
 3 files changed, 96 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..3ade8d3
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,76 @@
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
+	local i st line
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	while IFS= read -r line; do
+		ctrls+=("$line")
+	done < <(_nvme_get_ctrl_list)
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


