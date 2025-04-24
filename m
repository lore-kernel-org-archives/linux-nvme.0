Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB2C369D8
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oe37kHa6OjABHOtp27KFBj6FfYXoBY4b396xoyxnzoo=; b=C+uoU7LP/SK+qujB0dOUuCHnU9
	PHZpa6yVHKvcYccQEEPqvc+n+Dm3m5n3/nIZe5tKcGXgfMsTjywt3HVHFBBgXhvitxAN7emzPfHgN
	lfNECU1F8QFBxWECpxBaUJsr8X1xJj1tmK8Ue1dJF5tEBo/4/DPrdNMEogzSo9xjY3CyeqLqwNlKR
	dVfCuPJACckeDtYf6oo2uyqcvVM459Tm/j8lttzeYXN0Wv2oq7c2pcXfKN0rhSCPMkNA/X3CIeWVN
	BMHBSudmhJ5JJPg8rTPO/4bPS0yGN4wvfQvdbU9R/SRR9Rei9Rtbi5lE0x1aNwCldR5rua934/vGi
	UpIHTe8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wlo-0000000ECR7-2eWS;
	Thu, 24 Apr 2025 13:37:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uid-0000000Dqra-27UZ
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 11:26:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDE4921171;
	Thu, 24 Apr 2025 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oe37kHa6OjABHOtp27KFBj6FfYXoBY4b396xoyxnzoo=;
	b=Y6dGXbMwS9heb+/Fs+KWsMOpwCIjZapSKWgunkd7LFXKvpvmrxnf5jwRz0gf9HzIl+KaoG
	72g0ZBXio+JFpCwfRXbkCAlBre+pQvocNH3qWabNaB/764VJKDy05yIVQPS0ZGIkDvvmBZ
	Rm+ak4vHXgE4jKoCh67xR4t18J62pqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oe37kHa6OjABHOtp27KFBj6FfYXoBY4b396xoyxnzoo=;
	b=TBR+T+ncVgireaKgoU8ClVbRIp/p6cLFPKGf3ZzzqNIq8casg0ygGQbFPRk+skOx7hwhNF
	ZhEBiBO6Y/Uf5fCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oe37kHa6OjABHOtp27KFBj6FfYXoBY4b396xoyxnzoo=;
	b=Y6dGXbMwS9heb+/Fs+KWsMOpwCIjZapSKWgunkd7LFXKvpvmrxnf5jwRz0gf9HzIl+KaoG
	72g0ZBXio+JFpCwfRXbkCAlBre+pQvocNH3qWabNaB/764VJKDy05yIVQPS0ZGIkDvvmBZ
	Rm+ak4vHXgE4jKoCh67xR4t18J62pqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oe37kHa6OjABHOtp27KFBj6FfYXoBY4b396xoyxnzoo=;
	b=TBR+T+ncVgireaKgoU8ClVbRIp/p6cLFPKGf3ZzzqNIq8casg0ygGQbFPRk+skOx7hwhNF
	ZhEBiBO6Y/Uf5fCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCCE81393C;
	Thu, 24 Apr 2025 11:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmuxK9UfCmiTOwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 11:26:13 +0000
Date: Thu, 24 Apr 2025 13:26:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/14] nvmet-fcloop: add missing
 fcloop_callback_host_done
Message-ID: <44b6159a-a86f-4b76-bcef-35f267e69835@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-6-3d7f968728a5@kernel.org>
 <89289452-3647-4d94-baf9-529d145b652f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89289452-3647-4d94-baf9-529d145b652f@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_042615_687230_59D986BE 
X-CRM114-Status: GOOD (  16.31  )
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

On Thu, Apr 24, 2025 at 12:13:10PM +0200, Hannes Reinecke wrote:
> > +	if (!tfcp_req) {
> >   		/* abort has already been called */
> > -		return;
> > +		goto out_host_done;
> > +	}
> Sure this is correct?
> If the abort has been called I would have expected that all resources
> are cleaned up by the abort, so we wouldn't need to do that here...

Yes, it is still necessary to call fcpreq->done for this particular request.

> > @@ -983,7 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
> >   	default:
> >   		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
> >   		WARN_ON(1);
> > -		return;
> > +		goto out_host_done;
> 
> Do we still need the WARN_ON()? We can now gracefully recover, so a
> simple log message would be sufficient here, no?

The WARN_ON is there because it catches when tfcp_req is in an wrong
state. It should be either in INI_IO_START, INI_IO_ACTIVE or
INI_IO_COMPLETED but never INI_IO_ABORT.

