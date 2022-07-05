Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A7AC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aXXqCO4eYEW7ihl1nkLRPlC9zfL+9NshKktoq8vfUqo=; b=xVgDqfaffshkzyLKXuJqgCbQVT
	W2+gD3rDlqoEIz4MQuyjRydrbcEMNAUqaNydOdAL7ZrqTLaXhQ+eaRD8gqTXCP509EjPVkHWHOid8
	8O+xBAudR4lsEi4Mq0PqbZ6VIAShXXSPjMiGCfITOJAZTqY9dlLWGK7Wnbyw9pHUzSB6fSrKgu2Go
	cMD8QHANwjMyEeeyxm+S8zG4EIYrUimlgX+RA5DL1e4tyc9RA5B4Lgv5h7VENfp8f41FnCwIzQtwd
	R6/M/bEgrU3EZgI1MIvmsIAIQ5TV0E1YXEFwoGYhTgQFO4tWBR5KBp+pZZfv8utiju+U3gC//u/qE
	2wIrEENw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ixK-000bsT-49; Tue, 05 Jul 2022 13:51:10 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ixH-000bpT-CG
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 13:51:08 +0000
Received: by mail-qt1-x832.google.com with SMTP id ay10so13681442qtb.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Jul 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aXXqCO4eYEW7ihl1nkLRPlC9zfL+9NshKktoq8vfUqo=;
        b=cDfN+bQczbdMb2leah0e/N44YCVFwIYBhS6uK2yvKAxV/VrnPHyc+hyWjNAaUg1PfL
         kVcyYs7o5yY5RdPBbZ1Uy12G+gaOeGz7GPvyLzJpp7K+3AfzkxCHdfURo3kwOoQVGHsB
         CgYT4nV/UQd7IrmpI3kE+7IkazWCK3VkAF/AOUDIg9vA84UJqgb+kOFEqstZkexFUiOW
         t4uMNrJQXIZB/yeHytTtD8UoGO1NLRJoiAFfgFOvXzUbr67CkUchXLiOTkdsKPw7QrA5
         0GMzIsPAHjhYnDnVJ1sJYE4BoAvaoerhS04hqo2hF28Qc0NfnJdWsyByjW3v2jzln7ab
         r2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXXqCO4eYEW7ihl1nkLRPlC9zfL+9NshKktoq8vfUqo=;
        b=lPN/+J10ExC8Piarnq22J8sKWH6AQYSKAuhzLNw+i6Il8FpZ3/Yq7zuPMykISHQdKv
         C//v43gC7uomh3cfa3lWmEDcoPJ2HPOR3bDYA6eTC1pSAhS6ihnZRAizllb8DGIpuu11
         BEFnd/mfYJ8d/XXNv1cmsl7IORM8eRKxlxOz0GIJDGfUbp66IfUqT8m3Cro1L5gyKFkx
         Fjer5ryXDIep7szRR0OT2ycbkeVPHv+vmwLK97h3NZHsKGAu5DQ61OYZIHKicZ2McCTV
         LjriehHxa1J8s/7tvFDw6hwPRvFv0UwPCDbj71howqZjR3i/lqYrVCAhn7QGglRBoffM
         FUsg==
X-Gm-Message-State: AJIora+eYYAzYIbfmiZ/62b5u6FI12C24BXqUmkS0yjQiHzCLhR0FkgF
	ov2n9kzabq9lreU82FFlKTtGDA==
X-Google-Smtp-Source: AGRyM1tiQ1fXhmwo7QGB7JVrZMkNllap136sZt6NhU7vlDBe2k8co+srzJapO8MDIuFHQGrnlFDnUA==
X-Received: by 2002:a05:6214:5005:b0:472:e6b0:1fb2 with SMTP id jo5-20020a056214500500b00472e6b01fb2mr12627413qvb.124.1657029063626;
        Tue, 05 Jul 2022 06:51:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm27745242qkp.103.2022.07.05.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:51:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1o8ixC-006VQ4-6E; Tue, 05 Jul 2022 10:51:02 -0300
Date: Tue, 5 Jul 2022 10:51:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
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
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705135102.GE23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705075108.GB17451@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_065107_473861_07E36463 
X-CRM114-Status: GOOD (  17.84  )
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

On Tue, Jul 05, 2022 at 09:51:08AM +0200, Christoph Hellwig wrote:

> But what also really matters here:  I don't want every user that
> wants to be able to mmap a character device to do all this work.
> The layering is simply wrong, it needs some character device
> based helpers, not be open code everywhere.

I think alot (all?) cases would be happy if the inode was 1:1 with the
cdev struct device. I suppose the cdev code would still have to create
pseudo fs, but at least that is hidden.

> In fact I'm not even sure this should be a character device, it seems
> to fit it way better with the PCI sysfs hierchacy, just like how we
> map MMIO resources, which these are anyway.  And once it is on sysfs
> we do have a uniqueue inode and need none of the pseudofs stuff, and
> don't need all the glue code in nvme either.

Shouldn't there be an allocator here? It feels a bit weird that the
entire CMB is given to a single process, it is a sharable resource,
isn't it?

Jason

