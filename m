Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4E2103E168
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRlFZNRo7B1S54lKAQFnagJRoVj2t9FAWxbEyIoUHrU=; b=hD8LiGf1rRgXGMXcVB6SAxvXV7
	W/lrvDWwuhgA1RrnhACM8nS+dqQwRZXNj+6xuihpAwD2qSAXMk7nwTDkCw31M5aE+FU6/4DBouxwF
	d+6XA2nulNbUAfezXksiI616GOqdGLQKeGjbbXNlP9YW8FJRHKC1b18cZhAsXG+wafZPQrZEJnQFX
	bk7E9PwOvwQBdqgGL6IZ8yjn4y3QaIPo/+2b8AUsBMLZMdPjpKslnnAn2EcQupjLyc9JEk4VA5xda
	uuhwcHala2btYQkndWX5tIY4yB0dEbtq3IREQcF4Ua+JQAiH6eNcb2qKhrbV2881iNSIj6+sv1mxK
	PRFaiqLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2pjQ-00000008Mlq-2p1K;
	Wed, 18 Mar 2026 12:10:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2pjO-00000008Ml6-2P5Y
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 12:10:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B1995BEB1;
	Wed, 18 Mar 2026 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773835832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRlFZNRo7B1S54lKAQFnagJRoVj2t9FAWxbEyIoUHrU=;
	b=mm2remiIE28XSJ5A5Bjqvqer19KcRsuTj7ngSoaRWpwXn1faOXUUwjGPZFQMnaEs4Grdco
	bEn2zggy2fLL1hywObqz4QJt4FMpqkPf8ymGmnSl6kjDx4L/YZfJ29weEtxt4D3tBR0AIi
	XmrsZpgJ9iTd7nuLUPnr5Uc3V0VqdWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773835832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRlFZNRo7B1S54lKAQFnagJRoVj2t9FAWxbEyIoUHrU=;
	b=X8KEEFPeFu1/OsSOhjFK4KsvKYbK+cvfP6ine4IUY3bZt8ZOX/HyFvsPu/gQf00vXWygZs
	AMHKRnQq4MNSnJCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mm2remiI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X8KEEFPe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773835832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRlFZNRo7B1S54lKAQFnagJRoVj2t9FAWxbEyIoUHrU=;
	b=mm2remiIE28XSJ5A5Bjqvqer19KcRsuTj7ngSoaRWpwXn1faOXUUwjGPZFQMnaEs4Grdco
	bEn2zggy2fLL1hywObqz4QJt4FMpqkPf8ymGmnSl6kjDx4L/YZfJ29weEtxt4D3tBR0AIi
	XmrsZpgJ9iTd7nuLUPnr5Uc3V0VqdWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773835832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRlFZNRo7B1S54lKAQFnagJRoVj2t9FAWxbEyIoUHrU=;
	b=X8KEEFPeFu1/OsSOhjFK4KsvKYbK+cvfP6ine4IUY3bZt8ZOX/HyFvsPu/gQf00vXWygZs
	AMHKRnQq4MNSnJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 164E44273B;
	Wed, 18 Mar 2026 12:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HWpjATiWumkaTwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Mar 2026 12:10:32 +0000
Date: Wed, 18 Mar 2026 13:10:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: libnvme API review
Message-ID: <4a6270e2-258c-4ab2-84d7-a6f60e9169b6@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <2e26ab34-5568-4b5e-bfbb-7466eb515f13@nvidia.com>
 <f469ac91-a55a-4b19-b251-31081537d403@flourine.local>
 <b13a6910-07c8-407e-8267-13c9a60f2898@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13a6910-07c8-407e-8267-13c9a60f2898@nvidia.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B1995BEB1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_051034_793893_865E10BE 
X-CRM114-Status: GOOD (  12.53  )
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

On Wed, Mar 18, 2026 at 12:20:55AM +0000, Chaitanya Kulkarni wrote:
> Yes I did and then I looked into the spec, then I found that spec may not
> be that consistent as we keep the code consistent and forcing that
> consistency on spec for the code is not a good idea in long term.
> 
> Hence I'd like to withdraw my earlier argument of sticking to the
> spec.

As I said, my motivation is to make the APIs a bit more consistent and
rename the odd balls. Following blindly a rule is not really my goal.
There will be always cases where the correct name is just a bit stupid
(for fun look at mi.h)

