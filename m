Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A80C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 04:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXr/S54uwQ4A5x2l6e6gmoLerBfUQnRfJ6ql+dfUw0o=; b=rSjXViYqFvFFZDark0+eJUdeFg
	sAwA46Gc/SeoPumtzCIVBgSY0ySU8CTxFs6LmbLdr2QhsJYK67KTHjnhr9LeB9mdggOaNBMxpfFKu
	A7KA9HNBoDpo3Ad2VwtnfXuXMsRvwUZlQZWZ/jmcTS/pEyJGdoICNp46mbW+DasZMqflZdb/itffS
	EWlQlveabA2PEY9IynprrOOHC7yS6lAVyFO8RS3VUYFpJ1LyBRjR7QmFdOBdoJ42bdDARtlk+gSMB
	XGxVSlNC9l1hyHfH1GDycUmwGroKblJUztUOyqmpMoT/s4PnnhMD1/lWSDAlNGXMxZ5uxYB2CIGf0
	aHAPPEKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAMlG-000000082gB-1P6M;
	Fri, 24 May 2024 04:42:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAMlC-000000082el-2Yr8
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 04:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716525750; x=1748061750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KXr/S54uwQ4A5x2l6e6gmoLerBfUQnRfJ6ql+dfUw0o=;
  b=ImlT+od93XT9QDD1q++iSIKcnMNLDGv7vBqdbhRQ7eNh6DcMytbNm3p9
   43fccTJ86D/x8psmpjFN/N5GHJagNkJISI0q5guH1GuyxYBhXmvw7sDLo
   AC0arDRnmGst82JrBKbmHpxaKX4d57xVmh8QUxQ5qdHQL7Tty78nsVGLZ
   +LYnEEwU58HkrMB27aNzx5/49MGZugpuUYdSekB65iaDvk9FGNGTAOsEc
   Y9V777cUvA5NQvZoAUWzfMJCsrOA6lZRYqPxanQUrhAn0Rkf1W/0TkSs+
   FgHrmux3bbXYOPFNZp2x6fag/HfpNlb5lKpIsxxto7pj5jy+94CwPbUQI
   Q==;
X-CSE-ConnectionGUID: SiETsXzqRby2DbTrDWEWrA==
X-CSE-MsgGUID: iRpdZvQgQ7+s3HlSFQ8/lQ==
X-IronPort-AV: E=Sophos;i="6.08,184,1712592000"; 
   d="scan'208";a="17127656"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2024 12:41:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3kRk77doL9oe0dj4WktElZMYZQewuwUVYHmX9ywt3CJz50B2eqPvcaWR3GQN7bBsGsrtj3HziasuwxMX/8dW4Rt1g3YZL5q5C8HEiMKOZx5i3ndbfE/la9I8uWo0KyEfY8JjYEi1kztS5p30Co9rTsUShbyxWtK60abvbJfskVT/yrFUBREo4Nx3sW/7g4sTPrWhMe6wPDWqcXt7B6jn6wYtEGWJpNxknyOBr8lR8NI/rKResUPPWaAWSa35bh5/yjJtIxUxveAe/yeBZJNOGe6p6CaqEx5TMGyi17TINa12PUtvjY+IJrGfh0Li1GWr03DFQank32eczuHTfArgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXr/S54uwQ4A5x2l6e6gmoLerBfUQnRfJ6ql+dfUw0o=;
 b=PAhb+KOSpFv4OB5wpOeAzvaw74x8Dfz6+MH/2E6awuFcZ4l+mb+GXNQVEz5s9QQoU0ozmpzmQ9J6PlVIPOWfHQpzN5vNNC93K1Wd88rO6Dc2Sr6kNdZDEpgn6pyvcKp6Rol0yPLZDETCXIwfdjWxYG8r3Ge2Iqk8JU6281LezAAnyKKUm16gK0pq+C1U8vLmm1E5fikAXYj4FtnqThSWxLZBT430mRp7Z9H3QnVabja9Jb4sLRkwmrTbU+DgVcaZsf310XOYXl7VmZdPoI7hXPQr6dHbfYfiz4RspgSnn38lctLN494+4LbRX617hZG6SSULTz3TxHQMGK2MwDPtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXr/S54uwQ4A5x2l6e6gmoLerBfUQnRfJ6ql+dfUw0o=;
 b=yu6LtEMGGXqOVl/PXwE+2MG64eAcmwrdYMovZn1hozIVr9GxNhm+ycvgK1cmBn+LykLugBQc15UpCq11y4zIEUj3iO1n1RNH5zom6OxTDR3JxkekfroCfgd2AUzN/BxVOSI2nh7VjqcRmT1EdG+LyhBkCFWZWLlqJhcQ6imZq/Q=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7968.namprd04.prod.outlook.com (2603:10b6:408:157::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 04:41:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 04:41:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: use srcu for iterating namespace list
Thread-Topic: [PATCHv2] nvme: use srcu for iterating namespace list
Thread-Index: AQHarTWeiR7fH8u1B0mlF3YCf7pKMLGlzvsA
Date: Fri, 24 May 2024 04:41:55 +0000
Message-ID: <c7l5prtn3nxihfvbrecmf32mcfchuwrdredyl5ofhbta4a66v5@f4u3iiyev2ex>
References: <20240523172050.4080218-1-kbusch@meta.com>
In-Reply-To: <20240523172050.4080218-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7968:EE_
x-ms-office365-filtering-correlation-id: 668a16d3-ff8b-4101-a6a0-08dc7babd70d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?z5tWacGqdGS7avu7BiH+3ZbStrbuO+l3V2FL63P2BRRuirbKxsrYdrV9evo4?=
 =?us-ascii?Q?xSAQOyqX4YnOxqhq177aHc1KsHkBs15yWKnt3QB/2P/hfhMjgfpwxvSxSMZa?=
 =?us-ascii?Q?HfAkofF2OLm59JzB5UEn4P/0Dxa/1YQ92pnxE0ISdw5Er3NAh1UQ8+rott1F?=
 =?us-ascii?Q?PDx+W1nKPsrUt4uYQKa/2t/zPYb60YrjlPlDqt6Rtw9ERD+r9cZFP1htBuzJ?=
 =?us-ascii?Q?Bvnh0wvQk4iAnGi9EdX3+Hsymv2Fo+Nd7fWr3IZuyq7incqOQSr1thFYye3t?=
 =?us-ascii?Q?BcGur2uIxZOw3L3vAPmeeIV11Tm9RBxsaXmHotl+PZDeFrGVf892mhn3X/zr?=
 =?us-ascii?Q?yn0QMcWj0CYkSou0MZ04mAWHLCdvfJ5BTz8IIFF6eOMqEGNnpZ+lrkMhzEQn?=
 =?us-ascii?Q?723i5xRrk1SZp0iHRwET7rYXXomKV67q90j0JIdoRsx6F2+XkKuLJKqGEDCG?=
 =?us-ascii?Q?s0M3d2fHL6C95o0X3DNoDjVkeOLdQfmLSqNJfCnAiMJwu3+oQc++DzPeD+ro?=
 =?us-ascii?Q?ZLpcTrMCEJF4HXyyRIOqBM4CDqJrFjfVsWBc7szFBydKGAyRy+XTqrQy+NAX?=
 =?us-ascii?Q?OSzjl54kfc7ZVFWn7Lwbq4dP5/m4X7VPaPeev16c/3k2AXAf41t79dwm/gId?=
 =?us-ascii?Q?wS/JipqX1pSzSLr/JRYoPKnakMukFQ5dyvsn0SCptQmrkpyy5GFD4xQ9OezV?=
 =?us-ascii?Q?7yCxU8lvx/4K04ZLT7C0tbaSPNovfqjZ4nB19Z/G/DiXUuYVyp3ccAWRnt+J?=
 =?us-ascii?Q?Yo37wqMgTgxQRHxsJnpn3NgZlwh96CCzX28tXdwY/mrLt/yfOLxsBZmUypCD?=
 =?us-ascii?Q?R6N9BqssMkD8VSe5GcVyZ0jL94cR3Lio+jMjjYL1JavNqY9tagYHBg0cs97d?=
 =?us-ascii?Q?Dyd9SLJGpinR6gsWETvFOTUPMnVNArBxFAWbjgkJIi4Xn5wTa4BZlNxZm5D2?=
 =?us-ascii?Q?DlzqIABSemGCfD5tokBmAP19yVDmgv2I8VDEg3EHKka2Jsd4eVIpEIfhJOcQ?=
 =?us-ascii?Q?w7kfsYUzuJK5BDuZO9ERBcEnLKvK6rUkeleLAWrqqobVyo9wwrAmYuC/To/7?=
 =?us-ascii?Q?vCma7tUpPIHwPpgkBt3F9nqGKz6a8mADxOUWDOi10D6SjgKgkft4dWASIQo2?=
 =?us-ascii?Q?Z7SureCZa4SHBxUvg4vvrNF/Oy+9P7e/MyEQP+1BqALislVldzNxOM0fK8l7?=
 =?us-ascii?Q?QXV2ThyRnGX2RU079Y4PH2nWGvVtipLjynFZpiihjHNipxX/e6Db/h7+pBj1?=
 =?us-ascii?Q?MHKLiHCEryMcjnixVlQgR/SbIhgZAAX+VGWBLR+L/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZfZ0SA9OdP8ZvSjy/0htcmBVzdV9U9HqjyAdsm2KG5u2RSMbSI1vh7FsVTpO?=
 =?us-ascii?Q?2qTEPQidT9UeHVPlB8I0j6viGCa+3i7TXhQtB6mBtPS6vuFml8ggaxWSW06O?=
 =?us-ascii?Q?46ssn7M5ND96NHvYIo0gq+daICDYljCXhtUwkbOF3z19aS3ygE+SeNaKEhQk?=
 =?us-ascii?Q?1BEewS6VypTWclnGNy01ew+CfUO9ePA/sMk7DKvMCacrKli/7857t07WPAnY?=
 =?us-ascii?Q?CkP3NbwS730MvLxocYCLZPY/5Y5P9j3p4zuITYOjsZNUphGRflD7pMIhyzmn?=
 =?us-ascii?Q?OO7a3TEKme/cKdjyBtotPwZn2YYQwMV+ih5+obesqalba2yvep5wq4+92Mww?=
 =?us-ascii?Q?347RKE8gv6WXF87Yv9amYIr+IjH8pmBGTsekfk8B7dwlL0Nvis2tsB4jQfY7?=
 =?us-ascii?Q?uLcM0qcqtuwIwsE+h3/EMnUnqU5nK+z+nAIt5RPmKCYiq1bL+c7baI5cj7P6?=
 =?us-ascii?Q?fy48XEaw6xhXEHaAHi/swYsC8TQlgSI0qumSTUSEJdOOzuFXaUGge0r8bczH?=
 =?us-ascii?Q?ZLqqUysjZQhXTKq4/RROc7SsZnFyHP/u7zFvHWbCL81KsTkz5FsDu3zUQoMy?=
 =?us-ascii?Q?x3lFZ5Mo7tIGcnJZQnzE5lXYdDRM9clkpEocOFcoY+LGdRyb7ZTMyB55qVL9?=
 =?us-ascii?Q?I9FGBCbw3h1qk535bWCzv9AefEQmSzO6XtP17qSzcTa4uYhH0E2rnNGUXWJ7?=
 =?us-ascii?Q?5/ylyNBhZ4AOonTLv0xvoSdUZ++1M1qWhnKNyb3qaNdEWtd5NPhJYiayB20B?=
 =?us-ascii?Q?gzd7J7BzYhqohVFG5ebYHpZsXQtpUI63ZCkNLplquAh++5sbxrS2EhPvDCtc?=
 =?us-ascii?Q?IF0BsD9zcbUYi4nLtTiDXRq1MviIXfc0Bs2i/VbWxUF6l+02AdFa712ZgnXP?=
 =?us-ascii?Q?f2S4xs0TsNQePeBAantl3pxo3wkydPN4IiXEnK5ojaAcwQQ+YpQrwedw6n1U?=
 =?us-ascii?Q?dYP9kw8MnCN+cMAWG8dMHY3MNt4GmyUkdwIk61f8S/p28PsKm288HPzkpLCF?=
 =?us-ascii?Q?WsthowC/BvW0t0MpXyZWnaUbn2XJ3ZXRuUxaaVQbK2hPIVvwDbluMO9IlvLw?=
 =?us-ascii?Q?HjD8yWI6Nkuc5yNaL0SAS9xN5RDHvm0xB56RZkjMZYBicn0q7+/+Ax0F/EHR?=
 =?us-ascii?Q?wwmrlFFCtGDBUD3RbHHyoh9f+CZywdCqBGOkHa/prI7qoqOsYTOxYS5156Jd?=
 =?us-ascii?Q?YupqsXiYaQb8m+OQ0a1eekvPZSm0Mes8bB1lPKDeF6Qon0qJ82wgz71Bte2z?=
 =?us-ascii?Q?WogJH/MsG3Vpy0p/s08mRfmpAX7dw17Ag0G0IcuLYOCY0OxJ/u/qha5V6j1i?=
 =?us-ascii?Q?ecUYg+oEpqHAr+OaQiwypIe1HTcH9tjIHDNtub/ascz2m9M4xzU2FhthcvLu?=
 =?us-ascii?Q?4HPBy9yMTtea7np9tCJefZwrSO4ZBJo7uO2WjKTFJk6ZgUXCzU/Httzv2kFq?=
 =?us-ascii?Q?MAK44xF2x6Nz3AV7eVJkx8U9YX1pd0hKOHZmMMguFjU0Pf8vzwvW7crYeX8Y?=
 =?us-ascii?Q?U/mKjwZ1xSucZ2UMYGT07MK7LU4cmT6AnSGge0VM/ObLEWJgkk9gwr9oJgrR?=
 =?us-ascii?Q?YIMgivcguC8ua/X9GtGyUS/e4HMvJi5QDZQwP5O8GUlzcbWQV8z8B3G0oxfo?=
 =?us-ascii?Q?Z9u65zROh8byO0F8ygXX/Ds=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DF6A1ECD5F2934DB57F2CBB6F5AEA95@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zZ6KFRCMPPod+RCSGfghW+6jWBkfUNt4ofeXY4mlmNpTohx8EYkfeYgEOK9Aoiejovus8BcUmMB9dNUGUAiV+1g/ant0UbP72nKHgNmMN/WeX/F4Bf2LcCgj+s2TWFOMPABPLdH1IwE1qQP87wduMhiR82aetIw4R50QPgt4QVKUU0YDjSh7FD2PazPnjYtHvpHC8L1Fri4UUd9SR+2zzsCz4DZE/amm5bPD+cNiwB7Z5gpTvlV5ttW262o5C8wIJm2CLW9dl4fdRSG3qsBpQyvaYQmcvcmY6yn6n2eU0OQitzLNEF8RrYpUHl+qcesNj3Ursndc1+cVOsBZceiae1G1ZJ9gMqkeLNYpRPVXjTArohqf2PsgT6jYfRKNCaHiLrmZ7QLVf7SdyILHSdiSotD17NPJuTFpAOXYN92H+hpsVNtuLR53V3UepmcBfgDS0R3qbh5xdUaSst2afMqg6OYEQjbXr05YwQIqmck/qRk0SJtv6hY2KO72rjKM+ZTymCpazMbJKy9IOnBBbeOhvcwtR95WsxkJHNUXPykCOhxoq6tHybXy/t7gjEAnvFnh9hg69Di9Mg+aKc5qjk4pUpi4cb/DDAd5S9bnx9W51ktl5rs61iS2PiEiOJrjwCbF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668a16d3-ff8b-4101-a6a0-08dc7babd70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 04:41:55.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCOkld4+StHtvbDa9FlvTRuJyG5D0P4Z6zysocpqzfQaOsdefoBPz4qURxV0OdCNa4oAU+eFdlgHKKaqXtriIDSw0ONI99xFzpiIbJ/QthQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7968
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_214230_763638_FA06EFD1 
X-CRM114-Status: GOOD (  15.61  )
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

On May 23, 2024 / 10:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> The nvme pci driver synchronizes with all the namespace queues during a
> reset to ensure that there's no pending timeout work.
>=20
> Meanwhile the timeout work potentially iterates those same namespaces to
> freeze their queues.
>=20
> Each of those namespace iterations use the same read lock. If a write
> lock should somehow get between the synchronize and freeze steps, then
> forward progress is deadlocked.
>=20
> We had been relying on the nvme controller state machine to ensure the
> reset work wouldn't conflict with timeout work. That guarantee may be a
> bit fragile to rely on, so iterate the namespace lists without taking a
> lock to fix potential circular locks, as reported by lockdep.
>=20
> Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev=
/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Keith, thank you very much for the patch. Sagi, Christoph, thank you for th=
e
discussion.

I confirmed this patch avoids the lockdep WARN that I reported. I also ran =
my
test set with the patch and observed no regression. Looks good.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

