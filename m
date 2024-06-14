Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085B7C27C77
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQTwQURKL0VAg6uKeq1Dz3HF07Q3lK9/SsYm9Nop2sY=; b=EIT7gJnmBn4QwW79rioQybOAf/
	LClP7OEqYS27cA1Ym89GVAZnEDv8q9Hehw6DHQMvUNokN45uQbkHkbJI7KOlVaNalg5rCNMkgWRF8
	JhHPRrUum5yizrawWXX9fX+bWo04XFjbK5cvUprFj1UERrMtJhkzYP219+/Wa8Y45grWNpMtM6+Jo
	rGTse15G2sV5We/2UVWVrKlZu9aDY2EpOIG1AAnqdK95tgWsi11BGxljC9Hs2t9mILbBs6x6m7agi
	MA4ui2Wg1HsFbVyaRKTZoeHe6NQqaH8mzH74bPlp57CFlybi13kU6Q3ayYrBtxYeREnCQkO75wXqA
	vwF9dAGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9Ot-00000003Ka1-40dH;
	Fri, 14 Jun 2024 16:03:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9Oq-00000003KXM-2Yun
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:03:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D45068CFE; Fri, 14 Jun 2024 18:03:22 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:03:22 +0200
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
Message-ID: <20240614160322.GA16649@lst.de>
References: <20240613084839.1044015-1-hch@lst.de> <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_090336_820904_5B650FD2 
X-CRM114-Status: GOOD (  17.04  )
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

On Fri, Jun 14, 2024 at 06:33:41AM -0600, Jens Axboe wrote:
> > The series is based on top of my previously sent "convert the SCSI ULDs
> > to the atomic queue limits API v2" API.
> 
> I was going to queue this up, but:
> 
> drivers/scsi/sd.c: In function ‘sd_revalidate_disk’:
> drivers/scsi/sd.c:3658:45: error: ‘lim’ undeclared (first use in this function)
>  3658 |                 sd_config_protection(sdkp, &lim);
>       |                                             ^~~
> drivers/scsi/sd.c:3658:45: note: each undeclared identifier is reported only once for each function it appears in

That sounds like you didn't apply the above mentioned
"convert the SCSI ULDs to the atomic queue limits API v2" series before?


