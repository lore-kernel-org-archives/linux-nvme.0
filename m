Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC54C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3q6XaWzdNlm5rZVTCa+MalaN5VSyURFchooXo3LCyRw=; b=eQri6WKlOc0dUhrFDBBjII/CzZ
	7bf2K1xb15r9Ix6Db8GeLvnK/26ODpcVytg0JrSHQV1V1a33K74NstGZ5lg84mc4TEOOYL1m+glwt
	cNRMG2GvfabZ9LHoG21YEGR7oKlYH0MBdTKmCOAgJVKGhG/+X/EXFqLaJICs6ggCR04auFgZbmeHx
	wy1bWZzarvHug0XPrLYYA3pGi4D1DL7dmp49/mkXsE08HX4dEoka4BrV3b1XLKRvSW13xn1PvQTn2
	vMYDQ5TJIJz64JioSQMQ+zqYYSH8rn2ssPiqKhOpSuuXjFt5QSm85be4EsYvFLtn2d8zD6CJQQfDI
	SGjb3jAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtnD-00000000upa-0n78;
	Wed, 06 Mar 2024 16:06:55 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhspf-00000000hW9-30RY
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 15:05:25 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-42eff08e3f8so8053751cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 07:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709737521; x=1710342321; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3q6XaWzdNlm5rZVTCa+MalaN5VSyURFchooXo3LCyRw=;
        b=QxbS/7TZkHOBUglkXsxYIy/HUyu7gesLq2NJUgnGsLPMoXNb0RflgDIwkb3gSSuJ20
         IPlGOQQmXkw+gE3ASuvXPPiEEF1XGkC7kv/aEQJWEHe07QZsaSzWLi5W+I8zyzan1OcM
         /iRMEuMw9l/ecz5ChoV1Wg11gk4Zs5MSQXGAjzgPEu2t1g7wEr682Pl+Lz5oghrl29A5
         DcH0Ikxo4+3mA18+Lk6fpjpyjbTN6YFfEXY8xRci0c/V/cEX4ER/pZcSXbdcg23Q0i2t
         llbBYtl5CkAi8YRctX4zVQBGdpawqchRiTzFYYRR5UdM0nkR/qk2KJr/KCv/wlW8z0yS
         odzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737521; x=1710342321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q6XaWzdNlm5rZVTCa+MalaN5VSyURFchooXo3LCyRw=;
        b=MD/V/Zu1RbKwaLDt8hVoj2bldPLH4fWDL7BLOP4dajXzy/boM/kjFu+Wjw8q5fBhZX
         efHA6RHqk3jrzk2QhN6+ugLzUf3xkAAL5/YGVpXX1sZ4ObP67u+r8soVVosG9VROA5sZ
         eJM5rxhdU/VNgwRWG7y+rZsi8Ih/wW3BFgGqp4FnstvqeJnsFd4/H9DkJ8eJcCIwbI6J
         DyO5DuE+cysfmyv4fpj4FC+Y/GxA93fEWvba/bTnvZnu85QBPsBCjPUjlSBC5nvwC45B
         Sf78Y+h0KRgdpH4qKqLx9odeUfr8YVpwxt5YmQaHRQPHiEnyWlEJJQ9Gz26Cxn+2yNnA
         y5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmmi6x/0zfV26Zr8/tHxgR3r/AonskHK44xM97K1Vh9Ns1erpSxiZaZtBch2oaM8ox88WJs0KtDmrPbFMgKBQTO7Q+cnjStkYpvm5Z8cc=
X-Gm-Message-State: AOJu0Yw36ZaJrF/8r0og6nKAz/zU5EZFIfrapdQ2YXEZMnB0sRYQ+QZD
	by4jJIpGy/DV/o4mohvegQSeks4j2JGqccHq/eRB6FffcpxYqOtZDhAxtjr6irE=
X-Google-Smtp-Source: AGHT+IF3DD5YVqRayIYcxbWGOreOFw/mqikGG0c1CCT98Poz3twNOMiPHe1g+1Vg/YON1gYeWp1F9Q==
X-Received: by 2002:a05:622a:1743:b0:42e:bcc4:2959 with SMTP id l3-20020a05622a174300b0042ebcc42959mr5571780qtk.4.1709737520530;
        Wed, 06 Mar 2024 07:05:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f5-20020a05622a1a0500b0042f01390d5csm1686793qtb.30.2024.03.06.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:05:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhspa-001WNB-Tx;
	Wed, 06 Mar 2024 11:05:18 -0400
Date: Wed, 6 Mar 2024 11:05:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
Message-ID: <20240306150518.GL9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
 <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
 <20240306143321.GA19711@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306143321.GA19711@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_070524_042023_8AA4CD6E 
X-CRM114-Status: GOOD (  22.35  )
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:06:47 -0800
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

On Wed, Mar 06, 2024 at 03:33:21PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 05, 2024 at 08:51:56AM -0700, Keith Busch wrote:
> > On Tue, Mar 05, 2024 at 01:18:47PM +0200, Leon Romanovsky wrote:
> > > @@ -236,7 +236,9 @@ struct nvme_iod {
> > >  	unsigned int dma_len;	/* length of single DMA segment mapping */
> > >  	dma_addr_t first_dma;
> > >  	dma_addr_t meta_dma;
> > > -	struct sg_table sgt;
> > > +	struct dma_iova_attrs iova;
> > > +	dma_addr_t dma_link_address[128];
> > > +	u16 nr_dma_link_address;
> > >  	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
> > >  };
> > 
> > That's quite a lot of space to add to the iod. We preallocate one for
> > every request, and there could be millions of them. 
> 
> Yes.  And this whole proposal also seems clearly confused (not just
> because of the gazillion reposts) but because it mixes up the case
> where we can coalesce CPU regions into a single dma_addr_t range
> (iommu and maybe in the future swiotlb) and one where we need a

I had the broad expectation that the DMA API user would already be
providing a place to store the dma_addr_t as it has to feed that into
the HW. That memory should simply last up until we do dma unmap and
the cases that need dma_addr_t during unmap can go get it from there.

If that is how things are organized, is there another reason to lean
further into single-range case optimization?

We can't do much on the map side as single range doesn't imply
contiguous range, P2P and alignment create discontinuities in the
dma_addr_t that still have to be delt with.

Jason

