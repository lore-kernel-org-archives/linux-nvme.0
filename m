Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C1EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pwh07upWAeMrSGLu5MMFJRzxEYRIx1fu8oQcBB10gr4=; b=FwZhdjCnomKmeKxFMqNf4Aeaiq
	7PvB53+7sLs/bulkJzYCywUz7pgAZyBqqe68laZK2V3BruEFXXPlbW4jOEsENQA/wAHVa1dKcHg5n
	J4mw5EkDiHxxtzgR2R5wABNcTH1kHDeo3lNPFMdXY2Ym73+nX1JF7zhHuQvg9KDdIQGvRg42O/k4k
	/FP+G+O/LrlNr1KiinIX4AigJNE6QwYjVas3ItufOYM4MYJbbbeYzZOV04bEA2Z7sJ2+ysCOetL18
	F3ZSUDKucp/Uyjen60U5lzjHMJoAIZMNxKLp3VEf+bs/F3Kx2fOaqToTohaOR+abiarthtU7EDF2L
	1DB1r3ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nck5r-00FvYi-5H; Fri, 08 Apr 2022 08:35:47 +0000
Received: from mail-m118204.qiye.163.com ([115.236.118.204])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nck5o-00FvUL-43
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 08:35:45 +0000
Received: from [192.168.1.164] (unknown [218.106.117.245])
 by mail-m118204.qiye.163.com (HMail) with ESMTPA id 951A0A214BA;
 Fri,  8 Apr 2022 16:35:39 +0800 (CST)
Message-ID: <8f3db588-7625-1bc1-2577-4861ccb8d69e@kingtous.cn>
Date: Fri, 8 Apr 2022 16:35:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
From: =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
In-Reply-To: <20220408080721.GA2888@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQhlMTlYdSU9PGB8dT08aTR
 9VAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6GRw6ATkDS05JGTYcKENL
 AjgwCjlVSlVKTU9CT0tNQk9LSklNVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUpDVUpL
 TVVKSkxVSU9OWVdZCAFZQUxITUk3Bg++
X-HM-Tid: 0a80085092682d26kusn951a0a214ba
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_013544_316825_2D5ED20D 
X-CRM114-Status: GOOD (  10.96  )
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

Yes, the ID keeps changing if I do more suspend cycles. But numbers are 
the same, from 0100000000000000 to 0000000000000001.

[   26.574986] nvme nvme0: 8/0/0 default/read/poll queues
[   26.577001] eui changed from 0100000000000000 to 0000000000000001
[   26.577003] nvme nvme0: identifiers changed for nsid 1
[ 2467.069659] eui changed from 0100000000000000 to 0000000000000001
[ 2467.069660] nvme nvme0: identifiers changed for nsid 1
[ 2500.790058] eui changed from 0100000000000000 to 0000000000000001
[ 2500.790059] nvme nvme0: identifiers changed for nsid 1

I've changed two SSDs(Hikvision C2000eco(current) 1T, Gloway NVMe Basic 
version 1T) and they behave the same. I think is a device-specific problem.

The model is Lenovo Thinkbook 14p (amd ryzen 5800H + 32G). The suspend 
problem occurs in all Linux distributions like Ubuntu/Debian/Arch/Manjaro.

Current using: Manjaro Linux 21.2.5 (Linux 5.17.1 stable kernel, 
directly downloaded from kernel.org)

 > lspci -k:
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
Root Complex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge
	Kernel driver in use: pcieport
00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge
	Kernel driver in use: pcieport
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge
	Kernel driver in use: pcieport
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal 
PCIe GPP Bridge to Bus
	Kernel driver in use: pcieport
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller 
(rev 51)
	Subsystem: Lenovo Device 3846
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
(rev 51)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 3
	Kernel driver in use: k10temp
	Kernel modules: k10temp
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 7
01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
	Subsystem: Intel Corporation Wi-Fi 6 AX200NGW
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
02:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller 
(rev 01)
	Subsystem: O2 Micro, Inc. Device 0002
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci
03:00.0 Non-Volatile memory controller: MAXIO Technology (Hangzhou) Ltd. 
NVMe SSD Controller MAP1202 (rev 01)
	Subsystem: MAXIO Technology (Hangzhou) Ltd. NVMe SSD Controller MAP1202
	Kernel driver in use: nvme
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Cezanne (rev c5)
	Subsystem: Lenovo Device 3807
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir 
Radeon High Definition Audio Controller
	Subsystem: Lenovo Device 3814
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 
17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Lenovo Device 3831
	Kernel driver in use: ccp
	Kernel modules: ccp
04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] 
Renoir/Cezanne USB 3.1
	Subsystem: Lenovo Device 3839
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] 
Renoir/Cezanne USB 3.1
	Subsystem: Lenovo Device 3838
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] 
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
	Subsystem: Lenovo Device 3832
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x
04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h 
HD Audio Controller
	Subsystem: Lenovo Device 3833
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel



在 2022/4/8 16:07, Christoph Hellwig 写道:
> On Fri, Apr 08, 2022 at 03:56:49PM +0800, 金韬 wrote:
>> This is output from dmesg. Seems that "eui" has changed.
>>
>> [    2.086226] loop0: detected capacity change from 0 to 8
>> [   26.577001] eui changed from 0100000000000000 to 0000000000000001
>> [   26.577003] nvme nvme0: identifiers changed for nsid 1
> 
> Ok, looks like the device is broken and changes the EUID after power
> cycles.  Can you send the output of lspci -v?
> 
> Also just out of curiousity, does the ID keep changing if you do more
> suspend cycles?
> 

