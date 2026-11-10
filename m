Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C6606A331
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZQ98+MK1;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=PNT3X2tV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=; b=ZQ98+MK15S7zo5
	dDNEoe0Bc7xaMmq/r8UivL1sGC8PgwUABvgEKJztsXOnZiI0vgep4DNaJjvFul7tF2CvgOyrlfey4
	T577jbUud2ZD088BvBah0jBJuXXTdE8PeKuWacN2g0zp+Ki2xgvOlbZ8M9iz3GwekCmgX86pANctC
	l5zr6pSznrCN4fk/BzeQh797+NQsJiVSJIfKQ1VWMNgRRekGggIOeYF/DOGgXYvufL6mx2B5swXUy
	1AoH5I6QKeoMYrZcVZx/93NrtKKY/53Mx6KEN3jRKAc6+k8eunRJxTmJhLIK/CsEhvK7y0Nu9h/sv
	r6HB/Jge8H1SK2JN/0eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkMw-00000003hOI-3vrt;
	Tue, 10 Nov 2026 11:50:30 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkMl-00000003hEJ-3S4T
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:50:28 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-492690dd5daso1332968f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 03:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794311418; x=1794916218; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=;
        b=PNT3X2tVOX1BvjgjrcEFFchxNqPQ3roXkGfiNw+a3Zi31GzEKdU9iPWA9g7b7Q01NM
         fzIOZCYy6S3PtHxUAaTENO7E93rI48GURzeCAX2PO/YHmwNPNwDv5mUYuKpjKNWxaAnO
         LaZrhdPU+8vQiA4RuTeyI5rJSpAK7il12gve5RjY/q0p/Yd7oE7bhaKMnwFZtKozlZyO
         MPem5NpfHC3ZNXXZsdejJc1o1m0deMsJ7EQc3ors9TxF/gnWc8dznoBNdqyLHXbbfXvt
         aEadBNQwB8rxn+v/WJSG/ivv6uLFLbSRRX2SVQROvMhMPD/KWyH8OQFg9pcAIYmTzrtH
         Jp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311418; x=1794916218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=;
        b=mcp2sy28nY38R2hfCMHZ4YpcjIf/Mma8Eo+RC3ITBHZ78GAZq5di7u7leLxvdrgNW7
         2BZ760muuI1uxZ1dk61/WfrxagbN/SdbqfvzQboMb4OAko3wKabeFGaWGr6o+a5dyqW6
         QMWDgJdElANkFUGCMXuw7jF8S24qOSnRd7Wk4EksfG3/J8WvRBmeS6/IJwvtGYVGYmFz
         6AKYQ7/wHBOCh9RNz1T+3NVfubcC9ohmT0QSaqRwSgm00D/C7A36QFkOnGls5Z2bfVy0
         fE0uv7Zsv3zoM8nCfptjrcwMzxx4jsOernbho2PXlCtZs7jvHwB1E2pDhOdk/07EpS6N
         UNqQ==
X-Forwarded-Encrypted: i=1; AL+hErGYaQyi9xokKeT2s3lz5Hj69QxdjJ1Hvhen/JSknVEesvmzRZ1/oNrOaPlhuv4iE8mHLGytP37gxWV/@lists.infradead.org
X-Gm-Message-State: APuU4Z+KsJPs7Ls9W/1FzmbBDn31eZeOmDN7UhIXBejy3ObfSkL0xNBd
	o1UsO82c8/PKDvUSTJiLDq3N/FVeSxQ3gpxx25KM3W/ZrdRNokxaLSP2GmviJhm2Wf4=
X-Gm-Gg: AYBFou2WKKXDc3VbvulzFgaWCe8hxzrb0GgQgfpiE4q9AJvzmkF1iT3ahllhqnrpEPZ
	UFN+/marH0adp2g4fAl80keAECHkzL+OudrUQYP/7oDsrfJJ9/AtaQaB+Gtjn8VwEvIbVtGDrsy
	MCsyjyK5AY3UqdTj4xnEO37v295DJtByP1F0rdekWuhvDQqOBI34D03b9bo5Agle1FVDpbL3TW4
	6rLEwqJvzSMsXBnTw7KdAtqsyes+4+3QuxbbKsPj7mxiHxbzxfqsc/sRKWmRIvsQsAZr56nJ5Zn
	Qy73+H/ZGpSoMQ2BbaEuop3wjPObV7hG/jJjaUZmGE5gtJBDDuKCCmF42yDPAbB55q3EQorVr13
	nPebdoZe+WCpyzmuKTrvXD0U5Fnrq2pKxUFInWzhzCDJ30u5406/3d3xD8wbMPJ1fLky8535m8E
	kIrzJpvDnAETOLafB8EbyZHa8wqai0634vIHi1B8A89KRDtYPo6MMPfwGNvAw0D0i9kOaBuSJUF
	A7zerYHafyI3i/WjyIYSJ3OjF/GjkX9qu8SD8nB8yrG63vk3gq1vf6bHYacKVGqyQq02hvI1Irm
	ajjs39ZIZsFfACBPhTJ1xXkq+Gw74bP5hbfh5IMy5dvNCOOJQek086sRED2yUFPtxrR5l7ePeni
	mK+PBxFhM6BvD1s41
X-Received: by 2002:a05:6000:29cb:b0:493:c7aa:7cef with SMTP id ffacd0b85a97d-49830b98240mr2765311f8f.52.1794311417769;
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284cce7sm4839689f8f.8.2026.11.10.03.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-block@vger.kernel.org
Cc: nilay@linux.ibm.com,
	shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: [PATCH blktests v2] nvme/081: test the per-queue io_cpu sysfs attribute
Date: Tue, 10 Nov 2026 11:50:05 +0000
Message-ID: <20261110115005.47367-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
References: <cover.1794015622.git.saravanand@crusoe.ai> <20261107095350.98072-1-saravanand@crusoe.ai> <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_035019_984555_A3FB3AFA 
X-CRM114-Status: GOOD (  19.72  )
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
  - an assignment and the queue directories survive a controller reset
  - the queue directories follow the queue count as attr_qid_max
    shrinks and grows it
  - removing the controller while io_cpu is written completes

The test skips when the kernel does not have the queues/ directory or
the io_cpu attribute.

[1] https://lore.kernel.org/linux-nvme/cover.1794015622.git.saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
Changes since v1 [2]:
- Connect with --nr-io-queues 2 and expect exactly two queue
  directories (Nilay).
- Skip with separate reasons when the queues directory or the io_cpu
  attribute is missing (Nilay).
- Check that queue_count is unchanged across a controller reset and
  that the queue directories match it (Nilay).

[2] https://lore.kernel.org/all/20261107095350.98072-1-saravanand@crusoe.ai/

 tests/nvme/081     | 208 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/081.out |   2 +
 2 files changed, 210 insertions(+)
 create mode 100755 tests/nvme/081
 create mode 100644 tests/nvme/081.out

diff --git a/tests/nvme/081 b/tests/nvme/081
new file mode 100755
index 0000000..0bda988
--- /dev/null
+++ b/tests/nvme/081
@@ -0,0 +1,208 @@
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
+# queue_count includes the admin queue
+queue_count() {
+	cat "/sys/class/nvme-fabrics/ctl/$1/queue_count"
+}
+
+expect_queue_dirs() {
+	local nvmedev="$1"
+	local expected="$2"
+	local nr
+
+	nr=$(nr_queue_dirs "${nvmedev}")
+	if [[ "${nr}" -ne "${expected}" ]]; then
+		echo "${nr} queue directories, expected ${expected}"
+		return 1
+	fi
+	return 0
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
+	local count
+
+	count=$(queue_count "${nvmedev}")
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	if [[ "$(queue_count "${nvmedev}")" -ne "${count}" ]]; then
+		echo "queue count $(queue_count "${nvmedev}") after reset," \
+			"expected ${count}"
+	fi
+	expect_queue_dirs "${nvmedev}" $((count - 1))
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+set_qid_max() {
+	local nvmedev="$1"
+	local qid_max="$2"
+	local retries=10
+
+	echo "${qid_max}" > \
+		"${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_qid_max"
+	while [[ "$(queue_count "${nvmedev}")" -ne $((qid_max + 1)) ]]; do
+		if (( retries-- == 0 )); then
+			echo "queue count did not change to $((qid_max + 1))"
+			return 1
+		fi
+		sleep 1
+	done
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	expect_queue_dirs "${nvmedev}" "${qid_max}"
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
+	# fabrics caps nr_io_queues at the online CPU count, hence the
+	# _require_min_cpus 2
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2 \
+		--nr-io-queues 2
+	_nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	qdir="/sys/class/nvme/${nvmedev}/queues"
+	cpu=$(last_online_cpu)
+
+	if [[ ! -d "${qdir}" ]]; then
+		SKIP_REASONS+=("missing per-queue sysfs directories")
+		skipped=true
+	elif [[ ! -f "${qdir}/1/io_cpu" ]]; then
+		SKIP_REASONS+=("missing per-queue io_cpu attribute")
+		skipped=true
+	else
+		expect_queue_dirs "${nvmedev}" 2
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
diff --git a/tests/nvme/081.out b/tests/nvme/081.out
new file mode 100644
index 0000000..5deb638
--- /dev/null
+++ b/tests/nvme/081.out
@@ -0,0 +1,2 @@
+Running nvme/081
+Test complete
-- 
2.56.0


