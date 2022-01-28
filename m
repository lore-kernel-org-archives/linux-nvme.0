Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7491C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=; b=y/MBzC4jfWZR3ojiii5qrQ0gOz
	WM7A0rNHo6+7TkpCbLVBkqVhnIkgnAXn96XYO/S1GTCZoYri3VNSB9BPVl8qbG/BoOP+Mg9E/NgAK
	ThiT6bRT46vlGsPAH+bAVyuZknsryMftvxhsXzJ3wLyPundx7rm5r3zLPa6HaiRCAvlbi4jcATBfs
	lIk+bUSa2JemP/T1WBteDV+VPvrpDsm2kCiPZYxjNY89n5qPVBeaXbwqXlSvzxIF8tHr+3vGiFVj/
	8g4kVuHaV7P/jfKeWouudZdiV8WtKSUyUFZeqO8Ic4zT4RovQd0HTZne2eRDXAp7BvGxXc+tD3MM3
	u6DgypVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDS9T-002Wsc-Md; Fri, 28 Jan 2022 14:22:59 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDS9P-002WoR-0b
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 14:22:57 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id g13so5955026qvw.4
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
 b=U6c+XkFY8s+Ffl7FMQbVxlp2XqdxMulpeXig888uzfihlBCtxwuxIolRJkxjXzaeEX
 eIVyFvkbbf1xDb6SPEgSmnVCw9pDRfPJMYU4oslaqMl3i67iHf7KZeS/e0PmUBODdSZZ
 AowH8T2WlGQ4lht/OCyvJWxyWbcXEvFC6taxlenfQBvCzsa6ZLxsUregxcSiDD43dffE
 wyxXaf1wb+uEKWMD1qAmtSSmLQmslFUsrWqqlGvzI9Koh8SJ+5/r0xM1DEOICXREV+1R
 hc7uSuZaF6wJJ5ERb4Bbz+7wa78dvtPacUGiJQdQuCom+zLYAupwohfFwPnp5nzy05HC
 7X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
 b=vYw6FSOP4zbKiZlQSYdOyuspe1HR+xuWxOGnsPB42WtByRIwwJzMkkUr4dbUnNmdY2
 Dazswi1UpHojCX5bgdYkZoZhGpFBQx801sSZ1NYFvP0ObPSSsAJ0rySSaIDtRc11y29E
 rMLwkJoOKicTtaHa+r96bYS6iIWmrE5d1+zMdcIeZIzzk3DfSEMkITV7l9Z5q0xHd53H
 9r+7NXc5RfTsCvMbP12W7pSlHl0+5TRsLSM01f1ZC6/k8f+r6jn26Xv4Xgk04b3jlqkV
 gxODC+Elar2vz5tWnwdxOtln7Tz9t+YmuUSQKHu8iTFxJtzm1fZByFzWIcKqbQmB4LVw
 b3nA==
X-Gm-Message-State: AOAM531JWTvpRnWRLj+cEI7foj6ePDcHmLhxPhUWKrCK4TcycHxNSSkm
 CcsEvpRHDlgkHMrvJRDme6mbNw==
X-Google-Smtp-Source: ABdhPJxVRgqXNs0AEB/UOEkxwovAuD7L4ajDVFitY42TUAFuPNOZiD9bQ3/LB4azis3UeruHH3Md/w==
X-Received: by 2002:a05:6214:29e7:: with SMTP id
 jv7mr7547390qvb.114.1643379772621; 
 Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id v22sm1250520qtc.96.2022.01.28.06.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nDS9L-007UYx-Hy; Fri, 28 Jan 2022 10:22:51 -0400
Date: Fri, 28 Jan 2022 10:22:51 -0400
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
 Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
Message-ID: <20220128142251.GV8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-23-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-23-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_062255_147184_69E20E2A 
X-CRM114-Status: UNSURE (   7.92  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jan 27, 2022 at 05:26:12PM -0700, Logan Gunthorpe wrote:
> When P2PDMA pages are passed to userspace, they will need to be
> reference counted properly and returned to their genalloc after their
> reference count returns to 1. This is accomplished with the existing

It is reference count returns to 0 now, right?

Jason

