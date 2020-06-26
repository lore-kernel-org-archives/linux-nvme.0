Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FBC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7AE207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2GKXf+Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WszvHbM1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ED+3VEIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7AE207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=umZxwjLkUrKBDsWFBC5dRL5hh4F7BzdFCePcihhxUow=; b=H2GKXf+QQ6YoQ3qywXfqRzHis
	FSTNAJl+BRoBXVnJV7BWzJT3hCepeCjjFh65E8RQoejMIGAoZ394bNYP7SCtTmtYEmaLuhJv2uimK
	w1xUAv3spUcne/dV5MoUU0vJeW+a2ERbSI7QlQSYXUBgb2wLoggn0wbQSMUVBBHbfNVce84qsZlqt
	+MjFLxxjJQJ+YoTrqvP8fd2Z64nbuQ13+YmTDq2rqjEmo6FfbSbyQePJb2QxLiZ8AR/ZZKcTcAqIm
	9xzdbMENUunrk2Om3raBT9M0KM5DvBlncR/Pt7k1aBkGvA1ke3GHR4ohltzo19ORZ6ZQc+jUwilQ9
	bxd7Wm43w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolB7-00086F-SS; Fri, 26 Jun 2020 10:01:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolAg-0007o2-5b
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593165683; x=1624701683;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nenBgJ85kiE1NSwuuY5tGi7d+zGBN5vfMCBgLCyTfwU=;
 b=WszvHbM1JZivVifQWwDOyhGZfTuPw4m6f5dOHq6qt7v9Ex7mk3HvdlSZ
 XWhN/o8ljhOejIyUSod9m+pFahA23UTKL2tfByO/ot6WEca3mgetBupMi
 d3N8wAJYnAGRkNXcHPIx5gYIlOgjpJHV90JFJLZIJ0I4Pz85OyWvFR7hr
 1TvHRLScnM6xTNvX76+jl65ewzl38SMwOhV9yfygooUv5WlogS3SSgGin
 B/YMyn9cniuoU+ZG7fpisIhaFeGQmaDn47XIuuXRIjp2cvVBB9vZA8dvw
 WmqEIb4FEStKxKhgFqs7xBjfunWKFJjhXkafbssRBLG7gKm7273ed6i93 A==;
IronPort-SDR: jxSQCpoOd8u5bD0HhZxRvVJXdbUtjQ9Y6D9uHx3kcejNAw3IQ7s6sprrzY2XWuSVeccqdA486X
 XHzVAEiR3IwCeJLBEi3Vj6RJXSkDLZMyAoiEyePeurQsQFNYuZ/guqSHMMaCzXtv6eHCaSsRm+
 zVjqeqnIy8q/X8iRdJaPtc4cK3PDLqLDX6QGaX8J1f9TqLq2AevviMp38d/fU4XARDM+DDnuZz
 u+DQLnGd7aeH40baTG4DMK16LdssHRgIswR8atjz+v+N1CMlQDVZyzfKlVjo6+LwL2LkPgjaA7
 MkE=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="145304675"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:35:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehqR7aW9k9c6OG6oZ2Ltjp8nBEz/K+MGaXTp+4SBON0hFgq5wesRdACzk+RlZRUFaOYX32c5b6nqjHxhhnVWtsPYARIvKEKX8GDEmLO0PUWMe4dMW/DvyPIwhiFEK2IVXT3poyhRExJotOcnPiSrDqv07v/lcNXrikL/1InH0zGyOT0RYbKJY8IPgN203JiUaBq92TFmBgKZ9burjF4sswopvHWa0CJz8JoxK3TCjrhNBgUpIdEuapNO8Hrp+rj+ALhPyq4dzqMEJSFqeBQOFn55L1XRYY68+ATcq46yu7ijjmwQaCiJ4+XuXD8JBxTZ9ZSRT9UZ4T3EVRuWlatK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPMxpk4kL39xXoMHXmQplWk468yKOEPc0dDIJMCYLsU=;
 b=XKP5hIDiQZ8munr0UeWSu01ker2aidPVZ1LlaX1+o49ee7ngxZMjPfKoXypFisvlcUMrRkUH8/ceFpUtXU26carMmLwMHttlFNT9y/rd9ZTj+oNa20/6L8S9Th16Z5cctWSwnIFpo8VAKUHXiLrOPpEhH3BS06KjkE7w4kGx3/zMvU3/+oaREZxn0zwnOYlRyebz+dGMVleB91FsAFTk+js8aDEH+w3VFbUfMJc3VfAdNd8VitCr3rBZjibyPXsZhEENuGdlsA/oJ34twvYVNwF1wE8SseQ4azfTsIXJfgdSbIhgpdWBxOktC93HcrlVecsrmceFmttzrE1f1vTtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPMxpk4kL39xXoMHXmQplWk468yKOEPc0dDIJMCYLsU=;
 b=ED+3VEIj8jBasK0pFABtnbPuiqbdQhTIO9aXzowLpPn9qbUhJ8TL2uXUdM8422VquluMAXqnpyaO0W0CYjIqOfRYepuwSCk/GzFatq0a07n5R39GvE10XyfHq5eMzyUk+cotXXfC7PiI16cOYhDzxcb/dinC+BBQUwPoAl/EnzM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2316.namprd04.prod.outlook.com (2a01:111:e400:c618::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 06:35:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:35:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Thread-Topic: [PATCH 2/6] block: add support for selecting all zones
Thread-Index: AQHWSutRrDHAt43U1UKTuwgck7oDsA==
Date: Fri, 26 Jun 2020 06:35:05 +0000
Message-ID: <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04434c77-a80a-49fb-f065-08d8199b102e
x-ms-traffictypediagnostic: CY1PR04MB2316:
x-microsoft-antispam-prvs: <CY1PR04MB2316AFE477288E825088570DE7930@CY1PR04MB2316.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cgAA9Pwa0QbHpISYslt35uWSJCE4VbqGD9ebaVphacL51rql3H5CFCVCtpPuNcBjG8WqKNDsitojK+QxgXWMoQKlEufkZA7GKUP8euxdBTrBxlzLunUKBlPpQceS3r/+H6cqa5BhSWjAPIXSi9tUUrNVtrOBpWKovvlkXus9r03Gbsv/Vd8a+C91sxhsV/LiVCX5UpK6h+DAgVCWvKtfiZmBqwmPZj9pgzYvq/OfLfLqbS+6lGeueyo9q7A+s2sOLe+Hsun4DqC2ms9jbvUiFRryZarC1fumKcHODE5CRjuYZOvmWIWseekZ48T93+IM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(6916009)(53546011)(8676002)(86362001)(66556008)(71200400001)(66446008)(316002)(64756008)(66946007)(66476007)(66574015)(4326008)(6506007)(2906002)(83380400001)(7696005)(26005)(8936002)(186003)(33656002)(7416002)(54906003)(478600001)(9686003)(76116006)(5660300002)(55016002)(91956017)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YJwP5Nqpkwe1LDFQR5FHQLo81ah7o46MYVRneGxtut2d4zew0RwTSlCLlWKkAkBfNYk6Ud4/QIA09K5Kjn8cqWSX58gdtYE+7c3sM30r/G4vyVeGP8uWYer1ifpYMvE3KxGC5GFGXxKrMhN4FiXakF+vFWxyUHOaup19k+CUpx2bqqsCt9nYnRmbnP6K1K5O1zEcQ2ed3olaD2XwimOFm7ianIoljlT5imnIJvU1D720j9Pf+kugMewbXX8fRM+r1XruQAr+vHLM3UF4RzzNdbDqUtJyxpz/gCMVX5pT0adHy5rPjyycWToYorZs9RKaCbGDHEjE3WnFFSFCpQUSTvbhA3ML/9xhv9mgEAkTq0dkU0Qev4ph3TzeyMzYdKJSps3UDJ9hGc5cYahZO0h46XCvBU5MAGVLNWSb00HSGIVnwLxel+WK7U1fy1QFc2E287xhjawRw3K2PqdZL6+o9uu6vNtuo2fsenGQD2xsb7/SwSnWtVwUl/nrFZiVDhAz
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04434c77-a80a-49fb-f065-08d8199b102e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:35:05.3782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C7upWGAuvCz5KLhqGKxM4wmQK2ZV8i/fpRw5dh1WZVVo26PJGUAmbnE93gPH7Foi+Dw2wfhAOOnTQXZawr/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2316
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 14:58, Javier Gonz=E1lez wrote:
> On 26.06.2020 01:27, Damien Le Moal wrote:
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> Add flag to allow selecting all zones on a single zone management
>>> operation
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-zoned.c             | 3 +++
>>>  include/linux/blk_types.h     | 3 ++-
>>>  include/uapi/linux/blkzoned.h | 9 +++++++++
>>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index e87c60004dc5..29194388a1bb 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,
>>>  		return -ENOTTY;
>>>  	}
>>>
>>> +	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)
>>> +		op |=3D REQ_ZONE_ALL;
>>> +
>>>  	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>>  				GFP_KERNEL);
>>>  }
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index ccb895f911b1..16b57fb2b99c 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -351,6 +351,7 @@ enum req_flag_bits {
>>>  	 * work item to avoid such priority inversions.
>>>  	 */
>>>  	__REQ_CGROUP_PUNT,
>>> +	__REQ_ZONE_ALL,		/* apply zone operation to all zones */
>>>
>>>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
>>>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
>>> @@ -378,7 +379,7 @@ enum req_flag_bits {
>>>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
>>>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
>>>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>>> -
>>> +#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)
>>>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>>>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
>>>
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index 07b5fde21d9f..a8c89fe58f97 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -157,6 +157,15 @@ enum blk_zone_action {
>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>>  };
>>>
>>> +/**
>>> + * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt
>>> + *
>>> + * BLK_ZONE_SELECT_ALL: Select all zones for current zone action
>>> + */
>>> +enum blk_zone_mgmt_flags {
>>> +	BLK_ZONE_SELECT_ALL	=3D 1 << 0,
>>> +};
>>> +
>>>  /**
>>>   * struct blk_zone_mgmt - Extended zoned management
>>>   *
>>>
>>
>> NACK.
>>
>> Details:
>> 1) REQ_OP_ZONE_RESET together with REQ_ZONE_ALL is the same as
>> REQ_OP_ZONE_RESET_ALL, isn't it ? You are duplicating a functionality th=
at
>> already exists.
>> 2) The patch introduces REQ_ZONE_ALL at the block layer only without def=
ining
>> how it ties into SCSI and NVMe driver use of it. Is REQ_ZONE_ALL indicat=
ing that
>> the zone management commands are to be executed with the ALL bit set ? I=
f yes,
>> that will break device-mapper. See the special code for handling
>> REQ_OP_ZONE_RESET_ALL. That code is in place for a reason: the target bl=
ock
>> device may not be an entire physical device. In that case, applying a zo=
ne
>> management command to all zones of the physical drive is wrong.
>> 3) REQ_ZONE_ALL seems completely equivalent to specifying a sector range=
 of [0
>> .. drive capacity]. So what is the point ? The current interface handles=
 that.
>> That is how we chose between REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL=
 right now.
>> 4) Without any in-kernel user, I do not see the point. And for applicati=
ons, I
>> do not see any good use case for doing open all, close all, offline all =
or
>> finish all. If you have any such good use case, please elaborate.
>>
> =

> The main use if reset all, but without having to look through all zones,
> as it imposes an overhead when we have a large number of zones. Having
> the possibility to offload it to HW is more efficient.
> =

> I had not thought about the device mapper use case. Would it be an
> option to translate this into REQ_OP_ZONE_RESET_ALL when we have a
> device mapper (or any other case where this might break) and then leave
> the bit go to the driver if it applies to the whole device?

But REQ_OP_ZONE_RESET_ALL is already implemented and supported and will res=
et
all zones of a drive using a single command if the ioctl is called for the
entire sector range of a physical drive. For device mapper with a partial
mapping, the per zone reset loop will be used. If you have no other use cas=
e for
the REQ_ZONE_ALL flag, what is the point here ? Reset is already optimized =
for
the all zones case

> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
