Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA5AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f84+vDOkYdKvpAS/+2t0fMk86T27MpLA7gE2VV6cuuw=; b=KdQGQe7AdAI4/0bjXWRdCv2BED
	pRuHV+Nd4fsHlESw1eEjpAtbHFiGlvHjzBcqueMfsL6zIIuZ6jHow2+xmzJnKhwWKTdb/HjAvg0fF
	7rKJnruODBJx8fAw2iw3keQfJHJha8bVLCLR72wiI3LRfW6JmA7H/ESII9Aq5yqUL0i9YBzhVxvsL
	GwvHuJyugckab4AA6qNaQmi5uEkYolU8DsC1yvBNMXpfg3LICxusDy75QaxC4EpDyJYvc6UJHXziD
	B7CwHjTFKRTva1qsJe4WcXgm6xKZ+OzAfXw19udVkRwk0dbl2lAMgMYTnBh3oqlvW27FmUTybnB+z
	1p1/78kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlVZw-001Bm5-7I; Mon, 02 May 2022 12:55:04 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlVZs-001Bl8-GE
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 12:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651496100; x=1683032100;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JUhkvda0JEwXdsLju2Qm64dHW4RVR82QZ/jIjIRhXSc=;
 b=m38iFLdvrb3hfNw3N6/IcNJnLVs5lcfAAYex4pat4RJP+DOqf5aIkCGO
 amha9KtQp8z5EPvXCu+/d3S0TzBBEL5pZ1YJyLkGb+deORVbe74fC/9O2
 U3s6QxzzmRopz50EUd/Zy8T2BZ/hH+yBlcDP/1z0sH5hqh+4KHtqJ+SMg
 KuqCLgB++pZKoZ34SVxeKXA0PVSBDA7oIYyuHvzhQ4fbUoWs8pM1XgTOd
 niJ7jSggYZp4qZ8E+4F2YmiaSwWOSrUqMrbq+iQg+STxBKkouwgIUJn+R
 tE2dEeLX9jf5KcACuSIZIiUQdv32LtNVOMWyo+5pEAyVhwfR1cJ/ONkY0 Q==;
X-IronPort-AV: E=Sophos;i="5.91,192,1647273600"; d="scan'208";a="311307273"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:54:58 +0800
IronPort-SDR: WsWxSybLxBBI7PuNAb4RXDAcosBD7uASNTIzaLPuPcpKpY76J/mIosLFxmrfW243j8HSbHqvur
 l5vPonVqdYe931YUXW1fLOzxJ7QMJd9vnS+e/IXDDiNrn6mfajhITgzMKR545T8jIe5ESLciD2
 X6hbXzPcPu1ii+cS+Qy2i5xCT/WHA34Zz+5rayjsPg05THKDCQL1u4L5fybytMaQxsMVNdKbf6
 N2ILEJe94AEOOJ/DAJMf/Kj+Uo0/JgCwYK0ymU+ZWswy07/IxgviEGF19azX9xJor3rYJDB8vE
 6TPEIuZ8DCQVVxBwTBOnTdCN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 05:25:02 -0700
IronPort-SDR: QeWYtZtSGxacciw9qG56yA2n+JHaUhX44EuI8jQyxgDVeQaGcV77dDXNjUiU5aSbINXNGcdRQA
 ivbgQ9ql5i4skBtfMfFvOTLN2Zm8AgKgVLEu9zXJdTFpHInL4nxP1h9sPWK03pymEMSzjdpZj4
 U08O8kWAXUtQaGZ7OiE/a5NTUu0d8+/AOe1bMkSTFXoNhv0mSiz6lEaa3CdQ8y/BKxNHom30xj
 ou7PagHm7MjG8I4xusnQ6Mp7sbMY7u4/5kyhfwS41kNpW4jzwnNgCewAI6/asBSN3/pXciebC6
 xKw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 05:54:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsNNL1Qcxz1SVny
 for <linux-nvme@lists.infradead.org>; Mon,  2 May 2022 05:54:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651496097; x=1654088098; bh=JUhkvda0JEwXdsLju2Qm64dHW4RVR82QZ/j
 IjIRhXSc=; b=AIzuKRzwZQVGatHl1N9EZyzvTE342Ex2Xsdk8dBzDQ7YlT68E2V
 jV+TRKCrZd4GXYnfbCwGUwR95UrtQKr2UfhYl8T65OJz4IyX5umhChjtkVGNhb78
 fifJnXe4HbDMbtWoKXkttpTB62VrmW8Nx3y8woeYDf4X2F5K5ujyv36d1+FWxt7o
 sb9+KnDWiv764wZ2QpUYFR4rpzUKq6nGrx3NzsjOE6RgwxGpfrSzxy7XJaamCLU4
 cKra1DSpG8GFVPnxcIuK8yBXF6OG4IuYh9XditWd0i9eLs+PM4Hw+wMdbnKYLvAZ
 DOChJiv+tRmTFj4WmOuvf97nM+M1QTprY6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id RNRR9wD-KZt4 for <linux-nvme@lists.infradead.org>;
 Mon,  2 May 2022 05:54:57 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsNNJ5Mpmz1Rvlc;
 Mon,  2 May 2022 05:54:56 -0700 (PDT)
Message-ID: <46e95412-9a79-51f8-3d52-caed4875d41f@opensource.wdc.com>
Date: Mon, 2 May 2022 21:54:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <20220502040951.GC1360180@dread.disaster.area>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220502040951.GC1360180@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_055500_656072_76391F01 
X-CRM114-Status: GOOD (  17.36  )
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

On 2022/05/02 13:09, Dave Chinner wrote:
> On Wed, Apr 27, 2022 at 06:19:51PM +0530, Nitesh Shetty wrote:
>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>> The patch series covers the points discussed in November 2021 virtua=
l call
>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>> We have covered the Initial agreed requirements in this patchset.
>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>> implementation.
>>>>
>>>> Overall series supports =E2=80=93
>>>>
>>>> 1. Driver
>>>> - NVMe Copy command (single NS), including support in nvme-target (f=
or
>>>>     block and file backend)
>>>
>>> It would also be nice to have copy offload emulation in null_blk for =
testing.
>>>
>>
>> We can plan this in next phase of copy support, once this series settl=
es down.
>=20
> Why not just hook the loopback driver up to copy_file_range() so
> that the backend filesystem can just reflink copy the ranges being
> passed? That would enable testing on btrfs, XFS and NFSv4.2 hosted
> image files without needing any special block device setup at all...

That is a very good idea ! But that will cover only the non-zoned case. F=
or copy
offload on zoned devices, adding support in null_blk is probably the simp=
lest
thing to do.

>=20
> i.e. I think you're doing this compeltely backwards by trying to
> target non-existent hardware first....
>=20
> Cheers,
>=20
> Dave.


--=20
Damien Le Moal
Western Digital Research

