Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA09C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855B06105A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855B06105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gpvfrMKJRYw6twhAxEagpGMA2eT292L0UDJ231v/gVY=; b=k8DdHR88oEGs75azMbPD9VZkb
	piydMjauDyZy+QLgGWHTSIPFYr1Bq+LnWGHgic8H6A+UXAwiiLFfNoOSVdWGX4p+norkiVRRsnz1E
	gSVKnXy27wkSjInKSnmuskQPAR/F3HJKv3IqzZBT+qhbQIyMEs+aP/Re/K1cuN5ONHGnp15YbW7jI
	4Lu4rXbwp2uhJoKkD+JtZmy1RHtDOFfT5b3pmzon7saK1Pwk+gnZkXS6jZx10xfOk1i6nND/QfKT1
	fynkcLHESw/5XYOvQJtVewsPaM+cR5TDUriHD4RS5TkKhIdPzC3/pqJFY73X/dKzRl1gyQQvhPavi
	lH9MrMgww==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWgp-002O4W-EE; Tue, 27 Apr 2021 23:00:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWgb-002O1g-Si
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 23:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=RGdRC5FBlsTWfpWtOgCpYwh/6l+bY/lLU227Fr0Oa7w=; b=oK1PKXLgC/RJUquKgFRHrXovwC
 loqFVOLEMxy1xz3BHPkyn2jddgoIATziRDnzb3kVUB5Ql9JN4we4dSIaRO11nmqqfG4y5YBYvM6QB
 zzbciQdDnI/Ays47AwXOEJtvwNeCVMhMnY4HWTffzTdZa/VRQ45vEQg7vUCeHpBM16Is0QRIpWwJ9
 yVToAjSdzcuyVrw0m9k6Qwv+FjQ49TdY6O3oAuoR2GqVHULcqTPz6Zjbx5Glj5fYSnDw0bpfqp0EA
 VF5FCubqO+B/XZ5s1CoagRAPq/dpgrUwa23U8NsVilOnRLS7betEVZbMyhSBuuFQqVd3XhLqvlKlX
 M85gZ4fQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWgZ-00H4kR-FB
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 23:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=RGdRC5FBlsTWfpWtOgCpYwh/6l+bY/lLU227Fr0Oa7w=; b=e1cQkHUii+OnXHxuzyVnv2FOWU
 yRhslccFTPCSUZBHv6r9i2BtLYMYFFuNX+vj1xNOq/lXobsZ3eYFuedGTORJxwDIMCEh7Qthqs1Q7
 RVxgzfvWzK3UWw1HMRbfVYTe3vQzXRIV/ILbih4akY/evNrEaGCAlfgG+L3AXOME+jur1eJqyKhD1
 TMGSqOXU7r9XcMpgA/2JBpdbNNP7X3lLSbdPwHl2H10OkRWO75ot4KGzAuXd2ZJB/tmfOyTGaMv6M
 ae+aEYfgGtkGVcUSMzK45Ps6AhzhkNnGarVg7/1Ky1Fn+SEciywNHOIOcE/kvvy4C616xFskQ500w
 hxifV8fg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWgQ-0002oO-8N; Tue, 27 Apr 2021 16:59:59 -0600
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
 <20210408170123.8788-15-logang@deltatee.com>
 <20210427194753.GU2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6e78cdc8-8189-b778-20b4-7a108e28e557@deltatee.com>
Date: Tue, 27 Apr 2021 16:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194753.GU2047089@ziepe.ca>
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
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_160007_517310_60DEA838 
X-CRM114-Status: GOOD (  16.28  )
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



On 2021-04-27 1:47 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
>> Ensure the dma operations support p2pdma before using the RDMA
>> device for P2PDMA. This allows switching the RDMA driver from
>> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/target/rdma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 6c1f3ab7649c..3ec7e77e5416 100644
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>>  		goto out_free_rsp;
>>  
>> -	if (!ib_uses_virt_dma(ndev->device))
>> +	if (!ib_uses_virt_dma(ndev->device) &&
>> +	    dma_pci_p2pdma_supported(&ndev->device->dev))
> 
> ib_uses_virt_dma() should not be called by nvme and this is using the
> wrong device pointer to query for DMA related properties.
> 
> I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
> everything else.

Makes sense. Will add for v2.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
