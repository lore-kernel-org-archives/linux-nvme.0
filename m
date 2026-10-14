Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07353CC6B27
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=; b=udrF3Qim3kdJIy5UdU1ZB+yBpn
	0QENyH1RB61w+IMKBdxXLf5UbdoZ23r9Ws2vEfU/svPvzskBcZIgxcsdv+rcZREc+nvsfIUYjFfxf
	2PnWyDFuPFwlqei51OXmsX/rqw/aFilAKS0/ynFUskzNJSHOE7LVTjoIoBSEW1kNnyJVWNdBr6KG8
	gVa09W+jesyfPZ9XPGRMYz1re6LeEHog2Zg7tBRzwdvVJmZbStpN1Zl+E3bWJDyIcA6DXVpdQjTpO
	9lrurISvU0VyxbTrTv0oCI0vnt/lAVMFyTpnlwEsAN+8ZnV8nMU0/YmriF9sqFtV0ju6hfaqf7WUz
	zxPREU3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmV-0000000Eoj9-0FTr;
	Wed, 14 Oct 2026 07:52:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtmO-0000000Eoe3-2D4i
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:52:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C07501F7BF;
	Wed, 14 Oct 2026 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=QOGM8V3iLf/Drn9GjqJJWswH9z33anNCKraWMvkzQWu+/996Q5okjAkmH1BCbamCkJbXc6
	wEZ60siDKANN95saH3Au3jdxBnprbuAWCznNxK87GNPMxeGpOudJp6coIM5i8nf8os7Z0i
	B8LaTjwKVN5XUQw9QCG0recafhfCXaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=b+FjF22i7CH2CXZLv1NEQv4JwcDAG2SPlwwwmQjDwLgSZ5f2CXXXG5TUa2MV03Qq72kgni
	cLuzVjc5h3y4QrBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QOGM8V3i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b+FjF22i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=QOGM8V3iLf/Drn9GjqJJWswH9z33anNCKraWMvkzQWu+/996Q5okjAkmH1BCbamCkJbXc6
	wEZ60siDKANN95saH3Au3jdxBnprbuAWCznNxK87GNPMxeGpOudJp6coIM5i8nf8os7Z0i
	B8LaTjwKVN5XUQw9QCG0recafhfCXaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=b+FjF22i7CH2CXZLv1NEQv4JwcDAG2SPlwwwmQjDwLgSZ5f2CXXXG5TUa2MV03Qq72kgni
	cLuzVjc5h3y4QrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D1D1368E;
	Wed, 14 Oct 2026 07:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5pfG6I0z2rZPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:52:02 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:50 +0200
Subject: [PATCH blktests 4/5] nvme/072: test poll support without poll
 queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-4-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C07501F7BF
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
X-CRM114-CacheID: sfid-20261014_005206_706556_E1A3286D 
X-CRM114-Status: GOOD (  14.82  )
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

blk_mq_alloc_tag_set() initializes all queue maps. When nr_poll_queues
is set but the target grants no queues for polling, nvmf_map_queues()
used to leave the poll map in this state, with all CPUs mapped to the
first hardware context. The queue claimed poll support and polled I/O
was sent to a queue which isn't a poll queue.

Limit the target to twice the number of online CPUs, connect with as
many read, write and poll queues as there are online CPUs, so no queues
are left for polling, check that the queue doesn't claim poll support
and run verified I/O.

The problem is fixed by kernel commit XXX ("nvme-fabrics: clear the poll
map if no poll queues are mapped").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/072     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/072.out |  2 ++
 2 files changed, 87 insertions(+)

diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 000000000000..72bf80d660f5
--- /dev/null
+++ b/tests/nvme/072
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test that a controller without poll queues doesn't claim poll support.
+# blk_mq_alloc_tag_set initializes all queue maps. When nr_poll_queues is set
+# but the target grants no queues for polling, nvmf_map_queues used to leave
+# the poll map in this state, so the queue claimed poll support and polled I/O
+# was sent to a queue which isn't a poll queue.
+#
+# The bug was introduced for nvme-tcp by commit 1a9460cef571 ("nvme-tcp:
+# support simple polling") and for nvme-rdma by commit 5651cd3c4336
+# ("nvme-rdma: fix queue mapping when queue count is limited").
+#
+# Regression test for commit XXX ("nvme-fabrics: clear the poll map if no poll
+# queues are mapped").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test poll support without poll queues"
+QUICK=1
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
+	if [[ $(cat "${cfs_path}/attr_qid_max") -lt $((2 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((2 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	# Only grant enough queues for the read and default queues, so no
+	# queues are left for polling.
+	_set_attr $((2 * nr_cpus)) "${cfs_path}/attr_qid_max"
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues "${nr_cpus}" \
+				--nr-poll-queues "${nr_cpus}"; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
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
diff --git a/tests/nvme/072.out b/tests/nvme/072.out
new file mode 100644
index 000000000000..3f765b30a22b
--- /dev/null
+++ b/tests/nvme/072.out
@@ -0,0 +1,2 @@
+Running nvme/072
+Test complete

-- 
2.56.0


