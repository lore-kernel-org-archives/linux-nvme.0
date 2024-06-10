Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8551C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SumyHOClsajb/KiNsllT6TpU+/ViBRxle1uamwgAKYQ=; b=MTz8F+2dh0v4mFoj4soXRb2l3p
	sIn2Poz7x6op5BxlUE6xQL5fA44JviQEKY2BFKdjoijVxPEv488HK4kbRwYsmXwmrWRj9azYUPKTP
	N2GHcqgXWA37fOYkJLoCYtnudhNvQGfJgXUUAMqTE38lVneuAMX4xf3jaOR1ScKBJ1MrPCzsHxifR
	5HEzzr97bmToF7jFMyag9YwTAp5pkee1+yHTwtrtHXxuDWQWxsM80aHxSIt4qwgpNsvkKVpz5T6pN
	J1guGbT6Eqr4RZhGnyJdBXelxAVEDUEItkBUzISy0nKaGLjdIwTKpO1QeYY/HWB9N9y+k9mPDrXNB
	S4Ra4Z0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdYk-00000004sBV-0uHh;
	Mon, 10 Jun 2024 11:51:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdYg-00000004sAl-3CuI
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 11:51:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AD8067373; Mon, 10 Jun 2024 13:51:18 +0200 (CEST)
Date: Mon, 10 Jun 2024 13:51:18 +0200
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
Subject: Re: [PATCH 02/11] block: remove the unused BIP_{CTRL,DISK}_NOCHECK
 flags
Message-ID: <20240610115118.GA19227@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-3-hch@lst.de> <yq1le3d3ua9.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1le3d3ua9.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_045131_007584_1A500DC4 
X-CRM114-Status: GOOD (  17.84  )
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

On Mon, Jun 10, 2024 at 07:48:52AM -0400, Martin K. Petersen wrote:
> Fundamentally, the biggest problem we had with the original
> implementation was that the "integrity profile" was static on a per
> controller+device basis. The purpose of 1.1 was to make sure that how to
> handle integrity metadata was a per-I/O decision with what to check and
> how to do it driven by whichever entity attached the PI. As opposed to
> being inferred by controllers and targets (through INQUIRY snooping,
> etc.).
> 
> We can add the flags back as part of the io_uring series but it does
> seem like unnecessary churn to remove things in one release only to add
> them back in the next (I'm assuming passthrough will be in 6.12).

I can just keep the flags in, they aren't really in the way of anything
else here.  That being said, if you want opt-in aren't they the wrong
polarity anyway?


