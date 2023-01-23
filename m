Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C96C25B50
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GP56SpQ1hC5f27gfh1Otv3MB261WrSyhft64HOD07yw=; b=1Lxiql9JFm80B0+5s3WJhozYX/
	oZxDnE4g8nIRFINR9n8CuU/8Ny3nUNg2biIETjZ1lhfEh79vo5jgGCt1YyBrrHCDSSwY/FwhcR+uo
	47i9mkcEbn7lIw9L9GU5kU5CSKDNVF42jKRMeqIAFnr+zWk/L+HTIVPNPIodbxC+xlMTLaYI48+dg
	ezsCYYOlN+ateVYxCua3itBVyhXPkm9jrxbUaHK4vSfc5rf6nrxs1OaF9K8Msz+GenFKQ1OYqabN2
	AbExBfthd4GPu6eEhE/LkKd2aW9RIZaajvHbUAU0rJWVEnw4E2fi04bfPrSKmBQaW6SsWEsaqVhXG
	J3kMlJFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK1xF-0014Qj-TI; Mon, 23 Jan 2023 18:54:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK1xD-0014Pw-Ot
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 18:54:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 571B86100C;
	Mon, 23 Jan 2023 18:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F26C433EF;
	Mon, 23 Jan 2023 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674500042;
	bh=CR3WLrmcF2kOWP+0iveujpgoavEgQyWezC/MjX/AohA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k62/pcOD/n5iOH2gL1PRAFaynp30hAraCBwLlYXzav/ASAO6979G0jJc9ARj5/LFs
	 jRnQFZgdGI8xwK8JiYogg8RLfTtQb4Y/w53x+bePPz7j2Qe4Bzgx43AUGS0+/RDcYz
	 WvAguliRqrZxzmJdi0lu56NdMMLtHT6Tfe6x0km9mm8jjFqRTNLH+4ILR+kJ2Fl+KO
	 BUbE/RoKM9CgsZyvf3oNeKdqwj1L6k7VUgNacegnb6qZR9lSYBew25zAHIX5co8Cyd
	 EXD+MtgQyCYPSsAs3mwEC2PqRc1EBxr0/4nAhrB0IRnkmXch7+4TsOvpy1FIeVz/yh
	 UHVJ5lrthyD3w==
Date: Mon, 23 Jan 2023 11:53:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <Y87XxynP+NdShj++@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
 <20230119164128.2159217-1-kbusch@meta.com>
 <20230123102431.GA11000@green5>
 <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com>
 <20230123163536.GA7699@lst.de>
 <20230123163819.GA8009@lst.de>
 <Y87HFanyksHLp7BO@kbusch-mbp.dhcp.thefacebook.com>
 <20230123180219.GB13872@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123180219.GB13872@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_105403_859944_F9C0A297 
X-CRM114-Status: GOOD (  12.08  )
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

On Mon, Jan 23, 2023 at 07:02:19PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 23, 2023 at 10:42:45AM -0700, Keith Busch wrote:
> > xarray lookups are pretty slow in comparison, though. This is in a fast
> > path now, so I think we need to keep caching it.
> 
> Is it?

No, I was mistaken. I was thinking of uring_cmd for fast path, but that
doesn't go through here.

