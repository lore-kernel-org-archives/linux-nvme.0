Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92402C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbTO1ZmKVQNV93J1XFPp+keZlTkWNJtbg65OfZwYmm4=; b=L0LpPWCGBr5NO2+MiQgxSarTAX
	41VK8MQO6hg8wGtIuQn6BzRwTyjNjmkdVxhzR78dsbQ29B+JHaChzCERQpufn/cuAtsa3Tzo6KgFV
	2oqZtxSamghvS297K+bKQvQ/Lrovb5s6Dk8BeOk9c2YsCxIQtnvKbPFpVqOccxv0xYe3QbCFon1Kf
	TRUZ5a3VYO/M6LYOGDKOoqX89mU7qkY6oxt+I9uCOs2E8Yrv8JRyAvBxUa5PXo1130XhrANVO927P
	2Oirq8dTzrIHcyAd+6XeUA1Fu2UywN4R1725HHlu0PEz3iRJcwmA2hqRdm9Qlqcd8v1iQ9+1k5W0J
	g0ymqCPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwCe-00CiF2-2L;
	Mon, 22 Jan 2024 15:27:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwCb-00CiCl-2d
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:27:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03F9F220B6;
	Mon, 22 Jan 2024 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705937228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTO1ZmKVQNV93J1XFPp+keZlTkWNJtbg65OfZwYmm4=;
	b=HoMbFEQWnqc7B9Vwp/DgZ+DenZXcNIx4f3hIOTpENuswT8l3WcAVGEeJfAO/FiyGD8nzSu
	ALHzPAbXNFGBiurWZZFCPaTDIoO4k6Cnr2zhMMJokm3YZnPeGGjAGCGQ5ArJhT97MTeTDM
	wbTV0Eqi5XtOzmlTn+6lh6h4Sq4uBvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705937228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTO1ZmKVQNV93J1XFPp+keZlTkWNJtbg65OfZwYmm4=;
	b=o+TstFiM6KqztQ+33jg6omIqqN/yyxC0kvi790M+A20JNNoiPf/0VxlLaRjBzL1ulv8o6T
	65+awBhFM1tj3pDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705937228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTO1ZmKVQNV93J1XFPp+keZlTkWNJtbg65OfZwYmm4=;
	b=HoMbFEQWnqc7B9Vwp/DgZ+DenZXcNIx4f3hIOTpENuswT8l3WcAVGEeJfAO/FiyGD8nzSu
	ALHzPAbXNFGBiurWZZFCPaTDIoO4k6Cnr2zhMMJokm3YZnPeGGjAGCGQ5ArJhT97MTeTDM
	wbTV0Eqi5XtOzmlTn+6lh6h4Sq4uBvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705937228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTO1ZmKVQNV93J1XFPp+keZlTkWNJtbg65OfZwYmm4=;
	b=o+TstFiM6KqztQ+33jg6omIqqN/yyxC0kvi790M+A20JNNoiPf/0VxlLaRjBzL1ulv8o6T
	65+awBhFM1tj3pDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E41FF136A4;
	Mon, 22 Jan 2024 15:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LctcNkuJrmU9aQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jan 2024 15:27:07 +0000
Date: Mon, 22 Jan 2024 16:27:07 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com, oevron@nvidia.com
Subject: Re: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI
 offload
Message-ID: <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-8-mgurtovoy@nvidia.com>
 <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
 <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HoMbFEQW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o+TstFiM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.28)[96.65%]
X-Rspamd-Queue-Id: 03F9F220B6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_072710_011838_60115C2C 
X-CRM114-Status: UNSURE (   9.94  )
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

On Mon, Jan 22, 2024 at 05:17:11PM +0200, Max Gurtovoy wrote:
> > What about 'enable_pi' instead of the inverted boolean logic?
> 
> we can't change the default behavior (that is "enable" by default).

But couldn't we just have

    enable_pi = true

as default then? This should be the same as

   disallow_pi = false

?

