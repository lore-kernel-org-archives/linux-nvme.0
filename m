Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4715C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=; b=yc14n1luyG1eObCaMzBL1kO33l
	855iJyYA38yEZYa5eJnLLSsz+pz4yMb+aaOHf04FqLVljJ6GykAwcEXqJu3djm92DqcBpffL0fWcD
	zqVAGlYyY2iMGX4M3zC0p9UiYhhlcIhgTATzek4vJk8MKecQ9bsXEfZacPw2095x0roTzNn7Sf2X7
	XQDK2nmpCf3GG0gs/kj9A2QhTT4Ss1nchEJ2+l9ciRDwlF1kWn/foIj7dArNq7KHs2EuDsic9dyfN
	7KjE+CQgML4Bc6Ac6NaTDGJTtoOVt6Socomij+FTNPGDrCDtzgVYI/l9XX/EIfK4kfjbFEQ9CRnjR
	ipowYCqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6eF-00000004cR3-46P5;
	Tue, 26 Mar 2024 13:15:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dS-00000004c4z-2r9S
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=; b=Y3EpU0r6NaHcArgYZGIYyEIDU2
	DbZj1KAVVu418+4dyWN8xpdITDLJzDokxMq0mV5+4XjTQ0Ib2TWOvPGHDlrzup0LOJnqjp1dqCYit
	ozKpZ0sQihJH0JF++eEX7yhZTlIovatBqjMj4FHVrUwwbS+YgyKaxCbVepYE7RfQmr6+Ca15TL9hL
	o1kHVoN4ziXIhcTEfMf3hPDsEsKp8hLzLvRdYlbYdY8umOkIHnCBdstZwViC4IYzOIgP6nrEsFzqt
	Wi6G9dV6HWDUiWzFq7mWm5XgiqilLn7fSJTF7yzJzKMMnm9sFGTqz3QTSm8m3O5m2jSBrCcW8Ya5h
	pWfkKL0w==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dP-00000001KrA-19mD
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:37 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22FDF373CA;
	Tue, 26 Mar 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=urmC2Y463zI4LAuuayeqgr5nV3fFVV57tlaJDGEgthI5OIpFhnnk4phfamlpTgSA1HW1v+
	wFTpsgYzvuyosxZ+ZtuLsmC5rugHFgQeGnmhdRmIbwtIsycQnO7FaLhTfhvIRRaFyYVNJC
	ZhJh3fp+h3fX7cWjKf92Cv9fMBDhwWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=NLWZuotC8NqNpY45q7SuIC/94cdKyyRHdCVyR/95128+QqX+UWSw97GWDliTHVwyiV2/1v
	ZZSNkgYeU/vjZMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=urmC2Y463zI4LAuuayeqgr5nV3fFVV57tlaJDGEgthI5OIpFhnnk4phfamlpTgSA1HW1v+
	wFTpsgYzvuyosxZ+ZtuLsmC5rugHFgQeGnmhdRmIbwtIsycQnO7FaLhTfhvIRRaFyYVNJC
	ZhJh3fp+h3fX7cWjKf92Cv9fMBDhwWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=NLWZuotC8NqNpY45q7SuIC/94cdKyyRHdCVyR/95128+QqX+UWSw97GWDliTHVwyiV2/1v
	ZZSNkgYeU/vjZMCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FDAD13587;
	Tue, 26 Mar 2024 13:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id znFeAirKAmYqNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 20/20] nvme/028: drop unused nvmedev
Date: Tue, 26 Mar 2024 14:14:02 +0100
Message-ID: <20240326131402.5092-21-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.85%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131435_417181_A06706D5 
X-CRM114-Status: UNSURE (   7.88  )
X-CRM114-Notice: Please train this message.
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

Nothing uses nvmedev, so just remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/028 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/nvme/028 b/tests/nvme/028
index 4710bba1f416..9f4a90581984 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -20,15 +20,10 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
-
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-- 
2.44.0


