Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D30CC54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=; b=ODpOHoM6T20vRRg8eimjU2vvkn
	WFcSnxM3NFEGxxTK7aKC8TMTTMAIxAvCjdoBaFSINxahJYKbJTNvMGunqXier39czmtQ1ZMFM5KFr
	LPXaFklmzCYnutOTDi4hl4letJErFlQySxM9EExW9habJ28sD0neDbr/XFawyYrU5s1gFQ/tHRD0m
	DgtSGz1UDR9EBIZcVlYvz8ehd6DWOYHvGGz6NgzkAlHVnQ+6np0L4MS9+/RSJ/fXWWWic3aS3kuT5
	fYfekvHItSbUjIr0VcB5l1C4P3UtAFZjJcbR8Y0Ta4rPhvX2jkhs88AzNK/jq2/kfrtNTr2MMyuFy
	FDp+w5/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGBw-00000002i1c-0dUg;
	Thu, 21 Mar 2024 11:02:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1a-00000002Wr0-42sV
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:48:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58C385CBCC;
	Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=RVslSzArKJDfiohV2a64oRr66E2t9iyYVMre+McVXgiFpE1lYG9GwzbffINPUXq0EQgw2x
	tH5oXgSZ5atahwqt+HhKpejs5RFKNGaRksQDaAm16x599pPYfvkGImZp27bhUiHi5AU8rE
	7pEF2aNlBeGv4Nt8tY1TVezDnQs/uKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=//TN9HGfmgPwoXTbvT7zWssKCS+o3+Xd0GfTV9fOKY/DUwJoRwmU1H4WacIAtemWyUmVnk
	1oV2WKSB1EeErvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=RVslSzArKJDfiohV2a64oRr66E2t9iyYVMre+McVXgiFpE1lYG9GwzbffINPUXq0EQgw2x
	tH5oXgSZ5atahwqt+HhKpejs5RFKNGaRksQDaAm16x599pPYfvkGImZp27bhUiHi5AU8rE
	7pEF2aNlBeGv4Nt8tY1TVezDnQs/uKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=//TN9HGfmgPwoXTbvT7zWssKCS+o3+Xd0GfTV9fOKY/DUwJoRwmU1H4WacIAtemWyUmVnk
	1oV2WKSB1EeErvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481F113976;
	Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSgqED0C/GXxDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 18/18] nvme/028: drop unused nvmedev
Date: Thu, 21 Mar 2024 10:47:27 +0100
Message-ID: <20240321094727.6503-19-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RVslSzAr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="//TN9HGf"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.95 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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
	 BAYES_HAM(-2.94)[99.73%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 58C385CBCC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_024751_348725_E7C0A6CD 
X-CRM114-Status: UNSURE (   8.25  )
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


