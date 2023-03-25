Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E9C76195
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Mar 2023 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCaITCUIb7n0Nf9Jw4YQIA71pCsf4sZJzLupQDIMpyI=; b=Ovo5+SWBGnIZJoQ8qTLB6AzWnc
	WNmo1vMcereovBnBshYaSXdcSx62lG+WoqxfhxWKXCU/bUXg5HTijJKu8AquDvYshiHl9P+gHLkt9
	r/ZPOIVLwwFeHqomlRFPFuTyQP2dy3Nv0+NaX+yaOwjVdmpdHxchWCvdu3mrx2ldCGKHCqMue9DU9
	WDv9zZH8vq8PrRimAX1Hng7nR7qa4Fp12osmoecx22fiQ0PIdpkAnY3BgjeHieee39XvXODcSoo6W
	HZHPIVcGtyBDAbpXTSsmgyk6v25w7D72ZNI3TRVLlbibTl5pA265P/ejgQYhMxxpQWmw9IrQ1VmfV
	xU/xDpXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pft4o-005wjg-2C;
	Sat, 25 Mar 2023 01:52:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pft4k-005wj7-1z
	for linux-nvme@lists.infradead.org;
	Sat, 25 Mar 2023 01:52:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679709130; x=1711245130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+e0u94M4mFWy9NggJ2J8dTAr1xTZX3vES9dfSuZoUE=;
  b=OMb2D6BALd/Z6tmafG3gjYif0cbW1yTe+oIlzMgB9WCW9EGNtUQ27fGs
   8d/AZxX8H3m/qiB5JNBs0YUhDXKwRddBEm9vIeyhSxTzXZLRnoNd2bAJO
   4mZVOrIrub/i7I7xxdaJ18R1ilCgC/33jQydchJhRjehtCbQ1fncOO5Pd
   YQVH+veiqUUDZ4zltttJYx9ATeW+J07WaI5WpWtMkMfL0ZNThm564/wYC
   am4MlQK5AG+TkaYwAj/Kne+J9smS8gDlSwI8Q1uTbFh1zSbd086HXwrUS
   C6Y5WL+uypGJOPGPU8ibec/gKqWTnZG5txewXBB7Cd/v+eWdNSPdSSzss
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="226276152"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 09:52:05 +0800
IronPort-SDR: m1LrNaoONHnAg79EVG8ncCyA6I5PsIJfIiH7N2vXzxnudSjJdYGIoMEc+5EoS3vVRLo9L6Qysn
 K/kDg4B7bU1jTDky+Zn7RHDG+uDPrfj/J3Y3pLwFiY23/9xwGUEMxeurzjThJ+Uing5SkVLb35
 1+bSUcQ7+/nn2xkujfQm1D14yCRzMHzA+bMrW+9VtjiMDNbaA2K+sz7xUbKR3f3OSWxp8HNt2R
 LAJA7XF+WbDpMpE8RH6Uf3jcxCeqp6pxAdlShia6pTNgy0suadsa9HsfKPVq1bccW/fFkSvMhi
 00Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:08:20 -0700
IronPort-SDR: W8R9R/dpTRhGMSroIo2M4Y+eNyghZOcKI3NZegj2LhDL78ocwYOB9/YVvygZ4xfmqjfSH9hDCM
 s7utRQisjW0ITlzyBqDf9SYTDguqYTB5OyRb6bLn3svrIC/7TOfMDhU3AOn0sdtRKiZmBC8Dlr
 WUjK851KUaVaRchQyThWeMxcdQ8Na2xXF6cynA2ptDesE8XeLXYIPszUq2QrNG3a9NMOU5V6mf
 fKOp7CmuOFMDTEDHbj2DaKymUs/+X63N5cBNtxax6ZpxZyg6m/TLjfGfROhlDr3BIT41wkodPi
 53M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:52:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk2BY0BB4z1RtVn
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 18:52:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1679709124; x=1682301125; bh=5+e0u94M4mFWy9NggJ2J8dTAr1xTZX3vES9
	dfSuZoUE=; b=afpr/pk7GCrlrkyVF/Ym/0QBUoGxMV41eAEHybSiRYf/06FzUoM
	D6oln6poXivi/9iJaVGjtOLiTVC1NjwmQUVKLBgs7U7nL893iI6q10ZerdSP3q03
	LfUzHdPNwPYL0eWH55fKvlbNrZ3HSiuxp5DDjczDvVO/S0lB8Pvzy+vbqzUuNPYh
	WWDDyQ0baAvjVoy5dx9fhvtOMjqtfianmNaUPkotHDSVrWj3BQFg/UGVt9YG8XBF
	oIg/6qeGOJ9zmM1OL5TdTkkLrL44PudtG814dqheiq5wVD+BDF4WVudYwwqREmDb
	19zLxM5gVSRGEEE/WYCHMX3e6rk/a9yBIfw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hAFnLBDIsbqm for <linux-nvme@lists.infradead.org>;
	Fri, 24 Mar 2023 18:52:04 -0700 (PDT)
Received: from [10.225.163.103] (unknown [10.225.163.103])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk2BX1kbZz1RtVm;
	Fri, 24 Mar 2023 18:52:04 -0700 (PDT)
Message-ID: <67d3d0c7-afbb-98a2-4ce8-4d93dbb82663@opensource.wdc.com>
Date: Sat, 25 Mar 2023 10:52:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Content-Language: en-US
To: Alexander Shumakovitch <shurik@jhu.edu>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <ZB1JgJ2DxyTMVUHB@hornet>
 <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
 <ZB4Ty1L8Xa/qMQiV@hornet>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZB4Ty1L8Xa/qMQiV@hornet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_185210_750920_3174841E 
X-CRM114-Status: GOOD (  27.71  )
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

On 3/25/23 06:19, Alexander Shumakovitch wrote:
> Hi Damien,
> 
> Thanks a lot for your thoughtful reply. The main reason why I used hdparm
> and dd to benchmark the performance is because they are included with every
> live distro. I didn't want to install an OS before confirming that hardware
> works as expected.

You could install the OS on a USB stick to add fio.

> 
> Back to the main topic, it didn't occur to me that the --direct option can
> have such a profound impact on reading speeds, but it does. With this
> option enabled, most of the discrepancies in reading speeds from different
> nodes disappear. The same happens when using dd with "iflag=direct". This
> should imply that the issue is with the access time to the kernel's read
> cache, correct? On the other hand, MLC shows completely reasonable latency
> and bandwidth numbers between the nodes, see below.
> 
> So what could be the culprit and in which direction should I continue
> digging? If hdparm and dd have issues with accessing the read cache, then
> so will every other read-intensive program. Could this happen because of
> the lack of the (correct) NUMA affinity for certain IRQs? I understand that
> this question might not be NVMe-specific anymore, but would be grateful for
> any pointer.

For fast block devices, the overhead of the page management and memory copies
done when using the page cache is very visible. Nothing that can be done about
that. Any application, fio included, will most of the time show slower
performance because of that overhead. Not always true though (e.g. sequential
read with read-ahead should be just fine), but at the very least you will see a
higher CPU load.

dd and hdparm will also exercise the drive at QD=1, far from ideal when trying
to measure the maximum throughput of a device, unless you one uses very large IO
sizes.

> # ./mlc --bandwidth_matrix
> Intel(R) Memory Latency Checker - v3.10
> Command line parameters: --bandwidth_matrix
> 
> Using buffer size of 100.000MiB/thread for reads and an additional 100.000MiB/thread for writes
> Measuring Memory Bandwidths between nodes within system
> Bandwidths are in MB/sec (1 MB/sec = 1,000,000 Bytes/sec)
> Using all the threads from each core if Hyper-threading is enabled
> Using Read-only traffic type
>                 Numa node
> Numa node            0       1       2       3
>        0        25328.8  4131.8  4013.0  4541.0
>        1         4180.3 24696.3  4501.2  3996.3
>        2         4017.7  4535.5 25746.4  4105.7
>        3         4488.1  4024.0  4157.0 25467.7

Here you can see that local copies are very fast, but 6x slower when crossing
NUMA nodes. So unless the application explicitly uses libnuma to do direct IOs
using same node memory, this difference will be apparent with the page cache due
to balancing of the page allocations between nodes. And there is the copy back
to user space itself, which doubles the memory bandwidth needed.

Use fio and see its options for pinning jobs to CPUs and using libnuma for IO
buffers. You can then run different benchmarks to see the effect of having to
cross NUMA nodes for IOs.

There are plenty of papers and information about this subject (NUMA memory
management and its effect on performance) all over the place...

-- 
Damien Le Moal
Western Digital Research


