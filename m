Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC00AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wAELwHnCVtSVQIPGjIKF/3/QbeA5MWbXq9/MX1DPpXg=; b=jtwEiVjTktJ4ki+/50a2eFKNoI
	f3xx/CZtXYTYly7RRhCV4PBFbjXaMCbT8rXv6qRI/OZey3Bx+nR86mij/RyZBdkOagyVEWqXm2NYO
	QJciW4+lqKUcKBV7jDxztC0aGlstihFvMe3SIesKI60ZcPpt5XT9KXsFXuV+4mXJXal6G9btUW3S5
	iRWm6+pnQ6zYfzaDwBA+t5vUjxgdEf5hEcQOBowx431UbDQj2ld63hp+Gzlg3H4AGlq8A7nXZp04V
	PEj0IRVdupCMGEqlPPQnlk8UGWqqXVPMwQJx1H8uRFTkF36N6ysE3OlZw1/9FM0c3xOHX9zyxlQV3
	1y1lJD8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU9I5-009kwJ-7O; Tue, 15 Mar 2022 15:40:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU9I2-009kuk-3g
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:40:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4814268AA6; Tue, 15 Mar 2022 16:40:43 +0100 (CET)
Date: Tue, 15 Mar 2022 16:40:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: warn about shared namespaces without
 CONFIG_NVME_MULTIPATH
Message-ID: <20220315154043.GA15386@lst.de>
References: <20220315145141.2586124-1-hch@lst.de>
 <YjCvfMplVsxKk3yd@C02CK6Q3MD6M>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjCvfMplVsxKk3yd@C02CK6Q3MD6M>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_084050_355971_BDB653D4 
X-CRM114-Status: GOOD (  18.09  )
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

On Tue, Mar 15, 2022 at 09:23:40AM -0600, Keith Busch wrote:
> On Tue, Mar 15, 2022 at 03:51:41PM +0100, Christoph Hellwig wrote:
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 8fb89d0624fc5..e733c48de2e90 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2092,6 +2092,7 @@ static void loop_remove(struct loop_device *lo)
> >  	del_gendisk(lo->lo_disk);
> >  	blk_cleanup_disk(lo->lo_disk);
> >  	blk_mq_free_tag_set(&lo->tag_set);
> > +
> >  	mutex_lock(&loop_ctl_mutex);
> >  	idr_remove(&loop_index_idr, lo->lo_number);
> >  	mutex_unlock(&loop_ctl_mutex);
> 
> This unrelated change sneaked into your patch. :)

Ooops.

> The recent release pattern suggests 5.20 will be the last of the 5.x tags
> before seeing 6.0, but my understanding is that's at the discretion of Chief
> Penguin. Unless you know already, perhaps warning with 5.21 is more clear that
> removing this capability happens after 3 more releases.

Sounds good to me - we are not in a crazy urge right now, but we
need to settle this eventually.

