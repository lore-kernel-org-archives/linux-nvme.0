Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B24AC77B6C
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6lWxxPiFJ8Gs8rYjJGAxJMcdRVrMhFbOfVSaPZunB8=; b=luFbjYkPy2/e1uYEK0XZoEVdBk
	AuPy5w/mPwL+KECB1tsIusldwSaZqRLaNA8Bz2hdMu9W29K62vLrZlM3BQYwSdXnF0i7ABYZlHhbd
	w5wZyLwVkTUTuk89HIXwUXeUpFCt+1KzslMwDtAH2048WJc/+cGd9fVGixtCh+ZA1Uoiv/IUUsj7O
	jf6gv/1Tv37UYx5O1mQgKQCKSEKpCC4/Uf7oMQqnYIS5ep4NJxgzWTsznVezYwVDgXoNZHJNGVylG
	+epQU33hGYm1vg9prSqgdp0jmHow8K4t9b31la4dShdy2wvaaCVlVUxuU2/SfjNk4iGvmA8qJMCfd
	VAfnVYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL1L-006lAn-0a;
	Thu, 06 Apr 2023 08:31:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL1H-006l82-09
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 08:31:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E012122543;
	Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680769855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6lWxxPiFJ8Gs8rYjJGAxJMcdRVrMhFbOfVSaPZunB8=;
	b=gOCUojenzroC2Fk8aLgWAws2etdwLu+56QsX29fakGBPqoTj2XqnDU4Z7DyeFrCKITfx2w
	+4jdV/4pwoCX8a6jjaCijYRJurGn9bWQ01vmrh1CZjtOVMRw7nYIT9yPB9qqyg+HldbK1n
	kUXOymR4p8KYGPHshVQMYrWTw219UyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680769855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6lWxxPiFJ8Gs8rYjJGAxJMcdRVrMhFbOfVSaPZunB8=;
	b=SgMSiP30r5TvasZKPRzk0Rw1GlZeCY5Wn7jL5Paq4bS7G/dNOWoLEU1A9igktVoSTkVwam
	sZXArK52MG27o2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3766133E5;
	Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EBZMMz+DLmTbZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:30:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v6 2/2] nvme/048: test queue count changes on reconnect
Date: Thu,  6 Apr 2023 10:30:50 +0200
Message-Id: <20230406083050.19246-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406083050.19246-1-dwagner@suse.de>
References: <20230406083050.19246-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_013059_225568_FA876F50 
X-CRM114-Status: GOOD (  15.82  )
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

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |   3 ++
 2 files changed, 128 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

diff --git a/tests/nvme/048 b/tests/nvme/048
new file mode 100755
index 000000000000..926f9f3de955
--- /dev/null
+++ b/tests/nvme/048
@@ -0,0 +1,125 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Daniel Wagner, SUSE Labs
+#
+# Test queue count changes on reconnect
+
+. tests/nvme/rc
+
+DESCRIPTION="Test queue count changes on reconnect"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype tcp rdma fc
+	_require_min_cpus 2
+}
+
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+                if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+}
+
+set_qid_max() {
+	local port="$1"
+	local subsys_name="$2"
+	local qid_max="$3"
+
+	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
+
+	# Setting qid_max forces a disconnect and the reconntect attempt starts
+	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+
+	return 0
+}
+
+test() {
+	local subsys_name="blktests-subsystem-1"
+	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local file_path="${TMPDIR}/img"
+	local skipped=false
+	local hostnqn
+	local hostid
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	hostid="$(uuidgen)"
+	if [ -z "$hostid" ] ; then
+		echo "uuidgen failed"
+		return 1
+	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112861"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+
+	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+					--hostnqn "${hostnqn}" \
+					--hostid "${hostid}" \
+					--keep-alive-tmo 1 \
+					--reconnect-delay 2
+
+		if ! nvmf_wait_for_state "${subsys_name}" "live" ; then
+			echo FAIL
+		else
+			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
+			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
+		fi
+
+		_nvme_disconnect_subsys "${subsys_name}"
+	else
+		SKIP_REASONS+=("missing attr_qid_max feature")
+		skipped=true
+	fi
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${hostnqn}"
+
+	rm "${file_path}"
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
new file mode 100644
index 000000000000..7f986ef9637d
--- /dev/null
+++ b/tests/nvme/048.out
@@ -0,0 +1,3 @@
+Running nvme/048
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.40.0


