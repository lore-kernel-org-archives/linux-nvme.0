Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F27E77170
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=PO3rc3t8+d2N8CZRnPzT4pmV/bhnJbnzWbK4L69vGA4=; b=kXQsaMO96Zus5z
	URdRXl+7sS60KYhZDG0LhetL1ppZC63I/wUgDokZnMU1omcrSYrnrF9A6srRCs6WLXcVI4Sa7y0zI
	f+yHGByN+QiiLU6FbDrkav22WS8a41E8GfiIyD3DnlgzDaC5eXS1GrbxKRFIoEAfvavLT8cH0a+Wn
	gowttyudW9Yc2HRRumHm6GWbgNpsqUP7TElIgwHk2zbyXsrnaGCmdaFSW9KTC73K364wXTuWSSP/3
	0ow1EjkZfpas46awX/1I2Jfis7IHf529QgxuVCEe7QFddwyT4mWqZPpNs4GBcbMci02C6gVbkLY7Y
	BJPYHxaKxt6hKnrpmWYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNTR-00000000EdY-16zh;
	Fri, 06 Dec 2024 01:49:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNTO-00000000Ecp-1xDE
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:49:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82A785C61B1;
	Fri,  6 Dec 2024 01:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6830C4CED1;
	Fri,  6 Dec 2024 01:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733449777;
	bh=L4DXv199Z3VF0FFNAtlfPHVec44fIh6kYkZfjqUvd2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EdQEP56weDWGGpq3MZEWgWO2nZNrpnEwnoMicsmUyyunrex3x6Rbb89miDWIzDZfq
	 4hfKYtzNbc0p7T1WcNCk7W2A3ix79OKIPhXNKMLPzcHWKygIeWmm2U7lRrpEq6A6V/
	 ORmNSQ50Z+hDgyVpjl/J4ZdujO5PQMTlnKlwDzK2Ua/wk+Tp4XJsybYtQfNuXT4Uvr
	 Kovgyqx8oW/S80i5AfSVEbyxfVUXzdlGiLaHbFFgPIsk4jsBU6Bo4ar49F85r3PLBi
	 keCh/iopn5ZJ+joOsEO0xz2720Y1RFgpfkxir252Z8ySN78yCvpxtCEkJLh05Hbcrv
	 0CtvB10R/3iig==
Date: Thu, 5 Dec 2024 19:49:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241206014934.GA3081609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205232900.GA3072557@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_174938_550916_1BA5ABBC 
X-CRM114-Status: GOOD (  18.68  )
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

On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > device through the sysfs attribute
> > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > suspend.
> ...

> > We did attempt to solve this problem in multiple ways, but the
> > lesson learned was, kernel cannot decide the power mode without help
> > from userspace. That's the reason I wanted to make use of this
> > 'd3cold_allowed' sysfs attribute to allow userspace to override the
> > D3Cold if it wants based on platform requirement.
> 
> It seems sub-optimal that this only works how you want if the user
> intervenes.

Oops, I think I got this part backwards.  The patch uses PCI PM if
d3cold_allowed is set, and it's set by default, so it does what you
need for the Qualcomm platform *without* user intervention.

But I guess using the flag allows users in other situations to force
use of NVMe power management by clearing d3cold_allowed via sysfs.
Does that mean some unspecified other platforms might only work
correctly with that user intervention?

