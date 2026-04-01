Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0DE10F6FD6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=; b=aiSuW9mr7ON/i1iip6QHxO+YRi
	e8YOq6ln8kXHRgpwZ2UtgMWSn0xmqA17mPVISAdbRCyDhesxjFhvLFJBWQM9apfCr4+2W9hR8f3/d
	jDMcfSUcSQt9z9TVlCnJSBGY49W7sdZcEXDlWVvBJqB57D8pU/4inPqkGIk2Pi/uM0VV4oaTwBxtp
	cu+olUx5TDZS1kTcRDx1cmqokQdYWGd5H/Vu33E3ZjBkrSLUPFty2/SNtyGx6/4VLb0/bVY0XoGJ8
	FuMfkAsBGhgSaKMjf4lGFt2ewK95wESH2q1/CTi1UluH2l0mC9O4HrFdPOk+zCEg4h5m6N+EFMFFt
	9fhKxKdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xz1-0000000FgHT-3NYo;
	Wed, 01 Apr 2026 15:59:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xyz-0000000FgH7-3sSg
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 15:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=; b=KNhc9kFceRA83/8HiWHSkA/zbk
	bMxjmLp/b4GZ2GLh2x3NGmG+kuGpoZ5LNzBUnRyqb1x8xPNvK7f1yIVS9D+go2bhb9ejjx8Y2EoIb
	2TmN2ZGf5Xy0V//2Lb9Y/t6sL+8cBeB7trGgknbdNrlKvywCX3sGFUBaC4GrvsfOZhh1FcAzLj3lj
	MPAnn9uEj0WotX140HM+6TpydxKt+88WLuiMI6I91CewzA5wMTJ1Uj6R46Lbm8hBCKiBZI5/8wXl4
	0fdrsrpRi6QByAnY/r0Ym1oQ0OPtehKhzUbnW56eqH7Pm8UW5SdxFmBO2uscm7+ittWPBeMvz3Xtt
	gVo/D7ww==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xyw-00000000pzs-3t0z
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 15:59:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB4095BDBB;
	Wed,  1 Apr 2026 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775059188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=;
	b=thCRnPw5Q/O7PVZCM3ev3lyNA54MJUCZ50XDXBN6n87+s1ml6K6YA1JiV8a9JSnhBUWj6s
	xQpM0CHhEV2r6ScWDtpNybyMtiEJD+gu/6CSbpeU9eJcqG+w7gVJ5Fnn5Rmfu5r6WD2zBj
	RmIEYmn8gFGiiRvvPUA1k8tHlSiEwGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775059188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=;
	b=9+gLFgdiEdfoDJKgjgkjRJg/2gTP6VK5ufSzdoBm2S0kRJwbCeCTgrofNvOt5e3Ul8cuXD
	bO3DPs+W+NSRA1Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=thCRnPw5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9+gLFgdi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775059188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=;
	b=thCRnPw5Q/O7PVZCM3ev3lyNA54MJUCZ50XDXBN6n87+s1ml6K6YA1JiV8a9JSnhBUWj6s
	xQpM0CHhEV2r6ScWDtpNybyMtiEJD+gu/6CSbpeU9eJcqG+w7gVJ5Fnn5Rmfu5r6WD2zBj
	RmIEYmn8gFGiiRvvPUA1k8tHlSiEwGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775059188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5knxWFzgKZC0PlE6XPVdPQQxAyYnZR8Wb7EVdfdj30=;
	b=9+gLFgdiEdfoDJKgjgkjRJg/2gTP6VK5ufSzdoBm2S0kRJwbCeCTgrofNvOt5e3Ul8cuXD
	bO3DPs+W+NSRA1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99BEF4A0B0;
	Wed,  1 Apr 2026 15:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMlTJPRAzWmCYQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 01 Apr 2026 15:59:48 +0000
Date: Wed, 1 Apr 2026 17:59:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API review
Message-ID: <b31136a9-2001-48f0-946e-79016e5836d8@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
 <SJ0PR84MB2231AC08CA04F54CC29F03319841A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
 <0b954855-c99c-4165-a804-edde9a34f1a7@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b954855-c99c-4165-a804-edde9a34f1a7@flourine.local>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AB4095BDBB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_165951_078365_1D3AA0B5 
X-CRM114-Status: UNSURE (   9.22  )
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

On Wed, Mar 18, 2026 at 01:07:10PM +0100, Daniel Wagner wrote:
> Any opinion/suggestion on the prefix name?
> 
> - libnvme: probably the one which wont conflict with anything else

Alright, I'm going to use libnvme as prefix. Starting with the mass
renaming...

