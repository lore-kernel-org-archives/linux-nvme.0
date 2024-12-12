Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9F3E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mP7pm3dbRBuZKbXz7lQyjKJnAX5cCVGarvf+FTd8oL4=; b=0s2Zh8n90dkH+oRBSaPuK3ef3P
	vGRDd1OdOCI4OXsblAmGqoq6QT05b8HXKj7IUkaIhUF0VKdwdK/EEFORhe+RSJcVvPKbgcoHSpbQV
	akLSBddEZyoF958XJbsguNpB6Q0HUBCJ5KH5Zp728Vi2r8Fae/gGChinMJ9Y0igkt8s59qAtwbI/T
	lIvZ0cgCpHfwPLApBwi5mMsDXAGzLEmKncFp7ESSQckuHSm7i1LdpTEWqQRmk4CtGtkuy956sr0Pf
	O1kU5APjWwSIjox51ma5gel+m6o0GBRcRiVLJWpArU196k6KC80V9JYSkylCWhSb5FlQMmZOTq335
	JNBTz0yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgep-000000005eO-3lLT;
	Thu, 12 Dec 2024 10:42:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgen-000000005dj-02ua
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 10:42:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1683B5C10EE;
	Thu, 12 Dec 2024 10:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E2C4CECE;
	Thu, 12 Dec 2024 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734000176;
	bh=7Bj6zBbR1rPHQvsSOuLOKBNyiBtc6c9k6fUNqYm2/r4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u5ZG62YZ6VK1eB1akKbDWHsztpnf7u3HX6HZyWbTOTFxRuSnfe2PT0fNSsHKezkaE
	 bT6PmRk/1JmMtfKCutrPDqUwOaDIKEpzHQFGw+kKNXLD4O114AhVwsmjkHXQga4R0f
	 APz9G2SxsDBUGCyA+dp3KWzRMPzHHiK/bBdn7Y3jTwqXiY5NvgOc77cI7Mk7QIU71c
	 a+qbUu0AkJbz/uUNndtyn+g+tgYKdsoX/pn3nCI1P0lC+T0u964uYLi3U+OjiPTAkJ
	 vFt+A80z4b4W+TSQqCW92ahzzI84ZrrA/LRI3XFryLeNanXoDFsfiO8+2y2a0Y0+9/
	 hRQYNPzjY+JJw==
Message-ID: <795166be-d5cc-4c9f-99a6-567000a4a2a4@kernel.org>
Date: Thu, 12 Dec 2024 19:42:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
 <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhotOFTYc27n8wsnPtJ1fW2GHk5zRp3EeytjH=EZ2gxd5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_024257_144858_C2BFFAA2 
X-CRM114-Status: GOOD (  25.31  )
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

On 12/12/24 19:16, Rick Wertenbroek wrote:
> Hello,
> I have tested the NVMe endpoint function extensively on two extra
> platforms to run on, the FriendlyElec CM3588+NAS Kit [1] and NanoPC T6
> [2] (with PCIe x1, x2, and x4 links).
> 
> Besides testing with Linux based hosts (Ubuntu 20.04, 23.10, 24.04), I
> also tested that the NVMe device is recognized by a Windows 10
> Enterprise host and can be formatted and used as a regular disk. I
> also tested on MacOS Monterey on a Macbook Pro 2016 (Intel based) host
> through a M.2 to USB-C adapter [3], the drive is recognized and
> usable.
> 
> The USB-C adapter is based on the ASM2464PD chipset [4] which does
> USB4/Thunderbolt to PCIe/NVMe, I tested with PCI over Thunderbolt with
> the MacOS host, so the host sees the NVMe endpoint function directly
> as a PCI device and the NVMe drive is seen as such. This works well.
> 
> The only test case that did not work is when I tested the ASM2464PD
> chipset NVMe to regular USB functionality, where the chipset is the
> host, and presents itself to the PC as a "usb-storage" class device,
> but this didn't work because the ASM2464PD never enabled the NVMe
> controller (CC.EN bit in BAR0), the PCI Link between the ASM2464PD and
> endpoint function gets up however, and to the host PC the USB device
> is recognized ("usb-storage" class, like a USB stick, e.g., /dev/sda),
> but it cannot be read (shows as 0B block device). As I cannot debug
> the chipset itself I don't know why the NVMe endpoint doesn't get
> enabled. This might very well be a quirk in the ASM2464PD chipset and
> is a very specific use case so I don't think it indicates any major
> issues with the endpoint function, but I report it here for the sake
> of completion.
> 
> I have tested with different storage backend devices for actual
> storage (USB, eMMC, and NVMe (PCIe x1, x2) on the NAS kit).
> 
> In summary, over PCI the endpoint function works well with all three
> Linux/MacOS/Windows hosts.
> 
> Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> (I don't know if this applies as I co-developed the endpoint function
> with Damien)

I think it does apply since I only tested with Linux hosts. Thanks a lot for all
the extra testing !

Sending v4 with the build failure fixed and doc typos fixed.

> 
> Best regards,
> Rick
> 
> [1] https://wiki.friendlyelec.com/wiki/index.php/CM3588
> [2] https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
> [3] https://www.aliexpress.com/item/1005006316029054.html
> [4] https://www.asmedia.com.tw/product/802zX91Yw3tsFgm4/C64ZX59yu4sY1GW5/ASM2464PD
> 


-- 
Damien Le Moal
Western Digital Research

