Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4E6C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=; b=WxEa/s8g0yriRz2Y1jHAZgHQGS
	zTmiYRehQXeSBmaw4T+o0JojHOqzpHRNV9FejZLMw88VF/CCQAdGfSdw+kMbjUejVwZHOyJl9hmf1
	rnRC4rAUgEbL4KeRIe4ruwVj4BlER97xtPOgvcCXxA9VA7fxmJsofjp6Xn16c6+KaqoI14KNt1anC
	Fv5aVxuvuRoEO/9E16o5twtgxhI0yvRpNJv651xku6x1r9Ow8sNB6u/LYIS03aR/mAEKn6UPUp+p/
	4hSIbtXQG1FPjLNEuJ9BQ3r6sL2dVTU0Z7BPNJHOYqXmqx9bji/8suSc4fXLKPbsiYJNHPhpgY+vc
	GH2vkGTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTkN-00000004vo0-0qAv;
	Mon, 12 Feb 2024 10:41:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTk5-00000004vdb-2l3Y
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:41:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84C71FBAF;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=feXXkulG+ZmbY3LZrDlJ4DVbmLQPxHyXlMg1lC+cGqDDk/Fl9jISd6y6pTBreAuJmMDNja
	AcNKFlG+KD7JbexZ6pICKw34MGYNrqRggLtp2UTUx2bGV4Vtn72sKrJuwkh/AbK8OJozQW
	4RP863Tbt9o+oaLAxUabVxbOkeShqzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=RYaeIo1yAg/+y5PmxEP1W4TgCVLeQ98BXFf/PDsm+B0zmgIeuRZWf7UsFTwBYcoRCmfdP7
	s6zvetRxM2EwN7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=feXXkulG+ZmbY3LZrDlJ4DVbmLQPxHyXlMg1lC+cGqDDk/Fl9jISd6y6pTBreAuJmMDNja
	AcNKFlG+KD7JbexZ6pICKw34MGYNrqRggLtp2UTUx2bGV4Vtn72sKrJuwkh/AbK8OJozQW
	4RP863Tbt9o+oaLAxUabVxbOkeShqzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=RYaeIo1yAg/+y5PmxEP1W4TgCVLeQ98BXFf/PDsm+B0zmgIeuRZWf7UsFTwBYcoRCmfdP7
	s6zvetRxM2EwN7BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B741113A0E;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ny9KK7P1yWXtCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/5] nvme/rc: filter out errors from cat when reading files
Date: Mon, 12 Feb 2024 11:40:43 +0100
Message-ID: <20240212104046.13127-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feXXkulG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RYaeIo1y
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C84C71FBAF
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_024053_913868_E507D85F 
X-CRM114-Status: GOOD (  13.07  )
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

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroyed while the tests
are running. This races with the cleanup code and also the
_find_nvme_dev() which iterates over all device entries and tries to
read the connect of transport and subsysnqn sysfs attributes. Since
these steps are not locked in anyway, the resources can go away in
between.

Thus filter out 'cat' reporting non existing subsysnqn or transport
attributes. The tests will still fail if they can't find the device etc.
But without filtering these errors out the tests fail randomly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e0461f1cd53a..9cc83afe0668 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -350,7 +350,7 @@ _cleanup_nvmet() {
 
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
@@ -840,7 +840,7 @@ _find_nvme_dev() {
 	for dev in /sys/class/nvme/nvme*; do
 		[ -e "$dev" ] || continue
 		dev="$(basename "$dev")"
-		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
 		fi
-- 
2.43.0


