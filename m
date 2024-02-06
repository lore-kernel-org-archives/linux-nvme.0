Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48718C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKdSckDHC8yyNuxwuCavNQg79ylkDs381g2vPiNq+5E=; b=fZl+MPMAh8XtYm9TienZkjrhTa
	zwDVlAyW3d9fWMjuCHaj4XQe2j6jkzRdxmafPhngdwCudu9AKBhcOj3an0W6zIwSOWfj6NJJgqlAQ
	zNNlDsHeBsPWNiKX1D5fGKLxpNQx3v35B4lmqREM4pK11UczAh+4gxK6nevGokTWCS77Y2dcEV1nI
	8B8d7zpx5x4CFZoC9iNEALcRA1tWxMr+xLgjMmEVHpoxCNiU4p8Gj5/YcZdm/nc/p/4/HeDGSmWnk
	30uKFkUtC7X2wf2FZGqxavf9cgsroDTeWZ0QRaa3atHAlxi6LxHvFevhlHGA3zdJIHazuzwaht6Y9
	Da6J8Yiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXEXX-00000006BEh-28Ab;
	Tue, 06 Feb 2024 06:02:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXEXU-00000006BBz-2IdM
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 06:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707199356; x=1738735356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H+OH0wuzPcusKxxG1lApy3Lb7P7ngsByx6X21x8Nkm0=;
  b=mPdQnlxUOpUGQTQWgXb/Y1pOMJawNOiq+aRTREKadz6k4IvHKdtFlPVw
   BwnQJvGjQ1kjL+a9ACM8WJx2yBLi2A5vb1mI8KsZn0TIJruMPbrbGAzQJ
   rQWXnRIci2va9pWsFujV1A9iHUZFObdqOHlFyGAT+jf+JaAaJIzgRiY+9
   8fBD2zfHVFVm2kUl44hm0OTTqXmNvH3DXeEtBDTdd52RQBPRCEuGAOWHZ
   vEYmNuA3lmGfGZU/7uiKI/xySro8/paohv+P94JIoKIEA2lPULALs9RJl
   VfIEHE5vtflvIyyFcTD2VPP3HyJwktGZVBzCF12b1sYog70e/+qixLLqr
   Q==;
X-CSE-ConnectionGUID: wVO5oXDTRouom3O5tjsOsg==
X-CSE-MsgGUID: Yc8jRsKLSw6aFBy16Q6nSQ==
X-IronPort-AV: E=Sophos;i="6.05,246,1701100800"; 
   d="scan'208";a="8588297"
Received: from mail-eastus2azlp17012016.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.16])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2024 14:02:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnV41RP17aO9yAO3VAfbTHJZGRTkLLyfpUrFEeKK5rgEonO4OobjP8f7DSK/FE6ATsybZpKZ1fs7JZC7FcAW/TR42ZVqqRVBIQ1liHploZ6lNWjE+SCELzuDQOQ41TFdvIZ+G42vn8uFak+ythcDlufPHnChDAXQ5DWZGFHSzLjTbwg+tnxpuQuCnIN2h7aXetgJQbkzlgZc48PMklpIq86k8aDJnFcllmuffX6YZepbqz+tUoQ4LCW2UgaymlABmrWcRcmAetDqwZPLIsRX0JJte0+UgG+9cZ1dr1TChzyS7k279xcmpomOU8R7YB/lMJgtyk6UQfLi9XsWKq08ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKdSckDHC8yyNuxwuCavNQg79ylkDs381g2vPiNq+5E=;
 b=A5jzyxTjE16QExVdeDNmhG8iYPGk42jHrPx4WY098iOB/oTOTYud6dJgZXDmA2i/EA2bgeCaWYnzA+eMZTQCK+xQyF9OhFjbjlLIKnw2yupOQhhMu70+mXvHHlpu5cFujgFL1cKV8LDHunPezKOKyhyOSyYan3um3fBtNRgTKw/IM26Uw/Y6YNjzTIvyaabHxm7Pd21YvnstDDbgW3Jc8P2UY9Y8D+o6rODtlH0KXvvI4dxDB/Am/F2WGo4ceqTaQWWVn7AWKw5bDanM+Xkz2ydk2phIwWxYzg9BhlAdjm7V+iJcU5LvA0tSna5pSnYlDe6XBsbnGcnDXsVOXhbXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKdSckDHC8yyNuxwuCavNQg79ylkDs381g2vPiNq+5E=;
 b=xttRudMx8Hst9KxD+c41XeQ8Sf4eZoDEv1gGcBCoJoCVBBy4LqM+9Y76gZV0GfvTogiwlyMAw7jI0EpFjfU2MwM5nkt+JyYtKZEmvjo1f33iLtSEHi2Tdnr4F/+Q2ovte+cH16fa5SXImh+Vs6UgpVnfb7Y9GaP49+w+SFvPjqg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8103.namprd04.prod.outlook.com (2603:10b6:8:2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 06:02:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 06:02:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Thread-Topic: [PATCH blktests] nvme: test log page offsets
Thread-Index: AQHaWGR/Dr54sNANvUSX5YS80ipQ5LD801GA
Date: Tue, 6 Feb 2024 06:02:24 +0000
Message-ID: <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
References: <20240205185225.2878642-1-kbusch@meta.com>
In-Reply-To: <20240205185225.2878642-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB8103:EE_
x-ms-office365-filtering-correlation-id: f031ae3f-6bd9-41bb-8fca-08dc26d9308f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9o17KGNxnRaiYLYkxQw9wnipVReiNbFSwnMUivHZ7H2Fe8Ru7Dw95BOauDAc4stKl0KsNyvVkaimYIQFcfOiXsSlRk7nP/4LV5xqoj7fEzxlfI7BLqFAC9rItyAkAoRm1/mBDa2MINsfPp1q6YPnNKLufxOiYKU6G6LR/p+Q385lqgpuCDIXWYp//tflcXTOHjPmwkSiRp8z5DxholGU7PEZiL/YF+dtCrtSpS7d7tju38I3I0saPiS9Hm/vIsN/hziM/xvgMaMB+uodoXoLwnREFYuLYQnP2uyLiz8PZuD8weHonobOfVmsS7z4Lv8rhujFlIFsRnj7piStgqz2rAFjvkHEN2WtoOvhd0fYBSSFCyd0V3Rf3rqjtfdoJy0Zyf4TE0CNTt7JCOhMlBYqTAxwegVSuxwA9dOSbFw1K7urRcofRpBUwp95p2WnXwjSStqxqgKu71g4E9OJf2gqMEN5zvTjuPDYwt+pnBZsAIbY4G5QLHdG4lp0bty5iR9CAdvEKXkfLxBQiBaR92jyfCJ2Pm3djhY9Ukmkg8J6V6+6Luf6Jac1KB8KjVV/RgE6HlFb7//jCJAwSmA4PpHiOgIsqxrjpxPzdFf0evcUnTFZ3qXRrcQMFwJbFOYfxxf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(44832011)(5660300002)(2906002)(33716001)(41300700001)(83380400001)(38100700002)(122000001)(82960400001)(86362001)(26005)(6506007)(6512007)(9686003)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(6916009)(71200400001)(478600001)(8936002)(6486002)(76116006)(38070700009)(4326008)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z5nTol++sPxbKjF5AY8T/ca2g3UIDrzV3RKgf7X5YjZOhJKhvcLdJfXsErgO?=
 =?us-ascii?Q?H+xY2IWrs3i1tkNypvYwDFvIYJcF1LYSJOeh/u092AjoqyDBA2ACLmT7f7yO?=
 =?us-ascii?Q?oOMSQBgcySwuEtJWFAkdqKp564PRF9bzYk+AhWs5iXE/TKjT1njOmbErK4tD?=
 =?us-ascii?Q?kVU5Qm19yy4jXRgwW0ODXOuA81/4P10Ho8GxUXNFx7baOw14ukr+TWuYHH4+?=
 =?us-ascii?Q?AXzYavwl8CmZi7bKc8Sdz7Kthl5lZSrVvVF1wFOWighRziH318FIPw12daXE?=
 =?us-ascii?Q?AY15CneMoYG+lJDX64PShgSjuFzXAR5Ti9KF5qPHKBYFO7CwaOTLG+jbwxH7?=
 =?us-ascii?Q?E1u/qPG46hFR8mwNJFoFhfEa2WEHysYdnwuwKT71guOnPe2a37+8902H9ZZr?=
 =?us-ascii?Q?W9M4k6dDRobKCBB0dhUtWn7023bPN/OmwARmpa0PV0tK56ndXhTMdtqzjVBV?=
 =?us-ascii?Q?uUpaWJ3rW+FK58Rohx6Uyh+H8nkdsSpswvzByOHJb68CCiEjYz+1jtRZO+BV?=
 =?us-ascii?Q?HEpWmB9D0F/IaF4RxmZn43kf9fzKGnbCVxIY4ua5iaYI2mfpOjbs/qJ7sscm?=
 =?us-ascii?Q?yNIh/hByJb8M4SFIcBf9Jy1/1XhnXnKw5SDT6Q+Z45NNicn9J0r6ITkEFiRo?=
 =?us-ascii?Q?Nh/6OQs7d1mCm6S9uKJI7lV1dMQMMczRTSvKsPJRCs+QKDBPDMXVX0zIBkVJ?=
 =?us-ascii?Q?27iHTLKkExzkEZaPGBGU/6gAHJFxHeIqzz+HL0YW7yIwFRtdbl03katrxRhM?=
 =?us-ascii?Q?oB6baobvf73VpKkJ1PnXQ/HK8vOcUTF5uI42QXrTI9e0+pRMzDJUzebEvjj1?=
 =?us-ascii?Q?h1xOpeRLYNK+I64vp57XQqCsuHY7yiGQJ4Gy0YmoF1q67CVWJ4ieiMeKQ/er?=
 =?us-ascii?Q?BVM/YhEvIj4SFSztFDKbtZsy1MIMJ4gTvWO7F/8mZHmCdEt/hk4VQbCPBSXS?=
 =?us-ascii?Q?0jphBn/ksKltE45hC0Qhpilgo7gNMWUqQuXJ08tYrATO5HH7uEEMSznZnqlK?=
 =?us-ascii?Q?drVUUZNqjNMJTy4scaAup4jIaB0bBdVOpn8Q+hvjf0xBls9AEQ9RegXD7k/m?=
 =?us-ascii?Q?OFH1av72oOXFWqoQFUsZYpjZsLvKPpWc+aCMv2Oj+ezk1D+E5S32u7HUCGeZ?=
 =?us-ascii?Q?CbCl+XNluR3yTIOh6UHcjbYZQHypIzrQJQoIk3r1q1zqwrejhLUr5N3Vj9YK?=
 =?us-ascii?Q?OaArlsnaK5vRPB0ufnmFCQ5HIAUT5u9nvz6Sqb6LHA6Y+SBTi25osNViIkOI?=
 =?us-ascii?Q?YO+A81HYDe0WBDXrrXnonevIQV4eZHc1FZqhcL8D2441OZcS8T3utuuumlhZ?=
 =?us-ascii?Q?bOti+UZxUBWhPdYxzmOOu/XbcDISpS5GfRgyEb0NiP7xGjQYld7xQLKT4B0S?=
 =?us-ascii?Q?sCcTmxqXSAjy4N2BuS0ussSjhzRljqlQWAhZs9iUoTUqyEDoihNb9qcAdKXf?=
 =?us-ascii?Q?Fn4I7Tzx98nIjc4aArq7eokqNpFo6V9XeR9dl4BSeIyfsYjJ9s2l3g7xtLei?=
 =?us-ascii?Q?zdI7tdJ6SWuOMx0z9hw+dYTSuatgemaGAfH95LKBXHErodZ67yYxO2dAQohD?=
 =?us-ascii?Q?Y166kc4Ey9v/3oOSgMjmqrEMiapf0GeW3EU/aqF/fw8/Bv4OJI91Ok2AJH3o?=
 =?us-ascii?Q?+W9eH1o49vn+Rru7OwmFqB0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8932BF7610E2A4F8CE0D66BF66126EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wV5mL2OnrZHe4qn6/n1pLmde7Oq7EytLySCjz5v21mAzEaiRxlxzulF78KwEQE3gcZauog47/WhPYvr+u5yshSeKw9PE6Gkxl3eX9jNRLdkrJZFvHgZcTZ22jA0utLJbl1oG/2GLaVA6lucOn4NrGIo3yFwjCc868meSm3VcBYQmOkofHfv27f/m12jblIPSO5MrunyqGMibCBPh4nlsQLqCRhCaCGNHaQQmFMxyfuIOg2sanuZuACr/lPVQMsfvEZSDDcDz2sjzfurfHNXNmkiehgX4RnEmQzuiTWpSfYjgqcYmiQC3A/TMRcLq3QfxH1lEHlNqVcgUUjN2uBT89VbHjLQ08MHESNFOx7sPCIyvOUzmBawkNHEhZrOzCme/A4mSfkFsVEGi3+HNOyvKYgAb7LLOXO8bq5vBYfY55wofJnCm497TSyezt+glhWOhxLzCsktsOek1I1Z+eHgsjChtID1blz8Qvb7VCjZbj6GXkSlfWObmbdoi+xF65QT34nM9JjZ5f7ly5u1C4N9slTjOkM7hU3kv1WLgBWCMYAjUU3ykmNGiuocVKpIikp2XSOu8/XHdotqZ91ohWtZpOEnAEVJw4jaZ0e1oMfL+b4IoZxd6yX6uvIxXpYn0CRMz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f031ae3f-6bd9-41bb-8fca-08dc26d9308f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 06:02:24.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCNulpInjbjWITh9Oo7fpdXgX6uDEkuMQ1MFBDPKN/YIdILNE2+ycK1oUo+gNPOwPUlBgqPUKZBenph3vMlS+7gZvM7r1bwGzZYwYY5yWOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_220236_786640_60C1A74D 
X-CRM114-Status: GOOD (  14.83  )
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

Hi Keith, thanks for the patch.

On Feb 05, 2024 / 10:52, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> I've encountered a device that fails catastrophically if the host
> requests to an error log with a non-zero LPO. The fallout has been bad
> enough to warrant a sanity check against this scenario.

Question, which part of the kernel code does this test case cover? I'm wond=
ering
if this test case might be testing NVMe devices rather than the kernel code=
.

Also, was there any related kernel code change or discussion? If so, I woul=
d
like to leave links to them in the commit message.

I ran this test case on my test system using QEMU NVME device, and saw it f=
ailed
with the message below.

nvme/051 =3D> nvme0n1 (Tests device support for log page offsets) [failed]
    runtime  0.104s  ...  0.126s
    --- tests/nvme/051.out      2024-02-06 09:46:03.522522896 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/051.out.bad   202=
4-02-06 14:50:57.394105192 +0900
    @@ -1,2 +1,3 @@
     Running nvme/051
    +NVMe status: Invalid Field in Command: A reserved coded value or an un=
supported value in a defined field(0x4002)
     Test complete

I took a look in the latest QEMU code, and found it returns "Invalid Field =
in
Command" when the specified offset is larger than error log size in QEMU. D=
o I
miss anything to make this test case pass?

