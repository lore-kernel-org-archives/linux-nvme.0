Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A382C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 07:22:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67C560FEA
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 07:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67C560FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=obUnDAbVCUu+XqMuDO32ixb5eO2MBofvcbYF3WOV7lM=; b=S1yMOujKimnj8vTUtQCVmTAfl
	lKNjieqUM8yN2Xgy6/eIXMSHCu1klPJJXlVZ565mie5pOhQl6tsGkSK4oWmrdJ25apS/M9hGxJUfa
	UjYl0W2THQ1lOycuLOE8encf0OreadfPz9pGNSZl4+21RSzTHhQR6M4QUZaBx0oeTB3jsb2tt7g7n
	GjrU1+qgLY7EGeyrY8z/qi8OF0lPI26dVGqqO+M56ik77VzIdHcUUFMe+FcSQAshV+/MynfL9Nd1S
	chKnI/PFkzDqh+uWdSyCX2mSicR/jx3wnmbYDWQxqVQqb32txl7Q194cLdLqr4IkKdaMr0rRju7dw
	DD+5+idgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYki1-00BS5C-5V; Tue, 20 Apr 2021 07:22:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYkhy-00BS4r-ON
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 07:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=yfXuXSTgZfUcs7vrDnrcFFNMWhUxmT3KmvucARukWDc=; b=lEDVrOgnelA/9VLLfJPTXJacrw
 KFgYt++b2LuMk2t10/BvK3GYx/kLHQwdy54OWV2/6+gIzFrNjNzFxPgC+JWazcHKOKLjIpiCe5E6Y
 +hFPrVS2z3sW7tTdeuzkfqDHGRktYdu/IPvSdWekd1tpKCyEilg8MannXpPDiBZTbRrev0uAaIEja
 Y4xEvZcDzAEs9frf5oLOOWjpgj4epM30NCJZiBCATcj76MLey11+gbS2u+k/rfqQXa1MjanCaIh58
 vMSV1+f7N1eBtoHtPwLUYnqlPVSXu9RH8XzH49FEiAFd3Y2eYRDonfyYTX7ggAo1sWdHV7SOWVLUK
 UlwQAJdg==;
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYkhs-00BsLq-QJ
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 07:22:05 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UWBJ92o_1618903315; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UWBJ92o_1618903315) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 20 Apr 2021 15:21:57 +0800
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Christoph Hellwig <hch@lst.de>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
 <b1db72f3-f0a1-72f2-be12-6fd50c29e231@linux.alibaba.com>
 <YH2Kr8ZIn2fWKFyl@T590>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <42c79dce-ad99-4e59-6566-727fa08a66bc@linux.alibaba.com>
Date: Tue, 20 Apr 2021 15:21:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YH2Kr8ZIn2fWKFyl@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_002201_056399_731E3F22 
X-CRM114-Status: GOOD (  21.25  )
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



On 4/19/21 9:50 PM, Ming Lei wrote:
> On Mon, Apr 19, 2021 at 08:05:46PM +0800, JeffleXu wrote:
>>
>>
>> On 4/15/21 6:33 PM, Ming Lei wrote:
>>> For bio based request queue, the queue usage refcnt is only grabbed
>>> during submission, which isn't consistent with request base queue.
>>>
>>> Queue freezing has been used widely, and turns out it is very useful
>>> to quiesce queue activity.
>>>
>>> Support to freeze bio based request queue by the following approach:
>>>
>>> 1) grab two queue usage refcount for blk-mq before submitting blk-mq
>>> bio, one is for bio, anther is for request;
>>
>>
>> Hi, I can't understand the sense of grabbing two refcounts on the
>> @q_usage_count of the underlying blk-mq device, while
>> @q_usage_count of the MD/DM device is kept untouched.
> 
> Follows the point:
> 
> 1) for blk-mq, we hold one refcount for bio and another for request, and
> release one after ending bio or completing request.

Blk-mq has already implemented queue freezing semantics, even without
this 'grabbing two refcount'. So is this just for the code consisdency
with the bio-based queue?


> 
> 2) for bio based queue, just holding one refcount for bio, and release it
> after the bio is ended.

OK.

> 
> As I mentioned to you, the current in-tree code only grabs the refcount
> during submitting bio for bio base queue, and the refcount is released
> after returning from submission, see __submit_bio().

Yes. I ignored that the refcount grabbed in the entry of bio submission
has been returned back when the submission completes for bio-based queue.

> 
>>
>> In the following calling stack
>>
>> ```
>> queue_poll_store
>> 	blk_mq_freeze_queue(q)
>> ```
>>
>> Is the input @q still the request queue of MD/DM device?
> 
> It can be either one after bio based io polling is supported,
> queue/io_poll is exposed for both blk-mq and bio based queue.
> 
> However, I guess bio based polling doesn't need such strict bio queue
> freezing, cause QUEUE_FLAG_POLL is only read in submission path, so
> looks current freezing just during submission is enough.

Not actually.

blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	struct blk_mq_hw_ctx *hctx;
 	long state;

-	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
+	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))

Here QUEUE_FLAG_POLL is still checked in blk_poll() for bio-based queue,
at least in your latest patch for bio-based polling.

-- 
Thanks,
Jeffle

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
