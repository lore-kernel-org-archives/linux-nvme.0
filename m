Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AA606A31F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SDeH7KuQ;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sOXxlfr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p8DA46n4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sOXxlfr3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p8DA46n4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DSemvsn3rBQsTreVJV9vR9a2c/GssNnc84YSLaBk0Kc=; b=SDeH7KuQDMYsrlrDOXgEg4nriG
	KZ36Ov7A/v0eZDhMOm3mCnUMhraj1y+rln3W30SeNBcPgggcXRZf7aBWKW+276zwWjjmCIfHiAjWP
	lVgngws7pgKN8ZZHZRwpdxmrH6TE95FHcH955uCRtv0cBa49RJ/uYz4yYgs1AwkDNSC7B8QqmNvVc
	WX6L8cdjU+h2nDez9nR8P6dyiBqBBwQ4SI4aXDchLeotn93/9mH792vLdZ5aUD64tGvAEmeBbgQFz
	8uyxC9fIrzoJgD8nGRKMJIhovBAkvGdC9CNKh3zdXpt9arw9DGmvLJUi+Sq1/5Ge9zi4qCvnk7pmJ
	dlpJgSTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSit-00000009lpR-3OrO;
	Thu, 29 Oct 2026 16:11:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSim-00000009lou-3sfR
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 16:11:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C82921DCD;
	Thu, 29 Oct 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793290276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSemvsn3rBQsTreVJV9vR9a2c/GssNnc84YSLaBk0Kc=;
	b=sOXxlfr3vVkY17tMCvgD0EpwNJkgH1Gc5alN15LFyauldv3Y6u83W8c7lLLb/eDnqxSNuR
	YHpY58N0h1Y6mzJ2TL5PlLeiRYgWbQt96BxxIUfMY5mqzo6QorxgQ+lgOzO3slHH+8+yZM
	k9vkLl4mSByWZOA6FRkX3ByNAaUbi+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793290276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSemvsn3rBQsTreVJV9vR9a2c/GssNnc84YSLaBk0Kc=;
	b=p8DA46n4EzpJ6jfnMurT8/2dTb54DLKe/oanu2pqBvxVq2KhQfaWTdgSXzas+eA9l8U3np
	V7KCnBOaEjR5fYAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sOXxlfr3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p8DA46n4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793290276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSemvsn3rBQsTreVJV9vR9a2c/GssNnc84YSLaBk0Kc=;
	b=sOXxlfr3vVkY17tMCvgD0EpwNJkgH1Gc5alN15LFyauldv3Y6u83W8c7lLLb/eDnqxSNuR
	YHpY58N0h1Y6mzJ2TL5PlLeiRYgWbQt96BxxIUfMY5mqzo6QorxgQ+lgOzO3slHH+8+yZM
	k9vkLl4mSByWZOA6FRkX3ByNAaUbi+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793290276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSemvsn3rBQsTreVJV9vR9a2c/GssNnc84YSLaBk0Kc=;
	b=p8DA46n4EzpJ6jfnMurT8/2dTb54DLKe/oanu2pqBvxVq2KhQfaWTdgSXzas+eA9l8U3np
	V7KCnBOaEjR5fYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C2641339F;
	Thu, 29 Oct 2026 16:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RCG7NSNw42q7MAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 29 Oct 2026 16:11:16 +0000
Date: Thu, 29 Oct 2026 17:11:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me, 
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling
 and queue info export
Message-ID: <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026123411.1988949-4-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3C82921DCD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_091121_134239_F82BBC89 
X-CRM114-Status: GOOD (  13.36  )
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

On Mon, Oct 26, 2026 at 06:03:21PM +0530, Nilay Shroff wrote:
> Following the feedback, the logic for determining the number of fabric I/O
> queues (nr-io-queues) has been moved to userspace in nvme-cli [2]. As a
> result, the first two patches from the previous series, which implemented
> this logic in the kernel driver, have been dropped. This series contains
> the remaining two patches, which export NVMe/TCP I/O queue information
> through debugfs to facilitate host-side network tuning.
> 
> The first patch introduces debugfs helper functions that can be used by
> drivers to export debugfs attributes.

What is the expectation, what's the use case here? Should this
information be available in a productive system? In this case debugfs
might not be the right choice.

