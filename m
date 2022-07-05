Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63710C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=; b=T9sT2OvQtsiN8NnOKjlcZ76xe6
	/qP2E1OpoWSkxMXUaVKBtE58DlLWJNd+dIWrwDrpc7LAZJma6tM/oIyqcSw32Z1LMN9zPmk+mMvq4
	FT9m/AUzvuwlTe3L4ZqC0AqYDBU+8v1ZEInJuHdX63ra4DTXM2Aw2smXVZU1soiN6q7eMraAnrYUB
	9p9P4qd2P6FdMQc7j5daC93ejcgNUgabu/TMSjsVDh7NKyo62yhCVxzohm6FrQYO7vC7esUoQzM1k
	Y7FuL8I6/1sv5N1ZepfjgtEaYM12EVgXVfENgeFYlbVz27IAe0srShheHvLzFGSbL5NSwEJ6xSiyq
	DFOI9nLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lR9-001Tpo-Vf; Tue, 05 Jul 2022 16:30:08 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lR4-001TnS-RI
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 16:30:04 +0000
Received: by mail-qt1-x835.google.com with SMTP id g14so14435179qto.9
        for <linux-nvme@lists.infradead.org>; Tue, 05 Jul 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=ARfWpr8plwJhNlfMsfgbkLKFpSjayQPH+TVLj9njVh+9ZVwwYS0Q5lpx3QESUlwiJ0
         Xau0D8DTEtlBLA2TKJjGb0eWyuHzYJSySzH16w8i60Ucpq6lkPkx/9MUbSA7H8PkF9mf
         vy2eLsJPe5CP1cJVF8B6Y7AsRY7nQqxYHkWBv4hIekpX2n63jyIHOZts2vGssV+p6X7i
         o5tnF3lXu1HBK0CIU9B+BuQxS3B79T/BqxNUUNBMTSi7dFTn3cejUhBmCkHwZYPAldDy
         CzT6wuFA6Z8An5ETNanvoj5+zinJwVg3guVjtkzMtWjvDNeS+j8gPF7lh16xjKsVoTSd
         rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=MKRyrzhQBNbz7KUgFd2PkztdK80Sh3c6UrxrfVr9NqNjUDUUCyWHqPzBYe36kvGS5O
         FwpN3jLD4WNM+XxAGnmR44yHAKSZR72pvp5d7/7D58j4hfjBoZlMDET1eE//msfkrE12
         /cjwx4Yf53EvwnzL73rA7Uw0/TNuvFKwyXmn5JXxyD8ItsbyExYtVTvCyAzF4pwz6yYe
         49w1icTcZa+6L3g553AQvfXDHsU2OfWTw5hueliuTSZARgY7ijXXkvO2D9N5M9ILkWaR
         eBbSvWwszblVCu28mYwce+dLf0h4VtBezEaAnJ8dN3JPpxvKzrz7Hb0xhmumgejv2aLQ
         V56w==
X-Gm-Message-State: AJIora+ezs8Ja1DEXuHKN73ijc9Sqp1MWerCJOBLf1C/o7vPyax9VqoG
	KcXxwdYYSMXRNlO0ZwW+BuF0uw==
X-Google-Smtp-Source: AGRyM1tPLgF/oa5jp6ch7h66vURUmccxqkvEu70fGN2pQIZRW9uE0+BIJoib0UJtgkigroai62+FZA==
X-Received: by 2002:a05:6214:27cc:b0:470:9aaa:94b5 with SMTP id ge12-20020a05621427cc00b004709aaa94b5mr32033702qvb.129.1657038600343;
        Tue, 05 Jul 2022 09:30:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006b25570d1c2sm11328498qkh.12.2022.07.05.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:29:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1o8lR1-006YYv-9I; Tue, 05 Jul 2022 13:29:59 -0300
Date: Tue, 5 Jul 2022 13:29:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705162959.GH23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca>
 <20220705161240.GB13721@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705161240.GB13721@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_093003_193177_A6000974 
X-CRM114-Status: GOOD (  22.32  )
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

On Tue, Jul 05, 2022 at 06:12:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
> > > In fact I'm not even sure this should be a character device, it seems
> > > to fit it way better with the PCI sysfs hierchacy, just like how we
> > > map MMIO resources, which these are anyway.  And once it is on sysfs
> > > we do have a uniqueue inode and need none of the pseudofs stuff, and
> > > don't need all the glue code in nvme either.
> > 
> > Shouldn't there be an allocator here? It feels a bit weird that the
> > entire CMB is given to a single process, it is a sharable resource,
> > isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

That makes openning the mmap exclusive with the in-kernel allocator -
so it means opening the mmap fails if something else is using a P2P
page and once the mmap is open all kernel side P2P allocations will
fail?

Which seems inelegant, I would expect the the mmap operation to
request some pages from the P2P allocator and provide them to
userspace so user and kernel workflows can co-exist using the same
CMB.

Jason

