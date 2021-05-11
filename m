Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99957C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:32:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA466117A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA466117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PzGUU1uW1ZTlEXnQdupvd8fbgz+FYiMhflkR0HkUoL4=; b=dvMbCPuIwlWq8+SoSB7A3oOPG
	sTVMm+r0r2WOoTDP7oVmlcgmBYxqiNkzkzijPO6VIDLZ8xWLPtlFaFAaYZHv2e1whBrLEMbh32lcr
	RQ+VjcHx5lXJtLHGYWydo4kD+wM9CRxZJoENALNzMSbhsdF6otLLWCPyf1bR/uyHV8eYHN6AwafFW
	F1DWN8nIBdca2woO6zeJ1bzN9TBY5QG7r3SaHcfRQQY3DbEkFYx9OoDVm6iN2Cpvl1kioaGlAsffv
	KFbq/6sYthCR2k/qkamaGadfYb17Lt0AScGMO4HbOFYneDXGTMDvBxMXwLOBdj+yhNTbOOrraPTwk
	N/xBxKm8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVJC-000kit-Sw; Tue, 11 May 2021 16:32:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV22-000h3u-1M
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Ymx5jystW5s8EPZBRHR4WsTKIk8IQ3Uz4HGrVu+VdWc=; b=Rw9lZEXnOmXqqJ5402gS/O+5hz
 97pz4lEPBGuQGwRunf9ztECz7W9jd3Bl9E61b2cSD9j760jDvmLC9PeTVi3epJWpaIlT/d9AKWJib
 LIpjJxoWBu6jQAJYr5mU27mFvirDse2fDuQHOWMoGd3/Mhk3/smPwq9P14ls/pCcNRM3IJdsQsI2E
 uVbSnixjuGN2SqpGkEgyx+maxL2lSM7LNRs/qvC0RHUdq2T+powa117K48s740pLOd5GgcnxW9JN7
 mGwWoVu5dZDAMz1Azh4xlk3RqLjhnJacFUUvYVhAvoFHtXFYSBT64eBIrP9EzmWJG1WYSY1dHwMTG
 cnWueMBQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV1z-009kem-Fb
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Ymx5jystW5s8EPZBRHR4WsTKIk8IQ3Uz4HGrVu+VdWc=; b=hX92MI8IYDAFgrof9DVT2uOU0b
 8bPhv4kGORr76XEMFxwmACnHHa/fI3xZANPeMf8DFf2u+nfJFyyzXvvhEEx4cM9EGABLTEfGioqXt
 Z/Sl8b/TrsPmc0Zdggnd6a4Aa071uVgQv70MVapxhACireL1cQkKucMJmIpHrHj7H3XZLFjeZjpTX
 4FMfsVi3BiCcbaJ4tXOPM9w9r0P9oEz6cRAFuAhfOfKgHBHvXTSHQo7+X36DbFPQPvu2FECcfS/d7
 5R+EqotBeW4C+luSP2De1znJnMp1NuFlq/yf+AFYQPXXq6/dorM+PRU3IbwblLDzIzkKcuqhJpKSR
 pA8OJzOw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lgV1p-0006b5-VM; Tue, 11 May 2021 10:14:38 -0600
To: Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
 <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <70f58fff-c228-e637-aef8-f404af2d2f9d@deltatee.com>
Date: Tue, 11 May 2021 10:14:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, jhubbard@nvidia.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_091447_529570_1618FC15 
X-CRM114-Status: GOOD (  20.35  )
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



On 2021-05-11 10:05 a.m., Don Dutile wrote:
> On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set, just get the first element in the
>> device list. It should be impossible for the host bridge's device to
>> go away while references are held on child devices, so the first element
>> should not be able to change and, thus, this should be safe.
> Bjorn:
> Why wouldn't (shouldn't?) the bus->self field be set for a host bridge device?
> Should this situation be repaired in the host-brige config/setup code elsewhere in the kernel.
> ... and here, a check-and-fail with info of what doesn't have it setup (another new pci function to do the check & prinfo), so it can point to the offending host-bridge, and thus, the code that needs to be updated?

I've dropped the bus->self thing in v2. Seems bus->self is explicitly
unset for root bridges. There's remnants in the pci code that used to
check bus->self to see if the bridge is the root bridge.

I tried setting bus->self with the pci device of the root bridge but
that just caused my machine not to boot and I didn't dig any further.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
