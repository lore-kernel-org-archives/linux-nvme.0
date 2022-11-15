Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94AAC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SeocJqQ4xu3Vc3NPDyKfwxISio+CPGA4GrN7x0A5Hb0=; b=t5IvJ2JZtST1sFRnZakPkQscwF
	VRhHfq0k4+5GY9JSm62nzs6d3hg+Qv+0ykDqpccmFQa/M5SDuNlzAuRuIRofUoJ+XF8fRokmUGDXz
	KqEwHt/gwB/5SNg57iRu+FqAH3PaKFvumCnRxKMb8FqzbE/cpj88G9qSN1y3Ma8cxZHVI79UTZ+GD
	zVlyvBMuE56bIRr5RwuAI2XjBgtOGi88vvhZT47AEtpg1IsH3ztcGU/UY06DG63SyhQICohIIUJjn
	cmz4E5J10CgLsa9jtsfOPU4p0/gmlTbN/KiVU9wwj531Fw2XDL934JL3xnmH9JAeJxEuOtRa9eJsH
	b/H2+d/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1our1B-008tk6-AB; Tue, 15 Nov 2022 08:10:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1our19-008tiS-Bd
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 08:10:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id h9so22880182wrt.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 00:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeocJqQ4xu3Vc3NPDyKfwxISio+CPGA4GrN7x0A5Hb0=;
        b=rHVZyAOGRVyZ1vBUDnvGTgxauULn1B4CYSzcHMcDb7akMxfwboTswPM8oqLk01C1ql
         I/kyaADzbkvAR/48ztOQJL9iDeGbkQ2s/ZoDr43MmumMQjM42vTGB8muHex8CoPLFpSf
         08rkwS6mrh0EdsK3Tc/Il0hZzvWorZu+brh4kDk6HllsHkxswHhqzBQyidkGozHYS3Jq
         Edg8HKSik0rdfDTmSClB2PBDyMcvrXP3TF0qrMWVmcAT1Lplw6EJIwziVbbxN/6MhzXg
         jxs4IjXyV2OPMYSlkLz91i95CTlgY7gQ/SPMaTlqTsB4rrfw+8j13TKXLNaJ55Jh12jp
         Vzxg==
X-Gm-Message-State: ANoB5pk52dVH3w2a+ERDxbvxTR6V1bdqc67kS16TcRtlyBO4lVrBzUNL
	k8kC63gNIeFiNlNUvKVd1hQ=
X-Google-Smtp-Source: AA0mqf6t8LJ/UclUPgUOmWFksiiHRharjWPimiKCxBsX7HmwtlHKTwsNtcPzoyAglLWKeUmc5nVhtQ==
X-Received: by 2002:a5d:494d:0:b0:236:f47c:46aa with SMTP id r13-20020a5d494d000000b00236f47c46aamr10090631wrs.599.1668499799787;
        Tue, 15 Nov 2022 00:09:59 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b0022da3977ec5sm11572661wrw.113.2022.11.15.00.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:09:59 -0800 (PST)
Message-ID: <31916715-193f-ca8b-ff5a-f5a3490dd7b0@grimberg.me>
Date: Tue, 15 Nov 2022 10:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 10/20] nvme-auth: guarantee dhchap buffers under memory
 pressure
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-11-sagi@grimberg.me>
 <73d899af-a934-9692-7704-508d3c5d26e8@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <73d899af-a934-9692-7704-508d3c5d26e8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_001003_431195_0566287E 
X-CRM114-Status: GOOD (  13.60  )
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


>> We want to guarantee that we have chap buffers when a controller
>> reconnects under memory pressure. Add a mempool specifically
>> for that.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>    drivers/nvme/host/auth.c | 30 ++++++++++++++++++++++++++++--
>>    drivers/nvme/host/core.c |  6 ++++++
>>    drivers/nvme/host/nvme.h |  7 +++++++
>>    3 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 4d288333b0fd..4bfe9ecda12a 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -14,6 +14,8 @@
>>    #include <linux/nvme-auth.h>
>>    
>>    #define CHAP_BUF_SIZE 4096
>> +struct kmem_cache *nvme_chap_buf_cache;
>> +mempool_t *nvme_chap_buf_pool;
>>    
> 
> is there a reason they are not declared as static ?

No reason, they should.
If I post another series, this will be fixed, if not this
can be folded when applying the series...

