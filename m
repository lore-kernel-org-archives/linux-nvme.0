Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D30DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:53:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D29461037
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D29461037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8e9uav6zegWUp2wbS/kuwLHJtTSbCguFDvGCBSqaxL0=; b=Knj/lKrK/744ZK
	DdOgQMkG3YDFFdC+CYTpYnPwUbajtQaIIuimVP6UNLTktMXlAhoY/9dS1Np1Njb+zEXxHZ7tDRiMU
	xeeKbOWJ7CdoAIJqAUZEytJ4u+9V4hwR5YlrxVbd0jmAeHD/VL5PxJcFLYAmtouqljXHEuttfMoRU
	n5af8BEqC9Ks1L0RqiZ3iVB5U808Rd3S53pRDzu4EFiX1TSfkr+KPZVZ9vAMCmp2TW0gYs5N4NR3N
	JIfrmpjab9AJ+6wWqsVCxsNSu15Dd9UdSlr68huTZqUeiSGIu50JZyD1eBsSRxsQ7SDAvttF/hy2C
	/V5QpCY63OCR7u+OFaZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVjNZ-00Ce0m-PU; Wed, 29 Sep 2021 23:52:50 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVjNX-00Cdzv-04
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=EbaHldIfmljK2aAsHQqeoY1Qg/19dgw063FCWj78kIA=; b=BYOpvsO/6zfK/zmuM4LPBTGkEY
 IX+IV00ne55Vn0YfEDps7ZCSwEilHH8U02Q33wf4MlxPdQ0UWL6DzmjorF0O9tl0Jsm4uIASf2Ene
 aM4efeOMiejklMT3X3x4u5ceMHI9es5C0nZcATdnazTQGIO6GnDxU0gRZUpRLY04BYWJRwGKwIzlM
 MsiSqwPDnK66YxcCdj+o8uhP8jg1uNPzO6/t6Cb0JyUhdXEqKBgV0BT6H0WJz9/AKmbztTCYQsoOP
 zcbO+BgjsyCmu9TditfVdrlL1UcCemw3a1G6PSim8Gk2mjPDqAMmHRRC5zbBXFVy2p6sr5VqIlFuw
 E0w7Az4Q==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVjNK-0008VW-LI; Wed, 29 Sep 2021 17:52:35 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
 <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
 <20210929233624.GG3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <142badec-f6f5-e471-698e-8a386aae3c2b@deltatee.com>
Date: Wed, 29 Sep 2021 17:52:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929233624.GG3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_165247_053758_E1F0454D 
X-CRM114-Status: GOOD (  19.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-09-29 5:36 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 05:28:38PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
>>> On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
>>>>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This patchset continues my work to add userspace P2PDMA access using
>>>>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
>>>>>> patches in this series, but the early P2PDMA cleanup and map_sg error
>>>>>> changes from that series have been merged into v5.15-rc1. To address
>>>>>> concerns that that series did not add any new functionality, I've added
>>>>>> back the userspcae functionality from the original RFC[2] (but improved
>>>>>> based on the original feedback).
>>>>>
>>>>> I really think this is the best series yet, it really looks nice
>>>>> overall. I know the sg flag was a bit of a debate at the start, but it
>>>>> serves an undeniable purpose and the resulting standard DMA APIs 'just
>>>>> working' is really clean.
>>>>
>>>> Actually, so far, nobody has said anything negative about using the SG flag.
>>>>
>>>>> There is more possible here, we could also pass the new GUP flag in the
>>>>> ib_umem code..
>>>>
>>>> Yes, that would be very useful.
>>>
>>> You might actually prefer to do that then the bio changes to get the
>>> infrastructur merged as it seems less "core"
>>
>> I'm a little bit more concerned about my patch set growing too large.
>> It's already at 20 patches and I think I'll need to add a couple more
>> based on the feedback you've already provided. So I'm leaning toward
>> pushing more functionality as future work.
> 
> I mean you could postpone the three block related patches and use a
> single ib_umem patch instead as the consumer.

I think that's not a very compelling use case given the only provider of
these VMAs is an NVMe block device. My patch set enables a real world
use (copying data between NVMe devices P2P through the CMB with O_DIRECT).

Being able to read or write a CMB with RDMA and only RDMA is not very
compelling.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
