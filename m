Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A58C87FDA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=; b=zCxEfvv7eV8BLC9k95KB0FLeLt
	yVUid6c9r/7O5/2Rzh/mUTqYrVuPvxV2MV1+UIT5oD2nh/fO7QqV5NbUE75+BTtlF15Z9tQ2aM/He
	T+r3+Nk9tsQ8Ks+Qr0wklPt84gx6To0MPRuMokrP3M+aevdhnwcX60yM/SyV5roeMKcZPbg2/haZV
	yDOJz7Djb7KY2rDrne1N6qUzsvbDpi1108atXcfbHmZzmxE9p5K3yqrobaarcFYyDr+NXdO6Vh2mx
	LD+bCvuZIWLg5gHT31GhPSEr2shNWLwwRwSQClEUsXGFhjBWUsKuDOCAuVfgogoo0qlxjryNVVkya
	9QA2zSzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujuwc-0000000HRxW-1StP;
	Thu, 07 Aug 2025 07:21:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujuuM-0000000HRfy-47TC
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 07:19:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4A1B33C79;
	Thu,  7 Aug 2025 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754551163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=FOJxSC7zGyCrvj8vxuhgICa+/ruIOTxJiTJsAUH9+L0qIhuj72AifnM6qa0L/7mCs78RBw
	t/UTmAVt5cAgrzmTsWRnrZWVpLXF9HTeHIhCLLXQ8jrX5eQfrDdW6sEbKJlccEq4+mgbBB
	SX4Zhy65i01jH8WWgqkn1X9KnGvnhTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754551163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=QZg+PxFgXQw9Um9Xh9/LwUwACUTD2IhUJcpoi9gBZnCwMXh0YPciUjq55oA47mP53gq2w4
	u04wtZEP8dCFCYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754551162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=RAfJhFuCEq8++cmJU6YyWtl/iL/79g0/W5fcUDyMphuR5wW0+s/6YMu5clCzcgQI/h5Ei1
	jhLCnG/umEjg9/ff4eKHCZmoXcpSrgKLILattR5OC1o6vbT5MU4e0JavqwB9fqIh72BZlz
	HDP/4Rknt6eCYMAaJ0aN1Uq5ntIL9AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754551162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=lY2gJQbnPkglW94gaAuw5FPWa/DsnU5Wn9ntzCqBFSFmJBxZwP6YXhfZ9Jw3Zbm2T2MoLW
	35d9N77Y/OmI53Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1F9413969;
	Thu,  7 Aug 2025 07:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id einYJnpTlGhKEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 07 Aug 2025 07:19:22 +0000
Date: Thu, 7 Aug 2025 09:19:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Hannes Reinecke <hare@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Randy Jennings <randyj@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Message-ID: <3f440533-8feb-49bb-8dde-6ae520b81d39@flourine.local>
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,flourine.local:mid,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_001927_166908_46426577 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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

On Wed, Aug 06, 2025 at 10:35:07PM -0700, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
> Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

