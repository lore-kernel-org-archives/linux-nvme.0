Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883FFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dgbQC9wVRRwVEk4Aq2f8c21nZq4qc4uT4Rft/VP6WA=; b=foyni8WbQmrB6kT0gGoplbF6Fz
	kyHdbYjRBQh/DpAVe8V9zt18QwTzwLBKOpRnOgbGuDfAmDR2pUXPr1gEYRFVvh7TJesA0Mc36mFYz
	baQKFY2yCnnF08DOgyv1VPkFqd7BDvY0qbepv/pzOCdlO3e9vkTCzH4w0L/2Zakxlu/CvdvlCQQxn
	ULkb/UHVAprU49cbJOr8nFYIv2g0Gx14mLsFPv+2deOrSKWiCWCHm+04hSUGMKVF8hg1oU5/jWKUT
	q5PNjwPRestRvSJvx7jCng7uMB7SQkFy3BGcvmk8QsfWlnWbhONr5fVJnKB0Jk9VKZZoxPz4evxHH
	QfKwhXdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntbA8-0097u8-NM; Tue, 24 May 2022 20:29:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntbA5-0097ti-UZ
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 20:29:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4136172A;
 Tue, 24 May 2022 20:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43446C34100;
 Tue, 24 May 2022 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653424188;
 bh=WJfxQ2iiPSiUt1f4Uf4hEpa2Au75vVnP/AwO90foQtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SMPreiI6/55p4d7PJnP2wUL6G+tu6lUpshrQrTruCoTOxnJ5Nxjy4pjFom0rZAWWG
 ynvyqTADHhcYJ/l3m/3XGY452p6gA2mUxGGtGu8hn6/0da3ZMsPoft4fR+alyK7OVo
 g5L3NI4kIe/Z49comyxB/ZVMNLFnALWbtJTk7grhkEJoUXgTRh84lbWKxs+QRVz+VL
 FU+OyqKihWRQxY/BuH34+3MbTdnAwIYVBM8T2TivyvJyv0FaQrI81gr4RWXdEaoM4n
 fqbh8KZwVKGsmtV3oMReNp5XPQpPjtSoAJEoGRlmENAOcD7ze83/hG7qGu/ugAk2nJ
 h6ssvjXmqGJww==
Date: Tue, 24 May 2022 14:29:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme: split bios issued in reverse order
Message-ID: <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_132950_064229_B78045B2 
X-CRM114-Status: GOOD (  18.75  )
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

On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
> On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> > >
> > > The command lines you have are for read operations. The behavior seems
> > > only to appear with writes.
> >
> > Huh, I'll be darn...
> >
> > I think it's because the writes are plugged and the reads are not. The plug
> > appends requests to the head of the plug list, and unplugging will dispatch the
> > requests in the reverse order.
> 
> Thanks for confirming! That's about where I got to. Do you have any
> ideas on what might explain the difference in behavior between
> fio/pvsync and fio/libaio? And, why does this not seem to occur when
> only one nvme queue is present? Perhaps the in-order cases are an
> indication of not being plugged?

I actually didn't see a difference between libaio or psync, and also io_uring.
They all plugged and reversed the dispatch order. Do you have a scheduler
enabled?

