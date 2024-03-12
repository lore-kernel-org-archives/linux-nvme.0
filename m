Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DB4C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1wroYe6vs9yOLhgjBeWQhTGD8bBqaiy7yvVumdXAYk=; b=DUXECl+ezIUv4Kx3LhHcAuvvxm
	5ec18zt1vPeymgIle4d9ndi3AAWnB/BMVVNs3Ew+LXWbnbxNFUnZeC6PwSXlSUal5qFlZM5xBwOF8
	7ojLcHvZv4epErRb0MeTE+qMcGJFfS6gFcZxtpS+ICLkTQplTmedAtEcmJzL9zAUp8o7Ylwv7WXns
	i7/lp35MxmpUUHiFSl9NIpEPY5dmUxXrAev1DzzBJlI3/jL/13A068+0jWeE9B1B7liSKCxJAX+mP
	YgL+I3ifZ8RnEZK+4TmymLyYwFAxcETV+iSB7Qx5Ah2ELHr6RcN/B7aKTxFBWoI2FCkfhYxULDFSn
	PBtQPfhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk394-00000006860-1BAn;
	Tue, 12 Mar 2024 14:30:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk390-00000006843-3Ns3
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 14:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F1E0FCE180A;
	Tue, 12 Mar 2024 14:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE9C3278E;
	Tue, 12 Mar 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253810;
	bh=5ZRONL4SZlpcFHCp/QRQUWuu5UjWMRjepJDC44EFnbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqQT4erY+VvgRNM7cLdPyPLVPIdW53p7E0r6LGAoI2TN7EXUPWurLD8t9zkoHd742
	 yympcqKkyuiDC+ssxuOTX69i4v2QVB5Bfxh1tzh6kzFznyRLMT/gvHyqy9FGNtfs8y
	 QV57LBq5RW2uiQYMOd46qyK810vZVZJBVhqLlMk/2Qqef244ua2IKZq2SwuGkvUFKO
	 Es20B4F3XXxAh0hjNY/xSz7JOREqZfDF0J70YLmF9XA/eu+TUgQDnhcvOLq+d78P9K
	 YYdVmxe6MnNpR8T1dD0Ya1Nv7K6TM0e3cHtsBoQ2hDS9YjiYwz2GQPzPl/S8iyhVgS
	 zO7UVlRvcOyQA==
Date: Tue, 12 Mar 2024 08:30:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZfBm72xPozFN99GA@kbusch-mbp.mynextlight.net>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
 <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
 <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_073019_328900_26BA5E24 
X-CRM114-Status: GOOD (  21.46  )
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

On Mon, Mar 11, 2024 at 06:28:21PM +0530, Nilay Shroff wrote:
> @@ -3295,10 +3304,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>         case pci_channel_io_frozen:
>                 dev_warn(dev->ctrl.device,
>                         "frozen state error detected, reset controller\n");
> -               if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -                       nvme_dev_disable(dev, true);
> -                       return PCI_ERS_RESULT_DISCONNECT;
> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> +                       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +                               nvme_dev_disable(dev, true);
> +                               return PCI_ERS_RESULT_DISCONNECT;
> +                       }
>                 }
> +               flush_work(&dev->ctrl.reset_work);

I was messing with a similar idea. I wasn't sure if EEH calls the error
handler inline with the error, in which case this would try to flush the
work within the same work, which obviously doesn't work. As long as its
called from a different thread, then this should be fine.

>                 nvme_dev_disable(dev, false);
>                 return PCI_ERS_RESULT_NEED_RESET;
>         case pci_channel_io_perm_failure:
> 
> The flush_work() would ensure that we don't disable the ctrl if reset_work 
> is running. If the rest_work is *not* running currently then flush_work() should
> return immediately. Moreover, if reset_work is scheduled or start running after
> flush_work() returns then reset_work should not be able to get upto the CONNECTING
> state because pci recovery is in progress and so it should fail early.
> 
> On the reset_work side other than detecting pci error recovery, I think we also 
> need one another change where in case the ctrl state is set to CONNECTING and we 
> detect the pci error recovery in progress then before returning from the reset_work
> we set the ctrl state to RESETTING so that error_detected() could forward progress.
> The changes should be something as below:
> 
> @@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
>   out_unlock:
>         mutex_unlock(&dev->shutdown_lock);
>   out:
> +       /*
> +        * If PCI recovery is ongoing then let it finish first
> +        */
> +       if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +               dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
> +                       WRITE_ONCE(dev->ctrl.state, NVME_CTRL_RESETTING);

This may break the state machine, like if the device was hot removed
during all this error handling. This will force the state back to
RESETTING when it should be DEAD.

I think what you need is just allow a controller to reset from a
connecting state. Have to be careful that wouldn't break any other
expectations, though.

