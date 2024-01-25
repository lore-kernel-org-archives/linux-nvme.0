Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77394C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=; b=nzozB1RE5HGUULSO9GN9LJC0sJ
	S8J4rPAYEY1DKTmB1WQCPY5ZYLBHqsWoGLTmuVP640L2AODAj75jKzOrFeEY6kSs9RYiFiHXPuOwl
	0w7qka6e0OG08SZ4bYH7lpDDr79lbdsm+cpVmMOF3MpgS0Hw15S58zx188fDgbE4hwe8FaYhgLre7
	knML/D9Vvc8j3t3NuZZA8unKUHo4as7ZvJuGEzXofASimBIRIQ+L3gR+0sGO9Q7TCVOBx+qO7aNSX
	0BW5XRx6fZLVcJkx74KHl6KpijJpgWKv/eITPinXAzig014jFnCCHRiOcrHKArh6bCm+O/j13tYfY
	t2d737WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0Il-00000000CBY-2bcA;
	Thu, 25 Jan 2024 14:01:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0Ii-00000000CAC-1ptY
	for linux-nvme@bombadil.infradead.org;
	Thu, 25 Jan 2024 14:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=; b=pax82tMJlrCgFhi+gl/lxGc6bA
	uaULv2B+JbeQMzgyJBgrQvM1954pk1ut531oM42xjAAuyynZD7plS7nw7fP+QZel96AfxWUHlELRc
	R/TJSlSorMYUYvpYNhcwbYEKwinvo5KINi3G5StVulKjpYM4AG3bzVrkhsB5ZBN6yvYyFGM70Wx6S
	2Pjs/T/qLUq+E/ULtL28xIwUYOP1orWytUBp9euNY3d4OgzBg80vU/qj5WboqpM6RXo709M/YhC2/
	N414tVBHp1OuwO7Wp4SRsVlJpDcAYjrwqHNhFyMF6AYTpqzv0IRUqMId0ZhWTkzFWekkjPgBh/X/+
	/a0EUd9w==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSxC5-000000054JZ-1S7Y
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 10:42:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E822921F33;
	Thu, 25 Jan 2024 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706179306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=;
	b=pv22fslllC2Ylt07OTPY0M+RGETT38D5DqOmiHFqu3K/2201ConCESEsZchRKaiBaKGY4x
	oRN6TXzxKQCNcDF/1GfQhkYdXr4E/LoO9LNKsyB+XIslV99JMpKXxWnhzrIbzchBiVYoHQ
	qLFymtuaCBLV/bbBJYy6ljKJrkAiUXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706179306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=;
	b=QMABEvKXpA7AyHqNHJfWWvNkd2QN/Q0z7SSFVUCcKRv00/UkM0VKlQs99HSyhGULByttMs
	nR2XYE70Ktc5MoDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706179305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=;
	b=q9fQM3dRADSzM6r8nT6cJ7vOlxGlk3vv2RyGdmOm3cEFD00XVe6mu27mQ+cDfWsFRhayes
	/jQU0BI2D9WMA/KEj7P8CLnmQbnhaAKZmnkRnGSK+ApgLegba61YQsqP1E5R9UyhaXAiS0
	ccl5t6moNGEBHh/J3WOu+X8e1XfuQBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706179305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pv05Ae6ozb69Dvbu35CA6yEmozfrY4ouTeerMOlNQyE=;
	b=e66CPAYa20UOhCgf75HtTMq4/ie8bQtnHhpLThwnL18mfbvaxjZMgQJ6pq0AMaXrI5w2Xo
	v5Y9aXHLpqGJLmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4B06134C3;
	Thu, 25 Jan 2024 10:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9TCBM+k6smVdagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 25 Jan 2024 10:41:45 +0000
Date: Thu, 25 Jan 2024 11:41:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Re: nvme-tcp: question on poll return value
Message-ID: <t5c45s5t5m7lzeqtl2oekyw2ofcql6xpjqmuowvmhbr5ebal5p@b7tapl5hh3dp>
References: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
 <fe3c18bb-36c1-4f5b-874d-1e30af6714fa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3c18bb-36c1-4f5b-874d-1e30af6714fa@suse.de>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q9fQM3dR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e66CPAYa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.40 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.39)[77.37%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: E822921F33
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_104249_748417_24A339ED 
X-CRM114-Status: GOOD (  11.70  )
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

On Wed, Jan 24, 2024 at 04:46:59PM +0100, Hannes Reinecke wrote:
> nr_cqe is set to zero at the start in nvme_tcp_try_recv(), and
> incremented for every request received.
> So we need to use the _current_ value of nr_cqe after calling
> nvme_tcp_try_recv() to figure out how many requests have been
> received, not the saved one (which will actually be the value
> of the _previous_ iteration of nvme_trp_try_recv()...).

Got it. It's obvious today :)

Thanks,
Daniel

