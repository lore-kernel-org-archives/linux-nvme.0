Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ACDC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9tot3sfP2cWwBglwO81bHaRCGz6HR+/f+bFJ3D1WDk=; b=j3BVICWrmAjlIACCDX2VjEtBOD
	1/rnJGqlGRu7NuqiiWIWF0urhcYOv/rW5XuvJfwDNNqYHgVazoxvnq0/dRb2aPc1mWhHsHcCoJJGm
	SttakKJOk4MOK5ZXUpZRkYuEmMU9oXsZ/P3yFKiYOfoM5+DZBXcHtZbmWm8wQlZN5BDojyAr/zWEa
	wTshVAbgFOI/c0d+AZSQPu6yL4hcmXqa7Ms1WbSXYgWInKCWO02jkgti1Rc2J657smQQHE0jzIDbr
	yYb/2rgYLRdWq0pqKoMMXi4LwFs9yZxjBgQoDA/l9eGVYsDlxcaq56Acw17sRrXWftenxYlR73rKO
	IvKXNDKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDN60-00C8dD-VD; Mon, 18 Jul 2022 09:31:20 +0000
Received: from mout-u-107.mailbox.org ([80.241.59.207])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDN5x-00C8Zq-E8
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 09:31:19 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4LmcCM6mlzz9sWT;
	Mon, 18 Jul 2022 11:30:55 +0200 (CEST)
Message-ID: <f9a57983-0fda-9f94-6d21-e62870ca45ae@denx.de>
Date: Mon, 18 Jul 2022 11:30:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the PCI
 device is isolated
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
 <20220712124453.2227362-2-schnelle@linux.ibm.com>
 <Ys2CeIqv//5ZGJTM@kbusch-mbp>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <Ys2CeIqv//5ZGJTM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_023117_681607_E21D5AF0 
X-CRM114-Status: GOOD (  26.01  )
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

On 12.07.22 16:17, Keith Busch wrote:
> On Tue, Jul 12, 2022 at 02:44:53PM +0200, Niklas Schnelle wrote:
>> On s390 and powerpc PCI devices are isolated when an error is detected
>> and driver->err_handler->error_detected is called with an inaccessible
>> PCI device and PCI channel state set to pci_channel_io_frozen
>> (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
>>
>> In the case of NVMe devices nvme_error_detected() then calls
>> nvme_dev_disable(dev, false) and requests a reset. After a successful
>> reset the device is accessible again and nvme_slot_reset() resets the
>> controller and queues nvme_reset_work() which then recovers the
>> controller.
>>
>> Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
>> nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
>> queues if pci_device_is_present() returns false. This is the case for an
>> isolated PCI device. In principle this makes sense as there are no
>> accessible hardware queues to run. The problem though is that for
>> a previously live reset controller with online queues nvme_reset_work()
>> calls nvme_wait_freeze() which, without the freeze having been
>> initiated, then hangs forever. Fix this by starting the freeze in
>> nvme_slot_reset() which is the earliest point where we know the device
>> should be accessible again.
>>
>> Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Oh, we've messed up the expected sequence. The mistaken assumption is a device
> not present means we're about to unbind from it, but it could appear that way
> just for normal error handling and reset, so we need to preserve the previous
> handling.
> 
> The offending commit really just wants to avoid the register access (which we
> shouldn't have to do, but hey, broken hardware...).

Correct.

> So let's keep the sequence
> the same as before and just skip the register read. Does this work for you?
>
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fdfee3e590db..c40e82cee735 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
>   static void nvme_dev_remove_admin(struct nvme_dev *dev)
> @@ -2690,9 +2772,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   
>   	mutex_lock(&dev->shutdown_lock);
> -	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
> -		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	if (pci_is_enabled(pdev)) {
> +		u32 csts = ~0;
>   
> +		if (pci_device_is_present(pdev))
> +			csts = readl(dev->bar + NVME_REG_CSTS);
>   		if (dev->ctrl.state == NVME_CTRL_LIVE ||
>   		    dev->ctrl.state == NVME_CTRL_RESETTING) {
>   			freeze = true;
> --


Thanks. Looks good to me. So if anyone whats to send a proper patch with
this change, feel free to add my:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

