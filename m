Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6075C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 05:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dgaHlMR40VNrqwxakfYaG4cDLF
	Kb9D4gFIMV/v1TTCO9IArtshg5lL0WwRZvIDYttW+gBHmN6WddTzl1twPZRQqJr75hG8q9hqVFa+t
	6dDKl6Ku9p/N/YGu1GfknpAdrtUNHJsr5wCKeZlrdFZzXPtYUJGOCQ7Y8pYKVKt8Dr8yM7ZQdscBP
	tSidFz6DFdXdGpnSihIXRmHZzcDMvzowbSzmu2/OSvfsPYuLX3zsF5nkbdL3BHid3I7RXW0+CQ9Uq
	HGdo1IE47dflL8HvS3lLNTi0GLKBtwpKeQGAaoBaS27vv3hEvnqwvxQRW2ffdJhopSUKe7ElD/AZv
	WX1LgqKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1JN9-00000001VNu-27w5;
	Mon, 29 Apr 2024 05:16:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1JN8-00000001VNb-3Sb1
	for linux-nvme@bombadil.infradead.org;
	Mon, 29 Apr 2024 05:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=feNuGdjHOMqLlsOAQFejRWTc7g
	i3AdhJzKCSvymsa+AViNQFiJEflyj8EXzFoK3f4EIlyz81wgaNslI4AXSxqaewEItDR7iz1vyri/x
	YZpvdCvgQ52Mlp5IpmmbwcRX0Oxe1SmV04vIe0DzKPtqBIe3nArMgI81Q5owZB03pRHKvr+SVMUSn
	LnLq+YAJgyt57c5gFu/1dlXqW2kM9tnaFutXEo/1WPgh24FQaxymW/s+/cHLRS5fIXSM5Co4YYKYy
	9uTbJODjFKyRvDXcQkOdSFJYFtjAkh/REbnQxRuIZ09fs9ngxI3yZneOYImS3tooikLgfksVEco+w
	FHS5ocfA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1JL5-0000000GMW2-1D2I
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 05:16:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53776227A87; Mon, 29 Apr 2024 07:13:37 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:13:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet-tcp: fix possible memory leak when tearing down
 a controller
Message-ID: <20240429051336.GA32577@lst.de>
References: <20240428084949.61931-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428084949.61931-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_061425_046847_87AEC668 
X-CRM114-Status: GOOD (  10.41  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

