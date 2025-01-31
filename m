Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8902FC0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YkmclvEd+NPcLHMTM1fnvRHy8VVE/STQCjvVBsWmSps=; b=larmWnzYMHUUYP/BkX18S6bWTx
	ZXPpjH8a+9zfknj/vpopPKoY8Pukd2uYrYfEcyimD69xWA52R0+xc6ub+ul10N7GsI0ZS2edmsq3V
	IMZXbqRZbqW0o2i0puZXWfLiCd6EjLJBr1GkGXpfc2Kk7QFp6+7dSJbzzSY/H6Q1StXVThHxZOzS2
	r10K3K/iSDYi/VXvy+Q7OON3NxWNyDcHTsX3Tvy6Tcm4C7KNPOtZl1VqVPdmv96DFDGTbtZ3378rN
	bAXi5fkRL3zfVe2NQUDbFwSWa2XpcV2XJerIIfQbY45vm62GM+F/ifsp0rajP5La8wCfqbv0ol6xR
	u8twWG5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmge-0000000AEzt-1wyS;
	Fri, 31 Jan 2025 08:47:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmfp-0000000AEvw-0pR1
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:46:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD0282116C;
	Fri, 31 Jan 2025 08:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738313206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkmclvEd+NPcLHMTM1fnvRHy8VVE/STQCjvVBsWmSps=;
	b=b+iwE5oOQnvpjWxeeGP4MU8c78NwiNAycoab+sG4+SdmWFiNJJtecvhgTFgM+naSgq/9dd
	nbMwkJ83rsNrEE8NeIGz9VO0VU+crqMicQ3vqHRXtJt+Dragsj4amk00+FsYnRaPkCxlp/
	nqAoU4KuhKbirt5NRajPE92COa56dcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738313206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkmclvEd+NPcLHMTM1fnvRHy8VVE/STQCjvVBsWmSps=;
	b=NGfGL+0kN1OZIm/RNkRLGVK9LIg5n21zVgJwpKU0OGV6uyVSYVk/9Q+ILZ40E9ifHtCTh9
	iGfDK+yUQo3vuZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738313206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkmclvEd+NPcLHMTM1fnvRHy8VVE/STQCjvVBsWmSps=;
	b=b+iwE5oOQnvpjWxeeGP4MU8c78NwiNAycoab+sG4+SdmWFiNJJtecvhgTFgM+naSgq/9dd
	nbMwkJ83rsNrEE8NeIGz9VO0VU+crqMicQ3vqHRXtJt+Dragsj4amk00+FsYnRaPkCxlp/
	nqAoU4KuhKbirt5NRajPE92COa56dcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738313206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkmclvEd+NPcLHMTM1fnvRHy8VVE/STQCjvVBsWmSps=;
	b=NGfGL+0kN1OZIm/RNkRLGVK9LIg5n21zVgJwpKU0OGV6uyVSYVk/9Q+ILZ40E9ifHtCTh9
	iGfDK+yUQo3vuZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93101364B;
	Fri, 31 Jan 2025 08:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Du9SLPaNnGeNEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 31 Jan 2025 08:46:46 +0000
Date: Fri, 31 Jan 2025 09:46:46 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
Message-ID: <04ca03dd-d240-458a-a049-8cf0ea7f9dcc@flourine.local>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
 <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_004649_381187_8E6AF800 
X-CRM114-Status: GOOD (  20.49  )
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

On Fri, Jan 31, 2025 at 10:13:47AM +0200, Sagi Grimberg wrote:
> On 28/01/2025 18:34, Daniel Wagner wrote:
> > blk_mq_tagset_count_completed_reqs returns the number of completed
> > requests. The only user of this function is
> > blk_mq_tagset_wait_completed_request which wants to know how many
> > request are not yet completed. Thus return the number of in flight
> > requests and terminate the wait loop when there is no inflight request.
> > 
> > Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")
> 
> Can you please describe what this patch is fixing? i.e. what is the observed
> bug?
> It is not clear (to me) from the patch.

I have to double check again my reasoning after reading Nilay's reply.

The problem I am running into with my wip tp4129 patchset is that
requests are pending an newly introduce requeue_list queue and never get
canceled because these requests stay in the COMPLETE state at the
moment. This blocked the shutdown path.

I don't think this problem exists right now in upstream but I was under
the impression that the check is incorrect here. I mean the
only request we need to cancel are the ones which are not idle, no?

Anyway, I'll have to go back and do some more homework.

