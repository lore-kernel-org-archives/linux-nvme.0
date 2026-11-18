Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA36606A89F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mGCRl5Ko;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bw6eRs/k;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bw6eRs/k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=; b=mGCRl5KoOzBrL+
	8utoA8/Snrpv+oozPff56mRCs3WL5wJAvfqVrU47RIBeqAjS1uW3aMgHuMwNZoQZ6Zr7svpqHTY/v
	ZHJCQOq3u78KYyUOuPzmZ2DVDqHyRfhHmtuanOuq7wOVkVQYrMM8GqksSH/a/w8etKaRw4HmS8Si8
	CEnlZDIwzIyUqj3tr/YNLgCkiPgdYuWoQgx7E6LFJYrP+vCJnTZpOXgSr4KF6BbYNC5RnKs2SmrRQ
	oAXY3gFmra1xymQY38zcuujgJIzZwxemQWCS1NicKOqvYWi5yHTP/YyOk+a+qV/l8JIzZ2KCKtnN9
	AR3z61AYbcPyzvqZg5ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFV-00000008BrX-39w9;
	Wed, 18 Nov 2026 08:42:37 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFT-00000008BpK-0Ub4
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 08:42:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A9A21F7CC;
	Wed, 18 Nov 2026 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=bw6eRs/knqf8gHKfwQCl5w4vo+ZpyWzzRwxX6JVXsT9SRCnXlI6BI2KwDmhtV4FLULxJgr
	2j9+FRDHv4wZ2iH8fgdopnVlTBbZ66ySRm9ktEsx98jE684zDnlBCParkt2WQ+IV104vWq
	gdBJEJyHDer8xrxlgp6z5ST+wA4QlZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=YXA2qfntGus0fvyx2cgRudfFg8mp2bck06/nEpbwVll/NYc+V0YlvUAjtyeqvjEIUEgjs3
	wFe1OrxgwqWf02Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=bw6eRs/knqf8gHKfwQCl5w4vo+ZpyWzzRwxX6JVXsT9SRCnXlI6BI2KwDmhtV4FLULxJgr
	2j9+FRDHv4wZ2iH8fgdopnVlTBbZ66ySRm9ktEsx98jE684zDnlBCParkt2WQ+IV104vWq
	gdBJEJyHDer8xrxlgp6z5ST+wA4QlZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=YXA2qfntGus0fvyx2cgRudfFg8mp2bck06/nEpbwVll/NYc+V0YlvUAjtyeqvjEIUEgjs3
	wFe1OrxgwqWf02Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41929134E9;
	Wed, 18 Nov 2026 08:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RMHpBvlk/WoMTwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:33 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:24 +0100
Subject: [PATCH 4/5] block/009, block/012: skip if hexdump is missing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-skip-missing-deps-v1-4-a9b4a5a7cc94@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_004235_319217_E820C243 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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

block/009 and block/012 compare the device contents with hexdump, which
some distributions ship separately from util-linux, e.g. Debian in
bsdextrautils. Check for it in requires().

Fixes: 576668a4a6b1 ("add: Check page-cache coherency after BLKDISCARD")
Fixes: 3aeec46f048b ("block/012: add test for BLKROSET/BLKROGET ioctls")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/block/009 | 1 +
 tests/block/012 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/block/009 b/tests/block/009
index 8995646e5d21..1e3bc8ece8cf 100755
--- a/tests/block/009
+++ b/tests/block/009
@@ -14,6 +14,7 @@ DESCRIPTION="check page-cache coherency after BLKDISCARD"
 requires() {
 	_have_loadable_scsi_debug
 	_have_program xfs_io
+	_have_program hexdump
 }
 
 test() {
diff --git a/tests/block/012 b/tests/block/012
index c92f5b4b8dd2..430a3ac7f0b6 100755
--- a/tests/block/012
+++ b/tests/block/012
@@ -11,6 +11,7 @@ TIMED=1
 
 requires() {
 	_have_program xfs_io
+	_have_program hexdump
 }
 
 test_device() {

-- 
2.56.1


