Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FDBCA0EE6
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Aug 2025 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Subject:Cc:To:
	Message-Id:Date:Content-Type:Mime-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1h/bw6MWPhtYkzd58nPhjPCtWtPfRHnCtDvW+x+ZnZs=; b=z9AL37FdD+gyAJ2XK+V1wa6TF1
	wRuxE7SjO/UF8Pwc6aCespzejM0RpJnRynTemfhBK55YFcqnCVMu4pPprK/CzIA3Nk+jI9qdZ2I7J
	XTLlFtsNwbp9fppq7wjtBdeVTdewPms6UlFHNpXo8fcAXd+wliU4yqXvcgbAtns6UNM6XcVspvaMh
	DbgHyzJc/iiV3M1A2Vn4P9z0jFg0blumCQtHUxUDYGgUIqyCFE+KHA39lw3FeGOqLZnw181fd/Ovf
	BubipCLD1X5pSJR1iHlY2Z+nHUK5p6wqFxZLhken9VEJD2sKQmwZYD27nFQyL1FllfCBoexfpMgfI
	LmGzeO2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unFHp-00000004Ytg-2GNu;
	Sat, 16 Aug 2025 11:41:25 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unFHi-00000004YtI-20cW
	for linux-nvme@lists.infradead.org;
	Sat, 16 Aug 2025 11:41:20 +0000
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755344474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1h/bw6MWPhtYkzd58nPhjPCtWtPfRHnCtDvW+x+ZnZs=;
	b=YrzuUa2n/RG3q4uFVXmqTv7AN8BKqBpwh3l7+3yKaVfgUsQRR3E+V1wPoIU0rn9ML2nQlx
	oFYh2NMX0x5PzdhvlKswjrQfVEPw4uFHLeV4Gmg6WwTBRHU8JutCVx9RT5Wc53mQw61psH
	3jrgTcULoNtIvj5zM8NfN+GLqbcQxzQaahz04OrB2ixA+tUTy/5tbyff1ptlKbVuNbQAQz
	D4r9mItjwGIYuzL4J7JPfwq1++YKiTPhk77CY8gVMRR/7WBhkCkX426dg73xwrXGTxxJZq
	QkZypru9pZXZMU6kvTd5XUZRUgHxArDoLP8jcwhJIKc6fT5cy/szKCOO07hvtQ==
Content-Type: multipart/signed;
 boundary=35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 13:40:44 +0200
Message-Id: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
To: <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "Diederik de Haas"
 <didi.debian@cknow.org>
Subject: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250816_044119_675038_7DFA1CB4 
X-CRM114-Status: GOOD (  13.85  )
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

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:

root@nanopi-r5s:~# uname -a
Linux nanopi-r5s 6.16-arm64-cknow #1 SMP PREEMPT Debian 6.16-1 (2025-07-28)=
 aarch64 GNU/Linux
root@nanopi-r5s:~# dmesg --level 0,1,2
root@nanopi-r5s:~# dmesg --level 3
root@nanopi-r5s:~# dmesg --level 4
[    2.410231] dw-apb-uart fe660000.serial: forbid DMA for kernel console
[    5.234812] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.242112] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.246222] gpio gpiochip2: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.252811] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.265791] gpio gpiochip4: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.741901] r8169 0000:01:00.0: can't read MAC address, setting random o=
ne
[    5.806644] pci 0001:10:00.0: Primary bus is hard wired to 0
[    5.849952] r8169 0001:11:00.0: can't read MAC address, setting random o=
ne
[    6.017270] pci 0002:20:00.0: Primary bus is hard wired to 0
[    6.393688] nvme nvme0: missing or invalid SUBNQN field.
[   21.484306] nvme nvme0: using unchecked data buffer
root@nanopi-r5s:~# dmesg | grep nvme
[    6.386187] nvme nvme0: pci function 0002:21:00.0
[    6.386697] nvme 0002:21:00.0: enabling device (0000 -> 0002)
[    6.393688] nvme nvme0: missing or invalid SUBNQN field.
[    6.397901] nvme nvme0: D3 entry latency set to 8 seconds
[    6.428168] nvme nvme0: 4/0/0 default/read/poll queues
[    6.465173]  nvme0n1: p1
[   12.522314] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Ke=
rnel Module nvme_fabrics...
[   12.973871] systemd[1]: modprobe@nvme_fabrics.service: Deactivated succe=
ssfully.
[   12.977051] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Ke=
rnel Module nvme_fabrics.
[   21.484306] nvme nvme0: using unchecked data buffer

Before I put this SSD into my FriendlyELEC NanoPi R5S (rk3568; arm64)
I had it in my main PC (AMD Ryzen 1800X; amd64) where I had these
warnings as well, so it seems directly connected to the drive, not the
device it's plugged into.

I wonder if something can be done to fix those warnings.
I'm not aware of these warnings causing actual problems, but I haven't
'really' used it thus far (mostly to store some media files), but I want
to use my NanoPi R5S as my server (with f.e. my git repos), so I want to
be extra sure my data won't be at risk. And I don't like ignoring kernel
warnings; I assume they're warnings for a reason.

Some more data about the drive:

root@nanopi-r5s:~# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            xxxxxxxxxxxxxxx      Samsung SS=
D 970 EVO Plus 2TB             0x1        534.51  GB /   2.00  TB    512   =
B +  0 B   2B2QEXM7

root@nanopi-r5s:~# nvme get-feature /dev/nvme0 -f 3
get-feature:0x03 (LBA Range Type): NVMe status: Invalid Namespace or Format=
: The namespace or the format of that namespace is invalid(0x200b)

I don't know if it would/can be risky to share the Serial Number, so I
blanked that out, but I can provide that if that would be helpful.

root@nanopi-r5s:~# lspci -v -s 0002:21:00.0
0002:21:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVM=
e SSD Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd SSD 970 EVO/PRO
        Flags: bus master, fast devsel, latency 0, IRQ 75
        Memory at f0200000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, IntMsgNum 0
        Capabilities: [b0] MSI-X: Enable+ Count=3D33 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158] Power Budgeting <?>
        Capabilities: [168] Secondary PCI Express
        Capabilities: [188] Latency Tolerance Reporting
        Capabilities: [190] L1 PM Substates
        Kernel driver in use: nvme
        Kernel modules: nvme

But I did not change the Device Serial Number from lspci.
AFAIK I have the latest firmware (checked with fwupd).

Happy to provide additional data, but as I don't know what would be
useful, I figured I'll leave it up to the experts to ask for it.

Cheers,
  Diederik

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKBuUgAKCRDXblvOeH7b
biC4AP4xV9B0s22aFzjgq9ft23dgNZj5MmayWFZh8GlHwcLUqwD7BfjNzNwTKk/7
eKwWc79zBlllICr8AE2I9bdnDVnMjgE=
=yiAO
-----END PGP SIGNATURE-----

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9--

