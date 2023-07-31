Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0ABC001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Tcz2CmGe+bJCnr9UESUsKPsQeITB0/hccmKOqPjA5U=; b=IDoarbCe9pz0ZKvI5XnG3jGOvA
	k7xALSYYMybqI/iSR5yAIjaO90dmk1MWGvHhQsmWwNgL67EiGy9M3/NOAOUvMFLe1Dd2VnsMaGXlK
	ZbZNUEHHCUq40beqrQ3GX5KavftIuLWQ0XwJaq1BxHj0+TpPlbwQU+Zfh5vr1OQoNhaWI6opUquEo
	A8erJnearcLKMVdBncOLDKJv3keyibBNEcyVMNbfFoAXHASxYpMrFLa4/8ZfsF0ofwP8Tx1WyRUzM
	oLW9i1wHf/VEumfHSt2+ceKWkJaFwIArpumX/hmo0+yQ+D764hMKXVLutAWQ+/IU8RGtNwE/60IZ0
	ooGRu21Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTY5-00G4Xy-1I;
	Mon, 31 Jul 2023 14:07:01 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTY3-00G4X6-1R;
	Mon, 31 Jul 2023 14:06:59 +0000
Date: Mon, 31 Jul 2023 07:06:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMfAA0yDhgvekjb4@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
 <ZMe8XvFDDdAom97/@infradead.org>
 <3a827ef4-4143-a7d4-f3b1-6b50837f6fd9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a827ef4-4143-a7d4-f3b1-6b50837f6fd9@kernel.org>
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

On Mon, Jul 31, 2023 at 11:01:21PM +0900, Damien Le Moal wrote:
> We cannot do that in zonefs because there is no metadata to handle a possible
> reordering of the fragments of a split large zone append. Hence zonefs limits
> writes size to max zone append on entry and never tries to do larger writes. But
> the ZNS limit bug resulted in the split. At least for zonefs, I think there is
> no need to use the special bio add page since with a proper limit, we should
> never see a split.

Then we need to bring back something like the code removed in
8e81aa16a42169faae1ba15cd648cc8bb83eaa48, although I'd kinda hate that,
and I don't really say how that would protect against reordering either.

