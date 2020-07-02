Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDA8C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF61B20772
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCnbH3Xk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OgWLeHPx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B1huncmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF61B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=3FiWykGvr1nJ1vGgf4o5Qckuw7ryf88Xxv2ZkItnOUg=; b=sCnbH3Xknbr4nDKM+/wO3eBPX
	NUCwGtZ4N3HNsnjfzd1doLDHtmSswwVORgyP+n+696d/tOxyPmC8bdXZv5qecGTfMNd2VfhdkyHn6
	ZW1cB/WjVcMtyxw8UQHh6Sp21MtsHRJzt6QxItiIcVLZ1TW2EoWi5tczV0p2WqAC9jXbVHobUWNE6
	FIZ72fP59q2TdwstcqQz/BPn5htd77NNfKJJHvqClqxNy/fwqMsog+a+SLRFbTnywVBTEFntwZRVc
	B1ubjPu/pD7rIr2OyLM7gyH9TEBV91XQtw1Yi9XMZbecDFU3TlWY2w5dNLqBs6uaDu428FLujO7V5
	b8wpJFqsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquxQ-0004vh-8y; Thu, 02 Jul 2020 08:52:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquxN-0004v5-RA
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593679983; x=1625215983;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XvPvSN41Nl2PBHfJlWPCWf+s8fhgXAR4TFqZVD60/Ck=;
 b=OgWLeHPxcZuCKKWgToytvXo1LWOaB4usKgwu0IXbnnkZ1MWar2LYw9uf
 UC7K2gBak0l+8g5VwN05d08fjW09y9tM1+p+Z6Ggzem5uMLe3cqu0djpw
 5C5OUvBzE7HbRphYb//sSLadNFgsQDwQhzuhtAPrwEhoylpQCY+7Q5Z59
 F4rxyOVf1LLLuuk6Dk/kM1QQot/uD2cvuNHed9AEau3zn1uhCDatz6+AZ
 dbsFTfAnMLA7ub1NphQzB4NRhk4tfS3F/hmiUCCJTmy+kbnzdd8CChVYt
 Ks1lm/gPd37otTyJu4vUKYrgZcqD99cYDTGCWP5hRApg77/xhiudIYMbn A==;
IronPort-SDR: sNdgz5mHLbSOJEU06J+Kb6+FPQM/Z1U/4hCtReXVN+YkXRIGbsO2oDH3nZI0JRlIfNrwQtDGvf
 wW8a4UKzbXvEEAJ/XtyWJ3FaP+yUONmCpHwrtNH451PWwXDOqsUAjDNgFO15sAEr6MQ4jxLgnH
 HklsHE3UjD43uzHvFh4/O4I7IfaK5R7C9W3iQhy/FR6bM2kR5mUZIXLf47tPZH8I1lZKG01Iov
 2neA6aHRtKoHEPzphAULGiZOGk3GwNulcUbpDNCTzqLplWfkBKrH8jJVmiSS+jd8iT9gMTpL8d
 gwg=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="244484604"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:52:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuYtMOuBhYeuR3qr2ezZ5aDkYASloELJ7Xv+z08ovc0CJHpqFzP74pgUCKkvD6WQS/CzbMFqCH+UvMzXggepeHNRlzgTkkuG0DaUaPO9uCxP3eWwnkuIFWsG5Ju/iEN0sQ3EVaYvDczF4v/LRHPUat5MSmxGDF//Mo73k1n17Gd3QrOIviwmjMZXWjEk5kcmueKaJFEbCGeB3FPDfVnEiIcpT7DKeMpW65mwQLIjqI9xwI6n4Wecjf5Z/XJiEpYFMjAYwUnQdwRLZetbRzwRrsDta78jthsjyzBZX8sI38fP6YMQ4v/icBIA9KbsZVZOQHGzoyJMon6ZO7m027TEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPbbSN6FM6+V66+ZY69yt6xpdbZOIFgkYujFPKoYu0s=;
 b=WM/PIK6jvZpvJXrXTC0rHWra35nS3atd3baOuB6KIplA/qW+vl5zKWnH04VboJU3/1dI8ZYdr+IysflCbe20mW0uSw2nqWemw38M2ciSsvjqdESRPDL8nCDsCEkbjLPv7EYrfpCeMUvEywsr1SJrXzWekm4z+Y81OvwUCCvPAhdIBZCZfF4JAdmHBIUZUI8b+kRtgIXnTcIymJ89IlEecjdg+hr9sGOye6ELQxM2h+kINoIK6nB/IN8fsG5m1COaKqoFzPIPApn1sm3X8Xc9zaW4zJ8k+jXM3c2pInmV8ZBlbFeLchh+2hMe6l8EmcwXlTnyiIX0GsDerJs2qYwiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPbbSN6FM6+V66+ZY69yt6xpdbZOIFgkYujFPKoYu0s=;
 b=B1huncmDWMlaib3IaDhY9sgRJ28SHCwXmOP4RZndSe1Iup45JEdelmxYldNV+A3IPyMu5G2F4QKwwr9rIk8hqe4TkRXcnJqXbfqneYw64VSsZ/37gpwMRxzkrx/wzxYf8pPoYx8Cge7oP/n/Y+Bg0N8vwS9X4nnoj97cnWSowtE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1206.namprd04.prod.outlook.com (2603:10b6:903:b8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 08:52:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:52:29 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 2/4] block: add support for zone offline transition
Thread-Topic: [PATCH 2/4] block: add support for zone offline transition
Thread-Index: AQHWUD25AuPO9FUJKEmO2iwqT0FCbg==
Date: Thu, 2 Jul 2020 08:52:29 +0000
Message-ID: <CY4PR04MB3751E40E2719591FA81C21F2E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-3-javier@javigon.com>
 <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083956.rwlewfgyc6ycs4ys@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 944a3614-7817-4182-36f6-08d81e6540a6
x-ms-traffictypediagnostic: CY4PR04MB1206:
x-microsoft-antispam-prvs: <CY4PR04MB1206EAD554910462DB159D46E76D0@CY4PR04MB1206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S5XLYeXslr51COAmTwa8q00GcpmCc2Xg6RxuRyL59lo+Wr5rTPV5kWd1Ln+ncXrFsmta+5+HEw7/VSbeAo2uNxk5Xu3bjvQ0uZS7hZt01OL5mH/gSZ8nTAgoCabHfJfIgBl4BX83CIa9qQN75eJqwGUz5hAjirbYWz+yOvMyUahncWkkkP1nokv73jSKWzYs3D2lesbwt1fM3pW6w9A00TXn5eplQkOhvF4fTxK34zdXwZ4k2eCBYkmGtw21w/VUajIAn515FivaIxxBlbExTKpvhUqhGlBAPrDbIOXExY/0KGU3I2stFpdR3y2ihd09dUUafhIhsJDAKNo7UH2MHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66574015)(33656002)(316002)(54906003)(2906002)(7696005)(186003)(83380400001)(4326008)(26005)(6506007)(53546011)(7416002)(6916009)(66946007)(66476007)(64756008)(76116006)(52536014)(66446008)(66556008)(91956017)(71200400001)(55016002)(9686003)(8936002)(5660300002)(86362001)(478600001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KcbRkhqp1ys28OsYJxgp8DOXXrqvrUHBLo0UX8ut2HKlDd8K/4BZrojDM9tJr0yHyNKVHuEG1bruzh97ga+PfOm44PvyKM/jeaX9O+D+4Mumcv1ygTy5a97D2QdJwli1c8R8HmvAu0ODWqIUbU6tDRZpNzklGx2/ISxg8a5NlWhmc0HZWgAwfiIf+RNTmY7m851geqqCidGQ2dVSciicGufThMFe+140mZCO8RvL0RKVfAQnz+fubciae1rlqZ7NEufEQRIOFVa6RfHToJ/HjZ1tNeQyP9PICc6lh8ycd6EBefKzb59tozHjpDURms7VH93dkdMiWFHiQROjrqIjuPgCw6fW/+58H/ZgA/QxNtLH1ndv9S5paQnNyUfkwemIR0h1fJqA7FPzO1Hq6BWFAbQxxijEylcrE6XiBATz/u50Gf1wmcLzqtutJfzrgZRb7XhjcBNA7JH7RiUsZ0jurxq/0EKc6DY4bKd0Ma54mHY3zS37lniHxZCY6J/OjT4r
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944a3614-7817-4182-36f6-08d81e6540a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:52:29.6550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNmpWUjf8ZNXqp2lPg+u5gE+XotThzycHv36b2QHSuCx47PfIzbdj9a1FLCp8aNO5CC303lfHX1kib7IbzMi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_045234_057279_AE220416 
X-CRM114-Status: GOOD (  19.59  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 17:40, Javier Gonz=E1lez wrote:
> On 02.07.2020 08:10, Damien Le Moal wrote:
>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> Add support for offline transition on the zoned block device. Use the
>>> existing feature flags for the underlying driver to report support for
>>> the feature, as currently this transition is only supported in ZNS and
>>> not in ZAC/ZBC
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-core.c              | 2 ++
>>>  block/blk-zoned.c             | 8 +++++++-
>>>  drivers/nvme/host/core.c      | 3 +++
>>>  drivers/nvme/host/zns.c       | 2 +-
>>>  include/linux/blk_types.h     | 3 +++
>>>  include/linux/blkdev.h        | 1 -
>>>  include/uapi/linux/blkzoned.h | 3 +++
>>>  7 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 03252af8c82c..589cbdacc5ec 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>  	REQ_OP_NAME(ZONE_APPEND),
>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>  	REQ_OP_NAME(WRITE_SAME),
>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>  	REQ_OP_NAME(SCSI_IN),
>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		if (!blk_queue_is_zoned(q))
>>>  			goto not_supported;
>>>  		break;
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 0f156e96e48f..b97f67f462b4 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,
>>>  }
>>>
>>>  /*
>>> - * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl pro=
cessing.
>>> + * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLI=
NEZONE
>>> + * ioctl processing.
>>>   * Called from blkdev_ioctl.
>>>   */
>>>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>> @@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,
>>>  	case BLKFINISHZONE:
>>>  		op =3D REQ_OP_ZONE_FINISH;
>>>  		break;
>>> +	case BLKOFFLINEZONE:
>>> +		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))
>>> +			return -EINVAL;
>>
>> return -ENOTTY here.
>>
>> That is the error returned for regular block devices when a zone ioctl is
>> received, indicating the lack of support for these ioctls. Since this is=
 also a
>> lack  of support by the device here too, we may as well keep the same er=
ror
>> code. Returning -EINVAL should be reserved for cases where the device ca=
n accept
>> the ioctl but start sector or number of sectors is invalid.
> =

> Ok.
> =

>>
>>
>>> +		op =3D REQ_OP_ZONE_OFFLINE;
>>> +		break;
>>>  	default:
>>>  		return -ENOTTY;
>>>  	}
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index e5f754889234..1f5c7fc3d2c9 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req,
>>>  	case REQ_OP_ZONE_FINISH:
>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>  		break;
>>> +	case REQ_OP_ZONE_OFFLINE:
>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>> +		break;
>>>  	case REQ_OP_WRITE_ZEROES:
>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>>>  		break;
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index 888264261ba3..b34d2ed13825 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>>>  	}
>>>
>>>  	q->limits.zoned =3D BLK_ZONED_HM;
>>> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>>> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
>>
>> The name BLK_ZONE_REP_OFFLINE is not ideal.  This flag is not about if o=
ffline
>> condition will be reported or not. It is about the drive supporting an e=
xplicit
>> offlining zone operation.
> =

> I wanted to follow the same convention. I can change the name in the
> same enum for the report flags.
> =

>>
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>  free_data:
>>>  	kfree(id);
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index ccb895f911b1..c0123c643e2f 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>  	REQ_OP_ZONE_FINISH	=3D 12,
>>>  	/* write data at the current zone write pointer */
>>>  	REQ_OP_ZONE_APPEND	=3D 13,
>>> +	/* Transition a zone to offline */
>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>>>
>>>  	/* SCSI passthrough using struct scsi_request */
>>>  	REQ_OP_SCSI_IN		=3D 32,
>>> @@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		return true;
>>>  	default:
>>>  		return false;
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 3f2e3425fa53..e489b646486d 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_d=
evice *bdev, fmode_t mode,
>>>  				     unsigned int cmd, unsigned long arg);
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,
>>>  				  unsigned int cmd, unsigned long arg);
>>> -
>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index 42c3366cc25f..e5adf4a9f4b0 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -77,9 +77,11 @@ enum blk_zone_cond {
>>>   * enum blk_zone_report_flags - Feature flags of reported zone descrip=
tors.
>>>   *
>>>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>>> + * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.
>>
>> The device supports explicit zone offline transition
>>
>> Since the implicit transition by the device may happen, even on SMR disk=
s.
>>
>> But I am not sure this flags is very useful. Or rather, isn't it out of =
place
>> here ? Device features are normally reported through sysfs (e.g. discard=
, etc).
>> It is certainly confusing and not matching the user doc for rep.flag whi=
ch
>> states that the flags are about the zone descriptors, not what the devic=
e can
>> do. So at the very least, the comments need to change.
>>
>> The other thing is that the implementation does not consider device mapp=
er case
>> again: if a DM target is built on one or more ZNS drives all supporting =
zone
>> offline, then the target should be allowed to report zone offline suppor=
t too,
>> no ? dm-linear and dm-flakey certainly should be allowed to do that. Exp=
orting a
>> "zone_offline" (or something like named that) sysfs limit would allow th=
at to be
>> supported easily through limit stacking and avoid the need for the repor=
t flag.
> =

> I can add that too. I left it out as I did not add any implementation on
> top of it for the device mapper itself. If this is the way that it makes
> sense, then we can add it to the different device mappers later on.

If the capability is advertised as a queue limit and the generic limit stac=
king
function adjusted, you get DM support for free and will not have to add any=
thing
to targets supporting zoned block devices.

> =

>>
>> Happy to here others opinion about this one though.
>>
>>>   */
>>>  enum blk_zone_report_flags {
>>>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
>>> +	BLK_ZONE_REP_OFFLINE	=3D (1 << 1),
>>>  };
>>>
>>>  /**
>>> @@ -166,5 +168,6 @@ struct blk_zone_range {
>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
>>>
>>>  #endif /* _UAPI_BLKZONED_H */
>>>
>>
> =

> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
