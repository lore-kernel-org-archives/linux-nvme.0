Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD64D1CA3A
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=; b=patLwmoxfSnNDTr9ZHICzEb0Of
	PCXe6tAanznbZNsnT33zvmALrqbmJAYmZEm+iUXEEdfFyyxcw42HAnOTguw3fFXzkXiyGKUacK47o
	Du/r/cCv2LqvNl2CdyXStso3b0L03cchQyVNZVeuk/2P2MF2unWPk1ALLz+GXVkOmdGfIxhQHIEfu
	67lsvKIY+jlfd8SHWOq3M0VpGOED6NjnBRWc7BnIDEC+q9FoAKzymqzYp0LCKRKDBKOvyvv7ZbWAD
	8f6/x1b2yPo6JZZce+AwAMbeduG7Ot51ATSHnFHd+7VCRHlEhEUih84uDNyFeXfzB1T0oWo7Zi3tw
	4yllnDjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Da0-0000000G8Im-3Wro;
	Tue, 05 Nov 2024 07:02:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8DZv-0000000G8Gz-2inO
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 07:02:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4400321C6A;
	Tue,  5 Nov 2024 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730790132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=opbRgfzV6ucM6dwFefmfBBKyULd56MFAPu1ATr2KgEAYOV2+VMCqnjxtOlcZhpTJ2kT04k
	KEJLPtdZ6CydWlGSaWAzkvurkc1R5A0d9olGx/JVhzKArqzy2+9p4bBh1IgDDMFg0Gw+li
	o6WZpJL88bhU9SOvsfK5xOFN2ANfb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730790132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=uYBfBKMvzrWodH8DdlC+K3//UFpp8Sc2CyeNngv3nGL7njClGh4XdE0zH7OT9MKZJxxLEL
	ZTiHlnM4pd7pANBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=opbRgfzV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uYBfBKMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730790132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=opbRgfzV6ucM6dwFefmfBBKyULd56MFAPu1ATr2KgEAYOV2+VMCqnjxtOlcZhpTJ2kT04k
	KEJLPtdZ6CydWlGSaWAzkvurkc1R5A0d9olGx/JVhzKArqzy2+9p4bBh1IgDDMFg0Gw+li
	o6WZpJL88bhU9SOvsfK5xOFN2ANfb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730790132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=uYBfBKMvzrWodH8DdlC+K3//UFpp8Sc2CyeNngv3nGL7njClGh4XdE0zH7OT9MKZJxxLEL
	ZTiHlnM4pd7pANBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BF8D1394A;
	Tue,  5 Nov 2024 07:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+CIBfTCKWdKEgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 05 Nov 2024 07:02:12 +0000
Date: Tue, 5 Nov 2024 08:02:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kanie@linux.alibaba.com, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Message-ID: <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
References: <20241104192907.21358-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104192907.21358-1-kch@nvidia.com>
X-Rspamd-Queue-Id: 4400321C6A
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_230215_883111_E8460410 
X-CRM114-Status: UNSURE (   7.62  )
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

On Mon, Nov 04, 2024 at 11:29:07AM GMT, Chaitanya Kulkarni wrote:
> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload

What do you want to test here? What's the objective? I don't see any
block layer related parts or do I miss something?

