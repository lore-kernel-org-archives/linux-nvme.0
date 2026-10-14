Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550ACCC6B2A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=425t+R5ruu5k9Lveoptl4nDGocPQEjIuYGl7RTB5IqY=; b=jKWRDCStef+3Ts+0coBzIQqxQh
	flsALvmN+0hZMF7kJ8vXepWncHSouwKqUX4aFFg6oio6ybFlRAhlgh9ZjZbunlzoQtJfxsG+svXZm
	mkCaQO4CV5VWsigInDk4oT/9hni1IiuNdkInjqmKpBdgrCAbXfVynuUG7/38sNrInS+4l9BlMzCP8
	LYEssFjS8FMjYZba+PEGSqAKmFgQCCTs3kA3olCn3maic3WpZ3ux2Z/6Y4EZkt1JkN70kqLfK1U2C
	humpEHrADrT33F35BbGkB3FsHUa2lmvyF+sYjWYAxQdedJbKpmlfXrjQz2S7//A0BIMJNqPZSJHVi
	uAgbRaYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmU-0000000Eoik-3YDi;
	Wed, 14 Oct 2026 07:52:10 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmM-0000000Eodl-2qJp
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:52:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F2E1221A3;
	Wed, 14 Oct 2026 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=425t+R5ruu5k9Lveoptl4nDGocPQEjIuYGl7RTB5IqY=;
	b=jLPvdVL4ZLSHpvSc6lC6NsqABtr45recovdB1haGTbeSHSug//2snIrA8HCMzWRvnlVrr+
	kBLNFEnkxR/Y4H0DZQUE4BKorALOFGYJs5KYfyKk4XmgOKbvx5wF3DYduSConb/oLx2Yuf
	O7vS09u/KZ2JrPyOdoaj0glGPDmhc/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=425t+R5ruu5k9Lveoptl4nDGocPQEjIuYGl7RTB5IqY=;
	b=DJImOm/lgq0XaWNwsctgTWcGDUNlnV9oBhJ6fBX58k9HcXit6IDJYbb1UrM0V5O43p9Sh4
	YLyVAIjtrmdhUUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=425t+R5ruu5k9Lveoptl4nDGocPQEjIuYGl7RTB5IqY=;
	b=jLPvdVL4ZLSHpvSc6lC6NsqABtr45recovdB1haGTbeSHSug//2snIrA8HCMzWRvnlVrr+
	kBLNFEnkxR/Y4H0DZQUE4BKorALOFGYJs5KYfyKk4XmgOKbvx5wF3DYduSConb/oLx2Yuf
	O7vS09u/KZ2JrPyOdoaj0glGPDmhc/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=425t+R5ruu5k9Lveoptl4nDGocPQEjIuYGl7RTB5IqY=;
	b=DJImOm/lgq0XaWNwsctgTWcGDUNlnV9oBhJ6fBX58k9HcXit6IDJYbb1UrM0V5O43p9Sh4
	YLyVAIjtrmdhUUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E24251368E;
	Wed, 14 Oct 2026 07:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNoHL6A0z2rRPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:52:00 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:48 +0200
Subject: [PATCH blktests 2/5] nvme/070: test connect with an isolated CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-2-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_005206_658407_8CA9EA53 
X-CRM114-Status: GOOD (  22.53  )
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

From: Daniel Wagner <wagi@kernel.org>

Since kernel commit a46c27026da1 ("blk-mq: don't schedule block kworker
on isolated CPUs") isolated CPUs are removed from the CPU mask of the
hardware contexts. If only isolated CPUs are mapped to a hardware
context, the mask is empty and blk_mq_alloc_request_hctx fails with
-EXDEV. The fabrics transports allocate the Connect command for each
I/O queue this way, so the connect fails, e.g. with isolcpus=domain or
with an isolated cpuset partition.

Isolate the last online CPU with a cpuset partition, connect with the
default number of I/O queues and run verified I/O from a housekeeping
CPU and from the isolated CPU. To make sure the test exercises the
problem, it checks that the hardware context of the isolated CPU has an
empty CPU mask, that the I/O of the isolated CPU runs on that CPU, and
traces nvme_setup_cmd on the queue of the hardware context: the
housekeeping CPUs must not submit commands on it, the isolated CPU must.

The problem is fixed by kernel commit XXX ("blk-mq: use a housekeeping
CPU for passthrough requests on isolated hctxs").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/070     | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |   2 +
 2 files changed, 198 insertions(+)

diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 000000000000..6b9d4d80e257
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,196 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test connecting with an isolated CPU. blk-mq removes the CPUs which are
+# isolated, e.g. with a cpuset isolated partition, from the CPU mask of the
+# hardware contexts. If a hardware context ends up without a CPU, the Connect
+# command for its I/O queue can't be allocated and the connect fails. Run I/O
+# from a housekeeping CPU and from the isolated CPU and trace the queue IDs of
+# the commands to verify that the hardware context of the isolated CPU is used
+# and works.
+#
+# The bug was introduced by commit a46c27026da1 ("blk-mq: don't schedule block
+# kworker on isolated CPUs").
+#
+# Regression test for commit XXX ("blk-mq: use a housekeeping CPU for
+# passthrough requests on isolated hctxs").
+
+. tests/nvme/rc
+. common/cgroup
+
+DESCRIPTION="Test connect with an isolated CPU"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_min_cpus 2
+	_have_cgroup2_controller_file cpuset cpuset.cpus.partition
+	_have_tracefs
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+isolate_cpu() {
+	local cpu="$1"
+	local partition
+
+	_init_cgroup2 || return 1
+	_set_attr "+cpuset" "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	_set_attr "${cpu}" "${CGROUP2_DIR}/cpuset.cpus"
+	_set_attr "isolated" "${CGROUP2_DIR}/cpuset.cpus.partition"
+
+	partition=$(cat "${CGROUP2_DIR}/cpuset.cpus.partition")
+	if [[ "${partition}" != "isolated" ]]; then
+		SKIP_REASONS+=("failed to isolate CPU ${cpu}: ${partition}")
+		_exit_cgroup2
+		return 1
+	fi
+
+	return 0
+}
+
+run_io() {
+	local ns="$1"
+
+	_run_fio_verify_io --size=32m --filename="/dev/${ns}"
+}
+
+# Set isolated_hctx to the index of the hardware context the software context
+# of the CPU is mapped to, if the CPU mask of the hardware context is empty.
+find_isolated_hctx() {
+	local nvmedev="$1"
+	local cpu="$2"
+	local ctx
+	local hctx
+
+	for ctx in /sys/class/nvme/"${nvmedev}"/nvme*n*/mq/*/cpu"${cpu}"; do
+		[[ -d "${ctx}" ]] || continue
+		hctx="$(dirname "${ctx}")"
+		if [[ -n "$(cat "${hctx}/cpu_list")" ]]; then
+			SKIP_REASONS+=("hctx of CPU ${cpu} has CPUs: $(cat "${hctx}/cpu_list")")
+			return 1
+		fi
+		isolated_hctx="$(basename "${hctx}")"
+		return 0
+	done
+
+	SKIP_REASONS+=("no hctx found for CPU ${cpu}")
+	return 1
+}
+
+start_trace() {
+	local trace_dir="$1"
+	local ctrl_id="$2"
+	local qid="$3"
+	local event="${trace_dir}/events/nvme/nvme_setup_cmd"
+
+	_set_attr "" "${trace_dir}/trace"
+	_set_attr "ctrl_id == ${ctrl_id} && qid == ${qid}" "${event}/filter"
+	_set_attr 1 "${event}/enable"
+}
+
+# Stop tracing and print the number of traced commands.
+stop_trace() {
+	local trace_dir="$1"
+
+	_set_attr 0 "${trace_dir}/events/nvme/nvme_setup_cmd/enable"
+	grep -c "nvme_setup_cmd:" "${trace_dir}/trace"
+}
+
+check_io() {
+	local nvmedev="$1"
+	local cpu="$2"
+	local trace_dir="$3"
+	local ns
+	local isolated_hctx
+	local qid
+	local nr_cmds
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	find_isolated_hctx "${nvmedev}" "${cpu}" || return 1
+	qid=$((isolated_hctx + 1))
+
+	if [[ ! -d "${trace_dir}/events/nvme/nvme_setup_cmd" ]]; then
+		SKIP_REASONS+=("tracepoint nvme/nvme_setup_cmd does not exist")
+		return 1
+	fi
+
+	# The test runs on the housekeeping CPUs, which must not use the
+	# hardware context of the isolated CPU.
+	start_trace "${trace_dir}" "${nvmedev#nvme}" "${qid}"
+	run_io "${ns}" || echo "FAIL: I/O from housekeeping CPU"
+	nr_cmds=$(stop_trace "${trace_dir}")
+	if [[ "${nr_cmds}" -ne 0 ]]; then
+		echo "FAIL: ${nr_cmds} commands from housekeeping CPUs on qid ${qid}"
+	fi
+
+	# Moving the subshell into the partition confines it to the
+	# isolated CPU, so its I/O uses the hardware context of the
+	# isolated CPU.
+	start_trace "${trace_dir}" "${nvmedev#nvme}" "${qid}"
+	(
+		local allowed
+
+		_set_attr "${BASHPID}" "${CGROUP2_DIR}/cgroup.procs"
+		allowed=$(awk '/^Cpus_allowed_list:/ { print $2 }' \
+				"/proc/${BASHPID}/status")
+		if [[ "${allowed}" != "${cpu}" ]]; then
+			echo "FAIL: subshell runs on CPUs ${allowed}"
+			exit 1
+		fi
+		run_io "${ns}"
+	) || echo "FAIL: I/O from isolated CPU ${cpu}"
+	nr_cmds=$(stop_trace "${trace_dir}")
+	if [[ "${nr_cmds}" -eq 0 ]]; then
+		echo "FAIL: no commands from isolated CPU ${cpu} on qid ${qid}"
+	fi
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cpu
+	local nvmedev
+	local trace_dir="/sys/kernel/debug/tracing/instances/blktests-nvme-070"
+	local skipped=false
+
+	_setup_nvmet
+
+	# Isolate the last online CPU. Without nr_io_queues there is usually
+	# one I/O queue per online CPU, so its hardware context has no other
+	# CPU.
+	cpu=$(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online)
+	if ! isolate_cpu "${cpu}"; then
+		return 1
+	fi
+
+	_nvmet_target_setup
+
+	if _nvme_connect_subsys; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		mkdir "${trace_dir}"
+		check_io "${nvmedev}" "${cpu}" "${trace_dir}" || skipped=true
+		rmdir "${trace_dir}"
+
+		_nvme_disconnect_subsys
+	fi
+
+	_nvmet_target_cleanup
+	_exit_cgroup2
+
+	if [[ "${skipped}" = true ]]; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 000000000000..b765a2894652
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,2 @@
+Running nvme/070
+Test complete

-- 
2.56.0


