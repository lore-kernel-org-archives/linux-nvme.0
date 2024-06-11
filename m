Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D21C27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kecLidF3g75Y0M4dgmXIi2U7qv7nfX0gCWhXKA3lhlo=; b=Uq4HB9EMhXkg88ckbhnyXcAwgO
	+bV635aT9tk4476i9K2rjhnWHDPAFV3VMVguqLsKKeCyvJF8kkHOF3mo+NYGJE2YXKftssUsoyB3v
	BnHtB9acSGKe1xYuBpnVn1u+SNnQUhbnihkqJqXD9OdJOF/wfS2OImCc8OqjsSDIJ0hG/gejuF7gA
	eztab72E8D4m7OfMZock55MSYuZVYnbNCT0noiFf5i6goFmTPX4RtiLfLOAlHCq9WvcvCpnlJwjNu
	KZMchyUFKGVPdDpXhUWR3WBv5XjBfgbj+y2s1sqocdW2Q28Mwt6syqK8/Ixs/vmvp/gwWDB2qPqhf
	0J/ZSOeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwTX-00000007y6Z-17HE;
	Tue, 11 Jun 2024 08:03:27 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwFi-00000007vIw-2bps
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 07:49:11 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso526298066b.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718092146; x=1718696946; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kecLidF3g75Y0M4dgmXIi2U7qv7nfX0gCWhXKA3lhlo=;
        b=YlE5d3JEI/a2VfcayMZj/98SSYh0J+PbGZ/w+V7DhETRNcmB34R2vGNWV+pG99ZLiP
         KrTtbuMSbMbtjboIH4i/1apt9HVogADg8wzvPddFtlds5lV2vrT/IXOFwlykYKUn+Ir+
         5tA/TgL/oDl+EGW43wnMNXmvP6mrenMnKUczSMroCkrmxCZaR6nR3xXFXTSsVCVxHaNK
         1lwWcRoXPKLpgpxR/2EhBqA6gsPAWpL+N/fYmPQM81X1c3mtrBw/z+ld3LbBpnu7eMpK
         BKcVEZlRT7u+EZuq3gTPDQyxgwiz8S0UedbCDt+znwA7NxASRhpoKvqBlhj61R7dZpbu
         WH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092146; x=1718696946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kecLidF3g75Y0M4dgmXIi2U7qv7nfX0gCWhXKA3lhlo=;
        b=EZLwFy+EphsoSEjGrt3Kx/k1vbZllnDnKnHh5l6U1dfyR7lffCIhxujDLZ3flvw5ZE
         tN6WvwCgVZQz4Cj5P7JkAtZnu9lquaCquU0qjTIrSBDDLxwEofROdJS1YXY7gzIBml4L
         T+QRvqM+TadLiCpfaS683w5pOEw7DfrEyHAetPXP3+RbzL44N9DzCYvsw7TqvNAucUDv
         LdESjtjLRklBt0oDxvb0be2wfpoYXPkhXDJ+XCJdIJTEtuihePdlCT5oEosroTkOgUe2
         EYJntJG4QU1pZ8rZIyhmtM6672OC+Edq0NJJjUYzjUBOq7Ih4v+sNwAL8yEg7BzT0IQD
         QY4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEcAtjiyJmhGnZaLdToE8k9/nJZrhN4Fi1NPWubGpcc/8AeUeMO8eLRZHip/OLxv4LWklHcngrwbjH03/xSmC+Gy85D+rwtIL20fb+LKI=
X-Gm-Message-State: AOJu0YyJA5NO5A5ODmE7qrMPtJtE4CVsNR4OlJRKjbMGnVPSL98bhHWP
	uByniwmlNUjFPb2TY7Mopej7eQNfPY8qxbla+bl+uz7umY7gZjVX
X-Google-Smtp-Source: AGHT+IFzcNCL4DB7c7G7kLyb+7UFm4o2GGJXJ/lKj59bEb2GT+3Qy+R5dFmfo0Jxs1fqaAcSpOVYtA==
X-Received: by 2002:a17:906:6a0a:b0:a6f:1d19:c0b1 with SMTP id a640c23a62f3a-a6f1d19c496mr372629566b.18.1718092146075;
        Tue, 11 Jun 2024 00:49:06 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2942b02fsm145877166b.167.2024.06.11.00.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:49:05 -0700 (PDT)
Message-ID: <900d1d56-28ea-4c6d-b8c7-749a952e5f4b@gmail.com>
Date: Tue, 11 Jun 2024 09:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
To: "Zeng, Oak" <oak.zeng@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "Williams, Dan J" <dan.j.williams@intel.com>, "jack@suse.com"
 <jack@suse.com>, "Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
 "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610172501.GJ791043@ziepe.ca>
 <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Content-Language: en-US
From: Zhu Yanjun <zyjzyj2000@gmail.com>
In-Reply-To: <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_004910_687539_4786CB97 
X-CRM114-Status: GOOD (  23.83  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 01:03:01 -0700
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


On 10.06.24 23:28, Zeng, Oak wrote:
> Hi Jason, Leon,
>
> I was able to fix the issue from my side. Things work fine now.

Can you enlarge the dma list, then make tests with fio? Not sure if the 
performance is better or not.

Thanks,

Zhu Yanjun

> I got two questions though:
>
> 1) The value returned from dma_link_range function is not contiguous, see below print. The "linked pa" is the function return.
> I think dma_map_sgtable API would return some contiguous dma address. Is the dma-map_sgtable api is more efficient regarding the iommu page table? i.e., try to use bigger page size, such as use 2M page size when it is possible. With your new API, does it also have such consideration? I vaguely remembered Jason mentioned such thing, but my print below doesn't look like so. Maybe I need to test bigger range (only 16 pages range in the test of below printing). Comment?
>
> [17584.665126] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 18ef3f000
> [17584.665146] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190d00000
> [17584.665150] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190024000
> [17584.665153] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 178e89000
>
> 2) in the comment of dma_link_range function, it is said: " @dma_offset needs to be advanced by the caller with the size of previous page that was linked + DMA address returned for the previous page".
> Is this description correct? I don't understand the part "+ DMA address returned for the previous page ".
> In my codes, let's say I call this function to link 10 pages, the first dma_offset is 0, second is 4k, third 8k. This worked for me. I didn't add the previously returned dma address.
> Maybe I need more test. But any comment?
>
> Thanks,
> Oak
>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Monday, June 10, 2024 1:25 PM
>> To: Zeng, Oak <oak.zeng@intel.com>
>> Cc: Leon Romanovsky <leon@kernel.org>; Christoph Hellwig <hch@lst.de>;
>> Robin Murphy <robin.murphy@arm.com>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Joerg Roedel <joro@8bytes.org>; Will
>> Deacon <will@kernel.org>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
>> Brost, Matthew <matthew.brost@intel.com>; Hellstrom, Thomas
>> <thomas.hellstrom@intel.com>; Jonathan Corbet <corbet@lwn.net>; Jens
>> Axboe <axboe@kernel.dk>; Keith Busch <kbusch@kernel.org>; Sagi
>> Grimberg <sagi@grimberg.me>; Yishai Hadas <yishaih@nvidia.com>;
>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; Tian, Kevin
>> <kevin.tian@intel.com>; Alex Williamson <alex.williamson@redhat.com>;
>> Jérôme Glisse <jglisse@redhat.com>; Andrew Morton <akpm@linux-
>> foundation.org>; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-block@vger.kernel.org; linux-rdma@vger.kernel.org;
>> iommu@lists.linux.dev; linux-nvme@lists.infradead.org;
>> kvm@vger.kernel.org; linux-mm@kvack.org; Bart Van Assche
>> <bvanassche@acm.org>; Damien Le Moal
>> <damien.lemoal@opensource.wdc.com>; Amir Goldstein
>> <amir73il@gmail.com>; josef@toxicpanda.com; Martin K. Petersen
>> <martin.petersen@oracle.com>; daniel@iogearbox.net; Williams, Dan J
>> <dan.j.williams@intel.com>; jack@suse.com; Zhu Yanjun
>> <zyjzyj2000@gmail.com>; Bommu, Krishnaiah
>> <krishnaiah.bommu@intel.com>; Ghimiray, Himal Prasad
>> <himal.prasad.ghimiray@intel.com>
>> Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to
>> two steps
>>
>> On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
>>> Thanks Leon and Yanjun for the reply!
>>>
>>> Based on the reply, we will continue use the current version for
>>> test (as it is tested for vfio and rdma). We will switch to v1 once
>>> it is fully tested/reviewed.
>> I'm glad you are finding it useful, one of my interests with this work
>> is to improve all the HMM users.
>>
>> Jason

-- 
Best


