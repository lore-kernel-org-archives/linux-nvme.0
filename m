Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830CFC25B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5p3tdSxzMpD/Wr9oolKIJTZ2ITutxM9KyVoGQpf28Dw=; b=aj8WiVMK5vSs1v7G00hDRpIK/S
	vOE1vTC+1aoSwzxsyZezpsJ0jPmFQvH/y4TFlgNzLoMWJk+0OgF2lvGxxXb7r1vDxFxkvG2xh2Lmw
	gdArhuRttjMVsvqGml4lwtDhySHuVfUhhw3UR8cUwKd7faGngeq66/SygI8FiFsjAz0w8wrZPRoNC
	zw0ZZIIqZUZTS8icF25RyLEDzQHfTJU5JJzdRCW6fDfYLEalMWjS1GqVBZBBEdmSu+WIHa2Noe2CI
	gMdYTxizXryFGwKwCGq+7D5GE8VFlUb3kTB9EcUZXYx0iu9kh2ZIQFlwYEaLivgUkiwBUADDurxnK
	hbuZRckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWNgm-0050Cp-24;
	Wed, 16 Aug 2023 21:04:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWNgj-0050C9-2M
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 21:04:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B252366EED;
	Wed, 16 Aug 2023 21:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0189C433C7;
	Wed, 16 Aug 2023 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219860;
	bh=mMTfeKxGVaY+Llzxiq+JdTAw0bShPwSNTGJpRtPVghU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9BPGJFQQwO12dgLBeIPuJpXSTPAa2GDKIUiYQx/xfKLQw2UgZ7KoJ3Vk5bt6V4or
	 d2o3C11X45pJJiMlwRMwyyrgQCwrA+UDzJxLGbQJbqmdFjdhfC9iLzoYZaef4h2X02
	 zKFtRjYl7gTrjMZ/69YiLq/1vqYwo6QEN1LSQhttjOqRmDs2NP/CcknbiJTc0LuEKU
	 YFlnnxUrmyqNGiFprF5HTH37CB8iyaJmpY6Usqp/YYFbH8VeZJfbfgOf4eiAgXjZ7V
	 +YhWtQTtG8rjemiuXGvqoSHfe/YD9bkzk3Eg07j4tQMCZYnthC7lauH6rZqcVVKVUL
	 TaSU9kNIinIsQ==
Date: Wed, 16 Aug 2023 15:04:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: Possible nvme regression in 6.4.11
Message-ID: <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_140421_843350_489EF521 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Aug 16, 2023 at 04:39:34PM -0400, Genes Lists wrote:
> Also reported to bugzilla [1]
> 
> Failure happens on 1 laptop with samsung ssd.
> 
> Boot log manually transcribed:
> 
> kernel: nvme nvme0: controller is down; will reset: CSTS:0xffffffff,
> PCI_STATUS=0xffff
> kernel: nvme nvme0: Does your device have a faulty power saving mode
> enabled?
> kernel: nvme nvme0: try "nvme_core.default_ps_max_latency_us=0
> pcie_aspm=off" and report a bug
> kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to D0,
> device inaccessible
> kernel: nvme nvme0: Disabling device after reset failure: -19
> mount[353]: mount /sysroot: can't read suprtblock on /dev/nvme0n1p5.
> mount[353]:       dmesg(1) may have more information after failed moutn
> system call.
> kernel: nvme0m1: detected capacity change from 2000409264 to 0
> kernel: EXT4-fs (nvme0n1p5): unable to read superblock
> systemd([1]: sysroot.mount: Mount process exited, code=exited, status=32/n/a
> ...
> 
> All kernels are upstream, untainted and compiled on Arch using:
> 
>  gcc version 13.2.1
> 
> Kernels Tested:
>  - 6.4.10 - works fine
>  - 6.4.11 - fails
>  - 6.5-rc6 - fails
>  - 6.4.11 + nvme_core.default_ps_max_latency_us=0 pcie_aspm=off - fails
>  - 6.4.11 with 1 revert below - fails
> 
>     Revert "nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and
> 512G"
>     This reverts commit 061fbf64825fb47367bbb6e0a528611f08119473.

It sounds like you can recreate this. Since .10 worked and .11 doesn't,
could you bisect the git commits? It looks like it will take 7 steps
between those two versions.

I don't think there are any nvme specific patches that could contribute
to what you're seeing, it's more likely some lower level platform patch
if a kernel change really did cause the regression. None of the recent
commits really stood out to me, so bisect is what I'd recommend.

