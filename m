Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92EEE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=; b=yIMuwL4VWc+9KfrYG44cw+hEFm
	n1QDCSuQCgr36/kEzyZC9rbpIIsi8SSEJX4ow6XQNCOB0T/TfT3zmi1qOb/Q7B6uo2e+ayLZMlqU8
	YLUDWD8QoMXzXZcL4biBg6yvEqm8AjSdwHwgGtmrVwbyg6x0Ki0Ix8//2NXdFmu3mCzGh0t1V2zQx
	wX5lWOs4pDqpJBfLl1HA/XNf4AEQRN12EoSlJLRNIeO31G7994411IoXIx3djbaMU572jLUI8o/Ij
	binl7vVYvjoLDlsTzcrgkdH1MEb0M4jxqqsmby+U/qGmGNrTJXJY0+TdsmyVFp9JZE8IsxsJKDUmT
	XiBsJL/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgFo-000000001x0-04CR;
	Thu, 12 Dec 2024 10:17:08 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgFl-000000001wc-0WDz
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 10:17:06 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e3f4364c4easo448786276.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2024 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998623; x=1734603423; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=;
        b=GOtXj60mx968XrYyqZ0ZwSQ68Asw2V5l31qJUG0m5BtLWw9xj0MkadNzjufATDqHpB
         vh+Dq+2XoXkD2idO9ar4KDNG81j4If1i6ztjdonG9ul2xQOAErZLLYDIXTNJAWtJlmT/
         iAdkoxggaM4h2ATjNBNiRclUyaklsSc72WfxxfT+KrFXFWIpaQPKUv1YFH+JIAoTz9/h
         QQTHQgWHucMzDdAA+P1GUJKqSD8deNw3e0LqYIpkw3nnkpdkM7cfcDw/kEsh04XRaZ40
         6Q1mCWQA7Rfwd7sQoiJOpCpCbzOT35bor2B4Wvoqlo8u/nHKx5mnyR6d/nAykFjL1xn7
         AZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998623; x=1734603423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6sNSSpKZ3LKKYS3NHkAfIesC05rsXqB571iPrdFdr8=;
        b=SsnK29Ew/q8KyphoS1teSPTQuTePBTfbBsqaxwUXnIBupulKUemh9GdrUVf6bhnnfk
         eXdzXZPpT7ykaK3mD8dP5qwd1VDc5LTMWeQYWtZlQEQ22jk1tluI+gLKB+HbZvWynSdw
         O7ufaX47IqaUeHzbzxBVeotRydUWvUGNkrE6mRWeZoUIWIMZ1gyMj6XlxfOeg2cRivOG
         Y9cNNS0rZCWwxb/1JDCMhvYLU7nWjfiqgvepqxcHg+z/15fp+NytriEMxKhA16Sc/5RS
         K9no1t0hPelPOuPKOBTqGqhohu4UffW3jfRTNaQmPsRyj4Yx2Y43TOdwK1p9hd5NligA
         rL2A==
X-Gm-Message-State: AOJu0YxJVQNyJRDF+hprkjNmwxm8ZfGVMoEIKO4Oa5s8uPKUKYwYp4V3
	gYApcvpmRWcBeF45s5J72o4v0CLwWGK/H4QBMGZFDxuEFOTcIUiZ/fAQrz+ReEEobdl3+uHMGuI
	F9qoJS6zFIjmU6b55tmcTuqVipmJwjneR
X-Gm-Gg: ASbGnctbkoffzm740Gq8CEbf46nSaNSKZohGTtDGCLe8lHa6dtFXcOwyjG4DyoA9NS2
	Zc6XYgD7Q7wYDztoGxVjDM/sO+an68r1PAKKZXXo=
X-Google-Smtp-Source: AGHT+IFQ0mnoL4s3ntbi4EPBBc/tu7a6QOuEiTV3ORYuJ4Ti5V51Ij6T2l2YWjVzp70tafOWDPy1U2td8emRHbbjmWs=
X-Received: by 2002:a25:8284:0:b0:e38:81cc:f95 with SMTP id
 3f1490d57ef6-e3dc9270f8amr1913454276.10.1733998623325; Thu, 12 Dec 2024
 02:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20241210093408.105867-1-dlemoal@kernel.org>
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 12 Dec 2024 11:16:26 +0100
Message-ID: <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021705_162120_82CE480C 
X-CRM114-Status: GOOD (  15.53  )
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

Hello,
I have tested the NVMe endpoint function extensively on two extra
platforms to run on, the FriendlyElec CM3588+NAS Kit [1] and NanoPC T6
[2] (with PCIe x1, x2, and x4 links).

Besides testing with Linux based hosts (Ubuntu 20.04, 23.10, 24.04), I
also tested that the NVMe device is recognized by a Windows 10
Enterprise host and can be formatted and used as a regular disk. I
also tested on MacOS Monterey on a Macbook Pro 2016 (Intel based) host
through a M.2 to USB-C adapter [3], the drive is recognized and
usable.

The USB-C adapter is based on the ASM2464PD chipset [4] which does
USB4/Thunderbolt to PCIe/NVMe, I tested with PCI over Thunderbolt with
the MacOS host, so the host sees the NVMe endpoint function directly
as a PCI device and the NVMe drive is seen as such. This works well.

The only test case that did not work is when I tested the ASM2464PD
chipset NVMe to regular USB functionality, where the chipset is the
host, and presents itself to the PC as a "usb-storage" class device,
but this didn't work because the ASM2464PD never enabled the NVMe
controller (CC.EN bit in BAR0), the PCI Link between the ASM2464PD and
endpoint function gets up however, and to the host PC the USB device
is recognized ("usb-storage" class, like a USB stick, e.g., /dev/sda),
but it cannot be read (shows as 0B block device). As I cannot debug
the chipset itself I don't know why the NVMe endpoint doesn't get
enabled. This might very well be a quirk in the ASM2464PD chipset and
is a very specific use case so I don't think it indicates any major
issues with the endpoint function, but I report it here for the sake
of completion.

I have tested with different storage backend devices for actual
storage (USB, eMMC, and NVMe (PCIe x1, x2) on the NAS kit).

In summary, over PCI the endpoint function works well with all three
Linux/MacOS/Windows hosts.

Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
(I don't know if this applies as I co-developed the endpoint function
with Damien)

Best regards,
Rick

[1] https://wiki.friendlyelec.com/wiki/index.php/CM3588
[2] https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
[3] https://www.aliexpress.com/item/1005006316029054.html
[4] https://www.asmedia.com.tw/product/802zX91Yw3tsFgm4/C64ZX59yu4sY1GW5/ASM2464PD

