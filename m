Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DBFC369B8
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRVEo33WU77flzosDHSOR9hPx+/5k67YPG/wMgnuAdk=; b=Gj0jbQIZiYf2qP8dmDvQiBrnSM
	pH30uCMokY1yix8MyAfEyBRFQqyNDu0Dzh8fg1KJfdlU0rztvXQr9csOginkzAwkZwy3JRg+I3zvZ
	P/8sip49MI/F43L9U+SifI84RwX8ktUusL9pTQ6rmnrR+C9UNxHssaVpc1YMsoc2V2sWvoFJUH+l2
	HdeSGcqtGIvkXWFCcU8bFgsbw7zb+ah+NGXx/Py4YVTkX3WRKMm9ateWKzGBIM+G+o3iydEClurgk
	YCa+9SbF4XiI9zcKe688J4cnpK6E1/SWFbDpTUqNt+vDoBDyh7/+ISJGEmhnIhSHr/08mshYruKMJ
	RTNwiu3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fW6-00000005la1-43yn;
	Tue, 15 Apr 2025 12:35:54 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4f8A-00000005fWG-3NKc
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 12:11:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1B8E21163;
	Tue, 15 Apr 2025 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744719069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRVEo33WU77flzosDHSOR9hPx+/5k67YPG/wMgnuAdk=;
	b=RYH8oy06pRRtPL11b40J3tCg2lAOhcPC8qbL/clK1umHdtpVscA1NhWo2iZ4kmUrVONpbH
	Phvc8H2d2gpd1IH2PF5PozH/0Z7yqYfdQenL+zgo8xl1FzaHF59aSZXxt2VGJfqFra4t4J
	3C8W8SzrSYAy3Ii3aqIy6j+tsoWiOls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744719069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRVEo33WU77flzosDHSOR9hPx+/5k67YPG/wMgnuAdk=;
	b=prodVsa7lpYY0FZN7EGzeIXSze2KGQYIleIhf71l7lVdb3KBm6UTLFSX0USegGP16pacPU
	OHvLyPqvrrT878AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RmPe0ZZg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="um/suesF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744719068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRVEo33WU77flzosDHSOR9hPx+/5k67YPG/wMgnuAdk=;
	b=RmPe0ZZggSVGUtKtPwJVX7l4ZyZ6qtTIhOQz81ek74WhmKJMXHJ9GC16Ex72gOKlU0Ns4Q
	+pd572qh62JgjArINgjva4PoHPCb1OKem3eUo/DhhFyag4esmjxkR4ChqTecXuCKf3zRc/
	COG82onKXdV4CNuXFh37+COtHIuOX8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744719068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRVEo33WU77flzosDHSOR9hPx+/5k67YPG/wMgnuAdk=;
	b=um/suesFtoTECekRFCxmtUAikEU/YLnSXq77Y15juIJTKwHhb99eXj9RDoqdwujugMD1G3
	FwxU//8YMpBhDpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B81AD139A1;
	Tue, 15 Apr 2025 12:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PsILNxM/mefDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:11:08 +0000
Date: Tue, 15 Apr 2025 14:11:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
X-Rspamd-Queue-Id: D1B8E21163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_051110_994792_8DE1B783 
X-CRM114-Status: GOOD (  16.67  )
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

On Tue, Apr 15, 2025 at 01:28:15AM +0300, Sagi Grimberg wrote:
> > > +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> > > +{
> > > +	unsigned long delay;
> > > +
> > > +	if (ctrl->cqt)
> > > +		delay = msecs_to_jiffies(ctrl->cqt);
> > > +	else
> > > +		delay = ctrl->kato * HZ;
> > I thought that delay = m * ctrl->kato + ctrl->cqt
> > where m = ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> > no?
> 
> This was said before, but if we are going to always start waiting for kato
> for failover purposes,
> we first need a patch that prevent kato from being arbitrarily long.

That should be addressed with the cross controller reset (CCR). The KATO*n
+ CQT is the upper limit for the target recovery. As soon we have CCR,
the recovery delay is reduced to the time the CCR exchange takes.

> Lets cap kato to something like 10 seconds (which is 2x the default which
> apparently no one is touching).

If I understood the TP4129 the upper limit is now defined, so we don't
have to define our own upper limit.

