Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA685C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9T++C1dTMrkMN8MIJbFbiCZcd3AFA2TIFQVEMzhTpg=; b=Bls9qLixQQ3c6CGvJD8iVbCjSc
	+xtDWfoSK1RtLYRkyNza2cCqbFTfL/0u+zFGhMVEhtKzMSr6AZqlLIbmaxX+/I1Ti72zvTO5GZRXS
	brIkszQvzFVWQVlpMS5KUhqYnbIbBYDqdZCD7cP3JfaJ6cehvnOrQ8v1PDB3eKSDmN0uoNBOManWO
	2o7BQYb7FjhVbnKbmEDJCfuguPNdkLGrK1+iq0vkRJS3rv1EhI56/Ahgwcj6DzSMuH2ueduxwtMNw
	Fy93vod6bHekXeOTxYtoZkDiNEA2gs52g8DmFwTxGhyOOvj15a+MF2Pac5e/WT+lhxt0i+Yx429au
	oV+O/pUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofd90-008uN0-D9; Tue, 04 Oct 2022 08:19:14 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofd8y-008uLk-5I
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 08:19:13 +0000
Received: by mail-ej1-f46.google.com with SMTP id 13so27216041ejn.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Oct 2022 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I9T++C1dTMrkMN8MIJbFbiCZcd3AFA2TIFQVEMzhTpg=;
        b=Ahc84s4dvkJG5bZG4Zoa7IOB6wcsnk+qrMjuqq8G65B/tlpQ7aqcWZjHdMr4xVDXMV
         ad+HA2J0N5/4D9jcRF6oIHeFcBmNjtSTm8VaXt5V/1gsp3/3E7pZIn+LbxD2ze9dcR4g
         PhFHcf/SF/vj2BvIgjcE6FY99fACcTDElH29TU3QLRGexTCpWQT4F+dofWCkQHdpU+1n
         mxpLcFEzDLWXBVTM6ZfhSZGgmwk76QEE+9E52MITPS/blf7qGqT08TH3QCe+MzLNeu4x
         9PM00j4CF19jubFAn6fHC5rQjC/0DcQVv3APLu/hSR/5miGPl3O3PT4hdG337fYcLFu5
         GU0A==
X-Gm-Message-State: ACrzQf13SVJbyTd06i9ukOYzsZFpB7plab1srbjY7ZAT2pv3ZE9j+YgF
	7rJmwWvM7UPdYzEyy71hIJg=
X-Google-Smtp-Source: AMsMyM6tVzTV2ZQ6B8ODjDNilYUhx+hZ9ISSRb/MrE2RXzOTq2aiu8jq/UiwHAOqYd97Udez3cCvzw==
X-Received: by 2002:a17:907:b03:b0:770:872d:d7e9 with SMTP id h3-20020a1709070b0300b00770872dd7e9mr18037425ejl.272.1664871549513;
        Tue, 04 Oct 2022 01:19:09 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b0074a82932e3bsm3224679ejc.77.2022.10.04.01.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:19:08 -0700 (PDT)
Message-ID: <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
Date: Tue, 4 Oct 2022 11:19:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
 <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_011912_222854_F3F6B1F3 
X-CRM114-Status: GOOD (  19.10  )
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



On 10/4/22 09:11, Hannes Reinecke wrote:
> On 10/3/22 11:43, Sagi Grimberg wrote:
>> Our mpath stack device is just a shim that selects a bottom namespace
>> and submits the bio to it without any fancy splitting. This also means
>> that we don't clone the bio or have any context to the bio beyond
>> submission. However it really sucks that we don't see the mpath device
>> io stats.
>>
>> Given that the mpath device can't do that without adding some context
>> to it, we let the bottom device do it on its behalf (somewhat similar
>> to the approach taken in nvme_trace_bio_complete).
>>
>> When the IO starts, we account the request for multipath IO stats using
>> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
>> in the middle of the request.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/core.c      |  4 ++++
>>   drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 64fd772de817..d5a54ddf73f2 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
>>           nvme_log_error(req);
>>       nvme_end_req_zoned(req);
>>       nvme_trace_bio_complete(req);
>> +    if (req->cmd_flags & REQ_NVME_MPATH)
>> +        nvme_mpath_end_request(req);
>>       blk_mq_end_request(req, status);
>>   }
>> @@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>   void nvme_start_request(struct request *rq)
>>   {
>> +    if (rq->cmd_flags & REQ_NVME_MPATH)
>> +        nvme_mpath_start_request(rq);
>>       blk_mq_start_request(rq);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_start_request);
> 
> Why don't you move the check for REQ_NVME_MPATH into 
> nvme_mpath_{start,end}_request?

I'm less fond of calling a function that may or may not
do anything...

But it is a pattern that exists in the code, if people prefer
it I can change it.

