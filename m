Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DFC369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 06:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c07lb+O2RrNYtXRjvdK15QLO5xAGy7hLNxPxDwDrnQg=; b=hiLbua1zXaZv0+v7psX/MSqKVm
	kqabMCXTuQwvsP3Iu22DGZ6vdbIF60TrFtFUiqX0DJapVTft0tBD4IChMTxv3JmE1t2AtR5WcLlLX
	nQLu7uB4VvapCphJ1m1Sqg10718KGInl6a+C5AdTIRQqc+2Lsb1oCN+3bFCnv7a/FfAqFyDoRvn8U
	P7kF9b8ndj4Oi1NimbIYlVNLWHUIQfIEtz7q+QMRxu82V49UkE//aIPMxyDmAQsV84KAfezjWDhmY
	yvAErZ5O4zK6RGEMX9T6P9Yo4ZK856TqkexwOrf1dqyZJq3BqiiwRDul5A6WUO9qeh9Di5ZK7tS/0
	SGdIyoRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA1BJ-0000000BtnF-289b;
	Wed, 30 Apr 2025 06:44:33 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA1A2-0000000Btey-2AYm
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 06:43:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A8451F7BF;
	Wed, 30 Apr 2025 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745995393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c07lb+O2RrNYtXRjvdK15QLO5xAGy7hLNxPxDwDrnQg=;
	b=nKrS5p1UI2IcgjJDkMdXYB9MPnZaUQRPcO+n6hy0/2sFRTMpzSyi1B36y8eNKJVGc0x+R4
	zJqYrxVvHMTItgLJBZY93ABtaCK8RvLsuBNheC3STArVpYKpmUUVOJWSb0D1+MQjoExAHc
	Quq0uJLjqc9FN+S/SYdwEFrUjiWPmpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745995393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c07lb+O2RrNYtXRjvdK15QLO5xAGy7hLNxPxDwDrnQg=;
	b=RDnnzwI95B7WovRCDRFUsuozJrbba4W472Ph++Eft2hZ70evljDIMgYRioTDmg52CNFTVp
	QlduB0C6GYpEasCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745995393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c07lb+O2RrNYtXRjvdK15QLO5xAGy7hLNxPxDwDrnQg=;
	b=nKrS5p1UI2IcgjJDkMdXYB9MPnZaUQRPcO+n6hy0/2sFRTMpzSyi1B36y8eNKJVGc0x+R4
	zJqYrxVvHMTItgLJBZY93ABtaCK8RvLsuBNheC3STArVpYKpmUUVOJWSb0D1+MQjoExAHc
	Quq0uJLjqc9FN+S/SYdwEFrUjiWPmpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745995393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c07lb+O2RrNYtXRjvdK15QLO5xAGy7hLNxPxDwDrnQg=;
	b=RDnnzwI95B7WovRCDRFUsuozJrbba4W472Ph++Eft2hZ70evljDIMgYRioTDmg52CNFTVp
	QlduB0C6GYpEasCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E288713A25;
	Wed, 30 Apr 2025 06:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D8DsNIDGEWiebgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 30 Apr 2025 06:43:12 +0000
Date: Wed, 30 Apr 2025 08:43:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Hannes Reinecke <hare@suse.de>, 
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
 <aBEW4W40ZelIXfs2@kbusch-mbp>
 <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
 <aBEdkUky_-bfgISv@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEdkUky_-bfgISv@kbusch-mbp>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_234314_704252_FD4CB90F 
X-CRM114-Status: GOOD (  29.72  )
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

On Tue, Apr 29, 2025 at 11:42:25AM -0700, Keith Busch wrote:
> On Tue, Apr 29, 2025 at 11:23:25AM -0700, Guenter Roeck wrote:
> > On 4/29/25 11:13, Keith Busch wrote:
> > > On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
> > > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > > index b502ac07483b..d3c4eacf607f 100644
> > > > > --- a/drivers/nvme/host/core.c
> > > > > +++ b/drivers/nvme/host/core.c
> > > > > @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
> > > > >                   msleep(100);
> > > > >           }
> > > > > 
> > > > > -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > > > > +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> > > > > +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > > > >                   return;
> > > > > 
> > > > >           nvme_unquiesce_io_queues(ctrl);
> > > > 
> > > > I would rather have a separate state for firmware activation.
> > > > (Ab-)using the 'RESETTING' state here has direct implications
> > > > with the error handler, as for the error handler 'RESETTING'
> > > > means that the error handler has been scheduled.
> > > > Which is not true for firmware activation.
> > > 
> > > But the point of having firmware activation set the state to RESETTING
> > > was to fence off error handling from trying to schedule a real reset.
> > > The fw activation work schedules its own recovery if it times out, but
> > > we don't want any other recovery action or user requested resets to
> > > proceed while an activation is still pending.
> > 
> > Not only that; there are various checks against NVME_CTRL_RESETTING
> > sprinkled through the code. What is the impact of introducing a new state
> > without handling all those checks ?
> 
> Good point, bad things will happen if these checks are not updated to
> know about the new state. For example, nvme-pci will attempt aborting IO
> or disabling the controller on a timeout instead of restarting the timer
> as desired.
> 
> Can we just revert the commit that prevented the RESETTING -> LIVE
> transtion for now?

Unfortunately, it will break the FC error handling again(*). The
simplest fix is right above, add the transition from RESETTING to
CONNECTING and then to LIVE, IMO.

(*) ee59e3820ca9 ("nvme-fc: do not ignore connectivity loss during connecting")
    f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity loss")

