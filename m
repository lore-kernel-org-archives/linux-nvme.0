Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7DCC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0z5kPoOgxIzQKErA7jhEXu0vn7TbHEO1MNPlSSxfw8=; b=B/C20vcIjIYAG7tYo6tmAY6J3a
	bRGc6Yo+ErVIlxIo6tQD5avxGhCq3HFRdctFrNvcnaSDOpDZZ8u/p76pg3EEe7TnebiOZJ1+7fPCz
	bp9JzWiR4aX1LplB5EqfWDxaLF1NrlyMAmxWepRU8G+PKkmXVAAQfqxInOKJShEfwhcmgb7CVxitM
	Xt5J7SvJ67iQDPG2JbuNWjCJvCXivlUFsbSziukdEMMDQxhQmDyLIHJAdMxPzL34ans7Vor96ZF4s
	7DFWi4cSTXVOGEZBaGdiPbmWYerwYsk9ndNEFoDRb5F9WbyjHlhrFUIBm/B8voNatxNrfWGolq16q
	5AW05fmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCPa-00FcOf-2v;
	Tue, 23 Jan 2024 08:45:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCPY-00FcO1-1J
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:45:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DCCA68C4E; Tue, 23 Jan 2024 09:45:33 +0100 (CET)
Date: Tue, 23 Jan 2024 09:45:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 06/15] nvme: remove the hack to not update the discard
 limits in nvme_config_discard
Message-ID: <20240123084532.GC29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-7-hch@lst.de> <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_004536_586207_8414F5D9 
X-CRM114-Status: GOOD (  12.45  )
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

On Tue, Jan 23, 2024 at 02:12:37PM +0900, Damien Le Moal wrote:
> >  	blk_queue_max_discard_sectors(queue, max_discard_sectors);
> 
> This function references max_user_discard_sectors but that access is done
> without holding the queue limits mutex. Is that safe ?

No.  But fixing nvme will be done in a follow series.

