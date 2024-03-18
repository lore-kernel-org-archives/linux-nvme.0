Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F806C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=; b=EDS0bLg3IaFwq0UPHyt0EuOEd8
	0/TIzagTwq6/RzTje+pHyjJkG3O5hihpSJGw3+oGs2za4g8n8jKHaLjID35go+Q2tn3ZQ2QtZ/49J
	D7zRg5XrJozooqftXEZi1pEu1T2JfP4c1q6Asbaax1DkFDOv4u5odkZrf5Rd2Zco45cqn+Wa6v++3
	wH3hSNaUM0FeN8BLLYSZQ81JnDrjXyZpSc4chaNzGcRSGnZZPnfHeo/44mjIokEvfSQbaxu/4xfEB
	H0FmLa44q1eTqe5tRKMmDxC2yzEBSNrMYvpXxfxqIwx73UYGwik2vQgrLNQURp7djSsBJDeSfe/2O
	kbRnz/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9TD-00000007xdE-1tfJ;
	Mon, 18 Mar 2024 09:39:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9Sa-00000007xH1-1eHy
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 09:39:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95A2534881;
	Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=JmG6qZR0l+sGNd8cbAPLHM3vf8BSQUfutnC2VvzBkXON2AlEthTWfNYkcZvFldkbapXI+A
	JHyTkFiS+PbbQzDC44MD+Krcn4OUrwOPfDW7j4eha0sXcozWHSroA2YsVG8DhiDg3rfDrz
	gQyL0MF/2HPq7bR9AZSIeJCQSIrJE7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=L58CayZCFX2tjXA1ujFOHvJl5eYYaLCCo09pH+xh081ojyhoQQKEBBWXP9kc377eYU46Z3
	xecBJBCk7LvaYRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=JmG6qZR0l+sGNd8cbAPLHM3vf8BSQUfutnC2VvzBkXON2AlEthTWfNYkcZvFldkbapXI+A
	JHyTkFiS+PbbQzDC44MD+Krcn4OUrwOPfDW7j4eha0sXcozWHSroA2YsVG8DhiDg3rfDrz
	gQyL0MF/2HPq7bR9AZSIeJCQSIrJE7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=L58CayZCFX2tjXA1ujFOHvJl5eYYaLCCo09pH+xh081ojyhoQQKEBBWXP9kc377eYU46Z3
	xecBJBCk7LvaYRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 835DF1349D;
	Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BFigHr4L+GXHUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 09/10] nvme/rc: introduce remote target support
Date: Mon, 18 Mar 2024 10:38:55 +0100
Message-ID: <20240318093856.22307-11-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_023912_811684_3A5E87F3 
X-CRM114-Status: GOOD (  14.08  )
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

As we already have various nvme variables to setup the target, extend
this part with 'nvme_target_control' which is expected to be script
which setups the remote target accordingly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2e9a0860c0e7..35eb4cc5e954 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -7,9 +7,10 @@
 . common/rc
 . common/multipath-over-rdma
 
-def_traddr="127.0.0.1"
+def_traddr="${nvme_traddr:-127.0.0.1}"
+def_host_traddr="${nvme_host_traddr:-}"
 def_adrfam="ipv4"
-def_trsvcid="4420"
+def_trsvcid="${nvme_trsvcid:-4420}"
 def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
@@ -19,6 +20,7 @@ def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_trtype=${nvme_trtype:-"loop"}
+nvme_target_control="${nvme_target_control:-}"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
@@ -325,6 +327,10 @@ _cleanup_nvmet() {
 		fi
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	for port in "${NVMET_CFS}"/ports/*; do
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
@@ -369,11 +375,19 @@ _cleanup_nvmet() {
 
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
@@ -391,6 +405,7 @@ _setup_nvmet() {
 			fi
 		done
 	fi
+
 	if [[ "${nvme_trtype}" = "fc" ]]; then
 		modprobe -q nvme-fcloop
 		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
@@ -819,12 +834,13 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
+	local subsys_uuid="${def_subsys_uuid}"
+	local subsysnqn="${def_subsysnqn}"
 	local blkdev_type="device"
-	local blkdev
+	local ARGS=()
 	local ctrlkey=""
 	local hostkey=""
-	local subsysnqn="${def_subsysnqn}"
-	local subsys_uuid="${def_subsys_uuid}"
+	local blkdev
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -856,6 +872,22 @@ _nvmet_target_setup() {
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
 	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
@@ -890,6 +922,13 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" cleanup \
+			--subsysnqn "${subsysnqn}" \
+			> /dev/null
+		return
+	fi
+
 	_get_nvmet_ports "${def_subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-- 
2.44.0


