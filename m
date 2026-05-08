Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A530BCD3445
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYGdlSV3+j3Uk1YIvH6lUSHXzS7+7XRYrDMhQD6xtOw=; b=GLHYD5J6ASJHgh3h/N1sjG5BkJ
	5QjJQxW46OGL5GGnWU06DZ8l90NSZQyJGGhU8oMsnVZkfEciz4VRL8w2W27O4N9MySLr7YmYU7aIY
	A1UA7RK6zQBvI1sFFRTwLzBkoIefkE81Vf4XOurdDT53GkK55cxRhBtWH6dQm6p/Q8Eu34Fu91T/U
	+GhlvkkM9XKg7EaqVC0+q5roFzEcy5yuADl6SmUxp+pS5rYuJNRnP+IUXnzPntbdFsPiL+TR1hXrL
	iRqdVb7n1WYbXi0k1iK8+a8vtboIu1J0DbB/UOrOo0d7z0Hv9Yqxbcqpvn121lRNlcZCUncHNJ4Ir
	P5P76z9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOgK-000000074up-2Mg5;
	Fri, 08 May 2026 17:08:08 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOgH-000000074so-2jlP
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 17:08:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3E4E5C01C;
	Fri,  8 May 2026 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778260083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYGdlSV3+j3Uk1YIvH6lUSHXzS7+7XRYrDMhQD6xtOw=;
	b=zg5B0HcDJZNo6oLXkeRI5wCDKoGt+/4mqvboCVXhUz4Wxwbc7l/FJE+CniuBYs6MfMHL9H
	SHImpUmoOikFby/QPnL4p41SJpnY9XuTGU8o4NRMawnq1zAWm0xxnstjJCMugx4nte6h0l
	YEEQfUMHzaGrOsIs8Fxs2TSJSs8LtHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778260083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYGdlSV3+j3Uk1YIvH6lUSHXzS7+7XRYrDMhQD6xtOw=;
	b=9M1WF0uZ1daNcvgQfofj/i3+0Y7lkkKrW7qg3GjMZ2VxF/VO49wyH8E6bTQe7ja8djdmKU
	uKiJL6aIfgH3/1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778260083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYGdlSV3+j3Uk1YIvH6lUSHXzS7+7XRYrDMhQD6xtOw=;
	b=zg5B0HcDJZNo6oLXkeRI5wCDKoGt+/4mqvboCVXhUz4Wxwbc7l/FJE+CniuBYs6MfMHL9H
	SHImpUmoOikFby/QPnL4p41SJpnY9XuTGU8o4NRMawnq1zAWm0xxnstjJCMugx4nte6h0l
	YEEQfUMHzaGrOsIs8Fxs2TSJSs8LtHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778260083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYGdlSV3+j3Uk1YIvH6lUSHXzS7+7XRYrDMhQD6xtOw=;
	b=9M1WF0uZ1daNcvgQfofj/i3+0Y7lkkKrW7qg3GjMZ2VxF/VO49wyH8E6bTQe7ja8djdmKU
	uKiJL6aIfgH3/1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF88C593A7;
	Fri,  8 May 2026 17:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y3AYKXMY/mk3aQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 08 May 2026 17:08:03 +0000
Date: Fri, 8 May 2026 19:08:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 5/9] nvme: add sysfs attribute to change IO timeout
 per controller
Message-ID: <aad5649a-a8e7-468c-9bf3-6f3b07fd490c@flourine.local>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-6-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-6-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_100805_852588_1A2FA903 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, May 08, 2026 at 03:33:31PM +0200, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom
> I/O timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

I was wondering if namespaces would ever want different timeouts but
given that at this point it was always the default one and this change
scopes to controllers is properly enough.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

