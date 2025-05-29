Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E262C5AD49
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ob1tvkLWeq/o7Qc2+2cBTwIpVI7WckRAJH2sr6mRI+U=; b=J7MB1LNlQ1PSNboAoe9hy1evJA
	bcXXT0YlcE7dW71SF54eaaCb3QmGE05lxRHqjib4rPaOdrHVHRIBWb4t3z/n+aV8wQXkz0POFan15
	l4dK2s1BYs1WZCBYCqpWqV02yMmuEcMXWjHtgsQLGbeHdZhyEViJBR/HNU9RPFhCkRqA+eR/XkIkO
	iPLGHpHsejvph1khuoM8GdEDKudStTZ6Ev2IVx6rjZh4kqbIMV9ceiE24SctODOG+46rwDtnF6hQI
	erhy4PSihmkIKVOHLEoxZwnOfetYe+c7hDij6FSLR2KKT+3i+6gJdzVDiBtqLGMl434XOxiqWxisb
	sl8ketwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKlds-0000000GdCa-1CyA;
	Thu, 29 May 2025 22:22:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKldp-0000000GdBT-27u1
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 22:22:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0E33F5C69F9;
	Thu, 29 May 2025 22:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85753C4CEE7;
	Thu, 29 May 2025 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748557344;
	bh=qiABFbsJcWyIhPq0FNeTctPGJf0KQJvA0uRNtOQkP0A=;
	h=Date:From:To:Cc:Subject:From;
	b=aGliEGufqyb+DIOC8pTu31skuxGM1Z9/+SBkPULyPbr7nBDcxTbfxm5e2OUf5hw8Q
	 QvfhKaZWDrf+WxR0bBbtdSw4ly+IGFJlVwH0yuuoVWkXfDfdZgWq0tglZ66zaN1TXX
	 NLLHhx4s4PPmLeWSmxMN5eeH3mtObhhx5LGnKjSysl2JX+gnwni6m7HXwkvfBLqb+9
	 nZ0FVDBfrx2BRLfPAIgpjIRalxKEdgKsh2zSfdfVpTO34nmT7w9gTdK9bn33O9NOfP
	 lc9QNYhRqvj2kWX969thEjACIxvGrrqO0l/8li70WgBdyuUXaPYaO0kICEoHBeF7gy
	 +2dY6S4VzDr0Q==
Date: Thu, 29 May 2025 17:22:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-usb@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [bugzilla-daemon@kernel.org: [Bug 220175] New: NVMe SSD doesn't work
 via Thunderbolt enclosure on Framework 13 (Ryzen AI 300)]
Message-ID: <20250529222223.GA119209@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_152225_586470_99CF478D 
X-CRM114-Status: GOOD (  12.26  )
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

[+cc pciehp, thunderbolt, nvme folks;
 +bcc Andrey (reporter)]

Andrey, sorry that you tripped over this, and thank you very much for
reporting it.  I'm forwarding this to the mailing lists because most
subsystems don't really pay attention to the bugzilla.

Obviously we don't want to have to use kernel args to make things
work, and we also don't want to have to use /sys/bus/pci/rescan after
a hot-add.

IIUC, if you boot while the SSD in the enclosure is already attached
to the USB 3.2 port, everything works fine?  Could you please attach a
complete dmesg log from such a boot to the bugzilla, just as a
baseline?

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=220175

           Summary: NVMe SSD doesn't work via Thunderbolt enclosure on
                    Framework 13 (Ryzen AI 300)

Created attachment 308180
  --> https://bugzilla.kernel.org/attachment.cgi?id=308180&action=edit
lspci -vvv

I have a Samsung 970 Evo Plus SSD installed in an ACASIS TBU401E USB4
enclosure. When I connect it to the USB 3.2 port, everything is fine, the SSD
is detected by the scsi driver and shows up in the system as /dev/sdb. But when
I plug it into the USB4 port, the device doesn't show up.

However, I can connect and use this disk by using kernel args
`nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off` and
doing `echo 1 | sudo tee /sys/bus/pci/rescan` after connecting the SSD.

Solution described in https://bugzilla.kernel.org/show_bug.cgi?id=216000#c65
doesn't help and breaks most of the PCIe devices in the system.

More info:

```
$ uname -r
6.14.6-300.fc42.x86_64
$ ls /dev/nvme*    
zsh: no matches found: /dev/nvme*
$ cat /sys/bus/thunderbolt/devices/1-2/vendor_name         
ACASIS
$ cat /sys/bus/thunderbolt/devices/1-2/authorized         
1
$ inxi -MC           
Machine:
  Type: Laptop System: Framework product: Laptop 13 (AMD Ryzen AI 300 Series)
    v: A9 serial: <superuser required>
  Mobo: Framework model: FRANMGCP09 v: A9 serial: <superuser required>
    UEFI: INSYDE v: 03.03 date: 03/10/2025
CPU:
  Info: 12-core model: AMD Ryzen AI 9 HX 370 w/ Radeon 890M bits: 64
```

