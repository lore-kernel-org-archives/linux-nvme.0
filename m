Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C67EE6ADCA
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 22:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=U4WWmttoadv/y/rm/5ZDeqBXWNESZEXvli09CekTCzs=; b=LM2+b9qvjJCcxV
	WWdc6KYMyUbvytjuPuHpHifSE/M1RSHucpSvn3RfhaJdmocg4xqGRGamGJrIEHkffJDB1inhVLtao
	E7VLrdCGYdOqP0bjihbmeNK1Z8Y0etnPyvw+gV30TUS7CavrPUmJ2z7ocbqbsXUeo5LJSHiC3Nbbp
	ErXfalCkOKBz9FambmQo2lrKqLbmQVb2QuuJiCVxgI9PbZtQFRPDyo6j+nnqkt8BfzyXryHNf0E4+
	Lt2jnk5sxx/FgPVtsEvG7hjPf0dSTda983mZEvaNMPPWYbF4YJbKU+uNW3jWmch87FSsg1s0M6Svc
	olsnu6aJi1RjurPIoJVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEc1H-00000003PSn-2ybY;
	Fri, 22 Nov 2024 22:20:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEc1F-00000003PR3-0nAO
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 22:20:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 23117A41813;
	Fri, 22 Nov 2024 22:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEF9C4CECE;
	Fri, 22 Nov 2024 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314052;
	bh=TDoD+lOCxLL6fD8iEhwdRn95Pj9mWgTMDjgMOuci1bI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BE9n+TDB06+cbTv4npSy9jlp4wRibJIPfyJTme6OgdI69fT2wzJQoGyDbiZsE/Gf3
	 RStKNEJ8+BcJenqy9K6Im0bc2Uk5PhQdef9qb/UUK9VFFkMYJyCxnshBddkyi3VJGN
	 wd3wg4OLyu9xzqu79o6tbSxMQdWv47QDWhv42Om5tw84iiPrJ2Vd7sDQc8buds74uB
	 FoSG4xxR9Y50nMJ29kb25XayBuTK4FjTZloxXvZ2XsYFbrmcRGN1Ihg8TdSUDLkrCT
	 eDM+Z1fqVzDaHn2SKMqwaRJ773cq+NTjmK6lucdswbn9QiaacDECtccBy/xWJfESed
	 RT6K9JXbPqbCA==
Date: Fri, 22 Nov 2024 16:20:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241122222050.GA2444028@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_142053_360169_0BA696DB 
X-CRM114-Status: GOOD (  31.76  )
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

[+cc Rafael]

On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> PCI core allows users to configure the D3Cold state for each PCI device
> through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> to allow/disallow the PCI devices to enter D3Cold during system suspend.
>
> So make use of this flag in the NVMe driver to shutdown the NVMe device
> during system suspend if the user has allowed D3Cold for the device.
> Existing checks in the NVMe driver decide whether to shut down the device
> (based on platform/device limitations), so use this flag as the last resort
> to keep the existing behavior.
> 
> The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> D3Cold and the users can disallow it through sysfs if they want.

What problem does this solve?  I guess there must be a case where
suspend leaves NVMe in a higher power state than you want?

What does it mean that this is the "last resort to keep the existing
behavior"?  All the checks are OR'd together and none have side
effects, so the order doesn't really matter.  It changes the existing
behavior *unless* the user has explicitly cleared d3cold_allowed via
sysfs.

pdev->d3cold_allowed is set by default, so I guess this change means
that unless the user clears d3cold_allowed, we let the PCI core decide
the suspend state instead of managing it directly in nvme_suspend()?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4b9fda0b1d9a..a4d4687854bf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
>  	 */
>  	if (pm_suspend_via_firmware() || !ctrl->npss ||
>  	    !pcie_aspm_enabled(pdev) ||
> -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> +	    pdev->d3cold_allowed)
>  		return nvme_disable_prepare_reset(ndev, true);

I guess your intent is that if users prevent use of D3cold via sysfs,
we'll use the NVMe-specific power states, and otherwise, the PCI core
will decide?

I think returning 0 here means the PCI core decides what state to use
in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
could be any state from D0 to D3cold depending on platform support and
wakeup considerations (see pci_target_state()).

I'm not sure the use of pdev->d3cold_allowed here really expresses
your underlying intent.  It suggests that you're really hoping for
D3cold, but that's only a possibility if firmware supports it, and we
have no visibility into that here.

It also seems contrary to the earlier comment that suggests we prefer
host managed nvme power settings:

  * The platform does not remove power for a kernel managed suspend so
  * use host managed nvme power settings for lowest idle power if
  * possible. This should have quicker resume latency than a full device
  * shutdown.  But if the firmware is involved after the suspend or the
  * device does not support any non-default power states, shut down the
  * device fully.

Bjorn

