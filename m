Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF01D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=; b=q6tAIyHHsNHIBJaLqcp73V+8vA
	pE5CnKQxn26KiXSq/vbvkmf9GumVeGmqaxk21oK3z2RbMrCkcsHLOy0hRngzbjlOXfV4OAre5FGt6
	tLGk12kz3Oz4VaH4py0JWjj4ei7+s2E5J48Fcm1s3OS/Ld7xX+BUWa1/0Vwdz1QxjCv3ZoCv819xH
	LprMrp26xyyD6bd5abYtVGoS3I6ClX8umqOdHO33sUhBAbOKRLGOlcwOXIYSW4eC/MsbbVSXchsHz
	QUYzH/2RRxsN7N53TwP4ge1JzbB37nc6F17SqhKiEaJQveCDOhS/D+wvBapaxFqWiY5y2XBJTuMW0
	2LHfjxIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC2AX-00000003t98-1W5U;
	Fri, 15 Nov 2024 19:39:49 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC29a-00000003srd-2nMK
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 19:38:52 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-20cceb8d8b4so13809395ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731699529; x=1732304329; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=swWUo1rS5NpoE+hCTTmzQV5abyccA9ScvoANpwUKoeAhUfyyBmWUfleNH7+eqg9YG2
         rGXn3bGGMH2TOCcpxm7s5oFw9EP188v+wKqMpOyaFDvhOunGBAw+V9t9q9samKG+TBTM
         RoWLg3G4+I1nNIFBs6mwGkXvMDIj+x8ZvwYf3GlnTd4wfPCd/BlYgTX+QeaNYvAt9qm7
         D9815d0GoJo5wx8/uK8VdyLe9jugtNtWUrFsiKm+MSJaFuS6LgqkQxd4LuVjdXS63BZK
         DiozwZWbnFbe5mf3IoiNu0gDfz2bzyz22U+eES4gAfA5aCa3RQOOYEkGkmFHV/kbJsce
         2e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699529; x=1732304329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=BaKVMv2jwjX4UNfk9HJ7Va1uhgiPcfK/0Gd8kT/mfcaUj+b1S4k1/5isY/5Gd+yALY
         uhbZ3tqj4tEjDYWEw84Ukfz4tGeGfEAjVE0yOCh6+NzDNC2fvtqaB9u4yY8vnIXJVoz9
         +2cHFQ+H7lWIDSag6Wi+/RlR28f1ui8WgCtnoHq0uwTTZsJSMalJfjSwKlybNxfZARj6
         QgMf4RJzb+cHWzwDh6kdgP35+XpG0dRf4NLB4a93X500rCsiZP/UXFCaHO73sXukQlmS
         bKaQhH6O1iO/wziZ994n7lCWcHXwSz7tEBBmViUMXe0uGeh5DbTkeDZxbA3GCG1TjW3N
         eXYg==
X-Forwarded-Encrypted: i=1; AJvYcCUQejkd7PclEny6W5RJa/FYkLPQJjxqpJaSmovQooz6SOD/R/s6nbU84PF4/JCx0lRdjbc5MUYqmr9H@lists.infradead.org
X-Gm-Message-State: AOJu0YyiAUqjvcB4ZDACZU6sqGnlwsB3fLdGONBuBB32RvGbIebywlNQ
	3aWHL7ehivHg1wOLKGEyVzYMfcjHVLcUzyEj/1kxnP+76I5Dh2OGgpmeJEITXJw=
X-Google-Smtp-Source: AGHT+IES54wrZ5hHWz7YLdSu6vOgOr+rIrH779oUdaufOW3TN+xRLH1Q3Md1D//toQnJHNLrz6k4hw==
X-Received: by 2002:a17:903:1248:b0:20b:831f:e8f7 with SMTP id d9443c01a7336-211c0f21d06mr109893485ad.11.1731699528961;
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c04e3sm1791549b3a.102.2024.11.15.11.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Message-ID: <be0d06e4-a61a-47e3-8d50-f37f9b6fc719@kernel.dk>
Date: Fri, 15 Nov 2024 12:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
From: Jens Axboe <axboe@kernel.dk>
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
 <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Language: en-US
In-Reply-To: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_113850_969230_9EBAFA65 
X-CRM114-Status: GOOD (  18.66  )
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

On 11/15/24 5:49 AM, Jens Axboe wrote:
> On 11/14/24 1:11 PM, Nathan Chancellor wrote:
>> Hi Christoph,
>>
>> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 65f37ae70712..ce8b65503ff0 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>>  void blk_mark_disk_dead(struct gendisk *disk);
>>>  
>>>  #ifdef CONFIG_BLOCK
>>> +struct rq_list {
>>> +	struct request *head;
>>> +	struct request *tail;
>>> +};
>>> +
>>>  /*
>>>   * blk_plug permits building a queue of related requests by holding the I/O
>>>   * fragments for a short period. This allows merging of sequential requests
>>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>>   * blk_flush_plug() is called.
>>>   */
>>>  struct blk_plug {
>>> -	struct request *mq_list; /* blk-mq requests */
>>> +	struct rq_list mq_list; /* blk-mq requests */
>>>  
>>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>>> -	struct request *cached_rq;
>>> +	struct rq_list cached_rqs;
>>>  	u64 cur_ktime;
>>>  	unsigned short nr_ios;
>>>  
>>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>>  void bdev_fput(struct file *bdev_file);
>>>  
>>>  struct io_comp_batch {
>>> -	struct request *req_list;
>>> +	struct rq_list req_list;
>>
>> This change as commit a3396b99990d ("block: add a rq_list type") in
>> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
>> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
>> out?
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 00212e96261a..a1fd0ddce5cf 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>>  
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>> -#ifdef CONFIG_BLOCK
>>  struct rq_list {
>>  	struct request *head;
>>  	struct request *tail;
>>  };
>>  
>> +#ifdef CONFIG_BLOCK
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>>
> 
> Fix looks fine, but I can't apply a patch that hasn't been signed off.
> Please send one, or I'll just have to sort it out manually as we're
> really close to this code shipping.

I fixed it up myself, it's too close to me sending out 6.13 changes
to let it linger:

https://git.kernel.dk/cgit/linux/commit/?h=for-6.13/block&id=957860cbc1dc89f79f2acc193470224e350dfd03

-- 
Jens Axboe


