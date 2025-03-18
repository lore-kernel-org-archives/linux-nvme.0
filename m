Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B347C28B2F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=; b=x5kY92NAXQeEh52dmWrxbCXjiD
	flsZ8SLjEH4GtjpwSzlU2L8TJfp5Z2KDL55dV4ZILRtnOaPev5Fgr/PVM9Krezhdx+CZLLpjNNgFG
	5K+jfP4vndoSUyG2FnySXHOj1p1ycmslvnxW1/F6o7Xio1y05WG2WNoLXlnXdXWwfjn0tPsBDcL7n
	d8+ZLp54Vy5rL2w6cIOxtLQ9zmEk4kPtmk8C7Z2/P2h2MiM7/sRlg7GblaWE1jQPraw5YUB5w0QOi
	U1Ykch6B4JSof16uRoPJLo73LvAQsxSD1jwAgqOuTP8xgLZqFY1B3ytLJQg4dtdn/xOk9AKlSZBxC
	NJp9o7UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXUg-000000066eE-2pzA;
	Tue, 18 Mar 2025 14:00:34 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXQ6-000000065oU-3Yds
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 13:55:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B0AC21F11;
	Tue, 18 Mar 2025 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=qXI9QbUPZxiat7LCaEnc9mT83UzPp2cFJwTuOxQb4GmZ4i8Z3euU/M1wdpjACe0uJ8WBks
	hGqsbpRs+cxClHiuZAQ396EjEz0VndZlI0bKPpf/j98ArurLP3PBsTOiuTQWrrceJ0SLDm
	82gnR+aaTXiPBaQsuVGBgZHGKX1VUBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=yQzwZE6/Llf6ZXu+tPMdSK2leVliEhwnXC5m0xe8cDmhueyDXhIf4QObOJSAk5YPDBoUwM
	x4KhjspAK18Vd5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=qXI9QbUPZxiat7LCaEnc9mT83UzPp2cFJwTuOxQb4GmZ4i8Z3euU/M1wdpjACe0uJ8WBks
	hGqsbpRs+cxClHiuZAQ396EjEz0VndZlI0bKPpf/j98ArurLP3PBsTOiuTQWrrceJ0SLDm
	82gnR+aaTXiPBaQsuVGBgZHGKX1VUBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbbQJCb0W94lwPm3G3yIcFUzjFf7cmr8Xph5NtAbbg8=;
	b=yQzwZE6/Llf6ZXu+tPMdSK2leVliEhwnXC5m0xe8cDmhueyDXhIf4QObOJSAk5YPDBoUwM
	x4KhjspAK18Vd5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0DF13A43;
	Tue, 18 Mar 2025 13:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SR7nBWV72Wf5fAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:55:49 +0000
Date: Tue, 18 Mar 2025 14:55:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
Message-ID: <dbef52cf-a112-4fbd-b1ad-c9eebc1f4787@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
 <e5c91532-6f35-4124-b32d-a47aa4ce972b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c91532-6f35-4124-b32d-a47aa4ce972b@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_065551_036652_A2498EC2 
X-CRM114-Status: GOOD (  14.20  )
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

On Tue, Mar 18, 2025 at 12:15:04PM +0100, Hannes Reinecke wrote:
> >   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
> >   {
> >   	struct fcloop_rport *rport = remoteport->private;
> > +	bool delete_port = true;
> >   	unsigned long flags;
> >   	flush_work(&rport->ls_work);
> >   	spin_lock_irqsave(&fcloop_lock, flags);
> > +	if (test_and_set_bit(PORT_DELETE, &rport->flags))
> > +		delete_port = false;
> >   	rport->nport->rport = NULL;
> >   	spin_unlock_irqrestore(&fcloop_lock, flags);
> Can't you just check for a NULL rport->nport->rport pointer
> and do away with the PORT_DELETE flag?

Unfortunately, nport->rport is also set to NULL in __unlink_remote_port
and __unlink_target_port. If we would just update the pointer here, it
would be possible.

I played a bit around when to clear the nport->rport pointer but it
didn't work. There were always some UAFs or NULL pointer accesses. With
the flags I was able to get it fixed. I am not insisting on this
solution, just trying to explain why I choosed it.

