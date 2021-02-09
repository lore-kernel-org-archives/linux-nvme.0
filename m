Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB65C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 08:42:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84F864EA6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 08:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84F864EA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uEzwo7LPEVB9Chl014AWRFT/zM9XW/TcVGah1FSTM10=; b=gx7yUd7e3/zNWwedUbMvopODc
	ooRxtrobpuVTDtJpAgrgf1kNxRj70gSRnID+x2P1YvpZTzFZSfQWNILX9QFDrbPvITHKavgq3Lyhp
	h+IGQ+nbXmR0TR8xOPzAMPyK2TumnN+bjIKIivgdnaBQiViAZqc1v8LN8xJJyixyvj4mYDcVK0M8w
	gfT/nroZDa4nDbhNhwC4eoduUIyXckqqt0xBIafydezje6y+HSzZvv7B2YVfiMCo/aZS7yPWNRmcG
	0hcInc8y3m2cINAnTHacwyh0O9NSv9SkR7le47xwvOzg6DAAHxHy+uh6YnPp+owWePCGKhT9HQ72D
	ZASuBx+Kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Oau-0002uX-4Y; Tue, 09 Feb 2021 08:42:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Oas-0002uD-0h
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 08:41:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 70CBD68B02; Tue,  9 Feb 2021 09:41:56 +0100 (CET)
Date: Tue, 9 Feb 2021 09:41:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com, gregkh@linuxfoundation.org
Subject: Re: preserve DMA offsets when using swiotlb v2
Message-ID: <20210209084156.GA32320@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207160327.2955490-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_034158_237729_1903201D 
X-CRM114-Status: GOOD (  16.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry for being a little pushy, any chance we could get this reviewed
in time for the 5.12 merge window?

On Sun, Feb 07, 2021 at 05:03:18PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series make NVMe happy when running with swiotlb.  This caters
> towards to completely broken NVMe controllers that ignore the
> specification (hello to the biggest cloud provider on the planet!),
> to crappy SOC that have addressing limitations, or "secure"
> virtualization that force bounce buffering to enhance the user
> experience.  Or in other words, no one sane should hit it, but
> people do.
> 
> It is basically a respin of the
> 
>     "SWIOTLB: Preserve swiotlb map offset when needed."
> 
> series from Jianxiong Gao.  It complete rewrites the swiotlb part so that
> the offset really is preserved and not just the offset into the swiotlb
> slot, and to do so it grew half a dozen patches to refactor the swiotlb
> so that a mere mortal like me could actually understand it.
> 
> Changes since v2:
>  - cleanup nr_slots a little more
>  - fix a check in get_max_slots
>  - add a IO_TLB_SIZE define
>  - cleanup find_slots a little more
>  - fix the nvme patch to actually compile
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
