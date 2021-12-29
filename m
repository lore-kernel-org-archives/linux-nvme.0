Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8223EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVgOo439Gc3X8a2gKn0PZ4FRg4y65shHsljCNVxJRe4=; b=TlVO6EU9wd5Hibdh8JJ3GfQ25Q
	XCz7N1xsB5oCki/ZjcD2xIp3k1PabRBn/HPQfbyFdyrvCG3BTzRTR4388TvhBrv8ns/1S8E/r2dV7
	9HOm/m8LJ9tD0U1jbcY5ufy8BTvabrGuuXbjheJAH9JpiK6QyBgeejiuCBGZ6JnnVUQ6ETOyDg272
	FBFJJRh4ROTWzowEPZ7pyeza0i22bApivCLyPps3Cjm/Sh/E0eCVdQ5T8D32+v5Wk9rAPzwi9Sxzl
	gkD41Nuee+w6f8HHUx9Xli0O4wvUGc0rbLgjM4n4udDTtIWssYQkKXHHZPt1V7PlBXJFgYEKLkNcI
	rO+Bvbjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2g36-003QOw-7r; Wed, 29 Dec 2021 20:59:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2g33-003QOY-7C
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 20:59:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9225D614D9;
 Wed, 29 Dec 2021 20:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E1C36AE9;
 Wed, 29 Dec 2021 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640811588;
 bh=NAqyhgw99dAwFdyQP9icowfMzXhwfK1rXJgGi/VcBC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dx+PRw3oJdRxSinCLrl5tEkpWAT9MVuSuSQvv/2sNivxh0putoKe03auS0T5Rt2LE
 M88FUYwAJcwKHNBaiBycj5wfivzV+3vkqtu9+Hyk+FajgwPPe+NZH1ipuE2IU6KNlv
 jKylh6HuMe9dYHG3on8nIdWVFKMlpJxRWM8oCsDn9vtjVDveSpCz1THSSkbgmKQW7u
 FgU/ZtvOuhnqX1tIHZWqkfFaGh1BNHO7z4ni6zfaw6T7NdqvRr/C1xv3aNxSRmCC60
 zgiG7ZkckZvRMRszbTyxuDS6sA6OsukN8GsnetrIjLqjVcYL/iryX8NxkJ35YzhWHD
 F1MjhY6uV5v4A==
Date: Wed, 29 Dec 2021 12:59:45 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <20211229205945.GB2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-2-kbusch@kernel.org>
 <20211229174109.GB28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229174109.GB28058@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_125949_326532_19E39884 
X-CRM114-Status: GOOD (  19.37  )
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

On Wed, Dec 29, 2021 at 06:41:09PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 27, 2021 at 08:41:37AM -0800, Keith Busch wrote:
> > +/**
> > + * rq_list_move() - move a struct request from one list to another
> > + * @src: The source list @rq is currently in
> > + * @dst: The destination list that @rq will be appended to
> > + * @rq: The request to move
> > + * @prv: The request preceding @rq in @src (NULL if @rq is the head)
> > + * @nxt: The request following @rq in @src (NULL if @rq is the tail)
> > + */
> > +static void inline rq_list_move(struct request **src, struct request **dst,
> > +				struct request *rq, struct request *prv,
> > +				struct request *nxt)
> > +{
> > +	if (prv)
> > +		prv->rq_next = nxt;
> > +	else
> > +		*src = nxt;
> > +	rq_list_add(dst, rq);
> > +}
> 
> Do we even need the nxt argument?  I think it should always be
> rq->rq_next?

Sure. I only used it here because the safe iterator already has rq_next.
It's not an optimization, so I'll remove it.

