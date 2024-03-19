Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1C6C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Mar 2024 03:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlpeMeWbBEKJa6ztIT5qPZxiwhxmFPyDGi0Nk8AR7Q8=; b=KcJQieoF1r3FOWnT+OSFydNyt6
	6URIDJ0wRT+ts8id0n01BrqYRlY7lrzaKAAEVO6QwsxTrtXC11NtVxAXA9EB09SUnsD2H/Pkg4K40
	1U5WUEXorPMg1pbElIhPyu9lvF6f+uacK7GjhQl23sdITlYG3jzYOtKrpm+XweYkYqjvMBPK50MDI
	0nZzaV1ThJc457C8uURr6enWYsMCJ2riVZG0vZ/aYnoMPNghaPoC7U4MyYACNbm3gJqTkVLYoKxYm
	EYBckTHNSbWOqqDuHBWWcS1oMtt2f5NbH8150+0JDt9Qs7U2QzRXc4V/zHMZYbX7Xu5vXszfqgkBW
	UvkmLqtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQ1M-0000000B3iK-359b;
	Tue, 19 Mar 2024 03:20:12 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQ1H-0000000B3h9-1kBI
	for linux-nvme@lists.infradead.org;
	Tue, 19 Mar 2024 03:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710818396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rlpeMeWbBEKJa6ztIT5qPZxiwhxmFPyDGi0Nk8AR7Q8=;
	b=Jr1tGqvFMbeSz9vMITWs9l+FDeRrwdPuUbGRaHm+noJzm6XGpgmOb9Hf+8WxoZfii6x555UJ2jtzs7oMk46UnD5TI6kWKVGYLAkfCR/NMD/kJWpm/PeQag80f+TvLAK9r4LQh/7ajLXouBoil7sTHrT2WMkIUTK206dklSXjSCs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2r9a4u_1710818393;
Received: from 30.178.91.42(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2r9a4u_1710818393)
          by smtp.aliyun-inc.com;
          Tue, 19 Mar 2024 11:19:54 +0800
Message-ID: <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
Date: Tue, 19 Mar 2024 11:19:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
 <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_202007_964849_8745976F 
X-CRM114-Status: UNSURE (   8.91  )
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


在 2024/3/19 10:59, Chaitanya Kulkarni 写道:
> On 3/13/24 19:03, Guixin Liu wrote:
>>
>>> Didn't say this is actually in use, but a use-case that would benefit.
>> I will add a TODO-list to research main cluster softwares
>>
>> to see if this is actually a significant use-case, after my patch merged.
>>
>> I'll change my code then.
>>
>> Best regards,
>>
>> Guixin Liu
>>
> so which one is the latest version I use for testing ? I want to run some
> tests so I can provide reviewed-by tag ...
>
> -ck

I am adding a per-controller percpu-ref to ns to implement 
preempt_and_abort, the v9 will be soon.

Thanks,

Guixin Liu

>

