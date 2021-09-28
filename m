Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1346103E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C1346103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HotIiQ4eZxbL9UUWjo/EYv6d9cmejLHc57MddxhQlEQ=; b=n4pTjlngSeTrSO
	VkPfW+WW7v1DXeAf5eYkHRAECtuveySROqdAUQnqOt578ligMNfjhlXOa01r/5Z+SE/TQZIW/UGmF
	IO1YjKORIHpoIKAqsX8Px6NSxWDGj/G05UfBsfEIom9kAff3i/xw7FUF0J6iCuS4kbTAUsnLK9z6n
	x3O6ONtWQ3CyDoBwm0Xz+4c6vhK1nblZAWQwsIDqvlr0hSWpkncqQYffVWdjj/izmrNaeSoRQ21P7
	2ee7lIGZqaRfhoUNYsXcmSVIdr4mqzVFvJR7XtG3Y+o3Rpr3xNLpnb6chN8y1qNC/97FSvYhUrORz
	HbThePRvcRoJzMvsmMPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJCG-008iCA-Ad; Tue, 28 Sep 2021 19:55:24 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJCE-008iAh-0T
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:55:23 +0000
Received: by mail-io1-xd29.google.com with SMTP id q205so100433iod.8
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
 b=ZeD06VESIVwTz1xeRXSBHGWRRwsuqhJZqQwA7cS8w7S36OQJ9M42GPOt60GoPm4LLN
 EhyE/ygXrJFIONCKDGKyPvXji5TLlEPtth9nQsRZuy/IeYGcjbWWP7tWPdZ/g49vlVEV
 D4ziTYxHr8njp8La9hvWgYGQygcfX8fs0pN+lyR+t1RqdyHwC/7j9ctRh39DBoSxrCAF
 W7fZNVt8JY3zn5Gg4p3VkhBgFht+DBRN4Umj8cH8EE9Lo3YE6taSK+G2eOxlcDNL8a69
 u/eiBSoiyJw8GFFxy3BA4RXuA7thqLvfHkJROM11lKZey1rvl8Ml9UFTDNyZ2L/Vl66Z
 9YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
 b=8OO3JV7fWHKs7tt84VFAeJa4PHNjGfZWHdX59O9nDLyEA7dOK/uQR8wK5BsCRL+/4t
 OJgUca794CEZ0CCNmRWVA69zTjhWruyXZwYRHJPbE8HznZK3GKYLX4WkbHHKd/A7ETcs
 vsmmrrCqfRN/QThC0he1g3XhjzjPvqB9rGa5FyUQS6V5veK7AwUsyJqNg+MipD1nTF2H
 opQfkahDcwZISKA41erJ5WPoApTzXPz8KJUxahQl/vYSuq6dpQPvun5ZxinDFgwbW/l9
 LU/oVSkRNmF5TriPOr4T4dxZ0+Mar6mMjB9Fredvb5RaGicmjSUzNfAexBQNZgfHOTZv
 7zMg==
X-Gm-Message-State: AOAM5300vNg8CW775L4JEFgvtVUqc6b6uOLml8znMKZCf0rl/sztc92V
 Xn0+Kz8UOxKEr1loeF2sjdf4yg==
X-Google-Smtp-Source: ABdhPJxDG+imIW+LC31md8sJ9W5FJ6CYFuQFlJipqlnxhkrntzvi5fuKARgO5VrFwZOn9a7R7YqD3w==
X-Received: by 2002:a5e:c018:: with SMTP id u24mr5346781iol.129.1632858920781; 
 Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r20sm30511ioh.19.2021.09.28.12.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJCA-007Gjs-VN; Tue, 28 Sep 2021 16:55:18 -0300
Date: Tue, 28 Sep 2021 16:55:18 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928195518.GV3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_125522_086200_7ED5E1B8 
X-CRM114-Status: GOOD (  12.37  )
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

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
> +{
> +	struct pci_p2pdma_map *pmap;
> +	struct pci_p2pdma *p2pdma;
> +	int ret;
> +
> +	/* prevent private mappings from being established */
> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> +		pci_info_ratelimited(pdev,
> +				     "%s: fail, attempted private mapping\n",
> +				     current->comm);
> +		return -EINVAL;
> +	}
> +
> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
> +	if (!pmap)
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +	p2pdma = rcu_dereference(pdev->p2pdma);
> +	if (!p2pdma) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
> +			    &pci_p2pdma_fs_cnt);
> +	if (ret)
> +		goto out;
> +
> +	ihold(p2pdma->inode);
> +	pmap->inode = p2pdma->inode;
> +	rcu_read_unlock();
> +
> +	vma->vm_flags |= VM_MIXEDMAP;

Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
struct page, right?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
