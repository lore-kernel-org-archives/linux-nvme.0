Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FCCC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61AE611C4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D61AE611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FzF/vEeVrXCsdYreTH3Y4CXsaeO4aFRRSoS4GfuklYg=; b=GXNihsZVNZULWK
	ccMyrxz6D8e7Cj188Ql9epjVip/rcVw+lhykMvuxiXrMl3xjjUoujDvIN8WmdWlRCg76bZSPdK+pI
	uD/ZJ5APHRGrGi2tRaGZZRO+UWcDKMriHVT1p9nqz+43Iqy2xCQWf8Vm2MdZsrJL3JNUvSmKplxCL
	Bg1vQbaf7i4sYx1xRAKvKOjfQ3muigwHtRtVwbKZ2eiS2wJ74Ws44BzsSWIfD0XxuIpVGWClXqECP
	BnmYprAYkxuTNZNFDtb6ab8C6U5/BA+zed+rARn7LsmL96eFgBt1pW7B7ZJKG+Doulk8ttFJ/5G2c
	+ymJmN2vwswQujLw0Ojw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOLNo-00ABud-MZ; Thu, 09 Sep 2021 14:50:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOLNm-00ABtR-St
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 14:50:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8523F67373; Thu,  9 Sep 2021 16:50:27 +0200 (CEST)
Date: Thu, 9 Sep 2021 16:50:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20210909145027.GA32109@lst.de>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_075031_108382_E79A8AFD 
X-CRM114-Status: GOOD (  16.77  )
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

On Thu, Sep 09, 2021 at 07:47:39AM -0700, Keith Busch wrote:
> On Thu, Sep 09, 2021 at 05:50:21PM +0800, Jiapeng Chong wrote:
> > From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> > 
> > The error code is missing in this code scenario, add the error code
> > '-EINVAL' to the return value 'ret'.
> > 
> > Eliminate the follow smatch warning:
> > 
> > drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
> > error code 'ret'.
> 
> Nak, the code is correct as-is. Returning a negative error for this
> harmless condition will result in disabling the controller when we can
> proceed just fine without directives.

Oh, indeed.  We should probably throw a comment in to make this more
clear.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
