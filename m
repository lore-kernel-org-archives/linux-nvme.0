Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B39C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vc0+Mr53d0DUtouPeGzTe8BUoIjf0xB82ogzO5qigBQ=; b=esmhbfT9Hborrmd2nVqcEFPrI5
	7VqUMOjNNuGH4dGVnSeEN3G2FuRnm7wuTMGib4B8uNDuIUY7pFZisjtvxxRUjQULBDfB34SxLW6LI
	8cVsZ5xo4/KzDvrKm8ZDwwQv4ssu86vPTAxpq1MsiZfr+Sejf6lwT6mNHSe1qxCeTQb2U7BZKAMpm
	X4uJbgLINf9H6ETIY6XKNJrHk27s7xG1MRjMM/eTHxpBCTphVA7jlMnaSUtwbq0UAiNsRevzgs8Il
	tPtoQh+7DBoBbiXGT43PSrrucJ97myhiLZfWtLCqa11JbHTG+rCgpcadHCgUiZOp2EHelOMxSvwMk
	AJWXtihA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmn-0000000CNdK-3t7E;
	Wed, 12 Jun 2024 11:05:01 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmd-0000000CNZB-1mSI
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 11:04:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9A56342AD;
	Wed, 12 Jun 2024 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc0+Mr53d0DUtouPeGzTe8BUoIjf0xB82ogzO5qigBQ=;
	b=URSWdNX1MT5C85dMa5SvDYkZXRYB1TRfaAinpyY711OhRy/uXKKzfhTFWT1chfD5ztPTxs
	pyp7FKP5bp2PuA7e2a6JaWobJkl5+6b67x4C3mHFcccCZK1jY2quXUqSXxnv14VZEuDTls
	0OJc0Q7AakkeErbN6Pwg7LciNZr82Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc0+Mr53d0DUtouPeGzTe8BUoIjf0xB82ogzO5qigBQ=;
	b=nt1WNV7W7nnYal0TfDnq/hA95AwAZPE6hCUMwcF1lfw40V47IKZYUYGM5TDezgBTB8pH0x
	5cMx1V8aCIiHyIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc0+Mr53d0DUtouPeGzTe8BUoIjf0xB82ogzO5qigBQ=;
	b=B8uU4uFDexu+vpuV5Ad8HN9GYBQq6x9zXxpmiD1D9dMmqlEMw52rhhTCLWUxGNPkAq4Wqn
	2ftvIWFETotpE1w0AX/fktd1wfo2Ilotw0+PUtiVS8ICKmsi9WiizJqC6tHUIXHO9b+QDI
	onI2AAG7OX/s0e0BDbiFq2k9776TgJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc0+Mr53d0DUtouPeGzTe8BUoIjf0xB82ogzO5qigBQ=;
	b=0FixLTaFC5nW0e5HTgKsmsD6r7UKDFmlYI88MKixbnwn+opTrdGmDar5Mt6cc9q5MQAW5g
	YvJIFmUXdzHHZZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF0A913AAF;
	Wed, 12 Jun 2024 11:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YIN8MtCAaWaXDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 11:04:48 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v2 1/3] nvme/rc: introduce remote target support
Date: Wed, 12 Jun 2024 13:04:42 +0200
Message-ID: <20240612110444.4507-2-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612110444.4507-1-dwagner@suse.de>
References: <20240612110444.4507-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_040451_796565_47956465 
X-CRM114-Status: GOOD (  15.79  )
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

Most of the NVMEeoF tests are exercising the host code of the nvme
subsystem. There is no real reason not to run these against a real
target. We just have to skip the soft target setup and make it possible
to setup a remote target.

Because all tests use now the common setup/cleanup helpers we just need
to intercept this call and forward it to an external component.

As we already have various nvme variables to setup the target which we
should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variable
which points to a script which gets executed whenever a targets needs to
be created/destroyed.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  9 +++++++
 tests/nvme/rc                  | 48 +++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 968702e76bb5..99dedaebfab0 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -120,6 +120,15 @@ The NVMe tests can be additionally parameterized via environment variables.
 - NVME_NUM_ITER: 1000 (default)
   The number of iterations a test should do. This parameter had an old name
   'nvme_num_iter'. The old name is still usable, but not recommended.
+- NVME_TRADDR: transport address. Overwrites the default
+  transport address. See also NVME_TARGET_CONTROL.
+- NVME_HOST_TRADDR: host address. Overwrites the default
+  host address. See also NVME_TARGET_CONTROL.
+- NVME_TRSVID: transport service id. Overwrite the default
+  transport service ide. See also NVME_TARGET_CONTROL.
+- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup code will
+  be skipped and this script gets called. This makes it possible to run
+  the fabric nvme tests against a real target.
 
 ### Running nvme-rdma and SRP tests
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index c1ddf412033b..aaa64453fe16 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -7,9 +7,10 @@
 . common/rc
 . common/multipath-over-rdma
 
-def_traddr="127.0.0.1"
+def_traddr="${NVME_TRADDR:-127.0.0.1}"
+def_host_traddr="${NVME_HOST_TRADDDR:-}"
 def_adrfam="ipv4"
-def_trsvcid="4420"
+def_trsvcid="${NVME_TRSVID:-4420}"
 def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
@@ -23,6 +24,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
+nvme_target_control="${NVME_TARGET_CONTROL:-}"
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -359,6 +361,10 @@ _cleanup_nvmet() {
 		fi
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	for port in "${NVMET_CFS}"/ports/*; do
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
@@ -403,11 +409,19 @@ _cleanup_nvmet() {
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	modprobe -q nvmet
+
 	if [[ "${nvme_trtype}" != "loop" ]]; then
 		modprobe -q nvmet-"${nvme_trtype}"
 	fi
+
 	modprobe -q nvme-"${nvme_trtype}"
+
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
@@ -425,6 +439,7 @@ _setup_nvmet() {
 			fi
 		done
 	fi
+
 	if [[ "${nvme_trtype}" = "fc" ]]; then
 		modprobe -q nvme-fcloop
 		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
@@ -873,11 +888,13 @@ _find_nvme_passthru_loop_dev() {
 
 _nvmet_target_setup() {
 	local blkdev_type="${nvmet_blkdev_type}"
+	local subsys_uuid="${def_subsys_uuid}"
+	local subsysnqn="${def_subsysnqn}"
 	local blkdev
+	local ARGS=()
 	local ctrlkey=""
 	local hostkey=""
-	local subsysnqn="${def_subsysnqn}"
-	local subsys_uuid="${def_subsys_uuid}"
+	local blkdev
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -909,6 +926,22 @@ _nvmet_target_setup() {
 		esac
 	done
 
+	if [[ -n "${hostkey}" ]]; then
+		ARGS+=(--hostkey "${hostkey}")
+	fi
+	if [[ -n "${ctrlkey}" ]]; then
+		ARGS+=(--ctrkey "${ctrlkey}")
+	fi
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" setup \
+			--subsysnqn "${subsysnqn}" \
+			--subsys-uuid "${subsys_uuid}" \
+			--hostnqn "${def_hostnqn}" \
+			"${ARGS[@]}" > /dev/null 2>&1
+		return
+	fi
+
 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
@@ -948,6 +981,13 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" cleanup \
+			--subsysnqn "${subsysnqn}" \
+			> /dev/null
+		return
+	fi
+
 	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-- 
2.45.2


