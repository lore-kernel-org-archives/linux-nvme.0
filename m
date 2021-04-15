Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E83C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 13:56:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514D561153
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 13:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514D561153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1V5v0dzA7uRKcl6FM8hvuD8M6+uBtu/0SM9QdxX2aMk=; b=gxykto+vSKrBLqj8A51LZ2raj
	iQ/Ku1n/OMg7LxE6N1JN0cZ6bdgTlO/wXUUpPWSCk5EavTPonfI33UQseAdge+tUwrqeIEXxUD2Nc
	GCZJ+S6oKPU0P1xE+uvoq9+u8a3PHUCha4YLQHN743Ai9DUdx75OOL1x/uhbgeg6LlWWcx53qHkSI
	nDUBlghObII1ma4H1L5SrUOX3hVh3rTsJukn46lKwEAEN0DJP19anMN9oPBGmvlf4gcdxMvnPhkGL
	jSyzEo7LgVazNwYdyieTYzhcwj2JD5ZE9CL76Te0J2nhtw9Grac4GUAUdlA45sZG2IfHPzCgCNFhu
	tth4mHVhg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX2UC-00GMCW-5O; Thu, 15 Apr 2021 13:56:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX2U8-00GMCF-N4
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 13:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=t6k+KJHgh4qNKstVz2JZFL9ECTTreUR+oV6XNzdagBg=; b=N4ay+IW1vxw5IiQlTQ/Dj1V6Sq
 MYPt8MPhZ1yAr8iaxn+itl+l5ZWdibJsUU4VhJftkaQYoafCZyXxjeH9w0Mgkk8R6YHfBIKtjnh8P
 x6RgTl8i+qExaHFSsdHXoX93/COC9FYhXtGpQMGWetxn1JDtr7MxX0IuvqIVSb+TWAMMPCOPU34uD
 3Waq77/E/f5Dr51KyfBN8whB/Onb/6aHU/msdlxeySO5KKZfE+v6VbdFgskG5DL28trCIu12SSGx9
 BKl0KqPhk/u783WX22nL6DjWrRjjcqiJ9BdprWD+FIbsJAKDomqTzf4+fS2KLnQ7TAnZZotkK7KsS
 yk/r8ETw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX2U6-008d1i-9B
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 13:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618495000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t6k+KJHgh4qNKstVz2JZFL9ECTTreUR+oV6XNzdagBg=;
 b=d6oryWbPbhB5r0J8TuMMi8hcBYTcBpl05VhUj35OW1sOxOd/EyqGbI54wyAAVbsN5ElCnd
 T+XQTW4Vy2F3tHmPFBImjV1q0lep2kDHi7Wc87upeaPFmctm8YyO/CXZQzkAQ/o/GXcQ7a
 graL74tQB3wPle+S3KknQhO/65355J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-pZdUGFrCMOSb0PZnU_PH-g-1; Thu, 15 Apr 2021 09:56:32 -0400
X-MC-Unique: pZdUGFrCMOSb0PZnU_PH-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 167CB6D4EE;
 Thu, 15 Apr 2021 13:56:31 +0000 (UTC)
Received: from T590 (ovpn-12-95.pek2.redhat.com [10.72.12.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB685D71F;
 Thu, 15 Apr 2021 13:56:16 +0000 (UTC)
Date: Thu, 15 Apr 2021 21:56:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH 2/2] block: support to freeze bio based request queue
Message-ID: <YHhF+3Qw4Y+hv5X4@T590>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415103310.1513841-3-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_065642_413469_518F9026 
X-CRM114-Status: GOOD (  16.38  )
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

On Thu, Apr 15, 2021 at 06:33:10PM +0800, Ming Lei wrote:
> For bio based request queue, the queue usage refcnt is only grabbed
> during submission, which isn't consistent with request base queue.
> 
> Queue freezing has been used widely, and turns out it is very useful
> to quiesce queue activity.
> 
> Support to freeze bio based request queue by the following approach:
> 
> 1) grab two queue usage refcount for blk-mq before submitting blk-mq
> bio, one is for bio, anther is for request;
> 
> 2) add bio flag of BIO_QUEUE_REFFED for making sure that only one
> refcnt is grabbed for each bio, so we can put the refcnt when the
> bio is going away
> 
> 3) nvme mpath is a bit special, because same bio is used for both
> mpath queue and underlying nvme queue. So we put the mpath queue's
> usage refcnt before completing the nvme request.

RAID needs similar handling too, but it is easy to do, see md_end_io().

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
