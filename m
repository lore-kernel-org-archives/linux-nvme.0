Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D95CA1009
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=; b=mDgFnkctmdOfn6FQyXLI/Qoq+F
	FO8DTmJVTot5zS0q4RjdUK5ShjibZVwzctCF+32TZEY6AEjU7dK2U4AmVd75pD8FvKDCeVlI/lm0C
	EF4YYszXuqCOtMi+IMF3e0e9L0aQBFyZFZj3FF4Hs5YmpAdoYzxPD2WItzZW2wFg9jdliv59OlCTF
	rcxuaQij74sKcm8Ldy0h71SY1GxsVNXyMMnUkae2r5v4j29V6zd4r4qEIO7gbk/yzX7ubrE1vKa0s
	ryz1O84CDOLW6TNi+/osqqPmvNjt5/s/QGYzdeRtmAUPjetNygFmfzenQ9CvhNHPMBY/Wf7VIYAYp
	QhN8Zc4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utiyx-00000005dVH-1Zhl;
	Wed, 03 Sep 2025 08:36:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utiBY-00000005EKb-1vWL
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 07:45:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2E3B1F770;
	Wed,  3 Sep 2025 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756885538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=NJ0M6B6QvmyaxvYs4SpXavcchxSq0xwCKFZSIRsexxUh4yY2HHp/blxk/92tZ+ahc7BzJZ
	iquogK0OadI/HqfTfGTwfGZ0px6+e2VB2UxOKSLF1BHjHA4TWonWa0qoh+2gsycHyFjgS+
	GvoNv946wVl4GYNVmOka3UWI3pAGMl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756885538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=MhMJwGEgEme0OxeQNyV6Kq1MxiB2A9YMcF0ZAfFQfgKAAET1NIyznqG8F719cbtHol3hwG
	fms6nT8Qrg4PLXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756885538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=NJ0M6B6QvmyaxvYs4SpXavcchxSq0xwCKFZSIRsexxUh4yY2HHp/blxk/92tZ+ahc7BzJZ
	iquogK0OadI/HqfTfGTwfGZ0px6+e2VB2UxOKSLF1BHjHA4TWonWa0qoh+2gsycHyFjgS+
	GvoNv946wVl4GYNVmOka3UWI3pAGMl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756885538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=MhMJwGEgEme0OxeQNyV6Kq1MxiB2A9YMcF0ZAfFQfgKAAET1NIyznqG8F719cbtHol3hwG
	fms6nT8Qrg4PLXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFB6B13A31;
	Wed,  3 Sep 2025 07:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rElLLiLyt2jARQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 07:45:38 +0000
Date: Wed, 3 Sep 2025 09:45:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] nvme-fc: wait for initial connect attempt to
 finish
Message-ID: <58813044-1e6f-4267-bd10-70cc96348ecf@flourine.local>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-4-d69c87e63aee@kernel.org>
 <e34b522c-a492-4d86-9fbd-1a667e26d884@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34b522c-a492-4d86-9fbd-1a667e26d884@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_004540_648010_AC261CD0 
X-CRM114-Status: GOOD (  21.59  )
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

On Tue, Sep 02, 2025 at 11:13:41AM +0200, Hannes Reinecke wrote:
> > +	if (!opts->connect_async) {
> > +		enum nvme_ctrl_state state;
> > +
> > +		wait_for_completion(&ctrl->connect_completion);
> > +		state = nvme_ctrl_state(&ctrl->ctrl);
> > +		nvme_fc_ctrl_put(ctrl);
> > +
> > +		if (state != NVME_CTRL_LIVE) {
> > +			/* Cleanup is handled by the connect state machine */
> > +			pr_info("%s:%d ctrl state %d\n", __func__, __LINE__, state);
> > +			return ERR_PTR(-EIO);
> 
> We really should return the correct status (and not just -EIO).
> Guess we'll need to introduce another variable in struct nvme_fc_ctrl
> to hold the connect status...

(forgot to remove the debug prints)

But this is what the current return value is if something goes wrong.
The other transport map all status codes to -EIO or return the negative
error code from the function which fails. I'd rather not change this in
this series.

> >   	dev_info(ctrl->ctrl.device,
> >   		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
> >   		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
> > @@ -3895,6 +3928,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
> >   		dev_warn(ctrl->ctrl.device,
> >   			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
> >   			ctrl->cnum);
> > +		complete(&ctrl->connect_completion);
> >   		nvme_fc_ctrl_put(ctrl);
> >   	}
> >   	spin_unlock(&rport->lock);
> > 
> 
> And I wonder: what about the udev rules?
> Do they need to be modified?
> (IE: should we call udev with --connect-async or without?)

Without changing user space, the old behavior will be used. It's an
opt-in feature. I haven't finished the libnvme/nvme-cli changes but I
expect for getting all working the udev rules need to be modified as
well. My plan is to get the kernel bits finished up first before
tackling all the user bits in detail, e.g. also creating blktests for
this (in a way we have the first one which is nvme/041)

I'll post those changes here as it needs wider review for sure.

