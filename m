Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC84C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 13:51:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CA061078
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 13:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CA061078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G8mw+8gJw8IK2CK0osRSTLM2WnAg9c4SoFfEgYzVyUY=; b=SWooqqBvY8WE9MPVFNR24/iA8
	9m+Cp/kjK+1wVTFpiaaFY202Y8XmeUSj14dpQetyV+DbMBEfCOMFrg2m3muJA/TwrzZKIqw4cERoT
	HXvTKHHsX+b3A+2+OGzCNnMtaeLGTd/+wuXpFdUa1f8+La5d3xnJFYwyO6SF3UEvIg1HmtpXeD2nJ
	aheGcc9iG9tXo1eaWss6tBtxfw8a43jE4RI8YOVeK+uxfkNRS8TKRs6I3Ju73D+ShMiIgRL0hIxUV
	HDdSewFl8Rh0fykw9cWBvzYMToRu1LOJhsqZY50OZq1cK68oUXY5vyKD7GqlQgMSE8qrvk741Ve4c
	p+behHTYw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYUIl-00A1oV-FW; Mon, 19 Apr 2021 13:50:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUIi-00A1oN-Vm
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 13:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SXyrXEedJfmFDgBmkAT/98qBgfpQeb6WK3mtJeKmj+I=; b=WKtNDODgnYqDAMLORy18mVDu0l
 BuTPcCJi4aMhBwiGjwnI5HJO8CXUqVPDiU0Z3PyUaYOp3pzIG4p2Z/6EPK+9BIjahZRab/1hnHIgZ
 +zPddQiwanZEd14+5KiOljPYaKMUXCVH7dy4zzyQGCt5sqxGGQL8gmZWO62t1CM76uBxgbiQVKHOx
 AMZLDLtatqUtU/KhX+I4kT/IdEB5ivwjUcGucdMrBP4zHcxnaCoIcMJllwtPjZ7HVEZUfyO6BEFHq
 SiTJ+guYW1SkO9wMDurYpT0VqPoMxVLVdzIKuRQxMh44eO3Bv6tY7Jcl4QSNxShbx03GdxHKi9zdn
 uxTkJ6EQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUIg-00BQ2G-1v
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 13:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618840251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXyrXEedJfmFDgBmkAT/98qBgfpQeb6WK3mtJeKmj+I=;
 b=fFeRYdOJvrFnD+CjUWXmwUI6qWusBTt4mQ+801HhttT1kb5WkYjuka/6OpvYUMfNz5vwdW
 vs9Vv+6tT9hVb1U9ukcvm06kJRkNMnyQ+ef3h7UbPN5JZ9VQi1GviKlNKd78SaTDPa+edr
 2arqNtRXx5YZOtpvyM9Tnn3vcwQSwbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-zM7VMfOEPTeooElOnQyGzw-1; Mon, 19 Apr 2021 09:50:48 -0400
X-MC-Unique: zM7VMfOEPTeooElOnQyGzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72DD1006CB0;
 Mon, 19 Apr 2021 13:50:46 +0000 (UTC)
Received: from T590 (ovpn-12-222.pek2.redhat.com [10.72.12.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02A6017A81;
 Mon, 19 Apr 2021 13:50:41 +0000 (UTC)
Date: Mon, 19 Apr 2021 21:50:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
Message-ID: <YH2Kr8ZIn2fWKFyl@T590>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
 <b1db72f3-f0a1-72f2-be12-6fd50c29e231@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1db72f3-f0a1-72f2-be12-6fd50c29e231@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_065054_199116_B504A73F 
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

On Mon, Apr 19, 2021 at 08:05:46PM +0800, JeffleXu wrote:
> 
> 
> On 4/15/21 6:33 PM, Ming Lei wrote:
> > For bio based request queue, the queue usage refcnt is only grabbed
> > during submission, which isn't consistent with request base queue.
> > 
> > Queue freezing has been used widely, and turns out it is very useful
> > to quiesce queue activity.
> > 
> > Support to freeze bio based request queue by the following approach:
> > 
> > 1) grab two queue usage refcount for blk-mq before submitting blk-mq
> > bio, one is for bio, anther is for request;
> 
> 
> Hi, I can't understand the sense of grabbing two refcounts on the
> @q_usage_count of the underlying blk-mq device, while
> @q_usage_count of the MD/DM device is kept untouched.

Follows the point:

1) for blk-mq, we hold one refcount for bio and another for request, and
release one after ending bio or completing request.

2) for bio based queue, just holding one refcount for bio, and release it
after the bio is ended.

As I mentioned to you, the current in-tree code only grabs the refcount
during submitting bio for bio base queue, and the refcount is released
after returning from submission, see __submit_bio().

> 
> In the following calling stack
> 
> ```
> queue_poll_store
> 	blk_mq_freeze_queue(q)
> ```
> 
> Is the input @q still the request queue of MD/DM device?

It can be either one after bio based io polling is supported,
queue/io_poll is exposed for both blk-mq and bio based queue.

However, I guess bio based polling doesn't need such strict bio queue
freezing, cause QUEUE_FLAG_POLL is only read in submission path, so
looks current freezing just during submission is enough.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
