Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B1CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 22:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F065F61452
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 22:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F065F61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=od1RDmxmj5NpLUYJAuUbQ0GR9/Kq/rGvHjZhMsmuHw4=; b=SNNkjluwlgwOf2
	i7vcvGvLHamK5e2rUJMNcyTw1WdozIp1H2BOPyJrxipu8/VDIucQm/YSzbHFuwjAsFK2ndSaUoEXa
	3kWE/PesJGw+heQj56dspXpv80UWYH6RF+3HYOWCFNyohVM1dKDHaxjNLCHRlE1QPMvKm/xgU9XWU
	TllXTGziSNvVO0EhPR+14MDlXAQknUvPW/Xs02ilQAm3ROPSwcL98YBky1EnE94e0L73YRjiswZTA
	bNOx5eh1qtCpEmh1fpGU1AQO/JdGYRon92lZC6qvGmJFiBOOQRjUpaOZlXbgj39g2k9/viu5saufW
	qhbbSx1FltmU2u1OhiWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mViVH-00CYWy-Pl; Wed, 29 Sep 2021 22:56:43 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mViVF-00CYVo-0h
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 22:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=gyI1iWTgaQxXLC0uh18K74XDfJOQ35Yd/0UtBH7oL2Y=; b=VyEMo1To4bpq3hE/xr6uacN63S
 sFo8JLN2lg3Nt7NjJD/RyCHJ3xIMnFvvWyJQJDzNwEv5i2F31KL273mFPxjWpXsi8VJB7W8aU8iuX
 UhU9U05GQuc4pdzxedOdf9TAaZLqlqelpLTq2C+UtXnoObaPYB2yfaH1YLeAfoLoxcX8gTb/p0aCT
 164B3Y/N5rl7w8PhlikTl4aQ4jNqsb1jJoT2BUjjfIZtVih+GwnXuoh5B3mbUqiLvXqgCmdNOOLxt
 Cw4AtoX4dmjtYkv8q48FbqX8M5k1KxfxuoejCgFSCUcvy99IFnZpCWPQA7rx4nIKKrpUNT13PyREe
 /6e6C7DQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mViV2-0007a2-MS; Wed, 29 Sep 2021 16:56:29 -0600
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
 <20210916234100.122368-13-logang@deltatee.com>
 <20210928194325.GS3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7bbe021-9a0c-1999-0a2a-ba249578c9c7@deltatee.com>
Date: Wed, 29 Sep 2021 16:56:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194325.GS3544071@ziepe.ca>
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
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_155641_077055_BBE02108 
X-CRM114-Status: GOOD (  16.84  )
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




On 2021-09-28 1:43 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
>> is no longer necessary and may be dropped.
>>
>> Switch to the dma_map_sgtable() interface which will allow for better
>> error reporting if the P2PDMA pages are unsupported.
>>
>> The change to sgtable also appears to fix a couple subtle error path
>> bugs:
>>
>>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>>     that could have been incremented from the original call, as
>>     well as an nents that was not the original number of nents
>>     called when mapped.
>>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>>     were unmapped with the incorrect number of nents.
> 
> Those bugs should definately get fixed.. I might extract the sgtable
> conversion into a stand alone patch to do it.

Yes. I can try to split it off myself and send a patch later this week.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
