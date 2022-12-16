Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC6AC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTuZZ59ZuXN3ROvo7bPDkf1fKCfFNqiL65FtXm+DLdQ=; b=uLYMyW6hWRqcGLS4AAXsPCkul8
	A4XxpuFL3/z82Ipzz7oqm8udAlaTFbrECAVR9KHAVLuXE4FiRQlFlkj/p+FKyxAZMiPGBgZwaM/yb
	of9Oe1r/yDZLYIZWhiKzJREaoxCMN1/0FWvOF3VP+n54IceYeAwU8gvRjItHbaipXVDQPndyq/lPD
	FcAbbbsWfxe09g1Az/OdS6zzTeq4cQs93eqqKjbxmP3OLX4grebucjG1wgTYYqSfTpxC/bpPgAiI1
	5wnqfVgdEdHpMDOJJ5H4lUxqTCTVzbmFOsjz/qG0C1M3vNguNu/04QU2NNwb9awcG4QspbXSWcadp
	r6PdNG+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6JwP-002caZ-EO; Fri, 16 Dec 2022 23:16:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6JwN-002cZ4-5T
	for linux-nvme@lists.infradead.org; Fri, 16 Dec 2022 23:16:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6955F621A5;
	Fri, 16 Dec 2022 23:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2A5C433EF;
	Fri, 16 Dec 2022 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671232589;
	bh=OkjR+gsYNlyq01tAZ16Vmmdu9E65bis2c6Jzu87Mtw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxztpvnxjKPvXJNSS+M7ai6QPfS1fsJYak0FNDQb3IaT7DuGNuwouamZdBTg/CsPf
	 QPTIPTvjemOu8gfr80RcNAa277xRTlNakxCC3EuvDaBDmYF4D8U76F4JrVezMLcBWl
	 XypgJnzeBaXXiJfccjfz51zwqo8vZHDU5PP68lTsyRhNwXVLCe5gcG5xYCI5FCVKxg
	 r3kycBTjqrJA3kf1fUeqCdf6Qb/cROHoYtfQDE5WZOd4PyTjoOlQYVHknOpa+IFSvu
	 sFdZ63GNeHo8LsyoJ8dTBrP2ZAGCD749b7kNiMaFcTcbNdapBrqBSJoMxhomEs3HbN
	 gmYMLOk7Hlcvg==
Date: Fri, 16 Dec 2022 16:16:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_151631_262104_7BCAD16E 
X-CRM114-Status: GOOD (  10.42  )
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

On Thu, Dec 15, 2022 at 10:38:33AM +0900, J. Hart wrote:
> 02:00.0 Non-Volatile memory controller: Kingston Technologies Device 500f
> (rev 03) (prog-if 02)
>         Subsystem: Kingston Technologies Device 500f
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at ef9fc000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
>         Kernel driver in use: nvme

Seems odd that the nvme driver is in use, but MSI/MSI-x are not. We
really don't have a lot of testing with legacy IRQ.

Could you add the output from 'lspci -vvv -s 02:00.0'?
 
> CPU (quad core, cpu 0 shown, others the same):
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 23
> model name	: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
> stepping	: 7

That's a pretty old processor for an M.2 slotted drive. Are you using a
retimer or some type of AIC adapter card?

