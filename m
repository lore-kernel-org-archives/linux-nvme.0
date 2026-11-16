Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8409606A335
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KVSKZnHd;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hi+7am1n;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a6HFcYZg;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hi+7am1n;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a6HFcYZg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5dd3gaWnxyGYmLDfQYceg41vjRMRWzOvPs+gvBjx0cg=; b=KVSKZnHdBMr651LxyLXeWfeoVg
	LZMcPhhHk/KpMTJlkK8fWJObEmnD/TKAvatB4Dv7YGTVJUzpFUUZt8xuEY2yzV0sScnM3q5lr4iWj
	18UDJtztc29mgLi28sqyhvsNa5nIVkjUkq51Mu1WI6EI90s48aeNzNlnhDsjfRf3RCo8szgTPY6R9
	p70WoChhjmAfy48mnCcO4Bq4t26z9GKUJrxG3AOeKQn40FqbhDPyn4DdKlc+gytZaiT+wO8ABOtr8
	UbzwQZdFfCCL9Zzp0vRzCQEWLItQIV8sbgz9SRrTT50eTiiXNuN98PUNi33qDlgTWYTW6htVBr/sc
	gTf0lW2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvKm-00000002GU8-11BR;
	Mon, 16 Nov 2026 11:57:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvKj-00000002GRF-2ixF
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:57:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3807522288;
	Mon, 16 Nov 2026 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794830230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dd3gaWnxyGYmLDfQYceg41vjRMRWzOvPs+gvBjx0cg=;
	b=hi+7am1nCU82xuxgxJ3x1Q+7twFUxXAhmtRKgkw6ZHdNS0IPvLhLiKC4uDUbqqjUxfkO5R
	W97VxwcpFF+tseH9CD1RRAyGXq8JSTyz0/nX2329JtfEtKrNBYUzeqWDsD6xweP7U60+YB
	dY8nblDInaXxv4tg/Q6CKtOsryKRVzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794830230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dd3gaWnxyGYmLDfQYceg41vjRMRWzOvPs+gvBjx0cg=;
	b=a6HFcYZg6dz08eQi4ySHauPik6itTK+HROwVhnt3GP6fnnvjX+Fg7ABd1cgQn+qcp9xGL/
	+OcAb3Ppbz5loJCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794830230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dd3gaWnxyGYmLDfQYceg41vjRMRWzOvPs+gvBjx0cg=;
	b=hi+7am1nCU82xuxgxJ3x1Q+7twFUxXAhmtRKgkw6ZHdNS0IPvLhLiKC4uDUbqqjUxfkO5R
	W97VxwcpFF+tseH9CD1RRAyGXq8JSTyz0/nX2329JtfEtKrNBYUzeqWDsD6xweP7U60+YB
	dY8nblDInaXxv4tg/Q6CKtOsryKRVzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794830230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dd3gaWnxyGYmLDfQYceg41vjRMRWzOvPs+gvBjx0cg=;
	b=a6HFcYZg6dz08eQi4ySHauPik6itTK+HROwVhnt3GP6fnnvjX+Fg7ABd1cgQn+qcp9xGL/
	+OcAb3Ppbz5loJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F471334C;
	Mon, 16 Nov 2026 11:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C6ISNpXv+mqcRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 11:57:10 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 9090E24DD2; Mon, 16 Nov 2026 12:57:09 +0100 (CET)
Date: Mon, 16 Nov 2026 12:57:09 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 07/12] zloop: take freeze protection when recording write
 pointers
Message-ID: <t73376p7ip4bvetjbqijzugvglhi2rdxsqt62l3uuqtmt3tqgk@2rlkkdy33hwk>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org>
 <20261116064820.GB2964@lst.de>
 <20261116-biegen-flaute-flanke-cebddae97444@brauner>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-biegen-flaute-flanke-cebddae97444@brauner>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_035713_872674_FFC88E89 
X-CRM114-Status: GOOD (  13.09  )
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

On Mon 16-11-26 10:41:49, Christian Brauner wrote:
> Fwiw, the check can't go into __vfs_setxattr(), __vfs_setxattr_noperm()
> or __vfs_removexattr(). cap_inode_killpriv(), IMA and EVM call those
> from ->write_iter() via file_remove_privs() and kiocb_start_write()
> hides the freeze protection from lockdep for aio and io_uring. I have
> not bothered to figure out why. Maybe you already know? In any case,
> until that's fixed we can't place it there which means this doesn't
> catch IMA/EVM at which point this patch becomes pointless.

It's because of AIO and io_uring - if you don't hide the protection from
lockdep, it will complain about it when returning to userspace while IO is
still in flight (and thus protection is held). Sadly lockdep does not
support releasing resources by anybody else than the process which acquired
it so we fool it in this way...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

