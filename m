Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E701CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5YY0AKjuRmhN5jXS67K9oBDfInraYXWkuQQvtFh6y0A=; b=V5fL7fsKlOHgeKurLhhy+NXk3G
	tOmfnB0gTBmH5bUmtbY1tyB3o8rii6w/XH6SYdC9hziKvk4OCk5OiZLOcay+qCesIDJg6yxWuCjqw
	wO89/ahJeUU6hn1r9OPST+aVOXC8swFO5VJbVIP9XEnk0W95yfGZbGC97kQEDJ8kv03D4R+vwnUfE
	X2Z5LD3bEFTbzd8AscOAf1W58vpwz/+v9f/w8DQEJlq1THWqLHqSdBCLLwY2OCQ9SpfsfVZB/AHSP
	HKBDqPxd+KKxq4cmmHMPDBpLvWNveb2zXig51VGmtXse36TuNQLPGZLwRfS23u3TQ2yKWbPpOx5sm
	48LSWksg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU87e-0000000Bho5-0yVO;
	Mon, 01 Jun 2026 19:16:26 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU87b-0000000Bhmx-1q72
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 19:16:24 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-307263ad0cbso1353253eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jun 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780341382; x=1780946182; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YY0AKjuRmhN5jXS67K9oBDfInraYXWkuQQvtFh6y0A=;
        b=Poyxe3bQzb2D9EP7sQswL+o9AHeUbtpn2AdWOBPkhpbrf9SDnaebCvk0zNeaRYRc2Q
         kG5ArDucksJeZJwsibXXK4PNuYbeEi2WvzdgcUaXy3KrfktGhwB+Hp/JJfcuv9602855
         JzHfRQ8Rmn4dxX7flMYcVRTi3c1OB9DSfZoqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341382; x=1780946182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YY0AKjuRmhN5jXS67K9oBDfInraYXWkuQQvtFh6y0A=;
        b=pX0+TTL8+1rS8NyGpBjxD/DtX2xTkofr1k7FlllrgioVTGPOBjjoGCSxVPTvrJt8CW
         bZRph/h4W3cLfn2EGqDq51xBNp+CSNE6hXvK5upBmNWSUIzi+En9h58VDNEgg7D0Ton9
         Rm6ZccSxfuGY5SMGD894JwByO2k9ASlN5ddtuQGSKzab92vol8yAsiAlsv7jnpKrNc4t
         sjlmtRb3E+w6fXcyM/tyKyxfepP+dXMjkpJpOHux7wveFspU1nt9bSVEbhpuHrUXvWnZ
         M6j+y2h0SZvvFiU/Pv907ak72IxXJLQ9+ktvFUct++ZEvRmiWHKS9zZ5nQt5Jf+9kQOP
         nbkA==
X-Forwarded-Encrypted: i=1; AFNElJ/JKwtf6Iov1GWC/c8c9PESDbhUhtbjGlC2VfT/ozIF0L1n485yfnNou0n8Pn7zvReXL19YkFwypFsO@lists.infradead.org
X-Gm-Message-State: AOJu0YyNIwnWj0/T4vMxqdtmox9gNx53DXDFqgcs99H1cjjdlAxkVqcp
	woGaIt8v6jAqXTl6soeHYo4qDcnW+ETf5g+RpHC5WmvJ+zIEkEKvNsCrLkwQaol8lA==
X-Gm-Gg: Acq92OE3lBfe2UjV5ZryMUMTxqvZZ7lsv90LEg04yXsx1icwZErROtyon1vBm5bebgP
	oyCrXyVcImRklL5McsFzNnoVC5r4gHGRyS2ACPlTbgZcC1dI7xig5/tioFL3C+Ue8wevnJL5SpW
	Hm1YXqMFBrs/0vCZVUxaW4k719jW6XaboRE5PdF0qemFR8siSgVp7pbZytS0xNQwFrvMw/5QNhI
	BgThfWtdlrEIBV1UEp/nAGYheTYwbFnHnAOsc2STryy3VRc1CHYDDsHQ93D6E/BRPPLGhiVfb6f
	lJF+vzxIrxiNxz3t0HTxxSCTw86Ul8fa1/q7rg4sLjOKgrYctftDPFshaDQzHvMnty68ZB1JAlZ
	PiUlavw10Kc+i3EarFubQ6zkLZtYSHbF2y7kAUwyiGxn7Fvkn1oRqBxawSxb/C2SKAE5jM91KSe
	lW/nn1c+xkHPfEwQQqXqP2adUwf50AOX7s+306ENLLD31zSZHniZqm5FLLnqKD/snw4ThrRrn/
X-Received: by 2002:a05:7300:ef83:b0:304:9b48:53da with SMTP id 5a478bee46e88-304fa6438afmr5420329eec.26.1780341381977;
        Mon, 01 Jun 2026 12:16:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:d53d:3040:2c80:7717])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304ee0dd8e1sm13033848eec.21.2026.06.01.12.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:16:21 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:16:18 -0700
From: Brian Norris <briannorris@chromium.org>
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
Message-ID: <ah3agpwmcDfn9plX@google.com>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_121623_483729_B68EC451 
X-CRM114-Status: GOOD (  25.39  )
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

FWIW, this was already applied to pci/next for v7.2, but I'll add that
it seems this resolves what appeared as a regression in v7.0 for me when
using a Qualcomm SC7280-based laptop
(arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts):

report: https://lore.kernel.org/linux-pci/ahC8Pyuatu_AvnZp@google.com/
test notes: https://lore.kernel.org/linux-pci/ah3XLfI7E39B1UPh@google.com/

In short, my NVMe failed to resume from suspend-to-mem:

[   58.384442] nvme 0001:01:00.0: Unable to change power state from unknown to D0, device inaccessible
...
[   68.875606] nvme 0001:01:00.0: PM: **** DPM device timeout ****

Notably, this regression bisected to commit eaf290c404f7 ("PCI: dwc:
Enable MSI affinity support"), though I'm still not quite sure why.

Anyway, for $subject series, I'll provide my late tags:

Closes: https://lore.kernel.org/linux-pci/ahC8Pyuatu_AvnZp@google.com/
Tested-by: Brian Norris <briannorris@chromium.org>

