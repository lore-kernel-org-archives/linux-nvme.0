Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693F5C369B5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mCgPHzml+cG+IHXOvQdsMqGvOHFy+l1cnwHKlceKlk=; b=23ovWZ+MZwEbPnytPrKHu4LLrI
	qzW8t9lxF4fnWvf46hxZ0ONQUuKiZRu3D+S6WcIQ3CSHoaNBGNS/a832J2g7Il+sC9NKUHbVgykIL
	FokeijSwjZ7uDhOuqhuENAPa1hV12Xp63aNskReBIFkMF5UCYwpf/9gPdC+eGnt15P5CTSNEHNuu5
	BID3ZWFUibQgnUjn1JoBKhwRkTWQT6YfHQ+puZ0iLPVwGZZ//su2sFTwfDdA8XI0dlR5Q2tAgeYor
	lNpJNnhA+zDysNeieoqpTDlyHdYrkiCJoyPqbbD+MsFOqeqqle78FAQHYzjso+zAUr7O6jLb6Eote
	leO4iiGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fW5-00000005lYJ-2LA1;
	Tue, 15 Apr 2025 12:35:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4f2b-00000005ete-2JSD
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 12:05:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D15321162;
	Tue, 15 Apr 2025 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mCgPHzml+cG+IHXOvQdsMqGvOHFy+l1cnwHKlceKlk=;
	b=IWwljR+FdRRMMsl5HQ8hTIoG82tvyTjw+O33B87a2DVk4URPTZDlvxbF7+7yFQDeMo02is
	0M/LcQe6ADqCZXAhA5yPQHdan3zSC/6FLwt9vNEYBcJUVhqhP5BgF7i/wQLHcI9u0rBKc+
	mzNxl8tLJQcwoyg1e249tzxI+560wzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mCgPHzml+cG+IHXOvQdsMqGvOHFy+l1cnwHKlceKlk=;
	b=cewaL1RJ39hOmDG1DVqh5M0tSuB3iQfj/f3XcVZy5Qvtwe2Sp4Y/gJDXbizh15cLJ7H8tH
	LS7Wg1V2X5/C9OAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IWwljR+F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cewaL1RJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mCgPHzml+cG+IHXOvQdsMqGvOHFy+l1cnwHKlceKlk=;
	b=IWwljR+FdRRMMsl5HQ8hTIoG82tvyTjw+O33B87a2DVk4URPTZDlvxbF7+7yFQDeMo02is
	0M/LcQe6ADqCZXAhA5yPQHdan3zSC/6FLwt9vNEYBcJUVhqhP5BgF7i/wQLHcI9u0rBKc+
	mzNxl8tLJQcwoyg1e249tzxI+560wzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mCgPHzml+cG+IHXOvQdsMqGvOHFy+l1cnwHKlceKlk=;
	b=cewaL1RJ39hOmDG1DVqh5M0tSuB3iQfj/f3XcVZy5Qvtwe2Sp4Y/gJDXbizh15cLJ7H8tH
	LS7Wg1V2X5/C9OAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A333139A1;
	Tue, 15 Apr 2025 12:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EwKMAYRL/mfSCwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:05:24 +0000
Date: Tue, 15 Apr 2025 14:05:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
	Mohamed Khalfella <mkhalfella@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <97fd8c08-e5bb-4b4b-9ec0-0eea9af1da1d@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <7cb33ebe-2ff6-4c3a-82f0-c4ed547e8a25@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb33ebe-2ff6-4c3a-82f0-c4ed547e8a25@linux.ibm.com>
X-Rspamd-Queue-Id: 1D15321162
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_050525_734998_1C5D04C8 
X-CRM114-Status: UNSURE (   8.90  )
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

On Tue, Apr 01, 2025 at 07:02:11PM +0530, Nilay Shroff wrote:
 > -	kblockd_schedule_work(&ns->head->requeue_work);
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> > +	spin_unlock_irqrestore(&ctrl->lock, flags);
> > +
> 
> Why do we need to wait until error_recovery for scheduling failover?

This is where the delay is added to the processing. The failed requests
(timeout) are held back by the delay here and after the wait the are
immediately fall over

> Can't we schedule failover as soon as we get path error? Also can't
> we avoid failover_list? 

Then we have exactly what we have now. An failed request is rescheduled
to the next path immediately.

