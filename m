Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F6C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySXwHaWnwWfuqJedGiV+eti2ui1J2NF0RPAqqwKPf6w=; b=M3iWCE3HLwh005WIRmiRia6gs4
	iAXliUB7jKMdiQj/0AbhBdojGlRUDp+s6RXPXKU/e8exAdrHvGmwxEPPC1q8Z0Rq3UXWFmCD9kt6R
	DHyOhlB8S+aNyZcxjSV3aww6f678fIm1aYiUvO2XnthHs8EeqCZsbqFhxRGO2a5bkDU+jtN+HdhL7
	69scv3+GoYWRGFgd4IiXLg1fIrIKDvQtiX6Q47nDhth+5SLKVqCYlWXsh2qE5zcnq+WX8gDawDZ6z
	CRFHQwTbrb9xPSG1zhVu72XhjkLA4fjoLK9/yh5kOtlRBmmjwAaO6++UxB5SC4+sXwTLFxgWK1XkR
	0AK4b3KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtn8-00000000ume-1IgL;
	Wed, 06 Mar 2024 16:06:50 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXLV-0000000EPtc-2LfH
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 16:08:51 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1dcc0d163a1so17925175ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709654927; x=1710259727; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySXwHaWnwWfuqJedGiV+eti2ui1J2NF0RPAqqwKPf6w=;
        b=I5mwsFRqcOpG2SRkK0leZUvZno9ONoqaRXz8Tq2aMmlyHPiID/yyl8m1Xf2nqeAYZw
         /adnYdft/svdI7vN5i1TCumJIUAEsWGOioG31GypclOTKyu1ntgThX+gmb6H/IYHAb6c
         7UTWJWVF+A3qAo2N/iTAsaqmT8Tgbs7aO8+XHdBr3dYxRPMpov9awmfKSUCZtWU5xgoS
         PF+O5SZkek17HpyyrYsmlgdIjZ/eqOjm70Z6qTg/R+rJiaBLoI/6x7pwUDdd+Z3vNl3p
         hcX0ZOMz1NlDV6v4mv/aVyclftjaJH28tjbq2kpFaXwtJOGocXbOBCbns/HAUOPCOWk2
         m5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654927; x=1710259727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySXwHaWnwWfuqJedGiV+eti2ui1J2NF0RPAqqwKPf6w=;
        b=blkkRoiMGgR+dJYJbiq/nQvuEFx7RzZ/S29OO40kI+opTzYm/RUwkgHKQ1kHjQxhjj
         CkZPrflbWQcz6aB/26xvXG0Jr7BJlomDghR+3q0HyvLRb0FrjeMnIkS8W5C8argdH0lv
         ljg36MzgDR56C7rVmVscldltxnfjOF4HJWOZ5w73zZrAN1Lc4KgqzqzBEunGstj5Imbe
         2RnS0CwwNDRU145Yo5kqFmXDGjdGuTbef0nvYdi+oauRmXGkdoOA01wuk/a7Yxlqhzhl
         EmF97CojTC6U5ypNQgOvjDiDe6Z72Dr2p5Molk7LoOTh3v50sQ7g0ATvb3AnQFh47iR+
         CRPA==
X-Forwarded-Encrypted: i=1; AJvYcCUo3Qt6fOSP4fHdOteUraDkvwOFA8LVcl8f2gOHilLSJMmbza+AnhYlkBp5mORRcBXAHmFfXMg0dQAk0Ym2Yea9Cx+xfjBkxPS6Gb0hXDs=
X-Gm-Message-State: AOJu0YxWIB1ht0XCKRQGw26cNgQXyLElQvupFmnpqGueNozMTTIksfCr
	O47ZI6iMa7HDSAJuATOPBPzH/uKaGYfjxIJypSOUqKjTBJC90Jlqhiod4gVuycA=
X-Google-Smtp-Source: AGHT+IEQyMNsi91T5s32CUzK+ybKvXY5CY8IcxZgQ/czWV6ISp8aawkZe242UlnjfOr6MXQ5ygWb4g==
X-Received: by 2002:a17:902:b08b:b0:1dc:82bc:c072 with SMTP id p11-20020a170902b08b00b001dc82bcc072mr977677plr.1.1709654927270;
        Tue, 05 Mar 2024 08:08:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001dcf93e90a0sm6901815plg.20.2024.03.05.08.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:08:46 -0800 (PST)
Message-ID: <06787e6a-4e78-4524-960d-ec24b9f38191@kernel.dk>
Date: Tue, 5 Mar 2024 09:08:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Dan Williams <dan.j.williams@intel.com>, "jack@suse.com" <jack@suse.com>,
 Leon Romanovsky <leonro@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
 <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_080849_835397_81D607B7 
X-CRM114-Status: GOOD (  14.52  )
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:06:47 -0800
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

On 3/5/24 8:51 AM, Keith Busch wrote:
> On Tue, Mar 05, 2024 at 01:18:47PM +0200, Leon Romanovsky wrote:
>> @@ -236,7 +236,9 @@ struct nvme_iod {
>>  	unsigned int dma_len;	/* length of single DMA segment mapping */
>>  	dma_addr_t first_dma;
>>  	dma_addr_t meta_dma;
>> -	struct sg_table sgt;
>> +	struct dma_iova_attrs iova;
>> +	dma_addr_t dma_link_address[128];
>> +	u16 nr_dma_link_address;
>>  	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
>>  };
> 
> That's quite a lot of space to add to the iod. We preallocate one for
> every request, and there could be millions of them. 

Yeah, that's just a complete non-starter. As far as I can tell, this
ends up adding 1052 bytes per request. Doing the quick math on my test
box (24 drives), that's just a smidge over 3GB of extra memory. That's
not going to work, not even close.

-- 
Jens Axboe


