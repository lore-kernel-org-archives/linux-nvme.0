Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB9EE01F0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 23:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TV+CcAziPH35Tnx6moAkUp2s4yquxmqd8Fl0J+5RNqg=; b=wmSfHjaQDS+M5c7s6FbXvmYd8Q
	jbAtN3gmTnIke6CYMIOuQ7GQztsfhEs40F/35sNPS66zG1MWnY6uMituoOc9CERZYs4dfy6f1nUTt
	z8Ya2BJ3tf7TxUvIJBOGuTW32Gf05gl5vy4QgRUUZunypfrjwOujg6HPJ0I4FXLykYrMvOZuN5tI4
	MDBsen+GtqKJ+UlVbIwI8+9zhpRWs+aIH4lcypU0Kzt2S+8Cf/h7LNgwGFdUT55Ng+wj+YlR8uVHL
	mCx7FBg+MCANW0gmSmZFhFd4lTOhPCxwGlhBPeMLgZXGe83pXXYZgv54aoeOROhOR5Qzc4crhRV7Q
	cXA1lafw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so9sR-00000007OIM-0xWl;
	Tue, 10 Sep 2024 23:02:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so9sO-00000007OHr-1mfg
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 23:02:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A4B77A40501;
	Tue, 10 Sep 2024 23:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56154C4CEC3;
	Tue, 10 Sep 2024 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726009342;
	bh=BIYdIemb/WL/BM+LvvVr/a4fGnsrxpvabZqZ7muh97o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DX0nTJjcLQFoXRQ0sReddB4B0hoFkxGA4wbIIn9u+TWdHKL2nKnY9oYYRTChJH8qY
	 N6JKuOW1RetNDdqyL4b4EX0uDmQ25oNnwEJqHqWLVjvp8G+pfS74DRo8xBSf2LamDn
	 67q/IZY6iIZSE3HV3xLKrWn12oZfgo7nrFVrEPUZX1mRacsYNj4H87JqPXwINUEX2X
	 ftr89Q38wJDrLfRt4jRPwN0a7Hqt1nHj3sklVYaUJdbrvDJ6xLLjIWwg+UqW4Dlo/w
	 VnXSWmJNubandBv3GNIaof1o87Et3P0B4bqpU3sarI+X56OmLW+N1uHPYwv6bS8Qxc
	 CliaGl3vN9cUg==
Date: Tue, 10 Sep 2024 17:02:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 03/10] scsi: use request helper to get integrity
 segments
Message-ID: <ZuDP-ncB0EXrS9Xg@kbusch-mbp.dhcp.thefacebook.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-4-kbusch@meta.com>
 <20240910153217.GC23805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910153217.GC23805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_160224_547517_D288BC72 
X-CRM114-Status: GOOD (  11.13  )
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

On Tue, Sep 10, 2024 at 05:32:17PM +0200, Christoph Hellwig wrote:
> 
> although I'd be tempted to just remove the BUG_ON below (or move
> it into blk_rq_map_integrity_sg) and the ivecs variable entirely.

Right, I actually have more follow up's doing that. We just need to
change blk_rq_map_integrity_sg() first to take a request instead of a
request_queue + bio. I thought I might be getting carried away with the
"cleanups" though, so was saving that for later. I can definitely add
that into the series now though.

