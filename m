Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1481BC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QmmuKKNiBdQ0KUbG3pIPy3TfmXEz0wNIU60P6m34nmE=; b=Pys+FPPKc5p80IUHV0BhuF3brH
	vb+gRBlAJ0j/Ab2JetmFk7nMM3ByLlpGmGyo9Cw9H5OZqzEnAjGOFUWVEPu4oWrxMROZn3uNghdEz
	wWXw0jjNIAmivdOK6QiN06W3W3hkalZB0ODm6R8b98ezb6YS6eT0BSA3SypDHJu+20DvV1lbYWhsT
	kRfmDH1OCN7OZbQGoM7fve8fpAcU83rLfijjlLOmRGoM6nxIm+t4RpwthLRZIsp0C7OTc/+V1F7FO
	lDJL7aeH0xR2JPkXlo4sYPKGMhKfpuWkvRMwZE2wjq3z9sMgKID7/f4tyIrayaBjIvK+KuTu5B67U
	wDtOQwmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGGe-00BWEL-Ja; Tue, 12 Jul 2022 13:49:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGGb-00BWB4-Ci
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 13:49:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13E331FDBD;
	Tue, 12 Jul 2022 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657633770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmmuKKNiBdQ0KUbG3pIPy3TfmXEz0wNIU60P6m34nmE=;
	b=BGeN7IcAxMHk4hL1SWY5FBLhqoHvxraIGKwcRVtW60lLobLt6LbZb9ci/wMoAS1hldPOB4
	5o6xBRzXLzy4JRD3jT9aepUvWNeWF6APjlBc9LJXS6UQUrfXCp8LbdXKnIguVi7oNkt63g
	dZzMQoDNcuypwWo97T6NLCdb/mfNnsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657633770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmmuKKNiBdQ0KUbG3pIPy3TfmXEz0wNIU60P6m34nmE=;
	b=QQhIj2Meq9t87wCox/tOvvqyZq5wygS2bcI1vemCROaPgRxtyC4sDXW6rODz5fN5cFwBma
	HmwY5nBqFtjAcwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC22313A94;
	Tue, 12 Jul 2022 13:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ft/YNOl7zWLsTQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Jul 2022 13:49:29 +0000
Message-ID: <39098f08-696d-db4c-36ac-1199da95bc7c@suse.de>
Date: Tue, 12 Jul 2022 15:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the PCI
 device is isolated
Content-Language: en-US
To: Niklas Schnelle <schnelle@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
 <20220712124453.2227362-2-schnelle@linux.ibm.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220712124453.2227362-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_064933_631498_0CE06F9B 
X-CRM114-Status: GOOD (  24.90  )
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

On 7/12/22 14:44, Niklas Schnelle wrote:
> On s390 and powerpc PCI devices are isolated when an error is detected
> and driver->err_handler->error_detected is called with an inaccessible
> PCI device and PCI channel state set to pci_channel_io_frozen
> (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
> 
> In the case of NVMe devices nvme_error_detected() then calls
> nvme_dev_disable(dev, false) and requests a reset. After a successful
> reset the device is accessible again and nvme_slot_reset() resets the
> controller and queues nvme_reset_work() which then recovers the
> controller.
> 
> Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
> nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
> queues if pci_device_is_present() returns false. This is the case for an
> isolated PCI device. In principle this makes sense as there are no
> accessible hardware queues to run. The problem though is that for
> a previously live reset controller with online queues nvme_reset_work()
> calls nvme_wait_freeze() which, without the freeze having been
> initiated, then hangs forever. Fix this by starting the freeze in
> nvme_slot_reset() which is the earliest point where we know the device
> should be accessible again.
> 
> Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 193b44755662..7c0c61b74c30 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3399,6 +3399,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
>   	dev_info(dev->ctrl.device, "restart after slot reset\n");
>   	pci_restore_state(pdev);
>   	nvme_reset_ctrl(&dev->ctrl);
> +	nvme_start_freeze(&dev->ctrl);
>   	return PCI_ERS_RESULT_RECOVERED;
>   }
>   
I am not sure if that's the right fix.
 From your description the hang occurs as nvme_reset_ctrl() is calling 
nvme_wait_freeze() without an corresponding nvme_start_freeze().
So why are you calling it _after_ the call to nvme_reset_ctrl()?

Cheers,

Hannes

