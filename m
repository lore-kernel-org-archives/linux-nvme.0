Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF51C77B72
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjHuZR1FiTy+CNjCS37PaZAWquM3kFyxRb+Dk2fFwZc=; b=lqRqDYuWHzW8p3jnZf1spsYg5M
	vNAfGedFQtBOT8YNTBGaDzQ1IVCdEB3L46GOzNlGCRqvhZAuqrxR4BfZBnATQ98Rm8LznmYqgeXL3
	FBEyoK7hTi6e3YbGz/99adIuMIRT5gg1pzAPUFS2ye2CQ5syLMoa57S62TDa3eVAC+i9bxpkdQ7xS
	CndTE6DnChQYYWotFzSbLhNzJCae7ziimhVCsdT3OlX+/P05viy2ePcbpHvi0kdVxFjAsLkasIna+
	kZ7z/jQR1+jH8EHqWVMup4ndbIafOkidDuR6+11jhwmWNN2r8w+8UOYYeyoDKUx2rP7Uu+xrUnvAk
	nVsazqhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTS2-0084Mq-1K;
	Thu, 20 Apr 2023 12:31:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTRz-0084Kr-2L
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 12:31:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BF2B68AFE; Thu, 20 Apr 2023 14:31:39 +0200 (CEST)
Date: Thu, 20 Apr 2023 14:31:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, asml.silence@gmail.com,
	axboe@kernel.dk, leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230420123139.GA32030@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org> <20230420045712.GA4239@lst.de> <ZEEwHk32Y8IcT20n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEwHk32Y8IcT20n@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_053147_903703_B18E4C91 
X-CRM114-Status: GOOD (  15.88  )
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

On Thu, Apr 20, 2023 at 05:29:18AM -0700, Breno Leitao wrote:
> > > -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> > > +	if (req->ctx->flags & IORING_SETUP_SQE128)
> > > +		size <<= 1;
> > 
> > 
> > Why does this stop using uring_cmd_pdu_size()?
> 
> Before, only the cmd payload (sqe->cmd) was being copied to the async
> structure. We are copying over the whole sqe now, since we can use SQE
> fields inside the ioctl callbacks (instead of only cmd fields). So, the
> copy now is 64 bytes for single SQE or 128 for double SQEs.

That's the point of this series and I get it.  But why do we remove
the nice and self-documenting helper that returns once or twice
the sizeof of the SQE structure and instead add a magic open coded
left shift?

