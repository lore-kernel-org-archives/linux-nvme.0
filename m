Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4D3C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FebT9pXx4EWS9DDD7uGtIJAl/WWtPHNBTe8inii0ClQ=; b=OlvYE9DrTxJFTPlNOwefneG+P0
	HG7oDOMqxqWTvQ/2Dq1cxwedbBi/rpwtOisEOjiX7WWv7ZTyodJcsJ8AilInMsiPaVclGoMyCQGj0
	YWnOnk4jpaSk4nDlqUVaM4Sli74vO6NcPQ4vWDkUz9hoj6pntzSknElKls58Lo5WBDf253UDff4Ya
	VZmKXpUDlufNEOkRzPWdsUjwKB7xrsFoKbCHDgSF+aZqcC1ozoLq5Yx1AYbX7BubQt6RfC4rxt2b0
	dbOpH5sDnsJjBmuanMWZ2dhw8nRCrSswf7KGLdf65JRQOtdZjpxYDtdZ/X58gNXzIC4KcDVYePvcR
	nfHwoqYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTkP-00000004vpH-0n2x;
	Mon, 12 Feb 2024 10:41:13 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTk5-00000004vdp-3EPC
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:41:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA591FBB3;
	Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FebT9pXx4EWS9DDD7uGtIJAl/WWtPHNBTe8inii0ClQ=;
	b=NJS/GzaP5+MmixUWmNcy7fXMDekdIP9FgRTfe7JRMKmBBgLSAhjlMhqzDJciqcemGi18bK
	ca9HnM3cbwQbmN23keP8+247IuHG7yIoWW7lkO7kpKQW/ug7mcFEeOllHbYQtn7Fetb7Du
	A0op10tBTqfpLIwYCX/ONpChQmZ8wII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FebT9pXx4EWS9DDD7uGtIJAl/WWtPHNBTe8inii0ClQ=;
	b=3O8XBbnmLkKmg3A2sl8y7K+0lXbtUIGOK8lqMelxLTE9EJJXLzu0ap/KhOsAZMfhoBLFib
	RGjFEbcHx7kixvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FebT9pXx4EWS9DDD7uGtIJAl/WWtPHNBTe8inii0ClQ=;
	b=NJS/GzaP5+MmixUWmNcy7fXMDekdIP9FgRTfe7JRMKmBBgLSAhjlMhqzDJciqcemGi18bK
	ca9HnM3cbwQbmN23keP8+247IuHG7yIoWW7lkO7kpKQW/ug7mcFEeOllHbYQtn7Fetb7Du
	A0op10tBTqfpLIwYCX/ONpChQmZ8wII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FebT9pXx4EWS9DDD7uGtIJAl/WWtPHNBTe8inii0ClQ=;
	b=3O8XBbnmLkKmg3A2sl8y7K+0lXbtUIGOK8lqMelxLTE9EJJXLzu0ap/KhOsAZMfhoBLFib
	RGjFEbcHx7kixvBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A67A13A0E;
	Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PvegFLT1yWXvCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 3/5] nvme/rc: do not issue warnings on cleanup when using fc transport
Date: Mon, 12 Feb 2024 11:40:44 +0100
Message-ID: <20240212104046.13127-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NJS/GzaP";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3O8XBbnm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.39 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.61%]
X-Rspamd-Queue-Id: 6CA591FBB3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_024054_004127_01D772DD 
X-CRM114-Status: GOOD (  12.46  )
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
are running.

The cleanup code expects that all devices are under blktests control,
but this isn't the case. So just disable the warning as it is reporting
a lot of false positives.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9cc83afe0668..ca6a284a1e25 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -352,7 +352,10 @@ _cleanup_nvmet() {
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
-			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			# if udev auto connect is enabled for FC we get false positives
+			if [[ "$transport" != "fc" ]]; then
+				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			fi
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
-- 
2.43.0


