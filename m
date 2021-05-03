Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905E4C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:04:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C8F6101A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C8F6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PwEmJydyvWvDxRLnHc5OsWbMfuB09+lFMNi2M041y1c=; b=UGKZtJRCaXyyeJHi8qgTYOgob
	54cLSVFE6AEl8hea7PEtncFc6aLMzq8RP2YxIPhbhaa6C+qo94VwGkJCC3V5X2olDXGBf4axsIR1i
	UeFIvLl1EcMDzN0bOJ3F5hOGNYxYAUX91ePcM13VVbwlBKDx/gx62wGYi0BOhDNIpQCpisSud+jwM
	OSXq/dDEwy5s7fqA+Q1RMhcZ/nXEIU7WQCCYTHODPJWDYOWXx1hCSgpTn7LQmZvPcJSzgClB2knHX
	h9m4LIUWRhc/Fww9xoy2VZsCjYY2t01saB9GLZKGcOYuSoM6kqBPo6T+BKsllJGZiFl1waDHJpsIp
	Kp3NMzmGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbzn-00ETVy-M6; Mon, 03 May 2021 17:04:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbzm-00ETVk-35
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=XIo5o0eZ2ybUTNprcEF2/49WtyCaykR1qXGIExijWsM=; b=Zx5Z3JB+qS3dNXSeVw3jGL5MUQ
 xlqT/xTAO19nvcUYunivOPzKa+t04fhDNH4kKNHqvCAbI2hLAyD1ruDPMbLlS9ZXYud7ZYElmtJzv
 4T1mmMVWDlPXk18Nzz0kQmefUDVHO2cXMMEqbLttMxWrvaVEmp70Ak6H7jntGbNKRRGJcbuCYjLdm
 TkAHci8TugBBOp70HCg5DoI+STdKIicnXzVmoW1dxuGUJ4X6cgOEFBvoaJi+j0BiJD394FBa+z5oh
 ZYa8TIMJ7s3tlja9jmZNvZUcn6OPGvf7RYanLh4SZZtVxjmRN5NHRfYxgRMsVvsW0wCMSF6wuZ192
 kjFBEhEw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbzj-003JuK-KD
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:04:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=XIo5o0eZ2ybUTNprcEF2/49WtyCaykR1qXGIExijWsM=; b=A4opownLuMAvZjkxn/S5VlDlz4
 qED8iUdb0jEoi6DzG3q5SA7kp8n+oxHLhbgsHmFUrOLUwQFlzg1FKL0fq5PkdsBhHJzqb0XviPegB
 kKRHngxYkYJ0UpPyjCO0lOMylnMndCw8cb5iA/v+hS3jma7ltHNInla8vLysBcmccx983fL/js4MY
 lPvFn13ECitpdcjFVe84V/mNNGwhgHPrgKLAxqbjwODcoPUPBoYb1uT61RMyXvJXAK4g98T3HsqhD
 FQzLgskh7qEpkiRSBuYU5Blwu7PNIvF93A+JxrLASdf+M6KJe0wh6+dC6naKCDSvBhDzOiFHiKtCi
 3JIqatrw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldbzZ-0004qY-4w; Mon, 03 May 2021 11:04:21 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8de928ab-2842-dac9-07ad-a098124f791f@deltatee.com>
Date: Mon, 3 May 2021 11:04:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_100431_675736_62FDA9AE 
X-CRM114-Status: GOOD (  14.41  )
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

Oops missed a comment:

On 2021-05-02 5:28 p.m., John Hubbard wrote:
>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
> 
> Is it worth putting this stuff on the stack--is there a noticeable
> performance improvement from caching the state? Because if it's
> invisible, then simplicity is better. I suspect you're right, and that
> it *is* worth it, but it's good to know for real.

I haven't measured it (it would be hard to measure), but I think it's
fairly clear here. Without the state, xa_load() would need to be called
on *every* page in an SGL that maps only P2PDMA memory from one device.
With the state, it only needs to be called once. xa_load() is cheap, but
it is not that cheap.

There's essentially the same optimization in get_user_pages for
ZONE_DEVICE pages. So, if it is necessary there, it should be necessary
here.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
