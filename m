Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81358C369B5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KdtTOVJISIQ4Cl0YjSVZGn4hwArezCxw33TLu9csL+U=; b=bGfY4uyE7BT6tlypJaF3X+Q6MR
	Qoda8RU9aedY8cJg4l6r8EaLCFxkB2G7cmANXBuR+tJQKZaKSRNW+dy871NkfwG/llDDhgf9RSZMH
	qCIsR1C/RmgqIbQOvx+/v8O05ZuDktmwcsmkQ3hb40YisBXoW5D5AJtBY62453J6iRtTNmVRcp4Az
	Ay1xOt4gCZDi2zlnBseE2ZcJAAzP0rC0a1bONZEonSVBZKfrklnRUiM0WYu7QzWqceaOF42b8zMVn
	dl9EGEPtaTBToqVuyLIF4Cgpgpoj8jwJ8+ihpmK4KO0NMdJksegPZwVHk/i4s/pnqXw/ZTwsXPpv9
	63xYhc3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fW7-00000005lb9-3RQu;
	Tue, 15 Apr 2025 12:35:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fEc-00000005hAq-4Bui
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 12:17:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F4E521164;
	Tue, 15 Apr 2025 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744719469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdtTOVJISIQ4Cl0YjSVZGn4hwArezCxw33TLu9csL+U=;
	b=pcZtyyv1IkEmlJ6MZ92KESNTPSpgaagpjsggIEpvJwdQ0MFRAOP9O/LVXUaAAIbOlAOPjT
	k9Eoiq4vuq9rUUE/GvwrRPo04BqPdv8VU+X0R7xhOL7O6JnFJvMPPMHcmDU/oFTofpflHC
	oL0QVETVSz612gKzFivEZtQTP8zkWqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744719469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdtTOVJISIQ4Cl0YjSVZGn4hwArezCxw33TLu9csL+U=;
	b=MsQu9UbcRAdvyYphHi+IkI3Y/9IRx6UIHs53TdaRQAavSlRUaIk/VrSelGBMJdpjjpVzfi
	PdqBDorfMnm38xDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744719469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdtTOVJISIQ4Cl0YjSVZGn4hwArezCxw33TLu9csL+U=;
	b=pcZtyyv1IkEmlJ6MZ92KESNTPSpgaagpjsggIEpvJwdQ0MFRAOP9O/LVXUaAAIbOlAOPjT
	k9Eoiq4vuq9rUUE/GvwrRPo04BqPdv8VU+X0R7xhOL7O6JnFJvMPPMHcmDU/oFTofpflHC
	oL0QVETVSz612gKzFivEZtQTP8zkWqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744719469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdtTOVJISIQ4Cl0YjSVZGn4hwArezCxw33TLu9csL+U=;
	b=MsQu9UbcRAdvyYphHi+IkI3Y/9IRx6UIHs53TdaRQAavSlRUaIk/VrSelGBMJdpjjpVzfi
	PdqBDorfMnm38xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21972139A1;
	Tue, 15 Apr 2025 12:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/NLB21O/melDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:17:49 +0000
Date: Tue, 15 Apr 2025 14:17:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410085137.GE1868505-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_051751_181731_6D005AE1 
X-CRM114-Status: GOOD (  20.21  )
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

On Thu, Apr 10, 2025 at 01:51:37AM -0700, Mohamed Khalfella wrote:
> > +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> > +{
> > +	unsigned long delay;
> > +
> > +	if (ctrl->cqt)
> > +		delay = msecs_to_jiffies(ctrl->cqt);
> > +	else
> > +		delay = ctrl->kato * HZ;
> 
> I thought that delay = m * ctrl->kato + ctrl->cqt
> where m = ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> no?

The failover schedule delay is the additional amount of time we have to
wait for the target to cleanup (CQT). If the CTQ is not valid I thought
the spec said to wait for a KATO. Possible I got that wrong.

The factor 3 or 2 is relavant for the timeout value for the KATO command
we schedule. The failover schedule timeout is ontop of the command
timeout value.

> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
> >  void nvme_failover_req(struct request *req)
> >  {
> >  	struct nvme_ns *ns = req->q->queuedata;
> > +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> >  	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
> >  	unsigned long flags;
> >  	struct bio *bio;
> > +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> >  
> >  	nvme_mpath_clear_current_path(ns);
> >  
> > @@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
> >  	blk_steal_bios(&ns->head->requeue_list, req);
> >  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> >  
> > -	nvme_req(req)->status = 0;
> > -	nvme_end_req(req);
> > -	kblockd_schedule_work(&ns->head->requeue_work);
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> > +	spin_unlock_irqrestore(&ctrl->lock, flags);
> 
> I see this is the only place where held requests are added to
> failover_list.
> 
> - Will this hold admin requests in failover_list?

Yes.

> - What about requests that do not go through nvme_failover_req(), like
>   passthrough requests, do we not want to hold these requests until it
>   is safe for them to be retried?

Pasthrough commands should fail immediately. Userland is in charge here,
not the kernel. At least this what should happen here.

> - In case of controller reset or delete if nvme_disable_ctrl()
>   successfully disables the controller, then we do not want to add
>   canceled requests to failover_list, right? Does this implementation
>   consider this case?

Not sure. I've tested a few things but I am pretty sure this RFC is far
from being complete.

