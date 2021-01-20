Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C3CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C2F235DD
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C2F235DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=37CdJUL3jZzsQXFxpJnegaFMMD2jjH4PLfmxJ0QUoEU=; b=V1UCKeqyNrwmVjTubXqhnCVJe
	vDX8/K0KiGpVaSzTF5tZtfr5CM/n/fwjB2AOYV61FAPe332Zrj3HlPYMG+9nCg4+5KVUxAK+QcjOw
	YQfnle7WecmsqEmzHaNyFJfohZUqGqUZ4O3G8+taYNqpVnjfEPfRDr5kGnnElOAFYaPjHhwvk/O2E
	5Bwwr8FqACrntmLKe9rjw9gXL5MvegJPtVoQu4Mfq5Cz69KIFhqY15cDKkzpuirbifj84AMh5AsyJ
	9/7y/It738HcP82K8drxfWr6/czXlBmlHj7AUdD6rsC1b4MrWwuH1BDenf3G3FeMUI1dQ4kUMijdT
	hm4o2UO9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2L8y-0001Bx-6J; Wed, 20 Jan 2021 21:36:00 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2L8u-0001B1-J4
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 21:35:57 +0000
Received: by mail-wr1-f49.google.com with SMTP id 6so17211968wri.3
 for <linux-nvme@lists.infradead.org>; Wed, 20 Jan 2021 13:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RMWtoZPt0wXfqvcUtOgF62hYIMnKD6ziI7A2LuBMA94=;
 b=Ix7MgQy6afCP100V6tDXas0+StrLX1qtpXXCt0IbPSJhy5VN0S7FW7BV332wPzyhKv
 CORUzpfH8SKw4cGcStw8qlaxMQu89dZUHpgNwGa57R7IF1CdRCmii9+BDSxza1LAmGaM
 g/dITCTV5T4Vwvahs2+1FwLWPpBDf6OCXVDYLNJ3oTF7L1+hCOkSzwpVOM9yO7Mq5eNS
 Hd3/HbUjFYqyLIsRAtXf4kTvRMncSm27HBNyQ5IGtrtq0UmUfSFpMQnEJrNZV1xYLp9j
 LWkPBObWcXJWKAm2jDwGm/pmsldLhvGVS/ecAD8b+4/ivAld4LnCbmy3uNYlvYFrY1CU
 l8pQ==
X-Gm-Message-State: AOAM530GB7YCns9M8L6Kr4EhC8C5flC38IL4L5ldmzZRVBcy8zwIiWrU
 dUDfHwg1aPmefJYDhrfkmSQ=
X-Google-Smtp-Source: ABdhPJweonrATr5mVR4u9BtfQRUEG6CBbF1U/Z4B5RjM6Cj53fxefwsiaskKNS+Mb7y1XyhJMfeFBQ==
X-Received: by 2002:a05:6000:254:: with SMTP id
 m20mr2810019wrz.300.1611178552579; 
 Wed, 20 Jan 2021 13:35:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a0fa:6c02:3a4c:3368?
 ([2601:647:4802:9070:a0fa:6c02:3a4c:3368])
 by smtp.gmail.com with ESMTPSA id b132sm5924493wmh.21.2021.01.20.13.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jan 2021 13:35:51 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
 <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
Date: Wed, 20 Jan 2021 13:35:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_163556_643194_5869131C 
X-CRM114-Status: GOOD (  26.90  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


is not something we should be handling in nvme. block drivers
>>>> should be able to fail queue_rq, and this all should live in the
>>>> block layer.
>>> Of course, it is also an idea to repair the block drivers directly.
>>> However, block layer is unaware of nvme native multipathing,
>>
>> Nor it should be
>>
>>> will cause the request return error which should be avoided.
>>
>> Not sure I understand..
>> requests should failover for path related errors,
>> what queue_rq errors are expected to be failed over from your
>> perspective?
> Although fail over for only path related errors is the best choice, it's
> almost impossible to achieve.
> The probability of non-path-related errors is very low. Although these
> errors do not require fail over retry, the cost of fail over retry
> is complete the request with error delay a bit long time(retry several
> times). It's not the best choice, but I think it's acceptable, because
> HBA driver does not have path-related error codes but only general error
> codes. It is difficult to identify whether the general error codes are
> path-related.

If we have a SW bug or breakage that can happen occasionally, this can
result in a constant failover rather than a simple failure. This is just
not a good approach IMO.

>>> The scenario: use two HBAs for nvme native multipath, and then one HBA
>>> fault,
>>
>> What is the specific error the driver sees?
> The path related error code is closely related to HBA driver
> implementation. In general it is EIO. I don't think it's a good idea to
> assume what general error code the driver returns in the event of a path
> error.

But assuming every error is a path error a good idea?

>>> the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq will call
>>> blk_mq_end_request to complete the request which bypass name native
>>> multipath. We expect the request fail over to normal HBA, but the 
>>> request
>>> is directly completed with BLK_STS_IOERR.
>>> The two scenarios can be fixed by directly completing the request in 
>>> queue_rq.
>> Well, certainly this one-shot always return 0 and complete the command
>> with HOST_PATH error is not a good approach IMO
> So what's the better option? Just complete the request with host path
> error for non-ENOMEM and EAGAIN returned by the HBA driver?

Well, the correct thing to do here would be to clone the bio and
failover if the end_io error status is BLK_STS_IOERR. That sucks
because it adds overhead, but this proposal doesn't sit well. it
looks wrong to me.

Alternatively, a more creative idea would be to encode the error
status somehow in the cookie returned from submit_bio, but that
also feels like a small(er) hack..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
