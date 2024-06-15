Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B81BC27C4F
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Jun 2024 05:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qwWFBj3wJ0OcmwN3UF+qFpvVwNp+5imC209zVMCcq8=; b=a7xlASyAqNgteeAmOVdN2U1y1G
	Zzteng9iLbGYxRpgc23OffDcE5PCO9XVIQaj9Vy5diyaeuDvLaP3+gV80pwzG096dtCOxDHg182tl
	azFZrBxkjSHPnJPioYpuGEjgiqNTF5if7mzGsVArLk6HT6wktR1ZZjKu0ep/36oam66lsUs+dUUp5
	CRGmQkDBZAxzAR4gEk+9sW66s1+uy2aO0dN4EzT0szPBJJ/jSywOy9PfIv9VKH/NOqer1gOyqrnLl
	pt6vTI9hI5qfIQho1Y+MTRxXwcUWG/rruZ7uajpWUcSEq/Sm6X1DSjfxUSuWO/E1EXDGNiLaSVs5l
	5/oipTMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sILXh-00000004ge5-0Vlz;
	Sat, 15 Jun 2024 05:01:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sILXd-00000004gdW-3dKd
	for linux-nvme@lists.infradead.org;
	Sat, 15 Jun 2024 05:01:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5DAE68D07; Sat, 15 Jun 2024 07:01:21 +0200 (CEST)
Date: Sat, 15 Jun 2024 07:01:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v3
Message-ID: <20240615050120.GA28819@lst.de>
References: <20240613084839.1044015-1-hch@lst.de> <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk> <20240614160322.GA16649@lst.de> <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk> <20240614160708.GA17171@lst.de> <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk> <2fb3fc18-64fb-4a12-9771-3685111fd19f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb3fc18-64fb-4a12-9771-3685111fd19f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_220130_165953_6480C01E 
X-CRM114-Status: GOOD (  10.12  )
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

On Fri, Jun 14, 2024 at 10:23:33AM -0600, Jens Axboe wrote:
> Done, both series are in for-6.11/block-limits. It's pulled into the main
> block branch as well, but SCSI can pull it too as needed.

Thanks.  Btw, both this and the md branch now have versions of the
raid0 and raid1 use after free on failed ->run fixes.  Maybe drop them
from for-6.11/block-limits given that they've been picked up by the
md branch you've pulled.  They might even be 6.10 candidates given
that they can easily be triggered (although only by root).


