Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAD606A320
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ECuuuDCk;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oD0OusU/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YBzrWBxa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oD0OusU/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YBzrWBxa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWrNx4AAhmtdf03HJHhKfo46RSKRGBnuyAOARsq5cY8=; b=ECuuuDCkjjJ/5DWJwD/oTmLyvJ
	77z2v9w03Ef4ikbyOwvxm0JxkEWoBoWUHZYjHt2lmT/eL0E/nWE2ZoZyHZamg2+xXxVBsm3Uikn0z
	HzrkM6zfmjC4wfuBMMQJH+aJ+tFrfn0LaY7wqnzLcJy+uAosUba6xnnKERJQWT/ORxEDKkGLsUje6
	uFlN9kA35D/fROd6W5PZTLqPpdODB5AUCKGDMn0OOoACpRuAPk9nKwFwu+GJE/Div56mrLgEuo98S
	XxaHIPoTUM4V3ZXWGkjBVlMpVS16hzQ4PeGChVNWGd6UWu8g9W3SvLSsoXifwvyaG8X9yAjcsT2Vs
	l5bNrfjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9Qw-00000009j9a-1COq;
	Tue, 20 Oct 2026 12:59:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9Qt-00000009j8m-06Tz
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 12:59:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC081F7C6;
	Tue, 20 Oct 2026 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792501149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWrNx4AAhmtdf03HJHhKfo46RSKRGBnuyAOARsq5cY8=;
	b=oD0OusU/SLaseFS8AHwHSHVA1Ceraj2IBUuPq8xmW8ZTpbaKaXK56j2IWABFk0tccHgOrf
	hHM3TvNacyZb1h+VO6eBri7heWQuI5uLwtMYZbVEeT7AGXNlX+TNPo483+nT3UvcRVYKw5
	FHB9NYD/+6xMqpg+pCY6pUgmmeN3yVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792501149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWrNx4AAhmtdf03HJHhKfo46RSKRGBnuyAOARsq5cY8=;
	b=YBzrWBxaFnvVyogimX1fBadiLdUNY3z4/dYxqcp5Ax12o1vMJITBkr0+3xwDix6uY6/EBu
	EQRbJ1hzxoqXzeCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="oD0OusU/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YBzrWBxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792501149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWrNx4AAhmtdf03HJHhKfo46RSKRGBnuyAOARsq5cY8=;
	b=oD0OusU/SLaseFS8AHwHSHVA1Ceraj2IBUuPq8xmW8ZTpbaKaXK56j2IWABFk0tccHgOrf
	hHM3TvNacyZb1h+VO6eBri7heWQuI5uLwtMYZbVEeT7AGXNlX+TNPo483+nT3UvcRVYKw5
	FHB9NYD/+6xMqpg+pCY6pUgmmeN3yVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792501149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWrNx4AAhmtdf03HJHhKfo46RSKRGBnuyAOARsq5cY8=;
	b=YBzrWBxaFnvVyogimX1fBadiLdUNY3z4/dYxqcp5Ax12o1vMJITBkr0+3xwDix6uY6/EBu
	EQRbJ1hzxoqXzeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12665136CC;
	Tue, 20 Oct 2026 12:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfazN5xl12rnXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 12:59:09 +0000
Date: Tue, 20 Oct 2026 14:59:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
Message-ID: <a3852ed1-4b6d-44e7-b4de-bc1c6a3b635b@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-3-mkhalfella@purestorage.com>
 <179241127352.3544975.2554197788837860779.b4-reply@b4>
 <20261019190106.GK2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019190106.GK2931-mkhalfella@purestorage.com>
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 4EC081F7C6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_055911_451976_5F888763 
X-CRM114-Status: GOOD (  13.37  )
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

On Mon, Oct 19, 2026 at 12:01:06PM -0700, Mohamed Khalfella wrote:
> On Mon 2026-10-19 14:01:13 +0200, Daniel Wagner wrote:
> > On 2026-09-20 11:28 -0700, Mohamed Khalfella wrote:
> > > Export ctrl->ciu and ctrl->cirn as debugfs files under controller
> > > debugfs directory.
> > 
> > Could you add the 'why' part to the commit message?
> 
> target# grep . /sys/kernel/debug/nvmet/mysubsystem/ctrl1/{ciu,cirn}
> /sys/kernel/debug/nvmet/mysubsystem/ctrl1/ciu:57
> /sys/kernel/debug/nvmet/mysubsystem/ctrl1/cirn:42541d24813bb536
> target#
> 
> host# grep . /sys/class/nvme/nvme0/{cntlid,cirn,ciu}
> /sys/class/nvme/nvme0/cntlid:1
> /sys/class/nvme/nvme0/cirn:42541d24813bb536
> /sys/class/nvme/nvme0/ciu:57
> host# nvme admin-passthru \
>   --opcode 0x38 \
>   --cdw10=$(( 0x1 | 0x57<<16 )) \
>   --cdw12=$(( 0x42541d24813bb536 & 0xffffffff )) \
>   --cdw13=$(( ( 0x42541d24813bb536 >> 32 ) & 0xffffffff )) \
>   /dev/nvme1
> Admin Command Vendor Specific is Success and result: 0x00000000
> host#

In the meantime, nvme-cli learned to dump those values as well. I'm not
sure if it's worth adding these just for this use case.



