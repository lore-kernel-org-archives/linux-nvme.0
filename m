Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A969ED767F4
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=; b=ityTdz0YE1sfjE3w54QIr1GGtc
	+kTARGgAZhjGOutOnw9SygSShQG5iECwSUTh3T2jF/61+ZeS9O0YnmXOPUM8I9fnipJsmusp3RGdp
	Km9272y6Gmzx4X/9YKfFOQsyFrwOgfOwg2lzbdYV/Y4Nn+nBDu2Yq/5NEPJ+sOukMyvm9DY9Mq4a7
	SeQ2+dEXul5fhNdSl1DPuLJ+HONnMOgnA6XJ9DS0aoFOL+qNnJ9Nvrizn1VxoRPeWEcL6FZdRaL9H
	+4vSVP8VN1hVFv/rBwkYZfOb4Kf0gIgG9hyDM7jzjPsrGGxUBhKGoqultrUFlZCIyGBVPJniZtmiY
	SpRRaEhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZDB-00000004Ns2-2AY4;
	Thu, 31 Oct 2024 17:43:57 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZD8-00000004Nr8-2jvi
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 17:43:55 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-8377fd760b0so44243439f.2
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396633; x=1731001433; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=I8D55ISEDqnOz0Vl4Lp4xPfxJN9Ql/Kc0AwXomfWtCeXpjJGjFsG+WiIP+1Mevyxkt
         OLpen2PR9yEl7bkEzcPKmXMB5v49Mg4pP3Llb/hwAWf6fQ6CMJ144BUazVlamPBBvZzx
         eJ6VgWDHsa+Gy69rdbL3DNR4Fwv/x312ENgfIWeO+AxMMse6kKA5eV3HSShD7yvgFFc2
         FDfQuR6TQKQHoijH89cLAhMAnOLdOsjc+5+g0l40YBW6sgU/Rr9dpB/CueHzVgl3Kp56
         F4qANDOGKWySMylcmWqaJomZmTVTBxyfOBs0ufyXyKpggwyruxpYhBsMUZ+VYAxT4IR0
         fM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396633; x=1731001433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=DYkY1lCA6Cp6/9vuC4FDfHkOkBmiXPGWpGjKzb62pI5jmmOras3r9DySiw+ahL+eKI
         pvkHGIxsYFc3HFdaBdS4I9SR+sKNG+kqZF1pEPYwr+zJSTgxF5y0i8+fNz4A6BxZG3hi
         bM0gtCG7hGhS/vHvyT+qONj6FGEWW06B47qs96BsKa8KoqyShNmGZjygVEcO8K66hFiQ
         NA8E9QgzUwWQgNWolNzCT7bPTyYMMiVeUctVmfwICu4DPqDRrSctHJkPQc5D4qhaxz1Z
         jMiOmVP2m5zNhV5yiPVyd81ajV1sLNmkp0lKcA7b0xM2jWBqbZs+ovh8/3HghlvDG/rt
         vKbw==
X-Forwarded-Encrypted: i=1; AJvYcCW4oVRrO0PLE0ZH10sbi7/8/aPy7gOlXB0hEeIqC6kJi8yEHdqCGpePtOgygeGb6+Z/kI7gGfAAnKu0@lists.infradead.org
X-Gm-Message-State: AOJu0YzddyoFA4XcvY/EBV97Fw6fCLFbD5WxXiXqR5ivOaX/m+stIfe0
	nk2dI3zBkFh78WTVGqxiJYa5fsykAzJcWrwUEC44pTwyrZNEQeIzruvVFN/N9xo=
X-Google-Smtp-Source: AGHT+IGqvDPac4jMToI9PP3ppL4bi2ob+amIyOKddZ0fGQ56qF7607m8ktK4Ur1sfUjByGfZ1fMmYA==
X-Received: by 2002:a05:6602:6d0b:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83b1c4c27eemr2156317139f.12.1730396633080;
        Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e3736sm379375173.81.2024.10.31.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:43:52 -0700 (PDT)
Message-ID: <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
Date: Thu, 31 Oct 2024 11:43:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de> <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de> <20241031093746.GA88858@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031093746.GA88858@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_104354_729966_BBAC1A99 
X-CRM114-Status: GOOD (  16.97  )
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

On 10/31/24 3:37 AM, Leon Romanovsky wrote:
> On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
>> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
>>> This series is a subset of the series you tested and doesn't include the
>>> block layer changes which most likely were the cause of the performance
>>> regression.
>>>
>>> This is why I separated the block layer changes from the rest of the series
>>> and marked them as RFC.
>>>
>>> The current patch set is viable for HMM and VFIO. Can you please retest
>>> only this series and leave the block layer changes for later till Christoph
>>> finds the answer for the performance regression?
>>
>> As the subset doesn't touch block code or code called by block I don't
>> think we need Jens to benchmark it, unless he really wants to.
> 
> He wrote this sentence in his email, while responding on subset which
> doesn't change anything in block layer: "just want to make sure
> something like this doesn't get merged until that is both fully
> understood and sorted out."
> 
> This series works like a charm for RDMA (HMM) and VFIO.

I don't care about rdma/vfio, nor do I test it, so you guys can do
whatever you want there, as long as it doesn't regress the iommu side.
The block series is separate, so we'll deal with that when we get there.

I don't know why you CC'ed linux-block on the series.

-- 
Jens Axboe

