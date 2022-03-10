Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12047C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRNE1Q3UHcAv6Ct12abpAnXUsUnbwAcbxOzLZWSk128=; b=IDpb26X80xYFUegK3Wtasx814b
	0631MmucD9Z263mmW/sLP3QlPves8pw709rUBozHuk7wlSKHB37mRYRIPgPXXzNjsxV8OICrUEdFV
	gpdwe0OEncWbBLOUtqgkLj9zGU2NrUMsGuZfI4oE946KqocZLAiul3FBvBxuxqsi4cROe8RdZ1rwm
	yyAaTxE73p2KmqYDk5QGU+pDed98k6WKRaY2E1oFVXYxAzbR2gy5IPimXfwHtpxJGEMf7kkWI2xMR
	wx+CSNdvqoP6armGT5OS342HQPXdqIqWBinlENhJJND2vI4mrX3TmsiC6h66/iaVk4ER6wallk8x9
	4co/SSYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSKWn-00DJLB-Lc; Thu, 10 Mar 2022 15:16:33 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSKWl-00DJKY-0W
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 15:16:32 +0000
Received: by mail-wr1-x42b.google.com with SMTP id r10so8526254wrp.3
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dRNE1Q3UHcAv6Ct12abpAnXUsUnbwAcbxOzLZWSk128=;
 b=j9fj+0YOsW71ldzLgCBoUAGcbVKjFIK6ZRvCAMZRypA/XSyKwDDMydzdGnTXQtDQHm
 ixEaVK1IyqfaAPq1O6W67jzIO0cFZcmjT6I1DcPxOwvehTFhaw2+Xi2K3NsROy8CjG7W
 qmJ/MmZ43pez3z9Aan/E/w+zMs/qFZ7qKcwpI2d4FWIbg9gjhlTNh0RHndjlsjnyXshr
 PgSaPiYkq+PkTdPGfsTobMqrKnrQ9ky53l/8IHw3KXwaMm6Gz+GWGUHZ6IeqdoOgid69
 TJKWYxq+BFtGjhvCFNLAulrVzMrmTjHwgPgIEGLAQbEEDBRhJ+MiK+p+I+k63ofbzHEA
 W9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dRNE1Q3UHcAv6Ct12abpAnXUsUnbwAcbxOzLZWSk128=;
 b=mcp+f3dceB68W6qjPqC711/hzISDHiofdloQykrbP6qjalqW/C4o6jp1mq0yIUksq5
 QfOndWFK7IUMIxU59vByAYyBUlNeEFi/IYseqrGHW+3s5Gv3gMQm3eMDRo5jb5f0ElwZ
 9oBQQAkBqcDCMiR2YU8Lx8fAx/Cf7brg8/TALL9kWkQbTKS76ojejDYuNSGOOthhk/Pc
 7/cS5qtS0MSDrJPoHsLZ5y0cWsrsB7bCSt4GoFsOEONGzo6yKWXPRaXCRGSPc9dMGsty
 FjO0Fzy9+3+fcdOVVrH8C+kLKTylIME64b65I+dEfdE+YRuRF4eRDVRlzZZP/zyoQNTW
 ngFQ==
X-Gm-Message-State: AOAM532JECGAQhmIXEoT4DjWpcUVlbcjTVLIJ9lANrevGwIITzCNhgWU
 VXg7499OXqO3LowEtJjUseeIfQ==
X-Google-Smtp-Source: ABdhPJzUi+LPZUiXwebXV78bx1zgz6gydw/BcJqlaUAKuEgMiIAzEW/wR7qbM0cLhgpzF1q28AZJ5Q==
X-Received: by 2002:a05:6000:188e:b0:1f1:f8f0:f75a with SMTP id
 a14-20020a056000188e00b001f1f8f0f75amr3772099wri.682.1646925389123; 
 Thu, 10 Mar 2022 07:16:29 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a5d64e5000000b00203914f5313sm818592wri.114.2022.03.10.07.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 07:16:28 -0800 (PST)
Date: Thu, 10 Mar 2022 16:16:28 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
 Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_071631_078121_AC0F469D 
X-CRM114-Status: GOOD (  22.47  )
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

On 10.03.2022 07:07, Keith Busch wrote:
>On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bjørling wrote:
>>  >> Yes, these drives are intended for Linux users that would use the
>> > >> zoned block device. Append is supported but holes in the LBA space
>> > >> (due to diff in zone cap and zone size) is still a problem for these users.
>> > >
>> > > With respect to the specific users, what does it break specifically? What are
>> > key features are they missing when there's holes?
>> >
>> > What we hear is that it breaks existing mapping in applications, where the
>> > address space is seen as contiguous; with holes it needs to account for the
>> > unmapped space. This affects performance and and CPU due to unnecessary
>> > splits. This is for both reads and writes.
>> >
>> > For more details, I guess they will have to jump in and share the parts that
>> > they consider is proper to share in the mailing list.
>> >
>> > I guess we will have more conversations around this as we push the block
>> > layer changes after this series.
>>
>> Ok, so I hear that one issue is I/O splits - If I assume that reads
>> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
>> feeling would tell me its less CPU intensive to split every 100MiB to
>> 1GiB of reads, than it would be to not have power of 2 zones due to
>> the extra per io calculations.
>
>Don't you need to split anyway when spanning two zones to avoid the zone
>boundary error?

If you have size = capacity then you can do a cross-zone read. This is
only a problem when we have gaps.

>Maybe this is a silly idea, but it would be a trivial device-mapper
>to remap the gaps out of the lba range.

One thing we have considered is that as we remove the PO2 constraint
from the block layer is that devices exposing PO2 zone sizes are able to
do the emulation the other way around to support things like this.

A device mapper is also a fine place to put this, but it seems like a
very simple task. Is it worth all the boilerplate code for the device
mapper only for this?

