Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AACD1280
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=; b=S7OTpcaodJrMP53pKRM10cdMlC
	/Gj8ysCI7twua6ZNwKlhnNYbbdk1f/GLf/oGgJm90f12dfFulRffRCsWmLyMOlNqfJbVpxc+1jRKf
	4Xro6WI9i99ICPxTkhAJSHJctIvyvFuMjUb1+4CWPu58d35JQM1r72QCuj95QB676xurP9lNczu+z
	zvmxfIx3QYCxe94/nVseaFdFUFpxM4zH59Kue9zVIPztGiqKehMt4nwBGs5Y9GnL2qYezXlPPtEW4
	1ILOM/d6oSj3C3JGXLOOX1Wh6JEDnG4b6cShxseVDwA2UR4FZVQXhoUU9MGN+4qEnQrhYvV6O61tk
	Ttr3a4+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7bp-00000004s4g-26yR;
	Tue, 26 Mar 2024 14:17:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d1-00000004c0p-2DTa
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=; b=OUBR8OMl6p8W0ST2Q+J1ZLPehj
	K0FiKKtXws3BNfZToobg8IXN/Jf+NPdftsAi2G7yoWcoe4YgrFyYOqy91OWQUo2KXj6qTpuZ9DFeB
	PKlBpQcyIrHnkifS6zm4WPh2suIYSEI8nh+yjeNR14iahB3aBUB0JLLLOg1Oq+o9uO6krMjo+S9eO
	VKWeabhGIl2dPqIosa/nJLoJbOlCN3CpaYWD4GxPPvLtPZUEUtUWTEykt/T9Ly8kIoLfcCRM6gglV
	Fh36t9JT8KRCXEAG6I51wyk0vdM6lYPN+RGPV2rqoFWuQpdLUhLWg42F+3oXrH0ds2zfOLk5R34Zx
	WnllQuKA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6cy-0000000HAwL-1rc4
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:10 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDFB5D652;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=ovuhBFWwdn/dYh+5enRJmkPMmIoBAh9sSvl+hXlync638ZqkDENZMm3acOrKkjoyc9vr25
	8zYiNal0ODShwhSs50OH2oj6G+qHFJZOPrcaUV6LwhCJVuaPLPF4o118tXYj85zgVG8M1Z
	8U2wBX5Rd8j4NZGrumV1FxYI/KoHUiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=CBegQxT9aqXCnWtOEeZ1U7W3xRarZ4wKLQh9lxHdLhcrPTyE49nU8E1aNSn6YCEASBzmx3
	sKrqo6HdrjcvecCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=ovuhBFWwdn/dYh+5enRJmkPMmIoBAh9sSvl+hXlync638ZqkDENZMm3acOrKkjoyc9vr25
	8zYiNal0ODShwhSs50OH2oj6G+qHFJZOPrcaUV6LwhCJVuaPLPF4o118tXYj85zgVG8M1Z
	8U2wBX5Rd8j4NZGrumV1FxYI/KoHUiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=CBegQxT9aqXCnWtOEeZ1U7W3xRarZ4wKLQh9lxHdLhcrPTyE49nU8E1aNSn6YCEASBzmx3
	sKrqo6HdrjcvecCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D8F213587;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hKD1AR7KAmb8NgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 01/20] nvme/rc: silence error on module unload for fc
Date: Tue, 26 Mar 2024 14:13:43 +0100
Message-ID: <20240326131402.5092-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovuhBFWw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CBegQxT9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.58 / 50.00];
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
	 RCPT_COUNT_FIVE(0.00)[6];
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
	 BAYES_HAM(-2.91)[99.62%]
X-Rspamd-Queue-Id: 1EDFB5D652
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131408_596036_547EE971 
X-CRM114-Status: GOOD (  11.65  )
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

The other transports silence the error output when trying to unload the
module. Do the same for FC.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2d6ebeab2f6f..78d84af72e73 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -332,7 +332,7 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
 				"${def_remote_wwnn}" "${def_remote_wwpn}"
-		modprobe -rq nvme-fcloop
+		modprobe -rq nvme-fcloop 2>/dev/null
 	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-- 
2.44.0


