Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IteYUVGxmHbxaIe4fUmh/9gyui1EAyQ58DUi1hSrTA=; b=KUI6Qtj0KnR5QG0ouAMW0E3XwD
	eZoIT3LfndIiDpdsFv08pVCqt1Of0Qc8X4YecdH+BjrqcA0Xrz36ZTLWlWkmpSyipYUtFUCGubB0W
	rh8yppuBDtQM2c499PuExLkoNxD+RpO7GylIsk6J3FZL6E9G4iEzUkIXF7JYgX2BY3Ebe3OGpoEYo
	4Bx+8+SpB3ATGcL4KgaMmRsQAdARbTXteFJNJpwRduOzVMQRsHFbzKgcPJQLGVV14R1YPZnwRxIHx
	t9PnsczUNlKGKFlBI0L4lGbSf+Ll5/5VzUHDzX+d/Sr23WAASzbE/UTq8r7Hg3WBYd4cKOd4pjxY8
	w/gZJT2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3AQn-00GMja-BF; Mon, 20 Jun 2022 05:58:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3AQk-00GMiV-NO
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 05:58:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EF536732D; Mon, 20 Jun 2022 07:58:28 +0200 (CEST)
Date: Mon, 20 Jun 2022 07:58:28 +0200
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
Subject: Re: [PATCH 1/5] scsi: core: Remove reserved request time-out
 handling
Message-ID: <20220620055828.GA10192@lst.de>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com> <1655463320-241202-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655463320-241202-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_225834_942014_20B5DBC5 
X-CRM114-Status: GOOD (  11.65  )
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

On Fri, Jun 17, 2022 at 06:55:16PM +0800, John Garry wrote:
> The SCSI code does not currently support reserved commands. As such,
> requests which time-out would never be reserved, and scsi_timeout()
> 'reserved' arg should never be set.
> 
> Remove handling for reserved requests and drop wrapper scsi_timeout() as
> it now just calls scsi_times_out() always.

Please rename scsi_times_out to scsi_timeout so it still matches the
method name.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

