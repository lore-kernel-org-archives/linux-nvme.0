Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E938C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:23:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8837460BBB
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8837460BBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rqiFQzxPtleARSnaoHJl1tIE+5NYvsOwDsKPuVeAU0Q=; b=OcigNYg5hzvOUv7gduIxSTeMk
	+O5ya5S2SS1adcrbK/XcqrQN8OTdWuszh3AZma71Xdb/b7CmdtuhqAyxtAammSW4sYuPFO9kmsiyd
	scyWWjGef0OCQfqqOSbdhL7Eck8jIADavirUmrXcnp7R0AnQpx0q9kiF6wk9zPDd+tjqs5MLg3U6t
	ooL+d4z9Xj1ZZ45lZj4bmSJrN6sXiRmj/CbsnBWZQzsrKuJeIj2saPqRYuivlSab5zKZpF7y85mNk
	WNK5TzeNykvoRCXjXBCFiAnXCdxAq/d70wjTQcjeI94fADBaorc0H5JiPEtPdpTlIW0fkk9SnT9OD
	BcgGoAH3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTIB-0027I8-61; Tue, 27 Apr 2021 19:22:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTI9-0027Hy-9p
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=; b=KggWWsucSbvdlSKc4Mzkm+lmru
 pasC0Plq1oJgLLQGEB4RYk7IjoJpz4pQPqtLM7R2pFZFNPF2XCAYg/OUAhRqE1XFeJAe0wEeaNu/t
 PyASHrMtwLwjY6v/sKsOrXD8oAcSUBzkHuwg6RIQszKIQMWVzbwOHzvRY6gR1hZe4aJzY+IaQ4Z2t
 w2G5t2ZjW5bCEgub1jsloNPUw7RRoZK5OO3YT7Wr2fp016EGxLesZbcMUh/Bl91xPwv73wiQrS5rm
 4OPHos/6Cw10DdsAn3WPS2kpGcIXadkPMoTa//ukOz/d83c7iBt3HxdURVL4UnzhVkZMWhLdOuJAP
 fFrTst4w==;
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTI6-00GwGa-DD
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:22:39 +0000
Received: by mail-il1-x132.google.com with SMTP id i22so7642319ila.11
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
 b=KmmcN+wJO4XJEW8i1n4M8fdsVxKICGd+cicWY6PhIyfMntf61DWDbN0lYONPfv7avX
 7FxH4J1DcHU+d/BPW07cIeL7M0+KsL2H3xjnwnUShzOsbwp4p1Mstgek0/DJDywqlAvj
 pvQ4AeQxgT8d2B9boE2xCyb2V/QcKRwgqazkbOV36nIXZRCI1I41ENBc9O94GPWzuGWn
 ZoVb91ruebPuMOxROumRJF1bkL3LMcW5p3RL67vEkcYBqN+97GnMi303v4vqdgIYcysj
 J3wZPapZMjRdKb47N21dcq6V8IXSfFXXFfDtIZJD9rm1L4Cs5YgpeYsNB9gao99MRN+M
 bnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
 b=djr+2cFLCh/D2pUi79P5tyi9b1rkWvgBBYgdD2p4+JuDoWN13Ywujce45ejRL2+0i7
 lcNXF1S0qwOg1ICx6yxFXPz7BqMibCgz0K77Q7O/vPG3LT2skqRPVPqdSZcWCPZIXppk
 4Ep5LWpnSHJwv+fg5WNAcN84+Rce0JVH88uWY2qI4tu9VtFGUqdw3q8maTm+oUneLLIr
 soApX02Me5WONZqoVn6lksRGCgd/DUBGWJiYY8TcBdTnTgE0ciFSZRjXt8S9CyurEnc5
 I8B6ISl+x6cb4GK4Jj/hN/JRi8sxPTTt9MJYuR58gVLyA60sHewZOQJUmU6E4c/2i3wM
 XpLQ==
X-Gm-Message-State: AOAM532ONfmjqyojyqtYE6YKJG/8++4TqgKy0pAj6N00YQJixEqEjCKG
 CBhq9kbKNm7s9VgjDzmHU+Ht8A==
X-Google-Smtp-Source: ABdhPJx4F96uXqpXKJbkwUaij1OmBpJfBrZ4CVUAcProKFEqjv4XzeMalTF3wkg8sv23tVBPaKB/YA==
X-Received: by 2002:a05:6e02:13ca:: with SMTP id
 v10mr18478934ilj.191.1619551354939; 
 Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d2sm1817918ile.18.2021.04.27.12.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTI0-00Dglq-Rs; Tue, 27 Apr 2021 16:22:32 -0300
Date: Tue, 27 Apr 2021 16:22:32 -0300
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
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427192232.GO2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_122238_475636_154062DE 
X-CRM114-Status: GOOD (  17.99  )
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

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
> 
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
> is safe.
> 
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
> 
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
> 
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.

So this new API is all about being able to return an error code
because auditing the old API is basically terrifying?

OK, but why name everything new P2PDMA? It seems nicer to give this
some generic name and have some general program to gradually deprecate
normal non-error-capable dma_map_sg() ?

I think that will raise less questions when subsystem people see the
changes, as I was wondering why RW was being moved to use what looked
like a p2pdma only API.

dma_map_sg_or_err() would have been clearer

The flag is also clearer as to the purpose if it is named
__DMA_ATTR_ERROR_ALLOWED

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
