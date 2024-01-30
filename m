Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDCEC47DB3
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtBEirMuvJtVitc1MdgRC1Zp8gXGZQUySzqgqC/1r1A=; b=ShUEG7FDbNV7lJBUB/o8QRJN3s
	U2aBbzHiatOjM1vqMvkc2L5w/mvbuO2oNwnIFfuWlx7pw4T9cn3ewha+SSF9+5mSC7aPFSyJghaMm
	A42tKT4bq5h3eZKkCZXkbzIjqVRTDMHb3AaN0nRt+Yo6N5BARP5Xe5oBg3ecdp0IwVj9MRKRtNkJA
	vFHkFK6E5IrEoOwdQgyCNrcBs/1SmgOZqLag914xG8C8l0RDGGGFyS33Pfi0LDvbqPrx+DJjvB5Rs
	RpNktON2KjyOcG2jHRoFP7VQUdgJtLEw5YfSkyga/z6ah8uKPBAKwhJphEA/uo0FmR+lDhCw9xGNL
	ZusiuHdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUewn-0000000F9EF-3R0T;
	Tue, 30 Jan 2024 03:38:05 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUewk-0000000F9Bq-2muH
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 03:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706585879; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dtBEirMuvJtVitc1MdgRC1Zp8gXGZQUySzqgqC/1r1A=;
	b=c68scaxvaAryt9D1rlXSrSJWGUA7NqxiB1Iq7Q7ow79Llx2AUV0ByxzjtLdhfvq5AMIg51BvkOcVsr9XGS5qCi0bFnvMG5JTjqQlGqhnYx7Lcm9QWJ9Q0TSUhasMv947WOJqQ1OUGOC/xOeEeBlg6cAPhCUmh67DSB6TpwtetDQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.el16T_1706585876;
Received: from 30.178.83.131(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.el16T_1706585876)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:37:57 +0800
Message-ID: <e09e1b5a-ab6d-497c-9068-3d0bd51becf8@linux.alibaba.com>
Date: Tue, 30 Jan 2024 11:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: parse format command's lbafu when tracing
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
 <20240129082256.63239-4-kanie@linux.alibaba.com>
 <ab356f7f-cc42-4e16-a771-d2eb15a3c449@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ab356f7f-cc42-4e16-a771-d2eb15a3c449@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_193803_177646_C8C19BD9 
X-CRM114-Status: GOOD (  11.94  )
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


在 2024/1/29 19:01, Chaitanya Kulkarni 写道:
> On 1/29/24 00:22, Guixin Liu wrote:
>> Add the parse of format command's lbafu to calculate lbaf.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    drivers/nvme/host/trace.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
>> index b383d51c1a0c..3ccb33646794 100644
>> --- a/drivers/nvme/host/trace.c
>> +++ b/drivers/nvme/host/trace.c
>> @@ -119,7 +119,9 @@ static const char *nvme_trace_get_lba_status(struct trace_seq *p,
>>    static const char *nvme_trace_admin_format_nvm(struct trace_seq *p, u8 *cdw10)
>>    {
>>    	const char *ret = trace_seq_buffer_ptr(p);
>> -	u8 lbaf = cdw10[0] & 0xF;
>> +	u8 lbafl = cdw10[0] & 0xF;
>> +	u8 lbafu = (cdw10[1] >> 4) & 0x3;
>> +	u8 lbaf = (lbafu << 4) | lbafl;
>>    	u8 mset = (cdw10[0] >> 4) & 0x1;
>>    	u8 pi = (cdw10[0] >> 5) & 0x7;
>>    	u8 pil = cdw10[1] & 0x1;
> as I don't see the newly added variables used in printing a trace do we
> really need
> the calculation or a meaningful comment is would work ?
>
> -ck
OK, I will delete lbafl and lbafu variables, and add a comment for lbaf.
>
>

