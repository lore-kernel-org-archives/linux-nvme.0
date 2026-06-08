Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537B8CD8C9D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzPQS0zPV1qh7GmhSi1kjSG4u92Zg3IWFK7qLiSbD0Q=; b=x56iOhDSesL5sjxFwNKmmn1ZI+
	T05Qzyqc5IsG9Z/u0BVLd3WD3scsnxzDN1znlMVAOgFcJ0lCY2z6WSCAt7xEuwR5N4FReBPIT3nrK
	dd9oDww5Kjme46XSQZWxAvA14JL/oU3xdb/4ye84j2t8y7bMEGoGmf5/s8SftYpxawLI2iZ7Uw3xN
	kS+qMNuJ6SQMnSEPM4S21aBaR2/jps+QUfsHQcodt4dvldCbKczkoURj3EuhTj8Erq2Z88a6ek3NE
	PNDqpSydQ7BAqgnym7aPX6h561i4Rnn+srHye7E3+S/vfnq5BFkb8X+1TQNG9GGqnlBOenv8QrXy5
	ZlqJJmTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbjE-00000003wGT-0F7V;
	Mon, 08 Jun 2026 15:17:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbjC-00000003wGI-3gsE
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 15:17:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E90C8429D8;
	Mon,  8 Jun 2026 15:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8588F1F00893;
	Mon,  8 Jun 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931845;
	bh=QzPQS0zPV1qh7GmhSi1kjSG4u92Zg3IWFK7qLiSbD0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F1DqkHK1ftq/FuIW1T/MQiF/XGbX9BB8E00RwtpDQuSbjPM1jkRYBkFvvUtWGDbeV
	 iGIV3+YdwG4tAglB3OT7UzIycseX+ReiIzN+sd3glZ05TVs5G+Nx9QnUtWk+MtGdil
	 bmU7BnbXZ/mLyzk0vMFiBWdY/J3uBlYymaM4WJ/YW/71H7b/NN9JIi1veqZYYjzhUa
	 qa1pfj8gmz6/WRqEi5oG7yWXZi8PEPBW4nfk/WMMDrLSfoaT/8yYp4EuUEmI3WHkNM
	 WoxBtNqLzTHMaDDUHO5Fc91HaYLQub7skwoHAs7rj7864J7X7SGCM4/6/TpFJLlCO+
	 H21UBuIFejwlg==
Date: Mon, 8 Jun 2026 09:17:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, yebin10@huawei.com
Subject: Re: [PATCH 2/2] nvme: avoid possible double completions for the same
 request
Message-ID: <aibdA7YtCt5OS1EQ@kbusch-mbp>
References: <20260608113425.3836619-1-yebin@huaweicloud.com>
 <20260608113425.3836619-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608113425.3836619-3-yebin@huaweicloud.com>
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

On Mon, Jun 08, 2026 at 07:34:25PM +0800, Ye Bin wrote:
> To avoid the preceding problem, the NVME_REQ_COMPLETE flag is added by
> referring to the implementation of scsi commit f1342709d18a ("scsi: Do not
> rely on blk-mq for double completions").

That scsi commit was solving a different problem for a racing
interaction between the low level driver and the timeout handler and
error injection. It wasn't about protecting against misbehaving
hardware.
 
>  static inline struct nvme_request *nvme_req(struct request *req)
> @@ -807,6 +808,8 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
>  	nvme_should_fail(req);
>  	if (unlikely(blk_should_fake_timeout(req->q)))
>  		return true;
> +	if (unlikely(test_and_set_bit(NVME_REQ_COMPLETE, &rq->flags)))
> +		return true;

I think you need to invert this flag from "COMPLETE" to "INFLIGHT",
because the default allocated state is that this flag is cleared, so
this check as you have it wouldn't catch a phantom completion to a
request the host never sent.

You also have this check after the driver updated its internal
generation counter for a bogus completion, so now our actual state could
be off from what's actually being prepared. 

This previous proposal for a similar problem was probably more on the
right track:

https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@gmail.com/

However, I'm really skeptical controllers actually behave this way. You
wouldn't have a viable storage device if it was doing this.

