Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA7C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 03:50:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16117206F6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 03:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOZ/QYMc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5kQ283j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16117206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s4kBfLXss+k/ATdpy2+DIclkhbj2zyiA5B0kG/j3OiU=; b=XOZ/QYMcudvuV40lSt3F8au3n
	A+acZpT4UvhhjzoBxLZ8irAutqdpVy8on/1SMCWPSP37TJLxDpMVNRSbwnI7fy8KfyElA4pEwr/Xq
	wYJsrCLkUFF5+tHXeuVRXAx0M5aD+qBt2KOflOM1Yi8PIqZzxaV0mtI2yaMJk6Ta17R9UXN5t2EJg
	3pBjbg7WWFYE9JfhQGBn9mdEBUMhTuVV9axjrbs3mM4qhcCuBKY7BTXzurqjs7fETfUXAZ0zqW892
	omOkfyf+g3wZKX2s+NebGqMCPv3Ge3EmURLiubx+gq2vz00WphbW7cRi9CYTzr/wNs5YOpEveLz14
	Z2Z6sSJHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzuA7-0006rx-GR; Mon, 27 Jul 2020 03:50:51 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzuA5-0006rb-2J
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 03:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595821848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pAM0Zmv2QoUOAi07IeWvi0mIrJEh5DbB2DkMIwNm64=;
 b=i5kQ283jKXgmB7NYSCpEgrrp0fAhmL/Kh1M+S+vsuiJHuBGnm6NNw+8jypYXof0aaPnoMt
 97dRJ7fOHkDY9P+69dix1syTcD3/TQvjilANHm4tsc+RFNnOsqEq8wIohdW/9kQzXfnAi+
 7/AE7PtEvyflGNlqoRkIZHVcU3xE6FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-AGFhF_-bNwWwSq5HNf1UWw-1; Sun, 26 Jul 2020 23:50:46 -0400
X-MC-Unique: AGFhF_-bNwWwSq5HNf1UWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7976680183C;
 Mon, 27 Jul 2020 03:50:44 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D158FA35;
 Mon, 27 Jul 2020 03:50:37 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:50:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727035033.GD1129253@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_235049_197949_9EFEE6F1 
X-CRM114-Status: GOOD (  15.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/27 10:08, Ming Lei wrote:
> > > It is at the end and contains exactly what is needed to synchronize. Not
> > The sync is simply single global synchronize_rcu(), and why bother to add
> > extra >=40bytes for each hctx.
> > 
> > > sure what you mean by reuse hctx->srcu?
> > You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> > to each hctx for just simulating one single synchronize_rcu().
> 
> To sync srcu together, the extra bytes must be needed, seperate blocking
> and non blocking queue to two hctx may be a not good choice.
> 
> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
> not need if which do not need batch sync srcu, I still think it's better
> for the SRCU to provide the batch synchronization interface.

The 'struct rcu_synchronize' can be allocated from heap or even stack(
if no too many NSs), which is just one shot sync and the API is supposed
to be called in slow path. No need to allocate it as long lifetime variable.
Especially 'struct srcu_struct' has already been too fat.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
