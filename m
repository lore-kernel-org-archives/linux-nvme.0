Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F834C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:07:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2C364E8C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2C364E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RKCID9ZrAkhDUJlNc+wUFfkUWS6Gbzr5z2zqhU5Oz/A=; b=FSRB4vbTRMAZbu7LS4XcP4Okl
	x9cyZUIuS3zCCxCiS08+ZMiFW/mUDhMgPA6r1C81aFwMM+NfkTdc5EqhNA0VI+vPApOaGTCWlTrhY
	DVzDxOSeTi6sgZ3gy8J5rOokDHkDDdlU4ctMFIdP9DcpwtPRDRl9BV+CMShReqqdAI4QQuzqccx05
	rJNX3NUHx+Kl0iD1L+35lH7jACTsBd66myNWpuaIw5eKlIdZAjyZWiPWdaf/vRdCcYQ+S1et89vzk
	qA8cNcky/psMzkN9x/QAUKemjRiFhajGjlLrmNC5GYceskH2q1Z4WKoD17jgslZFlqLO4rIov+5S6
	pEWTgkNcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Pva-00047t-PA; Tue, 09 Feb 2021 10:07:26 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9PvY-00046d-7I
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:07:25 +0000
Received: by mail-wr1-f44.google.com with SMTP id h12so4608582wrw.6
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=305GA5Vcg+XCag1vR4Os30JZqIqVXTHehXGnV8UYBqY=;
 b=o+xQ1A/GnW6BBJRAPh858tHyXio1mNhhD3/PinHSlmDS1ktg/Fwhq4gqsExtsEAjRU
 4M0MMh1iD0vBwEAeGKcS3AcYPaIF9f4Oli+vi7zl/FSaBY9yAr7hlQBCE2U/yoPqkspT
 nm/kPzmOnEAEXz+Ul8nDbrErXzultdn7jYgFS1RyJbco8OT7yimtJiLvs3VTqbtuBWm1
 dfLOoZC2KfD6PGg5vxGr083at9n4N3ZExYkmZay6x8jSYcDtaXNUzBWUcQQ2uZRdN7ze
 EDPB0rVuQ8Vj4amiLqsDS/TflsdYzKJmsMF9GOthL6W3w/bBYZ5gLbD4HgSmiFxowoFa
 s7Ag==
X-Gm-Message-State: AOAM532sH9O0GpDlB8COJH5ulFVy/Jx+AQ/8deoafhADSXJOZuvwJVR6
 NDwy9M3uwC3IxYuhkFGk8Cc=
X-Google-Smtp-Source: ABdhPJxtrwVWsKIozf1x9mCf4BNR2dolgCSM9hgMBqNlLRRbn7nB0ORtYYuFngf9E2ABUsf8aX9zeQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr22346733wru.88.1612865240864; 
 Tue, 09 Feb 2021 02:07:20 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id y63sm3690719wmd.21.2021.02.09.02.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 02:07:20 -0800 (PST)
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
Date: Tue, 9 Feb 2021 02:07:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209075001.GA94287@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_050724_303710_62E8ABCD 
X-CRM114-Status: GOOD (  18.65  )
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


>>>
>>> One obvious error is that nr_segments is computed wrong.
>>>
>>> Yi, can you try the following patch?
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 881d28eb15e9..a393d99b74e1 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>    		offset = 0;
>>>    	} else {
>>>    		struct bio *bio = req->curr_bio;
>>> +		struct bio_vec bv;
>>> +		struct bvec_iter iter;
>>> +
>>> +		nsegs = 0;
>>> +		bio_for_each_bvec(bv, bio, iter)
>>> +			nsegs++;
>>>    		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>> -		nsegs = bio_segments(bio);
>>
>> This was exactly the patch that caused the issue.
> 
> What was the issue you are talking about? Any link or commit hash?

The commit that caused the crash is:
0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

> 
> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
> number has to be the actual bvec number. But bio_segment() just returns
> number of the single-page segment, which is wrong for iov_iter.

That is what I thought, but its causing a crash, and was fine with
bio_segments. So I'm trying to understand why is that.

> Please see the same usage in lo_rw_aio().

nvme-tcp works on the bio basis to avoid bvec allocation
in the data path. Hence the iterator is fed directly by
the bio bvec and will re-initialize on every bio that
is spanned by the request.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
