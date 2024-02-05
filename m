Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0DAC48291
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+zPUVo/07plw306woAQ/KryOhmpb4SWlJ3XIWEizdMA=; b=F6b2grZvyvuvbFLeuSyayFHxfE
	0xZAucn/FzbJXSf3eZT+yQKUVROu0U+TT6wb70UGOfqhT4TGGGkOcLCmYEdn/pX+EUhR1nS6XeiEJ
	+3dXfWxMG0aNwAXkrOqAJycKcV8+RDjB4Bt2kRwd8k6nEJ3v54F6sX7+TMBCpgcwkZTF4OkOHEyGe
	PMB4NJ7zr4TJlQEvsPJDp4mhQDGUXag4IN7Bi4uF4DQxwKz+jEsPuODVPBqvYWuwMTNAAU4dKlJHa
	B+XM7h2V9+Fb7la8BtjAsgR/TxizhFiu1Vo1aqIgH3MqH6ji80T3U+dbmv8ZSz/FxEw8d6CxrHmsi
	maDa5nJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWvtK-00000002k4N-1yTy;
	Mon, 05 Feb 2024 10:07:54 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWvtG-00000002k2p-1qeA
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 10:07:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B28231F8AE;
	Mon,  5 Feb 2024 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707127668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zPUVo/07plw306woAQ/KryOhmpb4SWlJ3XIWEizdMA=;
	b=lPXtlsKTNnNrovZ4WpvZ9bgrnvkz3onYYAzR3pM3xRFy+1hg6nBa4W+gh7Fkach6929ddF
	o4og6ai85DGty0Fk/H9oaN5WB8P0vxt9Bb7mmSfFdvcnhtQaDmFZeyC9yDRJp//XZJ0FAk
	4w0xxOrQAMpt80XUOX3S0SL2GFRuC48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707127668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zPUVo/07plw306woAQ/KryOhmpb4SWlJ3XIWEizdMA=;
	b=iHsyXdeH/IWHIk9XG3pl4S0upD3M8YFWjQxnPttfIB5ArkAvEDn2d4pnRCn3ze8hnhRzHb
	MdwGp58U71SYCADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707127668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zPUVo/07plw306woAQ/KryOhmpb4SWlJ3XIWEizdMA=;
	b=lPXtlsKTNnNrovZ4WpvZ9bgrnvkz3onYYAzR3pM3xRFy+1hg6nBa4W+gh7Fkach6929ddF
	o4og6ai85DGty0Fk/H9oaN5WB8P0vxt9Bb7mmSfFdvcnhtQaDmFZeyC9yDRJp//XZJ0FAk
	4w0xxOrQAMpt80XUOX3S0SL2GFRuC48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707127668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zPUVo/07plw306woAQ/KryOhmpb4SWlJ3XIWEizdMA=;
	b=iHsyXdeH/IWHIk9XG3pl4S0upD3M8YFWjQxnPttfIB5ArkAvEDn2d4pnRCn3ze8hnhRzHb
	MdwGp58U71SYCADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FECC136F5;
	Mon,  5 Feb 2024 10:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jgVjJXSzwGVrKQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 Feb 2024 10:07:48 +0000
Date: Mon, 5 Feb 2024 11:07:48 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Re: Re: race between nvme device creation and discovery?
Message-ID: <p2qty2zv6h5aq7mvbqbg3hbvwe5opuquq2sahcing6s7ezq5fp@dxbadmzjur5g>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
 <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lPXtlsKT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iHsyXdeH
X-Spamd-Result: default: False [1.18 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.83%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B28231F8AE
X-Spamd-Bar: +
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_020750_655328_077A7421 
X-CRM114-Status: GOOD (  12.96  )
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

On Mon, Feb 05, 2024 at 10:20:54AM +0100, Maurizio Lombardi wrote:
> po 5. 2. 2024 v 10:20 odesílatel Maurizio Lombardi <mlombard@redhat.com> napsal:
> >
> > I think I had a similar problem with nvme-stas some time ago, it tried
> > to delete a controller right after it appeared in sysfs, causing race conditions
> > with the init code path.
> 
> This is the problem I was talking about
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2eb94dd56a4a4e3fe286def3e2ba207804a37345

We have a 'state' attribute in sysfs already, though the
NVME_CTRL_STARTED_ONCE is modelled as flag. Not sure how this fits
together yet, so let me play with this.

