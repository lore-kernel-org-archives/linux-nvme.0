Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9F2C27C42
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cwK/9qb93uefmOwiM9L7eoX9EqBo1PHGiY0SO/DNWXQ=; b=hAQuMHl3FojZXrjg5nkBO+hVuA
	mgT/+r8/y6bRexRhAtKWxSfCOD1Q+87CYXUQtsqQ0eGHWgyzfBMEYxWSgH4+FUEsX9ndz08VBti3k
	+YwJmLL5G13LFfECOIqO+B57xXwKP3kjBNGz/QgPb7qb4EQTo0X5IC3Ln+XkUQgzXNGQdUdbVBoK6
	ij8VH1rij0dzb/hGA4Q8v2j9T24PO2s9PofXGPLwnHI0O9all5Ms9TmYPQEBNYQirK+PVBzt9f6wL
	WiEz6q2ClL47rqSGQ/h13Aa13plpM5v2OpgcwX/ygSIoFsQGzcdvlrPk8aAF7N79N6MteF5CzexK5
	qMqBZgPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWNIs-004xt7-1O;
	Wed, 16 Aug 2023 20:39:42 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWNIp-004xsl-2b
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 20:39:41 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 0CD98480AB8;
	Wed, 16 Aug 2023 16:39:35 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692218374;
 h=message-id : date : mime-version : to : cc : from : subject :
 content-type : content-transfer-encoding : from;
 bh=cwK/9qb93uefmOwiM9L7eoX9EqBo1PHGiY0SO/DNWXQ=;
 b=8uUWVzaOjcnNARkelIFzXv8PnV0r5M/UL/yy72gIdxuL3WTv95m/zJMcIlc/4bydwQyDV
 muaGv2h/J5CdR6GDg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692218374;
	cv=none; b=PsUJiXEGnDabzl9uwToLeXToWFtmQskJscXyt9qo4isQxpfinK7cOqM9tcFjd41pLNWCS+RVCNbAW6J/x+2hZuRFwQnvQiHQofkHc5BKrn1uW29VPQFW0oUEqCcmzkX90CdZ/wc1Kg5Q3JjK5y5S1uCGMKCJCPibbkUZFg3rmswac7s5gheGPmc7/oOlGZasIzE2CWLcA4Lap1jJMn88pWU5sFrQs0W5tFN6T6dZdm8hqn+2TsKuQIIBUjWQwd4L0VBPlzokwZb7w7DDCWuCGs6NYna6rQ4WdvHOiUDf/WuY7GZ8oHXVeb0oW1NPhmdYXcrocL6bdqAmRK8Jxan3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1692218374; c=relaxed/simple;
	bh=PiSNuZkOfyb48JGDdwOkAi+WrfYdMcst/w+0ai9sHm8=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding; b=UJx1vNjT1prLNd4vRLm0xD/vL1MJTvbn4CWcVYkzp9jZVMtv9C2pkk4Egoj2SuMkCZngGP4eWhGCFR2YOvPUKbZgcxBWUWlE9sMExCMCbjLzgIhCmd5+c4FQerNYtq8lI5n+A45X9aQGh1oH5xvTZ2oB/4T7WiuYz1cOy8rTsdQ37BmNh9DWETCHuUdYyO1pJcsMXlwBnmdsQO/cwleGXwhvWO/s2mhZzGenodTumaBrfeJQYD0/mAa3HcldU7/LeDyezUT1+JcxWwX9fkD5o75G4mz9IA7surleRCSBFgxYpt52QfGr63lEwgNtx+3uonzyLPDm8tI3J2qlM0DO4g==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692218374;
 h=message-id : date : mime-version : to : cc : from : subject :
 content-type : content-transfer-encoding : from;
 bh=cwK/9qb93uefmOwiM9L7eoX9EqBo1PHGiY0SO/DNWXQ=;
 b=AsIg5l8CarmMYWZ4R4WWtokk0DIFEMGDU3YvQnsEp7eoxW2Mnkg4Oxh2IVgxt1EjQiq6r
 vFdfkGcDvjJwjpRanpn7EXj6zvC6zMGPhy/75VF4ZsZydNje/3UudVH3zrbekYkQWgaY9vz
 lgVChL4M5UMQEwVt8N7/KlAjdqcc/Ip0Yg0Z5dUG3d2HgP7my8hsaay+E7aPALJU9GeXnBN
 7IsICzxT6/9PZtYkKy/ZB4y5RCUZwSbJ40WNqUOk5wHlmVEtelgKpVeJccGxQmAZKa8JT84
 RCtjN18zk5+qnCtbETYxzxs1dcxCYp4vwqM/te4H7R5FBpQHfvx7CJIh1lzw==
Message-ID: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
Date: Wed, 16 Aug 2023 16:39:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
From: Genes Lists <lists@sapience.com>
Subject: Possible nvme regression in 6.4.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_133940_006601_FED55DE1 
X-CRM114-Status: UNSURE (   8.79  )
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


Also reported to bugzilla [1]

Failure happens on 1 laptop with samsung ssd.

Boot log manually transcribed:

kernel: nvme nvme0: controller is down; will reset: CSTS:0xffffffff, 
PCI_STATUS=0xffff
kernel: nvme nvme0: Does your device have a faulty power saving mode 
enabled?
kernel: nvme nvme0: try "nvme_core.default_ps_max_latency_us=0 
pcie_aspm=off" and report a bug
kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to 
D0, device inaccessible
kernel: nvme nvme0: Disabling device after reset failure: -19
mount[353]: mount /sysroot: can't read suprtblock on /dev/nvme0n1p5.
mount[353]:       dmesg(1) may have more information after failed moutn 
system call.
kernel: nvme0m1: detected capacity change from 2000409264 to 0
kernel: EXT4-fs (nvme0n1p5): unable to read superblock
systemd([1]: sysroot.mount: Mount process exited, code=exited, status=32/n/a
...

All kernels are upstream, untainted and compiled on Arch using:

  gcc version 13.2.1

Kernels Tested:
  - 6.4.10 - works fine
  - 6.4.11 - fails
  - 6.5-rc6 - fails
  - 6.4.11 + nvme_core.default_ps_max_latency_us=0 pcie_aspm=off - fails
  - 6.4.11 with 1 revert below - fails

     Revert "nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G 
and 512G"
     This reverts commit 061fbf64825fb47367bbb6e0a528611f08119473.

Hardware:
   model name      : Intel(R) Core(TM) i7-7820HQ CPU @ 2.90GHz
   stepping        : 9
   microcode       : 0xf4

nvme:
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller SM961/PM961/SM963
         Subsystem: Samsung Electronics Co Ltd SM963 2.5" NVMe PCIe SSD
         Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
         Memory at edb00000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 00
         Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
         Kernel driver in use: nvme




Gene

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217802

