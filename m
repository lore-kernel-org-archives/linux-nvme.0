Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2FCC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DpylNVZ4+z4bSWGqnrmzH9JICKXck/uG/9AjnghtdeM=; b=QWeMVyKKOvgrtVMkcLSF/pNvr/
	VCI2bYWeQ6hjlo3ULIERbdkPdJxmK2CRhalYy6iWINnm5+apJhg/aZnBziaoVja4KBeHnoXapLaUm
	Pn337JjJsdKBsVVxLyB7UXIhuMdYi1L338Mk/z18H57XyVTw8e5i1IB0xO3v/wnViNXDad8ZSApse
	vIKMGz2PVlJVsVfmuIeZTn4hnXy71HVnCbNKsxmUg70nGiurSjNgI+dV5ZOK2AkrjtAqW/pZfIWEw
	3Ep/iS3lHDcvBp49h60+XV/3BTQRqfyNVMPlM27dAleEv/Xk0QSLNT5LH6pah436jb4i13ddTFBq7
	+isXI8iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCdSR-00AfKA-Mb; Wed, 26 Jan 2022 08:15:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCdSP-00AfIt-5m
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 08:15:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2D9C368AFE; Wed, 26 Jan 2022 09:15:05 +0100 (CET)
Date: Wed, 26 Jan 2022 09:15:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <20220126081504.GB23154@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-10-ming.lei@redhat.com>
 <20220124131516.GH27269@lst.de> <Ye80kxTBojm6GN8k@T590>
 <20220125072739.GA27777@lst.de> <Ye+605vZEyx3ofi2@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye+605vZEyx3ofi2@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_001509_405224_6EBD6FB1 
X-CRM114-Status: GOOD (  20.31  )
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

On Tue, Jan 25, 2022 at 04:54:43PM +0800, Ming Lei wrote:
> > So what is the advantage of trying to remove the freeze from where
> > it belongs (common unregister code) while keeping it where it is a bandaid
> > (driver specific unregister code)?
> 
> freeze in common unregister code is actually not good, because it provide
> nothing for bio based driver, so we can't move blk-cgroup shutdown into
> del_gendisk. Also we can't move elevator shutdown to del_gendisk for
> similar reason.
> 
> Secondly freeze is pretty slow in percpu mode, so why slow down removing every
> disk just for scsi's bandaid?

I'd frame this differently:

 - del_gendisk is the right place to freeze the queue, as that is where the
   gendisk is unregistered and all fs I/O needs to stop.  If we don't get
   all aspects right we need to fix.  As mentioned I'm already looking into
   keeping a reference for the bio life time for bio based drivers.
 - SCSI is the only driver that ever submits passthrough I/O without the
   gendisk.  So doing an additional freeze during request_queue teardown
   is only needed for SCSI and we can eventually remove that for everyone
   else.  And most of your series already does really good work towards that
   goal!

> 
> 
> Thanks,
> Ming
---end quoted text---

