Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68023C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0RTx3EaQ+M8bxrkBxK7TMUCfx+mnUwVjynNcSZ3MY4=; b=xEnQP77a0GaEMQkcKY9Od4Li/f
	wVteiiA36MEvnwRowyVW0+zcYQp6mbW+VunYYV43kDouOcKun6GP8WdvR4DGPHf5g9wDJNKcL7ozQ
	2vE9gRaUYVT7dibKdQVRPuzuEaq3hgAna3yWtrWqrexdWZQFw0gmDAKjIpcFmR7/58FklXhf+H6g6
	IreNVz4aBOSx2MVfmMsH14No8GyiICEzAZ0vMBin3IcpfWMmLcqPsC0dUUwMrT78AMriRkMxmMBzi
	+64B2gas8wFZCx2DSjPsLVm6omj2QoIPND8rANlACFJaZqq/wp0+3r5qYX8o5yQekYWLFQNpqyr5W
	Wq4l9HZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHF1N-0000000Axrl-2eJg;
	Wed, 12 Jun 2024 03:51:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHF1H-0000000AxoH-2IUr
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 03:51:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 939CE68BEB; Wed, 12 Jun 2024 05:51:22 +0200 (CEST)
Date: Wed, 12 Jun 2024 05:51:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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
	linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 03/11] block: remove the BIP_IP_CHECKSUM flag
Message-ID: <20240612035122.GA25733@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-4-hch@lst.de> <yq1frtl3tmw.fsf@ca-mkp.ca.oracle.com> <20240610115732.GA19790@lst.de> <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com> <20240610122423.GB21513@lst.de> <yq1zfrrz2hj.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1zfrrz2hj.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_205131_770846_599B1949 
X-CRM114-Status: GOOD (  24.20  )
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

On Tue, Jun 11, 2024 at 03:51:27PM -0400, Martin K. Petersen wrote:
> > But how do you even toggle the flag?  There is no no code to do that.
> > And if you already have a special kernel module for that it really
> > should just use a passthrough request to take care of that.
> 
> A passthrough command to the controller?

A passthrough command to the LU that has a mismatching checksum.

> > Note that unlike the NOCHECK flag which I just cleaned up because they
> > were unused, this one actually does get in the way of the architecture
> > of the whole series :( We could add a per-bip csum_type but it would
> > feel really weird.
> 
> Why would it feel weird? That's how it currently works.

Because there's no way to have it set to anything but the per-queue
one.  

> The qualification tool issues a flurry of commands injecting errors at
> various places in the stack to identify that the right entity (block
> layer, controller, storage device) catch a bad checksum, reference tag,
> etc.

How does it do that?  There's no actualy way to make it mismatch.


