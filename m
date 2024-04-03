Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12CBCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JgxCSwvNG0P27W5f12h7722+t2gjB+ZxIRQGwsNfcI=; b=C1ldXayJfRiGk0KF/faSw7fiWY
	IqwHT5pB3x5BBzwhqYdORRqVQhkCJoTXF3Jb3zMm6Rs/XRuxXga+xRR1TrLVsb/1lffpwhID9EdoB
	ayEK6A++1DYeOoROIon6a3cY0toQBTkpkKfvo1R/GNjLQZIDkXT8UUvbHok/E+MJXYtwlbzj1CXdS
	LKUzYLI91owpe2cr7YM1MZqzMQ7u6SS7UagVYDm4QhuFg6RwoJpJm9sziu0BN/lniotU3stxdksbz
	+GHMhbcZB7wDO56iZzM1j9tq42NytpZR4UGBHlt8GpB+FUm2OLM+MTVNjuoeqpTUE4DMdZqJypKJV
	VZ3r9kHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs02Y-0000000G0DG-23ak;
	Wed, 03 Apr 2024 12:48:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs02T-0000000G0BG-11zK
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 12:48:29 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B8275CC7A;
	Wed,  3 Apr 2024 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712148501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JgxCSwvNG0P27W5f12h7722+t2gjB+ZxIRQGwsNfcI=;
	b=erLTjwt22qlh8jCk0VENEiNYWMrOugWQUAI4+Dc0a0471LqWR5dvxhffdrSmpvwjjHMlEF
	TkBgd8/+1/gLXKfJN/VZ3p/t0fMRahtmGQjfHEYkQZ9uV6Qov/GkphRABXHBcibuhfShkT
	3mWpWWYi1goH8p9/IKsldzvftmo6nMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712148501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JgxCSwvNG0P27W5f12h7722+t2gjB+ZxIRQGwsNfcI=;
	b=2gWJ9LhkCaAti63VHoGh5s+Ceqj7ljdU8gjOjIDjTM8/NyuRY1gzAkBhjlSqCFC1h3lVx+
	HO5WTJNyvbeqfuDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EDF6213357;
	Wed,  3 Apr 2024 12:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YVGuOBRQDWbBPAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 12:48:20 +0000
Date: Wed, 3 Apr 2024 14:48:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "Engel, Amit" <Amit.Engel@dell.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Cohen, Yonatan" <Yonatan.Cohen@dell.com>, 
	Gregory Joyce <gjoyce@ibm.com>
Subject: Re: nvme-cli =?utf-8?B?4oCYbnZtZSBjb25uZWN0?= =?utf-8?B?4oCZ?=
 --duplicate-connect flag (-D) is not supported anymore
Message-ID: <endkd6bc5yooykdv4kkfb6uvijpkhlic6g7qut6yg5342cjo6j@cvmjm7hy6wk7>
References: <CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
 <bce9276a-c1bf-4faa-8fab-bfc81724646e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce9276a-c1bf-4faa-8fab-bfc81724646e@linux.ibm.com>
X-Rspamd-Queue-Id: 0B8275CC7A
X-Spamd-Result: default: False [-1.94 / 50.00];
	BAYES_HAM(-2.14)[95.88%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.906];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_054825_507361_7484A383 
X-CRM114-Status: GOOD (  12.36  )
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

On Wed, Apr 03, 2024 at 06:07:29PM +0530, Nilay Shroff wrote:
> I think this is a bug in nvme-cli.

Yes, regression from

07d6b911e081 ("fabrics: Do not attempt to reconnect to already connected
ctrls")

> If you want to use nvme-cli then you may try this patch:
> 
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -999,7 +999,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>         };
>  
>         c = lookup_ctrl(h, &trcfg);
> -       if (c && nvme_ctrl_get_name(c)) {
> +       if (c && nvme_ctrl_get_name(c) && !cfg.duplicate_connect) {
>                 fprintf(stderr, "already connected\n");
>                 errno = EALREADY;
>                 goto out_free;
> 

Care to send a proper patch?

Thanks,
Daniel

