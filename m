Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B624CA1012
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofbBRwXn4NwRWFOUaaAPn4/ZCyHKifDZzDC7NpE3rfM=; b=lB0iZ6jA8ijlSnJpY06e9mfqoy
	IJMQLwQcH0j6iad66ZNnlrBMOkh805AsW8W8MeD0du0Db8QHp5VXp+VlZNtehZYDIOkiFqGnfnISR
	sX8L5jWQevqNR0V/Bw8ZGqvcpnzROXFjuGWcVnfkEe07+OMNTvRndVxVRe6avTCNfWQoXFr8mI3z9
	OWqroV6Ogdaqd3NxKpT6ONh35WAOxeAV7yfDfJtrOIwcm2+KEBAGNy5t19cWXE0pUOXYYGiTOBO/z
	hj9F6n2zW/BnaSn9hImR2l1COB/XVmilV4h/o6yTE5cmB8z43nMC2Yzr1Eywff1xaN0dcw3AWd02c
	ihF8mhJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuM2C-0000000G0Nd-3qGy;
	Fri, 05 Sep 2025 02:18:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuFfO-0000000Duxc-02xm;
	Thu, 04 Sep 2025 19:30:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FE6144CCA;
	Thu,  4 Sep 2025 19:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909FDC4CEF6;
	Thu,  4 Sep 2025 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014240;
	bh=0RZ8CnMwf4NqKb6arTE1y1641ehql4WXMwOOTJDdIbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqU9NY0f4OsloxJ8hrjbay3uVxPdDfrJdhw+yQhou50Mf8usGqoTPhJTDxoNZp+w6
	 eu6nxigNZ8yXtk74xrcMlP3GhpB2hvBpxU8ah4yk5t3JX8Lb1vFpRH7YwijLTSgbWz
	 qa9mBqjd3NaDpDjXFuhgVL3ZcMFKlqGV8sDgsAaqf5VbqGYVLBnMpIt1xy+iFdzoOR
	 gNmUrbAa7u2A5P+g9AScjho9KWkTUaNgRl2ZBG1zaws8KKSV6BH1t5vhbS0CK2T0zA
	 ywZqzYHxLFtRwnoZ7Dz4d747xiS8+AL/sRcm6VTWQeX0uaJ4oW2rz2DMJ+YwSutGZT
	 wOMJINbdy8Rbw==
Message-ID: <5b02ef9e-3017-400a-826c-59b5d5770a44@kernel.org>
Date: Thu, 4 Sep 2025 21:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
To: Janne Grunau <j@jannau.net>, Christoph Hellwig <hch@lst.de>
Cc: Nick Chan <towinchenmi@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
 <89251134-9685-439e-b220-92717663f038@kernel.org>
 <20250902052646.GA11139@lst.de> <20250903095325.GA89417@robin.jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250903095325.GA89417@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_123042_082075_80C22F4F 
X-CRM114-Status: GOOD (  16.59  )
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

On 03.09.25 11:53, Janne Grunau wrote:
> On Tue, Sep 02, 2025 at 07:26:46AM +0200, Christoph Hellwig wrote:
>> On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
>>>> Do you want to merge this through the apple SOC tree?  If so:
>>>>
>>>> Acked-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>>
>>>
>>> I don't think that's necessary since there are no build time dependencies
>>> but if you want to I can take it through there.
>>
>> Merging it through nvme sounds fine as well, I just through up
>> grabbing everything together would be easier.  I also noticed there's
>> another Apple hw enablement series that touches nvme, so I guess both
>> should go through the same tree?
> 
> yes, they should go through the same tree if they go in the same cycle.
> They conflict in dt-bindings and possibly the driver. We should avoid
> burden someone else with this conflict resolution.

Good points, I'll pick up the latest version of this series on the 
weekend then and handle any conflicts in case the other one is ready for 
this cycle (which it probably will be) as well then.


Thanks,


Sven


