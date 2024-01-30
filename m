Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAABDC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NGnHNzPrVqW67EgshrEhAlvRfR/EZ95/jS3w2g6xPHI=; b=z+eJZeabzHcreIL4M2UdIP8Kmh
	2kIr+hfxrupypT3jR3LFDRwqxiiq/wFixWlHpzNAkvtX1lt8IDtri21c0Oyl566MKJ61rUomvYsZh
	kXyOqeLFWLVk959aeXWXWJ/75TcBmAjlldz1F2jV9JZWHuyRFpv8eY3+6gBpG+za0u5h6oXENOASW
	VGpvJaZ22MOwv6pljC2jnZZboTtWahhn6fOVX3TJSIxudR8ZtZ46lHHh0/zFPSTOo1fVHYm6v/0Vd
	djO4UF8lHVhxkYr1tlQb1anwVUrjZG2lejXNUG2yvf2pKK2NBbANTt3nf7fBqEen3SFhyEfIu7xWy
	+ns8J7LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUtFO-00000000EEO-2zjj;
	Tue, 30 Jan 2024 18:54:14 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUtFM-00000000EDu-1SPR
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 18:54:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=NGnHNzPrVqW67EgshrEhAlvRfR/EZ95/jS3w2g6xPHI=; b=LSXsYbK6hUezV0vQzNeACp0V50
	OUSCF1pZVruMPhTro60c8zb1UOxiTWhXxhRPPvdo+vpwCuwOidyfFWwXfkSUZuxd0PU25F6egtAHu
	2rv6Ae37K9PhUTJFtI+AoMCIkTJ7tVv7wu9j37StLQmMfxtephjke88IW4J9mnmwDxiIKSmLkoKX3
	yNJHLQv6FMt9sUA0rQcC9qQwyPyDyLxISSyXycVWomwdAGMOmQZu8abLPXT1EdWkladLYLvt+B4Yi
	UYjciB7IYReh9492g7qu4F02ybqbG3OGFkZv+KXkoBfAttTmlT17xHW1l3FRWC9INWjUGyF8NKvDO
	Y/pUaX82SoBxuI8Tz2HvZnaGqpgDsBllP66z5N3NpictIWCeuZQirlBNcnHT/d8PiOa5QUY2OOlsw
	6wm316lZhEyTQ+rwCwBHug4GR5w5kvIpVy7O4JgMjzUg/kxNxDHgncn/IVyc5wmltuuZxKltauxXe
	Dojbh0qEquIo3EjewT2sl93j;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rUtFH-00Ae5T-1f;
	Tue, 30 Jan 2024 18:54:07 +0000
Date: Tue, 30 Jan 2024 10:54:03 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 5/5] nvme: Add two-pass shutdown support.
Message-ID: <ZblFyyVmduZMf0XW@jeremy-HP-Z840-Workstation>
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-6-jallison@ciq.com>
 <2639d18a-0cfd-4449-8caa-4d363c788d64@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2639d18a-0cfd-4449-8caa-4d363c788d64@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_105412_414893_0A28A854 
X-CRM114-Status: GOOD (  19.80  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 30, 2024 at 01:15:43PM +0200, Sagi Grimberg wrote:
>
>>This works with the two-pass shutdown mechanism setup for the PCI
>>drivers and participates to provide the shutdown_wait
>>method at the pci_driver structure level.
>>
>>This patch changes the nvme shutdown() method to pass
>>down the NVME_PCI_DISABLE_SHUTDOWN_TWOPASS enum value instead
>>of NVME_PCI_DISABLE_SHUTDOWN. nvme_dev_disable() is changed
>>to call nvme_request_shutdown() instead of nvme_disable_ctrl()
>>in this case.
>>
>>nvme_request_shutdown() sets the shutdown bit,
>>but does not wait for completion.
>>
>>The nvme_shutdown_wait() callback is added to synchronously
>>wait for the NVME_CSTS_SHST_CMPLT bit meaning the nvme
>>device has shutdown.
>>
>>This change speeds up the shutdown in a system which hosts
>>many controllers.
>>
>>Based on work by Tanjore Suresh <tansuresh@google.com>
>>
>>Signed-off-by: Jeremy Allison <jallison@ciq.com>
>>---
>>  drivers/nvme/host/pci.c | 39 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 36 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>index 8ee77f755d9d..bbd89eecf05a 100644
>>--- a/drivers/nvme/host/pci.c
>>+++ b/drivers/nvme/host/pci.c
>>@@ -2607,7 +2607,14 @@ static void nvme_dev_disable(struct nvme_dev *dev,
>>  	if (!dead && dev->ctrl.queue_count > 0) {
>>  		nvme_delete_io_queues(dev);
>>-		nvme_disable_ctrl(&dev->ctrl, shutdown);
>>+		/*
>>+		 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS requests shutdown
>>+		 * but doesn't wait for completion.
>>+		 */
>>+		if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN_TWOPASS)
>>+			nvme_request_shutdown(&dev->ctrl);
>>+		else
>>+			nvme_disable_ctrl(&dev->ctrl, shutdown);
>>  		nvme_poll_irqdisable(&dev->queues[0]);
>>  	}
>>  	nvme_suspend_io_queues(dev);
>>@@ -2625,7 +2632,7 @@ static void nvme_dev_disable(struct nvme_dev *dev,
>>  	 * must flush all entered requests to their failed completion to avoid
>>  	 * deadlocking blk-mq hot-cpu notifier.
>>  	 */
>>-	if (shutdown) {
>>+	if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN) {
>>  		nvme_unquiesce_io_queues(&dev->ctrl);
>>  		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
>>  			nvme_unquiesce_admin_queue(&dev->ctrl);
>>@@ -3128,7 +3135,32 @@ static void nvme_shutdown(struct pci_dev *pdev)
>>  {
>>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>>-	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN);
>>+	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN_TWOPASS);
>>+}
>>+
>>+static void nvme_shutdown_wait(struct pci_dev *pdev)
>>+{
>>+	struct nvme_dev *dev = pci_get_drvdata(pdev);
>>+
>>+	mutex_lock(&dev->shutdown_lock);
>
>General question that just came up, is there any risk here that the
>shutdown_lock is released and re-taken later while the shutdown is 
>still in progress? I don't spot anything immediate, but perhaps Keith 
>can
>comment?

My gut feel (not knowing the kernel nearly as well as Samba
of course :-) is that this isn't a problem.

But that's because this two-stage code path of:

mutex_lock(&dev->shutdown_lock);
..
	set device shutdown bit NVME_CC_SHN_NORMAL
..
mutex_unlock(&dev->shutdown_lock);

followed by:

mutex_lock(&dev->shutdown_lock);
..
	wait for shutdown bit NVME_CSTS_SHST_CMPLT
..
mutex_unlock(&dev->shutdown_lock);

Is only invoked on the shutdown() method of
the nvme device. At this point the system is
going down and user-space processes are already
terminated.

Also the device has been removed from the
devices_kset list under a lock and the operations
are being done under a device_lock(dev).

So I can't see what other things could
go wrong with the two-stage approach.

Happy to learn if I'm wrong though :-).

>If this change does expose us to potential issues, you can simply
>release the shutdown_lock here (while taking it in ?

You appear to have accidently a word here :-).

