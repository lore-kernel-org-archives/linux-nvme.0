Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3795C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 07:59:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9656135F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 07:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9656135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JlYxq+uIUMWyxEp9J18EsuTtoleW6M7Ot1BcAoj/4Fs=; b=ktgROFZxXKkGehIspS2u0bO50
	Oh0bKemZjXeylnMxFJEuywqfOzoVpEE07YyQK/jYPimT3hZwgnistcT9w4OW25pkV+ij201VffZOS
	5dVRNqP7PledaTG+IkbAz0BR0p7998THOJYv8euURAqWRPDEB4Hcdtr8bVYyoF2a6oMx8jhQHUAxw
	BMDBBlGFKN062EcYm41qJYq3RqQcShSy/g0pIgXGskKw9r3LNLk4Gfoyzuwt1wkINxV1k5HNkr5Yc
	Ug4nnhNu0EDU5gfG3uX/XpGdTNGGZnvohqyY63N3zgCWMuaC8L7Y1qSj3nPP15uAhio2nlnRZdyrl
	CJpi7QS6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYlHo-00BWL1-D5; Tue, 20 Apr 2021 07:59:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlHk-00BWKR-VZ
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 07:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DAjeY/T/CPScSPWymCzycaeNgOOPXoZc8Xkk3oZ35yo=; b=S2MFnpgtIZp8OOH1WuD6q5aSEd
 Hn4wCZ3oa+3lV6oyS2cEnhFakR7xZ6pkVcbpnTyqEjz0Cjo0g8dyquLJVksuac2OSsQ533Dim/vit
 bu7fZ3tkgi8wfsSJXn4rids0tvkEE4iMK8CQ4FzrPZSbyMFhCJqg/74N2i5J56V2WJYv4VnYb/iuq
 zOGovuxBk1SfhnCCmHnJQluvrpQU1nMNtM2pOHVeAdmtGjnfWu7laYTf+Epoyp1gaxKCrg0cwvgY4
 uWpb3fLFaviufl7orfeyckdgapKYrbsxU4Ybw69Sz9ryXSFG+K+BuMCSCVf63MH3+1On0Qiz3FdO4
 GEbLxm/A==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlHf-00BtkM-IA
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 07:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618905537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DAjeY/T/CPScSPWymCzycaeNgOOPXoZc8Xkk3oZ35yo=;
 b=NGzp5blfOjjj/hO/aTzl8BWEnwUtaCVx7Rf2O3rG2yDQ3KOWdR+L3RadtmaG2Ctp3cGmjr
 HlGMN0OgLp+EMRF0804sEJF8N8NiGJoDNJyfVHcJ/RmAFJZ4ri9vj6uITDFIrO9bEVohPS
 5odycSR9vPNIZWbzuuUudSM+Zp2t3CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ZNEhrwp9NXembJ99KWR84g-1; Tue, 20 Apr 2021 03:58:53 -0400
X-MC-Unique: ZNEhrwp9NXembJ99KWR84g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C17B91E767;
 Tue, 20 Apr 2021 07:58:52 +0000 (UTC)
Received: from T590 (ovpn-13-154.pek2.redhat.com [10.72.13.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 735E75D9CA;
 Tue, 20 Apr 2021 07:58:39 +0000 (UTC)
Date: Tue, 20 Apr 2021 15:58:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
Message-ID: <YH6JrTEsYfFA5DQH@T590>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
 <b1db72f3-f0a1-72f2-be12-6fd50c29e231@linux.alibaba.com>
 <YH2Kr8ZIn2fWKFyl@T590>
 <42c79dce-ad99-4e59-6566-727fa08a66bc@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42c79dce-ad99-4e59-6566-727fa08a66bc@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_005859_703041_7B12592A 
X-CRM114-Status: GOOD (  29.22  )
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

On Tue, Apr 20, 2021 at 03:21:55PM +0800, JeffleXu wrote:
> 
> 
> On 4/19/21 9:50 PM, Ming Lei wrote:
> > On Mon, Apr 19, 2021 at 08:05:46PM +0800, JeffleXu wrote:
> >>
> >>
> >> On 4/15/21 6:33 PM, Ming Lei wrote:
> >>> For bio based request queue, the queue usage refcnt is only grabbed
> >>> during submission, which isn't consistent with request base queue.
> >>>
> >>> Queue freezing has been used widely, and turns out it is very useful
> >>> to quiesce queue activity.
> >>>
> >>> Support to freeze bio based request queue by the following approach:
> >>>
> >>> 1) grab two queue usage refcount for blk-mq before submitting blk-mq
> >>> bio, one is for bio, anther is for request;
> >>
> >>
> >> Hi, I can't understand the sense of grabbing two refcounts on the
> >> @q_usage_count of the underlying blk-mq device, while
> >> @q_usage_count of the MD/DM device is kept untouched.
> > 
> > Follows the point:
> > 
> > 1) for blk-mq, we hold one refcount for bio and another for request, and
> > release one after ending bio or completing request.
> 
> Blk-mq has already implemented queue freezing semantics, even without
> this 'grabbing two refcount'. So is this just for the code consisdency
> with the bio-based queue?

Right.

> 
> 
> > 
> > 2) for bio based queue, just holding one refcount for bio, and release it
> > after the bio is ended.
> 
> OK.
> 
> > 
> > As I mentioned to you, the current in-tree code only grabs the refcount
> > during submitting bio for bio base queue, and the refcount is released
> > after returning from submission, see __submit_bio().
> 
> Yes. I ignored that the refcount grabbed in the entry of bio submission
> has been returned back when the submission completes for bio-based queue.
> 
> > 
> >>
> >> In the following calling stack
> >>
> >> ```
> >> queue_poll_store
> >> 	blk_mq_freeze_queue(q)
> >> ```
> >>
> >> Is the input @q still the request queue of MD/DM device?
> > 
> > It can be either one after bio based io polling is supported,
> > queue/io_poll is exposed for both blk-mq and bio based queue.
> > 
> > However, I guess bio based polling doesn't need such strict bio queue
> > freezing, cause QUEUE_FLAG_POLL is only read in submission path, so
> > looks current freezing just during submission is enough.
> 
> Not actually.
> 
> blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	struct blk_mq_hw_ctx *hctx;
>  	long state;
> 
> -	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
> +	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))
> 
> Here QUEUE_FLAG_POLL is still checked in blk_poll() for bio-based queue,
> at least in your latest patch for bio-based polling.

OK, we can simply drop it.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
