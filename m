Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49DCD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQGPTjeTYC2G6Duont4PkYAZRT01n0oOkKtgkWvWmnk=; b=MOFGHz3LQfAXfueiC5VdAnfXaP
	oBCdkSRCEOnP186adqO4TcgpwwZCZM2o5kNWcf4miYvyGyLVNA5jY1i3fg2XqnQhMGAohkbj8ELeq
	LPuA59fdPXBpf4/R1NnZZ6qdJym4bq0vNi2LhG1AC1P8x8AMjn+CujI4icVluVoT1jCRrEFs3f9Nj
	8QSangYGwev2a1xPMwlOMI+D0MZbQpT0Ka5STLuVZ0JcJ/ZIUzcQmYIX6JstArUvlYwznaaYNWmhi
	w/PPT3rrwMe5+Kg6uOijpeDScwmbPHZ8IRCcItML3zvpXqCw9Mx8hgbw7AxKCbQsxsmrvFpug6E9e
	uPfvKkBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyT1-0000000FyqB-0vFy;
	Thu, 28 Mar 2024 22:43:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpySx-0000000Fyp8-44jI
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:43:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 81B9CCE2137;
	Thu, 28 Mar 2024 22:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBA0C433C7;
	Thu, 28 Mar 2024 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665800;
	bh=CITK6Ojd1qaNKBu5TkUujht795crhOMrLdIVFC0Z5hM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MKCy/AVU6l2/Wrshu0b1+Qr72XyFVoSv41DvYqxpLZR5jzfI7OrjWnyhqwEJ8kIC5
	 9Cd238wXzx+FNBGZseIM7viDlGvYyda7z9CYEwW6iYWjEiG2OmR4HMTT0yp+wurT2C
	 ssR3nRcj742vELHhL64gVOziqBuTKhRUJJEPJolpYIBqLzEoSkLrrfRgkvJeqxS4WH
	 xevrEy77CY54uuhICmkeeg9iydwkca+Cup/S1456Qs5SfIB/kQbBapooQnDU+Sp1Y3
	 XLA+/o23yQTWn1PhKXEW1xdKWL+l132FnXtAd2hUurbcsoTX/oUkCPTQim8uW+i9pL
	 oMNYZe8JYT/pA==
Message-ID: <935b43c0-b5cc-48ef-a283-564499ac7bde@kernel.org>
Date: Fri, 29 Mar 2024 07:43:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/30] block: Do not force full zone append completion
 in req_bio_endio()
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-2-dlemoal@kernel.org>
 <a474bae3-e505-4d17-a5e4-ed9928b6cbb3@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a474bae3-e505-4d17-a5e4-ed9928b6cbb3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154324_400470_53689CFC 
X-CRM114-Status: GOOD (  20.37  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/29/24 03:14, Bart Van Assche wrote:
> On 3/27/24 17:43, Damien Le Moal wrote:
>> This reverts commit 748dc0b65ec2b4b7b3dbd7befcc4a54fdcac7988.
>>
>> Partial zone append completions cannot be supported as there is no
>> guarantees that the fragmented data will be written sequentially in the
>> same manner as with a full command. Commit 748dc0b65ec2 ("block: fix
>> partial zone append completion handling in req_bio_endio()") changed
>> req_bio_endio() to always advance a partially failed BIO by its full
>> length, but this can lead to incorrect accounting. So revert this
>> change and let low level device drivers handle this case by always
>> failing completely zone append operations. With this revert, users will
>> still see an IO error for a partially completed zone append BIO.
>>
>> Fixes: 748dc0b65ec2 ("block: fix partial zone append completion handling in req_bio_endio()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   block/blk-mq.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 555ada922cf0..32afb87efbd0 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -770,16 +770,11 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
>>   		/*
>>   		 * Partial zone append completions cannot be supported as the
>>   		 * BIO fragments may end up not being written sequentially.
>> -		 * For such case, force the completed nbytes to be equal to
>> -		 * the BIO size so that bio_advance() sets the BIO remaining
>> -		 * size to 0 and we end up calling bio_endio() before returning.
>>   		 */
>> -		if (bio->bi_iter.bi_size != nbytes) {
>> +		if (bio->bi_iter.bi_size != nbytes)
>>   			bio->bi_status = BLK_STS_IOERR;
>> -			nbytes = bio->bi_iter.bi_size;
>> -		} else {
>> +		else
>>   			bio->bi_iter.bi_sector = rq->__sector;
>> -		}
>>   	}
>>   
>>   	bio_advance(bio, nbytes);
> 
> Hi Damien,
> 
> This patch looks good to me but shouldn't it be separated from this
> patch series? I think that will help this patch to get merged sooner.

Yes, it can go on its own. But patch 3 depends on it so I kept it in the series.

Jens,

How would you like to proceed with this one ?

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research


