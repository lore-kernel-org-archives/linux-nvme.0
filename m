Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:12:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7E961408
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7E961408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U9dRjR1lDBbwj/l7Vr0Cr3DcX23oZvUwVwzFHc9cyMg=; b=WJ7NKlBV9Jj6q172sPWD/rLsr
	KlD8lB2VZJ+O1mv2723exWnvar9h/i24sOrZCXivlXNduLyNTT+uDkOsQPJD2NQfZ0GlWxCcmixz1
	8y2h26LTrCgvxI+F+vGMDcazh21unZ56y5c285kZo0Wf4tpD55G4v7je5p43K9EFNOQBMOmVeytn8
	kHFO9zNDfLsIShDA6Ajhd9qOJuc4PAwSygvP0WxwGp23aZwaEjhKp5GmGWh7XDgRlvNfmq7lBW+M6
	GNB0fZ+FZ59dTWT+9oU58QKae67Ub+7U+dZLX2Sx7tOoIcs/HxhI6UpQsnKVrKRaiAOvZBt5wKGFh
	Mkmgsih9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgx61-0048IC-Me; Wed, 12 May 2021 22:12:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx5w-0048Hl-O1
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:12:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KuUD/AP0eu46ftOpFOwAD+oXCcqd6jdFH2K0mQnm/Ug=; b=RNje1aPSzQrXvD4fW6WRVEP44a
 SNv3UgIAxytR8sQS/7n1sBrjAsRn7aDISnStRkYbx3SslsEp8EpKzYT1iL/Q0Yb5M6g32bjB9sDu/
 7p/uRpvP5zUFIHnx3evIcALqYp3gSnGcIKTLitImKPWqmv8LSDfSuf/ZebqAIwXLiFG/uUd995784
 m8ojJlm9HoSimrSosLW+wULOCQ8cHg0MOlPapXX1bctDJVjQCuXb3AYn+4E3+xeGUoXvsoRKVBJwj
 7x7lqWN1P1Gt83G9MgiJrblQCx5piJCYqZ8jCx8I0jYJ2JUahwr0cn83qytr8ydme1kiKB/oREJXW
 mGro8g7Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx5u-00AreX-99
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:12:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F339E61406;
 Wed, 12 May 2021 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620857560;
 bh=krzwbY3LekAl7s/TmTn3XHRBie3mv+RrBA2O+8MCYYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Du+rilF0mutiHpRWqh2IKZGM5oINNki8qMrcvvEiO6Oc6HuK9adwU15rUd079Jp8P
 eSWikb5pGJ7nslJYmKJP2Jm/r/4ubswpXolmhlTKyv7pfq4NbkkkFn4eh6Rjle+30A
 dhf+WjtCDnMHtzgJwf/wS0jlIc8asLLUaZVIolVyImSEHevhGENmsEKkpIl3DP3cBP
 Bf//pzlKtnha++TmHKclYnsSWsTRuVZ+t37mnHOCd58LG4+QxduIvJbOJ+MAtX0U9w
 hv1440XGt9cFhE3cemp1dk4njKVuGoE4btKu8TR8VikGWaC3feh/oQV4npnNrg84Dy
 WcP1WEP577ZfQ==
Date: Wed, 12 May 2021 15:12:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_151242_380999_73E4017A 
X-CRM114-Status: GOOD (  20.32  )
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

On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > + *
> > + * Note: the caller must either be the context that submitted @bio, or
> > + * be in a RCU critical section to prevent freeing of @bio.
> > + */
> > +int bio_poll(struct bio *bio, unsigned int flags)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > +
> > +	if (cookie == BLK_QC_T_NONE ||
> > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > +		return 0;
> > +
> > +	if (current->plug)
> > +		blk_flush_plug_list(current->plug, false);
> > +
> > +	/* not yet implemented, so this should not happen */
> > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> 
> What happens if the I/O wasn't (yet) queued to the bottom device
> (i.e. no available path in nvme-mpath)?
> 
> In this case the disk would be the mpath device node (which is
> not mq...)

The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
get to the warning. But if that does happen, it doesn't appear that
anyone is going to wake up thread that needs to poll for this bio's
completion when a path becomes available for dispatch. I think it would
make sense for nvme-mpath to just clear the REQ_POLLED flag if it
doesn't immediately have viable path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
