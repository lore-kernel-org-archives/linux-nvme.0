Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B0BC10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA2820B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgLUU1FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA2820B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ka9Xdc+5YpoCkTjr3Od96BeAnNh/TJkNbflU9RXZqzI=; b=IgLUU1FCKP5VGa
	VMmJFSukX20gwkQll5WbAzhmq+L1Jwjwf+WytHVHI7orkoNmDSQ0TkVQd/vVuLc53rvG9I1rBzIva
	s/gBG9JLkUNKDAnbZVeh/6mMHYsLlF1cbX0EuCYQWVlebhCXiaeKpaP8NraitYEDyfmr/jOX8t36i
	nrrZV9PDrks20+Hy9C5lH629Y61HiIqEYuzzl8qS5herxxfRzTKOiEL5KaXHeX3uTy2ktQKP+Eh0z
	hzqijE5ByNHlxBq2XeVL/Fjl7K1mdvxfTfFzVqsztFSjUXeqyPC6UIm5AvV3Y8gRZWBKACuL3XRP5
	p2SMtfU9eH8RKDJVyE2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIcgh-00080C-Ts; Thu, 10 Oct 2019 17:57:19 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIcge-0007zC-2H
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 17:57:18 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1iIcgF-0000Hl-4N; Thu, 10 Oct 2019 11:56:52 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-12-logang@deltatee.com> <20191010100526.GA27209@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d0b7e064-2e28-83b0-1593-405ab75d5bd2@deltatee.com>
Date: Thu, 10 Oct 2019 11:56:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010100526.GA27209@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 10/12] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_105716_461503_9B8CD1BB 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

Thanks for the thorough review, lots here to go through. I'll address it
all as I have time and try to get the prep work done first, as soon as I
can.

On 2019-10-10 4:05 a.m., Christoph Hellwig wrote:
>> @@ -319,7 +319,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>  	rq->cmd_flags = op;
>>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>>  		rq->rq_flags |= RQF_PREEMPT;
>> -	if (blk_queue_io_stat(data->q))
>> +	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
>>  		rq->rq_flags |= RQF_IO_STAT;
> 
> This needs a comment why we don't account passthrough requests by
> default.  And I'm really curious about the answer, because I don't
> know it myself.

Yes, sadly, I don't know this answer either but the comment made it
appear that someone did it deliberately. Digging into git blame suggests
that it just evolved that way. The check was originally added in 2005
here with blk_fs_request():

commit d72d904a5367 ("[BLOCK] Update read/write block io statistics at
completion time")

blk_fs_request() evolved to become blk_rq_is_passthrough() but I suspect
no one ever considered whether we want to account the passthru requests.

So, I'll leave this restriction out and see if anyone complains.

Logan

>>   *	a) it's attached to a gendisk, and
>>   *	b) the queue had IO stats enabled when this request was started, and
>> - *	c) it's a file system request
>> + *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)
> 
> c) should just go away now based on your changes.
> 
>>  static inline bool blk_do_io_stat(struct request *rq)
>>  {
>>  	return rq->rq_disk &&
>> -	       (rq->rq_flags & RQF_IO_STAT) &&
>> -		!blk_rq_is_passthrough(rq);
>> +	       (rq->rq_flags & RQF_IO_STAT);
> 
> The check can be collapsed onto a single line now.
> 



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
