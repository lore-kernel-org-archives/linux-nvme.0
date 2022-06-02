Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858DFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=; b=1vMDHI4kCwr+H7wTta6e0B/5dI
	Fd7LRlnXqWgX//1WlHH1CesPciEz/v6USdPQE+jjf8ALwihv32nZilf20xBKrWdYOGLn70LuIYF9J
	OcDg+IlDHjn9bl1pwRaHQ/Hx25Ju5Cc5jFphSPrXjqBvilAWEbp5CuRFCzzK+qRpWEHL5eDgay6kr
	wp3RcBlDxiSKY8iRDP58X5zfzwPW6tuLWn6YYPwvoD+5yk6D8wOnfXb5lvHbY1jbJHvr/S6Oqz5wN
	ABgskAPy1NagYjt0Ue0CKD6MO3ACfkZl23uqtqkG6T95oEnHAa1B2jQZvheChHP8MKL43BkZdB8Ot
	1CZJ1cCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwoTh-003qWi-Em; Thu, 02 Jun 2022 17:19:21 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwoTe-003qVV-TC
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 17:19:20 +0000
Received: by mail-qv1-xf36.google.com with SMTP id j2so3955674qvp.9
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
        b=oY3UkNUXzvT4gdwz2capbciaRVMUwQe4uTXMNLZq5rB+SzgWV5Y9KoY1sDKwk8gWEZ
         3+Q6uw1zQKFy/Unx4HtSstHVhLVkyZWxIMc80Ov1HAVUKCwD358EREeYDHhZDZ8k2MZs
         bhOn53kb4QxCMIITNdm+0c1NDnpndPfQjTJuD8TnE5Uv3cFfjqWJqQft0Z4nj9YH3uBX
         nPBbjR1L9pvnoVrAHHIKs0Q9BrMid/o8PxXfUbP6XGG/0m5N+an4nPqyjM2uURiJ8hW5
         nebfcv+yWDiGXnYLe+dR4uJdRKeLgQOn7tZfDT3mAn3r317E5qS4d++iGATXbWfBN5kK
         ZpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
        b=mCV9TVs7T+VpRxqHqWxigIjuUuA6RxLZNjkuSagP2TxYehSYkr2Fynf1FBoBhK7cP2
         AmmGtQRmys45rYP6rgnx8uqORepXNBSp8pDilRF176m1rujpPSzQbphgW3d/f5TLcdhg
         4bnqKqXM/yyMY8Hq/619LCSJojeT8HWtqQuKIsA+ljs5xPPcyE9iIowuvIJYpPExxnj3
         mPfaRmg7JgJ8kJTckunyso72vn0pp/pQvNhAe3o4LKiYUZ3qoLHzDdqEbGX6v2vtutrp
         s8EX304zsbqzU4AFL+BoMU8CcoWLFMWUE1OCEm0O/6P2fHpOds8VMVCk9cHyGYLJk1hE
         mmjA==
X-Gm-Message-State: AOAM5326ArZTDlvRTP6i7TLQskJIjthhWP3ROFidJlo8BytGA+727oom
	G/hHgeuUFitvLBAG+XKj9p9RYg==
X-Google-Smtp-Source: ABdhPJyTeRjkxp4FkIVBkBdxqYlIi1Ql4U5vaRWOEfB4UJA8nUT6ExwG7uYWv1AjNIltcvnn29cQ7w==
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id 1-20020ad45b81000000b00465ded80780mr6281647qvp.119.1654190356566;
        Thu, 02 Jun 2022 10:19:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p200-20020a3742d1000000b0069fc13ce1e7sm3510487qka.24.2022.06.02.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:18:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwoSV-00GUM1-QB; Thu, 02 Jun 2022 14:18:07 -0300
Date: Thu, 2 Jun 2022 14:18:07 -0300
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
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602171807.GM2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_101918_981473_1A216F48 
X-CRM114-Status: GOOD (  27.62  )
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

On Thu, Jun 02, 2022 at 10:45:55AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-02 10:30, Jason Gunthorpe wrote:
> > On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Just stuff the pages into the mmap, and your driver unprobe will
> >>> automatically block until all the mmaps are closed - no different than
> >>> having an open file descriptor or something.
> >>
> >> Oh is that what we want?
> > 
> > Yes, it is the typical case - eg if you have a sysfs file open unbind
> > hangs indefinitely. Many drivers can't unbind while they have open file
> > descriptors/etc.
> > 
> > A couple drivers go out of their way to allow unbinding while a live
> > userspace exists but this can get complicated. Usually there should be
> > a good reason.
> 
> This is not my experience. All the drivers I've worked with do not block
> unbind with open file descriptors (at least for char devices). I know,
> for example, that having a file descriptor open of /dev/nvmeX does not
> cause unbinding to block.

So there are lots of bugs in the kernel, and I've seen many drivers
that think calling cdev_device_del() is all they need to do - and then
happily allow cdev ioctl's/etc on a de-initialized driver struct.

Drivers that do take care of this usually have to put a lock around
all their fops to serialize against unbind. RDMA uses SRCU, iirc TPM
used a rwlock. But this is tricky and hurts fops performance.

I don't know what nvme did to protect against this, I didn't notice
an obvious lock.

> I figured this was the expectation as the userspace process doing
> the unbind won't be able to be interrupted seeing there's no way to
> fail on that path. Though, it certainly would make things a lot
> easier if the unbind can block indefinitely as it usually requires
> some complicated locking.

As I said, this is what sysfs does today and I don't see that ever
changing. If you userspace has a sysfs file open then the driver
unbind hangs until the file is closed.

So, doing as bad as sysfs seems like a reasonable baseline to me.

> Do you have an example of this? What mechanisms are developers using to
> block unbind with open file descriptors?

Sysfs maintains a refcount with a bias that is basically a fancied
rwlock. Most places use some kind of refcount triggering a
completion. Sleep on the completion until refcount is 0 on unbind kind
of thing.

Jason

