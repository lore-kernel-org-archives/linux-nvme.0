Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FC7CD98D2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+j/Z0xLhRSjKs5wFvJcX9wYaBPUjY/kyQbPaphO1IA8=; b=xdf8LYc8YaoTnVx044Dpw/HGr9
	P/hTgXbCtP6aeRgDnsq4Q1hF/Ig35b2eliEVasZV0z1af/Or2bc/SCY/vl00ago0KyayRj5ODjX5R
	zzvKaDGCVtiKc7l0kc9dnCSqDO1FJKSbDk0ePNuy96+g+YY/iTYaQ6T5lbUG1GolCkG29sBYTZ88M
	K3AJV4oakdXsCHrm2aeD30Ee3yC7+6If2TjhBsfsEjbxoUb1uZxAanoi4ND/AnWkVh06H/LJZQDqT
	Utg4VVZc7boHZknHeUqPvfldcJ/SCtV2vgBQu4iGLlgqgdvtDHuUq9TV+0TCljErow0bdY7gNuOvn
	IMuFysvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJeA1-0000000B63p-2d7c;
	Thu, 13 Nov 2025 20:43:17 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe9y-0000000B62S-3GYj
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:43:16 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-948673fdc47so60665639f.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763066593; x=1763671393; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+j/Z0xLhRSjKs5wFvJcX9wYaBPUjY/kyQbPaphO1IA8=;
        b=uZz4i52U6ki6/IrthAIi1gZPXG5LZCUORS4sUzv54NNFFNTORkXuIytYiV5BOQoJWo
         BjuDrX608wxIKwql6w05GNyuLYQ39+z++H1XND7VEc3TE1uyPTKOiHn4aQ7Z8gNMxMfM
         AvLvV8CngoZhkMLF3VavkAngR9uR77kHSAN72sUw3JZP/IR3jJCXcczRbvMTvw7j/TlH
         F5BROXkoBFpVZp4fMJ2tmFZrq3gTbjBRFTbXNyJOPhpvDwaplqKVgcBvHgA4U9h0pEQN
         O7R/jp0NAt7iwNee2x3UHxibXMw51MpO6A8I3bv+hi2N/JDmMbLVxpt87mrUqhw+edYe
         PwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066593; x=1763671393;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j/Z0xLhRSjKs5wFvJcX9wYaBPUjY/kyQbPaphO1IA8=;
        b=m9dprg5170hVvHKIEdf0h3jWdNoQerptrp1hUcZFqOklyADOINvQe/WieG2fF+n/jc
         vEF+R5gDCHVDHASup0FBHA8tCuKIokIYUXVo8vLippOSkoGODdHjrogU/Bpd5s0U7ujK
         Ls74C+ynXX4BVGJkBkCu7FsHjWG0J+JQkNWc2OSPI3q/y1jtYnabx3+jQv4vYQ9NvmBz
         uf0GyPxkQSDcI3XEu36/tmXkNTYmHvaWaSv8m+YN82QA5Hjrg73yitiFyIptUvtUNGG/
         epT1tikNmAec4qUMJ5URfb1wUW3nvfF7Z4mOq2Rn4V5imQ0LfQ61JMGoMYhvd7Y1c+TZ
         nnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOwww0O8CMeAHlhS2ZyG9GEQnvhsG+vjU0XdT6I6ujq/8OZCPB/htqQTkzzLqZLKPVNSEdfQnVGBZW@lists.infradead.org
X-Gm-Message-State: AOJu0YwzMTWPSlAsXkytk4zA6yq5JNGvv3GJM0riZwqkN4a/ikPe86ny
	gCvNXO2tjS7JSm1wCHfG4Ohq3TwkK1K4U58z4Bv3exYwTRhDgQ6zXFv2h04+6o6EZNY=
X-Gm-Gg: ASbGnctkvDcD9YCjHa65vLO611mbFCpyVejt4QrZroIXsbWMW8yUZeNFxWTmq0ABjYn
	ROXjUJDBrRs3fm3xnX+qg0H5x3j8sp56yUkqGgr1YaETykjTA+HE0ukPT9xp9wQJgifGearXzaQ
	knU/3evLTjZEqG/n4HAQq6E41SqcgINKaLzdop5PBqXL8DMSVvwzUuoU3UeiJzfvY1Yk45jFW44
	ypsBERABZAv6ErUFIUFF7C75C8kGsZdGD9T4fWQ4Htm6Aooc+7UvJUbQmuDb2PznYbfYXtPjEGc
	TT7WRzlO88bPFqlQOkpdIZzjffABBt6Vxe4b1qWm0BjHd47StwxjCC3EzbjSZCo08cCwC0rSE+Z
	NwsMT1PdL3vIz0iZwMRDlMaWAjKk27qbriFCJOjthn0/7kiCOiD6mtdEmKCnq1iAQaldEuE2I5J
	MiBeX3EDNq
X-Google-Smtp-Source: AGHT+IFx6zjNpUrugZAc4wnC8a6azzxXy0tMnFASNITozSamcYusTb1sKbKe/dJVKe+5LnVSO1fFlg==
X-Received: by 2002:a05:6602:2b90:b0:887:732f:6a96 with SMTP id ca18e2360f4ac-948e0de0d30mr122779239f.17.1763066593467;
        Thu, 13 Nov 2025 12:43:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2b42dc4sm98817839f.2.2025.11.13.12.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:43:12 -0800 (PST)
Message-ID: <569825cd-c98f-4399-ad25-d4e62fba4255@kernel.dk>
Date: Thu, 13 Nov 2025 13:43:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251113195008.GA111768@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_124315_103361_5FE8E8AB 
X-CRM114-Status: GOOD (  23.70  )
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

On 11/13/25 12:50 PM, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>> On 11/13/25 10:12 AM, Jens Axboe wrote:
>>> On 11/13/25 9:39 AM, Jens Axboe wrote:
>>>>
>>>> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>>>>> Changelog:
>>>>> v4:
>>>>>  * Changed double "if" to be "else if".
>>>>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>>>>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>>>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>>>>  * Removed REQ_P2PDMA flag from block layer.
>>>>>  * Simplified map_phys conversion patch.
>>>>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>>>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>>>>  * Squashed patches
>>>>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>>>>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>>>>  * Reordered patches.
>>>>>  * Dropped patch which tried to unify unmap flow.
>>>>>  * Set MMIO flag separately for data and integrity payloads.
>>>>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>>>>
>>>>> [...]
>>>>
>>>> Applied, thanks!
>>>>
>>>> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>>>>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
>>>> [2/2] block-dma: properly take MMIO path
>>>>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
>>>
>>> And now dropped again - this doesn't boot on neither my big test box
>>> with 33 nvme drives, nor even on my local test vm. Two different archs,
>>> and very different setups. Which begs the question, how on earth was
>>> this tested, if it doesn't boot on anything I have here?!
>>
>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>> be a fatal error. And secondly, this just further backs up that there's
>> ZERO testing done on this patchset at all. WTF?
>>
>> FWIW, the below makes it boot just fine, as expected, as a default zero
>> filled iter then matches the UNKNOWN case.
>>
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index e5ca8301bb8b..4cce69226773 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
>>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>  		iod->flags |= IOD_DATA_MMIO;
>>  		break;
>> +	case PCI_P2PDMA_MAP_UNKNOWN:
>>  	case PCI_P2PDMA_MAP_NONE:
>>  		break;
>>  	default:
>> @@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
>>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>  		iod->flags |= IOD_META_MMIO;
>>  		break;
>> +	case PCI_P2PDMA_MAP_UNKNOWN:
>>  	case PCI_P2PDMA_MAP_NONE:
>>  		break;
>>  	default:
> 
> Sorry for troubles.
> 
> Can you please squash this fixup instead?
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 98554929507a..807048644f2e 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -172,6 +172,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  
>         memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
>         iter->status = BLK_STS_OK;
> +       iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
>  
>         /*
>          * Grab the first segment ASAP because we'll need it to check for P2P

Please send out a v5, and then also base it on the current tree. I had
to hand apply one hunk on v4 because it didn't apply directly. Because
another patch from 9 days ago modified it.

I do agree that this should go elsewhere, but I don't think there's much
of an issue doing it on the block side for now. That can then get killed
when PCI does it.

-- 
Jens Axboe

