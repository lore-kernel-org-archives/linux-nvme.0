Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F6CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kg52GvXtSVZtKjZRhxwNLFaHi0HcvS0wZcQdnIJN5Hk=; b=YUKSsUNassgUGl4HWjByweJB4b
	frtOHe3buluxUHQKBMB3myVFDott5Suito20MeKXDtoePZiojQEABi2/A4gWo/dU4pmGh1g6dedh5
	QuHOmv48R+cqvPcgrpp8zhBgAUf3SwFLXcNWdc3Gqc0j8JcYNJLpWG6eliCiDEpetOADYPaoKUCvR
	huGJMZJFdFPoFmKpr2M3Roid384Wt2ffek/VAe/XCJrWAKdfQ+rB8Um0mKsSdUSF1w/n8dfJDIh/O
	n8JwNhhg1TS1F3BPP0/O4ECm+S9lrjXU5a0IGEJ2Mx2Pea7CQdRDLR8BBtyT8WYyIoS5STnM+2Nni
	MWVzKa7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmX-0000000Eoml-2CmL;
	Wed, 14 Oct 2026 07:52:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmT-0000000Eogf-2wYe
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:52:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCCC021E5D;
	Wed, 14 Oct 2026 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg52GvXtSVZtKjZRhxwNLFaHi0HcvS0wZcQdnIJN5Hk=;
	b=bWDSbL7GfZ03OEiSU9RFsbVrGuSSadZlP5y+tDnNvFjcFU2OY9tkHWWXsh1xLab3rrGuQt
	LOoHCZSf/Af6VIlqPKdRNBQJnxCGMe9GYNrLWTDQ2lWbC0e3n+g/IvdgPMdwFcLg7fUh1Q
	7QZBb/kt+YkuTHrqgYdcy8m4LaNlT2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg52GvXtSVZtKjZRhxwNLFaHi0HcvS0wZcQdnIJN5Hk=;
	b=/ciHpmOMbtjvf0QgZPQ/03nWBGpJ7Xp9lNOEVNXRgEwK8dzbojO3wXig8SdURRt7wrJZJD
	QKtNBQa+xLUJiKBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UEGx8KlS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mIGK1KMc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg52GvXtSVZtKjZRhxwNLFaHi0HcvS0wZcQdnIJN5Hk=;
	b=UEGx8KlSSGF3kuRIv1y5Ap5G3oa20upe6cVD3rJnulMS5a7X6QOwVKuDhDrtQWmZeQF4x9
	aV/ktgTI/O2JNhjIxeFVNB2YBRF9mJnHtEc+uzt9oK0o2Ah5Qp53ADKSVtwffEhca51/Ot
	DQ3nQvNwUUmj3CyzcdkMV8x8jJjAm9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg52GvXtSVZtKjZRhxwNLFaHi0HcvS0wZcQdnIJN5Hk=;
	b=mIGK1KMcm/1QpAYvV//S5mV9yyBVMY+zz0yUusy8BQM2RJDDI/LgUu2XJeWuH2BtaBEXKF
	dIgHJdVy0qFlbIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93BD91368E;
	Wed, 14 Oct 2026 07:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+wUG6Y0z2rePwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:52:06 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:51 +0200
Subject: [PATCH blktests 5/5] nvme/073: test reconnect with fewer I/O
 queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-5-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BCCC021E5D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_005209_959862_460B8254 
X-CRM114-Status: GOOD (  16.83  )
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

nvmf_set_io_queues() used to only set the io_queues entries for the
queue types it hands out, but the array is reused on every reconnect.
When the target granted fewer queues on a reconnect, the poll queue
count from the previous association survived, nvmf_map_queues() mapped
CPUs to hardware contexts which don't exist anymore and
blk_mq_map_swqueue() crashed with a NULL pointer dereference.

Connect with as many read, write and poll queues as there are online
CPUs, then lower attr_qid_max on the target to twice the number of
online CPUs, which makes the target drop the controller. After the
reconnect with fewer queues, check the queue count, that the queue
doesn't claim poll support and run verified I/O.

The problem is fixed by kernel commits XXX ("nvme-fabrics: reset
io_queues before computing the queue mapping") and XXX ("nvme-fabrics:
clear the poll map if no poll queues are mapped").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/073     | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/073.out |   2 +
 2 files changed, 119 insertions(+)

diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 000000000000..1a5afb4fa1df
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test reconnecting with fewer I/O queues. nvmf_set_io_queues used to only set
+# the io_queues entries for the queue types it hands out, but the array is
+# reused on every reconnect. When the target grants fewer queues on a
+# reconnect, the poll queue count from the previous association survived,
+# nvmf_map_queues mapped CPUs to hardware contexts which don't exist anymore
+# and blk_mq_map_swqueue crashed. Without the poll map fix, the poll map keeps
+# mapping all CPUs to the first hardware context and the queue claims poll
+# support.
+#
+# The stale io_queues entries were introduced for nvme-tcp by commit
+# 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited") and
+# for nvme-rdma by commit 5651cd3c4336 ("nvme-rdma: fix queue mapping when
+# queue count is limited"). The stale poll map was introduced for nvme-tcp by
+# commit 1a9460cef571 ("nvme-tcp: support simple polling") and for nvme-rdma by
+# commit 5651cd3c4336.
+#
+# Regression test for commits XXX ("nvme-fabrics: reset io_queues before
+# computing the queue mapping") and XXX ("nvme-fabrics: clear the poll map if
+# no poll queues are mapped").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test reconnect with fewer I/O queues"
+QUICK=1
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_require_nvme_trtype tcp rdma
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+wait_for_queue_count() {
+	local nvmedev="$1"
+	local queue_count="$2"
+	local file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+	local retries=10
+
+	while [[ $(cat "${file}") -ne $((queue_count + 1)) ]]; do
+		if [[ "${retries}" == 0 ]]; then
+			echo "FAIL: queue count $(cat "${file}") instead of $((queue_count + 1))"
+			return 1
+		fi
+		sleep 1
+		retries=$((retries - 1))
+	done
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local nr_cpus
+	local nvmedev
+	local disk
+	local ns
+
+	_setup_nvmet
+
+	nr_cpus=$(getconf _NPROCESSORS_ONLN)
+
+	_nvmet_target_setup
+
+	if [[ ! -f "${cfs_path}/attr_qid_max" ]]; then
+		SKIP_REASONS+=("missing attr_qid_max feature")
+		_nvmet_target_cleanup
+		return 1
+	fi
+	if [[ $(cat "${cfs_path}/attr_qid_max") -lt $((3 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((3 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues "${nr_cpus}" \
+				--nr-poll-queues "${nr_cpus}" \
+				--keep-alive-tmo 1 \
+				--reconnect-delay 2; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
+		wait_for_queue_count "${nvmedev}" $((3 * nr_cpus))
+
+		# Changing attr_qid_max makes the target drop the controller.
+		# Reconnect with only enough queues for the read and default
+		# queues, so no queues are left for polling.
+		_set_attr $((2 * nr_cpus)) "${cfs_path}/attr_qid_max"
+		wait_for_queue_count "${nvmedev}" $((2 * nr_cpus))
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+
+		if [[ $(cat "/sys/block/${disk}/queue/io_poll") != 0 ]]; then
+			echo "FAIL: ${disk} claims poll support without poll queues"
+		fi
+
+		ns=$(_find_nvme_ns "${def_subsys_uuid}")
+		_run_fio_verify_io --size=32m --filename="/dev/${ns}" ||
+			echo "FAIL: fio verify"
+
+		_nvme_disconnect_subsys
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 000000000000..ed6690e57868
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,2 @@
+Running nvme/073
+Test complete

-- 
2.56.0


