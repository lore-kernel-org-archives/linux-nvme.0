Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E773F33811
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=; b=EdFnsPQubdZZ7bBdHHB8j1xJ2g
	Hnr/qcRd3VZJrFydQRMB9JUSC3sCzNoaKD7f6cAQV/4jgLZ9YHwYU0xNCcDzyto5vLqeY9umVmOhQ
	zdiIVNTMO+D6ZJr7GiDR5Mix46vW39R18eN2PMhB2dIjHlSit1Gn2qzyUUMESi12sLbmCrvKATTzG
	GmOAo9UQ/mPAni2fSapKQadOcSzX5/MaW6NMudcmTxi6ZVcsB++2grsfn25CYsXuayA/qGSnEICq0
	QpBRvPNjvRzL7c+u2ih5BwwGyTPp1RA4dvj/CNenz2bKqRLpv/RabjpKsU/IbKUB/IMWv3b6cmr4/
	LXp2CNCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QkV-00000005sDS-0K1W;
	Tue, 17 Mar 2026 09:30:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QkU-00000005sD4-19vn
	for linux-nvme@bombadil.infradead.org;
	Tue, 17 Mar 2026 09:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=; b=YmsgWzJ88tv31ljBeRXAAHvrKx
	xbqtP3oxo1Ulmtimgpg4k0Rw7ldtRAkfKacW8v1MDExUEbhI11YXTGkiNwWwSnG26DHvPHpj7jFIU
	G5AiGhDqCJe70If5pJbnfxjPYjSfrLJPMo/9MzsysyKcXAdTtMT6AcM+nkaBqoNvHwhwDPkHK15SE
	OQuvURJ8HZNKnoXaKwLEnLCUtAtkcdPNI3H5IXC47tKVJmrnFC6sRXmZFfCBdMbysjGUSRYQKX7y4
	DVW/X5IsTzpjhHJ4ACuz1jI6nn71WZn/WQZs2sxU/4bFH28sMHs2zsfFdnRLGpEn2qsRRIaDr0/+i
	esRH1IBw==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QkQ-00000008XX3-2bB8
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 09:30:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BAE94D240;
	Tue, 17 Mar 2026 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773739796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=;
	b=sgP+mFSY1ySx4BZN7d9depi0HVlSdu3swbXXcQRYzn84SzjpPWDFJN2MMhtlNR/uKIDOQp
	pINhPIIl1GO+ougGGCrepYrSo9DWNTzeCdX6xX5KXi4hIrri2eF0+RX7JOOHkB8NTlYFh/
	ufB2O3vzcaaLSbFgmpiGJjZ//aKtx3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773739796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=;
	b=3oQPwUCKLFeyj1Y8T8YXCwLYc4SJz7dodK76pBTCODNbmYAPtT39khBc5VvNsoGoy96gmH
	pj4aEm76Zl/ByLCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sgP+mFSY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3oQPwUCK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773739796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=;
	b=sgP+mFSY1ySx4BZN7d9depi0HVlSdu3swbXXcQRYzn84SzjpPWDFJN2MMhtlNR/uKIDOQp
	pINhPIIl1GO+ougGGCrepYrSo9DWNTzeCdX6xX5KXi4hIrri2eF0+RX7JOOHkB8NTlYFh/
	ufB2O3vzcaaLSbFgmpiGJjZ//aKtx3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773739796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkB0WxskFqfw1yNbKQVtLzL/a7w2rNNpXSuCjONRaO0=;
	b=3oQPwUCKLFeyj1Y8T8YXCwLYc4SJz7dodK76pBTCODNbmYAPtT39khBc5VvNsoGoy96gmH
	pj4aEm76Zl/ByLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AC7C4273B;
	Tue, 17 Mar 2026 09:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLnzFBQfuWlhKwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Mar 2026 09:29:56 +0000
Date: Tue, 17 Mar 2026 10:29:51 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>, 
	Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: libnvme API review
Message-ID: <f81a70be-6df6-46d1-9cad-30cd2a9de9ef@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <a0179550-3210-47e2-918c-323ee5bbd7f6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0179550-3210-47e2-918c-323ee5bbd7f6@nvidia.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 6BAE94D240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_092958_850073_2AB31C5F 
X-CRM114-Status: GOOD (  10.03  )
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

On Mon, Mar 16, 2026 at 05:21:25PM +0000, Chaitanya Kulkarni wrote:
>  From my experience, it always helps to keep the naming aligned with the
> specification.

FWIW, the table is mostly about the library interfaces not the spec so
much.
 
> We often need to search for the same terms in the code and in the spec,
> so using consistent naming makes that process much easier.

Good news, the cmds.h (helpers to setup the commands data structure)
header file is now following the spec pretty closely. types.h (the
'payload' for the commands) is still a mixed bag though.

