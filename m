Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14A6CD5BAC
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=o6BvjvS8rBGHZfEK/Y2a9oFckQ5H1gJo6XVFIye7120=; b=L3w0ifglOjC/w5
	T4omm7vDmW7aNTl/PWZaPc9lipESnnY3qFlrzRlw2P112dmvfgsOrEu+bvDIXX7Br3tCcxGMh9KvL
	7m0upVp/w6XGOpNM8aKtuvnuOeKJKI+bkfM/Li63+Awj0en49L7ZJjD0C3msUIL+JiYSaO8UGZZyk
	zmCn2a0psVfZdPZPew9U+gDOKLgNdIi57iZGRKA5S0KNgWHn09eNfREADYl2ogBJopcH6uzL2zt+U
	/Ah4OizjHDKtT/nKI8ZjQ8HWyHJzkxG/H4Z1+RiDwqskdU0Qr4nv4gKwRADgDje1oKI0yUvlob3hQ
	o0i/ugdV0u0dPLktHFow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQkdV-0000000DAD8-1yAY;
	Sat, 23 May 2026 11:35:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQkdS-0000000DACM-3jf4
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 11:35:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 1CCE540345;
	Sat, 23 May 2026 11:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C14331F000E9;
	Sat, 23 May 2026 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779536118;
	bh=o6BvjvS8rBGHZfEK/Y2a9oFckQ5H1gJo6XVFIye7120=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MVb5q4AEA8UmYtvooBwsMHlyw5RBbHG0GAKY43VRV44Y00vqACu7wloCvRO4n4iQ6
	 8rpEU0BcS3OBEMkMxux9nbuqdismvmSx5f0d9aoy8LXj47JSbi+iH0rx/tuJPMvTvB
	 nJSQn+sssQMWaQoSGSWVzyCkYqeaYSpR7J4ZlhfZ5FqDTqYTP66LLTOyFdbU1Ltf8+
	 8V1IAhmNejY5pFol/POpfEER8Jz5zMWOT4mz6nZiNlTcTJNKJ9a8dr3SoVOShwjZ3w
	 Ncxm3Fp1WwOYhh4/RVDUIk73mZK0039qDLWmjsvAqhYB6gm3auukD8tdOKrYRBARRB
	 NB0cq3pm6cdZw==
Date: Sat, 23 May 2026 06:35:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
Message-ID: <20260523113516.GA292297@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_043518_974554_293DDF54 
X-CRM114-Status: GOOD (  25.61  )
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

On Tue, May 19, 2026 at 01:41:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi all,
> 
> This series introduces a new PCI API, pci_suspend_retains_context() to
> let the client drivers know whether they can expect context retention across
> suspend/resume or not and uses it in the NVMe PCI host driver.
> 
> This new API is targeted to abstract the PCI power management details away from
> the client drivers. This is needed because client drivers like NVMe make use of
> APIs such as pm_suspend_via_firmware() and decide to keep the device in low
> power mode if this API returns 'false'. But some platforms may have other
> limitations like in the case of Qcom, where if the RC driver removes the PCIe RC
> resource vote to allow the SoC to enter low power mode, it cannot reliably exit
> the L1ss state when the endpoint asserts CLKREQ#. So in this case also, the
> client drivers cannot keep the device in low power state during suspend and
> expect context retention.
> 
> And these limitations may just keep adding in the future. Without a unified
> API, the client drivers have to implement their own logic which may cause code
> duplication and may also lead to drivers missing some of the platform
> limitations.
> 
> Once this series gets merged, we can extend this API usage to other client
> drivers as well.
> 
> Testing
> =======
> 
> This series is tested on Qualcomm Hamoa based Lenovo Thinkpad T14s latop with
> NVMe drive.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> - Renamed the API to pci_suspend_retains_context()
> - Reworded the commit messages to include L10_REFCLK_ON + T_COMMONMODE as the
>   L1ss exit latency
> - Rebased on top of v7.1-rc1
> 
> ---
> Manivannan Sadhasivam (4):
>       PCI: Introduce an API to check if RC/platform can retain device context during suspend
>       PCI: Indicate context lost if L1ss exit is broken during resume from system suspend
>       PCI: qcom: Indicate broken L1ss exit during resume from system suspend
>       nvme-pci: Use pci_suspend_retains_context() API during suspend
> 
>  drivers/nvme/host/pci.c                |  3 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
>  drivers/pci/pci.c                      | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h                    |  9 +++++++++
>  4 files changed, 57 insertions(+), 1 deletion(-)

Applied to pci/pm for v7.2, thanks, Mani!

