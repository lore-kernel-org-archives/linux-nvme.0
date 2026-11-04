Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24086606A33D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i85VKztv;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T428q87q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=68K9xLIf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T428q87q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=68K9xLIf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vfTG03QlAtwLw/SLtfnEyXu8tXQFb4j7MYMxf50ANF4=; b=i85VKztv2+qMAR
	HWHkcDTt+Ex3foVnVD+wxW0QqQNkq5rteIRi1trF7VQPNdwJTgKZ/vEmi1qbDzZc0D02kffM5W/O2
	ns1kz3aF0obV3YI0vmpPCsmFC4CyDb3jfjUmxIRgo8TlstXzWF6JP09DIIEue64ZYpbK88Ran0SBm
	Hbu/VuMSAJVV73T3gPb7Xd1P7JbwlScE/gArbrOsYUN1mfzbem1zrps+LAsZT38mcL2faPcmbpaYy
	kKP2YrGZ0FxEaxWKDmRo3rlX1q8dzYYO5Nl5QB8wuCavp9YHrqdP81NeEKL9+BuXKVyiy17fmpnsv
	ci4qypbI36UspUvtFUjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe7G-000000062na-3Dbe;
	Wed, 04 Nov 2026 16:45:38 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe7B-000000062gt-3WQ4
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 121201F79C;
	Wed,  4 Nov 2026 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfTG03QlAtwLw/SLtfnEyXu8tXQFb4j7MYMxf50ANF4=;
	b=T428q87qS7tkxCdYe8yrc9/F6TBYkGx5ITYtQd7j0Ntcf/yAUq+T1/vZBFoZG9H6ZEX7gZ
	Y0ef1Vd8KABjlBXeoxeCFT7TF/OnkaXlg4gIR0lWwlDp8z2Nz/KEX4oVMSaXrskKqEF0/5
	w5yY7TtfE+z3KvqnL87nNx/FXseVzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfTG03QlAtwLw/SLtfnEyXu8tXQFb4j7MYMxf50ANF4=;
	b=68K9xLIfPd+5skxhw83bigoVDpAiG9iDliKLuPSK5/b8pqE+9ePABtq0qHTQV8T0vx/3/p
	FwxVTTRVkLn+p4Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T428q87q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=68K9xLIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfTG03QlAtwLw/SLtfnEyXu8tXQFb4j7MYMxf50ANF4=;
	b=T428q87qS7tkxCdYe8yrc9/F6TBYkGx5ITYtQd7j0Ntcf/yAUq+T1/vZBFoZG9H6ZEX7gZ
	Y0ef1Vd8KABjlBXeoxeCFT7TF/OnkaXlg4gIR0lWwlDp8z2Nz/KEX4oVMSaXrskKqEF0/5
	w5yY7TtfE+z3KvqnL87nNx/FXseVzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfTG03QlAtwLw/SLtfnEyXu8tXQFb4j7MYMxf50ANF4=;
	b=68K9xLIfPd+5skxhw83bigoVDpAiG9iDliKLuPSK5/b8pqE+9ePABtq0qHTQV8T0vx/3/p
	FwxVTTRVkLn+p4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0F70134F0;
	Wed,  4 Nov 2026 16:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bDl8Kith62q2fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:31 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:48 +0100
Subject: [PATCH blktests 09/10] nvme: skip the tests which need a feature
 the remote target lacks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Queue-Id: 121201F79C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_084534_749115_9A85A10C 
X-CRM114-Status: GOOD (  15.05  )
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

An NVME_TARGET_CONTROL target need not implement the optional commands.
A storage array, for example, has fixed ports, manages the ANA states
itself and may not take host keys or a TLS key from blktests. The tests
which use a missing command then fail, e.g. nvme/057 on set-ana.

Add _require_nvme_target_control_feature, which checks the features
config --show-features lists. Use it in the tests which add and remove
ports (nvme/031), set ANA states (nvme/057), change host keys (nvme/042
to nvme/045, nvme/063) or set up TLS (nvme/062, nvme/063). No target
lists tls yet: blktests doesn't pass the TLS key to the script.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/031                 |  1 +
 tests/nvme/042                 |  1 +
 tests/nvme/043                 |  1 +
 tests/nvme/044                 |  1 +
 tests/nvme/045                 |  1 +
 tests/nvme/057                 |  1 +
 tests/nvme/062                 |  1 +
 tests/nvme/063                 |  1 +
 tests/nvme/rc                  | 18 ++++++++++++++++++
 10 files changed, 31 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 847792cec240..9ac55f2c6724 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -248,6 +248,7 @@ The blktests expects that the script interface implements following
   --show-trsvid
   --show-subsys-uuid
   --show-subsysnqn
+  --show-features
 
 setup:
   --subsysnqn SUBSYSNQN
@@ -288,6 +289,10 @@ set-ana: set the state of an ANA group on the port
 
 If list-ports prints nothing, blktests connects to the address config shows.
 
+config --show-features prints the optional commands the script supports,
+add-ports to set-host, and tls if the target can set up TLS. blktests skips
+the tests which need a feature the list lacks.
+
 The authentication tests change the DH-CHAP attributes of the host:
 
 set-host:
diff --git a/tests/nvme/031 b/tests/nvme/031
index cd69e8ef13ac..b12e24489740 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -21,6 +21,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_target_control_feature add-port remove-port
 }
 
 set_conditions() {
diff --git a/tests/nvme/042 b/tests/nvme/042
index bddbd1bbfc28..7ddc0e91706e 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -16,6 +16,7 @@ requires() {
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/043 b/tests/nvme/043
index ac25610a402b..f3b8d640891a 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -17,6 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/044 b/tests/nvme/044
index 1d9202143cf4..c1a48f1e3d86 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -17,6 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/045 b/tests/nvme/045
index 78a1c607e9c6..14f4949e198e 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -18,6 +18,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/057 b/tests/nvme/057
index 0a5cfa4df1a8..6c45af8b5ed9 100755
--- a/tests/nvme/057
+++ b/tests/nvme/057
@@ -13,6 +13,7 @@ requires() {
 	_have_loop
 	_have_fio
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_target_control_feature list-ports show-port set-ana
 }
 
 set_conditions() {
diff --git a/tests/nvme/062 b/tests/nvme/062
index eabe2d99bdcc..4402b848ecee 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -18,6 +18,7 @@ requires() {
 	_require_nvme_cli_tls
 	_have_libnvme_ver 1 11
 	_have_systemd_tlshd_service
+	_require_nvme_target_control_feature tls
 }
 
 set_conditions() {
diff --git a/tests/nvme/063 b/tests/nvme/063
index feb07bf3a06c..fae1e8941136 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -19,6 +19,7 @@ requires() {
 	_require_nvme_trtype tcp
 	_require_nvme_cli_auth
 	_have_systemd_tlshd_service
+	_require_nvme_target_control_feature set-host tls
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3c3ed680e416..6bdd4058586a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,6 +155,24 @@ _require_remote_nvme_target() {
 	return 0
 }
 
+# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
+# the optional commands and e.g. tls, see Documentation/running-tests.md.
+_require_nvme_target_control_feature() {
+	local features feature
+
+	if [[ -z "${nvme_target_control}" ]]; then
+		return 0
+	fi
+	features=" $("${nvme_target_control}" config --show-features) "
+	for feature in "$@"; do
+		if [[ "${features}" != *" ${feature} "* ]]; then
+			SKIP_REASONS+=("NVME_TARGET_CONTROL target does not support ${feature}")
+			return 1
+		fi
+	done
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }

-- 
2.56.0


