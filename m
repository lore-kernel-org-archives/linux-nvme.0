Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F311C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=; b=Kg160AR25zReJDHNMTCNS1dXYU
	4CUj5pDZREL8lUD17hwJBby61plac8VlD1UNidUQSKDxGPo303m2lCOm+nHqVinDUncvzmoy1jCrY
	lz6g6SnrdT5c0nsagPJCSISFnjrPtAbJYHPDxy9LT2fK7jqrgkcSaSxK8v2wpCpQ3jNqJkTJv+zDd
	ozdaYoh41K01M/RPEJDafOwfMqborG3ibAk3FSXhNIGp9f3xyTC5MQk6qk/vFhm+7p+h90CxVI80L
	ZzHHZH8R606Vqu+eLOxkbqOJ4PPWngUp6/f1yjUqNGyn0zbs23/Pzem37LpkmK7AeGU3gyYh6YBwH
	RYdzU7ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwnj5-003mY7-DV; Thu, 02 Jun 2022 16:31:11 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwniz-003mW3-GV
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 16:31:09 +0000
Received: by mail-qt1-x835.google.com with SMTP id y15so3752153qtx.4
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
        b=RBKGIdGVGyENiynuzvWzxsfKrlShOYG7LDNM6zk7j/0cpFAWM0CNoQ/RikC676Zwip
         BMHOMh5FSPCGjY61J1z6G+8c1X+4G/XGBmJ3fum6tDtClMi6od+zOdkcyAAKXb0oiOit
         b12jjL7nGu0mjk8vwPx18er2whDmGOBIM4slv0jp+xyv6iWVZkV8Hkprx2Ft3TnlNr8S
         F3ZKnuaS0udbsMCk0y55d04otKL6PRXBEyvPN62xIots/ndr10XIEf2q5FJvYZj2hwlD
         Ppp12ccOTvvIFXm+WxGW6jlLIOBk5xmPC4ktWEJBo/O94h/wW5jv5ZkhHpnGnc8M8pyV
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
        b=brjxJ3YvLwbAia2tuxN+d66K0p7wgFftdmNgt6CE4FetcqL/ciHcNmn+LKCNc/RWcc
         jPzg5BoC7aECY71kpSzRg5yT5sjzoorLN7rttEq5XcmDP2ClRDRkbd9aHlg4b5JQWCMZ
         o/k46FxmXUiYN6jWBLb8gC5Lzr2Y/UQt3ArbbVJ0F2pGumK+ttpEh6CTQIERzCNiyO5D
         joVxKjxhnQNMwzLDHjZRBeJCZ4it0QaipO35JQTQB58EWnYr/uPH9ygqTBVXpO0v4QXm
         Nsa2Si3UQA7hrMAGjHhkk+d5NUXc2XAmCLGVlXhR9MWMsOpS2Y1jh9sSt66f+FPJL5zQ
         pxXg==
X-Gm-Message-State: AOAM533Z8ANA5nsYdp1kHJ6YLCGo7mq7Cp/ah5MiG6d71Xu1qCKCH+IM
	y49LAaLt7/bNmHkJTMBEsIw/EA==
X-Google-Smtp-Source: ABdhPJzLJBnwcPaBtEw6VCmlLIOgqY/pJrxby5kBrBBtbBNr2VGXxQBgSbsEw14Z2kEr0zlwr/+sfg==
X-Received: by 2002:ac8:5e49:0:b0:304:c7db:6a2f with SMTP id i9-20020ac85e49000000b00304c7db6a2fmr4316676qtx.274.1654187460731;
        Thu, 02 Jun 2022 09:31:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id ci11-20020a05622a260b00b00304bc2acc25sm3261689qtb.6.2022.06.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:30:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwnit-00GTLv-7Y; Thu, 02 Jun 2022 13:30:59 -0300
Date: Thu, 2 Jun 2022 13:30:59 -0300
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
Message-ID: <20220602163059.GL2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_093105_574872_06F15752 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:

> > Just stuff the pages into the mmap, and your driver unprobe will
> > automatically block until all the mmaps are closed - no different than
> > having an open file descriptor or something.
> 
> Oh is that what we want?

Yes, it is the typical case - eg if you have a sysfs file open unbind
hangs indefinitely. Many drivers can't unbind while they have open file
descriptors/etc.

A couple drivers go out of their way to allow unbinding while a live
userspace exists but this can get complicated. Usually there should be
a good reason.

The module will already be refcounted anyhow because the mmap points
to a char file which holds a module reference - meaning a simple rmmod
of the driver shouldn't work already..

Jason

