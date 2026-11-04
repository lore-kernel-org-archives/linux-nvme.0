Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B86606A332
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EqpvjzYi;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJJsGvev;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b1InSFta;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJJsGvev;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b1InSFta
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3bWT/A56hg+m+72OhH/BAAE9fguz4SyuwgQb8/Ls2NE=; b=EqpvjzYiqLSD2n
	cqpZsWCVkItgvQn/APxjxZuj2YDqeiRR+nUe/0nftOW+SrrB5I/wcolAS6ovbEzQDMzBHi0cQ436y
	N0GpNJwsTLsIk0pBk+HLUqC3kkJ7lsmYKiOG1l6UTJp4+mXa6x+GRfKsAX/7pjq9Mthu3Yfq3EnRa
	W2jF0kmLSca09N+SRqrD7aq1cJlwllTzaI/VN5LjZWZEicD61jnU8J7rkf4z582PVMYOt4sbLvXb/
	+bC/Drbt2WhvUFbv+8shC7H6TBBGsYZKVr6KVwIS+pG4TYUkrMW5wQpHiWv+w+3BOTjrU/V2Gc7qy
	YeCv+iGGxnW1+Si/Bmzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvk-00000005cvE-2LeH;
	Wed, 04 Nov 2026 14:25:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvi-00000005ctc-1UO5
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:35 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1D301F79A;
	Wed,  4 Nov 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bWT/A56hg+m+72OhH/BAAE9fguz4SyuwgQb8/Ls2NE=;
	b=gJJsGvev18RwyKZEKdZgI3m+hxvh1THidW/3QGwb9xLZ5TwHPHq46DyqnY8L5RNRTV6cBq
	s/q+b66w5jWdMvcKAssU4jkf2dlXZUnMR1Jor7n5Ta4VpTmKKoHFGw9lgcy2jdERXzX2wl
	5KW9MjZvqU/owvctFZxH+3PNBG3Eokc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bWT/A56hg+m+72OhH/BAAE9fguz4SyuwgQb8/Ls2NE=;
	b=b1InSFtaugrmu3r5xds9Viez/YbuohxdM6hi8Uld8sS+KKIm15uaQeeP84jVQwajvicSXv
	rmagsH9o1iITAVCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bWT/A56hg+m+72OhH/BAAE9fguz4SyuwgQb8/Ls2NE=;
	b=gJJsGvev18RwyKZEKdZgI3m+hxvh1THidW/3QGwb9xLZ5TwHPHq46DyqnY8L5RNRTV6cBq
	s/q+b66w5jWdMvcKAssU4jkf2dlXZUnMR1Jor7n5Ta4VpTmKKoHFGw9lgcy2jdERXzX2wl
	5KW9MjZvqU/owvctFZxH+3PNBG3Eokc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bWT/A56hg+m+72OhH/BAAE9fguz4SyuwgQb8/Ls2NE=;
	b=b1InSFtaugrmu3r5xds9Viez/YbuohxdM6hi8Uld8sS+KKIm15uaQeeP84jVQwajvicSXv
	rmagsH9o1iITAVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82DB4134F0;
	Wed,  4 Nov 2026 14:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EuhDF1xA62pzagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:32 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:14 +0100
Subject: [PATCH blktests v2 2/6] nvme/077: test poll support without poll
 queues
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-isolcpu-v2-2-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Level: 
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -17.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_062534_679008_0E354457 
X-CRM114-Status: GOOD (  15.60  )
X-Spam-Score: -4.4 (----)
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

blk_mq_alloc_tag_set() initializes all queue maps. When nr_poll_queues
is set but the target grants no queues for polling, nvmf_map_queues()
used to leave the poll map in this state, with all CPUs mapped to the
first hardware context. The queue claimed poll support and polled I/O
was sent to a queue which isn't a poll queue.

Limit the target to twice the number of online CPUs, connect with as
many read, write and poll queues as there are online CPUs, so no queues
are left for polling, check that the queue doesn't claim poll support
and run verified I/O.

The problem is fixed by kernel commit 36ede1aa85d5 ("nvme-fabrics: clear
the poll map if no poll queues are mapped").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/077     | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/077.out |  2 ++
 2 files changed, 89 insertions(+)

diff --git a/tests/nvme/077 b/tests/nvme/077
new file mode 100755
index 000000000000..e57e3416cdde
--- /dev/null
+++ b/tests/nvme/077
@@ -0,0 +1,87 @@
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
+# Regression test for commit 36ede1aa85d5 ("nvme-fabrics: clear the poll map
+# if no poll queues are mapped").
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
+	else
+		echo "FAIL: controller not ready"
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/077.out b/tests/nvme/077.out
new file mode 100644
index 000000000000..c7f6ac360a57
--- /dev/null
+++ b/tests/nvme/077.out
@@ -0,0 +1,2 @@
+Running nvme/077
+Test complete

-- 
2.56.0


