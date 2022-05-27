Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399A5C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=; b=rkN9K0N/2dZ+o8hnzkXAvn2wo9
	DAfYVfHoBfJ3RB/fX8yJxoxG+3kz3hBmZXYUh9svc9Mn07U2LsodSzIK1k4EjodBAIJoYqwHto6l9
	Y3dzdYCfJWRxX7vlDLbfH6F03AQbFamYAfvIVQXOWr66tZ5ej+4m9Oq1hssz9p/QXrsUVnBQ8oHvu
	HSbAJ2KbYPmkKvQp7XtEUtpHZesZNJFGS8IVPFulMdVIqXeJrexizSaxMQzsH5u4TxQBq0wVZcFEV
	T+iulqbwy52roeDj8WEvyFf3XY7pPA86d5ZZwnX5Kt3FsEKNH+YErwPy9X/vtZY+zz+CzVq7u8OZk
	5kGB2wUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuZUi-0004GH-AV; Fri, 27 May 2022 12:55:08 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuZUg-0004F3-0E
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 12:55:07 +0000
Received: by mail-qk1-x72b.google.com with SMTP id 14so4799184qkl.6
        for <linux-nvme@lists.infradead.org>; Fri, 27 May 2022 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
        b=E1IEYVgSG0+Cp9E27az2DSZCdjooKZRFTIAknVPbxEA24IswYpisrb22a0LCO4Yutp
         4XsJlV3iiAHfEJHOUqZar/+z6eq/RNVnQDFf6R3luEpLOO9ZSoMj2k2S0fC4R/pSwYXU
         DOpBIBWUCslS52Qi/CzJYZEl+JwIDoG+YDkhlb773/e2F0xPQeqxylr+kzCyh268b3ya
         yKVvkB2lJlxnxrNfvpXMgjf4YpupMDYotK/5yJ7lKPpEk0ZuMkyWYAMEIMPhh7qzI2wh
         swLJ7nNqHWA6WZu24/335hmDWzwhZxSHaBFgg7blIZ9gyKzXZY7CMQ39H9PyDicns9IH
         ExdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
        b=7KDiBeW+N33iO0hzduKLeLQsdGogn4FDolurkEFIp3Fe4+gUTzkOV6zoOLSKpsj2Qt
         zlwuxWJ80yxztDNj9qYsegxKD2GLCMrjtByIh5nWAfnEfCq+LJoeWGQgt+9GW9IlXybF
         y5EidVAhDYQk5rZf5QPdlt6IDO1R5dxpH+ZrDZOHgDaoZiqwPbmRguQCkhqZpmjyTsbV
         C70FGNNPSWUbMI5sc1MsnO2EiFJnLCD+xNa9CIZFpkwVnl65cdMjL5OaA+VorRLMQT8T
         E7W3KF0GZ52omAHne2zLqnAQ4M5/4z2vdwIMkDICjGq6dMGUKixasd6iAj5f/cQKFqBx
         qrag==
X-Gm-Message-State: AOAM531DsLzWMWqvDLROMKmogoJbSDZOsbWpXD8Ad6GXyHA/Fh4aNLdA
	UJXTpng8XtpRg9c64G4JSHjlIQ==
X-Google-Smtp-Source: ABdhPJxcD+5XVE67Aydy9O792T3TtXb3ll0b0WRGBBEtp6VFaNN0UYQTLMiTbm4pLr0b1PVKMYNipA==
X-Received: by 2002:a05:620a:4481:b0:6a3:6326:784 with SMTP id x1-20020a05620a448100b006a363260784mr21538514qkp.372.1653656103072;
        Fri, 27 May 2022 05:55:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87d05000000b002f940249151sm3165272qtb.73.2022.05.27.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:55:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nuZUb-00DTYK-OD; Fri, 27 May 2022 09:55:01 -0300
Date: Fri, 27 May 2022 09:55:01 -0300
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
Message-ID: <20220527125501.GD2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154717.7695-21-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_055506_097542_893F90E7 
X-CRM114-Status: GOOD (  11.12  )
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

On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	/* Ensure no new pages can be allocated in mappings */
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +
> +	/*
> +	 * On some architectures, TLB flushes are done with call_rcu()
> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> +	 * before freeing them.
> +	 */
> +	synchronize_rcu();
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);

With the series from Felix getting close this should get updated to
not set pte_devmap and use proper natural refcounting without any of
this stuff.

Jason

