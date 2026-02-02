Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6854E7DEFC
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmZrp2bZmnEnNzt4MJ+CfKkajXGexFkhDAbKjOCJPBA=; b=JhDPXd7Ll0n93G2GSKv17yHAyG
	16GGqBCBTZ3taNtyLXHhh8WpYRth309u0tdrh7aehZIqJuKh42S1b0kMyoOSA0aDx03JZaoe+TTgJ
	ALp/RMHtMwBbBiXnsZ3ooF8PFVmrcL9vGrvztjtsDIbIsYhgoQj7xGAyEz2cIkpnYp88DGk3gRqNA
	HdRFZDPLbP4dZggsKjvXsgt0Nj70JQVwaazATCT8rAzotosQ0gxa2dJLdDkMZ/R1ktxZnaMQ8nw3Q
	L2sYITiwLRkngzyKjPBdB8G2qko4vwUdoEFQbe3foq/Ka0yrb15Wsip+vdPgdu5oF/RwmYaYw+n4H
	SGrWK54w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmwUz-00000005Gtl-1R22;
	Mon, 02 Feb 2026 16:10:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmwUx-00000005Gt2-0uZz
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 16:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A7D760010;
	Mon,  2 Feb 2026 16:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA144C19422;
	Mon,  2 Feb 2026 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770048598;
	bh=Lae8aXO087o0M2zdl/SketbEso+rARFNP0Zht6y383U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAkAztTdZURfZKunkV1/CAWLNFe26/6sIeUY5XTNGeMTxM6n68Fv4owprvw4Mpu4M
	 oRpGFy3lYrUZ+UgYk/KZmwgQUNsfaJTnC3YpkxoXpqpvPWR/7GsAu5CREQfJsAar1J
	 6D6k3MDrFqcRc6sUPsUzovIcghMA8ykCeCQ7GXpnmSn0a83uPK7RminRdypKjsTIyY
	 1ox1HUrthx821Tgry091g9vzrG/jU76nKCpOkFi2B7wcLlxCAQSdgkMUWEARS8EF/S
	 8UHl/1WdSt9Z2tY2VNHjEwu0+VvLYZx/uMxN+fFE0KsWObsvv2jugDBqp0WsKQJgYP
	 x5tRf4WlbdSBg==
Date: Mon, 2 Feb 2026 09:09:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme: fix admin queue leak on controller reset
Message-ID: <aYDMVFvZqJoYGBFU@kbusch-mbp>
References: <20260131144808.4173338-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131144808.4173338-1-ming.lei@redhat.com>
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

On Sat, Jan 31, 2026 at 10:48:08PM +0800, Ming Lei wrote:
> When nvme_alloc_admin_tag_set() is called during a controller reset,
> a previous admin queue may still exist. Release it properly before
> allocating a new one to avoid orphaning the old queue.
> 
> This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
> admin request_queue lifetime").

Thanks, applied to nvme-7.0.

