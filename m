Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96955C43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 07:49:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43C0208C7
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 07:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gToOyGEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43C0208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9+yPQ0KzqIvQoNQ6pjEyjP1rplK1WVJBfdKHD3/TpaQ=; b=gToOyGEvYaQLekrZI+Qj1BcWt
	tRKz/tBCtsa+uK3sLvGh4RBbzTf0c0zfJcAtVth87T7ZVu0WUqp/8LvtgJTvsLuYlHQfdUl5L0FGl
	ZuwbJkpJhI0j4IXpTbagYlkDnCmTbtd1d22Bb31SL3Iby/wxZxsq9v6wSgLdGut9HefHSaMbR+jHh
	0uT7dOjnNf4j7IPNfKs0KnYQO+ZvGOQytFTr3rWh6lXPnm6sVTUNAqzCiclKatxwtwLJcjwQp+FD6
	6GQyDvJpQwLJ4tWq3vWdnVI6V1LLZBSi3Ja+XGeYvOQKL5ugoKwbcOB8gblbNKqJZYJhUGKjr6QTV
	mBYO9iCag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFBtq-0005GF-7W; Mon, 07 Sep 2020 07:49:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFBtn-0005Fd-Gk
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 07:49:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1719868BEB; Mon,  7 Sep 2020 09:49:08 +0200 (CEST)
Date: Mon, 7 Sep 2020 09:49:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
Message-ID: <20200907074908.GA20762@lst.de>
References: <20200904152550.17964-1-hdanton@sina.com>
 <20200905073528.9464-1-hdanton@sina.com>
 <CGME20200905155056eucas1p2d4a2249f73506a765fce2d2f7089748d@eucas1p2.samsung.com>
 <1599321042.11726.6.camel@HansenPartnership.com>
 <1eb4a2b0-2fd4-9f3c-e610-c8f856027181@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1eb4a2b0-2fd4-9f3c-e610-c8f856027181@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_034911_693590_4ED37CD5 
X-CRM114-Status: GOOD (  18.44  )
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
Cc: linux-arch@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 07, 2020 at 09:02:34AM +0200, Marek Szyprowski wrote:
> > That's not a reason ... that comment was put in for coherent mappings.
> > What is the reason we should incur all this expense for clearing pages
> > which aren't unmapped in the kernel, because we can update the comment?
> >   The usual rationale for kernel mapped pages is security, because they
> > may leak information but unmapped pages shouldn't have this problem.
> 
> Any dma_alloc_attrs() buffer might be mmaped to userspace, so the 
> security reason is still valid. Possible lack if kernel mapping was only 
> a hint that driver doesn't need it, so it might be skipped on some 
> architectures, where creating it requires significant resources (i.e. 
> vmalloc area).

Yes.  It seems actually mapping it to userspace in media/drm drivers
seems to be one of the big use cases.  There other one is memory not
used by the host at all and just as an extra buffer for hardware so
that the PCIe device can cut down on DRAM cost.  For that could
potentially skip the zeroing, but then again you'd need to trust the
device, which with thunderbolt might not always be a good idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
