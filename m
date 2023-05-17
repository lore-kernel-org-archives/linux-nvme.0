Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACB9C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+L6QW6ifl2MlReq2lV/Tlh+Y+pWrx+Y+6W4K21rkgs=; b=KdF4dI0ELbKJMpnBkS30473kxO
	rgUoho4hB6vJ7owPYrJMNckLPDJnB9Hvnq650JhFCqrdI/NJCKTWTzByRhtCwKucYayjnCK5NOdJt
	9y7s0RCNGbk6g7MP189OMdQSATyEAffE4JCy1oHwURJGXDv2M5L8xJcA94pSiAa4u5sk28ZlnUSe8
	zubjCjAWP3V2Erm2wfr+pajEFKCnxuUtwiUMWheBk38kTTtkJjJ9UWs+DEkQWPDBwFplo2NchCdLA
	GYFo3427PowNi9mat9FPdfDqiCHDVs2zsX7abwZh06pHq6nftayI698KSBEHBm4vk6EiPW2pBpzPQ
	Fufe/dYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzGRR-009pOt-0n;
	Wed, 17 May 2023 12:39:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzGRN-009pLk-2j
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 12:39:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2BDC68BEB; Wed, 17 May 2023 14:39:21 +0200 (CEST)
Date: Wed, 17 May 2023 14:39:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	joshi.k@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Message-ID: <20230517123921.GA19835@lst.de>
References: <cover.1684154817.git.asml.silence@gmail.com> <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com> <20230517072314.GC27026@lst.de> <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_053938_029904_27E814B1 
X-CRM114-Status: GOOD (  15.87  )
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

On Wed, May 17, 2023 at 01:32:53PM +0100, Pavel Begunkov wrote:
> 1) ublk does secondary batching and so may produce multiple cqes,
> that's not supported. I believe Ming sent patches removing it,
> but I'd rather not deal with conflicts for now.
>
> 2) Some users may have dependencies b/w requests, i.e. a request
> will only complete when another request's task_work is executed.
>
> 3) There might be use cases when you don't wont it to be delayed,
> IO retries would be a good example. I wouldn't also use it for
> control paths like ublk_ctrl_uring_cmd.

You speak a lot of some users and some cases when the only users
are ublk and nvme, both of which would obviously benefit.

If you don't want conflicts wait for Ming to finish his work
and then we can do this cleanly and without leaving dead code
around.

