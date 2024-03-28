Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F46CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XpkAyFXDfnKKrnORiizuu0vbWhnwqe4qRQcMbxyl2vI=; b=w+S/olAtqgCcVnBIoiUYceTN6+
	e/UDoKVQ36M8kDcCnu9gQHBQsBlkUBoUh3WzPOF17py0Uq28a3kJS5uSJs2r0llI49zegQwiFzLmM
	C446fb9LN9rl4r8/w4Wr4Q/aaolCoT9mQAVwrPoKTkSdcD+q+X5RNdeIUWsun+LnpwPkQBUqMYSrO
	6Kwz2E+wZpSHBqHOrcBvWSW00P2D/Iq6FFWHXgM5yfMUxRbuiyKLXVIrtVKy1oo232fL6nJavVkDl
	LQRdH4bunW33lLcr0M6Q+25h1RLk/vjSpzn58ou6dEWSicTD1zXyLWh0IeN1Jc085priqqaf3eP81
	S/XFSkmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpymb-0000000G13I-0IIs;
	Thu, 28 Mar 2024 23:03:41 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpymV-0000000G10a-0kKF
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 23:03:39 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3688f1b7848so1543025ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711667007; x=1712271807; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpkAyFXDfnKKrnORiizuu0vbWhnwqe4qRQcMbxyl2vI=;
        b=SD1Hwh9wIiWHfUztdDt0QsVQOJirC+/xUU7Piwi+ex2wpyedwHLmUdGehXPmpfzvXZ
         gCUvThu87js4Xcx9F3NO8xYg9dkv44/qUvnZ8AXwP2sE8xGm3WePSBNOqoOgoTOeTMpu
         dHKtfOvBil35TXQ0uumPK8memBaMGxrW4vtGVNICC6xEEStyKVrYAbCmfQc24cPFGkzO
         EJssMP6ZrLS0knLCd1R2M2aah4SoTXngfNnqxBYmuJ3ZSIOYuJAd/sl2i457ST/R9pqh
         eavyKTTTI1yD+SHSwpJo7xO/+b0AUby4L9Tjmij0JMPQg0GqTpah15Yyv/YB3k9RV+g6
         PzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667007; x=1712271807;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpkAyFXDfnKKrnORiizuu0vbWhnwqe4qRQcMbxyl2vI=;
        b=PHvpFI+23MWIwNAFbFbG0wxNx0PQW8PFrJZgx3bBxuOXgY12sqcNqbrNCXrlCweowM
         9TJO+akmKmmExILYMk1r9pMySV3bd4Cdw4mk3nf0CqeLdWdWu/AcC3q72LEap+EemlZl
         JSSGrAqb/iYAGA9XOl75jYJIuMTTnEZcAbFgBQD3Eex/726XO7UnwOmlXxP6MPHZ7KPF
         qsaQUupUEzFxTxHxfAqHWwtZNbkCq5HEJzUC+XUKte5BvbrTodfOx1nJ2pPu0w/awwuc
         m+U8eOfXTJZpx1KdIQtahY8EgQUVPwMZVNy3uDBBYP2K9X2XSn4v9UfOdkTPwN5DTMWz
         4BsA==
X-Forwarded-Encrypted: i=1; AJvYcCVzGIQhmDxhxhzdOTfxb9ZqNmaYvEKeMZL/6TGeuiPDYiGcSj+gMZ7U2zqxHg0hOGizAqbFZBlKEfZTrK2MLq5SqW6o9K81AZw/FeSSCWI=
X-Gm-Message-State: AOJu0Yy143okLnH+5LAnKcVjEqS7Tyl5xQhDTqBF2H0Zt1o988gV+wsV
	xSUC4QJBn1CHoR++kh+m20Vn48NpOa+Y/4g0D7OrlkTqHatIztIW/o2N3xSj4MA=
X-Google-Smtp-Source: AGHT+IHAI1GJZLWvZiX+0hK7hw4PeNQyK/rx84JPWm9big8mT9eaCtaTSySO5HhDhFTfwSSCdLU3UA==
X-Received: by 2002:a05:6e02:350c:b0:365:224b:e5f7 with SMTP id bu12-20020a056e02350c00b00365224be5f7mr610977ilb.1.1711667007379;
        Thu, 28 Mar 2024 16:03:27 -0700 (PDT)
Received: from [192.168.201.244] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id 8-20020a630f48000000b005f0793db2ebsm1843234pgp.74.2024.03.28.16.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 16:03:26 -0700 (PDT)
Message-ID: <acf9949e-f4a2-49f7-9f6f-351c8158522a@kernel.dk>
Date: Thu, 28 Mar 2024 17:03:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/30] block: Do not force full zone append completion
 in req_bio_endio()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-2-dlemoal@kernel.org>
 <a474bae3-e505-4d17-a5e4-ed9928b6cbb3@acm.org>
 <935b43c0-b5cc-48ef-a283-564499ac7bde@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <935b43c0-b5cc-48ef-a283-564499ac7bde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_160335_351125_2049E376 
X-CRM114-Status: GOOD (  19.38  )
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

On 3/28/24 4:43 PM, Damien Le Moal wrote:
> On 3/29/24 03:14, Bart Van Assche wrote:
>> On 3/27/24 17:43, Damien Le Moal wrote:
>>> This reverts commit 748dc0b65ec2b4b7b3dbd7befcc4a54fdcac7988.
>>>
>>> Partial zone append completions cannot be supported as there is no
>>> guarantees that the fragmented data will be written sequentially in the
>>> same manner as with a full command. Commit 748dc0b65ec2 ("block: fix
>>> partial zone append completion handling in req_bio_endio()") changed
>>> req_bio_endio() to always advance a partially failed BIO by its full
>>> length, but this can lead to incorrect accounting. So revert this
>>> change and let low level device drivers handle this case by always
>>> failing completely zone append operations. With this revert, users will
>>> still see an IO error for a partially completed zone append BIO.
>>>
>>> Fixes: 748dc0b65ec2 ("block: fix partial zone append completion handling in req_bio_endio()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>   block/blk-mq.c | 9 ++-------
>>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 555ada922cf0..32afb87efbd0 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -770,16 +770,11 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
>>>   		/*
>>>   		 * Partial zone append completions cannot be supported as the
>>>   		 * BIO fragments may end up not being written sequentially.
>>> -		 * For such case, force the completed nbytes to be equal to
>>> -		 * the BIO size so that bio_advance() sets the BIO remaining
>>> -		 * size to 0 and we end up calling bio_endio() before returning.
>>>   		 */
>>> -		if (bio->bi_iter.bi_size != nbytes) {
>>> +		if (bio->bi_iter.bi_size != nbytes)
>>>   			bio->bi_status = BLK_STS_IOERR;
>>> -			nbytes = bio->bi_iter.bi_size;
>>> -		} else {
>>> +		else
>>>   			bio->bi_iter.bi_sector = rq->__sector;
>>> -		}
>>>   	}
>>>   
>>>   	bio_advance(bio, nbytes);
>>
>> Hi Damien,
>>
>> This patch looks good to me but shouldn't it be separated from this
>> patch series? I think that will help this patch to get merged sooner.
> 
> Yes, it can go on its own. But patch 3 depends on it so I kept it in the series.
> 
> Jens,
> 
> How would you like to proceed with this one ?

I can just pick it up separately.

-- 
Jens Axboe



