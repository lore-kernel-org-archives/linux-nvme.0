Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EB4C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387E86105A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387E86105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xPAYNLrGdiKGlIUKhYi2xIDMo6ghBPpEFGUCmGM4t6Q=; b=AZEaFyjjZ6JeqMpOq2Db5VJ5e
	o2ZyM53E0O+A/yeian8CNdLW8ZVsrY994DMPU6XjcGWb3Rs7xNbGOIuNqguTXM8zNhbh8iHRwkGBW
	RKtZyk8r9waZRSCChGTu3fhLGkOo1guQ31+tXN0La4udpY4CUmYb2RCVhS/b3aJ/6kGdKjhzjF/B/
	MniDS/EYI4YXtLtNPvac9DgkA2gu2XxE4M+9+Ezii+4sk2yhaO/zMleco8GuAQiK9aiDE99PFYCOX
	7AbjsR66xbPUyWhGaeYMG1759Pbfta6zzvgz4mlWOweC3H6xiji0abfajEhuntUG1zN9Qm82ABTC/
	dLXEN9a9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWhn-002OFx-KT; Tue, 27 Apr 2021 23:01:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWhj-002OFN-P0
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 23:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=; b=Itt2oJ3IUMR7rwL0MFCirnEXvo
 NboG4FxGvmw17nJexS6oAT3/02ZHxps2QFFVx+HJQiXs/AwisiVtWuKwoYMO6xgXYC/1zMs1blRGF
 0Ogvg6hLTHc50zYVZD7P5qFFO/CZr+T9crT3DerRJL5jD7VRwFW4pYjp5YDYpRZgf7nhW2dcZgKRa
 4RsPWy9SQGh6kFxnpT6iTjxpSKm5K/llE23m0/cOR/CNv59zJIE24PAzjczUOc9abt5ZP9Gd/DcVF
 5WMEcp3JvyTnXSVB+UW4OOMUEgN6qLFPzD7qqpGxw7RWPwA1sVxqi6zyBx4aJBxiXE36PiZDKw/y9
 ftQunm3w==;
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWhg-00H4rE-IW
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 23:01:18 +0000
Received: by mail-qk1-x729.google.com with SMTP id q127so2614940qkb.1
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
 b=mWCFLORk/JSO5hvqnSM+Tr4f5WX2JQQfM5zw3lnOqv2hI8yuK2QY2VRA4xKcfW/BBW
 7+hygn+gIdSUDWbWnu44e9xclJztFIqbTsp/9qMdRnWE354rUiO+6MGPtD09gFGZBaIy
 IMQtx4otwgxXJNa3cuXWog1ddYlO1lhhAgdkSaV16Mkmlj4d+AO8D+3Vib+IKn1kpnJh
 zB2E3oZUgKt5cnT7CqrKn19BnZSeoH4IVay80i46FytArqMCxbMFWeL7/z8Zhyn6aK1Z
 E+x0lqdvTXIEAWW5guabHeXg9VXM3pblwMdsknuFsYDM3IU6oHqS3nkBUCZzVKmLg6Hk
 fKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
 b=Ee0TvTnhlWomuqVkkrlLWmIedsHOAFjqbTHTdFcOtCM1oRMrLgwjPcEKQOK6Vcx38h
 /tri7OPPqqz9JbVkpcupLMvf4m732jfOkzcV22WFc/9vPzDCesfLigaeAOSrb+7pM4LY
 A/YaItBb+mMU7XcNP7Ykc/eUbC7zKHCZPSzALAYbpxKSMT/zNrpPDgifHI3qCmKVUXRS
 C89y9/HiQbxop5BUKSBR6BGLzWuMLGRJdTU7RM2QryZkZUYT44OJkajGzoXrqn7uTu4P
 KekB5JxuAXUgNotk4/tcJAMGOMiWL3oQft6bEviCpHv/oe/XTnIogJ5E5CIouk3Ed2ro
 vnTA==
X-Gm-Message-State: AOAM5324bp2FO/Bcs4AKEf0ZIFWCiUYfS8tVAHc2XFyJtHF0VRFompXg
 k0nKybTEzLLcNNbPQIRw1SNmRA==
X-Google-Smtp-Source: ABdhPJzddRKTQchhnx30/Xg2SkamnN6ck8rs0UJ921MDl2H1WKlMVuDanOHHUjSuQhUcGpmIX430Sg==
X-Received: by 2002:a37:a5cb:: with SMTP id
 o194mr13564100qke.303.1619564475032; 
 Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t23sm3730974qkg.61.2021.04.27.16.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 16:01:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbWhd-00Dl5Q-Jp; Tue, 27 Apr 2021 20:01:13 -0300
Date: Tue, 27 Apr 2021 20:01:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427230113.GV2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_160116_791952_58B3C603 
X-CRM114-Status: GOOD (  15.82  )
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

On Tue, Apr 27, 2021 at 04:55:45PM -0600, Logan Gunthorpe wrote:

> > Also, I see only 8 users of this function. How about just fix them all
> > to support negative returns and use this as the p2p API instead of
> > adding new API?
> 
> Well there might be 8 users of dma_map_sg_attrs() but there are a very
> large number of dma_map_sg(). Seems odd to me to single out the first as
> requiring these changes, but leave the latter.

At a high level I'm OK with it. dma_map_sg_attrs() is the extra
extended version of dma_map_sg(), it already has a different
signature, a different return code is not out of the question.

dma_map_sg() is just the simple easy to use interface that can't do
advanced stuff.

> I'm not that opposed to this. But it will make this series a fair bit
> longer to change the 8 map_sg_attrs() usages.

Yes, but the result seems much nicer to not grow the DMA API further.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
