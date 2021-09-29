Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388BAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E386B611C3
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E386B611C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XGVWc7ug/JduSM2z+nsUNfrQ4tIuIdpGkp3MB8DO+u4=; b=em55a1lkf1Gyia
	16FW/EWjFr1Xgkzb3fcn3VhRllEwwgv64bqZE6bMsghLh4YvF0Qm0sqinEzyPSUTyXiDXxczhApQm
	VLZ/Q7uibNL7zHYfEn+Rc0k1CK8FYVbofGXtYlxoTxZkZjGdFVhrb1uWsGHT/Is6aH5STv+mK4QKm
	rkGfy0X6YubohUA6SzisiwGDhmY7rNltxjofbToZo143U54kXgBUh+jdtlQ7f/naiBiXvbHHH7Wte
	ETBYGVtRruJznTn9DRsRGRFm1O/DpEtCYZHRICHxhcSE3t7p6NeFBH1keEM7pU7ZV1xgjFN4iIxqt
	cChEXTqXr+DHlMKb9yAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVitx-00CaaN-9x; Wed, 29 Sep 2021 23:22:13 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVitZ-00CaZS-Tz
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:21:51 +0000
Received: by mail-qk1-x72c.google.com with SMTP id f130so4030994qke.6
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
 b=SJtWHdnGo9L4mdll+qKaZsmtvpn7ds7Jqf9UErLrQmOsqRP3sxU8o3aw5o2MvhL5Mj
 lM03toh8ImPud8H7vh/AGGkl+3vURvGKxRBh5yeP3iqYJ3RXD4HkzTzjBF6Mgc3CyYL4
 NPwaDU2c+i54bQ4atNBSa63XnbDUvexvPwjoCQkmNEdCUAl1T+QvgnRV98lCDddMEe7S
 LVFALRCv3M02kPjD9ocMpxen45b3XXJIbEyj72HfycWLiBpEdaWRxZc5TzgjO4IW95ia
 6tYGEjCfhjevDUh3QKMgzT1YEh/Dp9tLfgFk0cHBocInRv2rBNOuuogJ3/Vn3OANJNLH
 kWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
 b=WFGrIROvStRxt1pKpiqer123cM3cUOHClq+YE1VU3+IaBykeSYHIyP9LLrfkyeT6qv
 +9X9oNG3xOTj+ZiBTDOdOzb5ytRjhXLbYgNMEa2gsrbYT9gQA43/Su8hv8KPX3f0ZMb6
 DTG4aNE+zak0a5E6IBdrUE1HY7qJH61vTw7cLDbvD1ZknFOUF1at8x59ROsD95CMKUYU
 qxrhZGav5Zx5TG3WelhnpFzFPEgX+FGnpZ13zo8Su+q3JLk4Qfm1BvVR+4wZGa8f2CSJ
 ANCgOkffGSVvv2YSjqpSY+8rbHu6tlkLwQxdZ9fumJuEmMiQXAtI+HC6/PKcIMoRsbsE
 +5gA==
X-Gm-Message-State: AOAM533S628J0vpTer2061jY3e+h+mC45/fqUQseEumSWhZwa5uj6CPP
 5EN6RYp15UJKg9UUcvMSe/5AZg==
X-Google-Smtp-Source: ABdhPJxjfksXX9RBzjsealxa+5cO5Ph50HuUSNxxHRV+6R5kI7btDIJAlC0cqyNxWaWuBVsQ1jP8wA==
X-Received: by 2002:a37:b386:: with SMTP id c128mr2193672qkf.426.1632957708587; 
 Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id x3sm631017qkl.107.2021.09.29.16.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVitX-007ii8-Gm; Wed, 29 Sep 2021 20:21:47 -0300
Date: Wed, 29 Sep 2021 20:21:47 -0300
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
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929232147.GD3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_162149_996246_76F0AFD3 
X-CRM114-Status: GOOD (  21.17  )
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

On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to add userspace P2PDMA access using
> >> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >> patches in this series, but the early P2PDMA cleanup and map_sg error
> >> changes from that series have been merged into v5.15-rc1. To address
> >> concerns that that series did not add any new functionality, I've added
> >> back the userspcae functionality from the original RFC[2] (but improved
> >> based on the original feedback).
> > 
> > I really think this is the best series yet, it really looks nice
> > overall. I know the sg flag was a bit of a debate at the start, but it
> > serves an undeniable purpose and the resulting standard DMA APIs 'just
> > working' is really clean.
> 
> Actually, so far, nobody has said anything negative about using the SG flag.
> 
> > There is more possible here, we could also pass the new GUP flag in the
> > ib_umem code..
> 
> Yes, that would be very useful.

You might actually prefer to do that then the bio changes to get the
infrastructur merged as it seems less "core"

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
