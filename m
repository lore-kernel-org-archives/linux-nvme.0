Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB0D2E9D3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUVW5HGlnTF+9WgfojbF+C5D0fQqaMimKBpp4x8Kg94=; b=sYBOlhgVqsI7VCRwDEzZCNz3KR
	w5QIsdifwejxg3TuycjeWrUX4OAozwSM6LIYngsLkvsUdRyNLBg9e4F78FV0XjZibJrm3GSpyRJ/h
	jMr6RdLMhFkb47EyC06rPZ4iqry6DYvwlB5NJXqDpeSdQIULoKLyqzJpRRvUEiv3vJKIVs0cR/cO5
	TEL6tOn5uRjpJFB4Ufl1IbzQnasy1XtxjNvtG8l15AcwHfWq1n/q9lmvnYO1AHNVL0dGaWsTweYWP
	t1R41pqjV4KYlzJyvxzx4TBirK64kQ33Gmr633bO2V1snq0MOCYEhODxypfExlLOder+Gd4pBhdaw
	6t5uXxfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARiB-0000000HHzF-0VgK;
	Mon, 11 Nov 2024 10:31:59 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARhz-0000000HHrN-0S6R
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:31:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1F24218A1;
	Mon, 11 Nov 2024 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUVW5HGlnTF+9WgfojbF+C5D0fQqaMimKBpp4x8Kg94=;
	b=vlCEZokDhohsZ8pMDG6fXd0fGnfYZpDhy7X+XtbKUiVhnM7sSiEU2BI6S/4KujeuAdnxb2
	RWRk+BaATMCJEYyLwFjNK+W31lKjD9fbR1gonOlIUh102MHeWm4H7+EsEOpEW2fchIA9nP
	c0fHo4xvq91+w9arc6XMV25iqdy3udg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUVW5HGlnTF+9WgfojbF+C5D0fQqaMimKBpp4x8Kg94=;
	b=LUQ2lRl29KsfyeLjYpEJcmBU+K9iYq4Lhke99RczpncN1fvYpReCgOZ8nm+lNhqEe+26Zq
	tXtio+P3jEGqvvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vlCEZokD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LUQ2lRl2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUVW5HGlnTF+9WgfojbF+C5D0fQqaMimKBpp4x8Kg94=;
	b=vlCEZokDhohsZ8pMDG6fXd0fGnfYZpDhy7X+XtbKUiVhnM7sSiEU2BI6S/4KujeuAdnxb2
	RWRk+BaATMCJEYyLwFjNK+W31lKjD9fbR1gonOlIUh102MHeWm4H7+EsEOpEW2fchIA9nP
	c0fHo4xvq91+w9arc6XMV25iqdy3udg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUVW5HGlnTF+9WgfojbF+C5D0fQqaMimKBpp4x8Kg94=;
	b=LUQ2lRl29KsfyeLjYpEJcmBU+K9iYq4Lhke99RczpncN1fvYpReCgOZ8nm+lNhqEe+26Zq
	tXtio+P3jEGqvvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97CD013301;
	Mon, 11 Nov 2024 10:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lwmhIhHdMWcWGgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:31:45 +0000
Date: Mon, 11 Nov 2024 11:31:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 3/8] nvme/016: do not create namespace when
 setting up the target
Message-ID: <4949818b-b855-4694-a5f8-4f66b2f37e71@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: B1F24218A1
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_023147_494107_5B2B0361 
X-CRM114-Status: UNSURE (   8.22  )
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

On Thu, Nov 07, 2024 at 08:13:49PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Simplify the testcase by not creating a namespace when setting up
> the target and have to loop iterating over all namespaces.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: use for loop instead of seq per style guideline]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

