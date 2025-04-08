Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C910AC3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+EWI/rYLDpDWcLoT1gk2OQGbplBoq6edsbUSHdu3w0=; b=Vxdfv4JcYHdePRTeFjR+4NphsU
	mLRR92UZtk/Y9vBC36uLnuaX7+k7HQiy5V4VfD7XaG/6As2IC/ubYtgYDD5GPYZRyG+yrX1ChdNZF
	AU5wX/a1K/x3dx5c0637osUJbNwViISku88IDrHXBCeC230I3MzZXfAaKS+w7snBH0IJXa9FeT64n
	Y5/oN5ijkwWnGRLraR9y3IiFicqfSBZM+4hB0CiF+IceFbdvdPyZdiT77F2AfoyQidX6Fa2o4lvaz
	evf6g/K6xS2ZVj2jgpC9TukfaltumyTUKSbMMT3GyxDn0Uzq8yv+OgY6o46yJsRBFgRPAYJENKLCh
	lj7mVzzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28mN-0000000473K-3DmP;
	Tue, 08 Apr 2025 13:14:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u27Id-00000003sHi-3QVX
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 11:39:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B3391F388;
	Tue,  8 Apr 2025 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+EWI/rYLDpDWcLoT1gk2OQGbplBoq6edsbUSHdu3w0=;
	b=TCdaITZDtuMEcRszZMH930xMxKAavMv5f/eFicv82Zuze1R3tLYjKfFK9XkUQ3PZ5gpxYG
	ASyC/tO5TSDdqic7ymOrniq6asvy4j7xqXyEOs3MwxXyWsf38Fdvgc3XpbWxjv1WBPnTPo
	sGJP8QcURokEgtDz6Bz4ygehKkYDH5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+EWI/rYLDpDWcLoT1gk2OQGbplBoq6edsbUSHdu3w0=;
	b=jP/PKNyN4QibdtMiqmzJ8ekbvDCSVm0J1hxtwadRBydq71nRpxzBcgNZOXlUFAMWpEKQLf
	O1paKG062OVfCNBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TCdaITZD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jP/PKNyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+EWI/rYLDpDWcLoT1gk2OQGbplBoq6edsbUSHdu3w0=;
	b=TCdaITZDtuMEcRszZMH930xMxKAavMv5f/eFicv82Zuze1R3tLYjKfFK9XkUQ3PZ5gpxYG
	ASyC/tO5TSDdqic7ymOrniq6asvy4j7xqXyEOs3MwxXyWsf38Fdvgc3XpbWxjv1WBPnTPo
	sGJP8QcURokEgtDz6Bz4ygehKkYDH5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+EWI/rYLDpDWcLoT1gk2OQGbplBoq6edsbUSHdu3w0=;
	b=jP/PKNyN4QibdtMiqmzJ8ekbvDCSVm0J1hxtwadRBydq71nRpxzBcgNZOXlUFAMWpEKQLf
	O1paKG062OVfCNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D7913A1E;
	Tue,  8 Apr 2025 11:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fMIVDe4K9WeuDgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 08 Apr 2025 11:39:26 +0000
Date: Tue, 8 Apr 2025 13:39:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, 
	Steven Seungcheol Lee <sc108.lee@samsung.com>, Daniel Wagner <wagi@kernel.org>, 
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests] nvme/025: use character device for nvme
 effects-log command
Message-ID: <d22aecdc-092d-4d2b-a09e-01cc3fab1935@flourine.local>
References: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 4B3391F388
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_043927_998057_1A389A2E 
X-CRM114-Status: GOOD (  10.20  )
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

On Wed, Apr 02, 2025 at 04:37:27PM +0900, Shin'ichiro Kawasaki wrote:
> The recent nvme-cli commit aec85d96e07f ("nvme: add error message for
> mmap_registers") in the version v2.12 dropped the feature for "nvme
> effects-log" command to fallback target devices from namespace block
> devices to admin character devices. This made the test case nvme/025
> fail with the message "Block device isn't allowed without csi". To avoid
> the failure, use admin character devices instead of namespace block
> devices.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

