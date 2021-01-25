Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3571C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 16:02:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834C9221EB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 16:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C9221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LJLaAMzBY3lynYaDLjiytaJkKpSLS4KPfvMXThJ2VHw=; b=l/CUcjWPhmss9xofB1GSZPcSNz
	LElh523FQNmzdjnUAkmEq1X0RE4Fjc+zq/YLm2I8akEN+W4pVWffsXRRxfkvpwvgSyDBsP9AsQFHt
	FxcNTgeiKuf4ngoh5GN/gFiK4fGXK4n1cieS9KMAYYCwR5AQoX04OUceLoC98GzOXcRDQFndLxvpp
	EIjD5hZvY8wU4nGxfYk4bzJXdsEqHg9DjxLFdMSrZhhXToofquH9le2qrVw4nm3PcXL+FcBIdua/C
	B2JTEi1XISR50PmaFD6q8dIh74key3m1fIh++nNDKjEwWnYItaPO21p317AHwpT5qdYCIFNH9pRZT
	vOoOVG+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l44J6-0007oS-V9; Mon, 25 Jan 2021 16:01:36 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l44IZ-0007n9-L3
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 16:01:04 +0000
Received: by mail-ej1-x62a.google.com with SMTP id l9so18783756ejx.3
 for <linux-nvme@lists.infradead.org>; Mon, 25 Jan 2021 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=1m78RHOX31Czdiyia8s3e9GsWcQHxiHz8d4iTdahj0M=;
 b=g+D0jYmK7aYGVXPm0obDwpO69J/OsLGnmoSGuup6bhJWLcADXJxNnufzB5M/mJGi7j
 crWdHClb7DxUkLefKtYm6mb9NcoR5LOuKHKB2/fNmmnVTqSYMfhMp8OemdgNhrj+s2p/
 QBHdaHrm5mAXfodpYhQeBDNGKchGVfcwfjg6rrOi4kxBavDlxXEzTBFUA9dV9nPDMPk0
 3Jlly3Etvs9UqcP9HUUF/KFQgU99LYq/47uUGtMxhP/yy1Cy0IliZw9auU/i0sFJM1YL
 QHDL9Quy/NPFfkColpGGXHzzmNS0wueABVU1jg73lwqI7xhQHNP6F4R1sxRwy460wvOn
 PvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=1m78RHOX31Czdiyia8s3e9GsWcQHxiHz8d4iTdahj0M=;
 b=W60H88lE1ZPQwXKPASklaE+YDbGZZ9RKcPF6UzXDMFvXAXizSOKLwrDymlah1nKFNt
 6/+s4ovD+zcpwAqp8lvGChDaYvNixHSvWym6XeqowxLFuMh/KfpuiSI1bEULeo2SEdIu
 ZwcwW5bsB0NTF8HghnNDXnUfvHrhzq21Lq3yedDpZocmxRsMtJM7mGrjZYe0Wkbo3MmA
 IlGsPieODxvIX0T///hhQAtKTvzVGgy2kGiKII5XyvairRFP5kRXJ+vgBd0q0SzRBT1g
 lBL0XuuuF0PKeYuoYJrL9ii+ItQeggmNSNoZXEG2a8BjX+wSGPjp7hs5wTrE94ZFmI0w
 gqlA==
X-Gm-Message-State: AOAM5320Fyw2LjdI1mbMpRXzwNrwigpdJBkFHN2VGvf+z1uURM2LwdvL
 Pp+rfnVyRiqMTKpsH7rCBYrvTXOciXIQJA==
X-Google-Smtp-Source: ABdhPJwu7Zai+nqwWLfq4kjTRgdinpjGzkZZXtZqLf4k29J86QwFGSUkcivrRVN4rF9RPzCxo2uhUw==
X-Received: by 2002:a17:906:9941:: with SMTP id
 zm1mr832910ejb.522.1611590459206; 
 Mon, 25 Jan 2021 08:00:59 -0800 (PST)
Received: from [192.168.1.70] (2-108-107-206-static.dk.customer.tdc.net.
 [2.108.107.206])
 by smtp.gmail.com with ESMTPSA id v25sm8619485ejw.21.2021.01.25.08.00.58
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 08:00:58 -0800 (PST)
Message-ID: <04fdb6a116bbc4d9eadc3f9434d8b6f2426e3c57.camel@gmail.com>
Subject: Missing or invalid SUBNQN on Corsair MP600 1TB device
From: Claus Stovgaard <claus.stovgaard@gmail.com>
To: linux-nvme@lists.infradead.org
Date: Mon, 25 Jan 2021 17:00:57 +0100
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_110103_695692_98F803E2 
X-CRM114-Status: GOOD (  19.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

This is my first post to this mailing list, so please forgive me if it
is already discussed.

I have just build a new workstation, where I noticed the following
warning for the Corsair MP600 1 TB drive.

nvme nvme0: missing or invalid SUBNQN field.

it arrived with firmware 11.3 and I have later upgraded to firmware
13.0 to see if they have fixed the firmware.

Have also reported in their forum
https://forum.corsair.com/forums/showthread.php?p=1077109#post1077109

Looking in the host pci.c code it seems to be a known issue on some
drives where the "NVME_QUIRK_IGNORE_DEV_SUBNQN" is used.

So I guess that Corsair MP600 is a candidate for the same quirk.

Considered to add the Corsair to the list of drives with
NVME_QUIRK_IGNORE_DEV_SUBNQN, but would just ask here first, if it
would be the correct use and understanding.

Regards Claus

Below is info for my system for reference.

nova /home/frosteyes # uname -a
Linux nova 5.10.10-gentoo-FrostEyes #1 SMP PREEMPT Sun Jan 24 23:26:32
CET 2021 x86_64 AMD Ryzen 9 5950X 16-Core Processor AuthenticAMD
GNU/Linux

nova /home/frosteyes # journalctl -b | grep nvme0
jan 24 23:32:23 nova kernel: nvme nvme0: pci function 0000:01:00.0
jan 24 23:32:23 nova kernel: nvme nvme0: missing or invalid SUBNQN
field.
jan 24 23:32:23 nova kernel: nvme nvme0: Shutdown timeout set to 10
seconds
jan 24 23:32:23 nova kernel: nvme nvme0: 8/0/0 default/read/poll queues
jan 24 23:32:23 nova kernel:  nvme0n1: p1 p2

nova /home/frosteyes # nvme list
Node             SN                   Model                            
        Namespace Usage                      Format           FW Rev  
---------------- -------------------- -------------------------------
--------- --------- -------------------------- ---------------- -----
---
/dev/nvme0n1     203982290001285542EC Force
MP600                              1           1,00  TB
/   1,00  TB    512   B +  0 B   EGFM13.0

nova /home/frosteyes # lspci -v -nn -s 1:00
01:00.0 Non-Volatile memory controller [0108]: Phison Electronics
Corporation E16 PCIe4 NVMe Controller [1987:5016] (rev 01) (prog-if 02
[NVM Express])
        Subsystem: Phison Electronics Corporation E16 PCIe4 NVMe
Controller [1987:5016]
        Flags: bus master, fast devsel, latency 0, IRQ 42, NUMA node 0
        Memory at fcf00000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
        Capabilities: [e0] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [f8] Power Management version 3
        Capabilities: [100] Latency Tolerance Reporting
        Capabilities: [110] L1 PM Substates
        Capabilities: [128] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [1e0] Data Link Feature <?>
        Capabilities: [200] Advanced Error Reporting
        Capabilities: [300] Secondary PCI Express
        Capabilities: [340] Physical Layer 16.0 GT/s <?>
        Capabilities: [378] Lane Margining at the Receiver <?>
        Kernel driver in use: nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
