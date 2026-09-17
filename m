Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2392AC982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuXnzhBzhb3IWTiyBtB85GensRs436L4fKELHVpGBRU=; b=JbempRcUUefIxfrMhJ0eGCIH0J
	VXTU4qfU0hBzSd+IF5YA6TpGm5D1HmSAvEJPfBgMO8WgRhay7S0cYWvAJhvzsLPYI9jaD5EM8U+LM
	/e8Nu23XxSnzcesRe1NHyvw+jL5MOyP7IpVDhRx4rPJYfu+8bkFN7/xNIs0v2wtLq9xh9fMkv63Ph
	cUiWxF2miWo8dM87cSVT7HBs9Mmo3k37IQt9pvM1SVkVPwMyJRKSMZFVpmnCOD4qhmKfNBD8+xZT/
	O6nPpKciMjdI4tw30bOhz+f0heqNK2VRAgmTkpqnGJ9FA8szwmE+vd0JlzNoYMvMy/XOE1azXNt4K
	xzm2QwDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x776s-0000000AqWJ-3EWb;
	Thu, 17 Sep 2026 08:04:46 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x776p-0000000AqVk-2m0a
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:04:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BC622001F;
	Thu, 17 Sep 2026 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789632276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuXnzhBzhb3IWTiyBtB85GensRs436L4fKELHVpGBRU=;
	b=D3k2gczOrG6jtPQQkYO0Rv89tHjQAMvy4I0To3KMe4MnonEEZMm/kC9s1FpA0JHDw0BxXb
	vVn8X31HVXhsamkzF4PiN/yLOb8guPcMgwzN9vzuwlwxqIO2RRNpG/CqKHgFbu5AagAEqR
	80s0hoMP2JaNKYsKppjnGut4ZdsOeWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789632276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuXnzhBzhb3IWTiyBtB85GensRs436L4fKELHVpGBRU=;
	b=4ZiAKFmrOp+uDSjVcYaDXwLGrEgALZS9Um1WYFKuC+LBwZZS6zBVM5UXMPRkkppmvD0K6e
	JqT3lrOwBD250vBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789632272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuXnzhBzhb3IWTiyBtB85GensRs436L4fKELHVpGBRU=;
	b=W213pMpa28BpvcXtTpL86rgHxSLfVlFvyQovps70HDW+50Dfg+c5o2vK/k5bLNQPrHrqqF
	Kw1/5BcbLL8wpeUMbuH4W3EJXeooBJopLNVv2Mez14IjL7L1zZQq+tlXEHsmt8f1UpavLh
	4Ha53Tt5CsFx+6adPQrF34V/3vQ4QBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789632272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuXnzhBzhb3IWTiyBtB85GensRs436L4fKELHVpGBRU=;
	b=770c6TsPO/CGUHSBAYgqCX4xkxE6lG7C07miRIzFsMwsGRp0wQrtlmTwphHAW1DwKTbz5b
	4HrN5nBcJ4KyYHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02C0A1374A;
	Thu, 17 Sep 2026 08:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCPhMw+fq2rRSQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 17 Sep 2026 08:04:32 +0000
Date: Thu, 17 Sep 2026 10:04:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, John Garry <john.g.garry@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs
Message-ID: <0d2ddba3-7acd-4acd-a67e-ef05a248ea11@flourine.local>
References: <20260916114254.335277-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916114254.335277-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_010443_852725_3BF0D65D 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Sep 16, 2026 at 07:42:54PM +0800, Guixin Liu wrote:
> Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
> implementation") added a second uuid_copy() of args->hostid near the end
> of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
> uuid_copy") removed the original copy that sat before
> nvmet_ctrl_init_pr() instead of the new one.
> 
> Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
> per-controller per-namespace reservation refs while the uuid_copy()
> from the connect data runs later, after the controller is published.
> The ctrl is allocated with kzalloc(), so every pc_ref created on this
> path stores the nil UUID.
> 
> pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
> matches it against the preempted registrant's hostid to kill and drain
> the victim's in-flight I/O for Preempt and Abort.  The match can never
> hit with the nil UUID, so whenever a namespace with reservations
> enabled exists before a host connects, which includes every reconnect,
> Preempt and Abort silently degrades into a plain Preempt: the
> preempting host sees success while the victim's in-flight I/O is still
> in the air.
> 
> Copy the hostid where the rest of the connect data is consumed, before
> the controller is published and before nvmet_ctrl_init_pr() takes its
> snapshot.
> 
> Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Besides fixing this bug, it makes more sense to pair the hostid memcpy
with the hostnqn one.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

