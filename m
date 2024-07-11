Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B73C3DA45
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iA5EkoKdOMHWMqTqv30k2JtFjPGSRguy2LMuZP+mDPQ=; b=vQbT/tqQH0b6BtQbGhpBWw+vi6
	Gx8HkiKmYKf5iTsmqWV37jmLSTP8yLUDwA71b/ZJ5oBJCXBOSbyGMcGSrA/nfJB9SfR29Mk6ArPYb
	n/UYSvSNbSajVPUqPNUAcAnzJOOH4rrdn3L7l4oKP4QCOsa8L2TsJaw5IZ0wQYCi+LusCtYeD0gqy
	/OBtU3p6Tq5vmtJ/RRUKucmiS8PEU2jBt3tInL/iK4V8jfiBEMaePz0vCawrEEJErSm8zh5Fnu8Jh
	wDSnFcUc0WHUzqUy4bwW1tK8T4JvkPMcT4ytCxyQDjBegelb8+rrKpJrC4XeKEY8iRYeutWWJgbeo
	DofwUQ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS36m-0000000FnhO-2zIH;
	Thu, 11 Jul 2024 23:21:52 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS36j-0000000Fngc-1u3i
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 23:21:51 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6b5d42758a7so8300746d6.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Jul 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720740107; x=1721344907; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iA5EkoKdOMHWMqTqv30k2JtFjPGSRguy2LMuZP+mDPQ=;
        b=S0o7D1cTp6aw+yGM6VZfW77wa32kdLR/KJ2BA3tyTrp4Ja3WuV6NmEd9PFxPrYvKQi
         CudDuPHA9aZwmvoHYiSGNVlL//5HeyhS6P+3I1T8Ar9ypPZSt7RrnqvLNqX3o0CtmL9l
         9a5moJa9PzVg0tzJKnkNzjNcynczYOCrXOpt1zsx3Lxg2mKe65Z3fNHzNlKL5h9jL75U
         XxoZMtUDo6fV58sItCh4ikX+W/xvjQ2jf7UluJSxzFaJB8Q4wB78rYADF4YfjlDO2y66
         +4enPsmWEf+9Ns100yfNYvccBgWuVJ7+In+QQRNtCXCK2zo45D0tRzILxRy8UWgk++OF
         7aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740107; x=1721344907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA5EkoKdOMHWMqTqv30k2JtFjPGSRguy2LMuZP+mDPQ=;
        b=e8Cg+LozYIowpd50FtAVEj0WBW6cZllVz4iQlX5A1kA1Lt2Q5GPgLh0tvgflTxeahN
         T0a8TowWrhvA8b/fdw3GpcJoY/WXdjuZjOAwjcqQajB+tdeTa9hwyWKa2T8QNJaiaD1+
         I+rWFAIC/E20tGiZdVaxQOcEHFZDEtG6ValhOebK5Phuw1KQv/naWDQNCM+9TYr2lJt5
         qnP5zzenTjr2s21vp1682WGRmKtmmZljpo8CEW5AIFcTBP/CXWIAPAMW6iG70zW4yY0i
         jZ3ttWj4x7YNU2glqbUw29lFBptyNB0/qJQNkzbQXmCXtL5S4pg0cIkQGZNKfpOfnO/a
         mZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUrynC2zylwviaVv5z9IyW0YnEJ2gDkiXwEPaJaOUQa+AUM/HfDR3ZLRuP8kEBtpCpMi6grZewl+f/7P4fVfCij3Ks/rprao14ycwptSxY=
X-Gm-Message-State: AOJu0YwzDF9X8wmf2Oj0ljmDuMa1GVFgT0xamBWV0x6v1wPVd5Okfeko
	AtBp4Cs3FuDypXTDeJb2z7cBAwsSO002q/tHxzkxFe2tViehnUd6gTRzwZaillo=
X-Google-Smtp-Source: AGHT+IE3EReOFfP9Gp9yOBbEQdd9ZoxHQTHmzRvm3onKx9Jai/yPhMccTCjhIICDfGTUxTuCo6A+VA==
X-Received: by 2002:a05:6214:1c83:b0:6b0:6a57:c982 with SMTP id 6a1803df08f44-6b61bcff6edmr121290886d6.28.1720740107241;
        Thu, 11 Jul 2024 16:21:47 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba7a437sm29827036d6.85.2024.07.11.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:21:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS36e-00FPgi-P3;
	Thu, 11 Jul 2024 20:21:44 -0300
Date: Thu, 11 Jul 2024 20:21:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240711232144.GQ14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
 <20240708165238.GE14050@ziepe.ca>
 <20240709061721.GA16180@lst.de>
 <20240709185315.GM14050@ziepe.ca>
 <20240710062704.GA25953@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710062704.GA25953@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_162149_518921_3E786293 
X-CRM114-Status: GOOD (  30.45  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 10, 2024 at 08:27:04AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 09, 2024 at 03:53:15PM -0300, Jason Gunthorpe wrote:
> > > That whole thing of course opens the question if we want a pure
> > > in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
> > > way to migrate and allows to share code easily.  We can look into ways
> > > to avoiding that more for drivers that care, but most drivers are
> > > probably best serve with it to keep the code simple and make the
> > > conversion easier.
> > 
> > My feeling has been that this RFC is the low level interface and we
> > can bring our own data structure on top.
> >
> > It would probably make sense to build a scatterlist v2 on top of this
> > that has an in-memory dma_addr_t/len list close to today
> 
> Yes, the usage of the dma_vec would be in a higher layer.  But I'd
> really like to see it from the beginning.

Well, lets start with agreeing on this layer's API and be confident it
can succeed.

Then I'd say to look at RDMA as it is a logical place to build such a
data structure and we can build something that at least does what RDMA
needs.

I need something anyhow to plumb through to DMABUF and over to iommufd
and VFIO, can't skip out on it :)

> Yes, I don't think the dma_vec should be the low-level interface.
> I think a low-level interface based on physical address is the right
> one.  I'll see what I can do to move the single segment map interface
> to be physical address based instead of page based so that we can
> unify them.

Yeah, I've been talking to Matthew explaining that starting at the DMA
API makes the most sense and lets remove mandatory struct page
entanglements there. Then we can start to examine other layers. Having
a consistent option in the DMA API to be physically based with a
memory type fits with that plan.

Jason

