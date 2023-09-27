Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B026E82CA1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSsR+1pi6WQeL2EDQFz3zRcfKCK0m23CLfBJSoHlrvE=; b=toMajtQiCMHgSgos06FEwcMmH9
	RJea/aCC2QoLlWd+lgNIiQQIpzUL+h9IMXZZO5f4v8TxKctPzqrrQsiw+/6Ler6jeUuco0GIS1w0N
	aAYpcS9b1rTzq3uEvvU/EoiHX+QDBTuAMmFMAsuSHvovg05wBq8JN92hhsILpsyY78lbL82mSac4t
	UKx90QBr8S2cuxHvonJJX26UBRCxiVX9mNCjH+oC34LafMKziCDFbG82AyF3Z0mgez+2xCA6hbV+3
	EPzb0+9BLvOg2PymvAtWXS0/1s4HHSs6+DX/VKSNDDwLxhn4DJw5sFByzHlRQBPJ9eh6jAWHwezUk
	Iz1P6dHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlVzl-001BMY-0D;
	Wed, 27 Sep 2023 14:58:33 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlVzh-001BJx-0b
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 14:58:31 +0000
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so3617760a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826707; x=1696431507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSsR+1pi6WQeL2EDQFz3zRcfKCK0m23CLfBJSoHlrvE=;
        b=o4UCIwU927Q4YrWdqqDljvZuX0uaYBe0u5Sg2oRv+Dj4exD1LrqzIXu/VO+ofTKdAT
         g0vjwxOkmFdUIyJ7i1TYzsbCscxUrsqtHC/fgp1C01EOUB6ZJsPZ/z5j1KW4wwSfw3+3
         REm8RvEKg9xz97PrlqXMMHTyrDE/eTgQzrcOdHWk/RB4ukNqEGH3G/Sx6aG7st9jqJeU
         m4/YaKiTCx0+9XVxLmL5IoMTCELBcV5cebKIjXpviTmc/pe3WEtqfruR/u0HZKu+rieo
         kUDBlYYXOgl3G8Qh8+cVllB/sX3Bl7Alpx/Kr4eSN+pCQ0kdfYf1EoX3es+uQ60uF43d
         n+bg==
X-Gm-Message-State: AOJu0YxBtAB0skN3MBPNssorKEfH+P22QVEn6zyhNdHE5AQaPquVLovI
	/mObTBsr4sVs/9Oz5Mnav17JmBwLqpagdQ==
X-Google-Smtp-Source: AGHT+IG86tHEY7hBTQMQr5XkKqL+5Jm+X4pfckIN3x+QXXUzzY3II3IW3Ycq6P17oqrwzP7idotnEQ==
X-Received: by 2002:a17:90a:eb02:b0:26c:f9a5:4493 with SMTP id j2-20020a17090aeb0200b0026cf9a54493mr2011770pjz.5.1695826706587;
        Wed, 27 Sep 2023 07:58:26 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b0026f39c90111sm3778794pji.20.2023.09.27.07.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:58:26 -0700 (PDT)
Message-ID: <b8e19b94-98bb-4250-bd4e-220851c6825b@acm.org>
Date: Wed, 27 Sep 2023 07:58:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com,
 jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
 <e0bdbbf8-83a6-4ce8-b313-80eab6809b34@acm.org>
 <CAGtn9r=5DsnsEBUpHxCXwE=r5LR_H5jE+w3yDzUYhYhDp_+_jg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGtn9r=5DsnsEBUpHxCXwE=r5LR_H5jE+w3yDzUYhYhDp_+_jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_075829_219068_1A09F249 
X-CRM114-Status: GOOD (  17.63  )
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

On 9/27/23 07:49, Ewan Milne wrote:
> On Mon, Sep 25, 2023 at 4:56 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 9/25/23 09:31, Ewan D. Milne wrote:
>>> +static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
>>> +{
>>> +     unsigned int nr_active = 0;
>>> +     struct blk_mq_hw_ctx *hctx;
>>> +     unsigned long i;
>>> +
>>> +     queue_for_each_hw_ctx(q, hctx, i) {
>>> +             if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
>>> +                     return atomic_read(&q->nr_active_requests_shared_tags);
>>> +             nr_active += atomic_read(&hctx->nr_active);
>>> +     }
>>> +     return nr_active;
>>> +}
>>
>> The above function should never be called from any command submission
>> code path. Hence, I think it should be added in a .c file instead of
>> include/linux/blk-mq.h.
 >
 > The function is only called in one place by the queue-depth nvme path
 > selector in a
 > later patch in the series, so it is called in the submission path,
 > which is why I made it inline.

Hi Ewan,

In order to keep include/linux/blk-mq.h readable and in order to minimize
the kernel compilation time, nontrivial functions that are not called from
the hot path should occur in a .c file instead of in a .h file.

Thanks,

Bart.


