Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAACD12D7F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOmU+DqOTssuNxVDSw47mJh+RLlQKxt2hGA3wP7JifE=; b=Uhed+EKKXHy5U+ejaMD1iCbK1q
	eJdc52ojupveRkuEcZmoifZUxrhzAFvR7Jc1dFLZ/w85eajLDQfcbxV/Hne3ETUh5y8PQ3A/NOTfv
	d2uFsY4013ZzFOWNZMxzg3aQkjMfXywWmKg9Clhtg2rx3rdbK0N6woiwCUsoXZcfyTtfyNXmVdh2U
	8q9wNYET6IvRsQuH314Wt10DF02RsSj5S93PkCIVx7szQJmH5Y5QV2NRX9ckZ4u+19P3XluZqGQtj
	CW4anFeruZ4GAfxQjxWPR1A+oaMB1G5yVX0kLR4fSEXEMhPov26Cs9QBytOOEUGn3JHD2HtvIpoP2
	kqvyEPKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOlX-0000000GfAU-0rYC;
	Mon, 11 Nov 2024 07:23:15 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOiQ-0000000GepX-3qDd
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 07:20:04 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3556020b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2024 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731309601; x=1731914401; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOmU+DqOTssuNxVDSw47mJh+RLlQKxt2hGA3wP7JifE=;
        b=l+U3bTDGux/jXm56s/619BCCz5HoO4AtFQ387Pncyl5FyNrE5QlwrdbxpYlPHt1CLj
         WeOtlpAB8YrWUGbqRlK7j2ED2rivZjEC7KYcpdZNPez7zN2TWCpvrRiz17sOAo0fjfJM
         mv8Sk/TO5RgmI6xlaYjSZk33QRQm0J6v/E5N7F/Nr0IFFCPnhHUAruUp0VLm9iss2wVu
         8swaaYbvzY2YqzDPSUaukqSZuyPRxvkTH0sxIvwodSqWTUGPbLMyktpHw2WjErbgQ6Gc
         zlbLOVYRq14YT5jWtQwSCUgj+NB7zT8PLQH1jzkEC8S3ubWfNIu48x6kPqlQsFUaoRMu
         TGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731309601; x=1731914401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOmU+DqOTssuNxVDSw47mJh+RLlQKxt2hGA3wP7JifE=;
        b=w8+LB29sf6GzrGU/7CsyU3H9D+YIO6zIiPF8Ybdx8xbPhkDWPAZaba0LQc9H6uhCr8
         ygyhOQ8iOvLrisjqT8HexUTF1pjLERU6zhCRxSv78GQfkw8DIYYI9mvWOBRw6lF4v/bI
         EO2jIykUITy3tqIDXQl43NNmYAs9bT83kqtXuWyQvbf6E8Pe41xI6VWAp/FcCVwxlsGj
         VK6d9ZDe8dH0pXT6Gl29yjIxIsNJMo23U8V2UwUzEemZrRQB9WBhqpX4wSUJ4yJvu3DZ
         KStZnVyUPwJIXZaF8Bw4eOi6j795cRHjFMwJVGPktcYORa2+wgs9+ba9YTlnpe/5bvw5
         7G3w==
X-Forwarded-Encrypted: i=1; AJvYcCVSDTv/6FpozgD/6qrjr6viSJ5UJBH3SY19AIk/XNpHaFk71g+yXHapSBpij6X/kUH7yPEwBFcIuWNF@lists.infradead.org
X-Gm-Message-State: AOJu0YxWnzX47x5qtC74Y8Ym7CdnhPCSLbQgfS/Vpk1u+rCVO0wKK4JX
	vzuDZMlDSlwY5gmBHc0mcc/UMFh63hEMxBzcBHO1+mBBeTu52EU0SOO+LROYeM5gm2UMCY8JZA6
	oqa7fwkQnXa59BegduLzEIbij9kA=
X-Google-Smtp-Source: AGHT+IE2GbhyhHM7VLZoUXFICAIpmggZuUxeUy9Xke7HCQ1ScZ37Bf1N00DNPtc+BrABfZWGfVXnr9FTBKVDLWlkvX0=
X-Received: by 2002:a05:6a20:6a1c:b0:1d8:d880:2069 with SMTP id
 adf61e73a8af0-1dc228395camr18138782637.3.1731309601118; Sun, 10 Nov 2024
 23:20:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730298502.git.leon@kernel.org> <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org>
 <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev> <20241111063932.GC23992@lst.de>
In-Reply-To: <20241111063932.GC23992@lst.de>
From: Greg Sword <gregsword0@gmail.com>
Date: Mon, 11 Nov 2024 15:19:48 +0800
Message-ID: <CAEz=LcshavSrtGDjhKBPZU9o+5Mr8rPiBPmVL4dxcOmEiqHQSQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/17] dma-mapping: Add check if IOVA can be used
To: Christoph Hellwig <hch@lst.de>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leonro@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_232002_988730_DDDD8CDD 
X-CRM114-Status: GOOD (  14.35  )
X-Mailman-Approved-At: Sun, 10 Nov 2024 23:23:12 -0800
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

On Mon, Nov 11, 2024 at 2:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Nov 10, 2024 at 04:09:11PM +0100, Zhu Yanjun wrote:
> >> +
> >> +/*
> >> + * Use the high bit to mark if we used swiotlb for one or more ranges=
.
> >> + */
> >> +#define DMA_IOVA_USE_SWIOTLB                (1ULL << 63)
> >
> > A trivial problem.
> > In the above macro, using BIT_ULL(63) is better?
>
> No, and can people please stop suggesting it?  That macro is so fucking
> pointless that it's revolting,

Why do you hate this macro so much, have you considered the feelings
of the macro author?

>
>

