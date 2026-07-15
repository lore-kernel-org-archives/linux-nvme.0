Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C0DC44508
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tBe5Hh5CZ9elNDX+NryJrxuUN0H1brjZYHGsOoRSfw=; b=AIYZS2nu0kyN0uBOE4j5Zd0q6Q
	Wz1BDifhwjU+7uLagfrzxkmt6svhdQ38qM6VJzmK1PvY4ibzII36UGrB30P2D71YN+3rnjAcfAKbx
	XyljS5o7hR4NIminD8od4q6A00T/R4eZplQe/Er/qUOyPFF33YPNS2I09/Kr8biME7Xvlq7KV6VMW
	OoH96oV9Zvp7sX9BZwP8n0/WCWmBtPelQlDttmqpDuPFstmNK+wowzi1UllXmZntkWeBo2TGf5W9m
	Y4nMPvWrf57o1pDC3kYtpd5c28XMYa+EgfYKahzx58T7x173FyGh7kCKEjD+csFvj0RRND5x/HxrG
	4I4wnEmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk23M-0000000FOdL-3cYa;
	Wed, 15 Jul 2026 16:01:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk23K-0000000FOcS-0yJ4
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 16:01:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0064143287;
	Wed, 15 Jul 2026 16:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B31F00A3A;
	Wed, 15 Jul 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131301;
	bh=7tBe5Hh5CZ9elNDX+NryJrxuUN0H1brjZYHGsOoRSfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRshH5t1r6At+UCyzxIn+UZOUDMdzTGuGsCYdi9w4mD3TJADafkaaZoT+hRpHf6b2
	 rQ3vDn0ESOZlZFaHttSqqR8lmF1UKdBMbZP/ky1bwdubAflv3+s75ES+77aMwZm2tQ
	 xKgxwN4arecU0/X642znBfaNf4XI7cK/e7uLJRxMyYCBR3Kgjtr1CCnLjaYhDWc7Wr
	 O+BT1ResAyI+plW8ebqO+DUhPC5zOM29lETxU9Nagu9ZissqzUHyUR+MG5sxc9G2e5
	 /uPKkhHp7XxHIJrcd8iLSSEqYJeWuXQtIzIrmFfjLaqYbMEKMMwwqrmSXRqS0t49oL
	 ouWLV1Cp4OAAg==
Date: Wed, 15 Jul 2026 10:01:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <aleu49e4GxG-Z7B6@kbusch-mbp>
References: <20260627061933.2187447-1-csander@purestorage.com>
 <20260627061933.2187447-3-csander@purestorage.com>
 <20260714135310.GB714@lst.de>
 <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 08:30:33AM -0700, Caleb Sander Mateos wrote:
> On Tue, Jul 14, 2026 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > For Type 2 this remapping could work, but doing it unconditionally
> > will make all data written using and earlier kernel in a partition
> > unreadable once this changes has been applied.
> 
> I mentioned this in the cover letter (and that's why I marked these
> patches "RFC"). Unless you have a clever idea, it does seem like an
> insurmountable obstacle here.

We had a similar problem when we enabled PI at the end of the metadata
rather than just at the beginning. This left machines unbootable after
upgrading the kernel, so we have a module parameter to turn off support
for the feature. It's an unpleasant solution as there's no upgrade path
to ever turn on the feature without a format first.

