Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFAAC48292
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTcgsrjQhcYpX1XfkrrhOOdrklqo9Vb33VKkNNBjUR4=; b=RAlJZ0NaEAudPc04H1ls6Wl8XI
	9ks46/aE5ZT2f39VOphJJD0BG7HOUPRTbpPF7IKakRDpe6gJNf8ZdfpwrrYrAebQ2M0zZnWvVY72X
	DgK2yjpyTUfq/3qUQ/jZZmmnym3Txz1sY9toQXTciYduEituU2dDZuiocLxsgAQu93RTg0BzRoX2z
	qxiGv4ueKN0mrjQRe/HMQNqidzbFuXgIzAbd3Fa3EBh56YdzkDNb8vUMSAtn8M8AyHuf9KXrTCpzj
	u8pPJH8GE5MdVmId4gIwDTEU3RIuBEJXTP7A14HuH291ApCcsybPVSm01/jKzC3sA6wh5oEJS+6Cx
	Uf7mG5sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2X1-000000046BU-2gbA;
	Mon, 05 Feb 2024 17:13:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2Wx-0000000469p-2ixm
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 17:13:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7531B1F749;
	Mon,  5 Feb 2024 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707153193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTcgsrjQhcYpX1XfkrrhOOdrklqo9Vb33VKkNNBjUR4=;
	b=to3aGsbYWIFWiQkfCSVtlE96UeZ3qZ73CoRz9bEhBZSGKQiuCMpUTQzgI9TtGXtXHzfq/J
	RyXQUG8W8OZjlmfe4rF1RHF4TFb5PFnYZ7epSHsn3Htcn7jRHd1v75Aq4D/pVJ3JGLBJDk
	EZcy2ZbyU5aQIuNPSAknice1Udv55Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707153193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTcgsrjQhcYpX1XfkrrhOOdrklqo9Vb33VKkNNBjUR4=;
	b=IwA0gEPnkQDEw7Fn4FMVP0UG1CSsqkd8XxyxdyRGXh0rkYLOH6V6NgL1Q4ptoW3vry+Y1A
	O6fTlhFoFRqMWKCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707153193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTcgsrjQhcYpX1XfkrrhOOdrklqo9Vb33VKkNNBjUR4=;
	b=to3aGsbYWIFWiQkfCSVtlE96UeZ3qZ73CoRz9bEhBZSGKQiuCMpUTQzgI9TtGXtXHzfq/J
	RyXQUG8W8OZjlmfe4rF1RHF4TFb5PFnYZ7epSHsn3Htcn7jRHd1v75Aq4D/pVJ3JGLBJDk
	EZcy2ZbyU5aQIuNPSAknice1Udv55Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707153193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTcgsrjQhcYpX1XfkrrhOOdrklqo9Vb33VKkNNBjUR4=;
	b=IwA0gEPnkQDEw7Fn4FMVP0UG1CSsqkd8XxyxdyRGXh0rkYLOH6V6NgL1Q4ptoW3vry+Y1A
	O6fTlhFoFRqMWKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 628AC132DD;
	Mon,  5 Feb 2024 17:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cqujFikXwWWvHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 Feb 2024 17:13:13 +0000
Date: Mon, 5 Feb 2024 18:13:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Re: Re: Re: Re: race between nvme device creation and discovery?
Message-ID: <r63s55fo5e5vbkbzfvw32hspxkghwozivgmptsv74cjpa3ulik@6jcsrsvkaaho>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
 <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
 <p2qty2zv6h5aq7mvbqbg3hbvwe5opuquq2sahcing6s7ezq5fp@dxbadmzjur5g>
 <m4mtj3s5v6wlgvcnir7skajafvekloufkzsodpjpqnzgpv3gfd@mievitjqki5p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m4mtj3s5v6wlgvcnir7skajafvekloufkzsodpjpqnzgpv3gfd@mievitjqki5p>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=to3aGsbY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IwA0gEPn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.73%]
X-Rspamd-Queue-Id: 7531B1F749
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_091315_874344_D962FB6D 
X-CRM114-Status: GOOD (  12.75  )
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

> > We have a 'state' attribute in sysfs already, though the
> > NVME_CTRL_STARTED_ONCE is modelled as flag. Not sure how this fits
> > together yet, so let me play with this.
> 
> If I got this right, we could just filter out all controllers which are
> in the NEW state, because all transports trigger the connect code right
> after the NEW state. At this point the sysfs should be completely
> populated.

I've patched libnvme to print the state of the controller right
before the lookup for the subsystem happens and it says:

    +state connecting
    +failed to lookup subsystem for controller nvme1

more digging needed...

