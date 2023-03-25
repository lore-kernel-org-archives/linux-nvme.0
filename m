Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6ECC76195
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Mar 2023 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50Hpltuz7gILJXdYqiaR2VyoR0ZxzFiM5PUoGrJ7RVo=; b=UVLSDif8tuxYnLsZuobS8ksXjS
	7g5xmouaKGLRh8HwsGpklfdm0V3wV5+t2LG37a+U99TYD7YFA2yxAD8frV5lgCZnb3tvkljaZeGRK
	8slg7Y10nnyF/RHSUtG4ppYfoTak2W/0N8JsiDt6d+7UAXYijO23CmGh5oAiAJIz2rwNvzYluNTQI
	IPhON7drnMOHHB17MWJunxb22QATEMdUm86mEjGJsA6DAonZYqgtvD/uThaIj2yJi8z9v3tPPAyVm
	t40pDfQXZ1/CLjn6rCpr1HpmiB8bqRYOianWhf85HPIwskaO1DnqZ/kYSufe64MgDeMFi6QWEjm+d
	ZGikAznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pft9E-005x78-1U;
	Sat, 25 Mar 2023 01:56:48 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pft9A-005x6E-39
	for linux-nvme@lists.infradead.org;
	Sat, 25 Mar 2023 01:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679709404; x=1711245404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BRmU2x6Fs/Qn9KNGpIyLY/DFC/CnREgasv/Miq3ozMc=;
  b=K1gE/Rh/n/YoUr2TcXLTcsQfTmpzlThE+Ly4jE8dXwhb6+sisM33UNVY
   CNLlvQRJ2MHtXSbjbdrCagWCm6VykauTyVs43Yb9EYt8ihehgxKhn4yHv
   idb50k9o1ILEJdxQkC6HDdz9uSXzPoUYLxWyLKaMSKJvcn3wPY3dfMYri
   XGukaXbfzUEVX/+8kNdU4t1Gal1ifiOFVDTaYVGhPC9zhxwkOfQsIBAZb
   Ueq8+/8Jj80rB5dhIkWGeB/CQOYIhgDo+tZ3bi4wkFvwNC7e0LAKs5ppA
   daTQq+FJCdKGW4pewSU+5gvIN/DSRjXRJ/xkwlbSaw8NRxSyeeJz7Ob4s
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="338526936"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 09:56:39 +0800
IronPort-SDR: jzYtPG3Jok0/bId/vEeiUlQ/rW0WexHdjDwdydLSlZJENcfp4EpK5vPp+BZAQoq3mUPOSHI1Aj
 3GM3559/27CFRYFuY5VoxfrjT3rhI4Q5jMYZZ4uiNhcPpawUIo3ZGHkCjKjKiwVs1WV9/IMykC
 fJHkCpSv7dbvh3Yxun6LbTyUwZY9u9A95NRdPt9mfNHz9nPpZpJuvG6D9dI9WTzIqr7+4ilVaW
 XJksX3YGOxfmUDP8uoQRCeLsS4Pn+BhZW3gjAAfMnAyLNqpOsW0Tsr+tdoSeAfspS97kdtBZ8E
 HNc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:12:53 -0700
IronPort-SDR: IGrjxEeRbzsmYdf7/465diaDv5TMMDuUoYv1u6uQ1YMYfuYgSEmA4rkOgi/pMZhULsgopw9n3G
 Qh9B1353md+xUUTjBor6NqQkgCZbehgxWQukfmLF0rvV165p+1J1oAzv/wVGzIXEk7/eFScTWz
 A6KghOE2WiYsCUE5bhyPbmJbMgCVCjGu+/kLYa51yNU5ibkCLk9JdrSWKcRmaoQ3YyAvkArmic
 5w36bDg0vXrhbMUUkmd2AX4e3wi38i/PguyFus4XhRwvYUnRfZECaciOe7SeCAUrWL2htu+kJh
 nrE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:56:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk2Hp5jjmz1RtVp
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 18:56:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1679709398; x=1682301399; bh=BRmU2x6Fs/Qn9KNGpIyLY/DFC/CnREgasv/
	Miq3ozMc=; b=UPq6xr7cSSBSHMHxA7mN6VbI+t6d+QcR4meG8LIR8Oc8dc7KBXt
	T8cnh4vdfAa/7ZfWTSVgcFJ0oREUFVX2zgDv50WULyO28gc3WBkWLDBd36t7qqE1
	6WyyuHkNfd+fPrQRzdGbM8ccOf5gz5C7dLrl27H8DUss+NBjDE5eq4S5kq3oW4/e
	ODv1osWYi80ZzZjKbJ4e/Q41LmCNKUavUklWo4T+6HF9EQL94Pu7dVsS9O9yo5wn
	ci9UZdg+JU5YfiorCtbsM4IUcwL6Unu0n95eYqxSH7A8t2e9a8+gOzUl3yglWRv8
	sHNezdvkmK4Gkbuk4DOEDP4iNi0J4nq1QgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RWcAp2wBO8mY for <linux-nvme@lists.infradead.org>;
	Fri, 24 Mar 2023 18:56:38 -0700 (PDT)
Received: from [10.225.163.103] (unknown [10.225.163.103])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk2Hp0SzLz1RtVm;
	Fri, 24 Mar 2023 18:56:37 -0700 (PDT)
Message-ID: <7e35cc20-1939-d303-a559-e8562a917578@opensource.wdc.com>
Date: Sat, 25 Mar 2023 10:56:36 +0900
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
 <ZB5BSJgeqaOkiXFF@hornet>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZB5BSJgeqaOkiXFF@hornet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_185645_022087_132C060D 
X-CRM114-Status: GOOD (  20.04  )
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

On 3/25/23 09:33, Alexander Shumakovitch wrote:
> Hi Damien,
> 
> Just to add to my previous message, I've run the same set of tests on a
> small SATA SSD boot drive (Kingston A400) attached to the same system, and
> it turned out to be more or less node and I/O mode agnostic, producing
> consistent reading speeds of about 450MB/sec in the direct I/O mode and
> about 480MB/sec in the cached I/O mode. In particular, the cashed mode on
> a "wrong" NUMA node was significantly faster for this SATA SSD drive than
> for a NVMe one at about 170MB/sec (both drives are connected to CPU #0).

That is because the device itself is slower. So the page cache and NUMA overhead
is not really impacting the results. Try and HDD and you will see that it is
almost impossible to measure any difference.

> So my question becomes: why is the NVMe driver susceptible to (very) slow
> cached reads, while the AHCI one is not? Are there some fundamental
> differences in how AHCI and NVMe block devices handle page cache?

Because the device latency is much lower. So relatively, the overhead of the
page cache an NUMA is much larger. That overhead in absolute is the same as for
any device, but compared to the device latency, it is a small % for slow
devices, but a high % of the overall IO latency for fast devices.


-- 
Damien Le Moal
Western Digital Research


