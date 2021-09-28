Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E27C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:44:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1392461157
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1392461157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehLMhQxm48I0oFlWPI4lSQEwtrhoqZHugoPeZIMA2dk=; b=AoM8WKyYS4PmbJ
	m4OILlRkwd3rq2pKUcneaU7tZmCCWIkApkM6XAvwwQOZ1GQ/Qr/nzOhv795OTwCtm6+X4KqAnze3W
	El+m508ycnj7acpxGLBxKBBog3EIyX4G7rHaBvTR5xkIWEO4zbWLgN9FGCRgHiQDxErkwzLIH/pEK
	I8oO/ZpI7luDrefdzP17Q4DcJ0zfy1k8FdvH2rKbLyern2bCe2yQ4Aei2NNmTJGi+GxluGz+l7jsa
	eRB990E8Ir+5Z93ViLy9JeZDaO1oNINtmzUg+zIkD2BqfPyFQ30AsT3isen1uHs9U7DWkKzoX0VF0
	qNWJNNrxxS0t97lfO4Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJ15-008gz3-OD; Tue, 28 Sep 2021 19:43:51 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJ13-008gxl-1S
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:43:50 +0000
Received: by mail-io1-xd32.google.com with SMTP id d18so31434iof.13
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
 b=ZaQqv4m808BuxDtGeChZCPzv4c52NMfLQHqoImEoIEMRktgEpidQ0ZAlaBzLiOgw2y
 4l7Us3OLiVksCSNisKnyEb1D4P1RyMjFLOa8HY/XMbPST1a9XRronsuCK46GdHIoKvOQ
 rVc1XwfKxHSsXcs4HW1yvQf7l+k9oqiRzK1FppsrZ71WeRxwfhW2epLKyirhoD9pZcR+
 9N3kupzPvhNrqC2t4nGZ1pxzZaEA8+UhDCVzAe12EQrq909NaIgptNCZerW6CzU7kfEF
 kpwTu4O75rJ2ShP1PWF7I9mYl3Pu9O8QL99v+c/gI+XAsb1bLcUON8byaZpmO5mXC6R5
 uPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
 b=PkKt1wDQfUKV//wZee5YKLG4PvUrF6WS9l8rY2WIgCgtIVV+Tbq0R0mHWlWgtvM83x
 1lPl3+2k6aK2FFatmFUjwySGrxluui/lye/Y3YUkCaW0z80eBXdrsUDu49WtnBfd4+us
 YDz8Y924/odqtrwF5E5wEMsSUQP5tbUJWElYXBrO3g6QP19Bq3MzevXYsHlR8fHgarVk
 IQ5eLAs+X0v9Tb033facn0w9U7QtXnAF1aKqDdrBzr9+vZ1VGr3JRVmuLIgeTwEs153T
 x8UnO8JMfs4BJu7c9QoOXvI5GUsc0rUe48Unhdpj+HlAkWqhQTcjg7Q4I3PJ6/2GjWwC
 OV+w==
X-Gm-Message-State: AOAM533VitUstCCaUwMd5f0mJfRxTJx2q0vDXRcpLuzDnXDRZAR3Uwhn
 KcXyhMN1t6w5zqv9+sIBMwxyvgO+0wOylw==
X-Google-Smtp-Source: ABdhPJxmxz+0kmlqXJtf+sZu5nJ5PkoIQJaS8/KyXSBNASkg5OkMz+upj0MvOj1bWgx5qCPm07nk2g==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr5097857iod.18.1632858228189; 
 Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id l1sm11703946ilc.65.2021.09.28.12.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:43:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ10-007GXo-Qu; Tue, 28 Sep 2021 16:43:46 -0300
Date: Tue, 28 Sep 2021 16:43:46 -0300
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210928194346.GT3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_124349_107188_D87778AB 
X-CRM114-Status: GOOD (  10.56  )
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

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Good riddance :)

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
