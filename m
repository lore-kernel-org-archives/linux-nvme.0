Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD5FC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q33FZxlaS+vjnI68ODkHX0jOlECgGNUWLeZagFwgwtA=; b=Ia/iJLKwzvYN+W0peSdoBwJhCm
	/h+a/ZXB7q7ZaMSx/V/zBAYZPV681DvCMuBoGrHqEqR8625iB/6PDYoIrVxKIhkg1koMOdUA9BvrJ
	pdAlQcb6vjzd5NrLvTlxOZqLxVEG3BhNhKaJn3RtyefW4PlsQ3WfZYfMnrn8rVWtDyvkYwvWqvMi6
	rXGXKhOrrNzcD4X3NPasVrVurPxMvzQvorXTDwPEEa7e2/t+K6uoYhswtmH0kOQj+iIoiSP9JFa5u
	ycsGWKdbQMtRWaSnVnM1sAnlyiUySId/wz8IM6xadpWesrxIrDpYkWj+Jowm/ITcrhd8rq8Kw3xZB
	uwEUrBxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphme-0000000CT25-250A;
	Thu, 28 Mar 2024 04:54:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphmb-0000000CT0m-291d
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:54:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B489968B05; Thu, 28 Mar 2024 05:54:30 +0100 (CET)
Date: Thu, 28 Mar 2024 05:54:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 30/30] block: Do not special-case plugging of zone
 write operations
Message-ID: <20240328045430.GN14113@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-31-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-31-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_215433_713167_71D00E42 
X-CRM114-Status: GOOD (  15.19  )
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

On Thu, Mar 28, 2024 at 09:44:09AM +0900, Damien Le Moal wrote:
> With the block layer zone write plugging being automatically done for
> any write operation to a zone of a zoned block device, a regular request
> plugging handled through current->plug can only ever see at most a
> single write request per zone. In such case, any potential reordering
> of the plugged requests will be harmless. We can thus remove the special
> casing for write operations to zones and have these requests plugged as
> well. This allows removing the function blk_mq_plug and instead directly
> using current->plug where needed.

This looks good in general:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But IIRC we recently had a report that plus reorder I/Os, which would
be grave for the extent layout if we haven't fixed that yet, so we
should probably look into it first.


