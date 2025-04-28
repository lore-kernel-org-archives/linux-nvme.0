Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6D5C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hZqPYtXCkRxEndHYyiJGx+O/sbxzBssSioQwUSVCXi0=; b=3OaHDMPc1/b9V56YrjeeJAau90
	se4pFNx+nkkqJAXKLv1HNcO2Ltgi2PH41HCQq6LsLs/RZNl4QeSsp7zMXEq0l6amhwuc8S6fVzpP4
	uxziXUttBAlDeVVYqabfCdaoZ+fxuP13di4qlz0BbNDJ+IFdGOb+2749USeyhOsmsyurEQVpY0WqG
	n1C7vPzsE3BeJ8NjkGc84A1tHjCvtRzgHNA3lkCkuRUO9LTMGiFsS959RXYnJcrDWGFWxWXaUsRzH
	j3h0WMj4KKpvDSLO1hMgkrZXrzQdxvgp+eIMw6E/Dcr46dhmOnLs0wF4MpE5EsbTD4nyCNePSbkyk
	nmNbOtNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Ows-00000006YGk-0tlY;
	Mon, 28 Apr 2025 13:55:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Ogg-00000006Vft-2OFX
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 13:38:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0A941F390;
	Mon, 28 Apr 2025 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745847501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZqPYtXCkRxEndHYyiJGx+O/sbxzBssSioQwUSVCXi0=;
	b=nBWpqPsFpnKzMRjb1xGMtp9ff2aeMA43CFNKyOtjzHNSJ3G7NcR78/IzKrdVRiZB1XHF7/
	xOrN2uw1TbGFcQreyRqPY3pcO9ETxXjmHsR9nwlAacRnbvUZNN4QS8zmgepC3hlFwAHE1l
	QtuL+y0ATaVypwVL/qa/xCWknDhBG+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745847501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZqPYtXCkRxEndHYyiJGx+O/sbxzBssSioQwUSVCXi0=;
	b=/2MbBGy2OHraJNlsAwYKzmxMs0aDZZGbnxXGC27L+hgOfhTSjI3AWsr4+LzNiwM/0SSh+L
	fydL3DdFkCqETQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745847500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZqPYtXCkRxEndHYyiJGx+O/sbxzBssSioQwUSVCXi0=;
	b=2GwpZkKGWecGhI9ljUPiT2S5tie7WdhJEIjvteOjfDY9VlP/ioT/n7kdzwdMM+NoK6ySD0
	qSfvIGID4rHTB7mMy5QdSMh2TvF/GyyuiU1fSpy8QfLtdo/JPOIXkokKTKflo6b5gTYFv3
	xDuXwhsdo8DNoAJXLRaPJ960GYmueMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745847500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZqPYtXCkRxEndHYyiJGx+O/sbxzBssSioQwUSVCXi0=;
	b=kF1+givy5Oictk7T/CltH9TiBcT4VFL3j/7FVeh5vDH+9KPKVyDyz0IMdKNsThwLXCBSc8
	UbQAE5HZ9SzFq9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E203B1336F;
	Mon, 28 Apr 2025 13:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PzI8NsyED2jiZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 28 Apr 2025 13:38:20 +0000
Date: Mon, 28 Apr 2025 15:38:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: check for valid request when polling for
 completions
Message-ID: <e2565f05-6385-43f6-991b-d5523aa86a53@flourine.local>
References: <20240902130728.1999-1-hare@kernel.org>
 <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
 <93dbb39f-3c5f-4631-aabf-1f4222781b06@suse.de>
 <Ztcn04fAPHM5BeAy@kbusch-mbp>
 <ZtdsgaDzdk9rLStb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtdsgaDzdk9rLStb@kbusch-mbp>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_063822_753109_4889ADCA 
X-CRM114-Status: GOOD (  23.91  )
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

Hi Keith,

On Tue, Sep 03, 2024 at 02:07:29PM -0600, Keith Busch wrote:
> On Tue, Sep 03, 2024 at 09:14:27AM -0600, Keith Busch wrote:
> > On Tue, Sep 03, 2024 at 08:25:08AM +0200, Hannes Reinecke wrote:
> > > On 9/2/24 19:04, Sagi Grimberg wrote:
> > > > On 02/09/2024 16:07, Hannes Reinecke wrote:
> > > > > When polling for completions from the timeout handler we traverse
> > > > > over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
> > > > > Unfortunately that function will always return a request, even if
> > > > > that request is already completed.
> > > > > So we need to check if the command is still in flight before
> > > > > attempting to complete it.
> > 
> > So the very same command was completed in some other context? We've
> > disabled the queue's interrupt here, there should be no other context
> > that can concurrently complete it. The timeout poll check is supposed to
> > check only unseen cqes, not "all" of them. Is disable_irq() not a
> > sufficient barrier for accessing the cq head or something?
> 
> Ooo, I think I see a problem. Does your device have more than one
> namespace? I think we need to lock this queue for that condition because
> the timeout work executes per-namespace, and we're not locking that
> today. If you do have a muliti-namespace controller, does the below fix
> your observation? 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6cd9395ba9ec3..2c73ccd21afe3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1109,9 +1109,11 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
>  
>  	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
>  
> +	spin_lock(&nvmeq->cq_poll_lock);
>  	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
>  	nvme_poll_cq(nvmeq, NULL);
>  	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> +	spin_unlock(&nvmeq->cq_poll_lock);
>  }

Ah sorry, this one got lost in my todo list.

We got positive feedback from our customer. This indeed fixes the
problem. Are you going to send out a proper patch, or do you want me to
do it?

Thanks,
Daniel

