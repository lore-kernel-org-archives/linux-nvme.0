Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2324C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:31:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF8D6138E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DF8D6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qY0oemwdfmf4etC8fNQbsvII1Bu2jvDIEYT3tGgEWnk=; b=KVplk0DmoVYhzN
	l5l0JX3LfVdBLrx0Cu/xMs9m6AYlXqqOalTOxm4KUAS1Czq4fbKbPtQgs1THWVQ7fmunUIo9P6trq
	exeAuE+2BuRk1PdxN0RUa2Ux/c8kNjOFsQV1Ecnw2QjHXzC4srSrbuXgEEQr5QNg3NihfD/PIRToE
	3bkr75DE66TKGD25A7KbZE2xHePAMHbQ5Zp4BUl0RVKjzZc1ex3E8ftgcox3KaD7v9c4MJ/gx5ogy
	90oygDanjwxHP0b0renMUHuLciJxW2lpMNCfxmbXnQHsmmOVertaYsbn0+06dnx+O3CtPvV4JTbAF
	JxAUKfwLbljtwEKAkdsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVhAR-00COBP-IZ; Wed, 29 Sep 2021 21:31:07 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVhAO-00COAJ-BE
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=6tw6VIf8QZ1mlsWGh+KwACIkxOMm5AZtflXeMzWKDvQ=; b=G14JPhTMh4902E+4gQOpPCi3NE
 bFxLHYjwVMdykIibHNGwwk/pfJGXatmfFScbRKqP5T+6cgkMlic66K1TnPj/+BC8j/maeAvLYRotG
 ORzZWzrzAW3Hz0kwwzy5NnyxHGwS6X410iNmK/7XOdakgXOPRmnlXQX4li117R5c5NTEe5AyXJctp
 I447GFVyTPVitNyLXfV4nNhxBdpafdYHIClVsnA/j/MQ6D+TDBXc8NapePSVE7WVhVJYba8tP0aDK
 j2NQQUrSiYHc+pbO0I+HvFF472sYp9bNn/BqdE6Soub7pluqmdrMQykwOElaEYZym+pT6Ga9TEQYr
 5xy7m3uQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhAB-0006Lf-1O; Wed, 29 Sep 2021 15:30:51 -0600
To: Jason Gunthorpe <jgg@nvidia.com>
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
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
Date: Wed, 29 Sep 2021 15:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928220502.GA1738588@nvidia.com>
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
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_143104_398088_4A67ECBF 
X-CRM114-Status: GOOD (  18.04  )
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




On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> 
>> +enum pci_p2pdma_map_type
>> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>> +		       struct scatterlist *sg)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
> 
> This has built into it an assumption that every page in the sg element
> has the same pgmap, but AFAIK nothing enforces this rule? There is no
> requirement that the HW has pfn gaps between the pgmaps linux decides
> to create over it.

No, that's not a correct reading of the code. Every time there is a new
pagemap, this code calculates the mapping type and bus offset. If a page
comes along with a different page map,f it recalculates. This just
reduces the overhead so that the calculation is done only every time a
page with a different pgmap comes along and not doing it for every
single page.

> At least sg_alloc_append_table_from_pages() and probably something in
> the block world should be updated to not combine struct pages with
> different pgmaps, and this should be documented in scatterlist.*
> someplace.

There's no sane place to do this check. The code is designed to support
mappings with different pgmaps.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
