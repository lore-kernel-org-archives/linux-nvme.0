Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEFBC54E55
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1cN5gYBP45I54WCStxe7DUVSwP4yg1UztQaoI/QgCY=; b=SKDdd0aTYYphq/pkKYoCn+fFUe
	GobAPUEov9u35TArEWioe4jFu1u0KuAaFT0oS4YH8yZRrIynrEgMl356Ehwh+ZAQDgUp879TGux26
	FOlZ6LGVVv6iJ16gVxZOfITSwgWLEVWgBlAAPCoGDrgL+D1fS8GjTjX5ipNOBlzTAteEHKcBW3O+Q
	mv4g9uMBbeuu60crMEMhr1H3AOteikCt3ZqXukjw0XDqBWslZOOto8KoDIjzCQV9rqD5QwdlElnxZ
	INJb9mH26KyHls/wo+BpKPaKRbaBBvbaLqdRwM38CRusCoDL2yK7+Z3uliEpNV4nAkqTRzNkT8ksv
	weHTvr3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtnE-00000000uqv-2FC3;
	Wed, 06 Mar 2024 16:06:56 +0000
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtQZ-00000000pI5-3tzX
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 15:43:33 +0000
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5a11b781a79so2892546eaf.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709739810; x=1710344610; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1cN5gYBP45I54WCStxe7DUVSwP4yg1UztQaoI/QgCY=;
        b=gU5k7Nj0A1uDulWpSWbEe+S9g6yVgy07sVkHFcrEblAQOqrM1NLcnN9Ge+OVWHQJSs
         2qKpCqk/UXpGyCSxzwsOlbri2+iSwOq30ud1iuOlQN+wxf9qKTbulHYXY5OTVP00IC8d
         YVoWN6rXxG3hcXtQaht5Bhj78CxWp7ONYcHyQI9iYh4Fn9Zt95CbasxR+OOwufcLiix/
         KAQPWqU3NLU/9vJHEuMON4EJGKxbkLvF2HgDIh/bT9fRXTrleoyUFb7gIeHlGQH28+fh
         YlzxBh2eGKV0O8JpEJg3VOLxo3GDmL1hHj2kCokCM9iC3glpvRJbItbTtZHectE92B4u
         wCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739810; x=1710344610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1cN5gYBP45I54WCStxe7DUVSwP4yg1UztQaoI/QgCY=;
        b=xM2/b9ar0ZMs/EN/ScAoRzxoDlAk2MaJ3PLm2QrE59DaxxsjJUQzsC+Y75jxhwsqEW
         dR76U+hLKidO7spksemOFT76ybPtEeEFiMzHOp02fKi26Y254/nKNeyOt4T1AiYgURy6
         aIMNFi/JrwcrTeCY3rSSQr8ny+CRPm0VoUfQ+w3lH1P0DdxtdOemGIMT7XXKnff6TRrb
         cxwYFhEJibNbunXx1ylkfeBRkUCGHqzdee6zQHQpnU5dVfjfi4Qa46fIMjV6CcMUvTi/
         JLfkFiAlFodiEVNB2q6cbDF2dwMik5qEAG7GIFAQc2aXw/ydKGI5L9+ZQXNwmcIoEpzg
         702A==
X-Forwarded-Encrypted: i=1; AJvYcCUvYmhHOYjHlQOkkMHoUph/VFJ3OWyqBOj1DZP3Ha4Z4pWDHVLaw5TQQf0vftQRCQ7H0DyBLv/18MQ3TILeeSemNZjpupwM/eAoC+ZrFyo=
X-Gm-Message-State: AOJu0YznQpRFUcIn479zykZYNItgfl2ZaYlUoMEFg58jkobBenVmPn0U
	uACrYXoyNkCW/IcnryBLlJHWb6GSnk7+PImpno1zXdQmmb6JYZ99VGE9DBHidlI=
X-Google-Smtp-Source: AGHT+IF835JdG2KV+Fg3U6AZj/VvG5X03U44hahvSgMdG82XDPKZTf6weC4/9ghDsNohTNUCXi+btw==
X-Received: by 2002:a05:6358:78a:b0:17c:1bc7:16d5 with SMTP id n10-20020a056358078a00b0017c1bc716d5mr5567125rwj.5.1709739810357;
        Wed, 06 Mar 2024 07:43:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j10-20020ae9c20a000000b007871bac855fsm6707680qkg.47.2024.03.06.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:43:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhtQW-001c2D-PU;
	Wed, 06 Mar 2024 11:43:28 -0400
Date: Wed, 6 Mar 2024 11:43:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
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
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240306154328.GM9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
 <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306144416.GB19711@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_074331_992486_27B3F4CC 
X-CRM114-Status: GOOD (  24.90  )
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

On Wed, Mar 06, 2024 at 03:44:16PM +0100, Christoph Hellwig wrote:

> Except that the flows are fundamentally different for the "can coalesce"
> vs "can't coalesce" case.  In the former we have one dma_addr_t range,
> and in the latter as many as there are input vectors (this is ignoring
> the weird iommu merging case where we we coalesce some but not all
> segments, but I'd rather not have that in a new API).

I don't think they are so fundamentally different, at least in our
past conversations I never came out with the idea we should burden the
driver with two different flows based on what kind of alignment the
transfer happens to have.

Certainly if we split the API to focus one API on doing only
page-aligned transfers the aligned part does become a little.

At least the RDMA drivers could productively use just a page aligned
interface. But I didn't think this would make BIO users happy so never
even thought about it..

> The total transfer size should just be passed in by the callers and
> be known, and there should be no offset.

The API needs the caller to figure out the total number of IOVA pages
it needs, rounding up the CPU ranges to full aligned pages. That
becomes the IOVA allocation.

offset is something that arises to support non-aligned transfers.

> So if we want to efficiently be able to handle these cases we need
> two APIs in the driver and a good framework to switch between them.

But, what does the non-page-aligned version look like? Doesn't it
still look basically like this?

And what is the actual difference if the input is aligned? The caller
can assume it doesn't need to provide a per-range dma_addr_t during
unmap.

It still can't assume the HW programming will be linear due to the P2P
!ACS support.

And it still has to call an API per-cpu range to actually program the
IOMMU.

So are they really so different to want different APIs? That strikes
me as a big driver cost.

> I'd still prefer to wrap it with dma callers to handle things like
> swiotlb and maybe Xen grant tables and to avoid the type confusion
> between dma_addr_t and then untyped iova in the iommu layer, but
> having this layer or not is probably worth a discussion.

I'm surprised by the idea of random drivers reaching past dma-iommu.c
and into the iommu layer to setup DMA directly on the DMA API's
iommu_domain?? That seems like completely giving up on the DMA API
abstraction to me. :(

IMHO, it needs to be wrapped, the wrapper needs to do all the special
P2P stuff, at a minimum. The wrapper should multiplex to all the
non-iommu cases for the driver too.

We still need to achieve some kind of abstraction here that doesn't
bruden every driver with different code paths for each DMA back end!
Don't we??

Jason

