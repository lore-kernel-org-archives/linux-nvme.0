Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6863C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB07561529
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB07561529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cMbJ8Dbg1yWIz7rsPVPXL/yx1RCdaoTIEGJDgmtQp0M=; b=AIN90YFuxxvV7v
	j4WYKvoz0G7r09Vuzw6UxKFAwVN60L4JHVRhAx87sDDK+ct8bcuhXN5BlcDWc4YRqycN61ZhLIgP1
	U5f05SdcwQ7WfTsSX1a/BGvpxYe2hIfPCbi5lVQrrekYhirsgfDTEuqsbUF5k6jX/n2WvSWaeSDTF
	bo5Enco5WJemVx/DTiEnF3AQZc4XvzpzzwDxc01PlCTFrQrK/998UvM4y5GlJqW8zjmCkj77zhIRa
	1GYwqr5ew6+MW2+3+E01PEPmTnbv3pOTzLKR9eD56MdOpocIh54vP0Dx5Zfj+uSpzAeRzJ/OGRKe1
	UvheOlYv1EQ0xcZTsgGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVhPv-00CQ3j-1h; Wed, 29 Sep 2021 21:47:07 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVhPr-00CQ31-Lb
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=E0+dWT8gAeYt6sxwFEz+vMLQHximHDqyya3XwSsMquA=; b=B1+ojUPj4nQ9gfTcjrhn2ItoGQ
 aINPbvBXV9Nds1L0hVw7x1w9p2f358U5Fu3wsB7LxIEcnVMidcZxVp9bnuYVbm+woQWShpT40RVzU
 OWcloGv5IVDL4LO1/uqKO7qJp8yyXESOWL5Pk908ezjO+8d79gGLYr04akWdskoQQITHB9DMMIHmA
 92BxFHqUONXLFywx+DHgJ56IhJUbz68+CmbfX8Rw8Ao+P9/K4WRFREHY1Dgj8ZBtJ3HAi1EpCtHUm
 l5AU9JEaCtAhOL0zCRMIIQj6PRFACLBxlb8WUFdKUs9k94DRCRe5C1KpsFdiatomWcFHdJ3AjXAfr
 abJCdzRA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhPY-0006ZO-78; Wed, 29 Sep 2021 15:46:45 -0600
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
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928200506.GX3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3dfbfb6c-321c-f717-8adf-a37956f15678@deltatee.com>
Date: Wed, 29 Sep 2021 15:46:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928200506.GX3544071@ziepe.ca>
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_144703_749875_E2CD9A51 
X-CRM114-Status: GOOD (  17.12  )
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




On 2021-09-28 2:05 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
> 
>> +static void pci_p2pdma_unmap_mappings(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
>> +
>> +	p2pdma->active = false;
>> +	synchronize_rcu();
>> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
>> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
>> +}
> 
> If this is going to rely on unmap_mapping_range then GUP should also
> reject this memory for FOLL_LONGTERM..

Right, makes sense.

> 
> What along this control flow:
> 
>> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
>> +                                        pdev);
> 
> Waits for all the page refcounts to go to zero?

That's already in the existing code as part of memunmap_pages() which
puts the original reference to all the pages and then waits for the
reference to go to zero.

This new action unmaps all the VMAs so that the subsequent call to
memunmap_pages() doesn't block on userspace processes.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
