Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62631C47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qt/2+SNXIcvA3MfMfgQkq31xO863ePjF+QBjZCiPLyA=; b=oMUlD6+rakK3PT1n2D9QUauSaE
	n1vCo5db6Szjh9s8O0yF4dDBJ7eAZsbysycH8BH92oEQ+C+KWuIK/j1S6Nh1tQLlrlQxkeeXPjIuN
	mf0Td3luRpJ+lYYSa5D4YvuF5u4tO4gtAUbKX9OtputzW0FQmFFVSLhBiFbP/oGC1Rk189hcQ1cAx
	bx4JGOClsyxdaKOj35AksCnTIGEklRdlcsVz5xdWWNuPmqwR1o/dZnMyFpxNzJhcmlArmYTFg4jKi
	6JkAie9++L6ogYlLlYv/HHAzymp+Q6jqJWrfc8IJTYVTz6lxU14mnDZcMFPj+URtnnx9mAxVNXENa
	oWAE2CCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUjaS-0000000FitQ-0XxZ;
	Tue, 30 Jan 2024 08:35:20 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUjaO-0000000FipM-3bVK
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 08:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706603710; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qt/2+SNXIcvA3MfMfgQkq31xO863ePjF+QBjZCiPLyA=;
	b=BpSJqk3kxCvM/MbtRwvuxxtgb3zOgC59MEHodTQ/FCbNByUlfpYlAY28TsyR4bX6CvqI+aDbOcDt7rSekRHVadcQ95IF743vxtPkPf87+oDD8PFiufcKkOQEKOe+H1xProKfMAHCcxi4z5oasoM3W9FQ3THfr++AhgDkNsGEtrg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.fcLEx_1706603708;
Received: from 30.178.83.131(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.fcLEx_1706603708)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 16:35:09 +0800
Message-ID: <001961f4-8983-4145-ab5d-4451f9115646@linux.alibaba.com>
Date: Tue, 30 Jan 2024 16:35:07 +0800
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
 <304cc83e-72c7-4b12-b2fb-f978e331e813@linux.alibaba.com>
 <93da3b09-7cb6-4e5a-b5b0-ced7a8542c1c@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <93da3b09-7cb6-4e5a-b5b0-ced7a8542c1c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_003517_652841_B534C9B1 
X-CRM114-Status: GOOD (  12.86  )
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


在 2024/1/30 16:05, Chaitanya Kulkarni 写道:
>>> I'm really not sure if we need to decode idw/idr as I've not seen those
>>> fields so far
>>> used by anybody maybe I'm not aware here, but can you please provide a
>>> usecase where
>>> you need these fields to be decoded ?
>>>
>>> -ck
>> Mostly we only use "ad" filed, but sometimes our tester will set idw/idr to
>>
>> see whether any errors have been reported by our target. Well this is a
>>
>> low-persuasive usecase, but I still insist it's better to follow the spec.
>>
>> Best regadrs,
>>
>> Guixin Liu
>>
> But why ? do you have a valid implementation that shows clear benefits
> for idw/idr ? if not I'm not sure why we need to decode these fields,
> unless others think it's a good idea let's not do that.
>
> Following spec only makes sense where there is a valid implementation
> for the fields we are printing and not sure if it applies to idw/idr ...
>
> I'm fine with AD and NR they are useful ...
>
> -ck
Okay, it will be changed in v2.
>

