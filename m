Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC5C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 12:08:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6D264F5D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 12:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6D264F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D5okTxCSSOJjVDJ4RhXt1yrjuqDk6iagT9JXxY/Zp1I=; b=m4HTNBpKNvByKFXAxtbyKq4s8
	L67cZMdNolbVSeJUWUcma5j8mnYl6oFouO1albFBSGvWjmQtS7L6zz3oWZIcfn5ktc330ZrYGrWrq
	0xwOQo08yLZDqexF75fLqbmmc4IGtcrXYlB7T23IcxLGo6ckPm1fjP1OdpGYhWx7cUiMwWQwWZKeb
	NSvZhlJgVqpbL4t5hBDjUrN+Wd8bqHnBEhzM/IAoEtKDQ8unMBtJWq1oO1zbyopSR3dNdH2RcKCRx
	d/vEEkb3HBdCQoFA5ifr+5ea2YF3khhccWoc/oombTMcRAx+8V6SE4yqA2zxq3fohijTDtLn2XWLp
	zzWdYd0sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6uTT-0008Gz-6H; Tue, 02 Feb 2021 12:08:03 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6uTR-0008GY-Sp
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 12:08:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3261396;
 Tue,  2 Feb 2021 04:07:57 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D6C3F718;
 Tue,  2 Feb 2021 04:07:54 -0800 (PST)
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jianxiong Gao <jxgao@google.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
 <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a34328d1-3918-1eca-b632-57be6a40baee@arm.com>
Date: Tue, 2 Feb 2021 12:07:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_070802_003534_D827B736 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, Erdem Aktas <erdemaktas@google.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-02-02 11:21, Andy Shevchenko wrote:
> On Mon, Feb 01, 2021 at 04:25:55PM -0800, Jianxiong Gao wrote:
> 
>> +       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> 
> Side note: we have DMA_BIT_MASK(), please use it.

FWIW I'd actually disagree on that point. Conceptually, this is a very 
different thing from dev->{coherent_}dma_mask. It does not need to 
handle everything up to 2^64-1 correctly without overflow issues, and 
data alignments typically *are* defined in terms of sizes rather than 
numbers of bits.

In fact, it might be neat to just have callers pass a size directly to a 
dma_set_min_align() interface which asserts that it is a power of two 
and stores it as a mask internally.

Robin.

> 
>> +               dev_warn(dev->dev, "dma_set_min_align_mask failed to
>> set offset\n");
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
