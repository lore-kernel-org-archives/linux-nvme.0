Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179F606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VF61cHsw;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XWwFksd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbJkSnUi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XWwFksd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbJkSnUi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=m+hTx9qgUkrLPxWKeVbt4mQIG6ZKUacOcVCNVILqWXE=; b=VF61cHswbI3SCU
	TPV3vwxBGJ3I7L5mBJWitOFMTZ6etrb8wSIT2n73/aAxtOf6r6DOiQCGwFie06kN1yitsuR1ZZMzs
	XJXdi/oNrJGoVD0Smgo2gDiklabNUsoSo4rdmLz/TajvnI8SIGi8+D/0buEQiYEb6HnTsuWOF4aqE
	l/xsf+QbmUev048CEVqJ7NkU4v3OzxAQQvddXBK01ki74Q/v90nddaFAJn6chsn3MG/zHs+AFvAZo
	dHVHLa5Y0D8slShPVTnJUpyVxc3+bxkc/LP3M4e3GYm/Q1QlNOKB9Spg6ZlFUr+w/Ch7+dz1RvpSn
	QLNdnaJ+uSTufHklBOFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6t-000000062Qn-0wxS;
	Wed, 04 Nov 2026 16:45:15 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6p-000000062NT-0voZ
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 972311F7BB;
	Wed,  4 Nov 2026 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+hTx9qgUkrLPxWKeVbt4mQIG6ZKUacOcVCNVILqWXE=;
	b=2XWwFksdxnBWwDJFIOHfa9FYmaKm3tKGHBqlB9ecaiLuErnzd76zgEWbhMMRgVIYjru77T
	H6USEen1pK7ZEw2QLhqLKCdBgxMpflGR+tWXCtjB/T/fShZgoUPh7pSCYFXwwKUo1sZmqp
	QYJG7pof0q25dyduYH3FV6L/wIF9mOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+hTx9qgUkrLPxWKeVbt4mQIG6ZKUacOcVCNVILqWXE=;
	b=VbJkSnUiFBZ17FLJL6bnw8br1Y2Agoiws4+8sgiAv8XjE0ZywQMCW0hmMr+qP61OJjGozl
	z3N9t5shxYXZM3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+hTx9qgUkrLPxWKeVbt4mQIG6ZKUacOcVCNVILqWXE=;
	b=2XWwFksdxnBWwDJFIOHfa9FYmaKm3tKGHBqlB9ecaiLuErnzd76zgEWbhMMRgVIYjru77T
	H6USEen1pK7ZEw2QLhqLKCdBgxMpflGR+tWXCtjB/T/fShZgoUPh7pSCYFXwwKUo1sZmqp
	QYJG7pof0q25dyduYH3FV6L/wIF9mOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+hTx9qgUkrLPxWKeVbt4mQIG6ZKUacOcVCNVILqWXE=;
	b=VbJkSnUiFBZ17FLJL6bnw8br1Y2Agoiws4+8sgiAv8XjE0ZywQMCW0hmMr+qP61OJjGozl
	z3N9t5shxYXZM3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6364A1350A;
	Wed,  4 Nov 2026 16:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtQAEBVh62ptfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:09 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:43 +0100
Subject: [PATCH blktests 04/10] nvme: skip the tests which need the kernel
 target with a remote target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-4-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_084512_295815_B0559105 
X-CRM114-Status: GOOD (  10.29  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme/038, nvme/051, nvme/058, nvme/060 and nvme/065 work on the local
nvmet target directly. nvme/038 creates and removes a subsystem in the
local configfs. nvme/051 enables and disables the namespace in the local
configfs. nvme/058 creates its namespaces there. nvme/060 reads the
nvmet debugfs. nvme/065 exports a local scsi_debug device. With
NVME_TARGET_CONTROL the subsystem is on the remote target and the tests
fail.

Skip them with _require_kernel_nvme_target, as nvme/030 and
nvme/072-074 do.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/038 | 1 +
 tests/nvme/051 | 1 +
 tests/nvme/058 | 1 +
 tests/nvme/060 | 1 +
 tests/nvme/065 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/nvme/038 b/tests/nvme/038
index 4271ee3af951..a5dcdeda14aa 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -16,6 +16,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/051 b/tests/nvme/051
index 8b3bb2b592a5..c5a37af31515 100755
--- a/tests/nvme/051
+++ b/tests/nvme/051
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/058 b/tests/nvme/058
index 997ff7f87be3..a410cf728c52 100755
--- a/tests/nvme/058
+++ b/tests/nvme/058
@@ -12,6 +12,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/060 b/tests/nvme/060
index 49786afba8cb..4c5fa8c31648 100755
--- a/tests/nvme/060
+++ b/tests/nvme/060
@@ -13,6 +13,7 @@ requires() {
 	_have_loop
 	_require_nvme_trtype tcp rdma fc
 	_have_kernel_option NVME_TARGET_DEBUGFS
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/065 b/tests/nvme/065
index e878001efbdd..05480f3072fd 100755
--- a/tests/nvme/065
+++ b/tests/nvme/065
@@ -17,6 +17,7 @@ requires() {
 	_have_scsi_debug
 	_nvme_requires
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {

-- 
2.56.0


