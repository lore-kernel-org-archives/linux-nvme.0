Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D52606A336
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nVjwxSCa;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mGj3SyMj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZQJR8Txv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mGj3SyMj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZQJR8Txv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HvB4Y2zBxs7WYLMe29I4Dl34Va5y8vlRI+QEd8b7R4=; b=nVjwxSCaYsXQobCRmORv94MGuk
	tTfqcZY7rwvhRhl9KA642yyTsEusFuW8pQEr/jvZNO//PAwVgGBh5BJN68OAHfeMEClrDLX2xzM7C
	X/bvIuAU4w3NsS0GFrg+wSEA4YKMxczn5kb21t86klzf66e2ifJS7/XCEDk+9Nm9lXQcsu262JsvM
	EZQnquIZNFtwnERdQ/nTljbocX3EW8YEqDplqRDve9VANCH3cvZIxL5RArkF9V4kfwqYBFq0mHwGH
	Tcr4lQANhyUMrgUY2DAe4HVO2nwOzuBXFV81Xcs2Dz5LFnbESP5fObFUuOidMWFE+TrHR24suAOaT
	6lEzi0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqei-000000082hq-39u4;
	Mon, 19 Oct 2026 16:56:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqef-000000082gz-0LAa
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 16:56:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69ADC1F45B;
	Mon, 19 Oct 2026 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792428967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HvB4Y2zBxs7WYLMe29I4Dl34Va5y8vlRI+QEd8b7R4=;
	b=mGj3SyMjP0fAAairHpxyFpnOyTkxAYPb/HIetE9Op738WMLug2ldCUW6QZwtfgKWybbn03
	sK8D2bhRafWC7O8olV+LWbM9UMVHJskbHs23qVfw9oYm/MOB6c31rQrvDZ3E2IWHtkd9H/
	5GNIWzDYyzNL7DSqPLXhCVnOqxJKWQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792428967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HvB4Y2zBxs7WYLMe29I4Dl34Va5y8vlRI+QEd8b7R4=;
	b=ZQJR8Txv95QmdQn0ETZILeVvPfyy2CaO86qJdLQVDU+SLahzBeBxa2UnCDhhrsYQuL2J/A
	RJB15J0hhItbLiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792428967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HvB4Y2zBxs7WYLMe29I4Dl34Va5y8vlRI+QEd8b7R4=;
	b=mGj3SyMjP0fAAairHpxyFpnOyTkxAYPb/HIetE9Op738WMLug2ldCUW6QZwtfgKWybbn03
	sK8D2bhRafWC7O8olV+LWbM9UMVHJskbHs23qVfw9oYm/MOB6c31rQrvDZ3E2IWHtkd9H/
	5GNIWzDYyzNL7DSqPLXhCVnOqxJKWQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792428967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HvB4Y2zBxs7WYLMe29I4Dl34Va5y8vlRI+QEd8b7R4=;
	b=ZQJR8Txv95QmdQn0ETZILeVvPfyy2CaO86qJdLQVDU+SLahzBeBxa2UnCDhhrsYQuL2J/A
	RJB15J0hhItbLiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F7D0136CC;
	Mon, 19 Oct 2026 16:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /IV6MqZL1mpbBgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 16:56:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read
 controller identify fields
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
In-Reply-To: <20260920182936.2317916-7-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-7-mkhalfella@purestorage.com>
Date: Mon, 19 Oct 2026 18:56:04 +0200
Message-Id: <179242896496.3619480.12975259904515722687.b4-review@b4>
X-Mailer: b4 0.16.0
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_095609_273090_51EE0328 
X-CRM114-Status: GOOD (  10.57  )
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> TP8028 Rapid Path Failure added new fields to controller identify
> response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> controller identify response. Expose CIU and CIRN as sysfs attributes
> so the values can be used directly by user if needed.

What's the use case for it? This is an public/stable interface,
it needs a justification and documentation

> Also add the nvme_fence_timeout_ms() helper that derives a fencing
> timeout from the controller keep-alive timeout (kato).

There is no user in this patch, introduce it when you use it.

-- 
Daniel Wagner <wagi@kernel.org>

