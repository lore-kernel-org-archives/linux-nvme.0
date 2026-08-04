Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B159C55182
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zRgXT9D1H46CwzKzWLPE98x9YSJbGrnWvNPDfDFR6s=; b=juvI1mtFV6/9ZOlHPtU/prKPDl
	V8bdGKm51DtZapT7jQrNhRjMkn1a23q9GMrT7SXrq1s6rwixzDDoRknPl/VYphd/Tohw7iHRVZjq3
	V1QeaIikZI9uF75fWquaBUUk8ZJSRbi3lsar2oRExW8DeX5pmY7QYnZ40vw8o7gr3czUX6fwRXotF
	Aa+Ipa+ySbwmG6W5FRuCNT0wq7onCVPiAWsOYHoSlScO13t+BQ3kS5lP2ItMgr4mM1l+3/68KcnB5
	vanqIDg8qfwsNsQAhjGbrQ1boitX/uyD/YAQmiu9iKvSR9CJLIW1BgMEv8ub+NPP956zM/Npxnj7Y
	fDfW8+vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4ln-00000000pqQ-3Lwm;
	Tue, 04 Aug 2026 02:20:43 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4lk-00000000ppq-3bxG
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 02:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785810039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7zRgXT9D1H46CwzKzWLPE98x9YSJbGrnWvNPDfDFR6s=;
	b=iUQ7jiVehw7h7y7gdO/t2jqEKsbf4pJk1bcoeAi8+NiADaWGLTDCnqS+B6dmRpHFAYfsp2lMDHLxCxnfhyDGF9d3bEXBUsME7TLMeFf8KMykTUpP0pMXrCyp8Xdord3GbQV+2wjfq2ONUu+oBDz8yHaWAL1qAc1uO11Et9oTGQ0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8MFwKo_1785810035;
Received: from 30.178.84.68(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MFwKo_1785810035 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:20:36 +0800
Message-ID: <a2c9fc27-1cb6-4c12-b62d-724bdffc0197@linux.alibaba.com>
Date: Tue, 4 Aug 2026 10:20:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] nvme: raise FDP placement handle cap to U8_MAX and
 warn on overflow
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
 <CGME20260731032043epcas5p46e85c04297e36291545e0b688ba7f6fa@epcas5p4.samsung.com>
 <20260731032031.1090755-6-kanie@linux.alibaba.com>
 <fe8f6e8c-185a-4089-848b-2c965fed84a8@samsung.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <fe8f6e8c-185a-4089-848b-2c965fed84a8@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_192041_077556_D2553F84 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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



在 2026/8/1 00:36, Kanchan Joshi 写道:
> On 7/31/2026 8:50 AM, Guixin Liu wrote:
>> @@ -2342,7 +2350,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>>    	if (!info->runs)
>>    		return ret;
>>    
>> -	size = struct_size(ruhs, ruhsd, S8_MAX - 1);
>> +	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
>>    	ruhs = kzalloc(size, GFP_KERNEL);
>>    	if (!ruhs)
>>    		return -ENOMEM;
>> @@ -2357,8 +2365,13 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>>    		goto free;
>>    	}
>>    
>> -	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
>> -	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
>> +	nr_plids = le16_to_cpu(ruhs->nruhsd);
>> +	if (nr_plids > NVME_MAX_PLIDS)
> I'd move this check down; after if (!head->nr_plids) part below.
>
>> +		dev_warn(ctrl->device,
>> +			 "FDP RUH status reports %u placement handles, capping at %u\n",
>> +			 nr_plids, NVME_MAX_PLIDS);
>> +
>> +	head->nr_plids = min_t(u16, nr_plids, NVME_MAX_PLIDS);
> And will keep this in above if block, alongside dev_warn(). And kill
> that min_t with a simple
> 	head->nr_plids = NVME_MAX_PLIDS;
>
>>    	if (!head->nr_plids)
>>    		goto free;
>>    
> Modulo these nits
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Changed in v3, thanks.

Best Regards,
Guixin Liu


