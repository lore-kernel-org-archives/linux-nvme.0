Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BAC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556F560FBF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 556F560FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZnNgLqxtslXPCnS1irztaTG6mxGr8ANw13g7wkpPgFo=; b=JxJ3VQ2/Rl5wQN
	C4VHkUeZ5JJrbaqSL6jJaGJeUMtxw0iiqa1CUlM4oBJvjyLGREVdrroKhVnwvJTqmzKDa6LnThCh9
	edOLG2ppmzyXPZ+jXG9fiBO5lSrkmxeK7NK+BesBPSBeWC2r9quzY+7ABsfS10UZXjJz9xCuxtC13
	p3+aH7ykHpd+oq0Y9iwhWHg1qk60QtfANkdCpyNttsgECRkV71rhqULoLI6+WLsINwp7KX7ji9P8e
	MO/i4q5JRemySVfQBHSIp992kVsBrv9WM1FoJN/F9eHsfLKaZfx0EY3v9WF2HZAJquqGu5zEXB7av
	2/mzO2/i/hLURccSDFDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG1lc-002voZ-HT; Tue, 17 Aug 2021 16:16:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG1lZ-002vny-Ge
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 16:16:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78C860FBF;
 Tue, 17 Aug 2021 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629217001;
 bh=EBYGH6hRtooqnI079c6XGEWroZ0teF2V9k2LXqsCqmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uUEcmk35C3XBTpqvhFSayUxnTIIzpcDiXtnTMDIW2xHlHU4/39rgodISFoqdpJMBn
 gTR2PjCq5+PUUnLZFO871nrD1V0uCMrTz/XWDzoFsrNJfioklGtrWVunlT2fy44FTR
 lDGb1QdnR7WoDINd9wvszFWeF4Rh2Bqm4XdVCepF+DzfU0LYJ2ayfB16/mHrK4ZSTC
 LL4Z7KHsqvDA2IJkzfms35b63gv2IzTBeRAEBgeGxlOMuwk926KMJ2O9wqFOSzn3ev
 XHhe1AbHN+aVFswGYcESQ1VwdB9xdiSMRvxMBrU65qcWPNx5ourF5D2NBElkmlmqI3
 Tk5mwRrPyU7Dw==
Date: Tue, 17 Aug 2021 09:16:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_091641_609641_C68E9323 
X-CRM114-Status: GOOD (  15.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 17, 2021 at 05:10:40PM +0200, Paul Menzel wrote:
> On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47
> shows the warning below:
> 
>     $ dmesg | grep nvme
>     [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple suspend
>     [    3.021861] nvme nvme0: pci function 0000:02:00.0
>     [    3.026593] ahci 0000:00:17.0: version 3.0
>     [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps
> 0x1 impl SATA mode
>     [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio
> slum part ems deso sadm sds apst
>     [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
>     [    3.044518] scsi host0: ahci
>     [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
>     [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port
> 0xd1339100 irq 125
>     [    3.058538]  nvme0n1: p1 p2 p3
> 
> Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is it a
> real issues, the manufacturer should fix? If so, do you have SK Hynix
> contacts?

It would be great if device makers would be spec compliant, but the
driver will continue to work with the device the same whether you add
the quirk or not. The quirk just suppresses the nqn check and warning.
Feel free to add it if you don't like seeing the warning message or if
the manufacturer can't resolve the compliance issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
