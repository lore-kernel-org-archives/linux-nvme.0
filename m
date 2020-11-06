Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8376DC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36EB208FE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zawv28vY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WEavvMGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36EB208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JNvvOBb1TJ6Xwb86YiUqth1KyiJA4bcjfUB2shFdaaw=; b=Zawv28vY+emq+bEF+DlzYzHYU
	CAguujvSVR6YyFXVbEljyeA7WEBTY/rhBYyJBJ2Rj84CfGN4pmQ/GPpGumQyJjNCr2t2TS8ObgCRD
	OTdcB4KPv57Ab9N/4RvtqEFFaFT2l405hmXwKG5XSFNf4nYo0ne0fsPVc1wQb7R8zfWyDwz7WHmcm
	VVdwlC4QTvgjsxAp46OokNdLdgX8veeKy3tB0kkbuR0E6AWkoYHaR97rSGNRB5KHdD0MxopKt8CWA
	P6qKT7x4lwN8i/lWqdZuNIiroEg2g4SZs/JiZYafRukZLFot6g3rJ4cEXVuNSlJjQPzvNqGBXrQGT
	S91VW98YQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb6LW-0006AA-6J; Fri, 06 Nov 2020 18:20:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb6LS-00069K-OO
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 18:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4c2lQ6ZJoiJD4wddIsh1sqnOjISbk8NdEHLgyMHjsI4=; b=WEavvMGUHHtVS6NthMSIjYgE8G
 m2Shk+887YnWyl84qAu5c5aSnwfmdgsQkwuV6Qk/VTpfpITmSKpZTStz2VoJeuvrgKYFgbkpcC2x9
 +Eygs4xkSnIjwB3jk8TQYbV+xWQY2KzZLECeTap/XHrhF7RfsNefRy2cKKo9kcYj3Hkd43uD6lH8r
 UeDxe01Yy7KFTC7wo/J2Zw1d3VJYZkJMQ5JZSmcYq3a5l1dL0v2dLl8ounQVMEe9onzzakY4UYleu
 immFBl00AOuIB6Gr3JQNUHz9T+DktFRE1Gznw7frT3XHfeD8UYFSjQcgB6Z9ymXrL/hXHs6bQE5SP
 AZUhpu/A==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb6LI-0003vN-G2; Fri, 06 Nov 2020 11:20:09 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
Date: Fri, 6 Nov 2020 11:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106180922.GV36674@ziepe.ca>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_132018_810309_6542ABF1 
X-CRM114-Status: GOOD (  17.90  )
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
>> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
>> genalloc through free_devmap_managed_page(). 
> 
> That sounds about right, but in this case it doesn't need the VMA
> operations.
> 
>> Seems like it might be doable... but it will complicate things for
>> users that don't want to use the genpool (though no such users exist
>> upstream).
> 
> I would like to use this stuff in RDMA pretty much immediately and the
> genpool is harmful for those cases, so please don't make decisions
> that are tying thing to genpool

I certainly can't make decisions for code that isn't currently upstream.
So you will almost certainly have to make changes for the code you want
to add, as is the standard procedure. I can't and should not export APIs
that you might need that have no upstream users, but you are certainly
free to send patches that create them when you add the use case.

Ultimately, if you aren't using the genpool you will have to implement
your own mmap operation that somehow allocates the pages and your own
page_free hook. The latter can be accommodated for by a patch that
splits off pci_p2pdma_add_resource() into a function that doesn't use
the genpool (I've already seen two independent developers create a
similar patch for this but with no upstream user, they couldn't be taken
upstream).

I also don't expect this to be going upstream in the near term so don't
get too excited about using it.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
