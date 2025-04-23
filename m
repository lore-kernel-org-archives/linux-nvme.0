Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C97C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=; b=mJxSe8UgVMJ6ErmmFO++TSlZ+K
	R94jYrh1GbFDjluZ0i0QGxMAZtvcN9sN8wfbX5UBFDhJsbbZV6kZy0RAopy/Cll4eHPp8omIx/24r
	SeVRaykJ4YUkv29rU+b9uqXEdoT+55rQUdvfiJCIHGMpPutIv9H+Is3OyDVr1b1DTgw0OSD028Yiz
	oTHnafdjf/OrORlDqxHyxrjs/YS6hbpA67x4mdcwHhSsZ9fLtiu38kMHLTH546fNFN3efWLe+1Vwu
	TbEnshozEjU6GFIBxksL1h+hhLAq3dTx9UFYqKa863YLZTGfft4BJZLC8dK8rvREGAder4AdWmo7Q
	VDdDDWlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7u-0000000Bd9c-2skc;
	Wed, 23 Apr 2025 18:47:18 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e4n-0000000BIBg-2GY1
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:40:02 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7c08fc20194so14423485a.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745430000; x=1746034800; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=U/YMIgHGiuxfMBnlMTlpxtKDMPjQnTYfW5mhI8mUIme/Y/Kl8gX22qd3sbUtAI0dTs
         Y0aSaliRziTu5b8i3XfJxendOqtSsXKdz9ch3iA2vq91HtUDQu/VqRnISK6A+Vsyydrs
         ZYR5x/sBDIw2ourR130GkVijU/qW9/PI0kaujAQK2aOO2PjYxAlvDCYlZT1auZIRTvOz
         LnFaM5Xxg7n3TgJlhutcKqK3RYEwQGm/pPo2JJk7Ajo0nCkFL0pKBqZbKTKCx12JeM6/
         dCkDvW4KBYqkryosBSX2TG5yQBrMpyR2d+wj/CLsSWRvniXvgkg5pbkL+G3h1SyHMtrY
         lJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430000; x=1746034800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=wyw/UbmYuUTCEI84KwreqnYOzitHPmIrqS1yE5LolXpJm4nNVM8YNn+kZsQTq+aPOB
         dkyg1ddJoePQp8LjDU59MhKkboUwuf7iB+2XuYfX8RwNFrw+CsVj8dDoeNwGhDMKvYDy
         0PtsGARReZmUnGO0RQdKrVe7kQU5fRzSV7vZuTYn9PNYMZ5QICnuVRldW0wRB24f/ETJ
         YGr95QeoASCrhWnrcsuLNO+lxHcHHl5P1qypCd6EXL9GIVuxDIKi+ZmtsR44I3K7abXG
         EdN5fdQaCjpveCtBDmqBQMsLYY4KDf4exfhME5CLn6XuYz6JaAMJ02ph+/zK7c0z0cv6
         11jg==
X-Forwarded-Encrypted: i=1; AJvYcCUstRh6g/LYxXtZ+Q/DFcUzjLZomVfspZbwLJUoJ5K10J9cgGGiXvNfYA8sqq/04x9CJZgLTbVY8TDF@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7agd0sBrrUepTmrpeqfqb4oKTg0sx1eSbKffScqKjdjksnDPL
	/4i7f76DmYYUxdR37A2x/hxHTyyUPglSLhcM37yZJvUaaIPcSM5whJMyHjOg89c=
X-Gm-Gg: ASbGnctqp7JNY2qR0/lhFciLbJ+UFI7C4of4/UQkS3L7PZ/thicdHRBckE96rhgxmpR
	3xFJbr0dAVfVgxMbqn+v3YEWwc/sDkkvDzs6/q2x7A1C7kBEBBPwINhbUlVw+8qW/oW67eV9nvk
	+4+fK8K7ud5TAxWZ9PZFRMFL+rM0qWs3lTTU+ypVe1hbfq4rHds8leNXn+VH1fxNugOtAR/pJ0+
	X/eCFhGC55gUi5NwF6vvaDyfGhlvvRC7Fsc1e+5kmshf2rp9by4ZQEZ8RXr4eeUjMOZZYjGrm+0
	1PGp3lDn4P7sJj8vdl3wMrvqkkP5M1l6YSPsUN0KJMytsyKHqpxrfEoLYm1Fi/4EnBJi6vXd2+O
	T/7vJSuB3mlXlqbMNkSRoZCCuP7Y1pw==
X-Google-Smtp-Source: AGHT+IEbQuW5n2GfFvJAnoWRo8rT/VepuLZ0gxRArfui4RxjUWT0n6IGPAbDd8GEItyJpW33RI8jLQ==
X-Received: by 2002:a05:620a:4043:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c92804d68amr3534168985a.48.1745430000401;
        Wed, 23 Apr 2025 10:40:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e9b6sm711717085a.2.2025.04.23.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:39:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e4l-00000007LfH-1pvw;
	Wed, 23 Apr 2025 14:39:59 -0300
Date: Wed, 23 Apr 2025 14:39:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 15/24] vfio/mlx5: Explicitly use number of pages
 instead of allocated length
Message-ID: <20250423173959.GQ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_104001_587696_74D63EF8 
X-CRM114-Status: GOOD (  14.18  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:13:06AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> allocated_length is a multiple of page size and number of pages,
> so let's change the functions to accept number of pages. It opens
> us a venue to combine receive and send paths together with code
> readability improvement.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 32 ++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h  | 10 +++----
>  drivers/vfio/pci/mlx5/main.c | 56 +++++++++++++++++++++++-------------
>  3 files changed, 57 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

