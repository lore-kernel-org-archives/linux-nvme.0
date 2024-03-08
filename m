Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83250C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXAB6e985i8rWZdCNlTwweEPS4KgxQODiAoYz9x9TRQ=; b=WR0/gd+h4G2urmUGF8m1WTuBob
	gs9g9uuuzsocOMBdvIC5fPFT1u3XdoyxYUwhI+ckktXeZXkwlOBbtkQyW0UhZeaXgk9ZOEvvsuNWQ
	68gURqCUqh4NGHu4+YqfA3W0BT5gYTq/KWysjbNfJQI4MOrS1mkg8FWVANYFYwIIGt/1c8Ob5YPS0
	2gr+T//f+uNnDFNO46QBjGP4yQnxl5mmMpepuVuifbr0+sICVVz7dez2Cph5JTIgW7EB58iYB8OnC
	YLwKhBJQVBtiIWkTuc0Xprp+580F50RKKSmJ8rtvfGyx3r7q6UVUkSVuWkGhqZ908ZPJKvL4TnolX
	gzylfWXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricM0-00000009wTn-1gnj;
	Fri, 08 Mar 2024 15:41:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricLt-00000009wQe-1NnY
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 15:41:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7B19ECE28E9;
	Fri,  8 Mar 2024 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450B0C433F1;
	Fri,  8 Mar 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709912494;
	bh=qgXTjEzUbSTzezT+CcIL+WmyphEt5BFFhf/YzdxcgqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfHAwg2yH4N32Qj5Q2F+aPCXZiWcHTF46B79a6q9Yls/qI7a/I9caKdDaXn/ZomIO
	 n2iKAnFhXOYVOkhBktvLEw3eJ8MLa2DwOkFnHrY58IwJYIEqdZ5v6hlLaaiea0BN/9
	 yhDv3u0oSDKC2shoIyBKfTc2widgw5dLha7Bzzs1xaEyxleQk27aQilV2Uc/MKMipR
	 8mmaJ7Sswjj2oqiSWPXrp7MQITjI1cwsOq76eIF4liF3u/P0tDe9vM9guYASI7t0fh
	 JsoeNPtHgnTisBa6KGL9Ht9AZf0tkCWSoQwkKQ+lBe6BFDXhRrHY1W5r+0SeHtffM+
	 5DC+wCSGNoR9A==
Date: Fri, 8 Mar 2024 08:41:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Zesxq81eJTnOGniB@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209050342.406184-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_074141_832528_DDFBAC56 
X-CRM114-Status: GOOD (  19.84  )
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

On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
>   out_unlock:
>  	mutex_unlock(&dev->shutdown_lock);
>   out:
> +	/*
> +	 * If PCI recovery is ongoing then let it finish first
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>  	 * may be holding this pci_dev's device lock.
> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  	case pci_channel_io_frozen:
>  		dev_warn(dev->ctrl.device,
>  			"frozen state error detected, reset controller\n");
> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -			nvme_dev_disable(dev, true);
> -			return PCI_ERS_RESULT_DISCONNECT;
> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +				nvme_dev_disable(dev, true);
> +				return PCI_ERS_RESULT_DISCONNECT;
> +			}
>  		}
>  		nvme_dev_disable(dev, false);
>  		return PCI_ERS_RESULT_NEED_RESET;

I get what you're trying to do, but it looks racy. The reset_work may
finish before pci sets channel offline, or the error handling work
happens to see RESETTING state, but then transitions to CONNECTING state
after and deadlocks on the '.resume()' side. You are counting on a very
specific sequence tied to the PCIe error handling module, and maybe you
are able to count on that sequence for your platform in this unique
scenario, but these link errors could happen anytime.

And nvme subsystem reset is just odd, it's not clear how it was intended
to be handled. It takes the links down so seems like it requires
re-enumeration from a pcie hotplug driver, and that's kind of how it was
expected to work here, but your platform has a special way to contain
the link event and bring things back up the way they were before. And
the fact you *require* IO to be in flight just so the timeout handler
can dispatch a non-posted transaction 30 seconds later to trigger EEH is
also odd. Why can't EEH just detect the link down event directly?

This driver unfortunately doesn't handle errors during a reset well.
Trying to handle that has been problematic, so the driver just bails if
anything goes wrong at this critical initialization point. Maybe we need
to address the reset/initialization failure handling more generically
and delegate the teardown or retry decision to something else. Messing
with that is pretty fragile right now, though.

Or you could just re-enumerate the slot.

I don't know, sorry my message is not really helping much to get this
fixed.

