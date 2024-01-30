Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AAFC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 03:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1jVti2joqyTS65nbUjYL0YdL8gkZW92EQbIbMtksFXM=; b=duxdutPW/HBq5OroCS9qA60LSR
	t6fyOYSju+wC/efPQISz2gg8DJA2+jaZ8Po8JcVqiVRanNJbHpRIGO0BuT++8C3gLc5VRewfusNOw
	Ys48WrciuTY7Z4KvjELd2V0L+ZXmWQdDDeBoNMMoSBXUeKJ/sK15TiAdCuK/4l8JE4ug2J0uIQAFh
	O3ZTgKFkQSLPZA6dQhKPT+XkLSUOnclGlKD+CzMQebiU1WaNs/CPiq1sp/l0SwA56yllzKqhY1v9u
	jBviOTaT6J2P1T6tpBR6vH4aaIbln+1oHdLzpbYw2b/ec5uG9vL2YlWP/smGFcPl8/Iqeg5uLde1S
	FzGqRG6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUf9S-0000000FB59-1yQb;
	Tue, 30 Jan 2024 03:51:10 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUf9P-0000000FB4H-40fB
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 03:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706586665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1jVti2joqyTS65nbUjYL0YdL8gkZW92EQbIbMtksFXM=;
	b=nxXppB+dSCzVp60iFy/awt71fb3TkxSHeEBQLMMH+i3WChZ7ujKpetTomw9R5UFf7jxGPs3LWWv2V6JHeafi4XaKzysYWWE9JIAle50Q27naO8ywcWrx0aIRYT7fPOHO8vNiGLexmGOwzuznUlCwo5oV5gHFV1K12ko+czVeypw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.emDEL_1706586663;
Received: from 30.178.83.131(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.emDEL_1706586663)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:51:04 +0800
Message-ID: <304cc83e-72c7-4b12-b2fb-f978e331e813@linux.alibaba.com>
Date: Tue, 30 Jan 2024 11:51:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
 <20240129082256.63239-3-kanie@linux.alibaba.com>
 <37d84d79-6be4-47dc-9f3f-09bb9c5cae82@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <37d84d79-6be4-47dc-9f3f-09bb9c5cae82@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_195108_358592_06466D33 
X-CRM114-Status: GOOD (  13.61  )
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


在 2024/1/29 19:09, Chaitanya Kulkarni 写道:
> On 1/29/24 00:22, Guixin Liu wrote:
>> Add detailed parse of dsm command to make the trace log more
>> consistent and human-readable.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    drivers/nvme/host/trace.c | 8 +++++---
>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
>> index 95572c85b22a..b383d51c1a0c 100644
>> --- a/drivers/nvme/host/trace.c
>> +++ b/drivers/nvme/host/trace.c
>> @@ -153,10 +153,12 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
>>    static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
>>    {
>>    	const char *ret = trace_seq_buffer_ptr(p);
>> +	u8 nr = cdw10[0];
>> +	u8 idr = cdw10[4] & 0x1;
>> +	u8 idw = (cdw10[4] >> 1) & 0x1;
>> +	u8 ad = (cdw10[4] >> 2) & 0x1;
>>    
>> -	trace_seq_printf(p, "nr=%u, attributes=%u",
>> -			 get_unaligned_le32(cdw10),
>> -			 get_unaligned_le32(cdw10 + 4));
>> +	trace_seq_printf(p, "nr=%u, idr=%u, idw=%u, ad=%u", nr, idr, idw, ad);
>>    	trace_seq_putc(p, 0);
>>    
>>    	return ret;
> I'm really not sure if we need to decode idw/idr as I've not seen those
> fields so far
> used by anybody maybe I'm not aware here, but can you please provide a
> usecase where
> you need these fields to be decoded ?
>
> -ck

Mostly we only use "ad" filed, but sometimes our tester will set idw/idr to

see whether any errors have been reported by our target. Well this is a

low-persuasive usecase, but I still insist it's better to follow the spec.

Best regadrs,

Guixin Liu

>
>

