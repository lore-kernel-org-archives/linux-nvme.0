Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E52C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wx3Izz00mSsl5ykG4rVsXiSmWEQqB2Hvu6El7feFXVM=; b=WFBvlpm7kKZeaiNoplCX75glJy
	CQUFoLzQQyCKQPfc5o+Vw6noSBAfh/sBTW304EedfqHlzKKeDmLsC5O4MFeU1bO+brDmcRiuwbyUR
	Fvz/hWEpFt2P+B54iuDFqfubrw599n3GXawxVurH3RpfS/OCPr0WjcTQAiMLVlpRPL9oCsPRWTBAL
	6/F4uLSWf4lXAazDCrv0dpylq5jIOVozYZxD8QUGQ8rBxamZNYYdbRSilJi6mVpLwlhxNy6m9klFa
	UABHSQ/pVO0L0o+Ld3Hl37fFhnREbSoTWbZNr7Hxx/Okh62IbNYVBIyC8kexLz615cSckxZfjOJj4
	ayfPZvvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQOJ-00CD0z-29; Mon, 17 Oct 2022 13:42:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQOG-00CCuo-C3
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 13:42:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE02868BFE; Mon, 17 Oct 2022 15:42:44 +0200 (CEST)
Date: Mon, 17 Oct 2022 15:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
	axboe@kernel.dk, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017134244.GA24775@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017133906.GA24492@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_064248_579045_80892C87 
X-CRM114-Status: GOOD (  14.14  )
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

On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
> Having to allocate a struct rcu_synchronize for each of the potentially
> many queues here is a bit sad.
> 
> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
> last week, so I wonder if something like that would also be feasible
> for SRCU, as that would come in really handy here.

Alternatively I wonder if we could simply use a single srcu_struct
in the tag_set instead of one per-queue.  That would potentially
increase the number of read side critical sections
blk_mq_wait_quiesce_done would have to wait for in tagsets with
multiple queues, but I wonder how much overhead that would be in
practive.

