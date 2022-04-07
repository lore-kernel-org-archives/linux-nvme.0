Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAB4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5MpFe7kvwzNP/nwXmgQurcpHqIPecTlCvJ/0HKR0o4=; b=OFi0vgfP9NkzIqTkDgCB4LImFj
	IRbPFztlrkZgyhud11P7uXF0+yV8cRfMdk5Jm/BjdCaDbEvE3zJHC3cjZhXuYNrPTCHUVm1xKMUzj
	acxOvtWDIJKHXjzBB+k7YGfeZlyobTuATC7PcZs2UnMsO3hbQuQKHPj7hNTpOo14IRIqVX2HVPfMG
	9CbKalHuYQ3/g+2yb3WTYu248OmyaWuqM1+HvnbZw0Dpm9gxg3Pk9zHi3aUycP99wHescMm+EG81q
	MYabIW+PwgWel1b1UWMISvEXBruUEg2T7WYjJ3keP9TzNW6F+IlUCf7dS2MPLqMDEkvw6GgdSVFoL
	LNGYiDyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSKx-00CBgI-WB; Thu, 07 Apr 2022 13:38:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSKu-00CBeZ-PJ
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:38:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2D27212B7;
 Thu,  7 Apr 2022 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649338686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5MpFe7kvwzNP/nwXmgQurcpHqIPecTlCvJ/0HKR0o4=;
 b=DHGZkF5snlVTVbbJSlALkVFgR9zuTYnwQ1JRPdWZpoNXmZD6GCz1Mci+88NuALkqg1J3T9
 HMx3NEtBzEgZhv7rj4EJELDekbqQHbeqTuywj8CybfKu5vi2PgsvCC4XOWw2znnxxDi4mQ
 cjgcs+yk11Xsl+ALifLOhMcw6HTdWhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649338686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5MpFe7kvwzNP/nwXmgQurcpHqIPecTlCvJ/0HKR0o4=;
 b=PtVVKqhLfHzlof2hdXAl0fPc3tX/an7FkYaE6oh4Ta6m8CVSZkvs2s9csxUF5gu+ggOwsH
 1v20BEIEZLK80/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B7113A66;
 Thu,  7 Apr 2022 13:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gRBDND7pTmLYOAAAMHmgww
 (envelope-from <dwagner@suse.de>); Thu, 07 Apr 2022 13:38:06 +0000
Date: Thu, 7 Apr 2022 15:38:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Message-ID: <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_063809_047653_BDBD5B49 
X-CRM114-Status: GOOD (  26.73  )
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

On Thu, Apr 07, 2022 at 04:04:44PM +0300, Sagi Grimberg wrote:
>
> > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > index 10fc45d95b86..f714d7ad38c0 100644
> > > > --- a/drivers/nvme/host/tcp.c
> > > > +++ b/drivers/nvme/host/tcp.c
> > > > @@ -1145,9 +1145,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
> > > >         if (ret == -EAGAIN) {
> > > >                 ret = 0;
> > > >         } else if (ret < 0) {
> > > > +		struct request *rq = blk_mq_rq_from_pdu(queue->request);
> > > >                 dev_err(queue->ctrl->ctrl.device,
> > > >                         "failed to send request %d\n", ret);
> > > > -		if (ret != -EPIPE && ret != -ECONNRESET)
> > > > +		if ((ret != -EPIPE && ret != -ECONNRESET) ||
> > > > +		    rq->cmd_flags & REQ_FAILFAST_DRIVER)
> > >
> > > I'm wandering if this will race with nvme_cancel_admin_tagset which
> > > can also complete the command... The whole assumption is that the
> > > cancel iterator will be running as the socket is shutdown by the peer
> > > and error_recovery was triggered.
> > >
> > > I think these shouldn't race because we shutdown the queue (and flush
> > > the io_work) and only then cancel. But I've seen races of that
> > > sort in the past...
> >
> > This particular request is issued by nvme_shutdown_ctrl() so we know
> > exactly where we are. But this might not be the case for any other
> > REQ_FAILFAST_DRIVER flagged request. So this might introduce the race
> > you are pointing out.
> >
> > The option is see is what Margin suggested in
> >
> > http://lists.infradead.org/pipermail/linux-nvme/2021-September/027867.html
>
> Don't know if I like the state check. Why this does not apply in a ctrl
> reset?

Understood. Would something like this work

      struct request *rq = blk_mq_rq_from_pdu(queue->request);
      bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);

      dev_err(queue->ctrl->ctrl.device,
              "failed to send request %d\n", ret);
      if ((ret != -EPIPE && ret != -ECONNRESET) ||
          (!queue_ready && rq->cmd_flags & REQ_FAILFAST_DRIVER))
              nvme_tcp_fail_request(queue->request);

?

