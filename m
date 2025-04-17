Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B71C369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xr+d4P9mvF32vnaICgajb7J0IwfdOi1m/8vSzmZlt8c=; b=a63mFDUx7YTrv0MHzGozs9C8ya
	Qj1F1ciKcC/E13/Ux9pmGwcyBlFV26IeaRDYeLKI6Dv3z41AXgptyGuyN0TMGMq3hYQlnZhQtIHW8
	6EVP6d6OjKVivFNL870cTwCZ/NY7DJ9C2iD/yLY7Lonye5DhJu+FbmeZQA74Y18aev6w+IYRvz1gD
	8TXurG7bWI4aFbJcQZlDQBTEQQFXdifg0bZmR68HCzq/NdAoEv4/BF/QtIdhPQKRnPj2S/u4GUt/h
	BeZNrZLj50+fz2esgPkMaD7lepjdyWtWAUnb7bYDi8aWGA7PBi823WnU1QWpfykiYU9dHB9vioU+x
	tTNwrKqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5MEP-0000000CZpI-2TCe;
	Thu, 17 Apr 2025 10:12:29 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5MEN-0000000CZnG-3fft
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 10:12:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DC7B211A3;
	Thu, 17 Apr 2025 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744884746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr+d4P9mvF32vnaICgajb7J0IwfdOi1m/8vSzmZlt8c=;
	b=0xKnWVwT5Yn07zu8FmHtHczlvySiIuGl0/R/Ciwd6PkQsH9w1Fs/3ZqnThOMHiFy6z1ZhW
	TfJFR/VAx2G5GX00N0hdaCvNQ40auQj/50LwFYHZ3rczBtn4AbATqFZYiJPyNk4UVCwxGI
	13IdARyp8joyoPatx9CKRAJ5LwFieBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744884746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr+d4P9mvF32vnaICgajb7J0IwfdOi1m/8vSzmZlt8c=;
	b=Tyxs+aa3O8m3L2xoJtpDbaordnGg9EoE4RajFqXpy5XWpFN0DNCh3Xlu0p83/leo5dU/gU
	e3tsmt5an2c2gjCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0xKnWVwT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tyxs+aa3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744884746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr+d4P9mvF32vnaICgajb7J0IwfdOi1m/8vSzmZlt8c=;
	b=0xKnWVwT5Yn07zu8FmHtHczlvySiIuGl0/R/Ciwd6PkQsH9w1Fs/3ZqnThOMHiFy6z1ZhW
	TfJFR/VAx2G5GX00N0hdaCvNQ40auQj/50LwFYHZ3rczBtn4AbATqFZYiJPyNk4UVCwxGI
	13IdARyp8joyoPatx9CKRAJ5LwFieBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744884746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr+d4P9mvF32vnaICgajb7J0IwfdOi1m/8vSzmZlt8c=;
	b=Tyxs+aa3O8m3L2xoJtpDbaordnGg9EoE4RajFqXpy5XWpFN0DNCh3Xlu0p83/leo5dU/gU
	e3tsmt5an2c2gjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A917137CF;
	Thu, 17 Apr 2025 10:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O02LBQrUAGjdBQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 17 Apr 2025 10:12:26 +0000
Date: Thu, 17 Apr 2025 12:12:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <852a4c64-9ed3-41d3-adc0-ae18aa320fa7@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
 <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
 <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
 <d1d76c7f-e8c7-4554-adf0-663bb49d2d82@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d76c7f-e8c7-4554-adf0-663bb49d2d82@grimberg.me>
X-Rspamd-Queue-Id: 2DC7B211A3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_031228_064432_F2A0BAC2 
X-CRM114-Status: GOOD (  13.07  )
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

On Thu, Apr 17, 2025 at 12:26:51AM +0300, Sagi Grimberg wrote:
> > I think I can reproduce it. I have two connections and do a
> > 
> >     while nvme read ....; do yes; done
> > 
> > and block one of the connections, when the error handler kicks in the id
> > ns command fails with EINTR.
> 
> What happens before Caleb's patch though?

I am able to reproduce it with the distro kernel 6.13.9 on my laptop
(real hardware) but not with one of my test setups (qemu) and a strip
down configuration. Neither HEAD, v6.14 or v6.13.8 is returning EINTR.

I will try the distro config in qemu as next.

