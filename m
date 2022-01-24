Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A934C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Py/6hsJC+imvSVCfXl/4sc0rc23XQ3G/ejBfkYEVx/Y=; b=sEvvoH0/qBm4jfqoraI4KvcPqB
	xN9FuHzeBjMPoTT8V6qwuO7MMsI5Eagu/UZaUxMgfZ6L5sMykj62axvHiLAzpOLfKiz9RBY+vedkL
	XpTKuLYReA8auko0GjZlB9ybUWf2JwZrf6xnt/jq2TgtmEdKc/yBce6lEnemHEjnHOYM67dIuN3tU
	mnc++QK2GDuxd+klVCnzFEqwj8TRx8R6r4idSiUBJF7DnJL02ffq+nVKLiZ/YdoWJgpE5qnq6LyKD
	T6bGxXKD+38ttvSZkNvAEGPG84hmEPdtLXFaILiT5LQOysNkrbXmkes2PeHi0hUwQtQZ+lYFFGook
	gXkXJuPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBz2n-003NSE-N0; Mon, 24 Jan 2022 13:06:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBz2k-003NR2-G7
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:06:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4116668C4E; Mon, 24 Jan 2022 14:05:55 +0100 (CET)
Date: Mon, 24 Jan 2022 14:05:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <20220124130555.GD27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_050558_734831_97096ABF 
X-CRM114-Status: GOOD (  15.48  )
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

On Sat, Jan 22, 2022 at 07:10:46PM +0800, Ming Lei wrote:
> Passthrough request from userspace has one active block_device/disk
> associated, so they can be accounted via rq->q->disk. For other
> passthrough request, there may not be disk/block_device for the queue,
> since either the queue has not a disk or the disk may be deleted
> already.
> 
> Add flag of BLK_MQ_REQ_USER_IO for only accounting passthrough request
> from userspace.

Please explain why you want to change this.

Also this is missing I/O from /dev/sg, CDROM CDDA BPC reading, the tape
drivers and bsg-lib.

