Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84269C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:07:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC362313E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC362313E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7h2czsICRzEEJT0MS19M0BmqZgIGhj5ucWy8ppBAFSI=; b=M02O/qorcl1C3tXvg+nl6y3T3
	FmMeKS0tVyui+mBuC153KOJISHHHntk7KRCVjxR5QqK0zGOgYa5U8v9jX+opYyvJfia/g8J1p7C3M
	8IN5wu1UjYezb9KsVTPLu2kgcjAt5HcfJhkKNlIdK69GPspK4Y1j3bQR2csUZabEiZkMVFwTiQysW
	C3+yiEH0kTvK/xst/AQ0x9kq+6NCRkEpGe/euR6MRJ6mFu4UQzde1zBtsL3n2dL0LzNOjkXpD2Wt1
	fz1P9/fF03PaIy4WC9NydYDHpB5MzKUQog5DA4o4aEwKsd5VUnexWygE5Hio56Bx193AuLdcgllCk
	Onlubn56A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knBM6-0004wW-Cc; Thu, 10 Dec 2020 02:06:54 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knBM3-0004vW-3l
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Uml3Mld7EOkwqbJ9IqsKe3VTCWPV7AsDblFsW7V45yw=; b=q5k3ZedQmC5MXoHZ2KUQBWN2Oz
 hquggxONMg9OTs9nTIGThURenvo42BA7KY08/toQkCBcNvHJmSs/mKRb5vQ9qzVX/OQgeho0G6WdO
 9XxCBe11YKfR/VlCB41qkLCtIUS3xCIgIfqrgZQRZ2bxV+gFQp/JjVUm8FS1KWKPLt4w1vqalq2Y+
 Y5a5In4k6tV2ekjPZBMOl4ZPDqqXRiRCqiRxzbFMyXp5HhBTRqxZK/1xsBeK1Vg84BAWQx1sItp/D
 Jr5RGFJd+FK4oQ14PB9CQP62D+M45qewCwQT+yFwRJ9FzoW79zsE6chP5NWVZBjIKnO41O8XhIL9u
 fFBxnSUA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1knBLs-0005p7-VP; Wed, 09 Dec 2020 19:06:41 -0700
To: Dan Williams <dan.j.williams@intel.com>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com> <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
Date: Wed, 9 Dec 2020 19:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, jgg@ziepe.ca, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de,
 dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_210651_178663_AE833759 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Linux PCI <linux-pci@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Ira Weiny <iweiny@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-12-09 6:22 p.m., Dan Williams wrote:
> On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
>>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
>>>> We make use of the top bit of the dma_length to indicate a P2PDMA
>>>> segment.
>>>
>>> I don't think "we" can.  There is nothing limiting the size of a SGL
>>> segment.
>>
>> Yes, I expected this would be the unacceptable part. Any alternative ideas?
> 
> Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
> segment-pages for is_pci_p2pdma_page()?

Because the DMA and page segments in the SGL aren't necessarily aligned...

The IOMMU implementations can coalesce multiple pages into fewer DMA
address ranges, so the page pointed to by sg->page_link may not be the
one that corresponds to the address in sg->dma_address for a given segment.

If that makes sense -- it's not the easiest thing to explain.

Logan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
