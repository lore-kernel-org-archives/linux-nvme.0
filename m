Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260DEC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:29:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FD961153
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FD961153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M4LjRWugHPsCkDNfFyJfFmZgpGqS9w4mcL9EBvt0+9Q=; b=QKIHMSVmhK9aqMMECx9phbq7b
	LB+52c1rlsEd+1P0e7qpK7OllCnuDSsNdul75ljduwDTZtp0vacqeUDsPHC7jBlsQnz84ytbowHW9
	0xX1QD7G7oQGYEKp6FcmyxV5A69Ql8CkrLs2PelBk76KhS9AnJaIb8PqBw5L55cclao2cA0DaY48b
	jGy/nIFNtSS/GKwFt8w6vF1wOSThHQLsJvZOHXo63cmIELr8TXeDqiacmoaafC64RStTEMhm67EF1
	j3WhkUt/BfQLS+VzUYp/CPJpn6pcWXIhATmANnSUdPXC12YfF0akb4d1H6BU7eH4JfUcEhVqeg/g2
	BuB8v+fcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTO7-0027Un-8q; Tue, 27 Apr 2021 19:28:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTO3-0027Ue-U9
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=; b=kTmztxSmYXg/4ohvBEHTPioGM+
 etUuN9Wtgii82LKliB8P1yZV11iyKv9wHfSY9vcaU4br7SduC1v7K+ydmvnB5FQFJQlcTnTuN9LyF
 2o47N2hsHHqpKhnM/LIkU9Tj4kKwl8PL5uLd6AvO5mdk1mfS2Dsyn5ZT/UM/+QPdXC4Bn+IZ4IMf6
 hT7U1Xvq+n9oWHhc9UAtg8wbOr8ytV8g/lHKxQ0dbMkT4isDrmFGlyUgo/NiQHEH6xs3ihUTy9YQU
 GiMO1CejjgAyyz5A9HWxzPwYnflcmIz58N2qAtSNuoyu+G1A+/DfIJMAakwm5uwQuW3b3wEDQnccB
 p3b0E06Q==;
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTO1-00GwRL-5m
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:28:46 +0000
Received: by mail-io1-xd2d.google.com with SMTP id s16so55482371iog.9
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
 b=d1W1Aqvy0WDQgLHfXd6KVJkwoZwwpQfM3q3r5Boe9IMOb1Ks78SGk5p7ivRqzqy7BA
 gSU82n1JTpmb9daPjD5Irwhh8B8KTsNa9G4UpI9HD9aQfAMHpjP5UnmkWK6P30EssgPr
 qJxOA1NOdKo9K00d+kPRugkI7hzjIwbR6beAJw47nAWJhCVUyqPECz8ykdHt9yMZoQDf
 ogK6wY42jY6a/WZjKm0cnc2nvFx8F0yTrlY8RDJ+yRE9tNcvkLbJZ6C9WY9hob38kSQH
 OkOHfjfKQxlSWxbGIOGwjc5CcjsPzLBsDhznnnN1CnbOGBl9wX3p6dSPxI4qPEJLDYmB
 oq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
 b=a5drbZdNYkLIqSc2GMV/skfY/yQEAiqLMyn8iho9v4h2pVh2ZbEL5iKwev+oxBspuq
 LxmqZ2G+ryhmc8Q4Wyw5TVAofGDO55aW+v++/cfvsLRo7vQ4b4DF4m3h5Dkk/95UIW+Q
 7gm+kVopw2tV5K2/ah1hu6fvrERx+YLQ6SScKa5jDKTQ38vBQnWJDDcEAshUABoI0lcW
 rPc2uFshae2PF/4KKo74kV3ePKxGxJDP3BeD5ZqcEW4BHc8KmybQE6N1RHUCiYKgSFrK
 iPkuolnFsXEEWOkYws7VHoDXwHycrwOS/rG5wKRdShh1pfA+Y9VEb9aT3HSPTEZYBa8Z
 rD0g==
X-Gm-Message-State: AOAM532lhy098H/ZHEriOC79Nl0pa+ZBDS5KK+ikGXlkkRKQ1tH9a1Tc
 2WgKJJONGKvPotugEnA2oym5bA==
X-Google-Smtp-Source: ABdhPJwQwDDELwuTsaB4Sx8qcFBGHVeacGfq4J3MKE4o16MniIdqkGIoAquFFRl+dmeSeAYT8wzXKQ==
X-Received: by 2002:a6b:3bcd:: with SMTP id
 i196mr20979811ioa.121.1619551720518; 
 Tue, 27 Apr 2021 12:28:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d16sm1715512ils.48.2021.04.27.12.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:28:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTNu-00DgsM-R2; Tue, 27 Apr 2021 16:28:38 -0300
Date: Tue, 27 Apr 2021 16:28:38 -0300
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
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
Message-ID: <20210427192838.GP2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_122845_236927_234F2C09 
X-CRM114-Status: GOOD (  15.77  )
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

On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to to add P2PDMA support to the common
> dma map operations. This allows for creating SGLs that have both P2PDMA
> and regular pages which is a necessary step to allowing P2PDMA pages in
> userspace.
> 
> The earlier RFC[1] generated a lot of great feedback and I heard no show
> stopping objections. Thus, I've incorporated all the feedback and have
> decided to post this as a proper patch series with hopes of eventually
> getting it in mainline.
>
> I'm happy to do a few more passes if anyone has any further feedback
> or better ideas.

For the user of the DMA API the idea seems reasonable enough, the next
steps to integrate with pin_user_pages() seem fairly straightfoward
too

Was there no feedback on this at all?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
