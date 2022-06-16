Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5ABC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI/cVxZcV0=; b=PTJkBLMatBW8v4eDk+0qOn7saR
	pzs6jkGIErIybg+YOmL4Q9nsvpv6OGiOXMmC8OxCvfvBLbXbM7w9muTBMiXrRXonrqUJX1SwmmrUQ
	CN5bUhs0L03Gg2KjfiFTzYd4MxteGtjRoz0/fkwDMleacD1IIxgO1MKLrbG3Dd+Ckgw53Z2It9Dcq
	fuoNZxknt+mDAfcCnRBbMzqYyiI5MXQbPSavc2Dt+e6+4cr9wAukursHmvsVkwm63SXpcbOagBT48
	FIKaeCa7Buu8yi4bjZhubhDmuu+oypGtOUmXyzLuFEm5sYqbJ5xOQIIu3tPNQvT9hGLqwaivOvA+o
	dm12cSvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1yx2-004kyO-Te; Thu, 16 Jun 2022 23:31:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ywz-004kw3-Gk
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 23:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422255; x=1686958255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI/cVxZcV0=;
  b=XKGnYG5VrwAaT03G9zbNtCm1ZvqsU9DfG9ipBu4CAQzGYdy68Wqsty8l
   07IPVF/yM2/TaTE2lFXs+jicEq3omPmKGTwrKogCOKH/8wOvDC+B3T/mA
   V+7iwirEHDnrFslY52XbN63RmVxzf997/rKnQft13EEjLOfEyQ2MTakim
   QwKNQB8NihChbhrMPsTbuRTmiVI9tKH1jsfFFp/Jr9v12OIrWAgE0E+U9
   b9H1y55sEBM5Uw4bVbDKTr4V7+hnZg1bqRiTr6+WJsPz4vZWgTREWexFd
   np+5WlV4a1EVbXi9zMz55BzDctyjSX9/dpZ6m7NK+u/GvPBNAjvyLXLM/
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="203374177"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:30:51 +0800
IronPort-SDR: KPfUIM58ey4OwkPeKY8HaRhYUzeG7lTMIrJMlJZcdp8b9B5ig3Wso7hTw7HscCbn3GOIrQ7iUq
 zQH7SFs2Okf1hEBfWIepPTsxBNU6smldQc6aHX22uqMECBpw0JqK3irE0AWKQLKKuLraUnpKHm
 FSNJg7jsV9V50gu9bt4nq1AJCTWycmcE7SZ0SkhzXRHFdkQVAn3iLPhj0PA4YixrtJtgAxGI/p
 A7q7GmT3jcDRfnMfSG3i5Bn4oAD2ainYxdVZZF2gWu6/yuBSnjvIh9Ztl+J3hAoturIyjZ7U9O
 3rRoZj8Qh8UyoOrcSRjFnM/N
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:53:28 -0700
IronPort-SDR: +LkS8xCKfDWY18wYEkQ/QlWqlNL6ruZ0xuGEGeGNTD1UdD9F487mfim5RZhcPaGfPSHPRVzxY0
 0Vs76JMXJ3ue33sW5dy4RZZ6s1gNxiKxsK5iTKu+az2r1LkqIIdcsFscY3+KpjGmizzl5+R180
 5wd2LgDk6YH8gDdGQW5xhy55nclxbqLXkH77ktnyg+Wulb0hP04gLkLPOLQKOh1kYo4b5dMfL4
 yDjA7UGU2BsSpPxxTUQ99VJa3S+0UAkT9ebtl7rdIx4MBOa2W6NqoMHU25nuBiJ/KiOeUCPHQP
 NW8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:30:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJMH75lFz1SVp9
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 16:30:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655422250; x=1658014251; bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI
	/cVxZcV0=; b=QrmRAjk+25AzX0pmuPjm21UbJvARRDhpRqZ8MwiHGxi+ExbXMdm
	KfWGaMfH86r+rqGZFUK3ugIbHq8FopF/CgqfnQjd0OTiUR90tAxXL6VqAHOOhkZI
	KGSDWUHHy0BNQh8nGkS6W5bM7aRI2w6QGd02G+8eSVrcXCm06MiM+4YsMB/nKjL9
	Eq6GwkqowHdlry39C7IEa89LanvFqo0WItYGNC0Sj+wKmyYDuQqTESGipfgGpCcD
	kQQ/njwlbMb6i/SpGKFXo/J5VGgQktL/Fxf9h/1MtXdl4dGOVzCxttSvCxDwQAPU
	Ob7mFLLGyECGCgsJNZjX0S84j5RQ0W46SKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DBhM0hwyac3v for <linux-nvme@lists.infradead.org>;
	Thu, 16 Jun 2022 16:30:50 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJMC59mkz1Rvlc;
	Thu, 16 Jun 2022 16:30:47 -0700 (PDT)
Message-ID: <ab75c1ca-986f-c3af-6c8c-c2c5b7e40bbd@opensource.wdc.com>
Date: Fri, 17 Jun 2022 08:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Bart Van Assche
 <bvanassche@acm.org>, hch@lst.de, snitzer@redhat.com, axboe@kernel.dk
Cc: pankydev8@gmail.com, gost.dev@samsung.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Luis Chamberlain <mcgrof@kernel.org>, jonathan.derrick@linux.dev,
 Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
 <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
 <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_163057_609453_C556A07A 
X-CRM114-Status: GOOD (  23.42  )
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

On 6/16/22 19:09, Pankaj Raghav wrote:
> On 2022-06-15 22:28, Bart Van Assche wrote:
> isk_name, zone->len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zone->len =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone size", disk->disk_name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't allow zoned=
 device with non power_of_2 zone size with
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zone capacity les=
s than zone size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>=20
>> Please change "power_of_2" into "power-of-2".
>>
> Ok.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_power_of_2(zone->=
len) && zone->capacity < zone->len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone capacity for non power of 2
>>> zone size",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 disk->disk_name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The above check seems wrong to me. I don't see why devices that report=
 a
>> capacity that is less than the zone size should be rejected.
>>
> This was brought up by Damien during previous reviews. The argument was
> that the reason to allow non power-of-2 zoned device is to remove the
> gaps between zone size and zone capacity. Allowing a npo2 zone size wit=
h
> a different capacity, even though it is technically possible, it does
> not make any practical sense. That is why this check was introduced.
> Does that answer your question?

Add a comment explaining this restriction, clearly mentioning that it is =
a
Linux restrictions and not mandated by the specifications.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Division is used =
to calculate nr_zones for both power_of_2
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and non power_of_=
2 zone sizes as it is not in the hot path.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> Shouldn't the above comment be moved to the patch description? I'm not
>> sure whether having such a comment in the source code is valuable.
>>
> Yeah, I will remove it. Maybe it is very obvious at this point.
>>> +static inline sector_t blk_queue_offset_from_zone_start(struct
>>> request_queue *q,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sector_t sec)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 sector_t zone_sectors =3D blk_queue_zone_sectors(=
q);
>>> +=C2=A0=C2=A0=C2=A0 u64 remainder =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!blk_queue_is_zoned(q))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>
>> "return false" should only occur in functions returning a boolean. Thi=
s
>> function returns type sector_t.
>>
> Good catch. It was a copy paste mistake. Fixed it.
>> Thanks,
>>
>> Bart.
>=20
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel


--=20
Damien Le Moal
Western Digital Research

