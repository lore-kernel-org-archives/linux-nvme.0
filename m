Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F1606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dvKfY9RM;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AFCeqoyq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PtRo0kYc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LeHPOiZF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RSpEkotT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1owvKF5GUqL0M9P4jkFUzj6aV11RPSJnJ/xdbSfMNg=; b=dvKfY9RM1WxguGwpyYRGW9B3NL
	krKxr9LDwEgaO63Xrm6gsMUJipWXZbBl3HxkA2RvdQzmJSSF55j9htt7N3otJerdWY8Lr5fMmu0t0
	6tdcfT3gPrgazdCkSVQLaY261qsLTcfiU6/WxlR7RK0gtu8d5ic5JUvjJOqyQIKwf1nVSg05t4ZHO
	TD298/QX0BsvC1W3Kb/HwfEQXzEIV859sGNANdUSsjSqXZrt7uz312UURzMC4GLsaDE2cl8bQtFnh
	wWFExl+GG1dEiFOTiSgK+YddVBPWZWdE/fl5slfRaVrDXsaxudUv37vWVyHQFITt+YPquAATZQQto
	lqQ47ImQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRhv-0000000BLzz-0oO5;
	Wed, 21 Oct 2026 08:29:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRhs-0000000BLzG-2hQi
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 08:29:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A00DC1F7A8;
	Wed, 21 Oct 2026 08:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792571394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1owvKF5GUqL0M9P4jkFUzj6aV11RPSJnJ/xdbSfMNg=;
	b=AFCeqoyqYjFYzQCDI7Hl4K3chgNdJEopDVQULex2hcbPl7bH0yL3pcI0eOIX74ri9LvorZ
	E+X+N5e+qcPaVO7diQ3pDa8DlMZr/yH1HoPrllgwLgi9ful+3O35hj/GlLzAyxQaKizM6l
	suW3I2kclCNFnt7xLNgAFY6hV+UMMLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792571394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1owvKF5GUqL0M9P4jkFUzj6aV11RPSJnJ/xdbSfMNg=;
	b=PtRo0kYcc1OvNGTCWg6qhwQsUtK1YiQTx6Mj7JjQWJPuNpWN7HVu0zpXmTM0SKA+RYntVX
	+R/M+V35mmg0Y0BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LeHPOiZF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RSpEkotT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792571393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1owvKF5GUqL0M9P4jkFUzj6aV11RPSJnJ/xdbSfMNg=;
	b=LeHPOiZFnLL37OuE20dQtE7TOdpQ670dVpOlmXuBwfYv+vepBfqc/lep8oIlFjRfHZdas/
	DUOmxP9nCIsEYZPFYKz8UkHYs2JAg9a7DuO4l8RQqodI9AeIs4X8wtoWlJNxOejEf+sdr6
	ByZHWFzeCEEVFIsyhMn1PbIbuZ1eMno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792571393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1owvKF5GUqL0M9P4jkFUzj6aV11RPSJnJ/xdbSfMNg=;
	b=RSpEkotTRCtW3bg80V61ePHDplK4AZtZYWw2lLBxkNsEiW9463FY5+mrz5sGEiN2FYbvzi
	7y9SAuVzY7lHGECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66334134FD;
	Wed, 21 Oct 2026 08:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJ+bEAF42GqSVQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 21 Oct 2026 08:29:53 +0000
Date: Wed, 21 Oct 2026 10:29:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Message-ID: <5f52d97f-dd27-48b5-8502-1a3b5ccf4d92@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
 <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
 <20261020235624.GQ2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020235624.GQ2931-mkhalfella@purestorage.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A00DC1F7A8
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_012956_825893_C3C613BC 
X-CRM114-Status: GOOD (  16.17  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:56:24PM -0700, Mohamed Khalfella wrote:
> > This part could be made a bit simpler and there is no need for the local
> > completed variable:
> > 
> > [...]
> >         if (!wait_for_completion_timeout(&ccr.complete, tmo))
> >                 ret = -ETIMEDOUT;
> > 
> > out:
> >         spin_lock_irqsave(&sctrl->lock, flags);
> >         list_del(&ccr.list);
> >         spin_unlock_irqrestore(&sctrl->lock, flags);
> > 
> >         if (ret || !completion_done(&ccr.complete))
> >                 return ret;
> >         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> >                 return 0;
> >         return -EREMOTEIO;
> > }
> 
> You are right, this is deleting "completed" local variable at the
> expense of checking the ccr.complete again. I find the current code
> easier to read and reason about. I prefer to keep it as it is.

The point is that with the local variable, the reader has to track back
and work out where it is set. I had to do exactly that while reviewing.
Putting !completion_done() in the condition makes it self-documenting
and ties it directly to the wait_for_completion_timeout() above.

