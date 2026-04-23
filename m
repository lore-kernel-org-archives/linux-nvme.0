Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF91FDEE2F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjrERcCY3f8DIygPHOtkMHGBt8hbLKtdv9dQz13eJGY=; b=zv4q2aDO6XM7tXDI7JTEPiQcU8
	jzNHA6WsEfI20UGBdh3+SBmJQCH3S81lPwGtqBnIq7SGXop30x7n9cIPVEICctW9iXmNF4JvXc4en
	II6dcILUUNbdseCRwRF8q8/V9ihxv5n+TBDgUQCZNi4xU2KW1wbAV8PiK31lYn7/HGUUPMuBJnaFI
	sGIEsr3nk7OAZZrm1Rel6gUlU/0AgtaJsEncq1weGFG830GuxSevwywXt0dIlNaSObSG5eABpgN3S
	OfBoruRiirgxBrY8j/BArPsAtgQd1rH15jYjEPm3EbGMd1FCRA3vWkFsPQYkg5tz/DqCY4PCOd1p3
	X/VKT+pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFxeP-0000000C1SU-2dm3;
	Thu, 23 Apr 2026 17:15:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFxeN-0000000C1RZ-4C0S
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 17:15:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58CD96A87E;
	Thu, 23 Apr 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 474C4593A3;
	Thu, 23 Apr 2026 17:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j2oxELpT6mlwEgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 23 Apr 2026 17:15:38 +0000
Date: Thu, 23 Apr 2026 19:15:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, 
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [RFC nvme-keyring nvme-cli] Should NVMe/TLS PSKs support the
 request_key API?
Message-ID: <691844f5-2148-4078-89e2-2653ed5cd93f@flourine.local>
References: <20260422231043.2689681-1-cleech@redhat.com>
 <58b7e84a-20a4-44ae-b933-b89ab0fe265a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58b7e84a-20a4-44ae-b933-b89ab0fe265a@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 58CD96A87E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_101540_185139_3CB1E20A 
X-CRM114-Status: GOOD (  13.29  )
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

On Thu, Apr 23, 2026 at 02:05:45PM +0200, Hannes Reinecke wrote:
> >   Biggest problem I see, requiring explicit loading of nvme_tcp before it
> >   can be used with TLS:
> > 
> >   - The async uevent handling loses the race against the kernel when the
> >     transport kmod is requested on demand.
> > 
> >    ┌────────┐     ┌──────────┐     ┌──────────┐     ┌──────┐
> >    │ kernel │     │ nvme-cli │     │ modprobe │     │ udev │
> >    └────┬───┘     └─────┬────┘     └─────┬────┘     └───┬──┘
> >         │               │                │              │
> >         │ connect       │                │              │
> >         │◄──────────────┤                │              │
> >         │               │                │              │
> >         │ request kmod  │                │              │
> >         ├───────────────────────────────►│              │
> >         │               │                │              │
> >         │ load kmod     │                │              │
> >         │◄───────────────────────────────┤              │
> >         │               │                │              │
> >         │ uevent kmod   │                │              │
> >         ├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌►│
> >         │               │                │              │
> >         │ check keyring for PSK ❌       │              │
> >         ├──┐            │                │              │
> >         │  │            │                │              │
> >         │◄─┘            │                │              │
> >         │               │                │              │
> >         │ connect failed ❌              │              │
> >         ├──────────────►│                │              │
> >         │               │                │              │
> >         │               │ nvme tls --import --keyfile   │
> >         │               │◄──────────────────────────────┤
> >         │               │                │              │
> >         │ populate .nvme keyring         │              │
> >         │◄──────────────┤                │              │
> >         │               │                │              │

Maurizio just added

    	load_nvme_fabrics_module();

to the connect command. So we could make the connect call wait for the
udev event, load the keys into the kernel and then write to
/dev/nvme-fabrics.

I see the /etc/nvme/tls-keys file is merely a stopgap solution. There is
certainly better ways to do this.

