Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C40CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VbI5+Gzaasy3VhHvOQVemI+FWa06SafXsFhQyLrAVU=; b=g1ulrjDXUfD02RfEU8HsX29pMP
	1pj7QQDTHkhXXT8RTAZFyBbGbrFt4MYtOQT9oaWVk9zWxRcruBCB4nYR6E/gKQ2gBJKH+70BbFrzs
	e9OvCLfFWOOVeCsoflhhfvqHH60x+G3OrYTOdeKb5bMD2ECLfRWk5n/c9rl8yI2OpPVAUXXsDS9Qy
	nCi2EK+H77mUb04J2bSMSh9rqn2e5kRuVPu1hcRsNWbL1TvUjPwPYGmvMIMZ39n4KGaV8AET19L/Y
	RgHfS63BBfAIm64qj48iopmQvnBKxKw7zctBrof++afUgb96rKTHgYHxdQwqW+fl1LFpz9pLByFnH
	u2utBqzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnwRa-00CbDf-5r; Mon, 09 May 2022 06:00:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnwRT-00CbC2-UR
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 06:00:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 60DD968AFE; Mon,  9 May 2022 08:00:11 +0200 (CEST)
Date: Mon, 9 May 2022 08:00:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220509060010.GA16939@lst.de>
References: <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
 <20220506145058.GA24077@lst.de>
 <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
 <20220507050317.GA27706@lst.de>
 <d315712a-0792-d15f-040d-3a3922700a53@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d315712a-0792-d15f-040d-3a3922700a53@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220508_230024_165689_1E346636 
X-CRM114-Status: GOOD (  16.10  )
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

On Sat, May 07, 2022 at 06:53:30AM -0600, Jens Axboe wrote:
> How about we just add a comment? We use it in two spots, but one has
> knowledge of the sqe64 vs sqe128 state, the other one does not. Hence
> not sure how best to add a helper for this. One also must be a compile
> time constant. Best I can think of is the below. Not the prettiest, but
> it does keep it in one spot and with a single comment rather than in two
> spots.

If you think just a comment is better I can live with that, also the
proposed macro also looks fine to me.

