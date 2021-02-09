Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA7C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:36:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8DD64DA1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8DD64DA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Cuf7MgrLeO+iV3K9rsysy8zFfBHlg1hvQiRyQRQdbJk=; b=YvuoiqxPtsa5HnTp3ydtavVCg
	06qVLmy6OskuCkEIGZIS8WUYDDD1tFE749A5GUlupVGejBxzN2pZXvpRGOSpstWQ8krPfdJQp+YUX
	7E+qDOV1bvhGfGS26iQViaJlIbM1nP/I6qr6VrCSDpKrdOqxtxmE9Av3LZqyLPLbUGXk4sozsLp1f
	jH8X22nr6g71VuLXjp+y5evXESq1OwhoulsjwOnsILY/6K3iREYn+Tu2GFute/yFLksupZwhWsPk5
	rzldtwxPe4nN/oJWQNE2B+N4mU48qa3ZoxheC0xfAa2yaLhmbfwGb5OPxUs28q1wbpHzl7jz6PfFv
	xiIRAggBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9QO2-0000Z0-PO; Tue, 09 Feb 2021 10:36:50 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9QO0-0000YE-JP
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:36:49 +0000
Received: by mail-wm1-f45.google.com with SMTP id 190so2607927wmz.0
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G7RII3tGzt7cobOVI6BO3Z3WndxhaneB61QTbfXxx+g=;
 b=MpUrf1K0/poP32OQtIg5qisVabW60AfWLHDXZLT10/rjKVwlW2rzDNTL0POUrcQcA2
 +G+HHaI5iVz+2puAZTkJ63QaM2S+Q+KjU409p4WOpAG30cXRvvtle2NimSgowJUgmyOx
 gzpvJYfxhUubfd+7ipOfVK3i1mCNhgePRsMtfCuDI19ttVMaVahQYn67c8htv7XdDV+Z
 d2M6exAmBoAJ8A7DCeD4teD8bcOjalS20YPRidbnNhZ4eTsDEsSL0/3qs+t0wg6A/+fD
 51rBBW6Zq65XxoCw+To+P6N8SZK3c6GOFnETsSOjsEtiF5sxQaU+1EkojPnNsOtopaKU
 tTMQ==
X-Gm-Message-State: AOAM5303EVjLubMS4PS6z3BxtqOIch0wUUWPzEZv5PSstMpKgzl6EKdb
 eomTzvh0oOOctK3txIcKLY0=
X-Google-Smtp-Source: ABdhPJy3UN4iZqwMRSfjUlyf3puxsRHJs098AQpGEs6HysSjDaCYUb5/+Vv2BshkWgMvPdLWxamczQ==
X-Received: by 2002:a1c:c288:: with SMTP id s130mr2791302wmf.125.1612867006961; 
 Tue, 09 Feb 2021 02:36:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id q19sm3960697wmj.23.2021.02.09.02.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 02:36:46 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590>
 <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
 <20210209103300.GA101814@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7caeb8fa-94cc-89aa-94ec-da084491cc04@grimberg.me>
Date: Tue, 9 Feb 2021 02:36:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209103300.GA101814@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_053648_659654_A03A1D6F 
X-CRM114-Status: GOOD (  26.24  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Yi Zhang <yi.zhang@redhat.com>, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>,
 CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/9/21 2:33 AM, Ming Lei wrote:
> On Tue, Feb 09, 2021 at 02:07:15AM -0800, Sagi Grimberg wrote:
>>
>>>>>
>>>>> One obvious error is that nr_segments is computed wrong.
>>>>>
>>>>> Yi, can you try the following patch?
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index 881d28eb15e9..a393d99b74e1 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>>>     		offset = 0;
>>>>>     	} else {
>>>>>     		struct bio *bio = req->curr_bio;
>>>>> +		struct bio_vec bv;
>>>>> +		struct bvec_iter iter;
>>>>> +
>>>>> +		nsegs = 0;
>>>>> +		bio_for_each_bvec(bv, bio, iter)
>>>>> +			nsegs++;
>>>>>     		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>>>> -		nsegs = bio_segments(bio);
>>>>
>>>> This was exactly the patch that caused the issue.
>>>
>>> What was the issue you are talking about? Any link or commit hash?
>>
>> The commit that caused the crash is:
>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
> 
> Not found this commit in linus tree, :-(

The original report is on:
Kernel repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next

>>> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
>>> number has to be the actual bvec number. But bio_segment() just returns
>>> number of the single-page segment, which is wrong for iov_iter.
>>
>> That is what I thought, but its causing a crash, and was fine with
>> bio_segments. So I'm trying to understand why is that.
> 
> I tested this patch, and it works just fine.

Me too, but Yi hits this crash, I even recompiled with his
config, but still no luck.

>>> Please see the same usage in lo_rw_aio().
>>
>> nvme-tcp works on the bio basis to avoid bvec allocation
>> in the data path. Hence the iterator is fed directly by
>> the bio bvec and will re-initialize on every bio that
>> is spanned by the request.
> 
> Yeah, I know that. What I meant is that rq_for_each_bvec() is used
> to figure out bvec number in loop, which may feed the bio bvec
> directly to fs via iov_iter too, just similar with nvme-tcp.
> 
> The difference is that loop will switch to allocate a new bvec
> table and copy bios's bvec to the new table in case of bios merge.

So in nvme-tcp used bio_for_each_bvec which seems appropriate, just
need to understand what is causing this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
