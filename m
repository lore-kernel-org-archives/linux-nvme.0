Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE29606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a7H8ynbB;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HonvjFGs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Cv3I4C+m;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j2QAxsOO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UNm33GYp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzfZZar3ayacu4O6UVeNjA9z3dc7q8klSgmjrIJ7nmE=; b=a7H8ynbBvP6uK2TBwjKcJnrXkf
	BT5EENJyFciN0qqZ1C0SgLffJkA/6lhYaS7f+wxDkJiZZp3X67pRu9w7mUJ09b5FQc1vMFstRtBfG
	Z2cdN/IyM4vYUP8NT63AawfbjPG/oeoisjAYKOWI8NvbthZWiePMscDqQfNsa4dIV5VFGyF+HTOlL
	YiAcLVysrKYpQiUSUvUm4IkODoJAHZoQFw8HdIxSE0RjvBAm8r9zg9ZA2+0seAarEQsPqZbVmCYgc
	wtFK+RDAJKF3XNgPLktOfZ1Fkyu5yrc4Pzxdwfs8GNejg6XsJ3dQJlpb6oID6VlbPLaqFDvstZmK+
	36lRStDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqkH-000000083HX-1hmf;
	Mon, 19 Oct 2026 17:01:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqkF-000000083Gt-0tJG
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 17:01:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74B2621C7F;
	Mon, 19 Oct 2026 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792429313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzfZZar3ayacu4O6UVeNjA9z3dc7q8klSgmjrIJ7nmE=;
	b=HonvjFGslhVMw8Q8tmPlqKdVhl9YszJ8GXGrisdJ+dZEXVGuqDyV76/8VRF9DWlCq0X9QW
	0mMnyVaMTCP+6BqiNKvO/d/WuTMXEX5ibQbJmuZk/b3G+H3tu2TZi75T1R7z2T83nR2gKb
	Glv6K2POiAvvRnh7CRNSUrXHgvIXG64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792429313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzfZZar3ayacu4O6UVeNjA9z3dc7q8klSgmjrIJ7nmE=;
	b=Cv3I4C+mhqjoiTo6hGo0ETyeck8GJX2p+tfreUt0gGzjrXCa1KUpT7xQDbwpHC1dUeyyt1
	0s3KPvLgSdVCMTAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792429311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzfZZar3ayacu4O6UVeNjA9z3dc7q8klSgmjrIJ7nmE=;
	b=j2QAxsOOchV1y1f3F8TR/W2p5DmXjzz0TLHDX5xafv1BsU4G5aQa0b3kSxO1N9hA9/a9Vk
	PjHiKW999h1VgPc6DTA4ogVZW60Hnh5+wFh/X5MRiqJ9hu7NyqGaMVx86wTtoQ413t1IVF
	aNsmRegQMEP5d29Id2PZRDVZ/8DBncA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792429311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzfZZar3ayacu4O6UVeNjA9z3dc7q8klSgmjrIJ7nmE=;
	b=UNm33GYpKDqprw2RIVEI/ZZrY7/saUCOiLJQVbFp38eXVANcIeEFrlKrdFggKsFG3WlynZ
	Y3rCp0MM9sTbdfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 375E0136CC;
	Mon, 19 Oct 2026 17:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nMHaA/9M1mqWDAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 17:01:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
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
In-Reply-To: <20260920182936.2317916-8-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
Date: Mon, 19 Oct 2026 19:01:38 +0200
Message-Id: <179242929827.3619480.8550407233438315193.b4-review@b4>
X-Mailer: b4 0.16.0
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-CRM114-CacheID: sfid-20261019_100155_720262_C4EB98C7 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -542,6 +542,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>  	static const char *const state_name[] = {
>  		[NVME_CTRL_NEW]		= "new",
>  		[NVME_CTRL_LIVE]	= "live",
> +		[NVME_CTRL_FENCING]	= "fencing",
> +		[NVME_CTRL_FENCED]	= "fenced",
>  		[NVME_CTRL_RESETTING]	= "resetting",
>  		[NVME_CTRL_CONNECTING]	= "connecting",
>  		[NVME_CTRL_DELETING]	= "deleting",

The ABI documentation needs to be updated.

-- 
Daniel Wagner <wagi@kernel.org>

