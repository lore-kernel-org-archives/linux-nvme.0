Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC89C83F26
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=; b=ZdEHCs6oichTACYeXHy2UYvXIH
	cGscRxjB3WvV79+Yyt6Hli3HRzOh+7maJv6NxOjhs9LpvaNd5IYZi+YvFdSQBG/81cjNRX7OMVBAr
	c31JaJYnpTFmMmKYBPINXT5Mr0R5HXjuMGl9YgkZ4X/ln1k2NEYQ4YkK0onTt6JM5Kosbl3KP8/r9
	HfjaFJBW6msWq/Tw55X1AC2vqiEaqgL6JMfAXOIdIoHbaIquBbpl4LbEdtSfzvau3E/uZdDq0ULN7
	58lILhf+A5pZRq5f/7fIGXQHzaMO5YWvkbYc7ka/6/kY4gCftkeA9PBjT7RSneMRX6al1mXpBgV9Q
	DtEXnNFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugIqP-0000000DvsM-3o8Q;
	Mon, 28 Jul 2025 08:04:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugIe7-0000000DtiC-1Nuq
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 07:51:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 461691F750;
	Mon, 28 Jul 2025 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753689100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=TNEWAEhfmMvgidAn9FpW3SEOjxUDcLGCMI1W7iTWwg9RqwshklTRNldiiej4NDQL1aJ7t1
	Dvz9YLc59jH/5ZJtUWK2433gdzsH3upXNLH4njHM8QfzjRHhpDiHRtI7PSiNnmm8Ji9sRi
	wzpuDc2cNBzbd9ib4eHBnvFXuZXTECM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753689100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=YMr/2LGD88wN7gz09qZLyeD25hyo+JQ5s/mUnMUv7ObjFQhHZqJKAE4pW1RkUa3Wdx79X/
	5oIHVZHsa0QsjCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753689100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=TNEWAEhfmMvgidAn9FpW3SEOjxUDcLGCMI1W7iTWwg9RqwshklTRNldiiej4NDQL1aJ7t1
	Dvz9YLc59jH/5ZJtUWK2433gdzsH3upXNLH4njHM8QfzjRHhpDiHRtI7PSiNnmm8Ji9sRi
	wzpuDc2cNBzbd9ib4eHBnvFXuZXTECM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753689100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=YMr/2LGD88wN7gz09qZLyeD25hyo+JQ5s/mUnMUv7ObjFQhHZqJKAE4pW1RkUa3Wdx79X/
	5oIHVZHsa0QsjCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36C021368A;
	Mon, 28 Jul 2025 07:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CSJjDAwsh2i5DgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 28 Jul 2025 07:51:40 +0000
Date: Mon, 28 Jul 2025 09:51:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@kernel.org>, Randy Jennings <randyj@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <630f5d07-ad66-4b1a-b13d-670012e5fab9@flourine.local>
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_005143_521503_F22D807C 
X-CRM114-Status: GOOD (  10.39  )
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

On Fri, Jul 25, 2025 at 01:50:05PM -0700, Mohamed Khalfella wrote:
> During nvme target initialization discovery subsystem is initialized
> before "nvmet" debugfs directory is created. This results in discovery
> subsystem debugfs directory to be created in debugfs root directory.
> 
> nvmet_init() ->
>   nvmet_init_discovery() ->
>     nvmet_subsys_alloc() ->
>       nvmet_debugfs_subsys_setup()
> 
> In other words, the codepath above is exeucted before nvmet_debugfs is
> created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
> instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
> Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
> 
> Fixes: 649fd41420a8 ("nvmet: add debugfs support")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

