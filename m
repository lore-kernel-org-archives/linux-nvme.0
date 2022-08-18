Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FBC32773
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Aug 2022 07:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZVU+i7wqZtZGHARIgN1b5fLwqXzj9+0KML0lVxOko7c=; b=vUIEW2LTemckSQFX1QGu3PESZw
	/APpYETlLrEogOftTSx0eiJ9TMT3GxxHV2L4S1Nbxpo0+9Uw2MLdX6SBeLey9AMMUsw6LW5erXf0f
	dkyq5ov1+6fOG1BYc+KUPqBVOdfyngx9lDswYhNQzM/wu9Adr+TtayCAi6hDF6ZvHobBOH500zHWQ
	Fg8AWMzGcSTZuOHUCufU90Qeh2FSMLn2R4HTjKWoORaUTVmGhpkidD5CJrjacG8NO0DXNGNNbL4+6
	6HmIC40+WVvfELdKDUqTnUZA1dy4SipT0d2KhsQ2YbkNbnYOKtEAih2XDaiNgzObJ2VjNS9LIOCFy
	UpsNb7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOZba-00HThI-1x; Thu, 18 Aug 2022 07:06:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOZbW-00HTZa-M9
	for linux-nvme@lists.infradead.org; Thu, 18 Aug 2022 07:06:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75A2E20AA3;
	Thu, 18 Aug 2022 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660806367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVU+i7wqZtZGHARIgN1b5fLwqXzj9+0KML0lVxOko7c=;
	b=JSMnt0wY993rc2Y4kRT3lfq/Q11YYIYRR327qnB6SYlntz0lnPI/YFHjOq4StfiPqWaeDz
	J4fWzv8N4FDui1E5/ttV5zeltCvXDYxWYsjXIamkxxrdcUnm8rBByPY1ggWaekwo3N7hNE
	s6AWtK4bzSoQdbKdh4/mU/pQUjlfBRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660806367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVU+i7wqZtZGHARIgN1b5fLwqXzj9+0KML0lVxOko7c=;
	b=1u2ayOS3tTDrrqjynJ/NUk9FPmTJ0zCTvy/01YLR6QuKcqtiOC7eAYUWjf485gZfb3suw2
	ZzijGW4cVgZx0JCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65BD9139B7;
	Thu, 18 Aug 2022 07:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NdBMGN/k/WK6RQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 18 Aug 2022 07:06:07 +0000
Date: Thu, 18 Aug 2022 09:06:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [RFC] nvme-tcp: Handle number of queue changes
Message-ID: <20220818070606.pgnpjv5hxooqyzqi@carbon>
References: <20220812142824.17766-1-dwagner@suse.de>
 <a32bb1f7-921e-1c88-716c-22340d4384d1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32bb1f7-921e-1c88-716c-22340d4384d1@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220818_000610_887057_8AFCC51D 
X-CRM114-Status: GOOD (  27.83  )
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

On Wed, Aug 17, 2022 at 02:28:12PM +0300, Sagi Grimberg wrote:
> 
> > On reconnect, the number of queues might have changed. In the case
> > where the old number of queues is lower than the new one, we try to
> > restart the new number of queues. At this point though, the tagset
> > is has not yet been updated and the operations fails.
> > 
> > Thus, on reconnect only start only the old number of queues, then update
> > the tag set and then start the rest of the newly added queues.
> 
> I agree this change is needed. The same issue exists in rdma and
> possibly others...

Ok, I'll take a look.

> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index e82dcfcda29b..177d2f5d9047 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1671,6 +1671,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
> >   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> >   	int ret;
> > +	if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags))
> > +		return 0;
> > +
> 
> How about we make concise calls to queue starts instead of
> making this re-entrant safe... Although this does follow
> the same model as pci...

I am also not too fond about this version here but I was at least sure
it works correctly. I see what I can do.

> > +	dev_info(nctrl->device, "nr_hw_queues %d queue_count %d qcnt %d\n",
> > +	         ctrl->tag_set.nr_hw_queues, nctrl->queue_count, qcnt);
> 
> No need for this print as info, its just spamming...

Sure, was just for the RFC here. Will drop it.

> Shouldn't we do the same for the create itself? Is there any chance that
> we will leave a tcp connection idle in any situation?

No idea, though would this not change how we handle the writes to
/dev/fabrics? Currently, we block and return success or fail.


