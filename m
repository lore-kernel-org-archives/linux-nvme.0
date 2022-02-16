Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C358EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNsvEy8wT2lUFfoMB56xMCh9KDkpTdHdMvFSnssvyKA=; b=LngIy71083AFjtwWVWqkFA570Q
	GJWQ8YL2zyIrHUDFqjepMUDYdF/rWxG0B54Bw4xwSQOz9MXAggTO5cVZ/vlfZ8Oj1Jpj0UdDORNfF
	ovfqdJUEv1Y1JJnTZDCM7XXebwE01GW/LJPSnOpNMvL/qWa7N2RdU4ZIrTkZj+RthYXGacrDCuxlT
	JNj5uEmE2eFU/h0NtQORkAKKRDEpB0vmPDnglalM2frzjuWXRFJ7mbkbIZZI/Q0kuWQ0ZeCv8iXdy
	OQIkmxEmyzCqkuhj7vJP7TGLb2w6sKHSWbNl4k8gYAsvFofWamzGgwvagcmNbl+oFGFJ90rPCJqp3
	jvmsHFwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNoM-007rA2-GL; Wed, 16 Feb 2022 17:09:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKNoI-007r8r-TV
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 17:09:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 31F0068B05; Wed, 16 Feb 2022 18:09:44 +0100 (CET)
Date: Wed, 16 Feb 2022 18:09:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216170943.GB20782@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
 <20220216153226.cgwaigrhjdjeuqo7@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216153226.cgwaigrhjdjeuqo7@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_090947_121250_E7B76F27 
X-CRM114-Status: GOOD (  19.44  )
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

On Wed, Feb 16, 2022 at 04:32:26PM +0100, Markus Blöchl wrote:
> On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> > For surprise removals that have already marked the disk dead, there is
> > no point in calling fsync_bdev as all I/O will fail anyway, so skip it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/genhd.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 626c8406f21a6..f68bdfe4f883b 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
> >  	blk_drop_partitions(disk);
> 
> blk_drop_partitions() also invokes fsync_bdev() via delete_partition().
> So why treat them differently?

Yeah. I guess we should just skip this patch for now.

