Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EDEC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0lpppjuydwSP2YxVHQTD1lLc177AyA5IB28ALNbCoiQ=; b=yHN6n204pqZ4VqhdanJoNiGLij
	jO/vwo6SUHrbBZluxAiNdM0qjAFaFHYVr5YcpAdoexDuX/aY4305uXuI+v5cd+chwV/M1d6dvHRI3
	OeZWv7oD1x51BOcTW2xsqYFUkjPN87X/cAi+cTbINkhCkSNQdBDCnAlrbXlL2RmTsM3NVI1jH3gHz
	zzNsqIcosUmGH4+22mO+ThVjzYlS02onVfm20GZIsfAyNhIQuX280xIVUo7gqN/cNHAYbyNaJ4sYS
	KqqYK6O50RDKjpd1vpJCcOL+3jj8ZzZ42rFMmDFY6LJkF3DmZZM0kEwsD0+vbeaAnlOJuZT6kzYOE
	Xr/qeQNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfM1C-00000009vVO-461Y;
	Wed, 28 Feb 2024 15:38:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfM18-00000009vTh-1ZS4
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 15:38:48 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94ED61F796;
	Wed, 28 Feb 2024 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709134722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0lpppjuydwSP2YxVHQTD1lLc177AyA5IB28ALNbCoiQ=;
	b=lSPcZpba5TtDICdQFvEU8ULp5hlVapI47cackdEWdIBSwImR9ZuEDu6BYc0oxtBqiRVIDr
	Xu76fukz9ZruHGx9siJrr+HV7CdJrfGdHB1U3KkFWVpy84rFjNFg7ATp9WxSeqHzklidVP
	FeOW4uEyz6MTDAlIly4a2JoNsyrSfmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709134722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0lpppjuydwSP2YxVHQTD1lLc177AyA5IB28ALNbCoiQ=;
	b=eAboESyiw6FmY0Aizw20UyxgAtNmQFxMSTjTU7K4vDJaOhR990qr3QaegjedhAUP8zpR/H
	t7L8cTmBzmx3raAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709134722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0lpppjuydwSP2YxVHQTD1lLc177AyA5IB28ALNbCoiQ=;
	b=lSPcZpba5TtDICdQFvEU8ULp5hlVapI47cackdEWdIBSwImR9ZuEDu6BYc0oxtBqiRVIDr
	Xu76fukz9ZruHGx9siJrr+HV7CdJrfGdHB1U3KkFWVpy84rFjNFg7ATp9WxSeqHzklidVP
	FeOW4uEyz6MTDAlIly4a2JoNsyrSfmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709134722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0lpppjuydwSP2YxVHQTD1lLc177AyA5IB28ALNbCoiQ=;
	b=eAboESyiw6FmY0Aizw20UyxgAtNmQFxMSTjTU7K4vDJaOhR990qr3QaegjedhAUP8zpR/H
	t7L8cTmBzmx3raAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 81AAC134FB;
	Wed, 28 Feb 2024 15:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wlajHoJT32VJKAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 28 Feb 2024 15:38:42 +0000
Date: Wed, 28 Feb 2024 16:38:41 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fabrics: check max outstanding commands
Message-ID: <rgmylw5fdp4yzi2i7oz5ohlfs7trixtwhhhtg7xsmxv3ferwxo@hdpkjtwg523f>
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
 <Zd4f4PaoOM6WSF4u@kbusch-mbp>
 <89bcff20-e07c-4f62-9ef8-36cbbc3d6def@linux.alibaba.com>
 <73uh4vwpacq22ttzlbrouvtpwysbcy246d2ejgpobsrtb2chaw@rlbdjiqzbdsa>
 <bc414f6c-55f7-4fda-b095-8d4a15028eac@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc414f6c-55f7-4fda-b095-8d4a15028eac@linux.alibaba.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lSPcZpba;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eAboESyi
X-Spamd-Result: default: False [-1.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.43%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 94ED61F796
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_073846_590789_D8F535F9 
X-CRM114-Status: GOOD (  11.14  )
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

On Wed, Feb 28, 2024 at 05:54:41PM +0800, Guixin Liu wrote:
> 
> > And please run blktests with it. Last time, we had some fallouts when a
> > new check was added. Thanks.
> 
> I am sorry for the last time's mistake, I've already run the blktests this
> time,

No worries.

> the maxcmd is mandatory for all controllers.

Sure, not disputing this, it's just we should at least make sure that
our soft target implementation is following the rules.

> Blktests log:

Excellent. Thanks!

