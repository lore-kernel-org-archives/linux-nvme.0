Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D84C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEAB8wH7RODaxSZEgSNpHeJCOEOxRXAyc6C3j1SfBxA=; b=wN5lb/R255RI1bHhW4UxDmvLg0
	k4uh93HGvJvSx1OSfParP7JgPzd8FRNCTSujAugMqBPqnf5XnhRy/s7ta/UFL9k9VoPz0CsIxe0L5
	U+LRBnHK/di5rys9+lwcR2AJtfjpaQfVu85dTQkMu5YBFEI/SItg+bTsUlJ4d4bMD1SLXCLLV/6vf
	vga7YmOjeFOBn7Tuoh2JSD35nyTAGMMjoWjRdaCEogjxXJU/jm/mx0FR8Lt6m6VHt3PxB1oKeBEnE
	2Zm24tr1rNnZ3imiC/jSkb9Zn9wpmCTeheqpVmfHnOL71DMBu5lQlJbj4iPrPdr/xOnsJv/Wtbyuh
	/bRACnuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmhCJ-00HVPy-Ae; Thu, 05 May 2022 19:31:35 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmhCG-00HVP1-7I
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 19:31:34 +0000
Received: by mail-pg1-x536.google.com with SMTP id x12so4371541pgj.7
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ZEAB8wH7RODaxSZEgSNpHeJCOEOxRXAyc6C3j1SfBxA=;
 b=gc0UXxI7Q+lfWYxT1o7dy9a9Pt/3hwfBFDEeuF60JuWDX/yY5Sbd6m5eH2YTD8T/KA
 NMGy6vCTG7hmTan8VG/F/icYR2UahTeapqF24LtgkXBvSlqemWBCH6hRMwRewo2ccqWd
 340H9o7vu2I4MGZng8GXrUoSl+R+ooW2LWvSfa0iyaMJTfZALhdMXKMQ0tTY13iHSg4T
 PfcJ2jN+DbONnkeix+M9Pf11GozqSexcxjFkmIN6gXFZ0M3YOKDy86R4ZXc2hFisYVWI
 lj+4Jt9yvpqsKu6rFNlAYL8hFasdVWj1ZebnJmvayTl1KakvICr/hvERSDNw5wyS4JzC
 g+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZEAB8wH7RODaxSZEgSNpHeJCOEOxRXAyc6C3j1SfBxA=;
 b=fOVCZ3UsIBUXmPrGjIj/9NLciSlv8uTew9WTrlZMRQRQv3OWpIjhzTJH/iebgD+3Kr
 IoSftosfCoX6nLwVOgk0oDdbJvbfq2hX+7nO0GlbrjdoRovji1JZmpA6YU1gFwbdNaAg
 MdAUkDkSf5g0zvMzgYHye4zMQxp0PnZASsPIgIPpJ3Hfom/CS21QdcrcV8N0ZHS89pST
 76KOKqLE01kUeDPgZbGfS6D3xA2fMZH8YRK1dyZNvk2zdPL+0yLWZMTuJgCPzsZzdrT2
 gN1VB9rpoYzo8WhxEywyadMwWZmhwn4S8kM1LO9jZLpLFLLg2FyoxxT9ZCV/fntEuLYo
 etUg==
X-Gm-Message-State: AOAM533FePVsJfvbQ1POZMpjwWPKTmFYFaWHjs5/tqcOrAjktr6uuRGX
 sj8yzwwiGW7tKO9B1uV+YVsRQg==
X-Google-Smtp-Source: ABdhPJwjeiwyGM8boT8FGrOO6e37KkyrsRzio67EZeHbJZ5rsApIS7H40f94mJ8q5n6dEotsAlT1yw==
X-Received: by 2002:a63:f44f:0:b0:3c1:ed4f:b066 with SMTP id
 p15-20020a63f44f000000b003c1ed4fb066mr20583437pgk.334.1651779091408; 
 Thu, 05 May 2022 12:31:31 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 gg7-20020a17090b0a0700b001d97f17f9b5sm5726220pjb.35.2022.05.05.12.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 12:31:30 -0700 (PDT)
Message-ID: <70c1a8d3-ed82-0a5b-907a-7d6bedd73ccc@kernel.dk>
Date: Thu, 5 May 2022 13:31:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Content-Language: en-US
To: Clay Mayers <Clay.Mayers@kioxia.com>, Kanchan Joshi
 <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com" <shr@fb.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
 <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
 <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
 <93e697b1-42c5-d2f4-8fb8-7b5d1892e871@kernel.dk>
 <0b16682a30434d9c820a888ae0dc9ac5@kioxia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0b16682a30434d9c820a888ae0dc9ac5@kioxia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_123132_539425_5BC3F873 
X-CRM114-Status: GOOD (  13.82  )
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

On 5/5/22 1:30 PM, Clay Mayers wrote:
>> This might be better, though you'd only notice if you had integrity
>> enabled. Christoph, I'm folding this in with patch 3...
>>
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 8fe7ad18a709..3d827789b536 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -21,9 +21,13 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
>>
>>  static inline void *nvme_meta_from_bio(struct bio *bio)
>>  {
>> -	struct bio_integrity_payload *bip = bio_integrity(bio);
>> +	if (bio) {
>> +		struct bio_integrity_payload *bip = bio_integrity(bio);
>>
>> -	return bip ? bvec_virt(bip->bip_vec) : NULL;
>> +		return bip ? bvec_virt(bip->bip_vec) : NULL;
>> +	}
>> +
>> +	return NULL;
>>  }
>>
>>  /*
>> @@ -205,19 +209,20 @@ static int nvme_execute_user_rq(struct request *req,
>> void __user *meta_buffer,
>>  		unsigned meta_len, u64 *result)
>>  {
>>  	struct bio *bio = req->bio;
>> -	bool write = bio_op(bio) == REQ_OP_DRV_OUT;
>> -	int ret;
>>  	void *meta = nvme_meta_from_bio(bio);
>> +	int ret;
>>
>>  	ret = nvme_execute_passthru_rq(req);
>>
>>  	if (result)
>>  		*result = le64_to_cpu(nvme_req(req)->result.u64);
>> -	if (meta && !ret && !write) {
>> -		if (copy_to_user(meta_buffer, meta, meta_len))
>> +	if (meta) {
>> +		bool write = bio_op(bio) == REQ_OP_DRV_OUT;
>> +
>> +		if (!ret && !write && copy_to_user(meta_buffer, meta,
>> meta_len))
>>  			ret = -EFAULT;
>> +		kfree(meta);
>>  	}
>> -	kfree(meta);
>>  	if (bio)
>>  		blk_rq_unmap_user(bio);
>>  	blk_mq_free_request(req);
>>
>> --
>> Jens Axboe
> 
> This does work and got me past the null ptr segfault.

OK good, thanks for testing. I did fold it in.

-- 
Jens Axboe


