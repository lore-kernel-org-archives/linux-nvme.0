Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567BAC27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grDoljKtR10QIPkHQXK/cTmG3Nh5jebn9RGKdqp9avg=; b=DvQ7CGzItgUYuCnGR0DDSi3F1/
	H8CZIl+eMBlxKBT0gqNWWq7Jdhi3XFDwWOFw8AggXhxTc4l+dAr3uXqy2GTEAJJlAIeblyr8k0lPd
	XIhgIxvD+C5xVtfPorgpdM3gQy/VyJx6z7231IUk8ATr3ns2TUqVJm9wHRNG7ujMZjonZ95/BSsps
	GNMlAhYd6+VFfypmNWDyZZo3zsAHODxsPLg/Xy0rTkQ16WQ1mjC7lwpAU/lOfGEhLo6mgsj6ze66I
	X9mvuHq+1yQVrFznsfsgqNeWaeQqqwEnvzQAeddiBn0hIA+1CZnwSBjU2AhCkHJSPXBvUTU44em/1
	S1ZuNzdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9SP-00000003LAr-2rqh;
	Fri, 14 Jun 2024 16:07:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9SL-00000003LAV-1QdK
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:07:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF31B68CFE; Fri, 14 Jun 2024 18:07:08 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:07:08 +0200
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
Message-ID: <20240614160708.GA17171@lst.de>
References: <20240613084839.1044015-1-hch@lst.de> <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk> <20240614160322.GA16649@lst.de> <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_090713_557965_23B8F0F4 
X-CRM114-Status: GOOD (  11.77  )
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

On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
> > That sounds like you didn't apply the above mentioned
> > "convert the SCSI ULDs to the atomic queue limits API v2" series before?
> 
> That might indeed explain it... Surprising it applied without.

Also as mentioned a couple weeks ago and again earlier this week,
can we please have a shared branch for the SCSI tree to pull in for
the limits conversions (including the flags series I need to resend
next week) so that Martin can pull it in?


