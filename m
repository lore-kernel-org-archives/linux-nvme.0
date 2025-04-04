Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6ADC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qbKrD0h+S0pJh/V1i4JkUn/lVc2CMhJrcitjKBTUiw=; b=TTaEMfQ0Ad+haUGuRWQvGAnAvA
	/HRNHJ8M4bj0ozUQ620veCriAQBEUSJZ5r/KbNxOnLbbU3CGTJ8vrOerl1SV9OkeRY1gaDS0SECQe
	cY8riWz2pt21kf5LKchG60dFb8183bdKLd5eDI5nD6MwDKGQ1QhGrVgyEU9rgA0acd5xbVR3dpcya
	PjkxFkI4y3AMFVB1/2DccOVpePRNPV13fgtNltW+i+AUinbM63uf6wd5yTUjiITtfEAULIGsjDPQR
	6QYTY3Vjwia1KoqgezebfZ2ljZTIpz7EVkztTKl4aIvWlBpxEloFs98E1A4Zdcq6tnk1gw3RP1Z0/
	WTjesbtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gYu-0000000BjMt-3riB;
	Fri, 04 Apr 2025 12:54:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gYc-0000000BjIR-0pg0
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 12:54:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A215211C8;
	Fri,  4 Apr 2025 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743771240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qbKrD0h+S0pJh/V1i4JkUn/lVc2CMhJrcitjKBTUiw=;
	b=mpHfzesVONj8GHap3OQH/01AVAmhXxRXyWIyGO1xYtdPRexIU2g9NnZyiN7rDZDrU/iWms
	YzzitzESBwk+AEGbty8B0tSdKRYU7U4Gqp5tR6OO/KWKR7FMx+rWMaNbobyoXOZO4jcJT/
	9EarQ9zFJ46D3L7lf6NsLoOkR7bu4kA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743771240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qbKrD0h+S0pJh/V1i4JkUn/lVc2CMhJrcitjKBTUiw=;
	b=UuGB+zpXixPX6SbQsrbINqUbfSvydyqgGp95Apo1tecmyuEhy4UyC4oDywRDsFTaZslUm5
	Pa4Qg4AH3Dd0e/BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743771240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qbKrD0h+S0pJh/V1i4JkUn/lVc2CMhJrcitjKBTUiw=;
	b=mpHfzesVONj8GHap3OQH/01AVAmhXxRXyWIyGO1xYtdPRexIU2g9NnZyiN7rDZDrU/iWms
	YzzitzESBwk+AEGbty8B0tSdKRYU7U4Gqp5tR6OO/KWKR7FMx+rWMaNbobyoXOZO4jcJT/
	9EarQ9zFJ46D3L7lf6NsLoOkR7bu4kA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743771240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qbKrD0h+S0pJh/V1i4JkUn/lVc2CMhJrcitjKBTUiw=;
	b=UuGB+zpXixPX6SbQsrbINqUbfSvydyqgGp95Apo1tecmyuEhy4UyC4oDywRDsFTaZslUm5
	Pa4Qg4AH3Dd0e/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46B4F13691;
	Fri,  4 Apr 2025 12:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rrs5D2jW72coUQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Apr 2025 12:54:00 +0000
Date: Fri, 4 Apr 2025 14:53:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
Message-ID: <2a012944-576c-469e-965d-080d841d191d@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
 <4937c9f8-fbc7-46d4-a14f-262a0244f1f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4937c9f8-fbc7-46d4-a14f-262a0244f1f0@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_055402_536500_E0F706A0 
X-CRM114-Status: GOOD (  26.91  )
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

Hi James,

On Wed, Mar 19, 2025 at 03:47:20PM -0700, James Smart wrote:
> On 3/18/2025 3:40 AM, Daniel Wagner wrote:
> > fcloop depends on the host or the target to allocate the fcloop_lsreq
> > object. This means that the lifetime of the fcloop_lsreq is tied to
> > either the host or the target. Consequently, the host or the target must
> > cooperate during shutdown.
> > 
> > Unfortunately, this approach does not work well when the target forces a
> > shutdown, as there are dependencies that are difficult to resolve in a
> > clean way.
> 
> ok - although I'm guessing you'll trading one set of problems for
> another.

Yes, there is no free lunch :)

So far I was able to deal with new problems. I've run the updated series
over night with the nasty blktest case where the target is constantly
removed and added back without any problems.

> > @@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
> >   			struct nvme_fc_remote_port *remoteport,
> >   			struct nvmefc_ls_req *lsreq)
> >   {
> > -	struct fcloop_lsreq *tls_req = lsreq->private;
> >   	struct fcloop_rport *rport = remoteport->private;
> > +	struct fcloop_lsreq *tls_req;
> >   	int ret = 0;
> > +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> > +	if (!tls_req)
> > +		return -ENOMEM;
> >   	tls_req->lsreq = lsreq;
> >   	INIT_LIST_HEAD(&tls_req->ls_list);
> > @@ -387,19 +391,23 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
> >   	struct nvme_fc_remote_port *remoteport = tport->remoteport;
> >   	struct fcloop_rport *rport;
> > +
> > +	if (!remoteport) {
> > +		kfree(tls_req);
> > +		return -ECONNREFUSED;
> > +	}
> > +
> don't do this - this is not a path the lldd would generate.

Ok, after looking at it again, I think I don't need it.

> 
> >   	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
> >   		((lsreq->rsplen < lsrsp->rsplen) ?
> >   				lsreq->rsplen : lsrsp->rsplen));
> >   	lsrsp->done(lsrsp);
> 
> This done() call should always be made regardless of the remoteport
> presence.
> 
> instead, put the check here
> 
>         if (!remoteport) {
>             kfree(tls_req);
>             return 0;
>         }

Will do

> > @@ -475,18 +491,21 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
> >   	struct nvmet_fc_target_port *targetport = rport->targetport;
> >   	struct fcloop_tport *tport;
> > +	if (!targetport) {
> > +		kfree(tls_req);
> > +		return -ECONNREFUSED;
> > +	}
> > +
> 
> same here - don't do this - this is not a path the lldd would
> generate.

The early return and freeing tls_req is necessary. If the host doesn't
expect the error code, then fine. I'll remove it. The reason why we need
it is:

  The target port is gone. The target doesn't expect any response
  anymore and the ->done call is not valid because the resources have
  been freed by nvmet_fc_free_pending_reqs.

  We end up here from delete association exchange:
  nvmet_fc_xmt_disconnect_assoc sends a async request.

I am adding this as comment here.

Thanks for the review. Highly appreciated!
Daniel

