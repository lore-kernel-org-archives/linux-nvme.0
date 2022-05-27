Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=; b=RzuvuLoNH4HO+xI2j2paBeZ0Ff
	ncmmPG9Pu9F9bnJZqkUjCJwJaYBDRQ5P06FQ4YStUlx8TFhjNQQTbps+YthUKeEiPNQTGHx89/6EV
	LGbXieskwJ2lfGzNhT+DnLlCl5Q7WkjyINZz7QZFlLcWbNibsCOuLXYRItypmbrJodQNEW06whQoA
	PPosofgV1U5Z8AGBAGxbESbHqcl0Yj/4yNSqx08Z5Zpfk9nLu1rqCL1ChTjkQvnUrtO8kofakVyk9
	07UwVKy/6d17YhiP2aYhJLue5IGtRTZp5rNBAigAyrXtT39Zk97YsScDWSK8R10il3JJge6OlpdN3
	IELQe02w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nufF2-000oWE-1f; Fri, 27 May 2022 19:03:20 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nufEx-000oUU-Qb
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 19:03:17 +0000
Received: by mail-qk1-x72e.google.com with SMTP id p123so5576239qke.5
        for <linux-nvme@lists.infradead.org>; Fri, 27 May 2022 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
        b=pCvvJmfpoo0WDFfVQYDyZGy4qzndOFVtgtSqVXTrWRGEyBqzBA7UAXhKvpkD0Q9/6I
         MSCpLxGE9cFQ1cGdQAtYz+UeGuecy1S3YR7ZbQ9wbQYDjQVRsaTuBol2dHTD44aSUBRR
         IycaJl0ihzjjIE0NocdjmVE2xhgAzy3ISwyDQK8gAI5+MC0ECVrWBJsD5Ckxr01Dq6tm
         NfD6L2oXhGqyHayMYe3j/EFrEVhX3h/t4cx5QraZ38JTD9HD3wAryzP4gzJYXUsnDZYo
         kHgGnIpoEzZEBX8KlbDHtvDbydY35MkFThf2P8sBKcZrGoTNzHOqvBFv/Fi48v3KK05/
         5Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
        b=IRmpqhtjg92gNOzzWRtw07r9m5jk23aIsKGp+DDnoOgJNo0/1HXxWDqLkrCl8dv9pJ
         XDflrlzmvCMToP6vdo6VD07F195SQtGAodyubsJwyYjfu8Nr2giv42YVu/avFvp3gs9U
         5DVNmYl4JLmyk2zbWpq2nRpoLbwyN5XhytW9BxMkKPUUrU4m9wf3RO4ovH5axpdYNEF7
         Ycce48A5XjkiOM4S2FMaxy9+z9xBgz+AfwbG7QVlqLvDOe5wdjE6aSzuspuO/9wj5yZl
         HaOgXPw8sX0X/aoD1hQLnqblJJzXAu1m3j3Zx43amvMxWz4Ps6vLBKQ6CxjqkFvGi2Xc
         QR/Q==
X-Gm-Message-State: AOAM530k3X+BMRmk+wHxXEJQhOjHYka39VVPJjUzQpdZ7JoB2s/DRxfX
	hcT2t0/VyCttEY+Jf7JTHufr3A==
X-Google-Smtp-Source: ABdhPJyO25WugHG0nEenLRCgTZGSyoFZr8oLpCObiI0Q0Dbj3autEreqfFCD221s7ojQxz7nAKospA==
X-Received: by 2002:a05:620a:298e:b0:6a0:94d2:2e2d with SMTP id r14-20020a05620a298e00b006a094d22e2dmr30141554qkp.353.1653678192374;
        Fri, 27 May 2022 12:03:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a079600b0069fe1dfbeffsm3024426qka.92.2022.05.27.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:03:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nufEp-00Dd1y-Rg; Fri, 27 May 2022 16:03:07 -0300
Date: Fri, 27 May 2022 16:03:07 -0300
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
Message-ID: <20220527190307.GG2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_120316_250491_6D69945F 
X-CRM114-Status: GOOD (  19.00  )
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

On Fri, May 27, 2022 at 09:35:07AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-05-27 06:55, Jason Gunthorpe wrote:
> > On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> >> +static void pci_p2pdma_unmap_mappings(void *data)
> >> +{
> >> +	struct pci_dev *pdev = data;
> >> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> >> +
> >> +	/* Ensure no new pages can be allocated in mappings */
> >> +	p2pdma->active = false;
> >> +	synchronize_rcu();
> >> +
> >> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> >> +
> >> +	/*
> >> +	 * On some architectures, TLB flushes are done with call_rcu()
> >> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> >> +	 * before freeing them.
> >> +	 */
> >> +	synchronize_rcu();
> >> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> > 
> > With the series from Felix getting close this should get updated to
> > not set pte_devmap and use proper natural refcounting without any of
> > this stuff.
> 
> Can you send a link? I'm not sure what you are referring to.

IIRC this is the last part:

https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/

And the earlier bit with Christoph's pieces looks like it might get
merged to v5.19..

The general idea is once pte_devmap is not set then all the
refcounting works the way it should. This is what all new ZONE_DEVICE
users should do..

Jason

