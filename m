Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13225C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMwrVIRpWHhsRNZdxl13SCxJzgKbY6KdOYZIsTlSEas=; b=UfKdplMSl/gKgFkGQdcjCqMpQ8
	RKfpuu7GNdR06No7PTYqzNitGaZQf7FKwkj6MbD5dp1m/oDk9rRdnAO8OceVBC12XIcbRHvQ8UgYb
	L/uZEyKldLhb5yU7HOnDo7Qfz9gfGGT8pslQLlRoUT2eeupwtY8y1GkPs1jw567Gfw225pxl8+uhz
	HUkPuFJPoxuP+4g8OtqadPNe5g4sMxAnDdoArbPHvsQaHww0XYL1gPI/TpkR3l6UTO8OXwVvjyxjP
	uXhp2om3ZpQuPjpunJM1mU4gZJ9V5tYsLjPjZFQ5KrChqLGWdVv4EZby6MnTdJKblp1cO89yDVpVj
	2ek3obtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxH4-00000008i1y-3Aqu;
	Mon, 19 May 2025 09:59:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxA8-00000008fms-3h4B
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 09:52:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 945EC22722;
	Mon, 19 May 2025 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747648317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMwrVIRpWHhsRNZdxl13SCxJzgKbY6KdOYZIsTlSEas=;
	b=DcSb1JIo1kUHXuAl5yW6LZJXpzcFbMxnNDEt+IoaVim/fDISS4V6hTx8sbhQxi0ZLYpyLb
	7y9b5UrlbRmExJjmarqitBPwZQv7QUt0ilN+P/IyHrP5osnSNGHie6mxEFgVOpLxirVP3a
	D79QCDaPMakgWPi/tNraDd9fWtyu9kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747648317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMwrVIRpWHhsRNZdxl13SCxJzgKbY6KdOYZIsTlSEas=;
	b=LOHTqEZylo01/a6TGWZpgEYhlaGud5ot24ULvLonTSRMCVyrDRStaF8y6z6TmB68A5fPWL
	gPx4Gkot+ESTqtCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DcSb1JIo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LOHTqEZy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747648317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMwrVIRpWHhsRNZdxl13SCxJzgKbY6KdOYZIsTlSEas=;
	b=DcSb1JIo1kUHXuAl5yW6LZJXpzcFbMxnNDEt+IoaVim/fDISS4V6hTx8sbhQxi0ZLYpyLb
	7y9b5UrlbRmExJjmarqitBPwZQv7QUt0ilN+P/IyHrP5osnSNGHie6mxEFgVOpLxirVP3a
	D79QCDaPMakgWPi/tNraDd9fWtyu9kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747648317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMwrVIRpWHhsRNZdxl13SCxJzgKbY6KdOYZIsTlSEas=;
	b=LOHTqEZylo01/a6TGWZpgEYhlaGud5ot24ULvLonTSRMCVyrDRStaF8y6z6TmB68A5fPWL
	gPx4Gkot+ESTqtCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE1013A30;
	Mon, 19 May 2025 09:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62GHFjz/KmjsbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 May 2025 09:51:56 +0000
Date: Mon, 19 May 2025 11:51:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org
Subject: Re: nvme-cli & json vs blktests
Message-ID: <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
References: <20250519054905.GA6156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519054905.GA6156@lst.de>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 945EC22722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_025201_061833_5F9E5863 
X-CRM114-Status: UNSURE (   9.73  )
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

On Mon, May 19, 2025 at 07:49:05AM +0200, Christoph Hellwig wrote:
> make the nvme-cli build a little less arcane?

There is no magic build into the meson/ninja build system. meson creates
the ninja build instruction which are fully hardcoded, thus it wont pick
up any newly installed libraries on automatically. Running meson with
'setup --reconfigure' is a design choice of this build system.

I don't really see a problem with this approach.

