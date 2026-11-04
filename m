Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B842606A32D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zKju46hR;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vemvAoAW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/0w+/ai;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vemvAoAW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/0w+/ai
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R/VbJUOGLVWKKhSvo5Kul+hlvR03T0ag8jgcGCJY3Lw=; b=zKju46hRq2xmUz
	ZNIFHj7jj7EsUwQKUIEvoq9pE3ivF/tZqgxhvAP53Jw1bO9/QkvronjHtLoo/KqQR8p++mVODgIGQ
	+/mkxTUBcfN1nfU+SToop3Bfe9Tf70QGcRiqSbSLU/O0+lDauDdWPgU4d+9ILfDwUiCtxAtqozZmA
	l7QezaIZAnhdFa8Fsw5aHg7Cbjjy8KauELGr86AUrnzNckUstmFEqpoEzoT46uC5MUP4PE+rgqJXn
	L+c1+Lw2GZk4ijdhib9cJB82LWClSjSDspWKdpBCVyAWpnCF40ODmwTJCSw7F90+Lw6ryAxSxN1Oz
	sGZY5WlmlaepZY6uNouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6h-000000062Il-3cds;
	Wed, 04 Nov 2026 16:45:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6f-000000062Fz-23ci
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C88421F7A7;
	Wed,  4 Nov 2026 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/VbJUOGLVWKKhSvo5Kul+hlvR03T0ag8jgcGCJY3Lw=;
	b=vemvAoAWwFksTNMwDpGEyrK9RhOeWO6SkE4knEAou9/5zcQNrmK5fI+gNW2NTZxHEQs+RV
	LleaCBRY0WAqO5JEi+4/Fp1oX7jNyjCIt3+mBhoti2frJkTlkTHjMD0/3HexSGfGWVlT3Z
	Ab3joqwte/yE3h+CDBj9DG1fLHRgZDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/VbJUOGLVWKKhSvo5Kul+hlvR03T0ag8jgcGCJY3Lw=;
	b=c/0w+/ai458V1SdAEjvy7kyrlqjUtlY8Zb+Kkbu6m3VxMOlezLP5ixWirDxz0wQxGtJSbB
	Fn8RkgjkqHwVOlBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vemvAoAW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="c/0w+/ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/VbJUOGLVWKKhSvo5Kul+hlvR03T0ag8jgcGCJY3Lw=;
	b=vemvAoAWwFksTNMwDpGEyrK9RhOeWO6SkE4knEAou9/5zcQNrmK5fI+gNW2NTZxHEQs+RV
	LleaCBRY0WAqO5JEi+4/Fp1oX7jNyjCIt3+mBhoti2frJkTlkTHjMD0/3HexSGfGWVlT3Z
	Ab3joqwte/yE3h+CDBj9DG1fLHRgZDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/VbJUOGLVWKKhSvo5Kul+hlvR03T0ag8jgcGCJY3Lw=;
	b=c/0w+/ai458V1SdAEjvy7kyrlqjUtlY8Zb+Kkbu6m3VxMOlezLP5ixWirDxz0wQxGtJSbB
	Fn8RkgjkqHwVOlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95911134F0;
	Wed,  4 Nov 2026 16:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 27SPHAth62pKfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:44:59 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:41 +0100
Subject: [PATCH blktests 02/10] common/nvme: wait for the namespace of a
 remote target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-2-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Queue-Id: C88421F7A7
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
X-CRM114-CacheID: sfid-20261104_084501_832170_D36253E1 
X-CRM114-Status: GOOD (  10.09  )
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

_nvme_ns_ready waits for the namespaces in the local nvmet configfs. With
NVME_TARGET_CONTROL the subsystem is configured on the remote target, so
the configfs directory doesn't exist. The glob stays unexpanded and
_nvme_ns_ready never succeeds. _nvme_connect_subsys then returns 2 after
every connect, and tests which check its return value skip their I/O and
the disconnect.

Wait for the first namespace of the controller instead.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/nvme b/common/nvme
index a8c7634ec2b8..93782d07dc78 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1027,6 +1027,13 @@ _nvme_ns_ready() {
 	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
 
 	dev=$(_find_nvme_dev "$subsysnqn")
+	if [[ -n "${nvme_target_control}" ]]; then
+		# The namespaces are configured on the remote target, wait
+		# for the first one the controller reports.
+		[[ -b /dev/${dev}n1 && -e /sys/block/${dev}n1/uuid &&
+			-e /sys/block/${dev}n1/wwid ]]
+		return
+	fi
 	for ns_path in "${cfs_path}/namespaces/"*; do
 		ns_id=${ns_path##*/}
 		if [[ ! -b /dev/${dev}n${ns_id} ||

-- 
2.56.0


