Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36898606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i5P94jRt;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=IHvSiqRw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=; b=i5P94jRtHqzxvh
	KLtp6nK6d3fXascNHyMLYECQmsNKHN3FbjVMwZOBbwosOMaMDDU5DY0TmlaSMtSWUiqQas0tdAPlK
	5hNOVTNnOVeweVb3MPw3sGAw+365AFG9BHfbf8YgP4gIvyAGIC9w1h2oG1Mm3AWX7PuyfDs6GuHt7
	ObcsUmZ7/ZYBdExBFP8mzod7FtyWDtM4Q7kpcxZFIE8Z15TVFPdacbXs6e64tYi1/+KU+GiZ4Twib
	C3CszZ1YRDxtyLlS/ufZiHBCZhufrJNFi3qbqdrrp9ZrkrU+Q7p18fGMDqSAjIV3DBBkTgFXfWQkh
	ov2P7Zo2JkDRMwdGu7bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKON0-0000000H98B-2bhm;
	Fri, 23 Oct 2026 23:08:18 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKOMy-0000000H97o-2G34
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 23:08:17 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36681e85e87so3298281eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792796896; x=1793401696; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=;
        b=IHvSiqRwyM0Z8/grs5dAcMQx1Bf70AsrXFhmfS/CfpGUHh80NtFgvCDqGcniLFacg0
         jGtLVavhiepRrnBN1URZADQWD2gr5S+2hIhlHNayzLSE1cLRhgbxqycQNESpXCRyoUDG
         JVVukHxsO5ZELJPUGE1kTe89NFmBl4E5Jfs6OJLVKPZc+wf4nZ6KiEWFzSGqESApIM9/
         i6S5fx7gIT21rv64kifjaOsCRxR08IFd4zPsV0dT+CY0z6J4tbqBkLkUnhNfsdV2xOBS
         BLhqVlDk/80jXJohZq1FoCEILOL5VqpreeROcGD6JZxLF2nvt6ltb8691CR9oJ+3cDlF
         trzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796896; x=1793401696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=;
        b=LL8f/yGhbckfoT6Zlgd4lSzJsJfO0JstkAxAMYLT3Meo2D3eUXpKWOmcTKTp0ysxmb
         atZvNgqxn6kybwaAuDV0wLLIzzG6ZX/OkUz9CqR44mQnfeTAu8TwVNa7rCePhQwYV0Qu
         RM5cb6HyMgmheAz720z74Z3iKcxJDZZcxWbfP7gBM1aHx+bSWWEvGp0joAScrS45cBPQ
         TmELcxHNTXQNHRIZJU7JaS5EdTv9wwc7JPfdPibFFYz78NdLofwdeSV5ZS6VUXCuGY6t
         6A2soLKeO0+dJOnsqWDKP0l8vsoZ3Q0DV1PGNWCydgWlNCzVu7fCpYxqlN12YiBUg6oq
         rpUw==
X-Forwarded-Encrypted: i=1; AKwUvBwpGFA6tolb7FRy5glWYXqHX63DOHWxO6zFmf3fqITVmVyXcXNw8KbK6Um2bpqCUDyx3fY/I7f1QtZZ@lists.infradead.org
X-Gm-Message-State: AFq9FYLBVEkdsV713hvlJXVN0f7usCMNDtDqD57Z+qAS4de96j1f2fWn
	T6MBhHOqF3JyewlnUYUFCzAtWXD/GPHTqHcWUOruGwaRVz3t+eHD9dATDvehhICm35ZCQoODUb5
	7cWOzXt4=
X-Gm-Gg: AYBFou0Ou0z2fydWXR2biFJHJtiJwOXzD6k/vUijCGQ32tyMW+xSk6vQoTA/Un45lmQ
	RxqvIIzzCcWUqR+Y224oyeyonhWFIHDW0LMJpncRIjhhwbkS3qU6p5whY+opZBMkXeh+XAOPa+N
	/++NSphKlrORzM3lxDcKP5/gQ3QAUJztKh5Ao8Y2hErILWGrRXLBT2F3nmoZc3vzl88WHWR8264
	UNafr28IqAWfU46aAhKKLHUOPVwESoZp0r0Vwc/TrIB309ro6GVzWKmf0wc/y0EmWpXOwN3PoDy
	BVpDpLTAtkGmtBB2SiU5zCv46hb7PMAW7+THmz7ZaF6e8z5xVxqex/LL/f0rsFribBb9pGBx7E6
	u+LEPygmgvu2OK1+Zu0780P+dBvnz0quZxDgaQbMkCOudW8b3Vb1kSAJ9+vGPvnCoPXrH9o1Rp9
	rez9BsitRVhvaZ5wNELqFK7k6/t2aTZ0HHc0ZMvffjaHs2OEvV/uj0KxlZMEF5VTgJo2FRhOyve
	rGDNt8U9PWlPfz/hDT+x/JyJNUefutcdmiu6MvFdYFvOeq71Ed2pnXMgMftPDPCjk/EhVkHnLBa
	637wgTKCFy0nE756+zMXyWzwfw==
X-Received: by 2002:a05:693c:415a:10b0:35a:7020:c08a with SMTP id 5a478bee46e88-369e846b175mr1112370eec.19.1792796895656;
        Fri, 23 Oct 2026 16:08:15 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d578casm1357561eec.6.2026.10.23.16.08.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 16:08:15 -0700 (PDT)
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
Subject: [PATCH blktests] nvme/075: test the per-queue io_cpu sysfs attribute
Date: Fri, 23 Oct 2026 16:08:09 -0700
Message-ID: <20261023230809.7869-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023230426.6425-1-saravanand@crusoe.ai>
References: <20261023230426.6425-1-saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_160816_589875_885CE687 
X-CRM114-Status: GOOD (  19.37  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[1] https://lore.kernel.org/linux-nvme/20261018010059.83120-1-saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
This tests the kernel series in the parent thread, which is under
review on linux-nvme.

 tests/nvme/075     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/075.out |   2 +
 2 files changed, 187 insertions(+)
 create mode 100755 tests/nvme/075
 create mode 100644 tests/nvme/075.out

diff --git a/tests/nvme/075 b/tests/nvme/075
new file mode 100755
index 0000000..0b4bce5
--- /dev/null
+++ b/tests/nvme/075
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
diff --git a/tests/nvme/075.out b/tests/nvme/075.out
new file mode 100644
index 0000000..0613dfa
--- /dev/null
+++ b/tests/nvme/075.out
@@ -0,0 +1,2 @@
+Running nvme/075
+Test complete
-- 
2.55.0


