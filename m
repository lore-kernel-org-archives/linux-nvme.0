Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF92FC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=; b=vcHYFeuCjalflD/YEC2rGj6E5i
	iCqUdGSfPbtKm/VnP+lWl6r6bdohx1Emh65NpboBNZ/V3BOuH+Pzd60NPyAUxmFO1xXAcKJMmIec9
	0DYPqtUSNg36tT/80BZniR5aVHqvpO1LejyOCjsaL6S/QJ5rcmxFXpTHpIQULKMH/mxJx9j38k2Wm
	e5xa1keXhCWIXwRdOvrxlsVc06vOrQgolIxBzuyOloBI7sz1NEt3M4ozsBwpngEoOH76w4uU0tUqo
	HnOph6chtqDLAggtvoD9qmHZOLsAEv40Und24tItkxlsza39EMqIQ+QmRf1YgpNWUqzzSaGtOKjN2
	PopcpGdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLdtB-0000000Fq01-1y9S;
	Mon, 24 Jun 2024 07:13:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLdt6-0000000Fpww-1yuH
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 07:13:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 111491F7B8;
	Mon, 24 Jun 2024 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719213193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=XuPjne2PyEnx/QmjaV2VH09wnLKuzfWRUZDgbILUusIx8RpTMRM3Oy0gEL+cJORAdZY4cT
	B30BsktTIx0plmkuGKGBpqpT8K43oyl3V9ayV7X31XiaRLjD8R9GQLJ8BzMbOfFcWvEWPQ
	+oWlfpePxbm/2TKv5joEhtmReGFTslw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719213193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=IQUWtLYKVJ88s/pwDMVLWk8DekxzAQGD1ArYT24w84Hqdu/YKuZGNh5m8bTqxHa0iamvX/
	it1sVNVoYXZ5mkBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719213193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=XuPjne2PyEnx/QmjaV2VH09wnLKuzfWRUZDgbILUusIx8RpTMRM3Oy0gEL+cJORAdZY4cT
	B30BsktTIx0plmkuGKGBpqpT8K43oyl3V9ayV7X31XiaRLjD8R9GQLJ8BzMbOfFcWvEWPQ
	+oWlfpePxbm/2TKv5joEhtmReGFTslw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719213193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=IQUWtLYKVJ88s/pwDMVLWk8DekxzAQGD1ArYT24w84Hqdu/YKuZGNh5m8bTqxHa0iamvX/
	it1sVNVoYXZ5mkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCAD13ACD;
	Mon, 24 Jun 2024 07:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YGmEIUceWZReAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 24 Jun 2024 07:13:09 +0000
Date: Mon, 24 Jun 2024 09:13:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622051156.GA11303@lst.de>
X-Spamd-Result: default: False [-2.26 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_001316_686864_4266068A 
X-CRM114-Status: GOOD (  14.40  )
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

On Sat, Jun 22, 2024 at 07:11:57AM GMT, Christoph Hellwig wrote:
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 2b461129d1fa..fe751d704e99 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -16,6 +16,7 @@ enum hk_type {
> >  	HK_TYPE_WQ,
> >  	HK_TYPE_MANAGED_IRQ,
> >  	HK_TYPE_KTHREAD,
> > +	HK_TYPE_IO_QUEUE,
> >  	HK_TYPE_MAX
> >  };
> 
> It might be a good time to write comments explaining these types?

Sure, will do.

Do you think we should introduce a new type or just use the existing
managed_irq for this?

