Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153E3ECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+QA5T9uhr+3UngnXvgJZ7LqxUFH6JjtfnA5h6QnONg=; b=B/5wgQOrasG57cNiL/CmT+WzSF
	X3+2NTDkjZNJPP6IZ3evPeYMC2Wr+tDuSNMAg9xZIEuVj/wR4+FoWXlua9SVS5HI35EkXyWaIFSvO
	mEIhlAPsqsJcsYG+GclRAa9mjYNWkfL8X65XEPw/GYQNZ+N/YWe33vWoIhtMgNClUEtb9YFYTvwLk
	kbyOX5tLHksAxTwKcdGBPxMTvdgqBkNsw1AJ2M8GZCjb0tVL2ilh+m6P88aICRuYkosmtrTvaxKyq
	pmNKFEGTQy/qABmSVrdEA+4KzzusGAlUba2jxJ2dIwDs7PKqzJH+4p9uz7sYJDhd05mpL75bjlFT7
	Xy10VxDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opApA-000JEZ-H8; Sun, 30 Oct 2022 16:06:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opAp8-000JCI-DN
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 16:06:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79AD768AA6; Sun, 30 Oct 2022 17:06:03 +0100 (CET)
Date: Sun, 30 Oct 2022 17:06:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
	leon@kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	smalin@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
	borisp@nvidia.com, aurelien.aptel@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v7 03/23] net/tls: export get_netdev_for_sock
Message-ID: <20221030160603.GA10248@lst.de>
References: <20221025135958.6242-1-aaptel@nvidia.com> <20221025135958.6242-4-aaptel@nvidia.com> <20221025161258.GC26372@lst.de> <253fsfazij7.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253fsfazij7.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_090610_613043_17B92FCC 
X-CRM114-Status: GOOD (  12.13  )
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

On Wed, Oct 26, 2022 at 06:55:24PM +0300, Aurelien Aptel wrote:
> Hi Christoph,
> 
> Christoph Hellwig <hch@lst.de> writes:
> > Any reason to not just fold netdev_sk_get_lowest_dev into
> > get_netdev_for_sock?
> 
> Thanks, we will use this.
> Could I add you as Suggested-by?

Sure.

