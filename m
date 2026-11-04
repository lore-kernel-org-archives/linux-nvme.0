Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658ED606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Prg7Q5w2;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/18D3lb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/18D3lb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=; b=Prg7Q5w2wG7asY
	x8RzRZa8i+Bbw8aPg5TBmB5JtJqIz118fnmPbYylXPqnAnOlUgAWIQPhpUag46LJRrTyC9Zd1B6Pi
	mFzvxf4a9iLwhYP38bkKSMSE7T8dfdw2sxAdXLmyP3LyHN68ggDQry3bBXnvAdOHWzVzNmjRDCWWn
	2s3ede7wejmY9QJclSr7zjUr2SSeHKIppfaYOdhTyYKFdc6SRFD7LKRryNj0UM7+wyI9NIi4d51FA
	aSuVxDYI1etHwTAP6RhsmyeXW7+wrCrndA3dqgxheRsk09NcfFnLW3GxuQ7cqqIq/KpLPw/umagEk
	0qdpP39tZBUVbGwMd63Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6r-000000062P4-0VEn;
	Wed, 04 Nov 2026 16:45:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6n-000000062MU-1HXP
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B592221FB6;
	Wed,  4 Nov 2026 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=zH65qRvbzg2bIGPKIF3G6QyhutB9uACooX7Xo5Xj32tG7mg60n9cAYICzU/hoRZqjPXJie
	KQDkAG+2kc3Xrl9Yk1mZPwo4xrHnjqtJmdmUWKklHHx0jCK9bypMbr1Nre3VzWWHLCE7wO
	fGY1NKPnGXFk1P7von7TNQHKclX5QEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=c/18D3lbsYQ1PwrS0oVzPIuWde0ckOJFouJgHpu3lg0KEeb3QOtYbSXijFi/KfxXkcE3/z
	fzcFYB7VzRJVcwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=zH65qRvbzg2bIGPKIF3G6QyhutB9uACooX7Xo5Xj32tG7mg60n9cAYICzU/hoRZqjPXJie
	KQDkAG+2kc3Xrl9Yk1mZPwo4xrHnjqtJmdmUWKklHHx0jCK9bypMbr1Nre3VzWWHLCE7wO
	fGY1NKPnGXFk1P7von7TNQHKclX5QEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=c/18D3lbsYQ1PwrS0oVzPIuWde0ckOJFouJgHpu3lg0KEeb3QOtYbSXijFi/KfxXkcE3/z
	fzcFYB7VzRJVcwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 818A8134F0;
	Wed,  4 Nov 2026 16:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1kIhFxNh62plfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:07 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:42 +0100
Subject: [PATCH blktests 03/10] common/nvme: check the subsystem in
 _nvmet_target_add_ports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-3-b31b40537bb4@suse.de>
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
X-CRM114-CacheID: sfid-20261104_084509_495598_05D8E78F 
X-CRM114-Status: GOOD (  11.90  )
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

_nvmet_target_add_ports checks that the subsystem exists before it adds
ports to it. It checks the configfs directory of ${subsystem}, which is
not set. The path is then the subsystems directory, which always exists,
so the check never fails.

It also appends the keys to ARGS, which it doesn't declare local. They
end up in the ARGS of the caller.

Check the directory of ${subsysnqn} and declare ARGS local, as
_nvmet_target_setup does.

Fixes: db623ee8039f ("nvme: Add _nvmet_target_add_ports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index 93782d07dc78..dfe85b6e281f 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1668,6 +1668,7 @@ _nvmet_target_add_ports() {
 	local host_port=0
 	local tls="none"
 	local cfs_path
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -1734,7 +1735,7 @@ _nvmet_target_add_ports() {
 		return
 	fi
 
-	cfs_path="${NVMET_CFS}/subsystems/${subsystem}"
+	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	if [[ ! -d "${cfs_path}" ]]; then
 		echo "Can not add ports to a non-existent subsystem. subsystem not found"
 		return 1;

-- 
2.56.0


