Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED5C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:48:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CF561D3B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF561D3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GzuZyYXREfeAYtCCxy8UvPkBAWOtjwekOmjXyfBPK6U=; b=3yE8K47vBJE9cB
	ScMPn4dZnd/YcbUgVfFvIuJdn9NLG1dEvs3UmBTUDZAX5/GSwuAHixegjrncw6Mcqi6CeKsR9S/rb
	QvBxvy+KKXzPbyRQHxfrTpPYbO2gBDrFDqAOfBOPfS7VoHGDXqOLG0fLTOHdsE0Yy7C0TGTN1JGDz
	BA9vuZfu3gOdPQAQmAd420uKEzg/RQB9k9WGCW7e6zZ5UZi9I86PK6xu35U4fPrVtwMW6CM7KyRNY
	IZEfChtXK67FkeEe76rP5sNAd5/eEN8CyhvTppvDQOL/D+WGzVQ3IxBJXXhLhKCGRq+Z48WfRXJbi
	iU2yPHgf+LmvbKiRbiBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly8Tw-00A5zQ-To; Tue, 29 Jun 2021 07:48:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly8Tu-00A5yn-Ez
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 07:48:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 215BA20398;
 Tue, 29 Jun 2021 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624952906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
 b=QDxsnKbPRghqgAqqWVEiRz+w5+ijS7liI5ikU6MMxdK7m4GzIn9jMY9Y+yYj7UmYC+kyc+
 cenbI8MN8ZsTA4A7dST1BKK9QDnO744ZqhjwGbrrQH0MNA0TM+naI/gFIYyVp9Xx6EWrwS
 3Hfck6E+h3m5TOleQn0un/kg3BySvDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624952906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
 b=V2wOJ5LjAXx0XQg8S7Mqh47jnXdumcGjJE/Nf3YYVcfe3tLxPng+FqBTsJnbwRLnnID9vC
 9nE0Me8ypuK+DNDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 0CA3111906;
 Tue, 29 Jun 2021 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624952906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
 b=QDxsnKbPRghqgAqqWVEiRz+w5+ijS7liI5ikU6MMxdK7m4GzIn9jMY9Y+yYj7UmYC+kyc+
 cenbI8MN8ZsTA4A7dST1BKK9QDnO744ZqhjwGbrrQH0MNA0TM+naI/gFIYyVp9Xx6EWrwS
 3Hfck6E+h3m5TOleQn0un/kg3BySvDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624952906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CV14zOE2o7+HNtZtVdan87nKTgQqnJ5Go2CWe21xjUk=;
 b=V2wOJ5LjAXx0XQg8S7Mqh47jnXdumcGjJE/Nf3YYVcfe3tLxPng+FqBTsJnbwRLnnID9vC
 9nE0Me8ypuK+DNDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id mJkQAkrQ2mCVJQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 07:48:26 +0000
Date: Tue, 29 Jun 2021 09:48:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210629074825.s5f2d3ihuyscktg3@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNp50pmlzN6M0kNX@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_004830_702139_985FFFAD 
X-CRM114-Status: GOOD (  27.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> On Fri, Jun 25, 2021 at 12:16:49PM +0200, Daniel Wagner wrote:
> > Do not wait indifinitly for all queues to freeze. Instead use a
> > timeout and abort the operation if we get stuck.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  drivers/nvme/host/fc.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index a9645cd89eca..d8db85aa5417 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> >  		dev_info(ctrl->ctrl.device,
> >  			"reconnect: revising io queue count from %d to %d\n",
> >  			prior_ioq_cnt, nr_io_queues);
> > -		nvme_wait_freeze(&ctrl->ctrl);
> > +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> > +			/*
> > +			 * If we timed out waiting for freeze we are likely to
> > +			 * be stuck.  Fail the controller initialization just
> > +			 * to be safe.
> > +			 */
> > +			return -ENODEV;
> > +		}
> >  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> >  		nvme_unfreeze(&ctrl->ctrl);
> 
> Can you investigate a bit on why there is the hang? FC shouldn't use
> managed IRQ, so the interrupt won't be shutdown.
> 
> blk-mq debugfs may help to dump the requests after the hang is triggered,
> or you still can add debug code in nvme_wait_freeze_timeout() to dump
> all requests if blk-mq debugfs doesn't work.

Sure thing, I'll try to find out why it hangs. The good thing is that I
was able to reliable reproduce it. So let's see.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
