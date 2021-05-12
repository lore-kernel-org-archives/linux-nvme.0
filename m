Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA60C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:17:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E940F61408
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E940F61408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n/tuG0cyZ3yy7/At79qO9/opuOr5usRpa+QHmzLubjs=; b=mEasHwP0HjueI3rlQYSRpBrUN
	feDf9J7xtT3a//JIQQ+AZDh2pOugWe7RFvTuXCgzE2cRhSA0XLJEbB7QH/jsSn32gyjUq6e47bguf
	gIxrgElVH79rgQwSY+WfFt5RR/m317M/AAXw9zJeuQE1gStLpdGW/v+8G7TKR6sfeSQWjmWs8vPVj
	VHML9X6EGbkV2wkoRU+7da5Gx/LQU5nQz1X/o5CG4JFj/9VLxUoYSIeedTQuMNr5aUwq1sb5n37GZ
	bWERS88i38r5FbrcX/nXAYGFh3+Q46gavmISDOYVjgbWS3DlyI/rm46e8stC+E/J4wJ7tS3CG3fNu
	4DLMGCKqg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgxA4-0048fs-8a; Wed, 12 May 2021 22:17:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx9z-0048fI-Tu
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Jv23KV9OiJ3OGNU92ipEQi9x+00KwT06+yPknzGPj7U=; b=ruGdkbBufyQbJ3iV4PaGBYD+GQ
 8pyRYW332f/quJJLit7lY2xXjlWlPJFqME+8O51ERoB4+trXubC83E8oq4aCjLMSwPRjN+AtmfjdJ
 y2vUvJeuwCv++OFSRS9oUc3Rl/RM+poWOBOkJkh3bsKQmPCTF9eTUxfqC+Hij7mw57UFqziOle8mp
 8pK0KxuXKLVQgOTOYxhheN6yekAFjNMxrjEIAj2VynM2mreq/nwWkB+vTUym2ldRBwmofr3GMo8T9
 aAeYwnUnuttBps546e02p+O0jkCJd8TiBm7NKV0qoOXUfCy08G7zwZVfMg54M18yVXetlabgjTA1c
 gWaGQ+Vg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx9x-00Arqr-6L
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:16:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCE160FE5;
 Wed, 12 May 2021 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620857812;
 bh=gWvXwEcUW9/zyCDBF+2nlh6sqFqdf0UI2tvHhr1sEBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HGr9heSTZtAV6hJ5Uuoc0TrX22mINbku96TDtiPDJ084KaKqhXEFugrSKPQfNUhU2
 riINRXq+ogjYsM29IVthNd95eYfXF/RsaYH7xzp4Fw8yy+SeciMASLxH2E3NHCH3RH
 R+LWxFsOcUPva+cE1D7AmmgPLFP8PSFkHOpHQFxQH4pJdfEJS4bP16B2tzO4Dkjxns
 NYKXG+TX3H0RHzfBfTZAM6w13rTIBaZzBqKZ/C97gYTeKMsGg2lECJMVFO9PZK+ihS
 AJZgMwQtnSzzEde48iIQ/IyVvwUs65yzGeQyAbo3sEE6wJnZ1FhW54IHPX7b9M/O2+
 cpZzTb+2e9Dhw==
Date: Wed, 12 May 2021 15:16:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 15/15] nvme-multipath: enable polled I/O
Message-ID: <20210512221649.GB2270434@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-16-hch@lst.de>
 <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_151653_382379_1938ADA7 
X-CRM114-Status: GOOD (  22.75  )
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

On Wed, May 12, 2021 at 03:10:58PM -0700, Sagi Grimberg wrote:
> 
> > Set the poll queue flag to enable polling, given that the multipath
> > node just dispatches the bios to a lower queue.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/nvme/host/multipath.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 516fe977606d..e95b93655d06 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -446,6 +446,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> >   		goto out;
> >   	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> >   	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> > +	/*
> > +	 * This assumes all controllers that refer to a namespace either
> > +	 * support poll queues or not.  That is not a strict guarantee,
> > +	 * but if the assumption is wrong the effect is only suboptimal
> > +	 * performance but not correctness problem.
> > +	 */
> > +	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
> > +	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
> > +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> 
> If one controller does not support polling and the other does, won't
> the block layer fail to map a queue for REQ_POLLED requests?
> 
> Maybe clear in the else case here?

This only gets called once per head, though, so it's just going to
inherit whatever capabilities the first controller happens to have. If
we do set QUEUE_FLAG_POLL, but the chosen path happens to not support
it, then submit_bio_checks() will strip off the bio flag and it will be
processed as a non-polled request.

If the first controller can't support a polled queue, then other
controllers that do will just have unusable resources.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
