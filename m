Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75940C77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bp1HJPa9IF3GyPm6Q1+fiFXJbf
	oWBbUT5CGTSIy4MgQVxb9Ug4OCwApKT7tYKjM9nZNiPgTk0RpEkTRj2SU1yOPlOq5SOFIIiyTnkwa
	oRdCu3RtGGCjs/gpvyAcu94s8JXLnGCD4tENZi/mkPUb2pf1lqhdW5LRZkNmghW9TzfkcDOX6PCcN
	6bpbXC39VdrwrAo1GA6/59HmX2H55gxns0Lwc/Kb6UN4VI2ol/FDoee8lSkvUjOW0UhLVTGu9Ff58
	Q7EUn6AmCCtTUotvVQYcCHnuR1NuBTzZ9arHZslySvZXeiH3M04xl9OWGpMvjHuFpbQkQb/23YvrW
	yEmLdnsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q275W-00G76L-2g;
	Thu, 25 May 2023 09:16:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q275U-00G752-0j
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 09:16:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BB8C68B05; Thu, 25 May 2023 11:16:45 +0200 (CEST)
Date: Thu, 25 May 2023 11:16:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 3/3] nvme: improve handling of long keep alives
Message-ID: <20230525091645.GC26725@lst.de>
References: <20230524232218.1584605-1-ushankar@purestorage.com> <20230524232218.1584605-4-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524232218.1584605-4-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_021648_409052_880F199F 
X-CRM114-Status: UNSURE (   9.65  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

