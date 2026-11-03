Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC426070A87
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v+rz9D+3;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0Gx/9y7U;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kxGiifaQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0Gx/9y7U;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kxGiifaQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OmVqza68r32jWT+7is8UbaUD50yd0FSVAcJ4aEWMju4=; b=v+rz9D+38N8LTSWrKO8rzdvLPp
	1+dGfnbA4DrKr6iK3gLJB7iuomF7tstbQ4O3ds7M0epHAPOFYJLc7wQbIOfbVjyEkrQaGKN+/PY8L
	EZ+sAsiEvjl+FkIE3zJ/ddO6kQqRQPxHDnM7VgOFpgeRjJ7dSNNkLoHleP683OYAD9sYcaAL0epxv
	V9Z5XDG2a0Ci/szJeMQbnN06TxcG9SNtamkusgzDX0hsx/CDVhGhlo9j3cnPnf9w3Ibd6BobJ3GLE
	bf1A2DrmdDrZJc0mEw/cL+kh4C+MlgWknJis0cJ3HUUrQmpDPiw4LCeMSdzYhGczIco6O8trKAp9R
	zzkLW6/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOC0v-000000023rj-1qpf;
	Tue, 03 Nov 2026 10:45:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOC0s-000000023qr-2JRF
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 10:45:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5E7721F15;
	Tue,  3 Nov 2026 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793702708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVqza68r32jWT+7is8UbaUD50yd0FSVAcJ4aEWMju4=;
	b=0Gx/9y7UOj02HXjG4ZsdvnvIaajiv9dBUb2r3VdVEq0QfXfWxIuCYk7lmKzbP7Dpt9bHXM
	O09oY0CU5ZAk/CmFUHHdy7ARuiW41YjDPJLoqrA+0e57TqdoTPgxtgd1Vwp5y0RD/m6VjA
	awbOn8Xxw+mQ7nRS3A1rHucNSC74faA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793702708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVqza68r32jWT+7is8UbaUD50yd0FSVAcJ4aEWMju4=;
	b=kxGiifaQdf093IUSGJk2pNHGkMa15+9Mjqc/E9+t2Vl5OU5HCx/UBVzLwvfm63nLWik2JX
	I/1W0uM6+7tmkDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793702708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVqza68r32jWT+7is8UbaUD50yd0FSVAcJ4aEWMju4=;
	b=0Gx/9y7UOj02HXjG4ZsdvnvIaajiv9dBUb2r3VdVEq0QfXfWxIuCYk7lmKzbP7Dpt9bHXM
	O09oY0CU5ZAk/CmFUHHdy7ARuiW41YjDPJLoqrA+0e57TqdoTPgxtgd1Vwp5y0RD/m6VjA
	awbOn8Xxw+mQ7nRS3A1rHucNSC74faA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793702708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVqza68r32jWT+7is8UbaUD50yd0FSVAcJ4aEWMju4=;
	b=kxGiifaQdf093IUSGJk2pNHGkMa15+9Mjqc/E9+t2Vl5OU5HCx/UBVzLwvfm63nLWik2JX
	I/1W0uM6+7tmkDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 657F01350A;
	Tue,  3 Nov 2026 10:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zUufDzS76WqlFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 10:45:08 +0000
Date: Tue, 3 Nov 2026 11:45:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Message-ID: <dce1f3c8-d988-45a0-b943-6418b4d704ac@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
 <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
 <20261031082155.GC34016-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031082155.GC34016-mkhalfella@purestorage.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_024510_760103_3544E8BD 
X-CRM114-Status: GOOD (  12.37  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 01:21:55AM -0700, Mohamed Khalfella wrote:
>  701
>  702         if (!wait_for_completion_timeout(&ccr.complete, tmo))
>  703                 ret = -ETIMEDOUT;
>  704
>  705 out:
>  706         spin_lock_irqsave(&sctrl->lock, flags);
>  707         list_del(&ccr.list);
>  708         spin_unlock_irqrestore(&sctrl->lock, flags);
>  709
>  710         if (ret || !completion_done(&ccr.complete))
>  711                 return ret;
>  712         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
>  713                 return 0;
>  714         return -EREMOTEIO;
>  715 }
> 
> Actually, this code has a bug. It does not correctly handle the case
> when CCR operation completes with an error. I added line numbers to show
> that.

Fair enough, then let's use the local variable. 


