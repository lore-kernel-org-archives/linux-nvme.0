Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4F2C7115B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgrAYXu3t1poRpFMLmL/wBTBNhxmNsfPIEus0KyVEyQ=; b=DVzK1UqEfd/QIJRsWiTtY9jd/C
	e9BbcDfAj3BWG6K/q8Ffewy6YP9P5cJJ1etpG/LMyJMOeKg/WQkW8J4gJYyTu0Dy6JPmMrpNJaI4T
	FCVPyvSEcvHlU7Wcxlm+bwLVjg5udQkXvD6SJyXJafSlBooZEsB6NaXroqvBgFoETnXZ99HrIm738
	x6i516v9UuI1XeXA90gmxKK4Lp9a4Fe+P9xNmOt5kcdj7Aay7RWH4oue9Dt5fnpiUtR7RH8ntsdFd
	HJIy0KX/Hpe7tMWAs5kibXmg6EB8LOqbmqgNvYo6+js2dj1HkL4TO7CcE92qRue0i2R1IFmLJ1yUo
	XK4xrZ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhTI-0000000Arts-3Fs9;
	Thu, 26 Jun 2025 07:56:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhLN-0000000AqtT-1mfp
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 07:48:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 689131F38D;
	Thu, 26 Jun 2025 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750924102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrAYXu3t1poRpFMLmL/wBTBNhxmNsfPIEus0KyVEyQ=;
	b=OFQmr6V8ax2zw7wakyhJM6XtHKt+opV7aCisJShxDvlIvZBm18JVy1sMCA88o533O8Gx87
	v1dQYyaivoSIGYQ/YDS/cJpeAtKWg2uB8PviDeHLl2EJlLTZMnn7UYSYColr2W4W5BroGU
	54fHkS+otzxA54i3FJqBGdZREdMzgmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750924102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrAYXu3t1poRpFMLmL/wBTBNhxmNsfPIEus0KyVEyQ=;
	b=5zdmAX8H43Ou8jNtoTjj7o2/Uf14Wwtn2zaS2YEDfI5Q+0tp82VIU5O/zMAPTw7X0L3wsi
	hDqLcliHIBinVXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750924102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrAYXu3t1poRpFMLmL/wBTBNhxmNsfPIEus0KyVEyQ=;
	b=OFQmr6V8ax2zw7wakyhJM6XtHKt+opV7aCisJShxDvlIvZBm18JVy1sMCA88o533O8Gx87
	v1dQYyaivoSIGYQ/YDS/cJpeAtKWg2uB8PviDeHLl2EJlLTZMnn7UYSYColr2W4W5BroGU
	54fHkS+otzxA54i3FJqBGdZREdMzgmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750924102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrAYXu3t1poRpFMLmL/wBTBNhxmNsfPIEus0KyVEyQ=;
	b=5zdmAX8H43Ou8jNtoTjj7o2/Uf14Wwtn2zaS2YEDfI5Q+0tp82VIU5O/zMAPTw7X0L3wsi
	hDqLcliHIBinVXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44A7013188;
	Thu, 26 Jun 2025 07:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YO9bDkb7XGgmMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 26 Jun 2025 07:48:22 +0000
Date: Thu, 26 Jun 2025 09:48:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com, hch@lst.de, 
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, axboe@kernel.dk, 
	shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: Re: [PATCHv3] nvme: correctly account for namespace head reference
 counter
Message-ID: <c2233513-6736-4c2c-a757-96f205286f18@flourine.local>
References: <20250626051935.801205-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626051935.801205-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_004825_609104_70052870 
X-CRM114-Status: GOOD (  12.97  )
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

On Thu, Jun 26, 2025 at 10:49:19AM +0530, Nilay Shroff wrote:
> This change prevents stale kobject entries from lingering in sysfs and
> eliminates the module reload failures observed just after running
> nvme/058.
> 
> [1] https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
> 
> Reported-by: yi.zhang@redhat.com
> Closes: https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
> Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Tested-by: yi.zhang@redhat.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

>  		list_del_init(&ns->head->entry);
> +		/*
> +		 * If multipath is not configured, we still create a namespace
> +		 * head (nshead), but head->disk is not initialized in that case.
> +		 * As a result, only a single reference to nshead is held (via
> +		 * kref_init()) when it is created. Therefore, ensure that we
> +		 * do not release the reference to nshead twice if head->disk
> +		 * is not present.
> +		 */
> +		if (ns->head->disk)
> +			last_path = true;

just nitpicking: what about renaming the variable to something like
'multipath' which matches more with the comment.

