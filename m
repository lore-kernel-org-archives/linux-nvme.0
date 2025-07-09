Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF27C83F0A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2YYcGO0EUX71lm7Td2l2zfWJT8OOfCPZdAKcK5bh3I=; b=rdp1qHwbWetZa9Vq6CyJWdD0A/
	P01AfUEldOPaTxlIIUoB3dQM0uOzcXgTwSSHOpCZrSmQX6V7FGRs/0Iu4F0nh2R40lP2kNUWVBbbm
	WDLFaVd4Yz2JBjWSa3UOcHoC41dQyaxJon1SXUYhhpV4I9UB9uTFxZ0mzkh4miwHByqBaVMUGb0g0
	4aEz/EnNfTTRZn8blUNBMn2Ov0AszKkOH/aE3dLLA994+gswLggIDs/BV7T7P7s5RD3X+NXdgg6bd
	Bbc0rpnRsK9Za6jgzyap+iU9ttGPAMsYAi32N4LyE70/6d4x8LikZDsxpIrxD25Q9mW77n8NRiBWd
	bs6OnsYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZX7d-00000009Dn6-22U9;
	Wed, 09 Jul 2025 15:54:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZUpO-00000008mZl-2cgl
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 13:27:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D2632117A
	for <linux-nvme@lists.infradead.org>; Wed,  9 Jul 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752067633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2YYcGO0EUX71lm7Td2l2zfWJT8OOfCPZdAKcK5bh3I=;
	b=fWmhuXtCXvwcGUotFviLi+gsyevBHEy0LtUjeWLH+EfygcSdfVt3tzn1ccn6bElJd6aHLI
	Ak5x1Z64NGpFm7aR0752erYX89V1JUshXg7ZcnemTuIusKQWni4MBp2e7kSv/yrWJrd5Zk
	WBZTJdQ3g6vmd6ThZwQKybLowSvv1n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752067633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2YYcGO0EUX71lm7Td2l2zfWJT8OOfCPZdAKcK5bh3I=;
	b=D7atHErzb22kgERKt3ADkxhacGiY/KCL6H8LoWlx98bmW4BFvy+Le70xZ064zrVlO6bZuV
	BGsB0vebt/P3FxCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fWmhuXtC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D7atHErz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752067633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2YYcGO0EUX71lm7Td2l2zfWJT8OOfCPZdAKcK5bh3I=;
	b=fWmhuXtCXvwcGUotFviLi+gsyevBHEy0LtUjeWLH+EfygcSdfVt3tzn1ccn6bElJd6aHLI
	Ak5x1Z64NGpFm7aR0752erYX89V1JUshXg7ZcnemTuIusKQWni4MBp2e7kSv/yrWJrd5Zk
	WBZTJdQ3g6vmd6ThZwQKybLowSvv1n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752067633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2YYcGO0EUX71lm7Td2l2zfWJT8OOfCPZdAKcK5bh3I=;
	b=D7atHErzb22kgERKt3ADkxhacGiY/KCL6H8LoWlx98bmW4BFvy+Le70xZ064zrVlO6bZuV
	BGsB0vebt/P3FxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3965136DC
	for <linux-nvme@lists.infradead.org>; Wed,  9 Jul 2025 13:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xS4PNTBubmgOWgAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 09 Jul 2025 13:27:12 +0000
Date: Wed, 9 Jul 2025 15:27:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme v2
Message-ID: <8e0b4870-830e-4ae1-b60d-4a722a88bc4c@flourine.local>
References: <88fd24ee-790a-44e2-aa89-66e9127346db@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fd24ee-790a-44e2-aa89-66e9127346db@flourine.local>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0D2632117A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_062714_808544_CB51D215 
X-CRM114-Status: GOOD (  14.82  )
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

On Wed, Jul 09, 2025 at 03:24:01PM +0200, Daniel Wagner wrote:
> I've started working on v2 of the library. There are several reasons why
> I think it's time for a major update.
> 
> libnvme added the MI APIs after the initial v1 release. The v1 APIs use
> file descriptors as "handles," which do not work for MI (there are no
> fds). So, the solution at the time was to duplicate a lot of APIs with a
> different kind of "handle." The main issue here is the naming for the
> new handle. I went with struct nvme_link, but I'm sure there are better
> names. While I'm not keen on renaming (a hell of a lot of hacking), it's
> better to have good name [1]. So let's start the bike-shedding.

Forgot to mention, the diff stat is nice:

 40 files changed, 1903 insertions(+), 4734 deletions(-)

