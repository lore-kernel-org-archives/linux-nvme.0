Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F609CD8CA4
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOUM233BkDBWLACgplH8WA444SMzwf33kfGfAapuszI=; b=cGYwKwf2tl0RR/RVtxx2FoFLi2
	Qgx5t/o6lwyCtL6QJJG3/cRoe8+pxdOwuc57Vzk9hmRh+oTteXS//rAox5769k0+hzo48WiqLNrwX
	YdAQvY2ztJNkoVRhnaEeJiQRnBnZPC5EW4MsgWklX43zP69T4vgtucO+omsxveJwyni2KCC3osEnY
	EPDd9/gXDMrvpzYvm4KOz3Tt04Q+daz6DVMYYR8Wj+1G2SICTdsb1qWssIKv7GS22EzvdHmAbB0oc
	KoPPw6beRccvFsQ4Hg+z/pnPDs+ZsiQkkP5AWe6yIuXamsGCFlwHseNNUuZgK4Ey959TYShZf9YZ+
	n3bL6OIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWfuP-00000004Jn4-34WX;
	Mon, 08 Jun 2026 19:45:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWfuO-00000004Jmb-3MtB;
	Mon, 08 Jun 2026 19:45:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 735A9440F3;
	Mon,  8 Jun 2026 19:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51AE1F00898;
	Mon,  8 Jun 2026 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780947916;
	bh=nOUM233BkDBWLACgplH8WA444SMzwf33kfGfAapuszI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ijWIg8hEXUjPIsGy30fNPYYxzPq3N1OHeiab4V3QfTyUN7SmS+ddM8BHST4psVUw8
	 JVd48+84OrFEkT/Wmd1ljv6pgmk/szWVRlpcquySAwMCwo1GU37BvOVV+HbczSeDS3
	 DqfgkSH5G/IGDA3y/m1HT1BlIMs3jSDrJbhDh5wo3IIQ9wsiWCUmqH/C3qODLC1JRi
	 juw2KI2WBY6ye8L7hAZUTl7LWXJ2u2Iw7CIYbxGLM772r/CjqUarLmZNXqHyxc2O2y
	 nvnRuz1ERBMws+VH0h2/bX37JVlNDrqChe8+Excwz7iLUPgP7N2mIzY06PNaNSuErd
	 qbEQsmgnVFSSA==
Date: Mon, 8 Jun 2026 13:45:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-apple: Prevent shared tags across queues on
 Apple A11
Message-ID: <aicbyoYG_XFUkocj@kbusch-mbp>
References: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
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

On Sun, Jun 07, 2026 at 02:10:58PM +0800, Nick Chan wrote:
> On Apple A11, tags of pending commands must be unique across the admin
> and IO queues, else the firmware crashes with
> "duplicate tag error for tag N", with N being the tag.
> 
> Apply the existing workaround for M1 of reserving two tags for the admin
> queue to A11.

Thanks, applied to nvme-7.2.

