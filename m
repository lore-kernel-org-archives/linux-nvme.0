Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DA8CA0EFC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1XDUsKzazzi7da2jaSuI66MfaTVenuV3nyli2KNjEk=; b=VqplpkQabyNe3tssXZoSFnLp22
	7qirTm4p2aOh29tluxRNnlR28UX0gKgZ1qT+Mjz2QswuxUMshCNT5tYAdDsqjLn86lRote1Pi55Ps
	xY+ygzot/RzTmGO8eJrmEkw+QiCul2HwK2+ZnhXbG5Czpt1JMDOJ1EflNP+ru/dqg0eVwUlKAEw6/
	aR5S5d/UMap7ZvZ0CCSR7/5lL48V8R58np4oT1aRQwIpER4UXoX9y33TVXXr5zBHEv/EIp03i8ExH
	hgv6rDJMmE3CJp3R3Hfy+Vgx3F7NFYaqUz+9X6zD2fTm4lQMTwE8DnHj2STETMrl940AmJ9ru0SDS
	7h8Uy5NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeko-0000000Cq3a-08q6;
	Wed, 20 Aug 2025 09:05:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe0g-0000000ChhP-3vGs
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:17:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D26F1F391;
	Wed, 20 Aug 2025 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755677849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1XDUsKzazzi7da2jaSuI66MfaTVenuV3nyli2KNjEk=;
	b=jz9/yFHJnwzsbQINjqNHQnl3CV/nfxDA3Prmks+21IXyph/gapDI6U2V4N3Zakl8P1beKD
	eKVVPT1MvzMrklMkbBV9yz3yD6GWg2cDpL2MkqgRyDhRNdmw2fYSoNmsi2SYBaQ3nSYAfV
	huYv8FQ2APmy/X5uLomw3Ixy2LTLWv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755677849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1XDUsKzazzi7da2jaSuI66MfaTVenuV3nyli2KNjEk=;
	b=yNVQvWJ0hvsLhr/dWiY+RW7rfO2XxXyquSo3hzUF4ipWRcHYRndmOTY6pr729fZ2GtqjKG
	Hi0WN9ThWwvaE4Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jz9/yFHJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yNVQvWJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755677849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1XDUsKzazzi7da2jaSuI66MfaTVenuV3nyli2KNjEk=;
	b=jz9/yFHJnwzsbQINjqNHQnl3CV/nfxDA3Prmks+21IXyph/gapDI6U2V4N3Zakl8P1beKD
	eKVVPT1MvzMrklMkbBV9yz3yD6GWg2cDpL2MkqgRyDhRNdmw2fYSoNmsi2SYBaQ3nSYAfV
	huYv8FQ2APmy/X5uLomw3Ixy2LTLWv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755677849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1XDUsKzazzi7da2jaSuI66MfaTVenuV3nyli2KNjEk=;
	b=yNVQvWJ0hvsLhr/dWiY+RW7rfO2XxXyquSo3hzUF4ipWRcHYRndmOTY6pr729fZ2GtqjKG
	Hi0WN9ThWwvaE4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C7E613867;
	Wed, 20 Aug 2025 08:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9puQFZmEpWhYZwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 20 Aug 2025 08:17:29 +0000
Date: Wed, 20 Aug 2025 10:17:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
Message-ID: <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
X-Rspamd-Queue-Id: 6D26F1F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_011731_119708_435A8BFF 
X-CRM114-Status: GOOD (  12.23  )
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

On Tue, Aug 19, 2025 at 08:15:09AM +0200, Hannes Reinecke wrote:
> > Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
> > is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
> > And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
> > I'll update this in the next patch.
> > 
> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
> the number of fields will be different (and making parsing harder).

What type of parser do you mean, a carbon based one or a computer? I
strongly recommend to use the JSON output for the later.

I would really prefer that the default stdout is easy for a human to
read not screen scrappers.

Thanks,
Daniel

