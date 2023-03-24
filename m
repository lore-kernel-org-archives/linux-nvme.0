Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00600C76195
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atSydaWWogGmie+bXLe/hDMQRjB7ehjqFFKQ0tFB73M=; b=fqIxlIdcx2SK/WbJXO+NLp8Mpd
	2InLyepUQg9z6RQ7zJ0wkXNv86yFjsfsP2qVYu5WDRJCAlFfgIYw3OFOgi1Ms4ed+L+Wca43WwEWa
	2P5lHGmCPdTATqYI5i924iPjKlOm+/MtRLNliXFYWmpxxCxhmWWTPcJdf7d2KCcZebpcY4/qnh4ZH
	WR71qTGxJCxS+GMYrWX/u0hs+IpV0gBHOqNfQfP3thtU7+VWpFlqkRmFoA8IWRK30HgcZm7wZxZa3
	vew8eWIynAZagUaAVAlH5TW3pdV28YQ8J1+zzEbywa+bnsXtZO7jnPOG2aRCkzW/gYsTnJJ1Apz1e
	/MFtM7fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfd1e-003tx6-04;
	Fri, 24 Mar 2023 08:43:54 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfd1a-003tvq-0g
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 08:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679647430; x=1711183430;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xfIgYAVnppzojaCIrJeZDPnuu4T3w+KOZAN8jJXyGQY=;
  b=Nwv7vTQp4+BT0DAgaExRNnTe7DBF/prtxmUASH6FOc/Y54bdj5yLlh/Q
   sJpnJuhXB0/2o7+cChW8oUzFm9QU4FUi4UyEcJPQ08tQqwwFDUVHNFXAz
   6H/8BO3I1/ahkYxXAdAc/HuS77S3Cl/pO1IZaao8hjR3SO8inSHxQ/6Gc
   rHanQ3t7TpyNeS4VuxRTo7X8uV/hEoQ/S8JTpw1a9FmsjikmqVWpfvTWP
   Ib+A8D0/0y/3Iys7/41w33/uxOSEqaGFmgNyiRmnn0xmcsZqS+pxm3G4F
   OI6FCIefCeg+8/6enyNc2kDOHBUjYhQ3+IBYCQirSqxvhQYYytzx5Fgr1
   w==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673884800"; 
   d="scan'208";a="338472126"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 16:43:44 +0800
IronPort-SDR: 2bLYKLzHqFd2gD+AJ/yIi6L+5jkwO+2Ss1WKpMQ8WKpZIcH5bxvkYtsu+Kz3y7b47nJkvfxOtu
 hSSaH/1fOFbGyv7nFPmq4yYwpUc0hBlVJdegpxr2sVBkfSF1FoGCtf8mAKY9clztEDfx+Ll9m5
 KX0STlBFAytAJxS/TaGm9+7kVou433jUTKO5Vuye/unJv3j+A2omI89f1xQocXg3gMjMSwJ7Nx
 xogtK8Gt538EPE6PFzikw+Qfsj9PBws2k4rqkjSpkv+tYtlFdVmkDATE/wkBLp0+CPKzRmdxDg
 RG0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 01:00:00 -0700
IronPort-SDR: XvP2i8zk8jtB029SeWLxUpQBS1kBdDSw8AmYp5u8YTlqrj997ELJ6hAx6mWStgEMn5CCAoliE9
 QsCOCnh01y/6As9hFhhjSm7yG0M1a8Pb3sGneNPvWObB4iQEJY7tYeEujFhLQOFBBhZtkbeIiV
 RCr5QuLqP3h5n+G9F4kukYNm/lu8bbWNlasYdu2UEuwiwlw1ddnB0UgLv65m4T1Z+XEmM4wCit
 hWMAdkKcAYEuilviRj+DLb1k2gl0aGWj1IUnGEJtK4DVrjEiEny8ws23wa4QtFpmQgnXAsSfUa
 PFk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 01:43:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PjbN04Vm1z1RtVp
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 01:43:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1679647424; x=1682239425; bh=xfIgYAVnppzojaCIrJeZDPnuu4T3w+KOZAN
	8jJXyGQY=; b=UIOOZNPbig2n4O/tndqp4OwT5NEYakG15tDWTMB8Wo7cQYrJxo0
	y7epbBeC9KcFcehwW2IaH21JkwtbNnanwkIi0GDJul2EGdfibiadWfUmFVKJOoPb
	ie40OGgssHv/+DSfEUsmxfEd2zjOu+puohjM6Ho4hLpWPnJJuaucWSjh44U3Tglj
	0Fs2NL+9+Z19QrRntMVHSHTC+lIZd9WFzVpToft7BuofpQKYLSsYIFiuaGoJwzwN
	JxGA3JIDLKB8Gk5nuME5onVVcDXFP4QlIFHkWudfk8gjYmAXjptgXI5EcWXP5+mg
	jB+tIUvJLzHh0OkJiX2euYRQ72syPh78M+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fD1_M2lh0Atl for <linux-nvme@lists.infradead.org>;
	Fri, 24 Mar 2023 01:43:44 -0700 (PDT)
Received: from [10.225.163.103] (unknown [10.225.163.103])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PjbMz5TyRz1RtVm;
	Fri, 24 Mar 2023 01:43:43 -0700 (PDT)
Message-ID: <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
Date: Fri, 24 Mar 2023 17:43:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Content-Language: en-US
To: Alexander Shumakovitch <shurik@jhu.edu>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <ZB1JgJ2DxyTMVUHB@hornet>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZB1JgJ2DxyTMVUHB@hornet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_014350_304373_4AEA900A 
X-CRM114-Status: GOOD (  36.95  )
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

On 3/24/23 15:56, Alexander Shumakovitch wrote:
> [ please copy me on your replies since I'm not subscribed to this list ]
> 
> Hello all,
> 
> I have an oldish quad socket server (Stratos S400-X44E by Quanta, 512GB RAM,
> 4 x Xeon E5-4620) that I'm trying to upgrade with an NVMe Samsung 970 EVO
> Plus SSD, connected via an adapter card to a PCIe slot, which is wired to
> CPU #0 directly and supports PCIe 3.0 speeds. For some reason, the reading
> speed from this SSD differs by a factor of 10 (ten!), depending on which
> physical CPU hdparm or dd is run on:
>       
>     # hdparm -t /dev/nvme0n1 

It is very unusual to use hdparm, a tool designed mainly for ATA devices, to
benchmark an nvme device. At the very least, if you really want to measure the
drive performance, you should add the --direct option (see man hdparm).

But a better way to test would be to use fio with io_uring or libaio IO engine
doing multi-job & high QD --direct=1 IOs. That will give you the maximum
performance of your device. Then remove the --direct=1 option to do buffered
IOs, which will expose potential issues with your system memory bandwidth.

>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 510 MB in  3.01 seconds = 169.28 MB/sec
>     
>     # taskset -c 0-7 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 5252 MB in  3.00 seconds = 1750.28 MB/sec
>     
>     # taskset -c 8-15 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 496 MB in  3.01 seconds = 164.83 MB/sec
>     
>     # taskset -c 24-31 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 520 MB in  3.01 seconds = 172.65 MB/sec
> 
> Even more mysteriously, the writing speeds are consistent across all the
> CPUs at about 800MB/sec (see the output of dd attached). Please note that
> I'm not worrying about the fine tuning of the performance at this point,
> and in particular I'm perfectly fine with 1/2 of the theoretical reading
> speed. I just want to understand where 90% of the bandwidth gets lost.
> No error of any kind appears in the syslog.
> 
> I don't think this is NUMA related since the QPI interconnect runs as
> specced at 4GB/sec, when measured by Intel's Memory Latency Checker, more
> than enough for NVMe to run at full speed. Also, the CUDA benchmark test
> runs at expected speeds across the QPI.
> 
> Just in case, I'm attaching the output of lstopo to this message. Please
> note that this computer has a BIOS bug that doesn't let kernel populate
> the values of numa_node in /sys/devices/pci0000:* automatically, so I have
> to do this myself after each boot.
> 
> I've tried removing all other PCI add-on cards, moving the SSD to another
> slot, changing the number of polling queues for the nvme driver, and even
> setting dm-multipath up. But none of these makes any material difference
> in reading speed.
> 
> System info: Debian 11.6 (stable) running Linux 5.19.11 (config file attached)
> Output of "nvme list":
> 
>     Node             SN                   Model                                    Namespace Usage                      Format           FW Rev  
>     ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
>     /dev/nvme0n1     S58SNS0R705048H      Samsung SSD 970 EVO Plus 500GB           1           0.00   B / 500.11  GB    512   B +  0 B   2B2QEXM7
> 
> Output of "nvme list-subsys"":
> 
>     nvme-subsys0 - NQN=nqn.2014.08.org.nvmexpress:144d144dS58SNS0R705048H     Samsung SSD 970 EVO Plus 500GB          
>     \
>      +- nvme0 pcie 0000:03:00.0 live 
> 
> I would be grateful if you could point me in the right direction. I'm
> attaching outputs of the following commands to this message: dmesg,
> "cat /proc/cpuinfo", "ls -vvv", lstopo, and dd (both for reading from
> and writing to this SSD). Please let me know if you need any other info
> from me.
> 
> Thank you,
> 
>    Alex Shumakovitch

-- 
Damien Le Moal
Western Digital Research


