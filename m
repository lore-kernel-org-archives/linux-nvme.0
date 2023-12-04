Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E930C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Os7OsOX6ajibdu9SDjR/ruVX2grLXNuTE3yRb9jRZO8=; b=4PctkG1/NtSdove+/poRbODzuI
	5mM/58qSJXiZL+GalVaaCQfgTINzYnRDtGS5hLA1DCzkhFXu+rY9H0W3GCF2HQn6UKlHl5zD4VqKy
	NAo68/vodIPj6vk6cexcLEcN2B5ahZwzenL57mfRH82chV5BlqPV1aaQSxieWFzDCj+ohjIpe4s2C
	5iQzNB3Ka7Sdiikqcqmg0CQrLLSwmfsgMyySq5ZIGmvRr4lJthKRFnW9S+mOrQQCVQfG6cHxJWuGf
	c0e2ExhgsjhJdXhhneH0IudW7kPk0r4BG08ChExNBiiE+8dE1UWMACTIP4ONHNhqS9t8jLl5Gard5
	7ZTXBAoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Li-003GfC-2l;
	Mon, 04 Dec 2023 08:30:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Lf-003Ge9-1s
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:30:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F4F868AFE; Mon,  4 Dec 2023 09:30:35 +0100 (CET)
Date: Mon, 4 Dec 2023 09:30:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Message-ID: <20231204083034.GA32360@lst.de>
References: <20231130201919.2486553-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130201919.2486553-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_003039_794394_83626F3E 
X-CRM114-Status: GOOD (  10.96  )
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

On Thu, Nov 30, 2023 at 12:19:19PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This can be an expensive call on some distros.

Huh?  How would a distro matter for kernel code?


