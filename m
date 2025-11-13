Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75085CD8CB0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tui2oZdOGFo/UwA9EjBvgc/qLK6VZNJJO4rcigX5624=; b=TJGwnlyxpS4OzkkYeFSkbsdOWZ
	SFUOAeu4n1sAM8oW8NwjzFjE1obw+QEXF8V9EpfPiipYWbf3dL5TfQAWFamgyCmeNzWdAOmb4Ar1D
	Wy3alctFjWHEsgSaCk0Nup/q4XZC+t5VD5m0ZxgyuXSpMBWPKMGfbnGeOaeIGKqxlxhArOPvyxNmS
	hwTphEj0gcn517k3HKgksLEdFbbHbWNgbAC1fD/AK/MoFhZl6ghreanHaUbNJWQjrFqSMbw8/Zpv2
	eu3isyM7+Tb7Zfb0dyEsL+en2f1X1YP4n0NZlVg4OFFIn5EIXKK7/JhouQOGTfShEfoOEg8FAwEjU
	Ys6XH8dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJbOQ-0000000Ash7-0qD2;
	Thu, 13 Nov 2025 17:45:58 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJbON-0000000Asgd-2MN1
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 17:45:57 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-94880a46f3fso35877439f.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763055954; x=1763660754; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tui2oZdOGFo/UwA9EjBvgc/qLK6VZNJJO4rcigX5624=;
        b=pBoqVEMc1Nro+w5F39ngxsr34AZefs8h5iC93ZZ2F7HNKOyroLSZmxLTOjbmK9fFW4
         IrIFJ1/fAJifUrut2wpoBrcnA0pTw5nlHu45SgEgOst8DMB/3b5MjNbAYqyvv9AAVKsM
         lXcwTdVAjYwLukGrXIfME6ufTIhC4+jwkL4Oj1vvMSmRWylIYbi1l3IS33sjXZS2aw6Q
         ieNXmKDRBF2/M2glf6viBJmUU/x1QvcXp4zJzlO1kbIcUWTzN6AwQreIS2yvxmqlA4DW
         OunZGVFigkcsPmP4cZAIgzlm2nGI9aDyWIsd030zLMlkHDxiIlJ17E8/mbczTSUL6GG/
         XaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055954; x=1763660754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tui2oZdOGFo/UwA9EjBvgc/qLK6VZNJJO4rcigX5624=;
        b=lsdcS8eRkdJ1CpQrRhr+Ar8XWjai5nM5qMAcl57TJjc+VTp0JxH2WBOc8wHXxNq0pQ
         Imujky6RPe6DSMVkvLWJETU6F2eZ2ezoigf/YzQBrFEXgDeBw+eI8lYXWxW6ixQw+3iu
         Nf6T/mgfK4vfVIlu8Ypo0FDNE9eKVQ+ubnCdQ6tGMBtfyiRlddWma+FIaOturxeltdOy
         1SfiFv3+CiiYOsVbXpbgeWwy+piPNmkA+ynG/HPJQr5PN/33hiOQ8NlDTzbthTXYUt57
         6FwLj2bFL1wcbL7m1jTvR7z2KhSxpwz1+BX34A6oTZSKggrxrvTJ554eF3P00nTPEhUg
         WQQA==
X-Forwarded-Encrypted: i=1; AJvYcCXFZo3mN5VfQd3REfUE70lh3dmAbN15ctikIjtoBpUbj2szQB1OSdhQtP2EwWMFGU0zPth3iMVem0jw@lists.infradead.org
X-Gm-Message-State: AOJu0YyaKOGippE8ChE+5UB943SIAryB+ggClufyUch43BAU7GCL12fq
	0/IxeUNEWlbHNwtjqgM723RKrrd3XpADRuefxtsMjQ/2UqqGauv180TKzSwddaVpMbE=
X-Gm-Gg: ASbGnctais8QBSVH1r3v+Dd9KyKG8sBUFKBX3fFuNgocAVHaU+eNHeL/iExonA6eIel
	nIPNki374HpnS/BYVFAwepbmtKNM3OUgPrg78LbaRI/VKJvcJiU/LbbJ+GcKR+Sn/Scb+UUhEpB
	3nnQmTeyq++6Tt2uMfxswBGHKQIwVb0UJj34Op3YhkzbAhvo268FXGjtfNHrsG/onQuwLS013qF
	dyqVOYfPLdxLyw4DishhCY8X/CFlCabM+O0SKg7XoF5t57W+nRf7A6jxvCwrMQvdnXlZ78IJf6D
	ZKGAxhw7TXxwu2oe2sffpWzdeJdBoraiX+CH+A3qoPm2q8SksEEC7Ay5XN1Dx3ObO060IOA9p8Z
	RtPdJeo8D6CcU34mGao+dynjSWSp7mLik12IRtG8IRpBbxjCFxpa1hWAia66vzNQzfKxtYlzI
X-Google-Smtp-Source: AGHT+IFXSRU9xlOg2cSLBdle6h81Us/iIfHLsl+eoj1ZDKVfNRBNwooLejXMxXYqDr3/KqGkAsIfkQ==
X-Received: by 2002:a05:6e02:3302:b0:433:2072:9d2c with SMTP id e9e14a558f8ab-4348c89e9d5mr6229635ab.10.1763055954535;
        Thu, 13 Nov 2025 09:45:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43483990056sm9159445ab.19.2025.11.13.09.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:45:54 -0800 (PST)
Message-ID: <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
Date: Thu, 13 Nov 2025 10:45:53 -0700
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
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Content-Language: en-US
In-Reply-To: <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_094555_853204_9E696B56 
X-CRM114-Status: GOOD (  15.37  )
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

On 11/13/25 10:12 AM, Jens Axboe wrote:
> On 11/13/25 9:39 AM, Jens Axboe wrote:
>>
>> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>>> Changelog:
>>> v4:
>>>  * Changed double "if" to be "else if".
>>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>>  * Removed REQ_P2PDMA flag from block layer.
>>>  * Simplified map_phys conversion patch.
>>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>>  * Squashed patches
>>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>>  * Reordered patches.
>>>  * Dropped patch which tried to unify unmap flow.
>>>  * Set MMIO flag separately for data and integrity payloads.
>>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
>> [2/2] block-dma: properly take MMIO path
>>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
> 
> And now dropped again - this doesn't boot on neither my big test box
> with 33 nvme drives, nor even on my local test vm. Two different archs,
> and very different setups. Which begs the question, how on earth was
> this tested, if it doesn't boot on anything I have here?!

I took a look, and what happens here is that iter.p2pdma.map is 0 as it
never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
be a fatal error. And secondly, this just further backs up that there's
ZERO testing done on this patchset at all. WTF?

FWIW, the below makes it boot just fine, as expected, as a default zero
filled iter then matches the UNKNOWN case.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..4cce69226773 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_DATA_MMIO;
 		break;
+	case PCI_P2PDMA_MAP_UNKNOWN:
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
@@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_META_MMIO;
 		break;
+	case PCI_P2PDMA_MAP_UNKNOWN:
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:

-- 
Jens Axboe

