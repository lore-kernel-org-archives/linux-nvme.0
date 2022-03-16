Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE78C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cY2zSS6SY31l7qOoS4GxN9w8wfcb+Vj7eGbXytsbn2U=; b=qXfcIdONRpIdq+pHuTuGE0qGKR
	qQhcH54fC+KvcFhyFY9t2xycGxAjVmue5l0taL/St2Dio/ivqkW2iFqzvfL0+f35wyAoenOOpEYDV
	7dyIVf1LSh6DOagPIWpD22gNJwdkE/s1MzevD/uxXQn6a+Gzln1r660Dcb0RHtYKMKZMlsfTUL6Sw
	I2+vnMpRvWdVNi4yEglIJhJmNQKK5hng1+1AJXewH38emQe3kA3qT/Wn3JrQs6iNKAG8XvD2WwC7/
	5nnOWNz+dDgu9QG5j4exqa3yOLPHaH7CVOvtfeV9e9q6p2Dl2L4jfWKzCcDPrY98o8bB6ajKbpTP5
	HLg0Jx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUH5i-00Awzh-2N; Wed, 16 Mar 2022 00:00:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUH5f-00AwyO-Qm
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 00:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647388836; x=1678924836;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cY2zSS6SY31l7qOoS4GxN9w8wfcb+Vj7eGbXytsbn2U=;
 b=H8ScupqtHyouJ9/Mar5hiqumrtD0+yyA497+OOBE/Tkx6+IZopG6tvd3
 qp8hc5GB3fh6xFXpoLBoa3RgI+2KvkpJiQSpu0Nja2dDMYcZtHv1/SQi0
 mVFtzNpBNyWkzBY5lKLfJYNadPsATNyuk11YdCIwLmi1JP01HxW1oln7e
 3nLdoXeEJbz3P+qygO5FdDzUdpvpeGSgCKpsx9dzLEFIjrDF8puSFl4yg
 fYU5KvVr7BbX7fjJsSPP3QHWUZj0du0U+qkHapC8FjDZBDYU0sO+SfLAG
 UObcDPG+pZuVuosFu2bxPpLtwq2mTmIg+wArwg9uTGRdzoeOJXfKOvBBn w==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; d="scan'208";a="196388082"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:00:33 +0800
IronPort-SDR: m5JuoAKwLbDCL7V3QkvkI2QfCVnq3YsbBgtErcNJ89nup6TPmrnvLcFWVhdkhM+BaTteUO+Rts
 YQQbEGh5gyFVjF+yOQeZP9GGFwRU3MnWJN5b5PPIFlrOezOiQdKrm6Wtd99JKChJcUTop6ZNhU
 qQdujg3OhM7dO8FaYxIiX4lVchza39baVhl1QOr31rEzJu6er0hH57q4V1o2IjA2jwLS0YpevV
 0ApBXRMa+dTT/pwcIiaVsF3c1RzzAUFs7UEk7QvCqEh1+ZWhq6PmENNMF29Ydb7fXrB3MIWcS+
 SxK0DwnhOIa3PbDkRBiJxfty
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 16:31:39 -0700
IronPort-SDR: ZcIqsHCwU2AqiFzr29PmRx0HSl4JdvONO2l8knVtoYSk1dNf/hS1P2Wp3jEJqDTGE3CKaU4L4o
 l2GKI/paiaXcjThnqUh7dkjTeHyW8/L8vYrIcHguScNBQxwYW5LLjYijoSmN6wEk+sW0texrps
 7/3rcu+IfwFOO5U1Z6qdgiyhE7SlVWXuiMFxCzfL1pqBZUlmnHgWntERAQmTIzAI8ovtjkuFZ8
 CCX2SZvH9QTQELBHplgo4GMZ45rnlDjQ9Jb3Ev/BBXcGBiXBp2mHBnRxJPDXVVYOPyeY/4FEix
 0GE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:00:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJ9QS3kKkz1SVp4
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 17:00:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647388831; x=1649980832; bh=cY2zSS6SY31l7qOoS4GxN9w8wfcb+Vj7eGb
 Xytsbn2U=; b=FNJ2VS2y9+0vbf8V4oUOeQmu2B3zV+Sv24+C5188Rmpk6g3uZME
 2w+eHQKdRgHHQBeAICkrhh55XEAuPch65VLvmqUWEZU3nLVGW/9HXl6exa4JyVop
 P98rhyYpBnAtLs55lA8aKofja7072ILSOFwYDMR0tMM3DNXKCS81C4+Z0P6nRBqg
 PrjbmkFQtvZLOlwf92mGqStNEjkS5leq8Gh1LYilstIdkRpbvNf9s1JlKyT6dn7c
 QAQlAMjkv0Bc1NYGYxYUSHB7ve8pZSExznaptA46XSbbC/NHOsufwk+qFkOYuNPq
 q4Z4IfsneoR0u4Vf261/PYxnjWs0RoUH4tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id VqoIOT9C2Z0i for <linux-nvme@lists.infradead.org>;
 Tue, 15 Mar 2022 17:00:31 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJ9QN5kJyz1Rvlx;
 Tue, 15 Mar 2022 17:00:28 -0700 (PDT)
Message-ID: <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
Date: Wed, 16 Mar 2022 09:00:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_170036_021740_6F3ED619 
X-CRM114-Status: GOOD (  37.73  )
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

On 3/15/22 22:05, Javier Gonz=C3=A1lez wrote:
>>> The main constraint for (1) PO2 is removed in the block layer, we
>>> have (2) Linux hosts stating that unmapped LBAs are a problem,
>>> and we have (3) HW supporting size=3Dcapacity.
>>>=20
>>> I would be happy to hear what else you would like to see for this
>>> to be of use to the kernel community.
>>=20
>> (Added numbers to your paragraph above)
>>=20
>> 1. The sysfs chunksize attribute was "misused" to also represent
>> zone size. What has changed is that RAID controllers now can use a
>> NPO2 chunk size. This wasn't meant to naturally extend to zones,
>> which as shown in the current posted patchset, is a lot more work.
>=20
> True. But this was the main constraint for PO2.

And as I said, users asked for it.

>> 2. Bo mentioned that the software already manages holes. It took a
>> bit of time to get right, but now it works. Thus, the software in
>> question is already capable of working with holes. Thus, fixing
>> this, would present itself as a minor optimization overall. I'm not
>> convinced the work to do this in the kernel is proportional to the
>> change it'll make to the applications.
>=20
> I will let Bo response himself to this.
>=20
>> 3. I'm happy to hear that. However, I'll like to reiterate the
>> point that the PO2 requirement have been known for years. That
>> there's a drive doing NPO2 zones is great, but a decision was made
>> by the SSD implementors to not support the Linux kernel given its
>> current implementation.
>=20
> Zone devices has been supported for years in SMR, and I this is a
> strong argument. However, ZNS is still very new and customers have
> several requirements. I do not believe that a HDD stack should have
> such an impact in NVMe.
>=20
> Also, we will see new interfaces adding support for zoned devices in
> the future.
>=20
> We should think about the future and not the past.

Backward compatibility ? We must not break userspace...

>>=20
>> All that said - if there are people willing to do the work and it
>> doesn't have a negative impact on performance, code quality,
>> maintenance complexity, etc. then there isn't anything saying
>> support can't be added - but it does seem like it=E2=80=99s a lot of w=
ork,
>> for little overall benefits to applications and the host users.
>=20
> Exactly.
>=20
> Patches in the block layer are trivial. This is running in
> production loads without issues. I have tried to highlight the
> benefits in previous benefits and I believe you understand them.

The block layer is not the issue here. We all understand that one is easy=
.

> Support for ZoneFS seems easy too. We have an early POC for btrfs and
> it seems it can be done. We sign up for these 2.

zonefs can trivially support non power of 2 zone sizes, but as zonefs
creates a discrete view of the device capacity with its one file per
zone interface, an application accesses to a zone are forcibly limited
to that zone, as they should. With zonefs, pow2 and nonpow2 devices will
show the *same* interface to the application. Non power of 2 zone size
then have absolutely no benefits at all.

> As for F2FS and dm-zoned, I do not think these are targets at the=20
> moment. If this is the path we follow, these will bail out at mkfs
> time.

And what makes you think that this is acceptable ? What guarantees do
you have that this will not be a problem for users out there ?



--=20
Damien Le Moal
Western Digital Research

