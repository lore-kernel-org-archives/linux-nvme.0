Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A926361440
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A926361440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yNoFxApsNg2hOxlU2fLPD8XCESvSuvyPkaIMa1PCU6M=; b=1ouID1c4NbJGSd
	BinMzB+Ihss3BFWga9QP0Vx0C4T9dwmzO5sNx/L0PuiaDzXa3thQKz4vCuF+k2YnfzpPN4cNFB+2u
	Qi5HpMlX5fuTaq92vAq5QMJf9AZL2JAvCUEfogJwAca8kQLvgcQsaaHz2tZgNsVg3Xil2/txzfZ1P
	JOszmLskizId9tbA4++yv2Eqg+MrLhyz+eUjY0BW4fyCCEL0bUtCr6WJLvXvj78K19SAhRwGsbE8h
	RUHXI1VciaIAfMqe9uWZKIiFeRah+5MVdBDY29/X+qXj3aMNHEZpcSDsKqsNtxArjUTgdQLOmQ3CG
	7yDFijrbZZ8AdQ38govA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVie5-00CZR6-Fe; Wed, 29 Sep 2021 23:05:49 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVie2-00CZPM-IW
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:05:47 +0000
Received: by mail-qt1-x831.google.com with SMTP id e16so3957194qts.4
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
 b=DIaskCn5WR5tA6jhdOqyO4JGz4+XatRitSbJTb+kmIqDsCr01GjZ0p3lPuKzblpDJT
 zhfIKMKyyPJmhP4fwKW9s1DOIPeWnXpgnGWww2ZsqZXMAXwagCxFkdbr/ZZNpdbvhNz6
 yhMxNtaJ4799pZOw9yof96R6NI1pis1TXcHgXiz2OGYJ2JTRjUBWxNfY9Bnx4SBlBLHZ
 NOkoZJeyzIFho5nhxKuuBqHTm7LkOuC/VLVY0i+EnUBy4CEUt/GqO7FcsIRDEUISOa/r
 ebsfSg+Kyd8gPXIldmrnVbOFPyE5xD126E/0FnMFaQl4NuKh0l+VCCKdHBolF0rJnHvM
 E9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
 b=uOCplKgii4rpciNqCvtk/BtPK80TvsGhJIY0E8ld/mr1WUZXAgpasoJ5j/3pbI2+6p
 +82QBOxYo1ltO/5hqjhu/qij1TGJ8415EseER1QMpSWWa8NgTq4xKcWgRvkjIEkvtcBc
 qDeFBrSrIvo+s9mKFqiFiGTsdcD+7176quLZ5tvuc44M6VhHjm8ONP4+1t4pgYcH5Dpn
 kktKyFLPiw2GAZH1jORzrcxQyirBFIY6Zgz9uV2oxYM88HmmrqpniCgb1AxQ8gwJ+oTH
 xx7xUlcYRy/hG1Sr+ppBA5Fzo2Re2wAcVZe4rhxtf9HSLHQzNboYk7Us7anVVoSonxRe
 O3Bg==
X-Gm-Message-State: AOAM533ojPHXQoiws50fNP65+L+vL0k0RWVCw/gmtJxhtsMvU7/FI0dt
 6NaC3cfW0QD/SuwPk9qcjiCerg==
X-Google-Smtp-Source: ABdhPJyapID+TUOl/mUzGMXiMJpXeNaxe+8Z2o/bunUXmIm+EzT4IvoM8B4R+kDDMjzs5lMTxyRE3w==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr2882513qtq.365.1632956745011; 
 Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id h4sm645980qtj.83.2021.09.29.16.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:05:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVidz-007iU5-Sx; Wed, 29 Sep 2021 20:05:43 -0300
Date: Wed, 29 Sep 2021 20:05:43 -0300
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
Message-ID: <20210929230543.GB3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_160546_638489_3AB0FBC2 
X-CRM114-Status: GOOD (  16.40  )
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

On Wed, Sep 29, 2021 at 03:42:00PM -0600, Logan Gunthorpe wrote:

> The main reason is probably this: if we don't use VM_MIXEDMAP, then we
> can't set pte_devmap(). 

I think that is an API limitation in the fault routines..

finish_fault() should set the pte_devmap - eg by passing the
PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
otherwise signaling do_set_pte() that it should set those PTE bits
when it creates the entry.

(or there should be a vmf_* helper for this special case, but using
the vmf->page seems righter to me)

> If we don't set pte_devmap(), then every single page that GUP
> processes needs to check if it's a ZONE_DEVICE page and also if it's
> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> requirements of FOLL_PCI_P2PDMA.

Definately not suggesting not to set pte_devmap(), only that
VM_MIXEDMAP should not be set on VMAs that only contain struct
pages. That is an abuse of what it is intended for.

At the very least there should be a big comment above the usage
explaining that this is just working around a limitation in
finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.

Jason


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
