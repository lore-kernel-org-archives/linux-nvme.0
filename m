Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699F1C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKwjiC8hL6n79wHazyHcmoNYJGUIqPJwcIesEKUi7H0=; b=bda0voOuCWoeqbTKSzlzct2xhz
	BvvfdXoSGTlUgKLTzyQq6Qag4GUAtGFV6xtSE1u0h/ecDKI/mV5EI8stgOoC/23TKDz0lnAKDIBR2
	uL/ZyuUzKsCL6hhrpIb3muA+Qq7ZCMKCX3lDTcZbvULkIO6JFddEvr13MrOVNS5d4zMnyKuUIvtEd
	45NHlNLv1GcmQVxzwrRup7yizPt4sEaUbOE70vleMCr4Pzy+atSW/p50ZXJ76rghaK51hJfqzN92c
	kj6ZkaQr7ZiZDY6Z7aLwk1Rj5BNurOfdPow8bXa8ZjfvSwJ71uc3ee+k+ORRyEykrVUwx6LC2Odp/
	xTvkV+hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xXN-009sFm-QQ; Wed, 22 Jun 2022 10:24:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xUT-009qzM-O1; Wed, 22 Jun 2022 10:21:41 +0000
Date: Wed, 22 Jun 2022 03:21:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Leo Savernik <l.savernik@aon.at>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Introduce NVMe quirk for multiple Micron MTFDKBA2T0TFH
 SSDs
Message-ID: <YrLtNVIhLMwvfMZZ@infradead.org>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
 <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
 <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
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

The patch seemed whitespace damaged.  I've manually applied it and
use that opportunity to shorten the commit log a bit.

