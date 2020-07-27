Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 20:38:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7872074F
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INePXRqB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UusocTr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7872074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bGLjwwrkX6lQDuNw5gqv3kdYOLtIFJxyC6pB2mq1hZU=; b=INePXRqB6QGOfnQeyUU8arOgf
	ZIMl6RHV8nVDeaZmI+reVuoUHhAGsZmetEZ/hoC4UDU0gqTH4rR8UETPKMvZxKDDFXjeTNS8UlbAE
	3BxrARyd5NktrCW1o+V/R9eDXoaL95QFaoiP6ugEjhuUkbElNOnRX6WE0Kzyo3jIPyfbZjBpXf4EU
	vxg1Xi3hX0zljWn5SIUbFk1hvczPCXRQn6Bpi1Fq8h6u+zbUSKjnaV2s+ku6K/XGqGSpoumRcmIxB
	Jzd64JSSSRtG+OYIUUICGY0HVetpXD/VF/r29H09HQT13fMrymyUezbTnMXRMeroBiypJMNpMlUs4
	f3B4VCEgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k09sh-0003z2-QX; Mon, 27 Jul 2020 20:37:55 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k09se-0003yF-2V
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 20:37:52 +0000
Received: by mail-pg1-x541.google.com with SMTP id d4so10603887pgk.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BoMGSFrK6JuNKJj0yzQkT5G/Ydi9HB5iMMp3B/Ar/NU=;
 b=UusocTr6Wn5ya8x5g7nFGEyJc8UZUmDNAQgB4983QxdSzLkqYvlSLtF2vuYsjVUBuF
 YeCgKhKyqgnSJor+vuG2KxcGmaJ502UTwJK0KF0mycK94hP+HQMYA8e2suKl2DJj0hCs
 tkIP0bkQapW8XcBilA9KV8IBiZ6nbKwyltEefHGBx3KH6aQOkM72342mcVy9aosHAv07
 BBGvWLv6cLA2dwMV72X6L6PlOuDbdQ3OC4VAFwgLLYzb9Ajneu/+Tr2XkuTJkXxI+6hJ
 okuUT1br2bAM9KD2ATd90v/FLIyT1TUwa7on7pSArJfS1OJtzxpD0Uo/h32x2/V5jdYm
 C3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BoMGSFrK6JuNKJj0yzQkT5G/Ydi9HB5iMMp3B/Ar/NU=;
 b=EXuhBX1beKYBZGxv/Gg18EcARTIdgQmDqGgNn2l4etoUEIawXvb3xGVgsEMhxCvaJF
 5+BZW6gA8bHGK8WBcIuGzYyJiFaAE1NZsg192xzxrATJa66x/NKJAvFCxWgKMFqKLmeg
 qnfVzGVcR2EqbyXncBrTZWw0VsyABWCgNWgfLhV7etDuXPlUmpP8iFW/LON183O+hrG4
 czRLWGmIUkOyma97iPW/Qcfvf85lPe/he3U4QI6swtxfcaIEvSPeIc/tPFLL7Krbl7tw
 XX5UNuDAo4A4V5RCVKb0XBWP/PNOWvAgOcwYvUmZNrBmgxhY5gvJOh3sgEiXBvSpJ+lz
 rh7Q==
X-Gm-Message-State: AOAM530iyRRrA6yT004tfQ8A2I9sS1FDe9vbGqtLGVe72hWFuFZkeCGi
 dAw6DqIRs1KYaiX1H5NQacUQOQ==
X-Google-Smtp-Source: ABdhPJxmez7ADoFSJNVMEcnyiur5YEx6PVUnQDGsz7qtvYp8baQZcPhTa5spOpDdvjAqtsiRJBGt1Q==
X-Received: by 2002:a63:495c:: with SMTP id y28mr21606643pgk.30.1595882270081; 
 Mon, 27 Jul 2020 13:37:50 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id s22sm15056230pgv.43.2020.07.27.13.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 13:37:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
Date: Mon, 27 Jul 2020 14:37:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_163752_159148_32113C35 
X-CRM114-Status: GOOD (  18.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/27/20 12:36 PM, Sagi Grimberg wrote:
> 
>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>> +{
>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>> +
>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>> +				wakeme_after_rcu);
>>>>> +		else
>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>> +				wakeme_after_rcu);
>>>>> +	}
>>>>
>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>
>>> That's true, but I want a single interface for both. v2 had exactly
>>> that, but I decided that this approach is better.
>>
>> Not sure one new interface is needed, and one simple way is to:
>>
>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>
>> 2) wait in driver specific way
>>
>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>> then you may add per-tagset APIs for the waiting.
> 
> Because it puts assumptions on how quiesce works, which is something
> I'd like to avoid because I think its cleaner, what do others think?
> Jens? Christoph?

I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
call that.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
