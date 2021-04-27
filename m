Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA213C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47557613F7
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47557613F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=457vUk3OPJmBJ9YxErVCuTR8nm7GxqeIc8FMquMP2CU=; b=BBEsebl0iIssRDf8LKxby8S6b
	uRG11OHAMgxPsONsE7xqSCij8sG7lwwjyq9JaaEu3yFbFjMHyCwBNTqTUFSWw7ghDHumgEr1rfVxt
	orXUxy9EFURJuGoi35eoMJzJKZIteKXVGUqjl/nGtMsF6yzzis+j7wZLWG8VzI3R2KorWwrzoMaF7
	SV+V/yOsgCeS4jpFpWIdyNPgZfFPO5PfgqVcYtpTAWhphvwCO+2IbcYe5YMpiXOGK16hKepOMDqzH
	1wiOTFmJs5zOjJ2Yi4Mo0s9E1wKx0NkqPIgj5EqLNeliI6HJDeYN9K0g1iLBmF1M8HTshpLPJbZE4
	OTkWjBW1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWgO-002Nyx-Hh; Tue, 27 Apr 2021 22:59:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWgJ-002NwN-N2
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 22:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=yfDJcXRXLcFqUpWKFnDEug6ObcuKDigbRQxLqk4fhDY=; b=MH9LPrvudUSSDHJhrbTU2n7SF6
 tiTBH24jo4vlfXI66C9HlSIA4zihfxUz70EfZFifmt/B2UXBmntD0Cd4LYv2kZ/ATBCyVmwRdy9bc
 woj42qNONCgdhtvOq4MgamslRPENrr/Iu/+DuPlATCfO+j2ddToM5Nzxtmvfk+lbFzo2LEvH+XWVn
 hARbaVKNStN56TGV/vC+F8+F3cBysp5xo4RyfHJbSPBDoIWTk5Xhxdz2sgfDRfrK3QNtCAhd47OOS
 svXZdJp+FVEnv7QWiJBh09/64ErkoIIUNZ9sK/nmgIIKbCMLXQsb6TIbAxRFVaoCNDrhskR3tne7d
 IKU4+9Cg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWgH-00H4hx-5l
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 22:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=yfDJcXRXLcFqUpWKFnDEug6ObcuKDigbRQxLqk4fhDY=; b=sbQMyumPhi9BO3PW7BbH7jx3Mv
 vyQd71v56wBfsn24nwtkY+oIQgX3d3l1Ef2xR/D7FmPPejRkZzxHW3lZYylXqntM3wayVT8xUbSON
 pRu0g92wUrYkY4mSSqIOYl5nF3ZdzT0niosmL6qBWRsJuD7/K/AvnuHQmjnHK7oloxX99WCDjqOI0
 cg5+SNiz8HchO6MM165oba4v51OTzr/KDIokovNCY/DFWZ7sMQFW03g7hYFCoWTz3ocn/dosmVMEZ
 sGBSFJDc2fGekrXGh7GNV2q3EeYZREtOFpzZ4vfUtHADST8VMXbeGXWLL0y5KZxGTJ2ejJzeaB2up
 1+e2wlfw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWg7-0002nw-DI; Tue, 27 Apr 2021 16:59:40 -0600
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
 <20210408170123.8788-12-logang@deltatee.com>
 <20210427194337.GT2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4e2537b1-21f3-f726-07bb-91d086e6d124@deltatee.com>
Date: Tue, 27 Apr 2021 16:59:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194337.GT2047089@ziepe.ca>
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
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_155949_244927_2CAC90AB 
X-CRM114-Status: GOOD (  14.47  )
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



On 2021-04-27 1:43 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
> 
> I expect P2P to work with systems that use ATS, so we'd want to see
> those systems have the IOMMU programmed with the bus address.

Oh, the paragraph you quote isn't quite as clear as it could be. The bus
address is only used in specific circumstances depending on how the
P2PDMA core code figures the addresses should be mapped (see the
documentation for (upstream_bridge_distance()). The P2PDMA code
currently doesn't have any provisions for ATS (I haven't had access to
any such hardware) but I'm sure it wouldn't be too hard to add.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
