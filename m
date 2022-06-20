Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB0FC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jPWddTqZcn7jiIlB3p15JHPKT5
	cU1MRplD+EmUgpAw8eCqyozvyfXwjcHL1eeg8DP9PWbgPHukl5Mrkuth96drsYsNNqwlpU2iW4HU7
	nAka5Bwtye+aHTUVoKUrKTQUM09g0nTukXkAxIGd03srjWRwOqb2mNjzN8GMwz3U9qE1Yeczqb8K/
	+oA9xYCVF1M1hyTmA4rredckEFGfDOXLdcv7Xz1uf+biIbqk6NBLyF0Bchsxmq9CMpGT5B7Bhg3LJ
	KPJSwyQ23iD8dWzMnbZlZZXwccOUmzJrNfjg8+FAjVEhFmHvG5UaBfniGqY4cgWinVBTs4tIt6415
	cXdGdufQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ASP-00GNQg-L2; Mon, 20 Jun 2022 06:00:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ASN-00GNPd-5W
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:00:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53BA468BEB; Mon, 20 Jun 2022 08:00:12 +0200 (CEST)
Date: Mon, 20 Jun 2022 08:00:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
	hch@lst.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
	hare@suse.de, satishkh@cisco.com, sebaddel@cisco.com,
	kartilak@cisco.com, linux-rdma@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
Message-ID: <20220620060011.GD10192@lst.de>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com> <1655463320-241202-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655463320-241202-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_230015_414657_3CA2AEB1 
X-CRM114-Status: UNSURE (   8.35  )
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

