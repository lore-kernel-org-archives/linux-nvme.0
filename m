Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E9C27C6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWRibSy8xdXC9HfsE/UEHivuH/I0YRtKXSMWYNbHNmM=; b=ezgxGDa09YIz/ugwSU2Okj1Wwx
	CUj48A9ULKDzMYfNzXB3Rj8h/pMVJwaelG31QwS6YJpby/VTL1402eAxwNNULeTK+0/xzyNv7zs+o
	n7AAnlcnnQUxfGlIxqtWm2ZbBnEVfu5rbwsrD4ioccY7mb9QaQ7cE+M+0OOnHzITXyhGYHKT+jSJ0
	tiVgo1BmlWEHIUEz8khz6RxZS2rpund1XR4RUUOp9JLtFAydjvyDjqusyA55toUrb5IiURU4ShXMO
	P3+RwhGlTKE2GvIDO4jHNjRPgPSmGQXFYqTUNHMVxnN70R07vlrRG3R2SC/UgLxdJI/VC+3IP5ddp
	08jWFldw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHd7h-0000000FBNx-3O2e;
	Thu, 13 Jun 2024 05:35:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHd7d-0000000FBLt-2R5G
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 05:35:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 680D568AFE; Thu, 13 Jun 2024 07:35:29 +0200 (CEST)
Date: Thu, 13 Jun 2024 07:35:29 +0200
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
Message-ID: <20240613053528.GA17839@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-4-hch@lst.de> <yq1frtl3tmw.fsf@ca-mkp.ca.oracle.com> <20240610115732.GA19790@lst.de> <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com> <20240610122423.GB21513@lst.de> <yq1zfrrz2hj.fsf@ca-mkp.ca.oracle.com> <20240612035122.GA25733@lst.de> <yq1tthyw1jr.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tthyw1jr.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_223541_787623_84890B74 
X-CRM114-Status: GOOD (  20.41  )
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

On Wed, Jun 12, 2024 at 01:27:47PM -0400, Martin K. Petersen wrote:
> >> > Note that unlike the NOCHECK flag which I just cleaned up because they
> >> > were unused, this one actually does get in the way of the architecture
> >> > of the whole series :( We could add a per-bip csum_type but it would
> >> > feel really weird.
> >> 
> >> Why would it feel weird? That's how it currently works.
> >
> > Because there's no way to have it set to anything but the per-queue
> > one.
> 
> That's what the io_uring passthrough changes enable.

The checksum type?  How is that compatible with nvme?

Anyway, I'll just leave this flag in for the resend, but if we can't
come up with a coherent user for it in a merge cycle or two (which
I very much doubt) I'll send another patch to remove it.


