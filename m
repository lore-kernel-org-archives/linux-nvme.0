Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:55:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F001564F86
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F001564F86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lYWsbNdHvI5jGCOTzI2sMjKMQWq+Mvl9V7C1bGx8Dfs=; b=PgweACKRgeUbQs8TAaCd//HZY
	YGTwXIhmQxrr9CBAm7q5QwFTwGbW2MMVRtTYfOnFeg3xVVb2CeF69FFvCcEIumwsfvkVADwgrjtZv
	qEwwxtU+fsZnsXPF8yfS353QVWBqJn3lk6KHiDD7/2yoYb0qChIeMk4ESmE4A/fteRqiOsJA4mCrd
	Mc1pFA7DqPZUBL2SyVWiQ2xO98y2c42MaRfYk5A2b0jPeaZrHks96aezgcYrf8i7CUOqN24gt54y1
	eNvRIiq1A1Uk/7c+Ack5D7MF5QNCIfbwrKlLMcNEjBCVjEwGJ4v8FRs2JvcRCyQWNnX4uO8K+ueoR
	x+DH8E6XA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKop6-00COlf-SN; Fri, 12 Mar 2021 20:55:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKonJ-00CObl-0H
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 20:55:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=CGrXx6tnunS4rU4vJV260ajUW0JSem+Dld3wlshcr6w=; b=BDbN0bC7mvuP4MZ4/ukk0LJPNY
 DPviP0ZYyTMeFAwbu8j5dMB7b2KzG2FZ7qIkKt0NUgGiAf1lt0M1PYF+gfW9IiRlBWt46STFG4T8J
 cZYMNg2vCeXa+Q8UWw2v2fJVgGu+2rbQWfbc9Xj5/D0yUfdNA2Z63WK6JaJHzMzVN8MTGlNX/GGyd
 Q6TBybdzp+x5Va6pP4OJcp8RqQl1vJGjI19FBAYa1GlCi7QLe7TtG8cifa5LNRoBCRtHYgdC61UIV
 8pOHhROLuEdapKBxAr35W/geKRPGeu8OGDWP2al0JqcX1wjdqdeNjhR6T4IFhrJ7RbKjOU1kMSY/G
 DjXl5YXA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKon3-0002ZN-Ku; Fri, 12 Mar 2021 13:53:46 -0700
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
References: <20210312203936.GA2286981@bjorn-Precision-5520>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b7b61f6d-3a94-3539-f7f5-425fbb1a9dfa@deltatee.com>
Date: Fri, 12 Mar 2021 13:53:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312203936.GA2286981@bjorn-Precision-5520>
Content-Language: en-US
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
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_205437_243739_6A3E18B4 
X-CRM114-Status: GOOD (  14.26  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-03-12 1:39 p.m., Bjorn Helgaas wrote:
> On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
>> In order to call this function from a dma_map function, it must not sleep.
>> The only reason it does sleep so to allocate the seqbuf to print
>> which devices are within the ACS path.
> 
> s/this function/upstream_bridge_distance_warn()/ ?
> s/so to/is to/
> 
> Maybe the subject could say something about the purpose, e.g., allow
> calling from atomic context or something?  "Pass gfp_mask flags" sort
> of restates what we can read from the patch, but without the
> motivation of why this is useful.
> 
>> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
>> message if the buffer fails to be allocated.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks! I'll apply these changes for any future postings.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
