Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F1DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:56:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15718650F6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15718650F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BuHey4SZbxH5u59QJtn0dsYOSaPg2eoH03huNJWvQS4=; b=k+nv+k8AUAGgwD3aMkC++EoiI
	lZ8l+Y5I2J/1X71ZaB5nA0LsEj6qDJcnIKtvnQasQBmn0pIHP+Qn5kxtfY8mbatBYwQzTrNno+Wl6
	aSS87IXrENI5DIZ1d4OMuEOAkdt5CHKtJVJe9mdZZRmxzMHnnBKuXs/eTfuATXpe925jautOH+CNA
	rIde7JNNkdIttFH+BT75B0BXiN30JMYnYGi+lcvM3Q51RIiqDpxRQK/vmNkJTxB8lV9bCGctyYWbA
	nFVgms7id2p19x/4Wt7fNg/OLtqTHABhTnU+ZI4bIb0uZN7JY1+/vd2MERn2Biq7i/1spoKC3HrPd
	V3NaKGD4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMC2q-0019wj-JF; Tue, 16 Mar 2021 15:55:44 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMC2I-0019mh-Cu
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:55:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=oFF8o/RVegrG3G5YG5dTK44WOWDv57bdoGVgR2ktNWc=; b=dsqiw2UqRHpc2m6czITifyPazC
 l3KC3T9j57KTF3XoWiyV+LPgw4lbLtgOWKdd598bgRLfvrtkF2yuQDTcMKhGG9vB+KiBIJHVKMqOo
 mz5L+MEsdNsRbgo0gzz/8XPLL0CEathKtt+ZC61Qu6pAMYwbwCzqpb34Hfj+pEJnqN+lbJ6lzm9Ih
 wMlXJ7CnBmVPIFSao3qYHQjM/uSXXdMUZqbGyOWB+ccwh0ZmHoBC+XWjsMT4ETu8VxhHGEnyC4uu8
 9v/yv+i4wmpSzCRFdT+0I+6inCilQdZbbQP3yiENwxiLiBsWDTPHNXrs7QPi+fZVB9gawHTLngfEt
 /Q9Irqsg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lMC27-00012D-3W; Tue, 16 Mar 2021 09:54:59 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
 <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
 <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
 <367fa81e-588d-5734-c69c-8cdc800dcb7e@deltatee.com>
 <20210316075821.GB15949@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <093b77cb-e8b1-c8a8-620b-ab36cdb7f3cc@deltatee.com>
Date: Tue, 16 Mar 2021 09:54:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316075821.GB15949@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, andrzej.jakowski@intel.com,
 sbates@raithlin.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, jgg@ziepe.ca, christian.koenig@amd.com,
 willy@infradead.org, dave.hansen@linux.intel.com, jhubbard@nvidia.com,
 dave.b.minturn@intel.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_155510_918049_C34F0613 
X-CRM114-Status: GOOD (  13.47  )
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



On 2021-03-16 1:58 a.m., Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 11:27:46AM -0700, Logan Gunthorpe wrote:
>> So then we reject the patches that make that change. Seems like an odd
>> argument to say that we can't do something that won't cause problems
>> because someone might use it as an example and do something that will
>> cause problems. Reject the change that causes the problem.
> 
> No, the problem is a mess of calling conventions.  A calling convention
> returning 0 for error, positive values for success is fine.  One returning
> a negative errno for error and positive values for success is fine a well.
> One returning 0 for the usual errors and negativ errnos for an unusual
> corner case is just a complete mess.

Fair enough. I can try implementing a dma_map_sg_p2p() roughly as Robin
suggested that has a more reasonable calling convention.

Most of your other feedback seems easy enough so I'll address it in a
future series.

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
