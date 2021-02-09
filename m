Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68546C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:10:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0022264E8C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0022264E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9Scx1CaMfd8kzAIh1AF6u8S5DBdii3qHdVVtPygi/Lw=; b=QizUQ45/dJ9EWCcIwQ+vaCQ+y
	T/1btfaVn0YNVLO1NXyg1XHQQYTiiqaUIftQQpetfJxAoQiDIWiav0KlGvGwkd+M2Ur8fTdX8xEsy
	KYz52EJqmy6/bkg1KDnIaQTQyMk5+S2ojWeM4TlW64PMsLdQsCD4IDUCG6NLYE7kCQ7kQIWofKdkJ
	8X/ueIq+6uOlMo7F73x6TLVeFYtm1Jh+eKWNc5MWq8rdUhg2tem8yQc4r/F2btAm1y27+dcrt+b+a
	YdaVOAuJel0JTSsboIYRRUF/fwkzHhUVcpA+x1aSePDKSdVnDK+CUY06FBkyp1G1LmidaJNKB9Y95
	rPnhLnr5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9PyA-0004Qw-3O; Tue, 09 Feb 2021 10:10:06 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Py7-0004QQ-Ej
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:10:04 +0000
Received: by mail-wm1-f44.google.com with SMTP id o10so1376638wmc.1
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=seCJL4De3neOYVSF2iF0tKojHKwJFoTAHwmEK2t1MYg=;
 b=rYmWyXroAj78d2L+uKmL4pLohhJROxDkwkLl9JOPHFER14lEzLmvJYMLxytV93okWY
 kvjLKhWndcAtsBW2bmmNizyqaX9ixlpsDuUNGFHOHDAg5KFc9wcmHXQOow7RTYCGVPYO
 moKEXq/M38qgQzA0hzSPX7dIshPaIBeWTwbGecYxiS7KrNOOtlXMpReZSd5Lr8s6kpRK
 3WmhBmT/JzVBH2JUN9tQPrZc+y2KH8RY2myZJDMy3UEDSJjYKegiXFCI+hw5zW89AO2z
 wq17RRiHONceKllhnIgTViuVua13z1glLjqB9OlzvGKoW8J9n0F2E/9T50VVmr+z2LOz
 fITQ==
X-Gm-Message-State: AOAM5336kN5NZvjQ3XtzWdU7WFC+z2MoyuLeg/lrvAHimZCkA2ZWoc6f
 LCjc7QoZ8dWsUC8NOB57JF8=
X-Google-Smtp-Source: ABdhPJwtm8lds5Xze0+ZHbvcE7HPSL8nzJOb3kUykUXJntGdvhWHTvVdt3w9XMXHDgdm0ZyvErtqJA==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr2716398wml.118.1612865401970; 
 Tue, 09 Feb 2021 02:10:01 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id x4sm493681wrn.64.2021.02.09.02.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 02:10:01 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590> <65F086AF-DDD7-46B7-9134-3E6B577E75A6@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92b6d55e-1a29-c5f2-f60c-0d1ac904dd4f@grimberg.me>
Date: Tue, 9 Feb 2021 02:09:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <65F086AF-DDD7-46B7-9134-3E6B577E75A6@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_051003_522941_54DCBA0A 
X-CRM114-Status: GOOD (  19.18  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Rachel Sibley <rasibley@redhat.com>,
 Yi Zhang <yi.zhang@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>,
 CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Yi, can you try the following patch?
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 881d28eb15e9..a393d99b74e1 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>>           offset = 0;
>>>>       } else {
>>>>           struct bio *bio = req->curr_bio;
>>>> +        struct bio_vec bv;
>>>> +        struct bvec_iter iter;
>>>> +
>>>> +        nsegs = 0;
>>>> +        bio_for_each_bvec(bv, bio, iter)
>>>> +            nsegs++;
>>>>           vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>>> -        nsegs = bio_segments(bio);
>>>
>>> This was exactly the patch that caused the issue.
>>
>> What was the issue you are talking about? Any link or commit hash?
>>
>> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
>> number has to be the actual bvec number. But bio_segment() just returns
>> number of the single-page segment, which is wrong for iov_iter.
>>
>> Please see the same usage in lo_rw_aio().
>>
> That what I have suggested but I've also suggested the memory allocation part which Sagi explained why it is better to avoid.
> 
> In my opinion we should at least try bvec calculation in lo_aio_rw() and see the problem can be fixed or not, unless reverting the commit it right approach for some reason.

I'm trying to understand what this is, but I'm failing to reproduce
this. I may ask Yi to add some debug code for this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
