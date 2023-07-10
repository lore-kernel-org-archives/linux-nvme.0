Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D821EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s10TaXvPesPOjUAZWMibCBW/laFSD5My+Gnp4gorR2M=; b=VJD3OijUvbNPc2zzcRhdWvDZWp
	Sb7SYXr5MpEtfmB17uZ5YwneGJMFgWuYZIOp8hM1TmMYWoOOUYS+mksDs3X8sSbWJGE++N2463fKp
	9UCY2H19yxmEkN3e7FkeUEuDULwsulPUT3b3dkfHlD1B4u/ACQY8xnfwUWci/t2YQtjqCMrUUHIjh
	VdkN548uoyjiGfUkbRGGBRNJnxda+bMD2CCO1LAYYlAjHzsQDuMyb6uShb4Hyjvxd7l36ymtxbhw1
	TyN7DV/zvr18NyyLp0b044cZhHVJyQgXFSApGkbEKMV8pDDRpTXp7pr8Wn9sd1biQlUzz8OM3ktuy
	ReGSUMTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qItHx-00C83y-0K;
	Mon, 10 Jul 2023 15:59:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qItHt-00C834-2R
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:58:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EEA7661072;
	Mon, 10 Jul 2023 15:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B242C433C7;
	Mon, 10 Jul 2023 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689004736;
	bh=QUm9t1ezC/IIBjn6xwi8cf0YyRAsFcWX+N8CXwamai4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qErJf3rV0VSpOBIFaXedO/qXItU5H8PQsiFAaXjpq+rI9yjOk+4dSlOoV8gjGnOuL
	 gVsk5LZxUzKimVySyZNlOkD4C28uhf8aVy7JT0F411kCaAYrln0AwBgiQ2w/uIxbBV
	 ETAnqmD71bPt3/uC360q33UqtfVDEyF6ztR+0CmoLqEiUq7VMmqMqc7cun8p3TAZkI
	 YCcmfB6g+dLatvmJjjxYJiihz124cK2wbhkFTw5MT6cspS4oBZicsA/GkfMgb+cRoW
	 IN4n2n8m34M+Wh86LUDLbcKVmoTH0XrL+Pu07/zB20qtJAPB40RHgZnsUU8fEzZfJS
	 tX5RdTFMze6DQ==
Date: Mon, 10 Jul 2023 09:58:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_085857_876720_236698CE 
X-CRM114-Status: GOOD (  24.23  )
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

On Mon, Jul 10, 2023 at 10:52:52AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.06.23 18:10, Keith Busch wrote:
> > On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> >> See Bugzilla for the full thread.
> >>
> >> The reporter had a quirk (see above) that fixed this regression,
> >> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> >> through cracks unnoticed:
> >>
> >> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
> >> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV
> > 
> > These bug reports really should go to the vendors that created the
> > broken device with non-unique "unique" fields.
> 
> I understand that, but I think we need middlemen for that, as I or Bagas
> don't have the contacts -- and it's IMHO also a bit much too ask us for
> in general, as regression tracking is hard enough already. At least
> unless this becomes something that happen regularly, then a list of
> persons we could contact would be fine I guess. But we simply can't deal
> with too many subsystem specific special cases.

I'm not asking the Linux regression trackers to fill that role, though.
I'm asking people who experience these issues report it to their vendor
directly because these device makers apparently have zero clue that
their spec non-compliance is causing painful experiences for their
customers and annoyance for maintainers. They keep pumping out more and
more devices with the same breakage.

This particular vendor has been great at engaging with Linux, but that's
not necessarily normal among all device makers, and I don't have
contacts with the majority of the vendors we've had to quirk for this
issue.

We did complain to the NVMe spec workgroup that their complaince cert
suite is not testing for this. There was a little initial interest in
fixing that gap, but it fizzled out...

> Another request came in today, even with a pseudo-patch:
> https://bugzilla.kernel.org/show_bug.cgi?id=217649
> 
> To quote:
> ```
> As with numerous NVMe controllers these days, Samsung's
> MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
> from invalid IDs, breaking suspend and hibernate also on the latest
> kernel 6.4.2.
> 
> The following change restores this functionality:
> 
> File: root/drivers/nvme/host/pci.c
> Change:
> 
> -	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
> -		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G, 512G and 1TB */
> +		.driver_data = NVME_QUIRK_BOGUS_NID |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },

Panjaj, okay with this one too?

