Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C3CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:45:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B1064F45
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B1064F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FQ1Fryx8K6KG1xv+taIlVm8wUgEa5nBZMTA2JhjZmi8=; b=P/6mIao8iNwpDLp7E6GSi8tNV
	QgpMfumbBaRoQ2WD1uOLUGcaxci64n3ko016h/VZ/3zcY4OGSQkhkFo7I2iI0MAmx52HGzWuS4JBb
	0++/WUIyh0azm1wgc7QOxTA44CoQWLvTkkilVcov/SHRc8ew2LGsQMVn9uf4+EAveMvbgvxEdimxo
	DpHP5KLgMpQ2w8Q2E+3QZtoqY+9lDSZhkiPafjEWqdSqrAQU+B8FewzYmX5H/OrWPWHepr17pNzw9
	aCMtlV0jriFB1AxtyquxdEyzNQA1AayTY72gXZ2YFD1IcD4ZIIdFeAEvglM0b8kcJQU/1YWlTBbUT
	I3unvsF+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kYq-0002Y0-RJ; Thu, 04 Feb 2021 19:45:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kYo-0002XF-0i
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 19:45:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78B5F60235;
 Thu,  4 Feb 2021 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612467900;
 bh=o/iwfEt4ELC7nj2C+dTWaP5pRUR4t6umd988LIvS00A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KHRta2Y+8N1NkWgpBglcnviwIE4MFBS3tOXxhTBi+0J5dJPSnhyydSwJKVUmcC3R2
 6U6UGg2qyI6qeDnWnbfog2uXRd/djBoafXENY600B6hWAt3XblHSqSkIIpQm2roeq2
 L4uI0dUT0QpUu1zp0ZnJzVbl22PCT7yJUybcJC/o=
Date: Thu, 4 Feb 2021 20:44:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] driver core: add a min_align_mask field to struct
 device_dma_parameters
Message-ID: <YBxOuScfAXhdcuf/@kroah.com>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204193035.2606838-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_144502_180659_0CB13948 
X-CRM114-Status: GOOD (  13.90  )
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
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com, jxgao@google.com,
 robin.murphy@arm.com, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 08:30:28PM +0100, Christoph Hellwig wrote:
> From: Jianxiong Gao <jxgao@google.com>
> 
> Some devices rely on the address offset in a page to function
> correctly (NVMe driver as an example). These devices may use
> a different page size than the Linux kernel. The address offset
> has to be preserved upon mapping, and in order to do so, we
> need to record the page_offset_mask first.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h      |  1 +
>  include/linux/dma-mapping.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
