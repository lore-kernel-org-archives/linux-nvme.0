Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F8606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w50Ln5CF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=; b=w50Ln5CFViieMh67HAsCxWM3NK
	WODDqLP5Z+ytRB4b7sNQEJcIWPV8tNvY9T8ac35Q1z/ndqLtxW/ZkNwhEPwbDet652jB4k7ffNq4+
	AJhHYUWJ+oGKo26xdLvDkr1LeLvKfT0ANfIfihm9GilWX4cH7qBv2T5ZY0BcyHGSyQzrUn4FAEsu4
	0LNjTOa9Qol9NHMQKP6wulyazWSLdMaD5kcNfc3VlKYirGFtUfWkduXC0QMNy6wueVrIIW2/j0GF3
	hsnAjGM6fI1bt8Yrj3Ru7szhpZeGJZjBRVwgPa7xJo6AiC7HzIghU6HYdoVyDJv9ruwspRJY9bObS
	K5hYHOgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQw7-00000009Kf5-3AEa;
	Thu, 12 Nov 2026 09:17:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQw4-00000009Ke8-1YcB
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 09:17:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FC0E21E73;
	Thu, 12 Nov 2026 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=KTGVIk5P0kN0zFMRP5qToi/IUI6jwaZvHPpksntaERfKWrj/fY7CEDKce0jvluwQHobnZM
	DhyfCY4laq90Cc9t5pHoVkwLKx/dIJPAO5TlxDTdx+awAEcgkcSGPHx8asA+C2lvTzO1pv
	+YyRSxvLAk66qBiEEkyztbVBMPlYqAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=dQSUvYPPz+VhJLwdjvyFbanGlHthSrmW1Yk8bDIVOHFoOp3UoDQxhIJgTrwiba+GIvJ7gD
	jvseyVwAK6hOYfBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=KTGVIk5P0kN0zFMRP5qToi/IUI6jwaZvHPpksntaERfKWrj/fY7CEDKce0jvluwQHobnZM
	DhyfCY4laq90Cc9t5pHoVkwLKx/dIJPAO5TlxDTdx+awAEcgkcSGPHx8asA+C2lvTzO1pv
	+YyRSxvLAk66qBiEEkyztbVBMPlYqAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=dQSUvYPPz+VhJLwdjvyFbanGlHthSrmW1Yk8bDIVOHFoOp3UoDQxhIJgTrwiba+GIvJ7gD
	jvseyVwAK6hOYfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D2F4134A0;
	Thu, 12 Nov 2026 09:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6fFqBi6E9WogeQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:17:34 +0000
Date: Thu, 12 Nov 2026 10:17:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 09/10] nvme: skip the tests which need a feature
 the remote target lacks
Message-ID: <c170db9b-6659-4fb2-a465-9c4adee0471c@flourine.local>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
 <avRD23enUQ1UfQpj@shinmob>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRD23enUQ1UfQpj@shinmob>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_011736_657701_A701549E 
X-CRM114-Status: GOOD (  13.08  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 07:33:36PM +0900, Shin'ichiro Kawasaki wrote:
> > +	features=" $("${nvme_target_control}" config --show-features) "
> > +	for feature in "$@"; do
> > +		if [[ "${features}" != *" ${feature} "* ]]; then
> 
> The line above is a bit confusing for me. I guess the line can be simpler as
> follows:
> 
> 		if [[ "${features}" =~ " ${feature} " ]]; then
> 
> May I ask you to confirm it?

Agreed, Klaus likes complex stuff, after he is German. An a more serious
note: though to keep the logic consistent it would be

        if [[ ! "${features}" =~ " ${feature} " ]]; then

The original line checks if the feature is missing so that the function
can skip the test.

I'll change it. Thanks!

