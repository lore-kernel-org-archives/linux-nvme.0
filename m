Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4CC27C55
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=17yqP/O+ErUPtlSwD4B+SG4dPNOyakdf3fQo1bOILbQ=; b=JRYHw2EbX1usKir9gh/uRF9mxJ
	y3vJJLGDcW95DaOb9AWPx+x4h02yT2WrfbZYyozKYhrv3iUv69Dc0qj3dqBxyZQanBMYoqH7ru9ut
	djn6oGo7LI8NEQiu6GV9IHZ3pDsc6ndpOo/5byc9MBNbYiMkG1JS0oJMqxHWNbJwsgUqoDSrqwnoO
	PXY3NvpabFfBrAy1U/GI5nPXrWXsNtn3itkmXyKcRyTarBhLCVRtCUwfXwRwlSafBZsklYZmxBS7s
	++cwQZS1klJEwZC1R610ejHX5ToZ9aW2OUvliYowg37ZldwN4uQBcnYdzZaNrzetiSkCV1dcGab+i
	w84GHQiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFT9O-0000000CihG-2Xeq;
	Fri, 07 Jun 2024 06:32:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFT9H-0000000Cigt-0HD9
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 06:32:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D57E468B05; Fri,  7 Jun 2024 08:32:21 +0200 (CEST)
Date: Fri, 7 Jun 2024 08:32:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH 11/11] block: move integrity information into
 queue_limits
Message-ID: <20240607063221.GB5387@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-12-hch@lst.de> <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_233227_272983_CCA7928D 
X-CRM114-Status: UNSURE (   8.19  )
X-CRM114-Notice: Please train this message.
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

I just found a fullquota.  If you have anthing to say please trim your
reply so that it can be found.


