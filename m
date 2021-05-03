Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55044C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:18:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FA261075
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FA261075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6sZOAxBpksCLXaeFVb00Pc4cfIBEcztIqg3hOaQEttM=; b=e//+xv7d//9A1R94uovfPmtOX
	UVDQSlKJGq5wa5Vwfzyg/1GkD14IYj7yk//mpDTfFzqiwAxhyFhs1E8g1QluWPR46MAPZtrU5WrAg
	l6lJSRpNUxmJPuWLub7k4YE9StbI4ov6UoWlZBVcNnE10OhsYaJP8oXqx1ZVHP2TO7a8Daxo+y0v7
	k/OgsQonWXljrz/r8cctK418kuDQSo8sQQWoYPJSka6lGK4LvGUvAEA7ZqzeohTcwzU6irU72soKx
	bbQT+9UTQTsxiJFVlanU31QAHBPxmOb+2ns/f9RFLILBZhQp9INOdw6UMrSKKlUyOBRqKyElpdJSm
	OZCD53mDw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldcCx-00EUpZ-Db; Mon, 03 May 2021 17:18:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcCp-00EUo9-JG
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:18:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=SAQ4S+jSIpU03o924OYwfD9SEbxJ72ZyqTFfTksfdhA=; b=QDU1Z2Ln8PUBqtM1lfj2l3+rPf
 XAQO3IlCOvH7bu0oREQDIXD+3RMMQoDXBuoj508CvpitKIHWgewyeORMj100cVI5Ued5b/5sQNwmT
 Z7+78F88+fn3zXmI1rJ7Uj5CPx3FMghYeFgxDG6ci8ZYQ3RGoFZFtOMdCsr+zoOW9LPj+PGJX39SU
 JBD5KXw47opknm/+KsvYhB3YE6ln07k2kq80BaqbZI0r26RLmHKnYL7AxuHJStS7fc8etUuQseVcL
 Vd89ZshJWIsEfK53UEVxRaUXMdiBNfCxLLPjGUcaI81iqc1TTJorIHDFbpXK1chgRhMh31Qhw6n4n
 DUBL7X+g==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcCm-003KyT-UD
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=SAQ4S+jSIpU03o924OYwfD9SEbxJ72ZyqTFfTksfdhA=; b=aHvkXNhJC0Th2xBJKUmBj+YFHL
 UzUUk1ISTbtYsp83553YSXXGRA++kbSiJtSN05jEXVqt9VEX+wniOJS1RplCEqtuDD5dEX6odZ4Kq
 cu222eZYaQudBjSH8A2rSJDXWW+51r3qeRWafwKoGAm6AVx0/RQ21Pp4Domc5hgQYrYZGJC3acctI
 oDyhQ6cbTWTz+4TBfHuPIS5Ncok4vJKWmc5qIIjxy5BONLC07sANEe9vDy3pqahAl0m4DRp8PkoaL
 1+iVIZ7RcwI7jzxYjW8Dkp9JZw0qq1u+WTSwK8ErzNEhrqQw5/H+bDo+O6nCitRx5LdA8d9D7PVCk
 nOiYSZ1A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldcCd-0005A2-F7; Mon, 03 May 2021 11:17:52 -0600
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
 <20210408170123.8788-13-logang@deltatee.com>
 <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f33a9cff-82d0-7a05-070a-8c6018fbaba9@deltatee.com>
Date: Mon, 3 May 2021 11:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
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
Subject: Re: [PATCH 12/16] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_101800_983499_25A48278 
X-CRM114-Status: GOOD (  21.34  )
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



On 2021-05-02 7:29 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Introduce a supports_pci_p2pdma() operation in nvme_ctrl_ops to
>> replace the fixed NVME_F_PCI_P2PDMA flag such that the dma_map_ops
>> flags can be checked for PCI P2PDMA support.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/host/core.c |  3 ++-
>>   drivers/nvme/host/nvme.h |  2 +-
>>   drivers/nvme/host/pci.c  | 11 +++++++++--
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0896e21642be..223419454516 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3907,7 +3907,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>>   
>>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>> -	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>> +	if (ctrl->ops->supports_pci_p2pdma &&
>> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> 
> This is a little excessive, as I suspected. How about providing a
> default .supports_pci_p2pdma routine that returns false, so that
> the op is always available (non-null)? By "default", maybe that
> means either requiring an init_the_ops_struct() routine to be
> used, and/or checking all the users of struct nvme_ctrl_ops.

Honestly that sounds much more messy to me than simply checking if it's
NULL before using it (which is a common, accepted pattern for ops).

> Another idea: maybe you don't really need a bool .supports_pci_p2pdma()
> routine at all, because the existing .flags really is about right.
> You just need the flags to be filled in dynamically. So, do that
> during nvme_pci setup/init time: that's when this module would call
> dma_pci_p2pdma_supported().

If the flag is filled in dynamically, then the ops struct would have to
be non-constant. Ops structs should be constant for security reasons.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
