Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2905CCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=; b=SRi7wIdhUCf0NTVIWbesAGPRGO
	bAR6CqBo+4f2ySEFQKccinoryfspE2enO2j6DjqI8Vl7nnPkaTtXo2oqHtD3pvR9pG5o4bpY8D2QX
	JInxR9M6Xhih01hAVfnylkgWW+X2s+N8qeqdL7gV0LKwfu7ptxMnrHURQswxL7inefsgsuKoShBDG
	HQGziJLrMiqYjoLV5D4WUdRX+gzJQAPbowcDwKKHBWDdWUW4SRDyozlbBiaUUIodLU9vRt8MHYUWG
	hvA65UVxs3E4J4NUlcXU90XS7qFXQ9xDBHIPwGqILu2hfJPcfikzkSyKNFbzX64fGYWz1/EXQ2gHE
	cVXXidQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE33Y-00000000crM-3F9w;
	Wed, 29 Oct 2025 10:05:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE33V-00000000cqE-3OJi
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:05:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0DD205AE;
	Wed, 29 Oct 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=uh5/iJo23Keblw9wEJ1C3Dcsi9FZTS3Pkvq7lMbAl4KDrEyI16NkvK05vzCj8rCd5XW9Lr
	Fg55OE8sfaleDQb6/4MLksC1RaKolJ6EoUu0qFL86deYdmWgiCWHn8hqxLCYjguYPIKqpB
	jpgs1EGC8pc2wIsmdwdHL6p0vD246ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=vRNjCpqMO+aCCdy4CjLT09Wm0bxQkRMZzKU7Y4abBQtCCBBE632eaKejW/tdtLmJqky2qZ
	gD4Fasz2qQGdbwDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uh5/iJo2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vRNjCpqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=uh5/iJo23Keblw9wEJ1C3Dcsi9FZTS3Pkvq7lMbAl4KDrEyI16NkvK05vzCj8rCd5XW9Lr
	Fg55OE8sfaleDQb6/4MLksC1RaKolJ6EoUu0qFL86deYdmWgiCWHn8hqxLCYjguYPIKqpB
	jpgs1EGC8pc2wIsmdwdHL6p0vD246ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=vRNjCpqMO+aCCdy4CjLT09Wm0bxQkRMZzKU7Y4abBQtCCBBE632eaKejW/tdtLmJqky2qZ
	gD4Fasz2qQGdbwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D51F1396A;
	Wed, 29 Oct 2025 10:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z2CEIePmAWlUJgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 29 Oct 2025 10:05:23 +0000
Date: Wed, 29 Oct 2025 11:05:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Justin Tee <justintee8345@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
X-Rspamd-Queue-Id: 9E0DD205AE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_030525_992301_CBCFF725 
X-CRM114-Status: GOOD (  16.02  )
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

Hi Justin,

On Tue, Oct 28, 2025 at 05:33:17PM -0700, Justin Tee wrote:
> > nvme_fc_ctrl_put can acquire the rport lock when freeing the
> > ctrl object:
> >
> > nvme_fc_ctrl_put
> >   nvme_fc_ctrl_free
> >     spin_lock_irqsave(rport->lock)
> >
> > Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> While I agree that we can’t hold the rport lock when calling
> nvme_fc_ctrl_put, nvme_fc_ctrl_free also does a nvme_fc_rport_put,
> which could also trigger nvme_fc_free_rport, making rport invalid.
> Should we also add kref get on the rport before entering the
> list_for_each_entry loop?
> 
> Also, because nvme_fc_ctrl_free removes itself from the
> rport->ctrl_list, should we also start using list_for_each_entry_safe?
> 
> So, something like this?

Yes, this makes sense. Just wondering why I didn't see any KASAN
reports. 

Should I add your change to my patch (obviously mentioning it), or do
you want to send a patch yourself?

In the meantime, I am giving this patch a spin in my test setup.

Thanks,
Daniel

