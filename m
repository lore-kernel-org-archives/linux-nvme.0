Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F142C02187
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=; b=amVdvfR9mH8znes5APDtL5YTAk
	+cRWUcIAyUSkxPmR15Y5hf1DcteQRlzvGGzg4BKTxG5KNc0U8u4SNs5tN0PwWOisweFMiQxoQLVNu
	j+Ay2ZBS6H50DNbPZH3P8fgtRE3UR3AshNd6k/6YaIB3eQbxZwQA3h829226KAUKEhhEBhQKCXaT1
	Aa9E5dTjkNjtRt+V2ctrOOzFoVXhcss/lj9B1xTImiD1TM7sZSqa0SirAhzu0KE/aC3zFHyf9luIO
	pjPQwhrBgeGaebtWGzJ15z8lXjvRFYSnlyWw9D/93UXI2xE+Qjaaj0SlpJFufsj8UinDOdtJ3YEwQ
	TV+rcOAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWKT-0000000FzTI-32Wc;
	Thu, 16 Jan 2025 20:19:01 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWKO-0000000FzR4-11IZ
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 20:18:57 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6d89a727a19so24105756d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Jan 2025 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737058735; x=1737663535; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=js3ifblFs1Rc9PSFpoUbeZxMpcntlYWGbpo+GWMgCpH19CIxzkqmXNqDRra9Lktr5p
         RjAkTfegW6DoGYvc1ni2ACB+gL8god/7aE428oHtkG6PUNA/vap7ooswy452IZMb4z9J
         oXb+hEryy8WwznkLVvvkMtSTToA3d0bKlAA/oA4n0vmsJVhH+o9XNrqPRdBhm5T2lx01
         kXepiV2Gg8Qd4lRyBtfjMFrapu47A3BS1zKLU5bjBOgwAzKjgpyGggJukmAdJkSQX06a
         dknNNQYgOKXF6HU7iS60lz5F9lW0+JzJbbZxltCEGL6nbrE9RPgyeE1HEZHCRsFZkGBm
         hYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058735; x=1737663535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=sppUqskjXe64IaRufPyPUQbfyIqsPULT4S8OBR1kj+aqMIekzrSQbZU3AhL0bnJW3j
         WOz1lADz/n/IuzwcoEWKTrhEacVAt4T9xQNQMwASvp3gP+QPeoO3xkgJI8H/5iCHoRkE
         VS/jn9iz+L5V+sJ1xvMgUKvFoyL6If/jgi/Brxebo13tO6Cwh815bRnaAeYAyrOmWrKo
         38sa+bfmwGqIopX2ib/0zuGowKnuBnYQKbomHKFNlffmvcM5bPfiwqNRfdnx8xqgzZU4
         hZfexyVuvfmrAHCbCc80Hk9iHhVUjnHPYQh7a/ypf/v57ICoO0FlzUzfUmxsSs+f0bbU
         UySw==
X-Forwarded-Encrypted: i=1; AJvYcCXUKqV9gnfjM9xEdKdgLgPLVHUDCpvQcysJkVHT8MdusjQH3K2L69Y2mnVp0N6mvD6SuocNYzEhbObz@lists.infradead.org
X-Gm-Message-State: AOJu0YwSLTtMS6udKq+edGo3zckD0UwFDblX6bCe8m+tLYdWf1xETxTM
	/096iw0RoQqHs8rBeU/tBcJmRSg98U37FmnTMcYqkj8MIEq3JganDACehKjnzwA=
X-Gm-Gg: ASbGncs1kz1uXWjJAFAxIXuujLPoQwLk+z2Ph7POmgJAbg++qnOs3YQ5X4IqCr+fnVZ
	EQceCDrJud5lXrwK+5FZ8Xi4eFS6GcjZ+GKTIFrCOHXv7QOI1B3UpX8pxBnlgrlnI/3TJHrGROw
	Tg08YjZ8xN+Tf8Hgky21nTdVU/vWdT5MweBJl+2O9QcgfsZg1DndW/EusMVeoRb52s7I50TkYiG
	iu9WzID/saSjFD2tEe3t++Wx2sKhNOakR0qYFLRBNxX6MjsOToFHB/7fYa+KLgCvF1mURD/7+Az
	PQ8Wh9B0fT9FHfSGqfpjx9raqqLoQQ==
X-Google-Smtp-Source: AGHT+IGiuhJCb6CE3xcrJekt3qGHV8KtpIud5ATr1ePaT30zfzK6ww+BnPBnVPMzNC6cTFY+JSWjmQ==
X-Received: by 2002:a05:6214:20a2:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e192ca312amr104688286d6.15.1737058735081;
        Thu, 16 Jan 2025 12:18:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4695sm3441426d6.104.2025.01.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:18:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYWKL-00000002y1X-3wBD;
	Thu, 16 Jan 2025 16:18:53 -0400
Date: Thu, 16 Jan 2025 16:18:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250116201853.GE674319@ziepe.ca>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115083340.GL3146852@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115083340.GL3146852@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_121856_288515_9816AF4B 
X-CRM114-Status: GOOD (  11.92  )
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

On Wed, Jan 15, 2025 at 10:33:40AM +0200, Leon Romanovsky wrote:
> > > +	do {
> > > +		phys_addr_t phys;
> > > +		size_t len;
> > > +
> > > +		phys = iommu_iova_to_phys(domain, addr);
> > > +		if (WARN_ON(!phys))
> > > +			continue;
> > 
> > Infinite WARN_ON loop, nice.
> 
> No problem, will change it to WARN_ON_ONCE.

I think the other point is that the addr doesn't increase, so this
loop will lock up.

Possibly just do return? I suppose something is hopelessly corrupted
if we ever hit this..

Jason

