Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB53FD6DDF8
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=; b=vz5XVgzf4sfWe/NRqg75brC7C3
	wd43foCFnRWKDk3Os62FqfsPMpaDcKNi4zZrPRJ63Ght4Tq5hg5G6qCn4nv0dsRKWcCjq1Gf8+KhO
	hUfZz7OmFQOuIG54we6e4AAkjYE7fIAswmBGZ7O9PVo3cktTBGi2XSncOg3tDfoOkI2Cupk4EkTDm
	3Fx8oDbRW0opZjj856k9tLzW8ugbG6XChQjX7eWl/gIAILIo9ZJfzerNMeCUzqahlLCoJLoAUm/w+
	Yf8x0Zbs2l2Xws0E0ZEwX7oHXh8cYd6TuhoPy8uv/TBeworkoPd62Kgvi+v4JSuxt4CMzhee1m23L
	jTk144FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBvlX-00000002i8c-2Yw6;
	Fri, 15 Nov 2024 12:49:35 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBvlU-00000002i80-2Nsq
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 12:49:34 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso1290748a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731674971; x=1732279771; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=gdrYfTks0iMvUM1YOiQaFJ++HZTZevpNzpqXfXa/PKiuXnKsNfNmB3qaYnJMuYBwbT
         gm5jM+6dxY5PtPceI7kHP0cKmFY9i3d0ltxt/FBlS4tgoT5igDAZsHJRlJLpZDLcXzWF
         W6c1tBrQfD9QUgJN+zlom4CZUQ/seSdRyf6Lo5F6tQfcL0+6OcAL/mzbjeHNm+tb7q79
         Qh8Mq7lFzLzNTmbAocp1ebmzWKzx1zWGEfLhDY3JQPgVOk0yHw8MdEy3WstMJR52Za+2
         e2JON2baQ+xZKHba1cRFyNaw/lwisdDhHSlApXq+zKT23uZnfZWZQC943QxP3KlMCYy7
         mG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731674971; x=1732279771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=FwbUxvc1zc4XPUGgG53nE1yQtx3IWRav+HS8WPyGpO8FA3IZrqfYi5tq0M897/WTgV
         50H5hLRYFiiaaSUMqlD6Fby0UQDdiKB8VDwjMRyQX6INntLkK3ql976NCNKI6E2UbccU
         o3Ss/dUxJrcX9SobF2NYL6pGWyYxWww79yHrOgw5BTSUprb4l47M5vXvn16N4yFwFKKT
         NYI5q01iNDcyEdwyjn3Xce9MCTkDCZ/o9iLqCgbIkc/b1azjcXRKH8MVNl8/yteJuqRD
         DMQx7vvX6CRWOzxnVuSCHxqxf1VyIitrgx1G4odmhUFlvvOcz239//0Wlb8vFJU0EyYo
         LG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgesuPqv3zK1wdhegnEOlr8ClLFR4oiBmSKMGSrJf9CluRf8or+/aKD5xUhO/P0XUVXvImhhlTF+SC@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9j6YifOUQTHeMqLAh+AMeNnYj1nNYmEY2yHLIgrBuv+FG9Hhi
	yM4dgAZcpcQmES3CGN+M5pbzhEkJWn3slqLg/C+lPDBUbgb4Nz9AxVzNzjPd2U0=
X-Google-Smtp-Source: AGHT+IHLsm4F8XGgt+dNqMlncEMHZaB6TNbve2F3AL5DPq8Q+6a6Bwd0d1gK0LzJt/GKxZcrS9AoKQ==
X-Received: by 2002:a17:902:e74c:b0:20f:b5d1:8805 with SMTP id d9443c01a7336-211d0ca73admr34323225ad.0.1731674971420;
        Fri, 15 Nov 2024 04:49:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34609sm11080105ad.121.2024.11.15.04.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 04:49:30 -0800 (PST)
Message-ID: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Date: Fri, 15 Nov 2024 05:49:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114201103.GA2036469@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_044932_885081_197B53A9 
X-CRM114-Status: GOOD (  21.31  )
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

On 11/14/24 1:11 PM, Nathan Chancellor wrote:
> Hi Christoph,
> 
> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 65f37ae70712..ce8b65503ff0 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>>  #ifdef CONFIG_BLOCK
>> +struct rq_list {
>> +	struct request *head;
>> +	struct request *tail;
>> +};
>> +
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>   * blk_flush_plug() is called.
>>   */
>>  struct blk_plug {
>> -	struct request *mq_list; /* blk-mq requests */
>> +	struct rq_list mq_list; /* blk-mq requests */
>>  
>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>> -	struct request *cached_rq;
>> +	struct rq_list cached_rqs;
>>  	u64 cur_ktime;
>>  	unsigned short nr_ios;
>>  
>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>  void bdev_fput(struct file *bdev_file);
>>  
>>  struct io_comp_batch {
>> -	struct request *req_list;
>> +	struct rq_list req_list;
> 
> This change as commit a3396b99990d ("block: add a rq_list type") in
> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
> out?
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 00212e96261a..a1fd0ddce5cf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>  
>  void blk_mark_disk_dead(struct gendisk *disk);
>  
> -#ifdef CONFIG_BLOCK
>  struct rq_list {
>  	struct request *head;
>  	struct request *tail;
>  };
>  
> +#ifdef CONFIG_BLOCK
>  /*
>   * blk_plug permits building a queue of related requests by holding the I/O
>   * fragments for a short period. This allows merging of sequential requests
> 

Fix looks fine, but I can't apply a patch that hasn't been signed off.
Please send one, or I'll just have to sort it out manually as we're
really close to this code shipping.


-- 
Jens Axboe


