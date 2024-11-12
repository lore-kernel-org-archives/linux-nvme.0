Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E48D41D50
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Zzjxt4JJW+x/rSc8WXikigcApJ
	oRX1ScyNKCJgBUWWyI1BLpLMMVNrx+SE3UOP0eWa5U95nKVvgNDS1Vj2F/pKGm0pp501PY0rwOlEM
	LQD12DHWOVh7LYTwagO4ftrfBp/VZNPq/Cw6EE6RXQ+LycjK9YNCLoCsHo/BqumESvbq7gQw2hYNb
	vAAPnUNKmv/DJpxAhVNnHcAvcGZvoP5+dTXj3QZcUe6rrYXn7D7blxrqFO2cT1kUVPacHS9bsn5FM
	K2kntxwQLgxOme2mofclDIEGqMhJE1/EtKIYWw+pacd3LQa5dRR3zfVWibZKCDZDymxByPGbT4XXC
	c9z0zs9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAipT-00000002BdT-1N1H;
	Tue, 12 Nov 2024 04:48:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAipR-00000002BcN-0KIE
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 04:48:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 766C168D09; Tue, 12 Nov 2024 05:48:34 +0100 (CET)
Date: Tue, 12 Nov 2024 05:48:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 5/6] virtio: blk/scsi: replace
 blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
Message-ID: <20241112044834.GC8883@lst.de>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org> <20241111-refactor-blk-affinity-helpers-v2-5-f360ddad231a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-5-f360ddad231a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_204837_265272_BEDA7313 
X-CRM114-Status: GOOD (  10.84  )
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


