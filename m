Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE980C04FF8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 20:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=de3+dHvWukTq+foTWR9kJNhz2ENgsX4tjRNUOESHt2A=; b=TSC2zbRfLN7F7d
	vyGCtxgSo3Uyr94iKmARpfuw0BlJX+iLwbP3KaAkvzxyuXmeiL3CxC8S+GNlw8mNQ3uy4rODdv4wW
	3T4HC23Ns/sk8eaBICpKRFuiBl/tqxUauDnHCIHdlVO026o8ZU9sJVl30F+FohLcJ8c0FzUEHeptR
	q8ChVvQZfz5/5/OJoT4m1l+ZCo9QrxciA97Fv3exiIX8y1ZfvVnuhAV2rbpJfXYdsOAXitGGhE+KX
	wzwyxqpf8ehAY/wjwy5mNbsbjgz6YzU9uV2z1/X7/Fjic7NVPz5Am/LnLkJzxtm6cBZEy2Xt4/XXj
	tjYHmsSeY39fuMzvqCoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxYTs-00000003dv0-17C9;
	Thu, 18 Apr 2024 20:35:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxYTo-00000003du9-0cDm
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 20:35:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 37A24CE188C;
	Thu, 18 Apr 2024 20:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22406C113CC;
	Thu, 18 Apr 2024 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713472533;
	bh=/k8CBxtFFxCCrPyB0ZQkRVXX+qR7tZDSRdyejPSOIGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lqMh5SX89qQB4n0qiw+izwaIkIAQ9m5dPQcveLPH9gV04HsYTxKOqyV8WjIy8YPDm
	 BjMiHFMgSW1lLjFpuhr5b/MKyBGNWBuqzUxQDvHB8FONBTMR1Mx9rd/qZtH2C/QJHh
	 T1WQQnf/Fl3i57nr5m7v09tpEhCH5clUGCA+23zY/B/8P4w5LxBpU6NQPtUA59FhB3
	 4p8O4tUN8AyPthpZOn5UtZ1MbfKcLlxLGSAnRTQ1B7E3NCabGXoeS32keleyGYfETw
	 brXTPMqtDcxieiwey+Qu8NTZlP8WR+aLwPLPYKRTrsiSdgRgDS1+v7eTDwHkRrB5/M
	 HQZsTmxFMiBgQ==
Date: Thu, 18 Apr 2024 15:35:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	kch@nvidia.com, hch@lst.de, gloriouseggroll@gmail.com,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
Message-ID: <20240418203531.GA251408@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416043225.1462548-2-kai.heng.feng@canonical.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_133536_578798_F38E6BE6 
X-CRM114-Status: GOOD (  31.49  )
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

On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> When the power rail gets cut off, the hardware can create some electric
> noise on the link that triggers AER. If IRQ is shared between AER with
> PME, such AER noise will cause a spurious wakeup on system suspend.
> 
> When the power rail gets back, the firmware of the device resets itself
> and can create unexpected behavior like sending PTM messages. For this
> case, the driver will always be too late to toggle off features should
> be disabled.
> 
> As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> the power will be turned off during suspend process, disable AER service
> and re-enable it during the resume process. This should not affect the
> basic functionality.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for reviving this series.  I tried follow the history about
this, but there are at least two series that were very similar and I
can't put it all together.

> ---
> v8:
>  - Add more bug reports.
> 
> v7:
>  - Wording
>  - Disable AER completely (again) if power will be turned off
> 
> v6:
> v5:
>  - Wording.
> 
> v4:
> v3:
>  - No change.
> 
> v2:
>  - Only disable AER IRQ.
>  - No more check on PME IRQ#.
>  - Use helper.
> 
>  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..bea7818c2d1b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> +		aer_disable_rootport(rpc);

Why do we check pci_ancestor_pr3_present(pdev) and
pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
to disable AER interrupts on suspend in general.  I think it will be
better if we do that consistently on all platforms, not special cases
based on details of how we suspend.

Also, why do we use aer_disable_rootport() instead of just
aer_disable_irq()?  I think it's the interrupt that causes issues on
suspend.  I see that there *were* some versions that used
aer_disable_irq(), but I can't find the reason it changed.

> +
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> +		aer_enable_rootport(rpc);
> +
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver = {
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> +	.suspend	= aer_suspend,
> +	.resume		= aer_resume,
>  	.remove		= aer_remove,
>  };
>  
> -- 
> 2.34.1
> 

