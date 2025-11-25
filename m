Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB655D0EE14
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQv0f+p2du9ActsUKGTcmvSzfLb7F9qhXkL+U/+TS2w=; b=Ea9tRMDeBWr+8RvRRaRYgoZOtD
	CGWaYfRFe/Egxe3RhQpvbYdo0sXkX77Me9ilPENairxoV3mJpBZ65/Zt3oohymGOX688yWUNM+KfH
	jXiwq08CY/cqZ+MNuvD6ADp/wPE6xQXFMae30nBOn9Nj2poDCeNuqQOWqMRehvcP3dhTTNf6i/C/f
	uSh9XIQv0lknAqM2PBjh59V+4RO7FkBNi5ngai15n6kMWQinKRpCh53T+iieb0mwkTaRGbh+bMGte
	3yddZwpwGxtNx8VNFNGQwd5R7LO303U+sejyrX0HrAjcshXzomXwTT+1352i0c9umOzLbkI88V5vi
	rhYOu/Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNxiC-0000000DlIv-1CjT;
	Tue, 25 Nov 2025 18:24:24 +0000
Received: from smtp.hosts.co.uk ([85.233.160.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNxi9-0000000DlIR-3cfF
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 18:24:23 +0000
Received: from host51-14-94-149.range51-14.btcentralplus.com ([51.14.94.149] helo=[192.168.1.171])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <antlists@youngman.org.uk>)
	id 1vNxi2-000000001rw-87yg;
	Tue, 25 Nov 2025 18:24:15 +0000
Message-ID: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
Date: Tue, 25 Nov 2025 18:25:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Content-Language: en-US
From: Wol <antlists@youngman.org.uk>
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_102421_910905_CB2381A7 
X-CRM114-Status: GOOD (  20.41  )
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

Probably not the problem, but how old are the drives? About 2020, WD 
started shingling the Red line (you had to move to Red Pro to get 
conventional drives). Shingled is bad news for linux raid, but the fact 
your drives tend to drop out when idling makes it unlikely this is the 
problem.

Cheers,
Wol

On 25/11/2025 14:42, Justin Piszcz wrote:
> Hello,
> 
> Issue/Summary:
> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> drop out of a NAS array, after power cycling the device, it rebuilds
> successfully.
> 
> Details:
> 0. I use an NVME NAS (FS6712X) with WD Red SN700 4TB drives (WDS400T1R0C):
> 1. Ever since I installed the drives, there will be a random drive
> that drops offline every month or so, almost always when the system is
> idle.
> 2. I have troubleshot this with Asustor and WD/SanDisk.
> 3. Asustor noted that they did have other users with the same
> configuration running into this problem.
> 4. When troubleshooting with WD/SanDisk's it was noted my main option
> is to replace the drive, even though the issue occurs across nearly
> all of the drives.
> 5. The drives are up to date currently according to the WD Dashboard
> (when removing them and checking them on another system).
> 6. As for the device/filesystem, the FS6712X's configuration is
> MD-RAID6 device with BTRFS on-top of it.
> 7. The "workaround" is to power cycle the FS6712X and when it boots up
> the MD-RAID6 re-syncs back to a healthy state.
> 
> I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
> 1. Linux FS6712X-EB92 6.6.x #1 SMP PREEMPT_DYNAMIC Tue Nov  4 00:53:39
> CST 2025 x86_64 GNU/Linux
> 
> Questions:
> 1. Have others experienced this failure scenario?
> 2. Are there identified workarounds for this issue outside of power
> cycling the device when this happens?
> 3. Are there any debug options that can be enabled that could help to
> pinpoint the root cause?
> 4. Within the BIOS settings, which starts 2:18 below there are some
> advanced settings that are shown, could there be a power saving
> feature or other setting that can be modified to address this issue?
> 4a. https://www.youtube.com/watch?v=YytWFtgqVy0
> 
> [1] The last failures have been at random times on the following days:
> 1. August 27, 2025
> 2. September 19th, 2025
> 3. September 29th, 2025
> 4. October 28th, 2025
> 5. November 24, 2025
> 
> Chipset being used:
> 1. ASMedia Technology Inc.:ASM2806 4-Port PCIe x2 Gen3 Packet Switch
> 
> Details:
> 
> 1. August 27, 2025
> [1156824.598513] nvme nvme2: I/O 5 QID 0 timeout, reset controller
> [1156896.035355] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1156906.057936] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1158185.737571] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
> [1158185.744188] md/raid:md1: Operation continuing on 11 devices.
> 
> 2. September 19th, 2025
> [2001664.727044] nvme nvme9: I/O 26 QID 0 timeout, reset controller
> [2001736.159123] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
> [2001746.180813] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
> [2002368.631788] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
> [2002368.638414] md/raid:md1: Operation continuing on 11 devices.
> [2003213.517965] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
> [2003213.517965] md/raid1:md0: Operation continuing on 11 devices.
> 
> 3.  September 29th, 2025
> [858305.408049] nvme nvme3: I/O 8 QID 0 timeout, reset controller
> [858376.843140] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
> [858386.865240] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
> [858386.883053] md/raid:md1: Disk failure on nvme3n1p4, disabling device.
> [858386.889586] md/raid:md1: Operation continuing on 11 devices.
> 
> 4. October 28th, 2025
> [502963.821407] nvme nvme4: I/O 0 QID 0 timeout, reset controller
> [503035.257391] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
> [503045.282923] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
> [503142.226962] md/raid:md1: Disk failure on nvme4n1p4, disabling device.
> [503142.233496] md/raid:md1: Operation continuing on 11 devices.
> 
> 5. November 24th, 2025
> [1658454.034633] nvme nvme2: I/O 24 QID 0 timeout, reset controller
> [1658525.470287] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1658535.491803] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1658535.517638] md/raid1:md0: Disk failure on nvme2n1p2, disabling device.
> [1658535.517638] md/raid1:md0: Operation continuing on 11 devices.
> [1659258.368386] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
> [1659258.375012] md/raid:md1: Operation continuing on 11 devices.
> 
> 
> Justin
> 


