Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EDDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 20:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=hvIIwHeuBXAMo+A2IO6kjvsRLVBqlPOOTKKkvcigKRc=; b=JjFJC1nkQd2tXM
	nvpmSgArwgEoBlzLkM4yPY8HXYPyPErtwiBkO/FP9S3viUQbD31WI3zHti8awnOsXcp2IP2fxSE9U
	Cn+fV2kBRv52Yhq1HZ0A2fn9BBpaF8Ydntwx/bcE1PsYyuVi/YKkUA9Fre9FMbwiWHx1au60IDuli
	LJ0gHsLTxyj1HqB6PbYEr6ZyUZCoQJAhIq3DVLc4xjFPP/NOAPvYXQ/wOzYyYFwbmPn4FgnLhO0J6
	sai91LdO/JcROruQ66FNldVF7bEs/kJwgmcF8n5H3ODEJqJ6iJvcoBpBgJrCC2ul5ukE1rdBxlNcy
	mlUTQFg6UoWn4IShik3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqh8E-00A0aM-RR; Mon, 16 May 2022 20:15:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqh8C-00A0Yh-78
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 20:15:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E7D9761214;
 Mon, 16 May 2022 20:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE4C385AA;
 Mon, 16 May 2022 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652732147;
 bh=zUURAcddULKH97MeOKJwmTGU6utdU5/s7G9WrHiCTFk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=r9VTZLEOTfzAv7DGyZZZMdbM3HengP/kdytlM1Z3v4rr2rs5wT/+XXfWaONGuKAdk
 0Hkh+N+O3k81ITyO7C4CymO3qPbpFEH17ORbu9j/y1igx2xC7NhnLk7bot43sK5Py4
 aWfuWEW+uYhS6dYE01EC4d4QjlvHJB0T0HjA84jOTeu68oFevqwJ0K9EhzmMQGKYhk
 aYTqdMsAkD3i+VMZKcftkuPVmWFYAm6HzY6TqiTq7G9/REy9Z4bRzJEPi3YQadnBBf
 vmZ/5W3hJzj5otJ63XqXYWXL9JgYQ2xIScbJpKez9ly9Yo713dmniTjdYrv+wG8Qz9
 7bkb2WzqE49yw==
Date: Mon, 16 May 2022 15:15:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during suspend
Message-ID: <20220516201545.GA1046888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_131552_374991_DDF44A53 
X-CRM114-Status: GOOD (  31.13  )
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

[+cc Rafael, linux-pm, since this is power management stuff
https://lore.kernel.org/all/20220513110027.31015-1-manivannan.sadhasivam@linaro.org/]

On Fri, May 13, 2022 at 04:30:24PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series adds support for notifying the PCI drivers like NVMe about the
> transition of PCI devices into powerdown mode during system suspend.
> 
> Background
> ----------
> 
> On Qcom SC7280 based Chrome platforms, the OS will turn off the power to all
> PCIe devices during system suspend for aggressive powersaving. Currently, there
> is no way for the PCI device drivers to learn about this situation. Some of the
> drivers assume that the power will be retained and some others assume that the
> power may be taken down.
> 
> We faced the issue with NVMe PCI driver, where the driver expects the NVMe
> device to be in APST (Autonomous Power State Transition) state for power saving
> during system suspend. So when the power goes down, the NVMe driver fails to
> bringup the device during resume.
> 
> Previous work
> -------------
> 
> We tried to fix this issue in a couple of ways:
> 
> 1. The NVMe PCI driver checks for the existence of "StorageD3Enable" ACPI
> property in the suspend path. If the property is found, the driver assumes that
> the device may go to poweroff state and shutdowns the device accordingly.
> 
> As like the ACPI based systems, we also tried to get the support in place for
> DT based systems. But that didn't get accepted:
> https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/
> 
> 2. Keith Busch proposed a module params based approach. The parameter when set,
> will allow the driver to support APST during suspend. Absence of that parameter
> will let the driver shutdown the device.
> 
> This also did not get accepted:
> https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
> 
> Proposal
> --------
> 
> Christoph suggested to add a notification in the PCI/PM core to let the NVMe
> driver know that the device will go into powerdown state during suspend.
> https://lore.kernel.org/all/Yg0wklcJ3ed76Jbk@infradead.org/ 
> 
> Hence in this series, a "suspend_poweroff" flag is introduced in the host bridge
> struct. When this flag is set by the PCI RC drivers, the PCI device driver like
> NVMe can shutdown the device during suspend.
> 
> In the coming days, the usage of this flag could be extended to other PCI
> drivers as well.
> 
> Testing
> -------
> 
> This series has been tested on SC7280 IDP board connected to a NVMe PCI device.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (3):
>   PCI: Add a flag to notify PCI drivers about powerdown during suspend
>   PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
>   nvme-pci: Make use of "suspend_poweroff" flag during system suspend
> 
>  drivers/nvme/host/pci.c                | 3 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  include/linux/pci.h                    | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.1
> 

