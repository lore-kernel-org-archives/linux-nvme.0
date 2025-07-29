Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6644C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=; b=T1w4qNQRgyZJ1NccV5vpYsS0UU
	/fhUplsGGtVCdsBat2kDVzWM0lx/7jzR1e8C4+mWRsemgETacd295l25b5pNue+A426EbplxnxPQ9
	MJergsH5542PYu7Iq03rD7evT+6r+yzDHTBOE7PKa6nLjmclPL4YvHhvItpUaXd3I+Uex/WfcbjQ6
	IhQg/tmKuCjhaJhm0MrARuhXPp0dgHrqCWLrDGGii31iarzJc2DsbQx1fOYpJWB4lb0cBhPaicW/p
	s3RYdT0WYQ9cioB3ffqpyjpDCkd2gQ+2Cztsl5yBC1arJNo0Y/bXrEMf720HTMRzzeAvEOkxwz8iR
	kNtwurew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugepP-0000000G7yJ-3dxJ;
	Tue, 29 Jul 2025 07:32:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugelZ-0000000G7Zj-1ntt
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:28:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 286461F798;
	Tue, 29 Jul 2025 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753774130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=kXydCDBD36oI7KLwmHsAq2MNzHiSN/2UBRC39MDcgstsTEEUTxDVPRh0u3ttaKG+awh7hc
	6MGQMFr4Z1tbpJn7LRNYHvB68Wp0KtgGa4fT7F2SYL2/Abc1QByUubLqFyFUvv12Ck3qkP
	Yh5IvsPIzlTvI1S08mBOPiLUF4Okplk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753774130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=n3tsvFqVmGNsjFXEOtzB8UPN6J+POWmS72WBRd0sy8curMSugyKp0Q76CeY9GWY+/gBVJI
	qQSVL8vSl1iFhXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753774130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=kXydCDBD36oI7KLwmHsAq2MNzHiSN/2UBRC39MDcgstsTEEUTxDVPRh0u3ttaKG+awh7hc
	6MGQMFr4Z1tbpJn7LRNYHvB68Wp0KtgGa4fT7F2SYL2/Abc1QByUubLqFyFUvv12Ck3qkP
	Yh5IvsPIzlTvI1S08mBOPiLUF4Okplk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753774130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=n3tsvFqVmGNsjFXEOtzB8UPN6J+POWmS72WBRd0sy8curMSugyKp0Q76CeY9GWY+/gBVJI
	qQSVL8vSl1iFhXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EF3113A73;
	Tue, 29 Jul 2025 07:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zN0mJDF4iGjXJgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 07:28:49 +0000
Message-ID: <2d3a9693-cbaa-46b8-9c66-d4aaf04429b4@suse.de>
Date: Tue, 29 Jul 2025 09:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_002853_752376_CFFE7EF8 
X-CRM114-Status: GOOD (  10.76  )
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

On 7/25/25 22:50, Mohamed Khalfella wrote:
> During nvme target initialization discovery subsystem is initialized
> before "nvmet" debugfs directory is created. This results in discovery
> subsystem debugfs directory to be created in debugfs root directory.
> 
> nvmet_init() ->
>    nvmet_init_discovery() ->
>      nvmet_subsys_alloc() ->
>        nvmet_debugfs_subsys_setup()
> 
> In other words, the codepath above is exeucted before nvmet_debugfs is
> created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
> instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
> Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
> 
> Fixes: 649fd41420a8 ("nvmet: add debugfs support")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

