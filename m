Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A026DC2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=; b=P+M4L/h0Xj1sJu3FGTyJC8eX6G
	S3YAEZG1osccyLQ5obyBx9vY6Q1rZRNGAYrev0WemS+h0jH8g5AB8AmgLm0ciKgOOVb3N4tCN+Nup
	N4yEcMEOdSwoIM32/TouzVZGltX9GI3ciOckDni/PnvQiWcucebBM+O8RauuSyi0MOS9YhhqHzUkF
	NPqF2Q9cNo0hVob/qBYkQwDAuE5F1IKVhwK+VqrvHbw2Yf7Ex+zeYFspS1+njheU/5qBNb51H4PVk
	O3VBP4zqOZz76SkdXBtbMSf/EFOUJgX1UzoWVgtYVZFYs7gVZINybQadyDVIgsrN+wOK0FiAK9nwr
	yph/YToQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmZD-0000000A0lr-10EA;
	Thu, 27 Jun 2024 10:41:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmYz-0000000A0iT-1c5a
	for linux-nvme@bombadil.infradead.org;
	Thu, 27 Jun 2024 10:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=; b=a4zxsElH0QzPhfowTi+lK4lEEX
	p1q1baSGdsh36blPhzPZxJc5EcOnJkUKLxW/VVhXUGtJ+0hxhftlh7oFpGlgglTd1+TeSMt5T4pL6
	8SftCvzmU06iMm2L7RA2B0etkqSPTrEhrHooY+ZgBbhmjidwoivHYSxUnMp+U5kvud15j1nYmA6D7
	l7P6DnNgzm7kDYfZoEgeCXk/gQYgZq1fYp/KzCUr8LccA2yH2O1SkV0ioHLoOJeGOUZap0qWiMy9F
	I5QUtHKWrD2ALpSyGWbXMwOnVlPWztph/gicL9LNAWTH6LCgfT9kX/ltGBFjS2MhkOZ5vEhc3dQ/v
	FcucWiJA==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMl9N-00000008mXR-004T
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 09:10:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 415D01FBB2;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=nEIuchUcGD43EelAryCcNYc66hdkWHRb6BlptaF1wVKvBXO4dh9KLMlMw13dB4af9v9EQr
	jvL+ta1W4mlKmYKBX6ie9DuyBPrXd4o5iC0NZeInQ5z+c+TpG7Fjhokka7dKWLIRl5kuQv
	GRypWCJt/qrUlL9XXq1bOUwDjPzofgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=pzKpR2xX8wEsHtb49chnzo95DW1vchReri9mlar9zEzd9ojEg9ho6CurNFtIXkw2TzOVTo
	MzLzI9omNGZjvUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=nEIuchUcGD43EelAryCcNYc66hdkWHRb6BlptaF1wVKvBXO4dh9KLMlMw13dB4af9v9EQr
	jvL+ta1W4mlKmYKBX6ie9DuyBPrXd4o5iC0NZeInQ5z+c+TpG7Fjhokka7dKWLIRl5kuQv
	GRypWCJt/qrUlL9XXq1bOUwDjPzofgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=pzKpR2xX8wEsHtb49chnzo95DW1vchReri9mlar9zEzd9ojEg9ho6CurNFtIXkw2TzOVTo
	MzLzI9omNGZjvUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3289D1384C;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hQt0C4gsfWbAFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 09:10:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/3] nvme/030: only run against kernel soft target
Date: Thu, 27 Jun 2024 11:10:15 +0200
Message-ID: <20240627091016.12752-3-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
References: <20240627091016.12752-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_101042_768722_3AF4FE85 
X-CRM114-Status: GOOD (  13.54  )
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

This tests is exercising the target code and not so much the host side.
The problem with nvme/030 is that it depends on interface to interact
with the target which is not covered by the standard. Thus we can't
run it against a real target. Just skip it when we run against a
real target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index b1ed8bc20908..ae7081d55354 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4465dea0370b..5e2e440ccd47 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -225,6 +225,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_nvme_target() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		SKIP_REASONS+=("Linux kernel soft target not available")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.45.2


