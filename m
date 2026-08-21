Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB70C5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSgKjk84mcBd5rrJA9uaVabxLzKH8PopYj9DmnYjP5A=; b=3ifuteK+sebPsKVsz2JgT2rm1r
	QLjR2qgLSyHKMy/7PzlN2SMhjG5fiRKQqhsnN16h/5xTT3KGb7l9O6iaLFcO1mDDrsm0/spnzEjX8
	x5eLPUNTKNTokA5/r5qe7XAeAcGbP24Dfmpu1XKpkyD5V9fj29LLlUdSuFaSzev9yZbUOi0KW2YRR
	8YSqN0/rUoSPeFu/RrufLYA6XlLyym0dCLSKBiFFjzOGI8IkYjcMKTXCYRfuapuEFxMwVOjAs6RMt
	O4p+M1XpYa8/EWMxVsc3kH8buYQyWTP2oBJvDFbe3sfmMzGe8Gu0EQqaTEPZnT0bjzzna6Mu7Y0kY
	kbEc1Hrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKSl-0000000Cmqz-2WsO;
	Fri, 21 Aug 2026 08:18:55 +0000
Received: from plato.eworx.gr ([2a01:4f8:271:262d::40])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKSh-0000000Cmpu-0zKx
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 08:18:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by plato.eworx.gr (Postfix) with ESMTP id 65592121193;
	Fri, 21 Aug 2026 11:18:34 +0300 (EEST)
X-Virus-Scanned: amavisd-new at eworx.gr
Received: from plato.eworx.gr ([127.0.0.1])
	by localhost (plato.eworx.gr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wzdU7KUFMelW; Fri, 21 Aug 2026 11:18:33 +0300 (EEST)
Received: from [10.245.147.15] (unknown [62.74.22.177])
	by plato.eworx.gr (Postfix) with ESMTPSA id BD7E0120667;
	Fri, 21 Aug 2026 11:18:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworx.gr; s=mail;
	t=1787300313; bh=VV7BwjjIDJ5bz3UdIc1Pj0vFxawXQvjDke/DpCVCus0=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=Iwcsg821EgFglhD24idDNwP0xjEGRyzVg/hhjT3uD6hLLl0ejO9sBymR/ON+O1BHX
	 8tSD1yXHE+qZjPtnSQO8m3UbiCJtanYq5kAVQ9Vh7bsJyaDnY6SJwrFQbYuKVHcwww
	 eBmamTLq+DduY58kbRVkbDa6Bt9HI297fFJn9A7I=
Message-ID: <ab8989c8-0135-47c8-8f22-2fedb9f5cbe5@eworx.gr>
Date: Fri, 21 Aug 2026 11:18:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ttencate@gmail.com
Cc: axboe@fb.com, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in Lenovo
 IdeaPad Pro 5
Content-Language: en-US
From: Maria Ioannidou <mi@eworx.gr>
In-Reply-To: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_011851_736335_639A15D4 
X-CRM114-Status: UNSURE (   7.16  )
X-CRM114-Notice: Please train this message.
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


I can confirm this issue on identical hardware, in case a second
report helps move the quirk forward.

Hardware:
   Laptop: Lenovo IdeaPad Pro 5 16APH8 (MTM 83AR001MGM)
   BIOS:   MDCN33WW (2024-01-24)
   Drive:  SKHynix_HFS001TEJ4X112N
   PCI ID: 1c5c:1d59

Kernel: 7.0.0-30-generic (Ubuntu 26.04)

Symptoms match the original report. After some idle time, writes
begin failing with I/O errors, ext4 remounts read-only, and the
system becomes unusable until reboot:

   systemd-journald: Failed to write entry to
   /var/log/journal/.../system.journal ... Input/output error

The failure is not confined to any userspace component. It
reproduces with no graphical session running (multi-user.target),
with the NVIDIA driver stack fully removed, and on a completely
fresh install of Ubuntu 26.04 onto a wiped disk - in that case
within roughly four minutes of first boot.

Diagnostics that made this misleading:
   - SMART self-assessment PASSED, Critical Warning 0x00,
     Available Spare 100%, Percentage Used 1%, Media and Data
     Integrity Errors 0
   - Sequential write throughput is normal (2.7 GB/s) when working
   - fsck from external boot media always completes clean, since a
     live USB barely touches the internal drive

Since a clean reinstall reproduces the fault, this initially
looked like failing hardware, and I was close to filing a warranty
claim before testing the APST hypothesis.

Booting with nvme_core.default_ps_max_latency_us=0 resolves it
completely. Stable for over 24 hours now, including several
reboots, suspend/resume cycles and repeated 4 GiB direct writes,
with no errors in dmesg.

I have not needed pcie_aspm=off or pcie_port_pm=off; disabling
APST alone has been sufficient here.

Happy to test a patch or provide further logs if useful.

-- 
Maria Ioannidou
Eworx Technical Team
mi@eworx.gr


