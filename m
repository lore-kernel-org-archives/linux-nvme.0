Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20885606D805
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QFJxvjoJ;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=EHScjdkd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=; b=QFJxvjoJHPyiQ0
	kL1P6OyHBUWBoPKGDmRveiMfnljM9YIyO6w9eNyKE/2GyltuO8un9MEGtRFgJO1chnok+vASfdVMk
	8xS5jN/1BiLCF+gIFWfdmjuWkTDampugwd1ekg0L7/+mvhjDBZXta2BYgwmgutiLqmPlNEoY3Tbrr
	hIvNVWz7dgZMSptzyR7BUvWwKqPm9aY2HvdwG+pA4Y5kdZ3VvTK4KuQAVzm8lN4xcgJ4bN1/tR2ap
	5N6f9UAtHouy3zwl18IPWqUYHcM4K92QDZ1/Q4tegfKIT15YLeBl/NF7HC7TYW1P2YZjqZrHNbPnN
	yGkOu4TTwNDX9mtJKEBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObf5-00000005ZyB-34ZX;
	Wed, 04 Nov 2026 14:08:23 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObf2-00000005Zvx-1f5x
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:08:21 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36cedf1bd63so743788eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 06:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793801299; x=1794406099; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=;
        b=EHScjdkdJRHVVderuR4bAUmN2/A3lHFSdZoL45J6Y8uwFd41h3QLYomn5B+YxHQ16J
         zQvUHbAK35iv365P4z3vl7O7Hb5Pr7mj+U3p6pxAdbUOcsqYoWUnK0v+7ZBmAHOdWjZt
         OMxCRZWFp1cHDNVMWyV7LqyYjY5/w046gdhfAKDHieFt5GaogbooFjTe4jHIBrupMq04
         ET1iFheqX0w8uWoGe82bRBOYpBYzQIrbtvuwC9ZbfQLgwrOhpGu+We3XEQbWfUhnbA3I
         rIL1kCeCUeb7z2RqKkboSXw8GIar5wx4xk1ywMEes8MRaMQ2dkHHr0Xnc1/EGYEP5hru
         Ox/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801299; x=1794406099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=;
        b=RRnjbhNnq4gGXMUD30k1b4uqrwQweFWG6PoxOuFi9CwxKsf35UCaxEzhvhRUNiHc5I
         2fEDkY2QNuWSL2RCfyOqcUf7solGUYYizayekLAqIDos2Fp0XhZBN97gNCX8RHTLwnpN
         36W6PodMlui/i6Lybw3Hlb9pA0zsiTULSAzGvVEwGbM1DhDw3mBDPAw9PZqZl8ZfP1yM
         nYM4NB+mTMUQFoLdtkLzNLihRR5YD4p2s8R2uuCpgYheoOJhkGRSULxrCJ2iy7ujFF70
         m4DGmswm8BTzIgZ8g1UdiQV+h36cjCvF+vHDfEroZs68Oi3R7wUj4kTRpjubiMEe0n93
         L5tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJtAcWs7sQi2Tyz1xX7IJpAm9uRCeQDpy8o3s9CVbHIaHDHgCe+GdQx3arI3djhmqD68daumTTEp8K@lists.infradead.org
X-Gm-Message-State: APuU4Z/RiWmka6sbVPTuQOlTbW7DoMGnJtzQc+7Bi8HdQDoh0j3LLvbY
	BS3BtLt5nWD2HnRRIOhmE+NPo0AtDX1Mep+qLL1yadx8ysQzcEBw74zyFyk5Cd9uR8U=
X-Gm-Gg: AYBFou0FJMFEMDqvIL9fVNy9Q1uibCFI1oHDOeLtsFncWQgIXOrPMo0McWHjeOx7CNk
	cWtZrkAT5DUFI/+bUWCd/NcWDKNdHfmJtmc7Lg3dHyOa9A1S62tPT3ocoRZq0wn6FV5i6Iv3KDc
	gO0gtgu/U42bU0L3YAAONy/79xvktRlO61h3AGgtnq/yj4ZUaB0Eyk5rASDFdkoRXvLlS3a9Oqo
	B+jUJT1cs6eboQxax9FlC7JrEq/EPZfBzQQoMdPo7cjYjd2OC3BVU+ostW8GMMjBOPffkMmxR8k
	Q32HuXaJORBO5VLmYvBWCdaAERmbUKhE0uahy2qMCakP8g6MKXe1Hy3y5YAgVrYTNMqL5fIOjio
	sD9lUGg/xPbO22y75N4nW3mWKzFhcsALjKUUmsV5cCZ5f6tO64ZBLS4reBahWHa3KYCIZTB7wuK
	Tk1kUa3BBE1fLVteHENNckKcCEptIryDPRu7w26CE9Yxykcqpaug+lUUMlfFae0osv1X9MP60en
	5GfUPF2HLc2pxuqaXpsYVekezwlzBc6P6DGRp3xpEm+TtmMjII6kDudNe7YXNkUWtV4V6ccGH49
	5R5W2XF9ueYTur3KS6Ok496JWI7L/arM1+0+FuJFpBYo8SE+uJkSK4YEL3PCtizgzZPVi651EQ=
	=
X-Received: by 2002:a05:7301:152d:b0:36a:79cd:12df with SMTP id 5a478bee46e88-36a79cd1c3bmr8481928eec.9.1793801298473;
        Wed, 04 Nov 2026 06:08:18 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm11812491eec.3.2026.11.04.06.08.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 06:08:18 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	nilay@linux.ibm.com,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH blktests] nvme/077: test the per-queue io_cpu sysfs attribute
Date: Wed,  4 Nov 2026 06:07:21 -0800
Message-ID: <20261104140721.4489-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793800758.git.saravanand@crusoe.ai>
References: <cover.1793800758.git.saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_060820_449980_9F1B0602 
X-CRM114-Status: GOOD (  19.20  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme-tcp exposes /sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
so a control plane can choose the CPU that runs each I/O queue's socket
work [1]. Test that

  - io_cpu reads back a written CPU and rejects invalid values
  - managed is read only and turns 0 once io_cpu is written
  - an assignment survives a controller reset
  - the queue directories follow the queue count as attr_qid_max
    shrinks and grows it
  - removing the controller while io_cpu is written completes

The test skips when the kernel does not have the attribute.

[1] https://lore.kernel.org/linux-nvme/cover.1793800758.git.saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 tests/nvme/077     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/077.out |   2 +
 2 files changed, 187 insertions(+)
 create mode 100755 tests/nvme/077
 create mode 100644 tests/nvme/077.out

diff --git a/tests/nvme/077 b/tests/nvme/077
new file mode 100755
index 0000000..0b4bce5
--- /dev/null
+++ b/tests/nvme/077
@@ -0,0 +1,185 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Saravanan D <saravanand@crusoe.ai>
+#
+# Test the per-queue io_cpu sysfs attribute of nvme-tcp
+
+. tests/nvme/rc
+
+DESCRIPTION="test the per-queue io_cpu sysfs attribute"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype tcp
+	_require_min_cpus 2
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# last CPU in the online list, and the first CPU id past the possible ones
+last_online_cpu() {
+	awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online
+}
+
+first_impossible_cpu() {
+	echo $(( $(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/possible) + 1 ))
+}
+
+nr_queue_dirs() {
+	local nvmedev="$1"
+
+	find "/sys/class/nvme/${nvmedev}/queues" -mindepth 1 -maxdepth 1 \
+		-type d 2>/dev/null | wc -l
+}
+
+expect_attr() {
+	local file="$1"
+	local expected="$2"
+	local value
+
+	value=$(cat "${file}")
+	if [[ "${value}" != "${expected}" ]]; then
+		echo "${file}: read ${value}, expected ${expected}"
+		return 1
+	fi
+	return 0
+}
+
+test_read_write() {
+	local qdir="$1"
+	local cpu="$2"
+	local bad
+
+	expect_attr "${qdir}/1/managed" 1
+
+	echo "${cpu}" > "${qdir}/1/io_cpu"
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+
+	for bad in "$(first_impossible_cpu)" -2 abc 0x1; do
+		if { echo "${bad}" > "${qdir}/1/io_cpu"; } 2>/dev/null; then
+			echo "io_cpu accepted ${bad}"
+		fi
+	done
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+
+	if { echo 1 > "${qdir}/1/managed"; } 2>/dev/null; then
+		echo "managed is writable"
+	fi
+
+	echo unbound > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	echo -1 > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+test_reset() {
+	local nvmedev="$1"
+	local qdir="$2"
+	local cpu="$3"
+
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+set_qid_max() {
+	local nvmedev="$1"
+	local qid_max="$2"
+	local queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+	local retries=10
+
+	echo "${qid_max}" > \
+		"${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_qid_max"
+	while [[ "$(cat "${queue_count_file}")" -ne $((qid_max + 1)) ]]; do
+		if (( retries-- == 0 )); then
+			echo "queue count did not change to $((qid_max + 1))"
+			return 1
+		fi
+		sleep 1
+	done
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	if [[ "$(nr_queue_dirs "${nvmedev}")" -ne "${qid_max}" ]]; then
+		echo "$(nr_queue_dirs "${nvmedev}") queue directories," \
+			"expected ${qid_max}"
+		return 1
+	fi
+	return 0
+}
+
+io_cpu_writer() {
+	local qdir="$1"
+	local cpu="$2"
+	local file
+
+	while true; do
+		for file in "${qdir}"/*/io_cpu; do
+			{ echo "${cpu}" > "${file}"; } 2>/dev/null
+			{ echo unbound > "${file}"; } 2>/dev/null
+		done
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local skipped=false
+	local nvmedev qdir cpu writer
+
+	_nvmet_target_setup --blkdev file
+
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2
+	_nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	qdir="/sys/class/nvme/${nvmedev}/queues"
+	cpu=$(last_online_cpu)
+
+	if [[ ! -f "${qdir}/1/io_cpu" ]]; then
+		SKIP_REASONS+=("missing per-queue io_cpu attribute")
+		skipped=true
+	elif [[ "$(nr_queue_dirs "${nvmedev}")" -lt 2 ]]; then
+		SKIP_REASONS+=("controller has fewer than 2 I/O queues")
+		skipped=true
+	else
+		test_read_write "${qdir}" "${cpu}"
+		test_reset "${nvmedev}" "${qdir}" "${cpu}"
+
+		if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+			set_qid_max "${nvmedev}" 1
+			expect_attr "${qdir}/1/io_cpu" "${cpu}"
+			set_qid_max "${nvmedev}" 2
+		fi
+
+		# remove the controller while its queue directories are written
+		io_cpu_writer "${qdir}" "${cpu}" &
+		writer=$!
+		sleep 1
+	fi
+
+	_nvme_disconnect_subsys
+
+	if [[ -n "${writer}" ]]; then
+		kill "${writer}"
+		wait "${writer}" 2>/dev/null
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/077.out b/tests/nvme/077.out
new file mode 100644
index 0000000..c7f6ac3
--- /dev/null
+++ b/tests/nvme/077.out
@@ -0,0 +1,2 @@
+Running nvme/077
+Test complete
-- 
2.56.0


