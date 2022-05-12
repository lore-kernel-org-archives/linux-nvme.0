Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38419C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzOrW+pH12sN66rHYXdUUY4rSp1YeYm/xwvJTXYqGRU=; b=CyEhKJ27UYASqF8aclyNQzzoH+
	e+l/NNlufcdroNkvEjeGW+bxek2k/kAztmyBmMWn0er+FJC9LIU9S8jb6DlxUcksHRF/Ta/DcS9B4
	1D3Pj5+9fa/0NRa81wtgSiAgoLV7i4cSDGDvLeirf/iwEi7Ts8UoINqNb3gXp2zK0WOZ9P18ZS+e5
	CLI485ajiPENQAKx3+p1/4h+5MKaic3Qe/JOmYppIesFKy2VaEW6PcYRx5oB3VJMyIMiT7+DL/P+Z
	cCwxfKNt1FqIPpt+bDfQ+/y8AI6Sjil5Rtj+nxwK6efwiaQ8MknGhCbpSAyk5Z88RfEu70hTXoJJk
	IUSh0p9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np9sN-00CPbW-Rn; Thu, 12 May 2022 14:33:11 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np9sJ-00CPYL-G7
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 14:33:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 533C1B818CD;
 Thu, 12 May 2022 14:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E71EC34114;
 Thu, 12 May 2022 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652365984;
 bh=sfcTKaUi98E7OC/j3iFh3YtytfrCxmTHiMc7UvH7bss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dMpIhhu2NwOLnZmMOauzb/gaBAS71QcoMrZ0ckcYHH/BilWW8OF7P7xONL1aKKeOM
 qKmNhDN+j/383T6nKxKmTfgfIuHmyEyZy2+YULBjP0MyK55qXEqHrI79zfxMLpIea9
 BwPiJ5x1b08B7LTiInkwqVgiQEojD3RubHn8LEvUnfru6cBUTApbHhqLHNnmjewS2Y
 hglWvgI7lX4g1E8DjMx13DOz4joP8zEgjWcwhtamqQu9wp6zYWDEIbJkxEkJ1E6Gp5
 ZnZIe62+kQ9r903JdJ1x6P6nQ/hJKfx6aZ+dWqP6rwsBVCDsPHygyAMhFlMDE9fUKj
 cdhO+ilSyGjkg==
Date: Thu, 12 May 2022 08:33:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Roese <sr@denx.de>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Message-ID: <Yn0anJBHcSd1K2tM@kbusch-mbp.dhcp.thefacebook.com>
References: <20220506101534.1728011-1-sr@denx.de>
 <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_073307_874364_948954CE 
X-CRM114-Status: GOOD (  33.42  )
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

On Thu, May 12, 2022 at 04:03:39PM +0300, Max Gurtovoy wrote:
> On 5/6/2022 1:15 PM, Stefan Roese wrote:
> > On our ZynqMP system we observe, that a NVMe drive that resets itself
> > while doing a firmware update causes a Kernel crash like this:
> > 
> > [ 67.720772] pcieport 0000:02:02.0: pciehp: Slot(2): Link Down
> > [ 67.720783] pcieport 0000:02:02.0: pciehp: Slot(2): Card not present
> > [ 67.720795] nvme 0000:04:00.0: PME# disabled
> > [ 67.720849] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> > [ 67.720853] nwl-pcie fd0e0000.pcie: Slave error
> > 
> > Analysis: When nvme_dev_disable() is called because of this PCIe hotplug
> > event, pci_is_enabled() is still true. And accessing the NVMe drive
> > which is currently not available as it's in reboot process causes this
> > "synchronous external abort" on this ARM64 platform.
> > 
> > This patch adds the pci_device_is_present() check as well, which returns
> > false in this "Card not present" hot-plug case. With this change, the
> > NVMe driver does not try to access the NVMe registers any more and the
> > FW update finishes without any problems.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/nvme/host/pci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 97afeb898b25..c764a2a1d7f1 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2473,7 +2473,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >   	mutex_lock(&dev->shutdown_lock);
> > -	if (pci_is_enabled(pdev)) {
> > +	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
> 
> sound weird to me that pci device can be enabled but not present.

pci_is_enabled() just checks a driver reference count. It doesn't actually
query the physical status of the device's link it references, but
pci_device_is_present() will do that.
 
> Also why we get hot unplug event for FW upgrade ?

It might happen if the device requires a Subsystem Reset to activate the new
firmware.
 
> is this the correct behavior ?

I don't know if the "synchronous external abort" is normal, or how severe of a
problem it indicates, but we normally expect accessing registers on an
inaccessible device to be mostly harmless.

> >   		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >   		if (dev->ctrl.state == NVME_CTRL_LIVE ||

