Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2E606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UcutVtWN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZOCTblioe0fUHPa1/ULzpKOMeU10MA+OZAFCTdg1ypA=; b=UcutVtWNRQ4UN0
	oiwx+HaqeQPvzD3TJ9nGAOSHoqGQA3lAublkxjNPqN67mY6tVji4xw5HyVA39eqMgV3yRFOD56sYH
	7NAiux9Jeu08+5t10lZj8T4dUpn6cs28LxH42lfih87jZGKFxtG4FDSpbDlZvXy2npMacRJ7UF5JY
	FtJENZraihEDkqmV4iw6ndah2f5GXkf1DfzyNM95+3zDNlxM5kWUUlSdk1NF7fQX+eWL/7VtCf/vH
	ME9krE7FBwrko+/wdzfTvzIN2idBP6npuU4kVqoTbOwB1KpmPTkTPxr0D2B3RR3+yDwllAUHRUGcm
	XiejTQWEphHKwuSLrFeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObw1-00000005d7f-0utB;
	Wed, 04 Nov 2026 14:25:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvx-00000005d3t-08K3
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B20D1F790;
	Wed,  4 Nov 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C520134F0;
	Wed,  4 Nov 2026 14:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5lAOGpA62olawAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:47 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:18 +0100
Subject: [PATCH blktests v2 6/6] nvme/080: test connect with offline CPUs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-isolcpu-v2-6-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 6B20D1F790
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_062549_234901_2EF6E597 
X-CRM114-Status: GOOD (  17.15  )
X-Spam-Score: -4.2 (----)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

blk-mq maps all possible CPUs to the hardware contexts, offline CPUs
included. If a hardware context is mapped only to offline CPUs,
blk_mq_alloc_request_hctx has no online CPU to select the software
context from and fails with -EXDEV. The fabrics transports allocate the
Connect command for each I/O queue this way, so connecting fails while
CPUs are offline.

Offline the upper half of the CPUs and connect. Check that a hardware
context is mapped only to offline CPUs, bring them online, run I/O from
one of them and trace that its commands are sent on the queue of that
hardware context.

The bug was introduced by kernel commit 20e4d8139319 ("blk-mq: simplify
queue mapping & schedule with each possisble CPU") and is fixed by
kernel commit XXX ("blk-mq: allow passthrough requests on hctxs without
online CPUs").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/080     | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/080.out |   2 +
 2 files changed, 144 insertions(+)

diff --git a/tests/nvme/080 b/tests/nvme/080
new file mode 100755
index 000000000000..eea4ed237218
--- /dev/null
+++ b/tests/nvme/080
@@ -0,0 +1,142 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test connecting with offline CPUs. blk-mq maps all possible CPUs to the
+# hardware contexts, the offline ones too. If only offline CPUs are mapped to
+# a hardware context, blk_mq_alloc_request_hctx has no online CPU to take the
+# software context from and fails with -EXDEV. The fabrics transports allocate
+# the Connect command for each I/O queue this way, so the connect fails.
+#
+# Offline the upper half of the CPUs and connect. Check that a hardware context
+# has only offline CPUs mapped, bring them online, run I/O from one of them and
+# trace the queue IDs of the commands to verify that the hardware context is
+# used and works.
+#
+# The bug was introduced by commit 20e4d8139319 ("blk-mq: simplify queue
+# mapping & schedule with each possisble CPU").
+#
+# Regression test for commit XXX ("blk-mq: allow passthrough requests on hctxs
+# without online CPUs").
+
+. tests/nvme/rc
+. common/cpuhotplug
+
+DESCRIPTION="Test connect with offline CPUs"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_min_cpus 4
+	_have_cpu_hotplug
+	_have_tracefs
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+offline_upper_cpus() {
+	local -a cpus
+	local cpu
+
+	mapfile -t cpus < <(printf '%s\n' "${HOTPLUGGABLE_CPUS[@]}" | sort -n)
+	for cpu in "${cpus[@]:$((${#cpus[@]} / 2))}"; do
+		_offline_cpu "${cpu}"
+	done
+}
+
+# Print the hctx directory and the CPUs of the first hardware context which
+# only has offline CPUs mapped.
+find_offline_hctx() {
+	local disk="$1"
+	local hctx
+	local cpu
+	local cpus
+
+	for hctx in /sys/block/"${disk}"/mq/*; do
+		cpus=$(tr -d ' ' < "${hctx}/cpu_list" | tr ',' ' ')
+		for cpu in ${cpus}; do
+			if [[ $(cat "/sys/devices/system/cpu/cpu${cpu}/online" \
+					2>/dev/null || echo 1) == 1 ]]; then
+				continue 2
+			fi
+		done
+		echo "$(basename "${hctx}") ${cpus}"
+		return 0
+	done
+	return 1
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local nvmedev
+	local disk
+	local ns
+	local hctx
+	local cpu_list
+	local -a cpus
+	local cpu
+	local nr_cmds
+	local trace_dir="/sys/kernel/debug/tracing/instances/blktests-nvme-080"
+	local skipped=false
+
+	_setup_nvmet
+
+	offline_upper_cpus
+
+	_nvmet_target_setup
+
+	if _nvme_connect_subsys; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
+		ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
+		# The CPUs are spread over the hardware contexts in topology
+		# order, so usually the upper ones end up without online CPU.
+		if read -r hctx cpu_list < <(find_offline_hctx "${disk}"); then
+			read -r -a cpus <<< "${cpu_list}"
+			for cpu in "${HOTPLUGGABLE_CPUS[@]}"; do
+				_online_cpu "${cpu}"
+			done
+
+			cpu=${cpus[0]}
+			mkdir "${trace_dir}"
+			if _nvme_have_setup_cmd_event "${trace_dir}"; then
+				_nvme_trace_qid_start "${trace_dir}" \
+					"${nvmedev#nvme}" $((hctx + 1))
+				_run_fio_verify_io --size=32m \
+					--filename="/dev/${ns}" \
+					--cpus_allowed="${cpu}" ||
+					echo "FAIL: fio verify on CPU ${cpu}"
+				nr_cmds=$(_nvme_trace_qid_stop "${trace_dir}")
+				if [[ "${nr_cmds}" -eq 0 ]]; then
+					echo "FAIL: no commands from CPU ${cpu} on hctx ${hctx}"
+				fi
+			else
+				skipped=true
+			fi
+			rmdir "${trace_dir}"
+		else
+			SKIP_REASONS+=("no hardware context with only offline CPUs")
+			skipped=true
+		fi
+
+		_nvme_disconnect_subsys
+	else
+		echo "FAIL: controller not ready"
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]]; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/080.out b/tests/nvme/080.out
new file mode 100644
index 000000000000..15119b8d7a83
--- /dev/null
+++ b/tests/nvme/080.out
@@ -0,0 +1,2 @@
+Running nvme/080
+Test complete

-- 
2.56.0


