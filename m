Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C57CAC5B8
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=; b=EqRpitwAc+bNNfY3Or8TCkrA7j
	RXF0F53ANlXDvJCxIXa8D9hsGwzO14N45JwNRgVkEO675upxkOkQHj4a4Ozy+L1JXo+17E/Igzh3a
	LqIKNBuEpbIw9Ka6o1UTPZP7uD0XAPoqbwuPCgS1wcSG4gR58zcZWPlU39hjZ2UMgwDu7nF4QzfYK
	QLAyecTVPKShEg7ALQ50zk7wm13g/V6BEHsv/bunjTK5f0KnWyBjHs98XDWGcw+sB1YvWbtCrnh2W
	cjjFa6BDYxM1rWhqbgF9zqiW7U50GT/kObm5Wm1AXekJUJmfTcf5LGwCu9B90k1r9RfNOAHBE8/f3
	iOWEqvOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5kZx-000000002KF-1Su0;
	Mon, 06 Oct 2025 12:44:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5kZu-000000002Jq-2yM2
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 12:44:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD7D7336BD;
	Mon,  6 Oct 2025 12:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759754672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=pPyAgPf4kvAJrhmw4OfFXo42H5shi3KNgj5nCT+ijbbhAwIloN79IljqBPn50ow+QKzbXa
	DXn7snqe2V/Edv5VmjmJ6fl78RTV0VsB8Z0h/wBXQhiqAwKkrObavM7Zbw3iEc6MS4ozVg
	Gv2GnWfmEhHox+Y8O/WzaT4NLVoIkyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759754672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=UAu6VZQ8K0dWeJXUbn0Ho6SX0wqpasOx5bZypvW49V6Mecdhd28FE0BO/GbTgsOmVxLPLT
	nqRUoRGW528G64AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cm9V9yF8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BXlcrGVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759754671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=cm9V9yF8wMm/bOGNABah3vuX4MCSFYe3fdvEYfRvA1A7ddE9tywOLpY0J1ZRw942O0U/R0
	4/d+Q0LJoMJ/gr5CgF0MLEFHkqrahnz6gshuM4J9AArDC68JAaQuyhb4Gr6jM6gMuqoErn
	rZNcDEN8Xi2Ycz5fF78qzYGXxQDtvPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759754671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=BXlcrGVA9g8ENQCpEg36kAdV0iFakq+mTvFRl0d672JtmyAm0zFLsksxtk/q5LXmjmpOUb
	IF1AXTDHb+9a4CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF64B13995;
	Mon,  6 Oct 2025 12:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SvLMa+542gefAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Oct 2025 12:44:31 +0000
Date: Mon, 6 Oct 2025 14:44:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Message-ID: <2bc10e91-d937-4584-967d-133487524980@flourine.local>
References: <20251002092202.11-1-alsp705@gmail.com>
 <20251003101354.GA15826@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003101354.GA15826@lst.de>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: DD7D7336BD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_054434_901032_3A71AC27 
X-CRM114-Status: GOOD (  24.13  )
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

Hi Alexandr,

On Fri, Oct 03, 2025 at 12:13:54PM +0200, Christoph Hellwig wrote:
> Adding Daniel who has been touching this area recently.
> 
> On Thu, Oct 02, 2025 at 12:22:01PM +0300, Alexandr Sapozhnkiov wrote:
> > From: Alexandr Sapozhnikov <alsp705@gmail.com>
> > 
> > The nvmet_fc_tgtport_get() function may return an error.

This description is not correct, because nvmet_fc_tgtport_get wraps
around kref_get_unless_zero. The return value is never an error code.

> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> > ---
> >  drivers/nvme/target/fc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > index 337ee1cb09ae..68a416a92bfc 100644
> > --- a/drivers/nvme/target/fc.c
> > +++ b/drivers/nvme/target/fc.c
> > @@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
> >  static void
> >  nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> >  {
> > -	nvmet_fc_tgtport_get(assoc->tgtport);
> > -	queue_work(nvmet_wq, &assoc->del_work);
> > +	if (nvmet_fc_tgtport_get(assoc->tgtport))
> > +		queue_work(nvmet_wq, &assoc->del_work);

nvmet_fc_schedule_delete_assoc can only be called when a reference is
held on the assoc->tgtport. The nvmet_fc_tgtport_get is necessary so
that the resource is not going away while the work item is executed.

And this patch doesn't seem against a recent kernel as it misses commit
70289ae5cac4 ("nvmet-fc: put ref when assoc->del_work is already
scheduled") which was added for 6.15.

I am not against this change but I was under the impression we don't add
code to make some tools happy. Maybe it would be enough to add a
comment?

Thanks,
Daniel

