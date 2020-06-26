Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C31C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:50:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E3B206DD
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D53NwLE9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0bvXFPP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DnIVnXFD";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nsjAN+Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E3B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=GM9aRS52njjjjqjCNBbei4FjLS11c0jtuZ3nUyimUK4=; b=D53NwLE9ICpkp6cwb8G9Ku3eZ
	EYfftYkqUWQs4nRcutmmhs3Ff8jG09MS+9HEfR5DjhoubfGAkqtuh3EBs97uhDyxnZd++L9ipCQXN
	CfskuObXaemcnVJwHopZWHCt0aCj4O5SPowxlSXXAHT0CRu0Kt4invGNsUXx320frQ8eCpJFjNgoq
	Bjich1XalmNyHDY8FuVJdY/6pzfvlVpNwS2C7j8UMAIZWpoWauuKh2F3vvhAeWwYHlifsPvL/oQnY
	7qJdl8kg85MaQHiMsjo2yQ7PRJ9GHURhZ/zzhggzXcQax1NdcT1q2oWgBiVj3VgnS4yI2NltCLUlM
	ZM2qstdSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolw6-0005cd-1X; Fri, 26 Jun 2020 10:50:22 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolvs-0005UN-Uk
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=ktxgc1k/RjJprr0k89lhJ5d65T5RBbhTon/NsJl/b4g=; b=i0bvXFPPXjvxe07gIja33e52AE
 4G5nIQ/fyqIe5rfc5Q7gPZPR16BfLCJ00ycANgJe2tnPNY+/154ot5wHYF+ztx2n8zOyexQPMIiC+
 kCbll9RNe60plOv1U/2ACXwB3c9XCGdM8/xYUaq6eHTPzx3pFnWIPsf9x0F47m3dI10/13hjfqr1K
 7UvvVJGfp6n/c9mamHRk4Nb01T0NxaCsvtAa9NugFA61L/lrlZ6oJTIYwCUW7MxjVFSBrS4OAmOyx
 M7g2Lxe23ZVxoBKX0yuZXaNsvaB/uqXfk++K4spKdJJvjZFQqNLBge64PR2X4fQMzcZOTF30HkStv
 EQIc18hg==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolum-00044i-Sn
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593168556; x=1624704556;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=h0lMljOTuTe1yDuhnO5QxUdBVR4/rSXnNfF9yBRROxk=;
 b=DnIVnXFDk49jhL3+TpM+CH/Kb/gUO0fdq7kgMFRTiqYdK44yzm2ptVpL
 2MS2OLYUdxRfQp4vveShNlbDfSu3BApP1OuYKodKIvgkhJvEEBwOd5AFF
 hoSMY4UvB6/Grt8ULZFTRdRT9pGV90bdg4CPv2vFaSGjbw36cFZbQFhRR
 lh/Hk1ihdTi0xItLKn7KflfvsEVkmXdSNct7mIYzGX0/bPpMwByNjzrm2
 24t2ozDJ7uSrYW5hmwNm66l+3aEp8IbyanH2T1DNFd/tqH3gesfNQyDQ7
 kSMbLRQlUjZZi8ujx6tG6JhH6MO3NatMfuRSObMS/BIQ+y/sOUuJ8VWAS w==;
IronPort-SDR: mPtrLh0ZuuMoVKUgOyA7d74+nT2fe3cvxFLi1KyhqwheUpqIjg1n7+VGqimM9cRTvLQNA9rQnG
 eJMCZ63twQpSIOpDAG7hx6m33gNp8dbGiB32h83zPq6HakAVBRkguw25iViVkSTVFVfze5uz/f
 mlPaVl8Rri3B0YeZsFC4IWTEVwpnQDGnLK5YmCdmDO0daVpe66tZDBSycoDGruUJgAtuJTd0VZ
 mcvkDtA5tzZ12fD/7eNgp5aDaQw0OeBc7IdfyOzUu3bOL1QCxSDw/5c2raOZ65D6ouMCSkLCKN
 Dks=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="243991843"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:50:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5ELu9ELcWuFaaREjtSgg0olUVRSgTz1DqD5xZ4yTG7kIvrRmGCLKFyYAmsMs/a6oIP3kdWtsSuqPtI9FSG2WITo35cwFucrs6FYMX/JU5u7ZABYJx8FIXUJ6LQAdsBWPM9woJVAveVEK/sonflLSjgZU9mQ8OLJzFuZJJitvm7JIL+7gCyFgCfuP/JTiy6ayGGgTsmyK/YYLPPk9vqyEDmBJei2flPSKRa5+4B5Zf8ByzhjSwehnvSPTBXz0NcdsKKOlDOMKLnW/BvjtFHzsseDSYHDdExq3mjwcVpZXgGdhXXwb/BrwuA/xyAzrIXf/WAk+3r1bIJrSGRwm+xCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxgc1k/RjJprr0k89lhJ5d65T5RBbhTon/NsJl/b4g=;
 b=c68tGjabNOK/7WwuOjIEbjjYJ4L8htYFM4I3dbSo9afJfPGBRGUI8j74p12FSxQPbkVuxh523c3JPm8VyUv1vhuGBP1KDf47fKMm4UZxCUZJq2GtVFc/vRflfEv+OkOLOfb3qdHTjWANHXyClZwoQpq6u33sNDpvC2oH5KJ6yZZ8B/wFa0/PrFHWbU9D5o0JgZkRLL0S3JRxam4BurJPk7LG2xwZN+gdEKD1HNnBRd/I/n0Mr4V+BoLuhiN15VnOPGkS2Pb0Fijr+TZAJRefoY0yT7GjzleLgKrP8aE9lkW2gjC4GgxsT8d7NcqPsUUjN3b2sYGwHQF4FOXnOPK/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxgc1k/RjJprr0k89lhJ5d65T5RBbhTon/NsJl/b4g=;
 b=nsjAN+JuU9vgWyGwhmuiLwDX6l65tvENs8xD3RXgZJz5oFkkyWLlaUk/UIBh4hWQno9VOrizfxP1aaEZdBvA3on/0xN8ClWCpIVgMz6Xu/2fGt11hCgyLqqWaTGpttk6/m7p9XJjlVVRDD/rrQTQskXpUjd44rwoCVaxBNjlWRY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 06:49:53 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:49:53 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Index: AQHWSutTIAjD46n2JES6Jp1duZEotg==
Date: Fri, 26 Jun 2020 06:49:53 +0000
Message-ID: <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd38f34d-9726-4c30-36c4-08d8199d21a6
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-microsoft-antispam-prvs: <CY4PR04MB07603C85B8E91D5ECD68DE23E7930@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClkwLBrRHCWnKJztonipv+gqzDhB7TEDceQ8CSdwR9JSF8zmhIkCN+k5Z4+kv3FtTXV0WL3lMXoiJ6fygzadxunboDZZJ5+dAMS7DNBcxL3/ad1ynGvjSgCDrImntfuiccdbP41PmQ26oZX2kEqy0UGi5kEaq9O34VDIm/e1usi66cOKUfxqoQfvELsgi/tkJbfbsAjvyxnvHG8lCsjWAEvKltmfNDFJd+kQhQqXsT15KGrPtTwz9HM3OuEXEgoJlOfFfybxJKt92QxnURE3sGLpyTrCJ6gARvdeUh4HHOrXRl/K9iihqft0Ov5bnFzcMPAWbCavvkmQphVH7JMPJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(52536014)(2906002)(7416002)(4326008)(9686003)(71200400001)(478600001)(6916009)(55016002)(53546011)(66476007)(64756008)(66556008)(66446008)(91956017)(26005)(7696005)(6506007)(86362001)(66946007)(76116006)(186003)(5660300002)(33656002)(8936002)(316002)(66574015)(8676002)(54906003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UXGokKeHet/v2kgBKQBY0YTXnXUB7TslW0p4BCfs+b6tl6pZU+KM2v+4DUrUd8gVkRp1FW5HZgYWDmikb8Tjp33A0cQMZRnYzLYnyk5033C4vzTjHyF0rY2shxk/GfPzuAq5UR5yQjOwRGMXU/iCFk5r3NeTI5r5QCzzFJpfMXHCtLczO6n3xrkXIRtnKjDH4DhTjrasrWGpaeoowGR42uhkuMA42R2p4sCrhjkiQIwM/2xBXQrssKNECdsknlHm3F6q62Iy9v4EwH/3+//N8JnICJBNxDgYByNeATRVzOy4QLyrQX3mpGPQp/qX7w7RAA/wSGeU56VtvBak4eH2NFHSbbbsyH8bI2y9Y2hE4QfyiIsOyU8jQ7dY0MvLK4Lqz/etSq+Pv4X0W+BPmrHPXsNqWnkplx6ROzz4DoISqdMN+KRd4kAabN444VTpYa0whD/UcWD67UshYQqnSccTucahKRfQkwK+koviV2OIYvEEnODvGwLgxpHzjUS+5diI
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd38f34d-9726-4c30-36c4-08d8199d21a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:49:53.7056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C30CJpu0ryL1xW3Xm8yePj/WIB/pWq7ZzXC1Z/rpniRRvoXZqNSNbdIvd8uQBNdJHCj9KJYkT6er8JqXQrT0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_114902_984781_3409AD91 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 15:13, Javier Gonz=E1lez wrote:
> On 26.06.2020 00:04, Damien Le Moal wrote:
>> On 2020/06/26 6:49, Keith Busch wrote:
>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:
>>>>  drivers/nvme/host/zns.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>>> index 7d8381fe7665..de806788a184 100644
>>>> --- a/drivers/nvme/host/zns.c
>>>> +++ b/drivers/nvme/host/zns.c
>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *n=
s, sector_t sector,
>>>>  		sector +=3D ns->zsze * nz;
>>>>  	}
>>>>
>>>> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {
>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
>>>> +				zone_idx, ns->nr_zones);
>>>> +		ret =3D -EINVAL;
>>>> +		goto out_free;
>>>> +	}
>>>> +
>>>>  	ret =3D zone_idx;
>>>
>>> nr_zones is unsigned, so it's never < 0.
>>>
>>> The API we're providing doesn't require zone_idx equal the namespace's
>>> nr_zones at the end, though. A subset of the total number of zones can
>>> be requested here.
>>>
> =

> I did see nr_zones coming with -1; guess it is my compiler.

See include/linux/blkdev.h. -1 is:

#define BLK_ALL_ZONES  ((unsigned int)-1)

Which is documented in block/blk-zoned.c:

/**
 * blkdev_report_zones - Get zones information
 * @bdev:       Target block device
 * @sector:     Sector from which to report zones
 * @nr_zones:   Maximum number of zones to report
 * @cb:         Callback function called for each reported zone
 * @data:       Private data for the callback
 *
 * Description:
 *    Get zone information starting from the zone containing @sector for at=
 most
 *    @nr_zones, and call @cb for each zone reported by the device.
 *    To report all zones in a device starting from @sector, the BLK_ALL_ZO=
NES
 *    constant can be passed to @nr_zones.
 *    Returns the number of zones reported by the device, or a negative err=
no
 *    value in case of failure.
 *
 *    Note: The caller must use memalloc_noXX_save/restore() calls to contr=
ol
 *    memory allocations done within this function.
 */
int blkdev_report_zones(struct block_device *bdev, sector_t sector,
                        unsigned int nr_zones, report_zones_cb cb, void *da=
ta)

> =

>>
>> Yes, absolutely. zone_idx is not an absolute zone number. It is the inde=
x of the
>> reported zone descriptor in the current report range requested by the us=
er,
>> which is not necessarily for the entire drive (i.e., provided nr zones i=
s less
>> than the total number of zones of the disk and/or start sector is > 0). =
So
>> zone_idx indicates the actual number of zones reported, it is not the to=
tal
> =

> I see. As I can see, when nr_zones comes undefined I believed we could
> assume that zone_idx is absolute, but I can be wrong.

No. zone_idx is *always* the index of the zone in the current report. Whate=
ver
that report is, regardless of the report starting point and number of zones
requested. E.g. For a single zone report (nr_zones =3D 1), you will always =
see
zone_idx =3D 0. For a full report, zone_idx will correspond to the zone num=
ber.
This is used for example in blk_revalidate_disk_zones() to initialize the z=
one
bitmaps.

> Does it make sense to support this check with an additional counter and
> a explicit nr_zones initialization when undefined or you
> prefer to just remove it as Matias suggested?

The check is not needed at all.

If the device is buggy and reports more zones than the device capacity or a=
ny
other bugs, the driver can catch that when it processes the report.
blk_revalidate_disk_zones() also has many checks.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
