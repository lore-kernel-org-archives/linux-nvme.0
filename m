Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D4BC282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=; b=KSR2o7+wTFbVp6d2H9FVd+bcA2
	d9xwN/vH7ooaazRr8zLHs7y6xv+u88SzVyBuzsy5YAw4difTXhHKmPoh4Ycc3r9lnHLj4MDi0gZ8O
	44RtC5sm9IAYb5YFk3eJIqBVR12VllwgeLOukfOQkyruvC2WFAZxLKrEjKXjS7Xv+/tRFOpQbnjDu
	OHnNJ3EQblGR87OVoNOc6rVvx5BcLJwPf7ZbydLNk+PSggcn6ur27ofS/oAMIqBVKdSuiEsorvmJc
	9/jrEBRt+4AY5I3MbtHxWuVPSDywXadOEzzhCijwtrdw4aGQv/o0OAbQPzgM8PVF9Eq1BuancTrj6
	XsrmPW7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq7VA-0000000AUBA-0A3u;
	Thu, 06 Mar 2025 09:26:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq7V8-0000000AUAu-1hv8
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 09:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=; b=T8CfixDhY6/J495TNF3ud3nCw1
	5UpnvvWWEuwOVstf7hDuh5XqMWDaFhrjnIlLrAMs8YpBSUCj1EQ22d1qyWg3P2mC8Dtps7URDLHtG
	jY4qFZ0FyFFwl/TXw8TPKlCeOAGK0xbxt+j6NQZmkF3e33i7t+UkdF1yE4v+lzxc5UK0/Gd93pXkv
	yJ5m6bgIkmU+zZqsqY0n0huI+VFePI0aXDMbpEqqxjXY/zVWdQvPr28tJtN7EJr9oTvSRJf7AIZaW
	wbshFsMIAGuZh3J7XrF4li8/jEv6Th6LCMFwIADflFUfztx6JzX2N2kdIP/7agCkkUWZKP8aHgP8C
	R6NsQv+Q==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq7V5-0000000794M-1af6
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 09:26:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4FAA1F745;
	Thu,  6 Mar 2025 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741253200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=mjSVyQA6FOwZgDMpjD4SI7GZqPE77sEYlIHudIRXMKNDkBqg0LUgdx8zehU2Pry1BscZNB
	bQrY8+YIlYWZg8Yvi1avRyA6dmeInADozmKIP2WUG91Cw5yh1v6Txf9EzQI8sY4GIa98T5
	juhtUDid+/uCqrXJTNQEXI/sx/QPD1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741253200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=8f8smvWgkoTuPmtAgYoWj5qhYkeTba6dXkXVYR7uU6hNBsEEZKEuy+rNzHYiZAyXa3jFFs
	fPOSDxRVtlpWQ8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741253200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=mjSVyQA6FOwZgDMpjD4SI7GZqPE77sEYlIHudIRXMKNDkBqg0LUgdx8zehU2Pry1BscZNB
	bQrY8+YIlYWZg8Yvi1avRyA6dmeInADozmKIP2WUG91Cw5yh1v6Txf9EzQI8sY4GIa98T5
	juhtUDid+/uCqrXJTNQEXI/sx/QPD1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741253200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8S+uobPBadM/V3a3IdY2KN51KYzwx5o/vP9axxxsHo=;
	b=8f8smvWgkoTuPmtAgYoWj5qhYkeTba6dXkXVYR7uU6hNBsEEZKEuy+rNzHYiZAyXa3jFFs
	fPOSDxRVtlpWQ8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92FB313A61;
	Thu,  6 Mar 2025 09:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igkLI1BqyWfrFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 06 Mar 2025 09:26:40 +0000
Date: Thu, 6 Mar 2025 10:26:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
 <20250305141740.GC18065@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141740.GC18065@lst.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_092643_456598_71A3A9FD 
X-CRM114-Status: GOOD (  16.59  )
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

On Wed, Mar 05, 2025 at 03:17:40PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 26, 2025 at 07:45:54PM +0100, Daniel Wagner wrote:
> > +static void
> > +fcloop_lport_free(struct kref *ref)
> > +{
> > +	struct fcloop_lport *lport =
> > +		container_of(ref, struct fcloop_lport, ref);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fcloop_lock, flags);
> > +	list_del(&lport->lport_list);
> > +	spin_unlock_irqrestore(&fcloop_lock, flags);
> > +
> > +	kfree(lport);
> 
> Maybe it's just me, but I find the kref a really horrible pattern over
> usig a simple refcount_t.

There was already some kref usage in the fc code, that's why I started
to use it. But I agree there is not much to be gained from the kref
wrappers. I'll replace them.

> Otherwise adding proper refcounting looks fine.

BTW, I found a bunch more places which need to do proper ref counting. I
have now a version which works pretty good. Though there is one
case which gives me an UAF:

  setup target
  setup host
  connect
  loop
    remove target
    wait for host connecting state
    add target
    wait for host live state

When fcloop has no in flight commands and the target is removed, fcloop
will unregister the localport now. But the nvme-fc driver just assumes
that the port is always there and just sends down new commands
independend of the port status:

nvme_fc_start_fcp_op()
{
[...]

	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
					&ctrl->rport->remoteport,
					queue->lldd_handle, &op->fcp_req);
[...]
}

There is nothing which updates the ctrl in nvme_fc_unregister_localport.
Not really sure what to do here. fcloop obviously is now behaving
differently to the hw drivers. But still, this looks very fragile that
there is no sort of synchronization between port unregistration and ctrl
state.

