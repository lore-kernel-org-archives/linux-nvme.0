Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DCFC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crvukPwYQf3UJei/s4UmkS3mEu2+SzRGq3XdJM+oDdo=; b=hdo9b3rcNsdGpFjBN6jX/68Q8E
	iaO/wKq46kljHSBnOS2f8X0hyfICzmWPLeO5sa58MeGGeCibMz5y11BKyWUgcrGgRh2dEGYdPV2VT
	ChpFZkIwKNk1zRsaqPCkfffQmS7FxXDIgjiBOKkurd0nyRvp8T+UPHa55M5qqmeKPLPrvYQXNOyrX
	wi4+/IMmiPMpaMZ60aYZ8mfDczL9cWgZ30+vK2tK9K9j2Ir5r/28kRlvFUd6TdsctHeQ+zVyDDKuH
	8qtTiCGryhs4W+Y0YAfVoaxnfx5aj7Pk8PKoHqcNtoJ+GDJhNruHRb7R/4mrmbtlEYN++n2QREHPj
	xoLtMOkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nagJB-009YNH-5l; Sat, 02 Apr 2022 16:09:01 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nagIy-009YJ3-7w; Sat, 02 Apr 2022 16:08:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D6CA5B80A2A;
 Sat,  2 Apr 2022 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED7C340EE;
 Sat,  2 Apr 2022 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648915725;
 bh=y7ESlPWtxRlIdhSZGGzoj11NW8q7/9qcgGEefxK5zJw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ua6L3GXkmuQ6CJbvQ5F7qY2YUTD9Bm6adyIsvhGeNXsNC6XRQIDKubNcYcYmQrvco
 +xNuRPps41q7NWA61K7FbzYDDgXDaZEOyXf+p7VeRmvUBltK3U2nX0I/AVa2t7E3SL
 cLQNzb8kmFQWQBE8pfS7TarHYEEMdK41tv2k/1+R1QOp2UVifNHDF4A5l3hILUFi+c
 ZsmRQ5qhDFtCxYqYGKvFdtRFMFgnBWKfgEF4pemgf+qI//J3aAGlJc+qPCfwNGKV0u
 dzHpss38jhP2I9JXo/Hbe2cIJB288yvvfURXVXUtb4Ma/LTQYbTCK2ByCjkOCFZM+j
 SdJo2JLAF6dZg==
Message-ID: <bc91bff4-0ba6-8f9d-e3b2-5e8caf16bd98@kernel.org>
Date: Sat, 2 Apr 2022 18:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
 <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_090848_633995_C77621F1 
X-CRM114-Status: GOOD (  29.56  )
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

On 02/04/2022 15:51, Sven Peter wrote:
> On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
>> On 21/03/2022 17:50, Sven Peter wrote:
>>> Apple SoCs such as the M1 come with multiple embedded co-processors
>>> running proprietary firmware. Communication with those is established
>>> over a simple mailbox using the RTKit IPC protocol.
>>>
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>>  drivers/soc/apple/Kconfig          |  13 +
>>>  drivers/soc/apple/Makefile         |   3 +
>>>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>>>  drivers/soc/apple/rtkit-internal.h |  76 +++
>>>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>>>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>>>  6 files changed, 1284 insertions(+)
>>
>> Isn't this some implementation of a mailbox? If so, it should be in
>> drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
>> Linux is organized. To drivers/soc usually we put drivers which do not
>> fit regular subsystems.
>>
> 
> I put this into soc/apple because I don't think it fits within the mailbox
> framework very well.
> (It actually uses the mailbox framework for the actual communication
> with the hardware with a driver that's already upstream.)
> 
> Essentially, the mailbox subsystem provides a common API to send and
> receive messages over indepedent hardware channels and devicetree bindings
> to describe the relationship between those channels and other drivers.
> 
> One of the features that doesn't really fit is that we need to be able
> to start, shutdown and re-start these co-processors. The NVMe driver
> actually doesn't need to send/receive any messages except those required
> to setup the common syslog/crashlog/etc. interfaces.
> The mailbox framework would have to be extended to support these specific
> use cases.
> 
> Another thing that doesn't fit is the memory management: These co-processors
> sometimes need shared memory buffers to e.g. send syslog messages.
> They always request these buffers with an IPC message but then there are
> different possibilities:
> 
> 	- For some processor the DMA API can just be used and an IOVA must be
> 	  sent back. For NVMe these buffers must additionally be allowed in this
> 	  SART address filter.
> 	- At least one other processor (SMC) does not request such buffers but
> 	  instead just sends a pointer into MMIO space and the buffer must be
> 	  accessed using readl/writel. This MMIO memory region is used for
> 	  both the common buffers (syslog etc.) and for the actual shared buffers
> 	  used for communication, such that the resource would have to be shared
> 	  across drivers.
> 	- And yet another coprocessor (for the display controller) requests some
> 	  buffers with an already existing IOVA that than need to be mapped
> 	  specifically inside the IOMMU.
> 
> Each of these co-processors also provides a single function and most
> of them don't even have different endpoints. And even those that do (DCP) will
> just become a single driver since all those endpoints are very much related.
> 
> While it's not impossible to do all that by extending and forcing this into the
> mailbox framework at lest I think that it doesn't fit very well and would just
> create unneccesarry impedance.

Thanks for explanation. I don't know the mailbox framework well enough
to advise you, so I don't mind keeping it in current location (drivers/soc).

Best regards,
Krzysztof

