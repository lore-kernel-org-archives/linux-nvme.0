Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F502CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=; b=GrI7vVcADEH1Aqe4yc77MxpKxo
	apwOea9boUE+DPrftUMRG/GbrisgWK6S4U6Sn1gcLPIJpfywCY1pSTV9CYcc7sUpmkgSe0aDZfvx2
	Zcgy8VkepI9Lqb5fX+hfUQzo3NjZL4IwJoofH2q2aGzs1R7zwFm+WZNpviQBcaFLpUOSS1/edNOdi
	z7kv/zOycNPq7RF9bk89XYPwT1bAj01Bra/T0ACT0vUo8e6t3ZEA+FuBpSKsljqmRxU7JQ7wmru5r
	sXG1+c9sAU9x0/jwibAcyWlQYWZk5xHNxi2ohEeJ8zAzRI3XN0MsDI0iWssXV6Jd2Ic61MM0KIJfT
	Y+Z6vhcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6ey-00000004cqj-00vN;
	Tue, 26 Mar 2024 13:16:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d4-00000004c20-41h2
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:58 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E09F37351;
	Tue, 26 Mar 2024 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=vuYtRdcGy1R005R3lAwAAxZ6ebJK9i21+IHVbXV/9Dq89dVJ516sTylPSYfIdzMGDm2i5x
	0Agq9y5mlhHUYAb9dTMIDitUsQ/zP3bdDZT5XxO8H/XdY+bjO1rt8zMKOSLooJxvC1/IC+
	Can0VQqVlw26/7CC3K+z3UWvNYwQLn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=wmhUHsz7FuTi3JVkirIaXoCMt+LsWeyfb5at8tcvjw5Eb+vnyPWoPSpHn8t0sEUrA29vcV
	+5vSusTOX5g4DaBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=vuYtRdcGy1R005R3lAwAAxZ6ebJK9i21+IHVbXV/9Dq89dVJ516sTylPSYfIdzMGDm2i5x
	0Agq9y5mlhHUYAb9dTMIDitUsQ/zP3bdDZT5XxO8H/XdY+bjO1rt8zMKOSLooJxvC1/IC+
	Can0VQqVlw26/7CC3K+z3UWvNYwQLn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=wmhUHsz7FuTi3JVkirIaXoCMt+LsWeyfb5at8tcvjw5Eb+vnyPWoPSpHn8t0sEUrA29vcV
	+5vSusTOX5g4DaBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C80613587;
	Tue, 26 Mar 2024 13:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cSn4ASXKAmYXNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 12/20] nvme/031: do not open code target setup/cleanup
Date: Tue, 26 Mar 2024 14:13:54 +0100
Message-ID: <20240326131402.5092-13-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.76 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.75)[98.91%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vuYtRdcG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wmhUHsz7
X-Rspamd-Queue-Id: 1E09F37351
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_061436_753447_2FCA8E7C 
X-CRM114-Status: UNSURE (   9.60  )
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

No need to open code the target setup and cleanup step. Just use the
common helper to setup and cleanup the target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/031 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index ed5f19668674..204ba7d2892f 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -40,14 +40,14 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
-		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
+		_nvmet_target_setup --subsysnqn "${subsys}$i" \
+			--blkdev "${loop_dev}"
+
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
-		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
-		_remove_nvmet_subsystem "${subsys}$i"
-		_remove_nvmet_host "${def_hostnqn}"
+
+		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
+			--blkdev "${loop_dev}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.44.0


