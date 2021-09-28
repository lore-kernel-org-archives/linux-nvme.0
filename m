Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C524C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C722B61246
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C722B61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=avdpw65y2oUWZWpXOWUaHyZaVQB+WgFtGgmtiIJEj+M=; b=TjROtf8T3gkQmz
	rxPJYkeCY4OVz/sUAuw30nY1Pr5kvReMiMcGjwE31wwcjRzevdQSg3ZZe7DMW4UU3puQyKc8jDWVJ
	xu+ngwAoDhQynqyjmriZ48jMPzL+cjpLwhy3bfLKPhIRUu92C2m8M2gcAzmRjKjU1BrtmxxvVWDZk
	UyHdRkqwhOi1YgS/TjsColY98YghSm9kR9+/NVpjeuFRYePTTRK//XklUzyYdFXb6yuKhFPXtEKWe
	8sxQ3X/Wf1MQN744W1U0G0ik+WgBQ+UzVr5Ik/ciWjp8cJJZyPAryXkzN9Gd7LpJHacmK3Sceup9O
	OQSHOX5jgVV3+AE4p+LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVIJ2-008YDs-Ic; Tue, 28 Sep 2021 18:58:20 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIIg-008Y6T-Dt
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 18:57:59 +0000
Received: by mail-pl1-x631.google.com with SMTP id t11so14828434plq.11
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
 b=Jx2GOuLqIF/s/mi2Zrk/xAaRKuyWPWZHCfm+XwkC1Yr0Dv0vjM+OfZQXVIMiJLsjmt
 UrV/wXbA0S/kA8NHbPEFpp1dbqLg5YihHJ0daxdbRmoiYipdrvH9aE1GR+5dg2ru+RLb
 D9RlleKhxyRZz7x683IeC5JDgX+RCiwr9h+iGzv5av3RkyBoFDWC4oGW5kDI8NZqd+wU
 GG0wiVbU0tcwD2OsUIWVh8MXHIcG0Qmyu9kG4Cl/ZJH0N5wnluQLcxjz6xhITElaiUL1
 soubsWJ2CeaU97V7PVulKA29iDPu0PVzaYdGQFsHPsL8RlHji5XVx44zUSja9oX1iGFJ
 ehCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
 b=osK8nmXZ7Y47lW7uX0kQxMt8VBaBy0zcH6M1smHlUV7R/Ndj0aE62TSWiWGFDwtNX3
 od0rPlkdH+UNqPZYf1IVbSpHvl/zgUdHaLL1rfKv9aSl9FZSJQRi35smKp89HiGrqF3m
 1+MORORcrMj6+RQ2ja2nhe2jacwDlORqe+TvoOlPrinkwCBT/NUYLZky43tulyp7s0VB
 48Oqb64mYT028Z9NhCAm7lsm/7YAIxYofexrzTftzJqoRclQdNMGKQLEjx0x66ILfypF
 PwCG4WQaQ5egqMJmKvMFZJaW5V/yEqdl6aUYz5R4Z2caV8/LbLiXQHK+itgMMVBUSoTU
 wJMw==
X-Gm-Message-State: AOAM5301MNoQVrag8oEUdmnPY9cUCU5DD+2nyutXdz4uGl3elFd2J5of
 7sOf2Uyi90X2Bo/bjrxpky6Z3A==
X-Google-Smtp-Source: ABdhPJx53FQmydkeg1NJ3LXDS/rZkMGUByvF4f/aWGCpIOOYUi1lNT78rKchyK327J3h0Fhk9/CHgw==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id
 u4-20020a170902a604b029012cdda230c4mr6060505plq.73.1632855477627; 
 Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id o20sm22682349pgd.31.2021.09.28.11.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIId-007FjO-20; Tue, 28 Sep 2021 15:57:55 -0300
Date: Tue, 28 Sep 2021 15:57:55 -0300
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
Subject: Re: [PATCH v3 05/20] dma-mapping: allow EREMOTEIO return code for
 P2PDMA transfers
Message-ID: <20210928185755.GM3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-6-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_115758_493243_714B22D0 
X-CRM114-Status: GOOD (  10.67  )
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

On Thu, Sep 16, 2021 at 05:40:45PM -0600, Logan Gunthorpe wrote:
> Add EREMOTEIO error return to dma_map_sgtable() which will be used
> by .map_sg() implementations that detect P2PDMA pages that the
> underlying DMA device cannot access.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  kernel/dma/mapping.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
