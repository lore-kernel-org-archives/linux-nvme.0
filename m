Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD9CD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITf7KktGLbSDnXpQlgu6YR/GMDEIJ07ZRAIMb0e+JUs=; b=RoME+UPlLX+pXQscwAr/NVkVeq
	Lz4Y8Vlim6Bnqpz9FdsNtMSaiIJAYmYhHNvUAgBKXCNybzyciyiykOWGfD8LTgUiIIF3o7HDPEY7H
	oGYy3vZJktjiZgsLzFk6ogVeCA7SNpKzFvEs8ghCD95ggrkOre3MWYsgXB9s/ND0X3NS/Meci40sr
	U9JOJYFejtBeaS5ovfYAPtKFBd/ZxCAhvCwsbXwbDLCRndrBXJpm+kHRNrxb4/f3fRYKQbjfHMDt/
	m7H/wjDfV7QEjMv8N63gpMs8eEOycBD9xVgEDOi4hhoU7xx9+D35ThVSHoPlk9vSKvGQxWj56R8jI
	CWl1zj5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSMo-0000000BMs6-1Wy0;
	Fri, 22 May 2026 16:04:54 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSMj-0000000BMrB-488G
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 16:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ITf7KktGLbSDnXpQlgu6YR/GMDEIJ07ZRAIMb0e+JUs=;
	b=oinMPgChun1Q8pHKMsUw7O6Ts6sSLkljCso/fGRETJlCrCWYKuUrh5jt6+QLet
	wCrZZsaQw81O35ddeXhyAgPV5kLwhQokrIiLeEvdINCX7+mp255mfLQYW4BKUZVI
	U+Par40HllVYF3BAn4GMFQYysZcIet5w1OF+/kS/aAIeU=
Received: from [IPV6:240e:b8f:91b3:d000:1df1:2c6c:16c1:e8bf] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXFlhyfhBqmV1DCw--.21621S2;
	Sat, 23 May 2026 00:04:03 +0800 (CST)
Message-ID: <09473fc7-e91c-4e80-9d64-0d14d585d89d@163.com>
Date: Sat, 23 May 2026 00:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
To: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wCXFlhyfhBqmV1DCw--.21621S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry5AFy8Jw15AF18Kr1kuFg_yoWrJw4Dpa
	y5KrWSyr1DJFWIyFnavw1jvry3uanYkrWUC3srGw15uay3uFnagr4jgr4Yqry7ur4fC3ZF
	vr4jga4UuFn8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRV6w_UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:1df1:2c6c:16c1:e8bf]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xVb-moQfnU7hwAA3W
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_090450_646747_64A6CD93 
X-CRM114-Status: GOOD (  31.86  )
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

Hi Mani,

We previously discussed a patch. I wonder if you have any memory of it. 
I'm not sure if it can solve my problem. As shown below:

https://lore.kernel.org/linux-pci/z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk/

"""
 > Hans: Before I added the printk for debugging, it hung here.
 >
 >
 > I added the log output after debugging printk.
 >
 > Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
 > Our hardware is in STR(suspend to ram), and the controller and PHY 
will lose
 > power.
 >
 > So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
 > controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
 > controller and PHY will be reinitialized. If suspend does not close 
the AXI
 > and APB clock, and the AXI is reopened during the resume process, the APB
 > clock will cause the reference count of the kernel API to accumulate
 > continuously.
 >

So this is the actual issue (controller loosing power during system 
suspend) and
everything else (ASPM, MSIX write) are all side effects of it.

Yes, this issue is more common with several vendors and we need to come 
up with
a generic solution instead of hacking up the client drivers. I'm planning to
work on it in the coming days. Will keep you in the loop.

- Mani
"""


Best regards,
Hans

On 5/19/26 16:11, Manivannan Sadhasivam via B4 Relay wrote:
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
>    L1ss exit latency
> - Rebased on top of v7.1-rc1
> 
> ---
> Manivannan Sadhasivam (4):
>        PCI: Introduce an API to check if RC/platform can retain device context during suspend
>        PCI: Indicate context lost if L1ss exit is broken during resume from system suspend
>        PCI: qcom: Indicate broken L1ss exit during resume from system suspend
>        nvme-pci: Use pci_suspend_retains_context() API during suspend
> 
>   drivers/nvme/host/pci.c                |  3 ++-
>   drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
>   drivers/pci/pci.c                      | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/pci.h                    |  9 +++++++++
>   4 files changed, 57 insertions(+), 1 deletion(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260414-l1ss-fix-6c9cf2451944
> 
> Best regards,


