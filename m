Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B9C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1321F61090
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1321F61090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OPaD1jZeUtEgrvWc9iE5t1nnHwRbPQtYw62Ej9ckaBQ=; b=d8L5OfuTWCml/dz7fzEzrqmWS
	msNPYuxz1DPwE5fRw5T9f199px9jWlUQCIgQhqAEGW4nvkJJRxF4/fPUMJnN5koDjwHgFJCgEp8kM
	HUktK+RkVclO8VikZ7D7OSS3kkzmRvR1wwXN216cGyeo78GxtezM+Qtq1JlatxPWTxXnEMMjih3kA
	UyOoQJ45Ou2t/0gJSu1wjDIJXw+Q0DYaIQZH9Yy7Qd/AgCgcNeEF/6lz7PQFIK2KTmldp1yIsCXkD
	9ResGDa+n5yy7nPTBod3omNnznSEY5YLI0wwMUlK1wqg7j/EY1x0k7vzhm6212O+jko0XGPIzxTt3
	CCau/HCDw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWcn-002NTP-US; Tue, 27 Apr 2021 22:56:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWck-002NTB-Lk
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 22:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=9cMqKeVqpV09cXzdKEdeF1wGWj3NSvz6cLLXzNXUCD8=; b=awe2FWxdMb9Oo2Fu9O61H+j9/Q
 Eq4OA93S0TAcE+tLZ9xl00PqPZWUvDbxf6N7qBAS1FcYdy2HXD7rpC1HTzjcWxpQ/q7dKEqGuJ0gX
 LzjhyeBMgVbRQLZO3HTu5MlnIQB8K1lWrjv5kOT602wr1KFaZF16s3AlSwvUEvskq4AFQE+fvYpD6
 qPUTJMgbrH2w4LObUa4iBvQHuTe8qOwOCSrmoJMztHecPRMSoR00n6agC2u357u5DtaihT0ZvavU9
 dpR7AimB1OSuAqjvFy3/ddCCemnn5k+ehzGRO4llFpycYoXpt8/c9gUkUWQAxe0c1BFmZKfXKFMnB
 ayQ0vO3g==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWch-00H4OU-TH
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 22:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=9cMqKeVqpV09cXzdKEdeF1wGWj3NSvz6cLLXzNXUCD8=; b=bZ0qGVskfkWJrx7xQzfuMkoJWn
 uXsbXCfWUy5H+XPJj218MIPSekFTaV56i4dZC9FFheUYyXLbwiAPhK3Bq+k3tBDvz0B7hbOVfR/Pw
 rU0TsIsdHTeMVZuRSJHe4unPK2tJx/470PpEKYmwqqNM5SMKswk4DlpwIILF3MrN0C47OMfdXi5S2
 BmumlWMKxYppg3kVyzDdH2wUlAdUddF9ynHCOu6+qhXaeoKWzLwiJNa8Oc5YWsvB9LSQXNNpokW3c
 /UfXKIphBb3KBrtAfzVBu1rR4lQSws2cuqBfu3uWRWvY4NniZl2lxAPi8Nr5LTxNRFv7wpixJqrf/
 2mQpmzmw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWcM-0002ln-Cs; Tue, 27 Apr 2021 16:55:47 -0600
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
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
Date: Tue, 27 Apr 2021 16:55:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427193157.GQ2047089@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_155607_957183_F385E03A 
X-CRM114-Status: GOOD (  21.66  )
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



On 2021-04-27 1:31 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> +/*
>> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> + * It should never return a value < 0.
>> + */
> 
> Also it is weird a function that can't return 0 is returning an int type

Yes, Christoph mentioned in the last series that this should probably
change to an unsigned but I wasn't really sure if that change should be
a part of the P2PDMA series.

>> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	int ents;
>> +
>> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>  	BUG_ON(ents < 0);
> 
> if (WARN_ON(ents < 0))
>      return 0;
> 
> instead of bug on?

It was BUG_ON in the original code. So I felt I should leave it.

> Also, I see only 8 users of this function. How about just fix them all
> to support negative returns and use this as the p2p API instead of
> adding new API?

Well there might be 8 users of dma_map_sg_attrs() but there are a very
large number of dma_map_sg(). Seems odd to me to single out the first as
requiring these changes, but leave the latter.

> Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
> the other api entry callers that can't handle it?

I'm not that opposed to this. But it will make this series a fair bit
longer to change the 8 map_sg_attrs() usages.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
