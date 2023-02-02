Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE1C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1ysYnCJI7O0MYof8n5U2atjCOSgtIBlzFDepXbZtOE=; b=1y4PQ9NYTT/Co9VwIqKIAINhiG
	OHiDTDyOI0cFn+J7TKeDfCX4YjWgmcfm0Xk81LTHMuDgKcTyzM8Un9ic6yf+712ncGlx9kY+/Iae3
	n5lWNuvChZ5f/kJk9iPUq8ZXVCziel5EfBXjUGpGbyJIgikJA8Ao7aOBMx6ehHJmYXZxLwVtHWiia
	ztBjgJAHxjEnmp2cr/AFPHZQ5EIoZbYtItg+K4Ak1BH0EyzC41w550xyYnRhzmSMGsxLHJDhlLzpl
	3cWf9nZrWrAiiHsJpHWWnDbWNQi8A2e7POJVi8RZy2CCmmFJ92NnuxaBM5WrkdOqE9rWmKT5Wd9UO
	juY0vMLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNfV3-00H5Zr-2q; Thu, 02 Feb 2023 19:44:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNfV0-00H5YR-1Z
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 19:43:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8BE261CC4;
	Thu,  2 Feb 2023 19:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94DFC433D2;
	Thu,  2 Feb 2023 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675367033;
	bh=itc3UzliAzjsR5O1/e1SVhNawXZKWfGYsx7aw+oqWrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vM7x+EgeyD7yjA6GP5u6FjEboSxJ/kJ+yKezqI0BR8e2MF4CuSAqdtJubPGq8oTXn
	 YR4UAjpPEFobH+ewieOZ56quy7bzPrEb+9V8Yz12Ce5PcrnlxlNxqu9snG02N2W4va
	 +VT/KFrNmOI2/9R2VzyWZitLQVJMDKxyjGae6g2Z2X5Uy+Pt7VHBQXomnPNiMr83Zx
	 AdwdxP4bQvpZ3+3H38xv4aeOwgvR8QPxCjc2OR5M3UOu+J6vJ7kIj01rTt0Ko+/rGx
	 i1HYUJzwettWZ4ErDWizWpjPHEm128vni2s3NjHx7Q4tM8ENgtui0BKVICxeHAp/BS
	 lUFrnbP93SGOA==
Date: Thu, 2 Feb 2023 12:43:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
 <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_114358_200470_8AF46FF8 
X-CRM114-Status: GOOD (  14.53  )
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

On Thu, Feb 02, 2023 at 06:47:35PM +0000, Grochowski, Maciej wrote:
> > I've been trying to look for this code in latest upstream and it has changed entirely.  Any chance you could do a quick run with Linux 6.1?
> 
> It gave me the result as on older kernel: failure in power state change and device disappeared after test (logs below)
> ```
> [  365.052300] pcieport 0000:00:03.4: aer_inject: Injecting errors 00000000/00004000 into device 0000:0b:00.0
> [  365.062200] pcieport 0000:00:03.4: AER: Uncorrected (Fatal) error received: 0000:0b:00.0
> [  365.070439] nvme 0000:0b:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
> [  365.081824] pcieport 0000:00:03.4: AER: broadcast error_detected message
> [  365.088635] nvme nvme5: frozen state error detected, reset controller
> [  365.157742] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 0
> [  366.205193] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 1008
> [  366.213394] pcieport 0000:00:03.4: AER: Root Port link has been reset (0)
> [  366.220312] pcieport 0000:00:03.4: AER: broadcast slot_reset message
> [  366.226771] nvme nvme5: restart after slot reset
> [  366.232018] pcieport 0000:00:03.4: re-enabling LTR
> [  366.239088] nvme 0000:0b:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x10a)  
> ...
> [  366.994113] nvme 0000:0b:00.0: restoring config space at offset 0x8 (was 0xffffffff, writing 0x1080200)
> [  367.003924] nvme 0000:0b:00.0: restoring config space at offset 0x4 (was 0xffffffff, writing 0x100406)
> [  367.013663] nvme 0000:0b:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0xa80a144d)
> [  367.023595] pcieport 0000:00:03.4: AER: broadcast resume message
> [  367.045269] nvme 0000:0b:00.0: Unable to change power state from D3cold to D0, device inaccessible

We'll do a secondary bus reset right before restarting the controller. It
sounds like this particular device isn't recoverying from.

Does the device come back if you manually remove/rescan? Something like this:

  # echo 1 > /sys/bus/pci/devices/0000:0b:00.0/remove
  # echo 1 > /sys/bus/pci/rescan

