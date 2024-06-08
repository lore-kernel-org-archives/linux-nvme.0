Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C006FC25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Jun 2024 05:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pcj71wA8x92xSZR9sUMBRdx2JgWjxanLFYuVPLfxKgQ=; b=A1vTKc8XqXKeZ8ocKrYpYFUSA0
	zIB7K54yO6W6A0pXQx48+9+eoEGzuuRuDUaCA/ok9IpfoRRxLqobA4WMmqwUm/0cnbisRp8QlQKo3
	PTJPzdftPWGR+4i8PYsF15ECZmMoai2qCtdJii+ADBnvR3oBKWtjCdDUbT1YEWNumNrxJD3eu8O6o
	iBnR+IgkQKSVDATFTNynp7Nq+o3YQIZSw94/KSqrqbJOf4O7XWcIx+Tx68c0TwCoEfwwTL55CZ4+F
	wkczxGM6EVCfjF6zIEot9AT4pi/PQER+q3VteUGRfl3fp0fqk0cP0KZznMxtVYl2w4MtDQSW9TCyG
	JzI81Qnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoLX-0000000GaqP-1beY;
	Sat, 08 Jun 2024 05:10:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoLT-0000000GapW-0moe
	for linux-nvme@lists.infradead.org;
	Sat, 08 Jun 2024 05:10:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F9AF68AFE; Sat,  8 Jun 2024 07:10:23 +0200 (CEST)
Date: Sat, 8 Jun 2024 07:10:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v2
Message-ID: <20240608051022.GA23972@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <ZmMqfj3T9Ft680j6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMqfj3T9Ft680j6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_221027_406455_027402B5 
X-CRM114-Status: GOOD (  13.34  )
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

On Fri, Jun 07, 2024 at 11:42:54AM -0400, Mike Snitzer wrote:
> > For dm-integrity my testing showed that even the baseline fails to create
> > the luks-based dm-crypto with dm-integrity backing for the authentication
> > data.  As the failure is non-fatal I've not addressed it here.
> 
> Setup is complicated. Did you test in terms of cryptsetup's testsuite?

I didn't realize cryptsetup has yet another testsuite..

> Or something else?

I just followed a random guid on the internet on how to set up the
authenticated encryption, wrote a script to do it and used that for
testing.


