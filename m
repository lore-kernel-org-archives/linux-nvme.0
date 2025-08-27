Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14894CA0EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1we65nNMzHyKmNTaoD2M9HgNH0sB4NZFX633kLc4lSg=; b=dz0K8/hPP3EyY01P8Xxy78W98n
	xiiypD81v1WzrtXt/Z3mplpmYdNfQSLjtW4TWBaz3AtVT7AsmGBvspzRm8a1EY6Mv3LM11To+rygx
	+KuC530/OcNi6trtRMISgjSayf0Yie5rlsWRO3hUkX3enQ4NZsdSqStp+3WgHsJL/Eijg9d3Xz+GR
	g/PYAnDsG18/RqaI4N57QxjoiKV6xmbA7kE5XjSpzKiPbK5yCgg6gajvBMYvcIeJB4TH2zszBTgSZ
	0E9d5A9MDTr8ofn8wzAXkMG+P95Xhv61CpK9g5Tov+6AO3lLzu79Ud8dEe9sjZEQ+5U8hnyHnJdF5
	NAp6Nu1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urE1n-0000000FCkC-0sjX;
	Wed, 27 Aug 2025 11:09:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urDJQ-0000000F3LQ-3ryD
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 10:23:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F227F22278;
	Wed, 27 Aug 2025 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756290028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1we65nNMzHyKmNTaoD2M9HgNH0sB4NZFX633kLc4lSg=;
	b=0vC7DhKjhFuJxEVSPbhHhb1o64BpQKymHRqIo3wziheE8+KuQXo6IrqY7fzS++S+4i6KEx
	TdL22/iwMYUpC6bknYkmmKYnkpwAPQbUv1YetzV2f/90ZdA3cywl+0UWm2Cn70pTgBUcvD
	rPqTRfZxMa8RTyAmgeQOQz4QxhBFmYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756290028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1we65nNMzHyKmNTaoD2M9HgNH0sB4NZFX633kLc4lSg=;
	b=e3qH+iWnmP1onDRyE6YG7EbffUXP+NM3qBEGoLJaggsTZ3dzG1I8q1cburaSSkB5ZsCqjF
	B4fbbz1SUFixCrBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0Nscj8UG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cawzaXtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756290027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1we65nNMzHyKmNTaoD2M9HgNH0sB4NZFX633kLc4lSg=;
	b=0Nscj8UGZuyK+Irg9sWDXrpGYsyYkQIf7DJqbW1Aty+ZsQbUD4mBMoKhPTLOvpil/NlOOQ
	KJcNXmjzcHjnPnCTA9dw3wftJviXjcaqNLo/88yK6t5qfQ7O7a7EjVtjOOSuG21DzWx/Pc
	lJqTwOnrfJqsDkqzMUQMvbUDmSsJeks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756290027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1we65nNMzHyKmNTaoD2M9HgNH0sB4NZFX633kLc4lSg=;
	b=cawzaXtTYkATrtAr1MpEUBDcOih5uZFPYqlOv78XSKGEBoi/TDRtGWKq6cGc6vGrRh87X5
	/1lyMEGMLVucuTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA85913310;
	Wed, 27 Aug 2025 10:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EtdwNOvbrmhTKAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 27 Aug 2025 10:20:27 +0000
Date: Wed, 27 Aug 2025 12:20:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	james.smart@broadcom.com, Maurizio Lombardi <mlombard@redhat.com>, 
	Ewan Milne <emilne@redhat.com>
Subject: Re: [bug report] blktests nvme/fc nvme/057 triggered kernel panic
Message-ID: <e66f8c0d-6fb7-44dc-9060-9075c781a0cb@flourine.local>
References: <CAHj4cs9U48Xjd-ZShsP6GjZFyp7_Sp7i2gFdT-Btfvpouu4akQ@mail.gmail.com>
 <01a710c5-c559-4d4a-afa6-c9d542ea964a@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a710c5-c559-4d4a-afa6-c9d542ea964a@flourine.local>
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: F227F22278
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_032329_107084_BFEFC3DD 
X-CRM114-Status: GOOD (  17.84  )
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

On Wed, Aug 20, 2025 at 10:36:15AM +0200, Daniel Wagner wrote:
> On Wed, Aug 20, 2025 at 04:20:40PM +0800, Yi Zhang wrote:
> > My recent blktests testing triggered the kernel panic issue with
> > kernel 6.17.0-rc2.
> > Please help check it and let me know if you need any info/testing for
> > it, thanks.
> > 
> > [1] reproducer
> > stress blktests nvme/fc nvme/057
> 
> I will look into it. I've got a similar bug report from our internal QA
> which I have debugged but not fixed yet.
> 
> The async handling code is not able to handle more than one in-flight
> command (__nvmet_fc_send_ls_req). I was able to trigger the bug by
> running nvme/044 for the FC transport in a tight loop.
> 
> This might be related here, as it seems to happen when disconnecting
> from the target, similar to the stacktrace I see with nvme/044.

It turns out this bug is a different one that I fixed in

https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org/

I'll try to figure out what's happening here.

