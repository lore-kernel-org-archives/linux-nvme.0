Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB80F4368D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Z12sobp7qwjh3xcHWBeA8W79iNahqtVkTOPZr69KVA=; b=jI8hImjjZOSvmVnxqSahhfnGks
	9lU/R3iP0NqRvbqQapTxW2Zi8gNRm9GLAVv4MpGJ9Dj/bZnKr23qB9dT5EEtB8zH7kpbUYFzbq9vT
	qh101v9SQF4C94RfQpjVevMF7veokc2lKZIWcZpHkvPeYvRFZrxrsTIge+RkAuLu4cWJoJpg7dSPz
	I2uEQSovpAnSVLIcKTKN/9hz3q1OmtKvpmQMx+XUJLD/gufZVDtYQj/BW8YNsFoOMTVdRoYCwOwjW
	L4TcZFA2VUqo1Q0fg0rlZ25Wo9sk/v7JOjA0+aEaIn9ZVWsHgMFvo96mVR7hc4thwfIXE3ppPsB46
	ds6mw6Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDh0W-00000003x2H-1unp;
	Fri, 17 Apr 2026 11:05:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDh0T-00000003x1Q-2s2m
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 11:05:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C65A443DF;
	Fri, 17 Apr 2026 11:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE17C19425;
	Fri, 17 Apr 2026 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776423904;
	bh=ZBam/+xG2IwtfYcUy/KBiLQ1KHTf9QZBls6Dnr28a8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvFyvFeREjmDAdzq+8psWIA8mIeGpYdB8CeF3MUYfBA+RkSMQUHoGqtKH7QHKdCKC
	 2ziWJs+xs1ZKK9VOB93JPcIcSbB6YUFrJTcRNNUKt6iU/bWccR43BmYYLpjHZJFWU7
	 /QaA8VFRcDM4eyAb4klUKVUsLktjZJNZaHKJmoJTgLiyDyvm6/irO4kgIcWE0qYFzB
	 5Q4aB31M1By3TjCLY7En3DHMB2XI3OpK7M7fTDsUD6jGmXTJSu5m3gUiT0rC4oGlvc
	 SYNmN94UfzmfuA2oVZ7qwx4bljISWb9K4J1Ksy/TEGMLjownF0KUqNNpwNtYR58G4c
	 3GaNAOGX6Bh7Q==
Date: Fri, 17 Apr 2026 16:34:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Introduce pci_dev_suspend_retention_supported()
 API
Message-ID: <3smfckgl2vwhha7rtlqlpfzlfpg2rebyump77cbi5pcgwubn3y@d66eu7axo7xi>
References: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
 <20260416191111.GA21551@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416191111.GA21551@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_040505_758799_617F744C 
X-CRM114-Status: GOOD (  29.99  )
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

On Thu, Apr 16, 2026 at 02:11:11PM -0500, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Tue, Apr 14, 2026 at 09:29:38PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > This series introduces a new PCI API
> > pci_dev_suspend_retention_supported() to let the client drivers know
> > whether they can expect context retention across suspend/resume or
> > not and uses it in the NVMe PCI host driver.
> > 
> > This new API is targeted to abstract the PCI power management
> > details away from the client drivers. This is needed because client
> > drivers like NVMe make use of APIs such as pm_suspend_via_firmware()
> > and decide to keep the device in low power mode if this API returns
> > 'false'. But some platforms may have other limitations like in the
> > case of Qcom, where if the RC driver removes the resource vote to
> > allow the SoC to enter low power mode, it cannot reliably exit the
> > L1ss state when the endpoint asserts CLKREQ#. So in this case also,
> > the client drivers cannot keep the device in low power state during
> > suspend and expect context retention.
> 
> I don't know what pm_suspend_via_firmware() means.  The kernel-doc
> says "platform firmware is going to be invoked at the end of the
> system-wide power management transition," but that doesn't say
> anything about what firmware might do or what it means to drivers.
> 

It's hard to predict what the firmware might do after it gains control from the
OS. But as far as the API goes, it just expects the drivers to save the context
and reset the device so that the firmware could do anything it want.

> Based on d916b1be94b6 ("nvme-pci: use host managed power state for
> suspend"), which used it in nvme_suspend(), I guess the assumption is
> that pm_suspend_via_firmware() means the device might be put in D3cold
> and lose all its internal state, and conversely,
> !pm_suspend_via_firmware() means the device will *never* be put in a
> low-power state that loses internal state.
> 

Yes, that's the assumption. Though, the firmware might not do D3Cold at all,
but the drivers should be prepared for that to be compatible with all firmware
implementations.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

