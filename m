Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB675C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7Xzew5rWDRlRGMpqB8Bq8Wd/JLPFE7C8SCawJlQk7U=; b=q8hzLIHUY2dcrBs/dpVINM/SAK
	NXn2w0c682lB1iPEfO0gV56GsUZqNwD/lt7DTTjkkU8Ck8oc9I4ArMChZLFrcY0Tf0ctP11loksE1
	Wnyb2Af0BUt1uCp9qq1VSKW22OQ2uAF8I6Ni2YK/JzlRXhjqA3EE6VscxkwUsrUYO25lvIU81mdhd
	FHJqTUXN75iS8xjymlMwYXGRyPaPnxQUOiHWzIvY+HXTyDUUj3Rp+4zwaLKDcAFe3su0c74mS8xDj
	qBEOYl8h8xgmFsXSfjpsV50ubrjPNIFzG+/aTPY4UzzpnWdOj0SVwAbyg5sNhDopQuLcc1BT597sh
	cCBu1L+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB6t-00000008Pf7-1Cl3;
	Mon, 13 Jul 2026 07:29:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB6q-00000008Pel-0G40
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:29:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E820077428;
	Mon, 13 Jul 2026 07:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783927786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7Xzew5rWDRlRGMpqB8Bq8Wd/JLPFE7C8SCawJlQk7U=;
	b=K7eyYUxUknkBwQC0L08GWrDp7lYnWJB1Q54UO6p2995QW8Uvo7rGSk09NrC8+XAM3lKELs
	gedGfUoShiRPwV9QoVpLhPxZYzswqdCQGGMdeaTQWlwFaPl5qc0kgNE/HP774QKgGHX1Ex
	8IYGI0H2lr2MBWCN2dHVopxLmC1bcGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783927786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7Xzew5rWDRlRGMpqB8Bq8Wd/JLPFE7C8SCawJlQk7U=;
	b=SqRP+t5rvWpfn7clFb8/rfp709hx+RxwmopTuWPNnWKB/1/MoMGVrJ3MUWU7T9KdBoL5zP
	xHCOJjfvVCU4fABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783927784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7Xzew5rWDRlRGMpqB8Bq8Wd/JLPFE7C8SCawJlQk7U=;
	b=QE7SM4Lw0+2I0n9NigIFw1hYHCUR0h9cU+hpJbcRE7J5sI1/A7jQ41cQUGrJ/uxPNXlHMq
	zrAc3GWPERIqUXRDpoh7HzNMIvPtSzHMPZstWtHaNBNcoJ9ljrAa699lT8sEtjQuDz3wUy
	M93b7NWffr71/xq3gk3K1JZu/XCIKrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783927784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7Xzew5rWDRlRGMpqB8Bq8Wd/JLPFE7C8SCawJlQk7U=;
	b=nPkQ6BA4aoXU9cI4cB7hXjUsxSk9Z7ylvymj2pn8DMuCZ1K+OGiQPKibEi/ve95AspS65D
	cFFn5Rzg9mCrjZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F793779AE;
	Mon, 13 Jul 2026 07:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ly7WIeiTVGpwaQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:29:44 +0000
Message-ID: <da754227-87f9-44b1-926b-9b3b6ead6e19@suse.de>
Date: Mon, 13 Jul 2026 09:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/16] nvme-fc: Refactor IO error recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Randy Jennings
 <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-13-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,purestorage.com:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_002948_271359_6CA912CC 
X-CRM114-Status: GOOD (  14.03  )
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

On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> Added new nvme_fc_start_ioerr_recovery() to trigger error recovery
> instead of directly queueing ctrl->ioerr_work. nvme_fc_error_recovery()
> now called only from ctrl->ioerr_work has been updated to not depend on
> nvme_reset_ctrl() to handle error recovery. nvme_fc_error_recovery()
> effectively resets the controller and attempts reconnection if needed.
> This makes nvme-fc ioerr handling similar to other fabric transports.
> 
> Update nvme_fc_timeout() to not abort timed out IOs. IOs aborted from
> nvme_fc_timeout() are not accounted for in ctrl->iocnt and this causes
> nvme_fc_delete_association() not to wait for them. Instead of aborting
> IOs nvme_fc_timeout() calls nvme_fc_start_ioerr_recovery() to start IO
> error recovery. Since error recovery runs in ctrl->ioerr_work this
> change fixes the issue reported in the link below.
> 
> Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 119 +++++++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 53 deletions(-)
> 
This is hard to read. Please split it several parst, one with
open-coding nvme_reset_work(), one with adding 
nvme_fc_start_ioerr_recovery((), and another one with the rest.
If that makes sense to you...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

