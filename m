Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989ADC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2960F21789
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BdeasRtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2960F21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hDnAyc39TV10DuKbcKhCKN7hb8ome0rMxZYX53aKsHY=; b=BdeasRtmZ0dRAN0a3eYGwUZX4
	FFK1xqW918sJD1H5ZbQ/nidjv49YOPuRSFcRhy5fIs3O/KGZr6RWcxoh+OuixgfNNaDtjfVQgdvLZ
	jmc1HuiyksDAEiuFZiGeX5Ou1n9digmMCiWFs/o/sHoaxIskujPw5Wgd4WRS+yqMFAwjvE401eKcA
	s3DW6Xre2vjc7cJgjpT0xi6AsrKTlMJYp0wJKlmxgnYZexXgtmATXHm3lxZpx9QSKB2kj02lNoITd
	r5Y3aIiXy+SEzGWDRVssI0b8S0RHkHzmGL0/ZYWSEOnR9g+W+8C8XKOvPw0jp/68i9Td6RwkYWUT9
	0oVrxMotQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQnVH-0008LZ-TG; Fri, 09 Oct 2020 08:11:51 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQnVG-0008Km-7k
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 08:11:50 +0000
Received: by mail-pl1-f196.google.com with SMTP id d23so4095575pll.7
 for <linux-nvme@lists.infradead.org>; Fri, 09 Oct 2020 01:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GmdwN6RgmFBHTx+x7HRiGyQc4DYAkB723WY+/xGkPKg=;
 b=JXf+oIpluuLChu284nGL+39STw7G9MQUrV3d7VMv5MK+5nBs+SpgLpnul3E5BiuRvD
 zU6bp1DicjfCI7QTe2AE4xsjNWeiVPpMCN0grtp2g+gC9G3jRb09/d/gtPofQma+CGM5
 uGSssqUrDIjx14fQMyzicdcGz0Lx8NXctkKNUBVBBsOJwg+VIfYDPLJzvL9Q2Hl4w+Hz
 2iF3HPm7md9cSn2a7wCB8xubCG7yLawxRP+g1g6hGOQmKbyCICTEUuCZyFyFvSakx6UI
 ATWwP2Ca0y9IqgEUFdIDyCkCk/HPyTi5STejmdlMkuLN5qpy9F9FAaZxNrmagkFuxErR
 wnHg==
X-Gm-Message-State: AOAM530nuBzR8pS3rgx8ko7zwcMJ0UPRCjISs/beYanfzvyubxN2TjQh
 uVokTy5zzul41Ww3gZUsIkw=
X-Google-Smtp-Source: ABdhPJyc0AUuDke+a4lSFc9O/N5IzIATMVN7/BoxK6g0Hh5gz99JlcSMPRMl51mzGMzZUgX3EAr6WA==
X-Received: by 2002:a17:902:74c1:b029:d3:effa:14ac with SMTP id
 f1-20020a17090274c1b02900d3effa14acmr10554741plt.64.1602231108852; 
 Fri, 09 Oct 2020 01:11:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e430:c9cb:46e0:d242?
 ([2601:647:4802:9070:e430:c9cb:46e0:d242])
 by smtp.gmail.com with ESMTPSA id x4sm3258254pfj.114.2020.10.09.01.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 01:11:48 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Ming Lei <ming.lei@redhat.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <189a7d80-ff0f-e6b0-f8f0-b50dfdd028f8@grimberg.me>
Date: Fri, 9 Oct 2020 01:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009043938.GC27356@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_041150_284577_B1B29286 
X-CRM114-Status: GOOD (  17.91  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 8f4f29f18b8c..629b025685d1 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>   	if (!blk_mq_request_completed(rq)) {
>>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>> -		blk_mq_complete_request(rq);
>> +		blk_mq_complete_request_sync(rq);
> 
> Or complete the request in the following way? Then one block layer API
> can be saved:
> 
> 	blk_mq_complete_request_remote(rq);
> 	nvme_complete_rq(rq);

Not sure I follow, how does this work?

Anyways, I think that blk_mq_complete_request_sync is a clean
and useful interface. We can do it in nvme but I don't think
it would be better.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
