Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:29:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55738206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FlvuC9de";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUC9skQw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A1mcBZkQ";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uKEmlmNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55738206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=NsxLtlGDhGDkhwKgszASK77fMqT81jvjV/IAMBKopa8=; b=FlvuC9desQ/ee8k4koWJ05i2o
	3bg5y4x6vHtGUzRagUYdcDOq8InBbRgC+lq4THG6goGKNEhhhpoEVzjSMMkCv3gM1C0CDXMP36G95
	aCD75IMWOABwvhabm6xyM3wcpbC139u+FaFjY9AsLOonKlBS8BtZulzZqSSag1jcAlKxkcbXAsiuc
	N/nN8FIDm0SyJjpEJGw1cRN28pTprD6CfBu7wgRyKcXdnB1aUs6uSXi1ILDtP/Jylatrx8SDKUquL
	LbkBD3tp8+wsn1y9I6GAmywQ3RmBPVwREvgQmnVZzS4gzX8FH1DW2Z0ph935Ytj/SqR97QSlX+Hlz
	0HGA3DrVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomXe-0003fk-NS; Fri, 26 Jun 2020 11:29:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolG6-0000z2-83
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=UmKQAvWXr7UzjXdHq2nd6MFuBEVBcflkprpPUTVOWgs=; b=CUC9skQwdUinGbVkNmVJWPAGrP
 ft5IqbR7ls9/y18PH12zL7Zg7drMlatQIzH/m1hS4IKakR9BFz2Rpvy9y8j4flaItT3OgA5FMt9+S
 5Ub4IOr9/9mDbbnkQR1AJelO4djrEZuaMgcGLV8XTn6hz9p5dZHoVWvq0SjcFRR4ZgGAWmKPA1QMe
 FSFBNDUMIWOSDjOyLEqIdsCoAhkvUSNfXSHFfcLe5hPpK/XO090Ry+ZYjQuK5nWzzqyhA4PWzZbSq
 NLof9j14eVJXmMXXXIR4t15NAtl8mP2WCmt5Rj0sDWVYBTU4RVhoE5Iczq6i6f9dbzyB2Mgvs5OpN
 SUaoRKPQ==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolFH-00052p-Jc
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593165967; x=1624701967;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8jAHWqrlQyNTj53ezyKk9zXuKUwWiQ5Exz3avj8hpW4=;
 b=A1mcBZkQxrJ5aESand4tO57OeFcaS/MHm/CAfnUlhNv2coRLCg0F8Iht
 sY5ZWGxuOaT1XrVIgmyIXQqWGE9EWbXgdDcdARldI1MgW+E6Y6L8WoOS5
 Vq83+82sJzF9idzS1Cdn1HOYTNTm0cbtVbJBdZ7uW9LwDNZB+S+HvDoX9
 CSHQTULclYfz2bDq7lY7vyTV/uta5RrbFSTv0+NoDR++LD6wyyfN97ea9
 QPv9B3ULRD3fWETrcDW9xiSN1W5LvkUIxJPCUFchH6Oh+uarNJDkY6/RE
 i4Cb+WC9vbLxW19FeCWNQEyXd1TgXJjQqtv+Unzyc11mJMcGHRCxifNX5 w==;
IronPort-SDR: d5oZ774jrqu/ILF6iH5j/6shUdeB2nIDg7Dw6fLAM485cqfVHT9bZ7bbg9LhFn2PeMFzR2wndr
 +UaRLTDMjmWR8BK8Mkyn5RT26N9Rs+NqKIYQZltobh6dbDwv96jTCfKZFXW3iPhAm94bUooyBC
 OBndaCxhr9vjnAbFxDbOkL0msOnFenw1M/ZT0NaCaDDv4USDB/tWZyZQ9pGtehpn6yJbTbRaNj
 eFe+Dgbx+L9ifYGHGlkNV5GJPXaNRiSfUhSB0u503XubIqXC2iawDKkpMt3HhtsmDyCwd9GeJu
 RRM=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="250205316"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htJR4yzezUoUfSiE661gfoeKgybi+VVshFyiy+GkyZe3xvEBrfrJdMtzwF/6l6mNLXmgQ/Vu8A4UcdRUO1pZbBV+shERqFYKv0KbuoPChB2EcafiJGNvkVSGyWZ6Lec/3OXDQlV+Ro4YVXm5f8JRuaydBH6L8VTyHwJBBs5aWh4X4I0jrnaY6RScWlKTR0mLpFTXC8h5+GSOfiV1Cbniy2uandAIFJUcp5bzUeponlz68l5zaC0sF3J4BsAJ8em3kKn+NEUglrK0kgt/xmx/1SPRaPO0AqXWb1wQI7BbUMastaPMOEQABfFKainDjy9aAQtzYaqQ4S3qAVAGR73wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmKQAvWXr7UzjXdHq2nd6MFuBEVBcflkprpPUTVOWgs=;
 b=H0OirPGhwRcIYbFC0rXiZ0QkbfIvcX07rf4AnbbAWKa04/SOQdIoqlaSwpBb9++R960GLcLK06TzOAkkeqzwXb//WA2nZzbiTvUM1NQX+GnByTn/xN1Z5+Gz3tU3t4AyJAtt5vq8twj+ihEU3jAVLnx0Bv5IGWcxwmovs0Qk/OV9WjIHDhSUvhvLG2Xdc1Xkh+5O9QSk9Uvo+OtlgfGO4aqTK4CP7aJ57snFX3MyVqNv2+fOgOF8ugHTtoyNPr97fJsa/GUwJNRCaYt4xzmoGM+DT+/uaMBl7TZi7Vm/3Mxrdi0tKX9L2G16jsRje0nl4kKmFGf1bls4XT+kkeq03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmKQAvWXr7UzjXdHq2nd6MFuBEVBcflkprpPUTVOWgs=;
 b=uKEmlmNtlreVfmet8OcgTtKb/p+bBXKYBzul1eWnLSpqIhWwjd3Gz4Puui4It0N3Dn5IS7TzFgUYtkZsnd+W5/NY3z3V/mvjsNiB4H223XczadfAVm44YpRZxw6ouLcPsCBuiCUGi/hCzYyddCcglORBKeAmAfzr16nxNrfpPg0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 26 Jun
 2020 07:03:20 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:03:19 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Topic: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Index: AQHWSutOpOYox0Fba0KpyHzgytYs/A==
Date: Fri, 26 Jun 2020 07:03:19 +0000
Message-ID: <CY4PR04MB3751C477970B556483800A1BE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
 <CY4PR04MB37514A1058726B8681AE2501E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065128.6x2csy5mjunjbr3t@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d49963bc-8d63-4a56-53a3-08d8199f0229
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-microsoft-antispam-prvs: <CY4PR04MB0727AE7D60DDCC4EBCB4CBC3E7930@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7MLbknb0bVq4/1MfGgSY2oDmhK9o2F/8WvxtAE/aqJwMygezpusiq323/+rDDSYNPn0+8J6M6u2n1I5prEZ4NZKPAbmpZwRr5k4MfwT7hkXlp3oHj0DKKByJBBFwPlXi/DIOI3+6PENgBFjsxmaYWf2qVYIuzwMMdBYL/rN+Uvkb7qQNiljIYWUsJ1qjMJtaQgl5IGK0miDYXg2fyWxnE1lJ/lZCLFJ6nT9nBnvyNxSH+n13YsOiShDo+hUHgTnOWbHJaA7YEMjAiW4NIYhYuNrULkRlZ7o0/MjZ8kQ1Zu1SPMkfYU0Z7reZ6lWVmN4hXoVK1cF7QvwKuc9+IapDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(7696005)(54906003)(66946007)(91956017)(76116006)(2906002)(66446008)(64756008)(66556008)(66476007)(53546011)(6506007)(71200400001)(26005)(86362001)(6916009)(478600001)(4326008)(66574015)(83380400001)(9686003)(7416002)(8936002)(52536014)(8676002)(316002)(5660300002)(33656002)(55016002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nFqYZ3ytaGjjwpZJ0xyLH7I4sOMXGmIXa0d0mOeb4detqbAdY0zBCRzglMn9HLsTIKhPNoTRItH9LHgq0nPjXuK9EZDNK0h0uO5yPVqxrZmqs8lVmN3iT9+6JDOrNmky7hxS4pMBmwr4GYxGbUZMsMph9UXT9n5RspTkeJJ7AOcqlN0c7XhvBxHl2CP/lwhcMHy567jh9SX11Fr0gtALYdk8Zr8mRRJg8ykFnuzNg21tdFsrjWM6ycB63D0O+uO0hNyE6JuzDR2AEgh+xjt5C+TOyyDjX0YwrPC5P0fUUf4duUuAbyFBZIHn1Kt4KDr5D1B2s3AcMRPNnrfy/NpOFsuB2/PpUwUqc6phkyhwS5CYIipU8VUTS5V8SIwzRNl/xWm7qSqys/Y/tpG8+97BcSLGgwNQxPmvc7BOXWRGWrVVpUraKDUFQvGH1WRUS1PBXjiLOLi0ovfpPKDvLkoOizl2h8K4gSzYzcadFGItwmIKO6y5MK3RdrVSzPFL2eWV
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49963bc-8d63-4a56-53a3-08d8199f0229
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:03:19.7963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtmeCOpSdEvbJQwCosjRNzuwhPC8MLqhz8rQpYOm9eDNROFgTOSTieq7pirZRs6bKB7LhVJCVYxh1Vww92pZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110610_382942_800DF1C9 
X-CRM114-Status: GOOD (  13.13  )
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

On 2020/06/26 15:51, Javier Gonz=E1lez wrote:
> On 26.06.2020 06:37, Damien Le Moal wrote:
>> On 2020/06/26 15:01, Javier Gonz=E1lez wrote:
>>> On 26.06.2020 01:17, Damien Le Moal wrote:
>>>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>>
>>>>> The current IOCTL interface for zone management is limited by struct
>>>>> blk_zone_range, which is unfortunately not extensible. Specially, the
>>>>> lack of flags is problematic for ZNS zoned devices.
>>>>>
>>>>> This new IOCTL is designed to be a superset of the current one, with
>>>>> support for flags and bits for extensibility.
>>>>>
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>> ---
>>>>>  block/blk-zoned.c             | 56 +++++++++++++++++++++++++++++++++=
+-
>>>>>  block/ioctl.c                 |  2 ++
>>>>>  include/linux/blkdev.h        |  9 ++++++
>>>>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
>>>>>  4 files changed, 99 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>> index 81152a260354..e87c60004dc5 100644
>>>>> --- a/block/blk-zoned.c
>>>>> +++ b/block/blk-zoned.c
>>>>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device=
 *bdev, fmode_t mode,
>>>>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl p=
rocessing.
>>>>>   * Called from blkdev_ioctl.
>>>>>   */
>>>>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>  			   unsigned int cmd, unsigned long arg)
>>>>>  {
>>>>>  	void __user *argp =3D (void __user *)arg;
>>>>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *=
bdev, fmode_t mode,
>>>>>  				GFP_KERNEL);
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_io=
ctl(), with
>>>>> + * blk_zone_mgmt structure.
>>>>> + *
>>>>> + * Called from blkdev_ioctl.
>>>>> + */
>>>>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>> +			   unsigned int cmd, unsigned long arg)
>>>>> +{
>>>>> +	void __user *argp =3D (void __user *)arg;
>>>>> +	struct request_queue *q;
>>>>> +	struct blk_zone_mgmt zmgmt;
>>>>> +	enum req_opf op;
>>>>> +
>>>>> +	if (!argp)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	q =3D bdev_get_queue(bdev);
>>>>> +	if (!q)
>>>>> +		return -ENXIO;
>>>>> +
>>>>> +	if (!blk_queue_is_zoned(q))
>>>>> +		return -ENOTTY;
>>>>> +
>>>>> +	if (!capable(CAP_SYS_ADMIN))
>>>>> +		return -EACCES;
>>>>> +
>>>>> +	if (!(mode & FMODE_WRITE))
>>>>> +		return -EBADF;
>>>>> +
>>>>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
>>>>> +		return -EFAULT;
>>>>> +
>>>>> +	switch (zmgmt.action) {
>>>>> +	case BLK_ZONE_MGMT_CLOSE:
>>>>> +		op =3D REQ_OP_ZONE_CLOSE;
>>>>> +		break;
>>>>> +	case BLK_ZONE_MGMT_FINISH:
>>>>> +		op =3D REQ_OP_ZONE_FINISH;
>>>>> +		break;
>>>>> +	case BLK_ZONE_MGMT_OPEN:
>>>>> +		op =3D REQ_OP_ZONE_OPEN;
>>>>> +		break;
>>>>> +	case BLK_ZONE_MGMT_RESET:
>>>>> +		op =3D REQ_OP_ZONE_RESET;
>>>>> +		break;
>>>>> +	default:
>>>>> +		return -ENOTTY;
>>>>> +	}
>>>>> +
>>>>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>>>> +				GFP_KERNEL);
>>>>> +}
>>>>> +
>>>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>>>>  						   unsigned int nr_zones)
>>>>>  {
>>>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>>>> index bdb3bbb253d9..0ea29754e7dd 100644
>>>>> --- a/block/ioctl.c
>>>>> +++ b/block/ioctl.c
>>>>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_devic=
e *bdev, fmode_t mode,
>>>>>  	case BLKOPENZONE:
>>>>>  	case BLKCLOSEZONE:
>>>>>  	case BLKFINISHZONE:
>>>>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>>>>> +	case BLKMGMTZONE:
>>>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>>>>  	case BLKGETZONESZ:
>>>>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>>> index 8fd900998b4e..bd8521f94dc4 100644
>>>>> --- a/include/linux/blkdev.h
>>>>> +++ b/include/linux/blkdev.h
>>>>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *dis=
k,
>>>>>
>>>>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmod=
e_t mode,
>>>>>  				     unsigned int cmd, unsigned long arg);
>>>>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t =
mode,
>>>>> +				  unsigned int cmd, unsigned long arg);
>>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t=
 mode,
>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>>
>>>>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(stru=
ct block_device *bdev,
>>>>>  	return -ENOTTY;
>>>>>  }
>>>>>
>>>>> +
>>>>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, f=
mode_t mode,
>>>>> +					unsigned int cmd, unsigned long arg)
>>>>> +{
>>>>> +	return -ENOTTY;
>>>>> +}
>>>>> +
>>>>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>>>>>  					 fmode_t mode, unsigned int cmd,
>>>>>  					 unsigned long arg)
>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzo=
ned.h
>>>>> index 42c3366cc25f..07b5fde21d9f 100644
>>>>> --- a/include/uapi/linux/blkzoned.h
>>>>> +++ b/include/uapi/linux/blkzoned.h
>>>>> @@ -142,6 +142,38 @@ struct blk_zone_range {
>>>>>  	__u64		nr_sectors;
>>>>>  };
>>>>>
>>>>> +/**
>>>>> + * enum blk_zone_action - Zone state transitions managed from user-s=
pace
>>>>> + *
>>>>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
>>>>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
>>>>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state
>>>>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state
>>>>> + */
>>>>> +enum blk_zone_action {
>>>>> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,
>>>>> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>>>>> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>>>>> +	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct blk_zone_mgmt - Extended zoned management
>>>>> + *
>>>>> + * @action: Zone action as in described in enum blk_zone_action
>>>>> + * @flags: Flags for the action
>>>>> + * @sector: Starting sector of the first zone to operate on
>>>>> + * @nr_sectors: Total number of sectors of all zones to operate on
>>>>> + */
>>>>> +struct blk_zone_mgmt {
>>>>> +	__u8		action;
>>>>> +	__u8		resv3[3];
>>>>> +	__u32		flags;
>>>>> +	__u64		sector;
>>>>> +	__u64		nr_sectors;
>>>>> +	__u64		resv31;
>>>>> +};
>>>>> +
>>>>>  /**
>>>>>   * Zoned block device ioctl's:
>>>>>   *
>>>>> @@ -166,5 +198,6 @@ struct blk_zone_range {
>>>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>>>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>>>>
>>>>>  #endif /* _UAPI_BLKZONED_H */
>>>>>
>>>>
>>>> Without defining what the flags can be, it is hard to judge what will =
change
>>> >from the current distinct ioctls.
>>>>
>>>
>>> The first flag is the one to select all. Down the line we have other
>>> modifiers that make sense, but it is true that it is public yet.
>>
>> You mean *not* public ?
> =

> Yes...
> =

>>
>>>
>>> Would you like to wait until then or is it an option to revise the IOCTL
>>> now?
>>
>> Yes. Wait until it is actually needed. Adding code that has no users mak=
es it
>> impossible to test so not acceptable. As for the "all zones" flag, I alr=
eady
>> commented about it.
> =

> Ok. We will have this in the backlog then.
> =

> It would be great if you and Matias would like to comment on it if you
> have some ideas on how to improve it. Happy to set a branch somewhere to
> keep a patchset with this functionality somewhere.

I sent a much simpler version of this using a REQ_ZONE_ALL flag too, but dr=
iven
by the specified sector range. That allowed to do reset, open, close, finis=
h all
zones using a single command much more simply than your patch. But as Chris=
toph
commented, the only real use case interesting for this is reset all (e.g. f=
or FS
format). open, close and finish all zones have no user...

Let's see first what kind of flags may be needed in the future, if at all. =
We
can then cook something if needed.

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
