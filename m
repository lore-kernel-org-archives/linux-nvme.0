Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3C7C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:31:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA3E610FC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3E610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/AT7JF/7pxwPMBqe24UXEItRkYWYoFCU21v/azbN0tM=; b=hIQli9BXlA28wTLZG+W3enx1p
	mE2RUqMhswL8DNLxnbfOQD9MZA9zbLtyZvchEAQOzohGEK9rD7K0pb+E1EZYWUtBzv0TlXKkLuO50
	Vtj0cFyKLSZv+6zUuRar1EEw2qh3R34JmQhYrpE14hkfY68fhkg3X7N3wpOqBMcEy3RRUNbALh9GW
	Gv3fH7G05ZhhS6FvCvwdz+fF/Hpul/7gfeTmJrC0wR5W7blxYf2TuLpQKNi9VmR2ekqpF/4plNvk2
	KK24Ahcs04Fr7iMrRrcr++SwQ5TF8lA7ZwmVOdAmjHyGWAwI+Hx76WKgCSxda9Z232bYcakW1TlKV
	t0RNlwJZw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddLk-00Ebfz-Ll; Mon, 03 May 2021 18:31:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddLh-00Ebfi-2U
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=4PPTHdFwsG/FNijX7QmJQU5iOiwqKMFkAEJmwyjdEcs=; b=w/S5ue8LRaid5C8hQuvacAnQf9
 NJjui6F0wSV2IDpGb17CBIzkBNHRpOY0cDoUo5uk5Y7U13oY4CR+sWlTYfLSOTpxnDXS+o8AqNHXP
 WfS/2Fce9lgTZHU2t+EMi2X4TgXrjmfm/Ad8NwkQ7juP20OBOVOu5uaMqi6S/JF3kXQmg+3XkOTum
 AWk4waOI3Geuu3NzSCwhKgFFYExGLSDErWRTg7cUQxbcGmnGdaHofbHHkSNTlmyo6VW9fPP4+WHXQ
 c1xnXrUqNxXRe0rGA3CzpqXOCcERE2am9jtPnZ2wxuB9mkalEkzvJ/EbE+hwNRNORQY1QEAtkHrGl
 iGjhHOKQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddLe-003Ogt-AW
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:31:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=4PPTHdFwsG/FNijX7QmJQU5iOiwqKMFkAEJmwyjdEcs=; b=pWmTqC5UhoOtIRbROwzaB+ZWE1
 wHkLmyIDKJxZsZDLxgnD6Z1lbkZNPwtAHMVRKSMIIb9/0maQTAXw7MDfHeL1hFkcrZtGYsLBetLNw
 j+7qzrbqYPpPmJ23hX6P0ls4TPaV0WkGh5DsW1oxoRADWAdB3nzhINiIOs20KiGt0t0Ss/9SfTKjF
 xUcrvgRWw6/OrYVY9rAMPwOmac3o7/upKHt34JkI38fv0Z+DSNGGCnloayK7gr2BXlP4k3imBeIB9
 +aWQrrtNiOEqAn3BuRX+uctRRjVm2wQnywiNbH3clIsf9tjw46NnASc/POq5RagQrKSkmCqLwk8Y4
 wNygqJ9g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lddLV-0000jc-25; Mon, 03 May 2021 12:31:05 -0600
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>,
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
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
 <20210427230113.GV2047089@ziepe.ca> <20210503182811.GC17174@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e3d55333-1e24-8dad-4a94-727bce8f776c@deltatee.com>
Date: Mon, 3 May 2021 12:31:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503182811.GC17174@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_113114_375062_DD4A2EB6 
X-CRM114-Status: GOOD (  18.57  )
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



On 2021-05-03 12:28 p.m., Christoph Hellwig wrote:
> On Tue, Apr 27, 2021 at 08:01:13PM -0300, Jason Gunthorpe wrote:
>> At a high level I'm OK with it. dma_map_sg_attrs() is the extra
>> extended version of dma_map_sg(), it already has a different
>> signature, a different return code is not out of the question.
>>
>> dma_map_sg() is just the simple easy to use interface that can't do
>> advanced stuff.
>>
>>> I'm not that opposed to this. But it will make this series a fair bit
>>> longer to change the 8 map_sg_attrs() usages.
>>
>> Yes, but the result seems much nicer to not grow the DMA API further.
> 
> We already have a mapping function that can return errors:
> dma_map_sgtable.
> 
> I think it might make more sense to piggy back on that, as the sg_table
> abstraction is pretty useful basically everywhere that we deal with
> scatterlists anyway.

Oh, I didn't even realize that existed. I'll use dma_map_sgtable() for v2.

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
