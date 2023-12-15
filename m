Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A089C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7IMkAfIBmEvxf3elgEkopEiSqNlGl7JwL9zvw1zGOA=; b=LX/xnA9IvOk0E/UC07fvcsxNnd
	pnU29G4uAB/qJWlZZJIGDXiKRN2jYjhewhsIvKzUNtlZPVgI/Iwk67xYBnG2cdbfsF3fm0DKx7Slv
	hzqITHXcbacy52OUSgrnjD2j2tQxmA4SPfu5b7wKso8REvvIWJVJJfTFI+nZyBryCbtyPLYOcpaQN
	BhJ2ZCFQOZ5zMplcicNk8k4mTyYpYvK6uufEdBBEeL6XqY60hbx3NwDG+Dg9y7vHltohWEasJJOM8
	ktft638VpVpmdyhddNx7BulpWv1er0t7Fba/mkZV1jTsyQ9geqU3L7hhOjhAVBQ1CLBPSNH09sDLd
	NE1ZZUMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rECcB-004D46-1L;
	Fri, 15 Dec 2023 18:08:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rECc8-004D2W-0c
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 18:08:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A0D5D62725;
	Fri, 15 Dec 2023 18:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072F7C433C8;
	Fri, 15 Dec 2023 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702663723;
	bh=iinseS688h/LregynHtbLbWjkVjdS17BzYa7o6Tm53A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UznLvWYupfikK6SMYTjjYAzMrEDCdSktDX58rkZa255k6Tb4ADfHvCoS2Wxn2L+JZ
	 Pb//McPIM8kIgOUihdUBmJ6a/Pk8F8huEmnqdksLXnfLtvvtRnmxwmTUhzIYPhCDuw
	 PbPZGfzjvjD1qyOqwT2f1ZE6iaBHGFdBJxBSK+F+WHwv79htFB1gWUuBgZgpBUWt+7
	 4CIrMsu8Qum2G4cSn7KXNxx2BHMcEGJSmqzYhfEVhwcodtAYUqJMcLzV987llzmIts
	 Y4ccOceIhF1zgTujFL5v4G9z5eL7g3tgPM8G+pbaERrnXvig59GWxWwmuvw/12eVzQ
	 /7uS0UvYgunWw==
Date: Fri, 15 Dec 2023 11:08:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: ioccsz and iorcsz check failing
Message-ID: <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_100844_268022_A9466437 
X-CRM114-Status: GOOD (  15.93  )
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

On Fri, Dec 15, 2023 at 03:48:04PM +0100, Daniel Wagner wrote:
> Since commit 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz") my
> testing fails with these checks when trying to connect a remote target
> (Linux nvmet) via nvme-tcp. Looking at the TCP frame I see these values
> are 0 on the wire.
> 
> When running blktests with nvme-tcp via the loop back device all is
> good.
> 
> When running blktest with nvme-fc via the loop back device the first
> check fails because ioccsz is 0. I've added a bunch of debug prints:
> 
>   nvme nvme0: I/O queue command capsule supported size 0 < 4
> 
>   nvmet: nvmet_execute_identify:687 cns 1
>   nvmet: nvmet_execute_identify_ctrl:469 ioccsz 4 iorcsz 1
>   nvmet: nvmet_copy_to_sgl:98 buf ffff8881348a6000 len 4096
> 
> So this part looks good to my eyes. Not sure where the problem could be.
> In case someone spots the problem as I can't really make sense of it at
> the moment.

Weird. I optimistically thought I'd find a problem, but nope, I am
confused. The code looks like it's doing the right thing, and your
target side prints appear to confirm that, but host sees a different
result. Is anything else in the identify wrong, or is it just these
fabrics fields?

