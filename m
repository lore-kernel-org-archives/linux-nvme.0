Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A46C282EC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEXE8nVqb077JMj+9Tc6Pf2mb1Q/yk/YgpJyYDwtADs=; b=QhiklMY0fX1zR/BUQVR17OGYrV
	6YUE4x+HsFGFqeSUna0Q0Llf3TmxcT26p1yThJJlFUhCUHp3PuBJgqEE8epkSvCl7suD9D/7cLY2C
	NzsRCwn0b502pOEEwegwJb0rAPsNsMgFVsiDUzEYg8DuB+aWd3ulBLaF9iZtYwMMSJVkEHKrK9Iee
	sgpn9Ei1+JSptTCDO5c3Pf3rBVvkDcVAsM27ZDo/1t6wOosz7psJfTxPlSQ2mbi/INOWY/IZQggk0
	W+2Ggmc8mvDR35Yd1Op9tTi3Js+NuTy5WzDdSMDogwR9g1KrKr1FZmnCXE20ghCoVit7NZiUlL2PK
	Z8F8rTkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt02o-0000000DOEE-3Lgg;
	Fri, 14 Mar 2025 08:05:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tszwu-0000000DNFG-06eX
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 07:59:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 138792117C;
	Fri, 14 Mar 2025 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741939158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEXE8nVqb077JMj+9Tc6Pf2mb1Q/yk/YgpJyYDwtADs=;
	b=bxFXfjFLWcto+091j0crXq60MxRDWiWp4KH3vMCfWa1McWpnbU7URxDNU/67Q+vxmrvh/Q
	jUmUAVeC40BpY55io/jAQkEaAq5zoCW+nnOMRbM0n94zo1e89Ug6OAur5XM4JTKA+LwtfD
	Su+IZX6ge2LqjBB9+AikYWlrhlPktIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741939158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEXE8nVqb077JMj+9Tc6Pf2mb1Q/yk/YgpJyYDwtADs=;
	b=9GA1qBKnURm2Y8lNdnCMAzuaFJlKDxlnMRxQ+j/jlWvjrZiPPcVzx6ZIR6JkGLiAO73xFA
	2FrQF9wxy19E4NAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bxFXfjFL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9GA1qBKn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741939158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEXE8nVqb077JMj+9Tc6Pf2mb1Q/yk/YgpJyYDwtADs=;
	b=bxFXfjFLWcto+091j0crXq60MxRDWiWp4KH3vMCfWa1McWpnbU7URxDNU/67Q+vxmrvh/Q
	jUmUAVeC40BpY55io/jAQkEaAq5zoCW+nnOMRbM0n94zo1e89Ug6OAur5XM4JTKA+LwtfD
	Su+IZX6ge2LqjBB9+AikYWlrhlPktIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741939158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEXE8nVqb077JMj+9Tc6Pf2mb1Q/yk/YgpJyYDwtADs=;
	b=9GA1qBKnURm2Y8lNdnCMAzuaFJlKDxlnMRxQ+j/jlWvjrZiPPcVzx6ZIR6JkGLiAO73xFA
	2FrQF9wxy19E4NAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B95F813A40;
	Fri, 14 Mar 2025 07:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zd0BK9Xh02d3NAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 14 Mar 2025 07:59:17 +0000
Message-ID: <60c79cd2-c92b-4ad2-9a8f-ea0abc12c034@suse.de>
Date: Fri, 14 Mar 2025 08:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] nvme: restrict authentication to the admin queue
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "hare@kernel.org" <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <dlemoal@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250124114738.115882-1-hare@kernel.org>
 <BY5PR04MB6849C5BBCCD96273CF2F2A52BCC42@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849700BB53BBE24BBE640D4BCD32@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BY5PR04MB6849700BB53BBE24BBE640D4BCD32@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 138792117C
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_005920_217584_A51C0A66 
X-CRM114-Status: GOOD (  12.52  )
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

On 3/13/25 18:29, Kamaljit Singh wrote:
> Hi Hannes,
> 
> One of the key TLS handshake issues we faced is with SHA384 and I see 
> that you had requested this gnutls fix ~2 years ago. I’m curious how you 
> got around that.
> 
> https://gitlab.com/gnutls/gnutls/-/issues/386 <https://gitlab.com/ 
> gnutls/gnutls/-/issues/386>
> 
> We had to hardcode gnutls v3.8.9 to change its default SHA256 to SHA384 
> for using the appropriate binder length.
> 
Yeah, that is quite annoying.
Guess I'll have to bite the bullet and fix gnutls.
Especially as even the maintainer acknowledged that it's an
issue.

BTW, the secure concatenation fixes are now merged with the nvme-6.15 
branch at git.infradead.org/nvme.git, and I've opened a pull request
for blktest:
https://github.com/osandov/blktests/pull/158
which should test possible combinations.
No test for the binder hash, I'm afraid; if you have ideas how to test
this I'd be happy to take them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

