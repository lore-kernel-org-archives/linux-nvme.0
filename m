Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBD606A886
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bDnoCWeZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=; b=bDnoCWeZjHDZQG
	4LLf0aKkoFNIb7dpcqpof4MZXx4AAqZlZiG5nB7FFYzshQI60gXCWIiLQDuATphpwrvcPIGUzxiXb
	kV/oCoK9Aph/Nl+/YUgTPBC6JXb17fkqCGrnk6hV1Cc8DIbLbHKtuRLIOmwEP6g3slEXueiGKXeLX
	1Lc26dp0YtbaZKPxdU5PAlEwm+pKDWQjxiNhd+2wWU1/q67UvXPeHluZpX3dyHgnBz8JaB5PY0ugC
	PhWI/RSjVdfh6Jbt4GRB3gWKJzAFhn2EbRtq9HeaL3XWkmmsZmE6L+2CuXiRPBVEO00nxLrK5hZsG
	YP6tGRxW5B3MhkVXPAIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFO-00000008Bmz-1lGS;
	Wed, 18 Nov 2026 08:42:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFM-00000008BlE-04aR
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 08:42:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78F101F7CC;
	Wed, 18 Nov 2026 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=kUEhRR1vZLFRIa5n2iA+AXa5lsLdysD2DzzJOqakSbPcMM7JOFUb7zzlUKixENSWyON6bS
	pGanODuWwxjnV71sRrUKGbpGZohofxy5trrWCPTbXFcUHtPuqKYyLFDz15KSoZvicA/h9m
	Th08GZglExi6qeiAxvcBM4tnQd7W8jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=t7EzEsFbUe8jjwy84MogHvgt9tTmwkBCY6YPO6X0j26rDTRMjLndpbGRfk4v9qPrCEXDpF
	TG9TeFFf6xpK6oBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=kUEhRR1vZLFRIa5n2iA+AXa5lsLdysD2DzzJOqakSbPcMM7JOFUb7zzlUKixENSWyON6bS
	pGanODuWwxjnV71sRrUKGbpGZohofxy5trrWCPTbXFcUHtPuqKYyLFDz15KSoZvicA/h9m
	Th08GZglExi6qeiAxvcBM4tnQd7W8jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=t7EzEsFbUe8jjwy84MogHvgt9tTmwkBCY6YPO6X0j26rDTRMjLndpbGRfk4v9qPrCEXDpF
	TG9TeFFf6xpK6oBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECBD134E9;
	Wed, 18 Nov 2026 08:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x3q5AvBk/WrOTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:24 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:21 +0100
Subject: [PATCH 1/5] check: unload modules when a test with a fallback
 device is skipped
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-skip-missing-deps-v1-1-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_004228_367075_F6442A14 
X-CRM114-Status: GOOD (  10.71  )
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

The requirement checks load modules, e.g. _have_scsi_debug loads
scsi_debug. When a test with a fallback device is skipped before the
fallback device is created, the modules stay loaded, and the next tests
that need to load the module themselves skip. A missing xfs_io for
scsi/009 skips the scsi and zbd tests that follow it.

Unload the modules on these early returns as well.

Fixes: 1967331d6667 ("check: do not create fallback device when other requirements are not met")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index e8613936554e..a0ce930942d8 100755
--- a/check
+++ b/check
@@ -761,6 +761,7 @@ _check_and_call_test_device() {
 		if [[ $TEST_DEV == fallback ]]; then
 			if [[ -v SKIP_REASONS ]]; then
 				_output_notrun "$TEST_NAME"
+				_unload_modules
 				return 0
 			fi
 
@@ -768,6 +769,7 @@ _check_and_call_test_device() {
 			fb_dev_file="${OUTPUT}/${TEST_NAME/\//_}_fallback_dev"
 			if ! fallback_device > "$fb_dev_file"; then
 				_warning "$TEST_NAME: fallback_device call failure"
+				_unload_modules
 				return 0
 			fi
 			TEST_DEV=$(<"$fb_dev_file")
@@ -776,6 +778,7 @@ _check_and_call_test_device() {
 			if ! _find_sysfs_dirs "$TEST_DEV"; then
 				_warning "$TEST_NAME: could not find sysfs directory for ${TEST_DEV}"
 				cleanup_fallback_device
+				_unload_modules
 				return 0
 			fi
 			fallback=1

-- 
2.56.1


