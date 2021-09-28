Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAFDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423A4610E6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423A4610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S9t8S/qDhT0Xql2yKIv9kFYei6SLEF3vuQXcC/zUKTE=; b=FD5yrC+QqhZT5F
	YB5KpwvD8Xl75n002KttR8sFiVLRsCH32SuJAPKWWm3b7+pMVGNIIiQh1gYoAQ7RfBSnMkXrWSAsX
	Egt0xrKTXiJI+vUhkOsc4Q1T2+4l8PSVii/Cr7IHzGQOJkOCnhHhWnrcKf1dpfrU4eCAQBeREXVlL
	X6jf8JQkeZt0pvTjPWIHVazcgfazl/sX1xgXPnDMM0bngXWlb8z70tKkr0TBLNOKwjYKwOqO0rpWv
	JT2VPNmN7f8WxazZfjATneYUdlEX2D48V/tobkDYjPj59crtzgeXW06h9JkK9L7fo+qmKP6yhLukD
	gTXkad1gz7qn8blL9GOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJLk-008jXh-Mm; Tue, 28 Sep 2021 20:05:12 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJLi-008jWW-0u
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 20:05:11 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id x9so59863qvn.12
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
 b=mXg4nC/0EIy5mcGZgRBdVGh4+PtQ/R7qKfJdIHvckLXvlCgA6RG20VZtoVAC7XwA0/
 1Q9jV1hRPeuiqNHTfiF2xEDf/GmdCrABm9VW4FZUzunFeWsbqWbu0OIpkB0K7pTzfgbd
 6AZsXvNDXNRBaOqQHwB6uloUHcpht9y8ZbZWcpcNkXzVJmyDxhAzyVOeTC4gm52ORmXN
 mB9dfyB6upC6rckPem/56kkVq6mMDb0monvwsJpjKud0G8lLORhrGaRbWZcJi7ULZ9Wj
 5fjO0VyJ8XxtZ4Gi+c3kBFto+M+PTYIof3BPLlQNFsws5BUO2HFuvQyKhOfpgnkZotGZ
 sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
 b=zKrEDEqV4c6ut7xuEawGV2w0Vl6bL5UY8CEYtMq5J2khbUG0lLuudsR1iHuLFSfxfD
 ZA9L8Sg7i9iSdywMCwSsgHLM5gHu8gt09uEsvTsh6tIxPvjf7iSzPYelBXiwfMw4J38T
 DctF2ucHwhbm9Q2cFYy/79T8PiMO80KrbZpy5nW/jvI77mbrGy/KF6jXrpTGx8114ha+
 51SaLveaW7jXibjoYbyRUP9rHlSSvFi/IWiy4fZNv24clmbCB0wkLEzwgMMSkSXR6S+8
 jdNWaVwQCmMNRGwRRqdox5ASSwg+8dqOLdSEfVJZ+luUEKeLsJ77adgcTxIVwNJoC0kl
 y7yw==
X-Gm-Message-State: AOAM532kpUilfG39HveBJZ3i4OMVeOEgSFSCNBbQH1bZgTeqXl1RKcmY
 5Ju+VDwFoqnfVOQ8f7S+FLyO9Q==
X-Google-Smtp-Source: ABdhPJzKbJYaBmt9+b2JfarRag3/wc7athe6CPjiFKF1JovwH1BSJxbPc5yOuJ/qnsZmJUt2zTx5pQ==
X-Received: by 2002:a0c:9043:: with SMTP id o61mr7850968qvo.54.1632859508704; 
 Tue, 28 Sep 2021 13:05:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id x125sm118440qkd.8.2021.09.28.13.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 13:05:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJLe-007GuE-T8; Tue, 28 Sep 2021 17:05:06 -0300
Date: Tue, 28 Sep 2021 17:05:06 -0300
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
Message-ID: <20210928200506.GX3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_130510_086247_8222DD2C 
X-CRM114-Status: GOOD (  11.63  )
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

> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> +}

If this is going to rely on unmap_mapping_range then GUP should also
reject this memory for FOLL_LONGTERM..

What along this control flow:

> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> +                                        pdev);

Waits for all the page refcounts to go to zero?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
