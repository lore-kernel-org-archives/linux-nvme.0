Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E09C27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 04:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2yL61iK99KIaopVAcsr21t8kF7zjSPEA917W8Rogxc=; b=MfBjjyCGzaf2r9UTcYNHz2y0Uo
	1KehQzyhnsKRCavuXL50v77F9/cSjxngsAYlSovgijsYW9qWU9thUAiwj65MX+nu2GvD5l8BnEmve
	vNHs+9XdAv/Ky/yjX7Fe0IY/3m7YIiB4INZWgjPB1/X/iZ3qV8B/Th3VU3dJf6y7Bx9aK8geK1Yx9
	SwZD57tpcQs/86McWG7NRkiMS7fShXiaHOOG/PNOYR2GXio2Dz0QIAxZDguNSqW+QRXplnBSHu8/h
	25vuEqmBOwJv2SFn8xMuFCIw6D4DSJ8mMT5lRUCmaXoUJ7r9uMu9Rk/E48NkHBwpol3aY1X4aJSBx
	OXSKgM1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF56F-00000008M8x-1ljb;
	Thu, 06 Jun 2024 04:51:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF56C-00000008M8G-3kAi
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 04:51:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78EBA68CFE; Thu,  6 Jun 2024 06:51:36 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:51:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [PATCH 12/12] block: move integrity information into
 queue_limits
Message-ID: <20240606045136.GD8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-13-hch@lst.de> <3e49207a-1efc-4fe6-99c2-8cdd9c24664c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e49207a-1efc-4fe6-99c2-8cdd9c24664c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_215141_397751_B471A31C 
X-CRM114-Status: GOOD (  13.44  )
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

On Wed, Jun 05, 2024 at 10:56:20AM -0600, Bart Van Assche wrote:
> On 6/5/24 00:28, Christoph Hellwig wrote:
>>   	if (!dix && scsi_host_dix_capable(sdp->host, 0)) {
>> -		dif = 0; dix = 1;
>> +		dif = 0;
>> +		dix = 1;
>>   	}
>
> Although the above change looks fine to me, it is unrelated to the
> other changes in this patch?

Yes.  And earlier version touched this more extensible and this is what
is left of that.


