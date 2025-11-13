Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A63CD8CA4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=; b=v/K+T9NAWd/4yHLZ0Kcsb8LbBA
	uRy3tMHxiJXjBhuh5M8loW4cqJ9VQD6ePAmZAQEp0JxKNztrRDDO/J6k7Q2971zs4w2iAHWcn2pj/
	UgCdn47QEi+uvJVEWZHEH37eekQYVonJ+rWIh125EKOlj4Ava7o3uVyOWFTU2FXVWBpZHeF/dCIuB
	kYrWR5/qtm4isB6dgblG1j7pATHwz0YbE+srDlU7LMhfRqfK/wNBShRuKPPmkCN5f3C8OqU09lSS0
	ZsEYut06+PSyN4kxRWU7TNZ1pnqK+6BBWNh8IQNNvpDT0Zj5OW6NrfAlv8n0sxmJXQ++g987Q/pvT
	5mr3YnFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJasJ-0000000Aqfz-2LGD;
	Thu, 13 Nov 2025 17:12:47 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJasG-0000000AqfC-44OD
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 17:12:46 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-948cda204a7so90200039f.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763053963; x=1763658763; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=mxhLaadxUEOBrfSPAlJfCEB/0rgQHCplAv/pesQS0wK4NTVOYVSWT52IXddOz1FVRJ
         vD+BVOZBJwmnaJrZCSHfyv7PnOM3xVHfy08I7nBioctYRn9Z9/mMLPhXUd5xX+oqmySV
         l0jiLVVrhgv1kBDGrwg1lYjprizZ88HPpNT+5c2ewUZbxmQzjmk4q4b4QjgqayF80Uyc
         d9/JOHqb6YWT9XDEceosZ9jt/Y9Tn+DE6jwZ/lJTMfyZbtK75x7lZhkgrtvmEDZ074ru
         yfRv+IR7j+uAOQlkFXhcKjbNz67dnYF2g+uhCHBC+O2PfaaNjVsklMzrhHZWvZqSWWyf
         Z1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053963; x=1763658763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=Ba5clE1KwuZEG0Zjh9h8ACT3LhQ0jKi9Fsuc/bxc3VrBA+TTT+J7cYXY0ETyFrN2Xn
         98ZlH4wimoCxoUDycG7wQofs69o+MkRPUa1CbD5UDUN3sIriFk+2c4ts3VlbAC/7W1nu
         IQtKma0PPEPVpufmpH17z6XU1PbKN+Dz3BEqFpycb+iXlkDhVDJuO9vFCXPl4+LrLtOT
         xnkgj9CQ/jmAtzhvVheRkgelHwVn+A6WYkkm56taSwNv489mV2Ov3b7PzsC8mHJgFKi5
         79mo5c9gqO6/YVG6J0u7utGWZI1sZR1L79rM4wSKLzmF0sX8X2WVmGoxotNYGzmc+x0/
         9FWw==
X-Forwarded-Encrypted: i=1; AJvYcCVftsv3gqGIN9SG5h+0fdGPEnosHpKUkedlm/dMA5sBZI1KVnyzIfkgwVRHS2gvFD40kNHeqHA4+Su+@lists.infradead.org
X-Gm-Message-State: AOJu0YzgNA/b5MCmiUfrA8jyN1G6C7QJmbCcOTdlVLkT0uwaRkyeULOB
	wFqbnIirnQGWf46RL8j3T6ayzclJZwdCVvYgZZdUXggQvagG39GzLnPTQVwetTgVL9g=
X-Gm-Gg: ASbGncuKPomTGH+SH5RWoM2wDXoPDu72whhLvy8YFVwCln3BQ8Cg9yPP8Q5rTW+ZCyY
	vHxM65UMp+smGpAc/RKY+6shLR9jqzrfDrEdL6cwTwxuLZ7WyLnbr6kDSAwsOOgZmUnLUokgGVo
	TLqcfnLzW8YieaTL2M7DZxY2htCWf9YE5D9htJI8rvNQxpFn7AkuCnx/RF9I1/UhN4Oj2igjOEM
	Kix6mdLRhqAHnCwQaVhOoid4Hj42k5tk/Cw/wVeUQ0y0TXXUME4uZoRRzZXWZxwssmTQj8RGpDR
	uVcjKEZDXcHQpDYdXC7yiKHuv67IIvyAhoaVcVmYrW08fHwy7jalsOnxckGnA30kPFoKs0I6dJM
	kEralZw8R+r1GSAvnpRPJsEp1bUWK3rxjkxcmRLYL7upp6zgaA0vqp/OpT5Pb0pgjrZUaLeR4
X-Google-Smtp-Source: AGHT+IESfdDpCl3TykV3jnebGBOgzapv9FYkIKAhNH+gAKGVBuzPG8lrd5CjZsSJSCN84KOJrH4GFQ==
X-Received: by 2002:a05:6602:2c06:b0:948:cbd2:3b84 with SMTP id ca18e2360f4ac-948e0d87a37mr14748539f.11.1763053963524;
        Thu, 13 Nov 2025 09:12:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2ba690bsm82035439f.8.2025.11.13.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:12:42 -0800 (PST)
Message-ID: <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Date: Thu, 13 Nov 2025 10:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_091245_039657_273C3644 
X-CRM114-Status: GOOD (  11.59  )
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

On 11/13/25 9:39 AM, Jens Axboe wrote:
> 
> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>> Changelog:
>> v4:
>>  * Changed double "if" to be "else if".
>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>  * Removed REQ_P2PDMA flag from block layer.
>>  * Simplified map_phys conversion patch.
>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>  * Squashed patches
>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>  * Reordered patches.
>>  * Dropped patch which tried to unify unmap flow.
>>  * Set MMIO flag separately for data and integrity payloads.
>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
> [2/2] block-dma: properly take MMIO path
>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

And now dropped again - this doesn't boot on neither my big test box
with 33 nvme drives, nor even on my local test vm. Two different archs,
and very different setups. Which begs the question, how on earth was
this tested, if it doesn't boot on anything I have here?!

-- 
Jens Axboe

