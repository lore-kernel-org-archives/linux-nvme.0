Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D4C19F2B
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2mt1O7SWjFLHD1EXE6V9UmPR5M2z7VMStRoTnCj5Bjo=; b=0wM8ug5l9t/lg5NKSZczBTktFx
	cFaULzJ2+wIwM8TzptqMLILSkoFyOLSL4rV/MitqJ0v553dHtB0rcE561V4dY5bEQ7bEXwuQyUt72
	SK8xSNTQOXEhKDcUVQCLTPNKarvrdmATdxPBS84BsPkILUVgI8HPRyTSmhV3Zjxw+xwDZDNx1FG0+
	eGY189ekrel78rZQA4Hu7Xk2c4WgvUpTuwXwY2fvnM7WnKVijlJZrmfVVUwSOPcGX77p4my7dLdHb
	zepZHYpHbnCySIqh5lXkUlDT1ayK22lx8PnkIjuayFCZjXqDs8D6oMIQVl2GzD7lmWEf2dB5DDai3
	UoM2S1AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGshZ-002WDN-0F; Thu, 28 Jul 2022 01:52:37 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGshU-002W9N-U8
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 01:52:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658973152; x=1690509152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKUt3pFI0/Q=;
  b=Enj0KKA1eKTg3TpYg4dyr8t1BZ0ppV/zBxVTKiCypFmaAOA67uDIbXa3
   jONoHqsMe/L+zKNH5mc9IbYt1CdYDvRfoOOc0EnwGnUlTVOr6mwuY2HL6
   6EGcSinmvA0StbxRbxkvsqgVDWXJWJQ8d6/XeocDZZe5LPRkuElom5GlH
   ungbB0O0aq8/GZiEJ+e7jAbG5RksMf/8liix4L17SnYJB6enVEwH90RU1
   npn2z4qFdx/7S4IwQNKdByAPwt4Xlu+HNIcK3GvqsrYEBhafSI2sqB1ra
   QV3ARiT221IVHlunN/qrISLBML24S4fPC+qZpL3ya5Ck5K6LIM/ThJiAc
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212058728"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 09:52:27 +0800
IronPort-SDR: QrW3dsvR2nMg/X1R1cI9RdOegnRNjjwBacoGc7QxIyZCjf2YLS3+Tbst1eCod9BvhZgGOTKp45
 Mif6h6XofM2MAhGjark8ngV9OBIChk24hOMWtWVxAWs7m8LKaGITMCgseGvZmtSCQAwutswzXd
 Mz54hf39tDZ/k/iq9a18VEmj6j0PXwVZQz5m3nu1VCoiE9Pz2+7PDH3dhi2kphoItNsXVRv1wZ
 UQsvo1ev+WbKoF6/xSja56DnSPXKJdNFhIs/V5cJPKB2OdXm6CzAvCGqNY3C1LUFb1qAk0GOBe
 4wzt1ypug206/+aoNdag/MbO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:08:35 -0700
IronPort-SDR: HegMeiSjNxicxsvIj33c1Inp8fAYOi2cbRt18TAz67kLg6R39cgEuhjxImMQh40Rci/x30hzhM
 Q3Tz4xbcXhwzsYebEkhwJ9YQvP1k0yIGFeEQyInDrCYGZX2yd3/v03kLDKqxmS9IRNTm2kllLB
 w1wT3xKcPym8fd8Ck7iIlywQN4q8MC5I2LhCDuLyNXQbuZkR5vB4pcXggU2umTnnBWBpmPX+2K
 0aO4jpZi0c+raEZbDUgj6AfQjWu6zyeRII585C0wr3lBKmhaSm4NEM2MWCW7VS/sb10/ANIz9j
 pW4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:52:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtYYl3RfBz1Rws6
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 18:52:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658973146; x=1661565147; bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKU
	t3pFI0/Q=; b=F2iFvoSMiJbccMADjVAZVn3gxWlhNSCpud0qSERpSOd0Ry5Xo6F
	81dY6m6tBCK2oCJXK4dOrRJS7yNisxUJtbfIfLOGG7EjrS5D/amN0FY+Hzj45R+L
	Oe5u5/l77XqslEMw0POtUwr7nVVYFzCyx/bcl3ycltBiovl0G1yxk50QbnjCapjx
	VG/XkGyfKk+WK613YwwwKpQXFZn+ty9vLUAVcqOYeXLtobUoJcygQwMnnLylXPYx
	RhXfOrxRLu3TdBEledwgd0z/EubL2m3Y60eLOH+lQW5gcXeEwhv7WiaAVoRGRAzO
	KZB8F0gXFZOk2ZhFee8Ub4lkhrskmA2GbIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nKt4C6ShEgGj for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 18:52:26 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtYYh12zFz1RtVk;
	Wed, 27 Jul 2022 18:52:23 -0700 (PDT)
Message-ID: <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
Date: Thu, 28 Jul 2022 10:52:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Pankaj Raghav
 <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk, snitzer@kernel.org,
 Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, jaegeuk@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_185233_033372_C74962E3 
X-CRM114-Status: GOOD (  16.39  )
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

On 7/28/22 08:19, Bart Van Assche wrote:
> On 7/27/22 09:22, Pankaj Raghav wrote:
>> This series adds support to npo2 zoned devices in the block and nvme
>> layer and a new **dm target** is added: dm-po2z-target. This new
>> target will be initially used for filesystems such as btrfs and
>> f2fs that does not have native npo2 zone support.
> 
> Should any SCSI changes be included in this patch series? From sd_zbc.c:
> 
> 	if (!is_power_of_2(zone_blocks)) {
> 		sd_printk(KERN_ERR, sdkp,
> 			  "Zone size %llu is not a power of two.\n",
> 			  zone_blocks);
> 		return -EINVAL;
> 	}

There are no non-power of 2 SMR drives on the market and no plans to have
any as far as I know. Users want power of 2 zone size. So I think it is
better to leave sd_zbc & scsi_debug as is for now.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

