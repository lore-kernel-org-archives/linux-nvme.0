Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C0CC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/EUsESql93tn6dVCOadSawA/ezkRYy3il9jfNAY/jBs=; b=LzYswFlcTmuSE5ne5A9Rdvtl7o
	UhdxP4YTSjCt3OLIdHj6dMiMuXQNjHkefmjSjQ6AvSiFi9DvQYvSvUc5rOiRP2K9GZh5YPmAw+AeM
	ozJf5uEyjXVVckFAm6Y5UpJ3n1GwdrPdABnRwJDPWqh0Odt1a/9O1W8Bm1+nG7xjBQ2OZFvqgO8FU
	WwQm5uAUCSkW7GoPn5kX7R5LznwvvRDUa9yTv4XfAViDtxCZADPkYBGnOCdBb5xKBouezEpvXprjF
	/QcrJWsAzM9aoZEyfkFtl9b+3jaXebX3x8NDAhlz4S8wCjB3rk/Doygu/pT97ZHCYCC907hllJWqY
	ctdRrsAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okS5D-00DGoT-DZ; Mon, 17 Oct 2022 15:31:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okS59-00DGkx-JI
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 15:31:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5514B68C4E; Mon, 17 Oct 2022 17:31:05 +0200 (CEST)
Date: Mon, 17 Oct 2022 17:31:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
	axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017153105.GA32509@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_083111_822008_40D1648B 
X-CRM114-Status: GOOD (  16.44  )
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

On Mon, Oct 17, 2022 at 08:21:36AM -0700, Paul E. McKenney wrote:
> The main reason for having multiple srcu_struct structures is to
> prevent the readers from one from holding up the updaters from another.
> Except that by waiting for the multiple grace periods, you are losing
> that property anyway, correct?  Or is this code waiting on only a small
> fraction of the srcu_struct structures associated with blk_queue?

There are a few places that do this.  SCSI and MMC could probably switch
to this scheme or at least and open coded version of it (if we move
to a per_tagsect srcu_struct open coding it might be a better idea
anyway).

del_gendisk is one where we have to go one queue at a time, and
that might actually matter for a device removal.  elevator_switch
is another one, there is a variant for it that works on the whole
tagset, but also those that don't.

