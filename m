Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81ECC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 00:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=; b=W2UlON5yij/YorGLlPtZzlO1n9
	suvdzEGFlhK+VwEQj1l+zEYEmi//9Sjw1TYZz7qTRcuhTq8YCUe2D3D73gEnp1PeUp6hm2e29KCl5
	dz0h8XlML28syWCpKL3ksIpgpYXPZ+gBj0bLZHz4BA5QPSmWBOSZHPD/ne7EjjPr+yB2+yzdaiR7P
	Do4chvjO78By6k5DbpMvZxfnqeabDcHMedRDiyimxm72OLT+7zFY3uL/+ObXiU+SdfpV77tMOB9Rp
	Tiiu1e0QEp/+/uIbn9HpPDbShOwXlvL2mcCmpYPQ4BP19Jwt0FALv/lbBMBIkWOChPBYgaJUS+duF
	Fsf5RTwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwYGf-000q0y-OP; Thu, 02 Jun 2022 00:00:49 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwYGZ-000q0V-Fx
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 00:00:45 +0000
Received: by mail-qt1-x835.google.com with SMTP id hf10so2384058qtb.7
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jun 2022 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
        b=PNI9gR5OxCMLK2wesmPP7beTza1LVUIA9KonYJGbDAFowaWR1+gOMSPFQyILlCbdK9
         gUfn5ltQQND4Igpr1PcoJgKaxcD5dBAwzrvhneuGmR5cB6Xf3NpyEwE9pIIgcm5WsDfj
         OMBTPHZn69Csi4sdfYc+o9dQdNtlWVyz5OxRR+X8nyDPYF6K2ahO4BRlxiavJkdgkk5b
         vBCAgX831wn8MMIkjC+ZBM62WCGcevuCk6vOX7Pr2o1vHeySgvRlg6SFXHlD9BjBBgRR
         tgzeldcoyTnuS2Xyrkl/LEo9UbgD40oyCdtA/wA5nQPC/hTnaLXrjoV5QjIEjd2lSEr7
         qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
        b=i3czajBra7HomwLUqxLDzXuIifRbynixLbKHjuBKAGC0uMYl6/qar7/JgYzL6N0/Sv
         PQGicsBNR/+PyBa3Kn6ATe3L8x3ht0w51Z4wxHS3Z2bMhHfUzVMH8BfEhNx0CMD3h1uZ
         QguqGlNKwybUUyNEvYI76J5NyI/NSg6nEH6QCgV82DytssCmffidKk4xtP1KIOFLevY+
         rUXv+112eru5SSkn8j0180Kma71KmfIhgdVmKTXNfQ10z7JkITfIkUak4LdmfyopvvOI
         IufQN0mMfQOQ6jzLo1G1bqa6nyJKAZEaZvVfviV+6kR3lf2PLVr8aF3PX3IJhQv0uHXt
         Q9mA==
X-Gm-Message-State: AOAM530ahcn4A+bvOi2p5wEjFmdKS+839jaMak03f7RIR6GSNFqg2Lqs
	rqCDhzh+vET6oQgwzN/8B/H2pQ==
X-Google-Smtp-Source: ABdhPJyvPa7jsnbpw9EbFCPQVbuxZnWhMX7Sx5D9T0fweaGvqMgcaf7CabbpUfVwopaFMLH+hIknjw==
X-Received: by 2002:a05:622a:313:b0:2f3:b9a1:dd4a with SMTP id q19-20020a05622a031300b002f3b9a1dd4amr1870963qtw.536.1654128040009;
        Wed, 01 Jun 2022 17:00:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b006a38debe62csm1867208qkh.89.2022.06.01.17.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 17:00:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwYGU-00GCY4-Af; Wed, 01 Jun 2022 21:00:38 -0300
Date: Wed, 1 Jun 2022 21:00:38 -0300
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
Message-ID: <20220602000038.GK2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_170043_946034_75DC27C9 
X-CRM114-Status: GOOD (  22.34  )
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

On Fri, May 27, 2022 at 04:41:08PM -0600, Logan Gunthorpe wrote:
> > 
> > IIRC this is the last part:
> > 
> > https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/
> > 
> > And the earlier bit with Christoph's pieces looks like it might get
> > merged to v5.19..
> > 
> > The general idea is once pte_devmap is not set then all the
> > refcounting works the way it should. This is what all new ZONE_DEVICE
> > users should do..
> 
> Ok, I don't actually follow how those patches relate to this.
> 
> Based on your description I guess I don't need to set PFN_DEV and

Yes

> perhaps not use vmf_insert_mixed()? And then just use vm_normal_page()?

I'm not sure ATM the best function to use, but yes, a function that
doesn't set PFN_DEV is needed here.
 
> But the refcounting of the pages seemed like it was already sane to me,
> unless you mean that the code no longer has to synchronize_rcu() before
> returning the pages... 

Right. It also doesn't need to call unmap range or keep track of the
inode, or do any of that stuff unless it really needs mmap revokation
semantics (which I doubt this use case does)

unmap range was only necessary because the refcounting is wrong -
since the pte's don't hold a ref on the page in PFN_DEV mode it is
necessary to wipe all the PTE explicitly before going ahead to
decrement the refcount on this path.

Just stuff the pages into the mmap, and your driver unprobe will
automatically block until all the mmaps are closed - no different than
having an open file descriptor or something.

Jason

