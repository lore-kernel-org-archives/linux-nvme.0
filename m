Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E40C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jIAlKzMQZkwpTN8x4c88BHiMy1DP29F0XFcamdIm0po=; b=fZxBVRkhw9zh+2ZGRp5gSTCyJb
	LMLjTu7uKne71/fPinWv/rNbkj9vFmS5l9O7TaNK4JGEFZKUl0/iE1I+o7ocRpd7j6LOtKQX1GYgO
	+eNTopbAwkh20edk9YAy8lKulgykPg1SaKKiZ9fJ2z5KrKNLVUO8AT9/3hDWNMZSHDpF5PmNuqXhh
	HVrX4Www9O1gryFpjyvH8E9KOmyDaM4If1ZZocFuqpgmRvHkAjS05RImHRWA9LkUzc7yxpfvr0geQ
	H/po8WKKjcIkJCQGTqiBsXq62lmq2pIr7mVQjconpdNsRx/r2ucsHj19Ebw0pTR72IxeBjyL45Vhn
	fXoGK5cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqGJA-007w7s-Kz; Thu, 25 Nov 2021 15:05:08 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mqGJ9-007w7c-2T; Thu, 25 Nov 2021 15:05:07 +0000
Date: Thu, 25 Nov 2021 07:05:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YZ+mI9a1Jd2/zNkh@infradead.org>
References: <YZ+X/qGC6/w3bp2c@infradead.org>
 <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
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

On Thu, Nov 25, 2021 at 07:55:38AM -0700, Jens Axboe wrote:
> On 11/25/21 7:04 AM, Christoph Hellwig wrote:
> >  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
> >  drivers/nvme/host/fabrics.c       |  3 ++
> >  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
> >  drivers/nvme/target/io-cmd-file.c |  2 ++
> >  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
> >  5 files changed, 93 insertions(+), 46 deletions(-)
> 
> This doesn't match what I get:
> 
>  drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
>  drivers/nvme/host/fabrics.c       |  3 +++
>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
>  drivers/nvme/target/io-cmd-file.c |  4 ++-
>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
>  5 files changed, 94 insertions(+), 47 deletions(-)
> 
> Hmm?

Looks like the diffstt doesn't include the the requested reformatting
in io-cmd-file.c.  But I have no idea why.

