Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 21:39:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D267C64F23
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 21:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D267C64F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rUbv3r/aFJAnGULBn+t67x80hTT5m+VmL6yDJnVBdv4=; b=GKaisaSLsBTTCEKRuiqNbHNer
	Sb3KqcAx+6/djL+TiMG1rccH92Z4pacGupnyJTx1XkweVEdNNGk0Xqx8OKjhB9aNkxKfCsqNs8zmS
	5GpzecXdJePr5l4FzpjfjZHhjNvUBaFcsFW8Cexd7b3FTbede/Oe1xAU9oJCUYuwEY/8AgxdWLNVe
	KOc45tKUhj3hFQcK/Ujaz3A18STlOnaurwWAOALFyRgEAwOt+IO+KmrF/0ZU2CKAG9XsQWnKU57pn
	hE+2ul/6gFkDfMlmkwpMyf1Owp1ITF5ecLzawhhoK4fiUDMg8BwOBUiIYvyp1uuNHWe/rwyyCjmnZ
	OzyPN9a0Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKpUe-00CSqO-HV; Fri, 12 Mar 2021 21:38:51 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKpTQ-00CSlp-8U
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 21:37:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=T7mzuRgHR5zyL13fGxYATb0PibzAkq1gophY5Qi93V0=; b=NljsSHJkFlQ2oulW4psgZdRBZa
 qgoQiY/5e6LFm23c9qIwGHKx59Rdscll0uQCdBksaP8keL4Gv+qXd6SpMzWE3c2KTPN+Yt7TkjfMD
 VKufm9iYy9S1kM3gq5EoA8X0Iwwk+BXaeKR2DtsJwSiGP5M99l11j01GzfuA1WhYodeMJwR9eULLx
 qMCAqJ61hDuiWk9NoL/OXxGIsON+G05ZxyItH2tyiPiUwdHuiVQZbuD3Gw6w7iSs3CxWor/qKRJ+N
 iHGSbxHK1EBS+HEejQDjnyuIn1A2bZ90d2L7GIQDkwb8bf9pWbOv+q1TJdhTOcLW3uuY5x0278s54
 XVUZIIjg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKpT0-0003Fl-Vh; Fri, 12 Mar 2021 14:37:07 -0700
To: Bjorn Helgaas <helgaas@kernel.org>
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
References: <20210312205707.GA2288658@bjorn-Precision-5520>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c252253e-5000-5d96-1ac8-90835c1a4eb0@deltatee.com>
Date: Fri, 12 Mar 2021 14:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312205707.GA2288658@bjorn-Precision-5520>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 02/11] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_213736_261606_291E591B 
X-CRM114-Status: GOOD (  32.09  )
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



On 2021-03-12 1:57 p.m., Bjorn Helgaas wrote:
> On Thu, Mar 11, 2021 at 04:31:32PM -0700, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set just get the first element in the
>> list. It should be impossible for the host bridges device to go away
>> while references are held on child devices, so the first element
>> should not change and this should be safe.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bd89437faf06..2135fe69bb07 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -311,11 +311,15 @@ static const struct pci_p2pdma_whitelist_entry {
>>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>>  				    bool same_host_bridge)
>>  {
>> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>>  	const struct pci_p2pdma_whitelist_entry *entry;
>> +	struct pci_dev *root = host->bus->self;
>>  	unsigned short vendor, device;
>>  
>>  	if (!root)
>> +		root = list_first_entry_or_null(&host->bus->devices,
>> +						struct pci_dev, bus_list);
> 
> Replacing one ugliness (assuming there is a pci_dev for the host
> bridge, and that it is at 00.0) with another (still assuming a pci_dev
> and that it is host->bus->self or the first entry).  I can't suggest
> anything better, but maybe a little comment in the code would help
> future readers.

Yeah, I struggled to find a solution here; this was the best I could
come up with. I'd love it if someone had a better idea. I can add a
comment for future iterations.

> I wish we had a real way to discover this property without the
> whitelist, at least for future devices.  Was there ever any interest
> in a _DSM or similar interface for this?

I'd also like to get rid of the whitelist, but I have no idea how or who
would have to lead a fight to get the hardware to self describe in way
that we could use.

> I *am* very glad to remove a pci_get_slot() usage.
> 
>> +
>> +	if (!root || root->devfn)
>>  		return false;
>>  
>>  	vendor = root->vendor;
> 
> Don't you need to also remove the "pci_dev_put(root)" a few lines
> below?

Yes, right. Good catch!

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
