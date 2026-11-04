Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E33606A330
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jrgEHtz8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QZvYRm9kpXyEiln1T+N2yehC7+ROhrO7cYIRp8yu6MI=; b=jrgEHtz8m35bYA
	tRzoTscCNxxdaWc6eRvu2ktz+BZ19tZlTWkt9OaU/5jmue0TCAO0sNv3Cv7ZX+uWrz71TcraCpAZT
	PlqSPpJWpqzaD5zYAw4t5symH4zQvgs6YLuTZPFgNEz+IXycpgNSl1uv2nU7UrEYWrsJJPFS5koVC
	lKFK++h1DrstoVlui+x1zpxTjY56X8be9ceGhKF74MOAv5dd6bmPO5yJV8s5rk2Nr9YQF9ngaV2EK
	KT4qHyOygKpKsIMswGREISvL2sSVOONRV0/P/jLjsMZwTqmAT5r8pVMlTBD9PCuE0jScj8oV8YQaC
	qxQvZwTJWJxT/56x0+WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvj-00000005cuU-1tPn;
	Wed, 04 Nov 2026 14:25:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvg-00000005ct8-1SMX
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 721771F790;
	Wed,  4 Nov 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21E64134F0;
	Wed,  4 Nov 2026 14:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCL3OllA62pvagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:30 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:13 +0100
Subject: [PATCH blktests v2 1/6] nvme/076: test I/O queue limits per queue
 type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-isolcpu-v2-1-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 721771F790
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_062532_538528_217C7561 
X-CRM114-Status: GOOD (  14.81  )
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

nvmf_nr_io_queues() limits each queue type to the number of online CPUs
when asking the controller for I/O queues, but nvmf_set_io_queues()
used to hand out the granted queues without these limits. With
nr_write_queues larger than the number of online CPUs, the default
queues got more queues than there are CPUs, some hardware contexts had
no CPU mapped and connecting their I/O queues failed with -EXDEV.

Connect with nr_io_queues set to the number of online CPUs and twice as
many write and poll queues, check that every hardware context has a CPU
mapped and that no queue type has more hardware contexts than online
CPUs, and run verified I/O.

The problem is fixed by kernel commit 99fd0cbae849 ("nvme-fabrics: limit
each queue type to the number of online CPUs").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/076     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/076.out |   2 +
 2 files changed, 108 insertions(+)

diff --git a/tests/nvme/076 b/tests/nvme/076
new file mode 100755
index 000000000000..d3389af63bd1
--- /dev/null
+++ b/tests/nvme/076
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test that no queue type gets more I/O queues than there are online CPUs.
+# nvmf_nr_io_queues limits each queue type to the number of online CPUs when
+# asking for I/O queues, but nvmf_set_io_queues used to hand out the granted
+# queues without these limits. With nr_write_queues larger than the number of
+# online CPUs, the default queues got more queues than CPUs, some hardware
+# contexts had no CPU mapped and connecting their I/O queues failed.
+#
+# The bug was introduced for nvme-tcp by commit 6486199378a5 ("nvme-tcp: fix
+# queue mapping when queue count is limited") and for nvme-rdma by commit
+# a249d3066de6 ("nvme-fabrics: add queue setup helpers").
+#
+# Regression test for commit 99fd0cbae849 ("nvme-fabrics: limit each queue
+# type to the number of online CPUs").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test I/O queue limits per queue type"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_have_debugfs
+	_require_nvme_trtype tcp rdma
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# Check that every hardware context has a software context mapped and that no
+# queue type has more hardware contexts than there are online CPUs.
+check_hctxs() {
+	local nvmedev="$1"
+	local nr_cpus="$2"
+	local disk
+	local hctx
+	local type
+	local -A nr_type=()
+
+	disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
+	for hctx in /sys/block/"${disk}"/mq/*; do
+		if ! compgen -G "${hctx}/cpu*[0-9]" > /dev/null; then
+			echo "FAIL: hctx $(basename "${hctx}") has no CPU mapped"
+		fi
+	done
+
+	for hctx in /sys/kernel/debug/block/"${disk}"/hctx*; do
+		type=$(cat "${hctx}/type")
+		nr_type[${type}]=$((${nr_type[${type}]:-0} + 1))
+	done
+	for type in "${!nr_type[@]}"; do
+		if [[ "${nr_type[${type}]}" -gt "${nr_cpus}" ]]; then
+			echo "FAIL: ${nr_type[${type}]} ${type} queues for ${nr_cpus} CPUs"
+		fi
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local nr_cpus
+	local nvmedev
+	local ns
+
+	_setup_nvmet
+
+	nr_cpus=$(getconf _NPROCESSORS_ONLN)
+
+	_nvmet_target_setup
+
+	# The bug only shows if the target grants a queue per online CPU for
+	# each queue type.
+	if [[ -f "${cfs_path}/attr_qid_max" ]] &&
+	   [[ $(cat "${cfs_path}/attr_qid_max") -lt $((3 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((3 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues $((2 * nr_cpus)) \
+				--nr-poll-queues $((2 * nr_cpus)); then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		check_hctxs "${nvmedev}" "${nr_cpus}"
+
+		ns=$(_find_nvme_ns "${def_subsys_uuid}")
+		_run_fio_verify_io --size=32m --filename="/dev/${ns}" ||
+			echo "FAIL: fio verify"
+
+		_nvme_disconnect_subsys
+	else
+		echo "FAIL: controller not ready"
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/076.out b/tests/nvme/076.out
new file mode 100644
index 000000000000..f453b79ce2fb
--- /dev/null
+++ b/tests/nvme/076.out
@@ -0,0 +1,2 @@
+Running nvme/076
+Test complete

-- 
2.56.0


