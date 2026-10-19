Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E860A2603
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LPAiYZNo;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B1N4q3FF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sXlFMUUu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wadop/V8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9eStKV0R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7yKnfAHa1v9LGP7+XQTfNitsFqTEJMzZVT63Vgda8I=; b=LPAiYZNolS2+f6ZWj/q7kBLlsj
	ehyZAW59xugESxS0aw++8LkLDU2ZEkLXzdP2Ff8M2CC0vSmQCTVVJX1jBX7esbzhQJX2vhRn26jEl
	Z1ndJ5fjIMi/BHMoghdrJoaIWEd7x11RBPGnLkHhIuayYA/OJji0D4qGChW7APQscthxx3WVtJlE0
	ObKuFBxISUSb2qL4IkIetVK31M1KKNlhUoLEwmN3mFEbadRI3RjQJmajD8f/NxojhSyTq8IXffxwZ
	Dj6PgV8c7XcgLHcE1KaBkNuiLa4K3/Klvf/8ch7dWxZLc/iW0NX33XZB7UkW32YRw2iPtFUJ8WoQW
	uxplBH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqGs-00000007yOk-0PUh;
	Mon, 19 Oct 2026 16:31:34 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqGq-00000007yO7-0flE
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 16:31:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1543121CFC;
	Mon, 19 Oct 2026 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792427490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7yKnfAHa1v9LGP7+XQTfNitsFqTEJMzZVT63Vgda8I=;
	b=B1N4q3FFEN0cEUnHjO+0x3zR1YFaSlQRfUWYn2hl9qTJWTtJEh6bdQsesJ2Lfsq3/OzT3C
	T6E8Ia3/WGcmBJ5M+nwUODy1TpNe23xZm274bNnx8TAJ3wsNcdWXhDWYbpWlbm7z0SZEve
	6NKOqZ8CpFGLuNnYCHFhg60U5gwOZvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792427490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7yKnfAHa1v9LGP7+XQTfNitsFqTEJMzZVT63Vgda8I=;
	b=sXlFMUUudGaLkEYbFgVW9Nd0ZiwsOgQo8cvBnuHrczvPUcl6oAe7EUBsmLuwqUGKXV40GB
	mO55j/aYCXUpq9BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wadop/V8";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9eStKV0R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792427489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7yKnfAHa1v9LGP7+XQTfNitsFqTEJMzZVT63Vgda8I=;
	b=wadop/V8PdksECiRJ+ZxP7GN88pWMCJL4pz9dPw1SdHI3jnfbzSlJnmF94bE5mOEw4wSjs
	QKIXMUBT8v5OUyGoM9xLXs48TvToI84+PA6p15PnVN+Atp+fugNALmp5ALHVdRc82xU9+Y
	J/gK2YksN2ysps/1QSedrocn4FVIVww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792427489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7yKnfAHa1v9LGP7+XQTfNitsFqTEJMzZVT63Vgda8I=;
	b=9eStKV0RTfFgYdA3saGtZpHWCvtdltoZtfLwgLva3zfn9Jv0SFkQ50LBiseKNe4QD9ZEQg
	ZlLoOH+PznFSr0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA5B2136CC;
	Mon, 19 Oct 2026 16:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dicoL+BF1mquawAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 16:31:28 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/18] nvmet: Send an AEN on CCR completion
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Justin Tee <justin.tee@broadcom.com>, 
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260920182936.2317916-6-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-6-mkhalfella@purestorage.com>
Date: Mon, 19 Oct 2026 18:31:14 +0200
Message-Id: <179242747494.3619480.8696467521098938874.b4-review@b4>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1543121CFC
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,grimberg.me:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_093132_498421_F4930E92 
X-CRM114-Status: GOOD (  10.61  )
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> When an impacted controller that is the target of pending CCRs is torn
> down, send an AEN to each source controller that issued a CCR against
> it. The notification points to the CCR log page that the source
> controller can read to check which CCR operation completed.
> 
> Split nvmet_add_async_event() into a locked helper so the AEN can be
> queued while ctrl->lock is already held.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

-- 
Daniel Wagner <wagi@kernel.org>

