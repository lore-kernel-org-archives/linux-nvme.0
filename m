Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68254C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F325123B1F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325123B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aSjI/TWHTk9FCFZP7Ei0sMw5VtSjl7iZYdlOu6n2cPk=; b=aVlYd6yGRNQbdbPPnZIB1vQDK
	fBCT8n/DMXQLFm7Eavlv3mgxTw8C1rxVMxS2Y3juBIqG1xfKMJYDt83QE3kEO8Zr5leZwVVvtAdHi
	mrGZthNixqEFs2F3dVOQEnacXYu2uXliH10mMtEwIeFybePOgKvAfLpOs+MV3qp6LQJ2AuQjrN3/q
	kX1NrXX94AML/ZBhAD8xzwi4Pz8t6ISxKQVPAE+ofVQlUQAoKSPc3bcBTpBBzgwKsuY3GzjTdhwHo
	TKaN7mbgm2GG4wVI7+1n2xpY8JG6Cb+cb/L1DtgsbrPQjdlTWe7y7zuWVSnHeEHkx3y35EHST0c3a
	aMsE9/toA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knAeu-000372-Jr; Thu, 10 Dec 2020 01:22:16 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knAeq-00035P-T4
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 01:22:14 +0000
Received: by mail-ej1-x644.google.com with SMTP id jx16so4962764ejb.10
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 17:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
 b=hLlhVWiZHkRszGDN0QvNv3k5cDa7NBwZGJhnG+u6snpj/DqWm97HsIYwTJsnjvT1vM
 lqLgTToh0Yl0+7UdLKf0OJc3R9/7th3uREf05mUHcpVQ/dGI9wmQMaG7b8tJQr7VzCU6
 n7TG/Q+F4n+X2SsRVoAlKSheAcmCFeTxkrOIXFDWuvtQdZWTf7ANt2zcUkpZxBGmjkXa
 wO9mFNtjhCJhXDZ9MpC+XSEcdnWG+j3g1YG8jxS+Jo15C0UFtAA2umrf/tujow1hZuMc
 f9OtadNZ60HDDPjDjL1evB3x/w7Ymxm2RXqqrVLk5LCk3Du/muGWXQQZ7gJkcfcPQvRI
 RABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
 b=JxfImr3IjglcrrGNSJLEoJvVNWzqG6oWBBooMlD+C8TiJy0C89WA7MpWLsklx9+GOr
 9ZJcyNGk90NR6x1gcUGXqfXov17pqEXx/fT0xg5fjA4N2sjkCLXgWu7wte8fQEdQ23pV
 RnXnLN6RC+FQFRgQBTE5nKGgPsKEt85n5gkRdfnjAYv7MWqpgbVr1bcCblYlx2G0k5XG
 9ekA8BJoDXIZ2c/dA2I+QCnAoN42V6LoeXn0+IgInpY126CbD0Vvv5HF3bGCmYOD5zpi
 Fd8GFhks3NKCvjMmWamN5EnSOYbVX8T8+3io+vq9ZUm17CKbdISWPsqt9myhe48PdBQD
 QtJw==
X-Gm-Message-State: AOAM530oF0ckAltunVQvZSCDTEZfmK5lLChVFE7p8mxneEfsjoU4yhcz
 X3YD4r2ClofJ45JLDKdtXysgXnmskjC2HMRFO5ErAw==
X-Google-Smtp-Source: ABdhPJyAwcrv2J7//UeT/BRlFkXF6BfuHfPDxCDsLChk0w8jJb7pNGsjyGRaIu9jO63Jp7V2CJR6QsUNyeoJndfV6A8=
X-Received: by 2002:a17:906:a29a:: with SMTP id
 i26mr4331316ejz.45.1607563330752; 
 Wed, 09 Dec 2020 17:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
In-Reply-To: <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 Dec 2020 17:22:09 -0800
Message-ID: <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To: Logan Gunthorpe <logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_202213_010437_7E3D8825 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Linux PCI <linux-pci@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Ira Weiny <iweiny@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> > On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >> We make use of the top bit of the dma_length to indicate a P2PDMA
> >> segment.
> >
> > I don't think "we" can.  There is nothing limiting the size of a SGL
> > segment.
>
> Yes, I expected this would be the unacceptable part. Any alternative ideas?

Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
segment-pages for is_pci_p2pdma_page()?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
