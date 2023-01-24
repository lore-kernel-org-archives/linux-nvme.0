Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F5AC54E94
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6WsntO7etH0xfXEg8dr97u06W5hMLUyrAcb7rSsGTk=; b=V08f5mGubCqg1aKJNwDA5tjl9w
	ZZ8EMX8pZt6p6yYzwKaiUaeMKVu836MhGl4K40c4vqWJLNC7kCP5pnsusFm1qXqAvMon5Vi57C9iC
	rXtlBiHnyDDtRgORmV/ncNr3ITSWC3F6/0/gJWCy05qlHFEegpEZqmkbGIeCtjUjzHUOedadA12uS
	Vc6UWVPvpRmqk/ptZL3gcDPPH2/cZheTDuQjj58xg/SAbYfveT3lzkbhaEWPkJd7nP3/4YfKgEuMi
	DNCUcKuNLJWwodYNX019vggKulD4SzbVjUbEYtKzEIxpqyJZOAmB8uTReCEGbV72mk32Z0KGFyLjW
	TOyuoVPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKR3r-005RvV-3z; Tue, 24 Jan 2023 21:42:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKR3o-005Rul-70
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 21:42:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 165DF61338;
	Tue, 24 Jan 2023 21:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110EFC433D2;
	Tue, 24 Jan 2023 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674596550;
	bh=owzr33xpbLSNlpRdKrPnxGLXCylgaqpvMFbxxp0ej/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDJOq26+qUQTiEGCyl00cN44SxlcBIaopA0XhLIxK9pGwahZdZMCAYxXKl4JoiT5A
	 XKABank1f8753ma/NDN/XlZ6gC/R0e5YRuWJbniKwhmWsiuypKrX2QhrH8hRuO9S0c
	 kc2Kzoty9vS3jLyGTxX/UTFauIGfXSFDTylMgAvKllu3KIyJfBIw8f2VGqauPk5JfA
	 EH8iLGfXQnHBTlL/gTTQKAt6HKoLg9ArXdIRHNSoVmFsfbfVYsqtNpi/Y+ZNgeDE3E
	 LCLqLwfm9w2ioN9aKjJ2B6oRqcFlf3X6onZOa/5tpIAe461jOCDJNBZ0C+iaCe4RPv
	 g18yQDv68yfgQ==
Date: Tue, 24 Jan 2023 14:42:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <Y9BQw7jgddoMXDAO@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
 <20230119164128.2159217-1-kbusch@meta.com>
 <20230123102431.GA11000@green5>
 <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com>
 <20230123163536.GA7699@lst.de>
 <20230123163819.GA8009@lst.de>
 <Y87HFanyksHLp7BO@kbusch-mbp.dhcp.thefacebook.com>
 <20230123180219.GB13872@lst.de>
 <Y87XxynP+NdShj++@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87XxynP+NdShj++@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_134232_327192_3D467C78 
X-CRM114-Status: GOOD (  14.56  )
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

On Mon, Jan 23, 2023 at 11:53:59AM -0700, Keith Busch wrote:
> On Mon, Jan 23, 2023 at 07:02:19PM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 23, 2023 at 10:42:45AM -0700, Keith Busch wrote:
> > > xarray lookups are pretty slow in comparison, though. This is in a fast
> > > path now, so I think we need to keep caching it.
> > 
> > Is it?
> 
> No, I was mistaken. I was thinking of uring_cmd for fast path, but that
> doesn't go through here.

Oh, I'm an idiot: uring_cmd recently does now use this through
nvme_cmd_allowed(), so the cached effects are needed over the slower xarray
lookup.

