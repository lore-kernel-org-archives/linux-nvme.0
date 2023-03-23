Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9874EC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5eaU9UI5gNRoVJmBelB0AByjFrGD8ImlIIGOOSTiYM=; b=Vd7Vm0qnWuXpoD8fKcOuuhWC/N
	Z4pILWrmBavFq+N5ppB+7vMCsCxrOhjeAzUfrsvMf4bsU8zDe3fB/8IL8Fs+KwsUQskNef9TfTx3j
	9rYqLYJ4lMVc42Fli9Xm2IWAuQUVtIt2CwpPr5H0mEZ11n9NFqdlJ3ZmtuMBOJJ+vNR54afjq0A6f
	6nwQ2TDkSocUStRTk7caoeRWWaxO5HftcMC/Tq46Acd5fBH8YnazKHYmLUvCL+90MX8VF07PLENoO
	XoroKg73/or353RXiQc3bj3xUNFOb8+Vr9kbeQ+gtI+kY3crfcJegdNxAcKT6MO/oRG01XyfFevl8
	MW1PseOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfMXR-002J2v-1v;
	Thu, 23 Mar 2023 15:07:37 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfMXJ-002J1g-0z
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 15:07:33 +0000
Received: by mail-wr1-f50.google.com with SMTP id v1so14774839wrv.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 08:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584046; x=1682176046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5eaU9UI5gNRoVJmBelB0AByjFrGD8ImlIIGOOSTiYM=;
        b=lXzf3ptJCM6BjCqxNm9ingkgDVFp6mXWF++F0G4Df8Fs+kMOhGFKdDRD3BnTHVEPKY
         fRSSdmUEBtNnJsqUNwXrVf+PhEh1ArWlJn8q3nNgOLusiaGb/iFOxtlHDIfK2echBn/Y
         bvu6YEaUqWuRVI9EndBRiaiWz8OS7IsimZEp/uJVZvNoE5iDUb+0m/EZgF/TmPGWyj3M
         IymtxjFEyRKEDI8mNTVWCTnN87vt+03SqytS8ZkVQJhYgdEIwh7ciPSiJJqG4W6h1mbn
         bP1WymV6zMNqA+HDJX8/nY7RU2wBpn+EIx5nLY9kL4ZTa10q/uOt1h3gkSsZDk7Zsw3W
         BC4g==
X-Gm-Message-State: AO0yUKU9/s74QBSJXqp5OpfZAx1VREpwKnAZdoWeG0ndM/qtcu79YBrb
	2x9S8CJw4QBtMmcuL6bHllw=
X-Google-Smtp-Source: AK7set+e4miZKSYP825PLpvWVYToMLQ9zWrZumdjz4czNzXkEklOqiRp4QzdYZS+q2IQIUtyJryFSA==
X-Received: by 2002:adf:f681:0:b0:2ca:ab68:eff9 with SMTP id v1-20020adff681000000b002caab68eff9mr6178292wrp.7.1679584046480;
        Thu, 23 Mar 2023 08:07:26 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y16-20020a056000109000b002c56013c07fsm16215088wrw.109.2023.03.23.08.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:07:26 -0700 (PDT)
Message-ID: <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
Date: Thu, 23 Mar 2023 17:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBxOHZwre3x8DkWN@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_080729_340358_B5841A79 
X-CRM114-Status: GOOD (  18.98  )
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


>>>>>> No rdma device exposes its irq vectors affinity today. So the only
>>>>>> mapping that we have left, is the default blk_mq_map_queues, which
>>>>>> we fallback to anyways. Also fixup the only consumer of this helper
>>>>>> (nvme-rdma).
>>>>>
>>>>> This was the only caller of ib_get_vector_affinity() so please delete
>>>>> op get_vector_affinity and ib_get_vector_affinity() from verbs as well
>>>>
>>>> Yep, no problem.
>>>>
>>>> Given that nvme-rdma was the only consumer, do you prefer this goes from
>>>> the nvme tree?
>>>
>>> Sure, it is probably fine
>>
>> I tried to do it two+ years ago:
>> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> 
> Christoph's points make sense, but I think we should still purge this
> code.
> 
> If we want to do proper managed affinity the right RDMA API is to
> directly ask for the desired CPU binding when creating the CQ, and
> optionally a way to change the CPU binding of the CQ at runtime.

I think the affinity management is referring to IRQD_AFFINITY_MANAGED
which IIRC is the case when the device passes `struct irq_affinity` to
pci_alloc_irq_vectors_affinity.

Not sure what that has to do with passing a cpu to create_cq.

> This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
> creating a CQ on a random CPU then trying to backwards figure out what
> CPU it was created on is silly.

I don't remember if the comp_vector maps 1x1 to an irq vector, and if it
isn't then it is indeed obfuscated. But a similar model is heavily used
by the network stack with cpu_rmap, where this was derived from.

But regardless, its been two years, it is effectively dead code, and not
a single user complained about missing it. So we can safely purge them
and if someone cares about it, we can debate adding it back.

