Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC503C0015E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1m8UlGJxpQO1LTP10K08q9bvqhzmlZ7vs1OtXxz6tM=; b=EDd9TrokGy5ubBpGOmXcPpx+kw
	s/WxL8/ak3Fbbm/HR6dHOAspe7XN7AspQAFvkoI86VLl/ecie3twi8rWuNy6bss2vveM7VGyx2F16
	9ckn5gk6lPP1edNMzzkmArW8+w87cU+nIYe28kHHv1ud7AKqoePUdEr7VUyHwAbtzaUYKEydsxpa9
	m0Co2evy0Rl/LCmnF7DuTpw3P5I4XK76uGcLaAp9OCRv7AASjiw/wsQYc9AangQcOMc8tXnbSE74T
	Ezj1shIRcuRrN+sSmJkM74hXvKPECXujJseQWdLEolGMsbKESqjX6rdYC5lXCZALzs0APvym9Nhrw
	JdBV6U3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOHS-001euV-22;
	Thu, 06 Jul 2023 12:40:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOHQ-001etu-2Z
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 12:40:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A47467373; Thu,  6 Jul 2023 14:40:14 +0200 (CEST)
Date: Thu, 6 Jul 2023 14:40:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 2/5] nvme: zns: Set zone limits before revalidating
 zones
Message-ID: <20230706124013.GB12545@lst.de>
References: <20230630083935.433334-1-dlemoal@kernel.org> <20230630083935.433334-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630083935.433334-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_054016_982255_37BB50ED 
X-CRM114-Status: GOOD (  12.58  )
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

On Fri, Jun 30, 2023 at 05:39:32PM +0900, Damien Le Moal wrote:
> In nvme_revalidate_zones(), execute blk_queue_chunk_sectors() and
> blk_queue_max_zone_append_sectors() to respectively set a ZNS namespace
> zone size and maximum zone append sector limit before executing
> blk_revalidate_disk_zones(). This is to allow the block layer zone
> reavlidation to check these device characteristics prior to checking all
> zones of the device.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


