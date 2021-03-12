Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F33C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:57:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAC664F5E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAC664F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=oz7ouzmnhRwOl43mBZgtfRlMf8+h57p+PftFKW5zQZQ=; b=IOp4sJRMCeajcGzAuqQ+g2adk
	r2i1Wtce/fcw+oDQFFR8PLIqU2aBDiZhe3ODbyNqg1fTCX9Cs77snT2LeSGP4O1v7Xpi/QcktHTlw
	uLeIivsu+d6F8osizqGGXkkPJo/5d+i+wFKnVGaDx+wWEM2fzvDK5FEkl2VpFPUXfoXLx9/yEkADl
	2anElk0+xwdm01TClFh1/THiKZMPHJTPwoTjHHQfsIAvsJMzcYnFLbelo6/STNkV2FEG7gURNy3Xb
	odCLmc7UJdLePGEH8FLkYkDa7HTiRNlEs2RYVwBJtiko0BW91JLRTPxEZ7CqD5aTerghaMvqmE/8Q
	hUTgiF1DA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKoqn-00CP6T-Gx; Fri, 12 Mar 2021 20:57:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKoqN-00CP3F-JY
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 20:57:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C09564F87;
 Fri, 12 Mar 2021 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615582629;
 bh=mkL75zFRcvY7SDVV8rIsNBThP6Ch2Zj5Sc2UsAwvmCY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=kKZvn2V5xv7vpfX93Th5HlKcyhtTFfyTOdhE+m5fKiVxM27wSYf500/9OadIahsw+
 oEGYQIHa1AwIK5CClP76fHluAH6DgvHGmwD1Kea5H0lGK94aaa2xCgbL6GQHBkCRBy
 fVCGSAVP/trm3ZEI5cH7YCoGdMP86GqMr+tM1r6Q+i+i6nEhMLbeEbyGFsvblGKgXb
 xQ672JWkV5EhfxHIkbYo60ElXUtpihbb1u6Rtm7tTANTg6lC/odVOR3a1b0iFOziBY
 eq9ls4SRmtP/ZzQ/Cqg3h/hLa//KTnib5Y9jqx7r0b4zd9zW8JIrje6QXqM4nEM/hW
 3rwqhKzBPmI7A==
Date: Fri, 12 Mar 2021 14:57:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 02/11] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
Message-ID: <20210312205707.GA2288658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-3-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_205712_440580_FB879366 
X-CRM114-Status: GOOD (  24.75  )
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

On Thu, Mar 11, 2021 at 04:31:32PM -0700, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
> 
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set just get the first element in the
> list. It should be impossible for the host bridges device to go away
> while references are held on child devices, so the first element
> should not change and this should be safe.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..2135fe69bb07 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,11 +311,15 @@ static const struct pci_p2pdma_whitelist_entry {
>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  				    bool same_host_bridge)
>  {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>  	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>  	unsigned short vendor, device;
>  
>  	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);

Replacing one ugliness (assuming there is a pci_dev for the host
bridge, and that it is at 00.0) with another (still assuming a pci_dev
and that it is host->bus->self or the first entry).  I can't suggest
anything better, but maybe a little comment in the code would help
future readers.

I wish we had a real way to discover this property without the
whitelist, at least for future devices.  Was there ever any interest
in a _DSM or similar interface for this?

I *am* very glad to remove a pci_get_slot() usage.

> +
> +	if (!root || root->devfn)
>  		return false;
>  
>  	vendor = root->vendor;

Don't you need to also remove the "pci_dev_put(root)" a few lines
below?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
