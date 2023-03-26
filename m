Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49770C6FD1C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2s6cgqtyHQC9upsmEZAwdtb5aFvaLxCWNrBqYDjKU6k=; b=XgfYtlIwgJOnb8Wx/PFgjsz9jC
	j94Y8GA7rAQ6vzOrvRla8rj3Z4YT5TBV8h3J/wu86Yf/kODObHLBzoddvbvlppfftYCUIIabAuuat
	nGON9uNsoZSZeLjxjTH63hFfhfASS0fLHl2CyA+lZzqE3pavD4/Gn6MSO1WMKLWB9LFXwWI8XyI6g
	WR4FHjQ8Hl4dVWW1THK2MT50k15lMc+56BaegI6r2z3Lob8DzX680cPW3mfgAVopNT17AkASE7r2R
	h94/8QfW+mNGxkZrLcZmjHwd1B03+oywxQz3vgO+5P+pzIB3/ywmNWwnxk/SUnGHUupq7XiZoMnq2
	Cr5i5x1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKYX-0087AX-2X;
	Sun, 26 Mar 2023 07:12:45 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKYQ-0087A4-1A
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 07:12:39 +0000
Received: by mail-ed1-f46.google.com with SMTP id ew6so23703487edb.7
        for <linux-nvme@lists.infradead.org>; Sun, 26 Mar 2023 00:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679814755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2s6cgqtyHQC9upsmEZAwdtb5aFvaLxCWNrBqYDjKU6k=;
        b=TrPsbwbZ4ddWPJjZ9uNpoRYoHk11DJoP/wMdwxPUM/smxaUbREtaWj2b75yPM70Zht
         Ti8feCeyD/M6aOEMzgxYawU3EcKRVnbycxV1Jta0gPLaQDLW8oBBdSJavbeWouqhcw3p
         a3ouKcfQ7ZYP1y/J25/GwgEUEyU7iUfuT8hQAqHaoKZRvd7WHEzbwkGD/8MiJM/D+RVB
         YGzUvFOjyYPGikndOsM1q5iTf/VeS6PSy3ZRp7amuPJJFDg4qr9tu3dYBgE5kMBbNri3
         cEih+KckCxJ5VuVjdNKgRqJB2LXVkbcbEOMu7h7Q796z5kyElZeso0vqpFnRSbV0fHni
         CWZA==
X-Gm-Message-State: AAQBX9dXBjt340U//9mVfcd8kg1rb+XTYWkJ3ML6L3mMvxJKl0A5km3d
	gzaZ/r2z1Cq3PxL55BNMiN0=
X-Google-Smtp-Source: AKy350Z59FFbxqYQ3c6FUFkwDSCe0WvmExH2hVkE5OBDnCeIYjbMxg9DNM6zlzenSjxa9M44P7rC2w==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a0 with SMTP id w14-20020a056402268e00b005020ffd74a0mr9556077edd.2.1679814755521;
        Sun, 26 Mar 2023 00:12:35 -0700 (PDT)
Received: from [10.100.102.33] (109-186-69-235.bb.netvision.net.il. [109.186.69.235])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b004fb95f51f54sm13066442eda.12.2023.03.26.00.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 00:12:35 -0700 (PDT)
Message-ID: <9a59298e-bdac-09ad-d648-ae00c55b8653@grimberg.me>
Date: Sun, 26 Mar 2023 10:12:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
 <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
 <ZBx3AI5pothCuvTx@ziepe.ca>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBx3AI5pothCuvTx@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_001238_403287_C331FD90 
X-CRM114-Status: GOOD (  18.62  )
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


>>>>>>>> No rdma device exposes its irq vectors affinity today. So the only
>>>>>>>> mapping that we have left, is the default blk_mq_map_queues, which
>>>>>>>> we fallback to anyways. Also fixup the only consumer of this helper
>>>>>>>> (nvme-rdma).
>>>>>>>
>>>>>>> This was the only caller of ib_get_vector_affinity() so please delete
>>>>>>> op get_vector_affinity and ib_get_vector_affinity() from verbs as well
>>>>>>
>>>>>> Yep, no problem.
>>>>>>
>>>>>> Given that nvme-rdma was the only consumer, do you prefer this goes from
>>>>>> the nvme tree?
>>>>>
>>>>> Sure, it is probably fine
>>>>
>>>> I tried to do it two+ years ago:
>>>> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
>>>
>>> Christoph's points make sense, but I think we should still purge this
>>> code.
>>>
>>> If we want to do proper managed affinity the right RDMA API is to
>>> directly ask for the desired CPU binding when creating the CQ, and
>>> optionally a way to change the CPU binding of the CQ at runtime.
>>
>> I think the affinity management is referring to IRQD_AFFINITY_MANAGED
>> which IIRC is the case when the device passes `struct irq_affinity` to
>> pci_alloc_irq_vectors_affinity.
>>
>> Not sure what that has to do with passing a cpu to create_cq.
> 
> I took Christoph's remarks to be that the system should auto configure
> interrupts sensibly and not rely on userspace messing around in proc.

Yes, that is correct.

> For instance, I would expect that the NVMe driver work the same way on
> RDMA and PCI. For PCI it calls pci_alloc_irq_vectors_affinity(), RDMA
> should call some ib_alloc_cq_affinity() and generate the affinity in
> exactly the same way.

But an RDMA ulp does not own the EQs like the nvme driver does.
That is why NVMe is fine with managed affinity, and RDMA is not.
The initial attempt was to make RDMA use managed affinity, but then
users started complaining that they are unable to mangle with irq
vector affinity via procfs.

> So, I have no problem to delete these things as the
> get_vector_affinity API is not part of solving the affinity problem,
> and it seems NVMe PCI doesn't need blk_mq_rdma_map_queues() either.

Cool.

