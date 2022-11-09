Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3EFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3gnoqK6D2Miuin5pwo6jHBYFdre5OF3EfWFPvLxtq8=; b=mfixxzMZqP0iZNb5gGxgwk8ZAx
	SR+xmSBfvNeTeIryGcc7FEhMxVlxk4/LcTGlNEga9Zo9rIiRLITrAukdjGR2IPqF5TAgHEaiqk9Bg
	K81HCFiJsuYsXuJbiKAeWtPezoFSPvxYZDZSQWBjVJ0AZ2YF+19mVE8mB+bO/XeF3Ofk/Ukux+McX
	A2BOQrnHZR4ihepb8st/GhdL7rz8ciGWpz6iqqvS3o28daro5nHVIohVkb0LRC+JIdri8F6P5t6Sq
	p7PPp3OgPU33lLNdGk8ZBW6DHbN2HezZjhZiwP+heZ9/lHfzxX9SgjLYZMCLz4E4yAlboWzAOhtAP
	lBXMtH8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osq4E-00GGvS-QN; Wed, 09 Nov 2022 18:44:54 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osq4C-00GGnx-9n
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 18:44:53 +0000
Received: by mail-pj1-x1031.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2773214pjk.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 10:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3gnoqK6D2Miuin5pwo6jHBYFdre5OF3EfWFPvLxtq8=;
        b=b3Vlitfa3cybSlW84JLWFqEuOyBemFM8tzzrFEQDyWRxNIcMFAMI92JOkkfkBTPOns
         9AU4ZYr+URfjv4v8NzxcwfsfKBi9GnX3eCANXE767WjID3tii9m/Axf/knEf0xf3Tx42
         KEPReYGg79g6OhenCPR7GZSpxcS44Cho78PVIbIc9QKooULFGDifsJvC1YZ45qYKli2E
         ISPqCuvJv54Kq/I+Q5AtyZDxrp/4lAJtO8b29V49SCobL073ccoTfw1sZUb0+N/+yCo5
         UgxEtt/EP5noXuWNZtjd8iTtGu3c323gd8VtDXhq3Gze4Mp3VMLFXYRAGNLJgHTmKzax
         Rn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3gnoqK6D2Miuin5pwo6jHBYFdre5OF3EfWFPvLxtq8=;
        b=MFxbrBacO+vwpIAens0l9BnB6Z8VgFqcH8/uv9f7mOvfqGKbrZi5Re/uO31c+kziu/
         c15wOaAkJ8BsI9LRl/ZH7jCA2klXykBnabBvmxE4203+qcWO1Eo6+CacLF7XsUtucp9u
         39d8a7BOTgKVgEyaimCUe3+e01BwFk4BosELKmwXPZnmi0cIVZM2Pub7hrVjomC6gUVE
         xRjhZdbO0loAWpQlST83Nql69BIQ3v1pdKoHEW1vbE6vnfCCsSJ/LhGCOFGVXf/z85yH
         yIAo1bexr/bsysIKl29iCVVinMh+wuOY3NYQIftcv8j8uqf6Ry67mcc1WebuKaI5nh1P
         jpTw==
X-Gm-Message-State: ACrzQf2feKJDluc8DlledTOSAA+I5tHbmoc8DoaX0K65kVKy36RbDMNW
	sA3gVeZMHPfzxJAYtr9HR8fUFtmw2j31VQ==
X-Google-Smtp-Source: AMsMyM6pEjqco+aAjjL5gj0laOht4xYC6FlktsQnWZq3kxt1KO+qWUhXX6uLe3TPaISKh5H5cyazFg==
X-Received: by 2002:a17:90b:3705:b0:212:e2e5:c0c0 with SMTP id mg5-20020a17090b370500b00212e2e5c0c0mr64598302pjb.239.1668019485503;
        Wed, 09 Nov 2022 10:44:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001784a45511asm9438022pls.79.2022.11.09.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:44:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Stephen Bates <sbates@raithlin.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Martin Oliveira <martin.oliveira@eideticom.com>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, Jason Ekstrand <jason@jlekstrand.net>,
 Robin Murphy <robin.murphy@arm.com>, Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Christian König <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Don Dutile <ddutile@redhat.com>
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
Subject: Re: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
Message-Id: <166801948299.62038.7880027993878682342.b4-ty@kernel.dk>
Date: Wed, 09 Nov 2022 11:44:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_104452_349171_96A04A32 
X-CRM114-Status: GOOD (  11.67  )
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

On Fri, 21 Oct 2022 11:41:07 -0600, Logan Gunthorpe wrote:
> This is the latest P2PDMA userspace patch set. This version includes
> some cleanup from feedback from the last posting[1].
> 
> This patch set enables userspace P2PDMA by allowing userspace to mmap()
> allocated chunks of the CMB. The resulting VMA can be passed only
> to O_DIRECT IO on NVMe backed files or block devices. A flag is added
> to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
> on whether the block queue indicates P2PDMA support. Patches 7
> creates the sysfs resource that can hand out the VMAs and Patch 8
> adds brief documentation for the new interface.
> 
> [...]

Applied, thanks!

[1/9] mm: allow multiple error returns in try_grab_page()
      commit: 0f0892356fa174bdd8bd655c820ee3658c4c9f01
[2/9] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
      commit: 4003f107fa2eabb0aab90e37a1ed7b74c6f0d132
[3/9] iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
      commit: d82076403cef7fcd1e7617c9db48bf21ebdc1f9c
[4/9] block: add check when merging zone device pages
      commit: 49580e690755d0e51ed7aa2c33225dd884fa738a
[5/9] lib/scatterlist: add check when merging zone device pages
      commit: 1567b49d1a4081ba7e1a0ff2dc39bc58c59f2a51
[6/9] block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
      commit: 5e3e3f2e15df46abcab1959f93f214f778b6ec49
[7/9] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
      commit: 7ee4ccf57484d260c37b29f9a48b65c4101403e8
[8/9] PCI/P2PDMA: Allow userspace VMA allocations through sysfs
      commit: 7e9c7ef83d785236f5a8c3761dd053fae9b92fb8
[9/9] ABI: sysfs-bus-pci: add documentation for p2pmem allocate
      commit: 6d4338cb4070a762dba0cadee00b7ec206d9f868

Best regards,
-- 
Jens Axboe



