Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF3C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 14:02:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523EC20867
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ozmOWgQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523EC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lafiJtYz6azJyImy9Fs5KrEKkKA+dP+RtMh2O/hB+4g=; b=ozmOWgQhvw2AvDqLAWFdD6Qoc
	C1ttrk6liKAoJpJtHiZ3L/Z/x+2t+lDUOn/Pdl77u8ckn2SdhT8VlcWBFbEjWS2aLITI9v//JcEma
	rwpe6GFDlb3OoyIb9eW7KCJ0pXYEIC7OQ9RfnPYmvcjik3WXDENow7/b6zWHJxz315V8YSYoGE1xn
	wNJMGpEhCHNZIoJRWwcy5uPB54WPGD4cHcjCWxBsjY5VhDQ7dluXz/9fS3xov1Wv4IO4RGxNnKZtT
	LKCXZlbDzuQ89Id0hnGVJapRL/8Bx0LJUVKoAsqPRxYu3g1N0wu3xD1vmvCSW5qnjCJGTkzygXhIb
	/h2Eb5K4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc7kb-0001FK-6Z; Mon, 09 Nov 2020 14:02:29 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc7kY-0001EI-Sj
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 14:02:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C77E31B;
 Mon,  9 Nov 2020 06:02:25 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383D53F719;
 Mon,  9 Nov 2020 06:02:23 -0800 (PST)
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com> <20201109091258.GB28918@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <491c26de-bda0-3266-a67d-ee2580559a54@arm.com>
Date: Mon, 9 Nov 2020 14:02:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109091258.GB28918@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_090227_055036_43CD1E34 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-11-09 09:12, Christoph Hellwig wrote:
> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
>> We make use of the top bit of the dma_length to indicate a P2PDMA
>> segment.
> 
> I don't think "we" can.  There is nothing limiting the size of a SGL
> segment.

Right, the story behind ab2cbeb0ed30 ("iommu/dma: Handle SG length 
overflow better") comes immediately to mind, for one. If all the P2P 
users can agree to be in on the game then by all means implement this in 
the P2P code, but I don't think it belongs in the generic top-level 
scatterlist API.

Robin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
