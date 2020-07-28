Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625FC433E5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:58:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0667A204EA
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hq0F5T7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0667A204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xN8UKvuH/Jw2JjwqJ4v2wvRpv8tg5OYOoadY2ZCCla8=; b=Hq0F5T7XZ0Lz1lry/i5a5/VrC
	7pV+jMTrPTl/1iMrBVlMSoNQ+SFIWovMEfN6AQgbbBFDcsaJiYieWxQhUFEtNilw/VlzWe3088ixd
	MyiMiJ5tKoG7Ujb3s3n4SPJz5zD4oll4WCWXZBzCUDf2IdZNjkZm+xFpND87DokSn1Gft+zwsEsRb
	+NTXNGxCNIPpOH0KWUPk5oGxJuWeIQ2W35UkhkuqzyvBca3b6mhS9W4NsokXYfs57t6PJqeji6q7B
	Sy9pylkIDE0qBIAkjPDfVGfhFZOYBhXZmUU8kq9sRkGxilwp30cVKT5DsMIZUsYVyBvomFttf/ABr
	NgLsY401Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0NJT-0004uC-GR; Tue, 28 Jul 2020 10:58:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0NJQ-0004sw-Ub
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 10:58:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5FD5668C4E; Tue, 28 Jul 2020 12:58:23 +0200 (CEST)
Date: Tue, 28 Jul 2020 12:58:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728105823.GB29763@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_065825_112291_F697336B 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2020 at 02:37:15AM -0700, Sagi Grimberg wrote:
>
>>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>>> allocation and wait doesn't seem very scalable.
>>>>>
>>>>> Paul, do you have any good idea for an interface that waits on
>>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>>> global completion and counter, and each call_srcu would just just
>>>>> decrement it and then the final one would do the wakeup.  It would just
>>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>>> counter on stack to avoid an allocation.
>>>>>
>>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>>> the rcu_head in the hw_ctx.
>>>>
>>>> I think we can do that, please see the following patch which is against Sagi's V5:
>>>
>>> I don't think you can send a single rcu_head to multiple call_srcu calls.
>>
>> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
>> rcu_synchronize into blk_mq_tag_set.
>
> I can cook up a spin, but I still hate the fact that I have a queue that
> ends up quiesced which I didn't want it to...

Why do we care so much about the connect_q?  Especially if we generalize
it into a passthru queue that will absolutely need the quiesce hopefully
soon.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
