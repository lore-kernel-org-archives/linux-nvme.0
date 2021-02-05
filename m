Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E804260241
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E804260241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9iEf2iPLTziJNdE4B4acm66nPh92S1/tsGBtxcqMswE=; b=vHLMjUudaJP4riqXVAqfX3DyU
	DCLLrfnCjXgvjCdVLLdwbbVu+1evIWTV7aFPfzeISflmaH1cwB0Kj2Zx+JWnM9vExtnT0e8ICyabE
	bjERLZRxugUaj08f6ungZuEWXZcyp0RwNj9RpVgmg+EPMUhGS9PbBN0TIhI5fUz1GchUUGYMCiH9B
	W9zPisZMYJXDs7It7jBiEvk7VSz4MiAAIovKogGTr6s8CK5t5JrZRQiXUbnh1yKbM9wpzMlzkZrVW
	kMGJ1uVPbrEtHEz+6LJV3zKhSbtlmUrbIjdDVk/J2BNp6B+YjI3QIlXhzZhoCYFx+vC59EFGY+7jX
	CNep7RPlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xgY-0004RP-R3; Fri, 05 Feb 2021 09:45:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xgV-0004Pv-B4
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:45:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 78EE968AFE; Fri,  5 Feb 2021 10:45:49 +0100 (CET)
Date: Fri, 5 Feb 2021 10:45:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/8] swiotlb: refactor swiotlb_tbl_map_single
Message-ID: <20210205094549.GB2801@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-6-hch@lst.de>
 <f60ddc1b-94c3-32a1-06eb-b2187d56d797@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f60ddc1b-94c3-32a1-06eb-b2187d56d797@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_044551_607221_6614BA50 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com,
 m.szyprowski@samsung.com, Christoph Hellwig <hch@lst.de>, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 10:12:31PM +0000, Robin Murphy wrote:
>> -	mask = dma_get_seg_boundary(hwdev);
>> +	if (boundary_mask + 1 == ~0UL)
>
> Either "mask == ~0UL" or "mask + 1 == 0", surely?

I switched forth and back a few times and ended up with the broken
variant in the middle.  Fixed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
