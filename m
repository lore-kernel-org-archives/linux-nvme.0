Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E75EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:33:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4494664F2A
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4494664F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iDgOLn9WvAJf4HVBs28o9Zib2Mniku2U4/FJ2OeWsnY=; b=TVIVWwW70DK1U4ileqEIM70cU
	v74r22pPYkGGS7iJkGDqZL4J+qWXEQrmNhsxGrApB3Oup2bSi5EjSYuXdcquHMJB8NWBbuC6ZG0pA
	bqw81kHzHdt9KnwLpcoJiy1/gBHM06gOD3e59kzsdZrxxjHcpmFONKqgyiDUj+fItj7tRGmeOecho
	w6mTre+A/nXVFxZZmQtPyASJ8QaJUyEhCy6/hp89aTofYDTsUZGCWkD+gmqIom6mGXI/jASYY0QC/
	xuUeAmmdMqnm0jIhe7M3W6BBXu9powu0+cPLCyrD8tncYo/87YtGnaevtrLj8fxVCxOFy4QOkpjmP
	etf8LA4TQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLq9p-00GMaS-O2; Mon, 15 Mar 2021 16:33:29 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLq9l-00GMZ2-OY
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 16:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=25tvzr6LDKuaRWZ7Kq1InXgjrQLBkOCY64hHowQXZig=; b=jd/7txTKwBaK4XM4L4pEdPfaXK
 j77z2FSuQPygPyzOaNtQeB/WuPI0mEHeLQ5XoVaOvM0peJGMT0rSFK7QLdYPovQdiR6d9crYwP30V
 U3qzhU7lI4cnhPY5eLbFwsQgHc3dgrwJ+5RCrXGFRhWPpVYBx20B8JOfELVsToLgjg+JhMv9AAQoV
 QXi+qBm+8NQLJ8YR2We0YcMp4QAshPbXnXH9nMM7W7FgIHCSgDMML5rQNraVpwyWQFm6LURTNIcjG
 M4ZrRp9VjFELAy3KrIPg5y1v+lSFYwe8hnogW0iDZtEp5btt8nr/QzFZs11lfwZQdVaCWefOipyWS
 LCYU1tFQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lLq9a-0000OV-Kj; Mon, 15 Mar 2021 10:33:15 -0600
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Ira Weiny <iweiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-8-logang@deltatee.com>
 <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
Date: Mon, 15 Mar 2021 10:33:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ira.weiny@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_163326_172007_A4C8A0D7 
X-CRM114-Status: GOOD (  12.69  )
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



On 2021-03-12 7:36 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:37PM -0700, Logan Gunthorpe wrote:
>  
>> +int dma_pci_p2pdma_supported(struct device *dev)
>    ^^^
>   bool?

Sure.

> 
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> 
> Is this logic correct?  I would have expected.
> 
> 	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);


If ops is NULL then the operations in kernel/dma/direct.c are used and
support is added to those in patch 6. So it is correct as written.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
