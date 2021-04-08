Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:10:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C081E61041
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C081E61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0EEBbNnO+hnGraEATcaODn+nbtnEWEztamjPLP5P+/8=; b=LIAFggtjZYovPsw/+Ku1dA8TG
	AcNMpTV9aPyHADsnOMvPcXMMKag9pQn53AmrxxODBjV5qQ0q1XLKvy16BXbVVcwcbpz0Qixjb3jQz
	EaxIUo73vAENaqVIMZ4OvoefyYPOf2weVQO1J8i/xe4H5IU65ZEwYCkWFRqlW7QyAl4JYkEYYPQFK
	AcD2PRuyaztiDgBMq4WEvHDt6UhQpb+5N2qe1FyM+2HWbLbXVkTLqlEnSPHx9Obo4iJ/AUvivDLLy
	4bJbE8nr7JOgeohMh3f/JhTKkdPM+BKb/UdyW8FRHkO/bTwPUUhItO67VOB9bZCychCowIngG16AC
	KjaeIZkGg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTUF-007vwO-8q; Thu, 08 Apr 2021 12:10:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTUA-007vw6-NH
 for linux-nvme@desiato.infradead.org; Thu, 08 Apr 2021 12:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=OD+3GSqXwax+Y4U+W9lPocQs5LatoYnLqBRmd80f694=; b=UKg97Wwjyok0HfuAs5czQ0q0Ve
 55nXsH233yrM2XUnQK2uWC6BH+avsWLVafY/9xpDCSwH+Y8uzBO6tQYYPWok5GA/lj0Cn0+GL3XxH
 dlGdM6ucd9qpWplrdDVJODidxd4kqzVnoa23j7Jef6WMPbYljnlMCol7eq/OfnVAXBrVFoeXWMn+e
 prN+EhOC/6/57RK5tpYdF0pFSS5369qpNfv5qBzZq8fB5CqxBHwDQK8zfFwR0gO+a4jZ7YaszCX9g
 tJ/TkIj6JnI5CquEHBU5oNwHaqt/XHuTgSFep28UrvGeZ9+Un91iWrHcdHHk8VJArvojT7Aikd0Qm
 /Vj+FUAQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lUTTt-00G8ZG-Un; Thu, 08 Apr 2021 12:09:58 +0000
Date: Thu, 8 Apr 2021 13:09:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Padmakar Kalghatgi <p.kalghatgi@samsung.com>,
 Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: Re: libnvme questions
Message-ID: <20210408120953.GA3842993@infradead.org>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Thu, Apr 08, 2021 at 08:37:06AM +0900, Keith Busch wrote:
> On Wed, Apr 07, 2021 at 06:08:06PM +0530, Padmakar Kalghatgi wrote:
> > Since most of the companies who develop SSDs, use MI(sideband) channel, we think this will be a good enhancement to the existing functionality which the nvme-cli provides.
> 
> Can we even use this from a Linux host? I thought the sideband channel
> was typically connected to the baseboard management controller.

... which typically run Linux these days :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
