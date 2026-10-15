Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14272CC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WB/B2ugoNFP1dpwe4GDp3tkiqdKw621FuvrbzLouDRE=; b=GG9WQgC47vMp7GBAwUBQP7o3xq
	VTX1KE/MUTYmTEZMUhW8ONmBkqHlATGK0cH2CvM2YKYMirMCy/PXryoD7oGY6xmM7kPDu7XLsiBQQ
	WqqFfCJ3+rlmgHv1dw1kOWKvln31Ieggq91mqBsVyErHhaL5cpK+DVi5el2PSueFhMLGRuzgg6KTO
	nVcZDgcwVlTPFjLmbX4MukfJRwls32tKryC9KKnBytUnLVgUECQ+TQDgOZ6PIha3366Zo+0ECANip
	vuc51byxC8hRfkQ0Qim0mEs9lwBArh/aT9UN5H6lDFlVdz5U2ICtznSBKPQ5wNtXh5RlaHzTsLKwp
	z26SKqyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHL2P-00000000Biq-48oM;
	Thu, 15 Oct 2026 12:58:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHL2K-00000000Bgi-1qnK
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 12:58:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98EE41FF48;
	Thu, 15 Oct 2026 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792069096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB/B2ugoNFP1dpwe4GDp3tkiqdKw621FuvrbzLouDRE=;
	b=eSUcEurDDSngNxBaZh3xHICSQX1j8usVTwaXX/4hkU1Rjk4DcsX0cx+kxW5dK3MWnOfeBC
	4SSl9zXVfI4dkAtTr0u1lZlaMbYsYg19El9hgogpjYxTFH0qNJsK9Uwv1Y5bZes35/BihS
	aUmXOvvWlN3iYQjMJKua0v4iWINn6oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792069096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB/B2ugoNFP1dpwe4GDp3tkiqdKw621FuvrbzLouDRE=;
	b=0l+1dFyZLrKW6GxbYWJ+X7WINbdIRg3pfBxifgWU6w0HbfC4BYN5VK6AWfYfXV7Pcp1ER1
	EVlhnIpkoWU50oDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792069096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB/B2ugoNFP1dpwe4GDp3tkiqdKw621FuvrbzLouDRE=;
	b=eSUcEurDDSngNxBaZh3xHICSQX1j8usVTwaXX/4hkU1Rjk4DcsX0cx+kxW5dK3MWnOfeBC
	4SSl9zXVfI4dkAtTr0u1lZlaMbYsYg19El9hgogpjYxTFH0qNJsK9Uwv1Y5bZes35/BihS
	aUmXOvvWlN3iYQjMJKua0v4iWINn6oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792069096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB/B2ugoNFP1dpwe4GDp3tkiqdKw621FuvrbzLouDRE=;
	b=0l+1dFyZLrKW6GxbYWJ+X7WINbdIRg3pfBxifgWU6w0HbfC4BYN5VK6AWfYfXV7Pcp1ER1
	EVlhnIpkoWU50oDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF8113782;
	Thu, 15 Oct 2026 12:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v+DWHeXN0GryNAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 15 Oct 2026 12:58:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/18] nvmet: Rapid Path Failure Recovery set
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
In-Reply-To: <20260920182936.2317916-2-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-2-mkhalfella@purestorage.com>
Date: Thu, 15 Oct 2026 14:58:04 +0200
Message-Id: <179206908475.1897932.6636243827945983905.b4-review@b4>
X-Mailer: b4 0.16.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_055820_793284_BB70D52F 
X-CRM114-Status: GOOD (  10.68  )
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

>   maximum number of in-progress controller reset operations. CCRL is
>   hardcoded to 4 as recommended by TP8028.

The spec says at least 4. 

> @@ -1695,6 +1699,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>  	}
>  	ctrl->cntlid = ret;
>  
> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> +		ctrl->ciu = get_random_u8() ? : 1;
> +		ctrl->cirn = get_random_u64();

While get_random_u64 is very unlikely to return 0, it still possible, thus

   get_random_u64() ? : 1;

would be the safe choice. Besides this nitpicking:

Reviewed-by: Daniel Wagner <dwagner@suse.de>

-- 
Daniel Wagner <wagi@kernel.org>

