Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BFAC25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 05:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGD8e8W0ADYiRiaARL57q94CaUzxErin9PPmd+A6Ntw=; b=YuX7RPysJFFmoWGmdR+PNd95LE
	FuSwt6N3cmluBi5hAZTG/ZQfw17S/Lgzm6Jup4HkYfN0kFZpvzB925TXTXBUR0AlIGA3XqffcQ//L
	oGfGcEKPyvC18ssbZLNoDrF5llwZWPW96xfhaY5fTclftk9y5/EyDot8GXj+FS5pvQClS6SZobeLk
	vRffM6yMNHoFeE3bj1CfuFWmbuuae1pGl6GyMfNNSi03xM6Uzm3qHRlJ5ZO6AvblmWfFs8yHT0iPe
	oLY34S6l5aJiRpyGa7o9X6SJyB2kB9TiPJIKvpgst9ByOIJK/3TxU9QAKbAL8suFfEFhLPqBInFT/
	W2OnoFFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHmG-0000000C2Xu-0676;
	Sat, 01 Jun 2024 05:59:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHmB-0000000C2Wk-461g
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 05:59:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06C1168D17; Sat,  1 Jun 2024 07:59:32 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:59:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240601055931.GB5772@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com> <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org> <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org> <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com> <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_225936_217795_78686DD6 
X-CRM114-Status: GOOD (  14.32  )
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

On Thu, May 30, 2024 at 10:11:15AM -0700, Bart Van Assche wrote:
> This new approach has the following two disadvantages:
> * Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. These two
>   operation types are the only operation types for which not using a plug causes
>   an I/O failure.

So?  We can clearly document that and even fail submission with a helpful
message trivially to enforce that.

> * A loop is required to combine the REQ_OP_COPY_SRC and REQ_OP_COPY_DST operations.

I don't see why that is a problem.  Especiallly once we allow multiple
sources which is really useful for GC workloads we'll need to do that
anyway.

> Please switch to the approach Hannes suggested, namely bio chaining. Chaining
> REQ_OP_COPY_SRC and REQ_OP_COPY_DST bios before these are submitted eliminates the
> two disadvantages mentioned above.

No.

