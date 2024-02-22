Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A392C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHgQaEQlYkn6ujYz+MSkx2F0GoQDIkTIsN6UEGGddHU=; b=ezIYgLDJMrDGzOFD1cPonVOVN8
	KZGE9N9QTi3HksMrK6HInCmiSMtex/odoZ75tt/wzlTnq3NN1Bh9kn03YlUHYoiZivWgtiumGNNHF
	ERJHNeiW1IPv8q7KuC0uiK58o3EN8RaYNG+D2i7PByO+xqPjHnuuSpSPE18FPnI+FJV8//98Uy8Wg
	3Jpv8ATcqyyOVD8Gr3QV1adSa0hXlIxyPkI0FTuPe0PtxKPzLTD1+cYIbKSTFdYB5RuVBqAohafDI
	Z2e1G4fCfrRY93ywpIQzOusIfvjZVTAt+RETBSh4ypQxSxQYu8bzTCV2Kjh/FpyYLkY6OGs2dUXFk
	ITXJsHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFHu-00000006Qyb-43Yj;
	Thu, 22 Feb 2024 20:03:22 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFHr-00000006QwC-1fwl
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 20:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc95Zc0+g6r0F+pkZOzdUM6K6kbcLt4enMjiidGGbrVRatjSilPAHRDu5gZ8UkVAsM5SrL/XrxqqgmYDKX6DYZxMgLhsSIybWufQtif+5V8lbisx+adbalF0eAx/O1mWBJvelZfnEviLS36LN4JKApwSRqx++lx20Y9rLn2m1AgFZg9KrdgzZDxY1YNmaIpbT3q6ei7wPFJunkfDceinI/z9skTjVI96EzJf6N+FY4wd1fJ/TGRN+Mig/30sBeR8AYOz+FnD3bC98bq2ytsHWwrRlPkYbmLc2kGVVet5iL2+68n3fBrNvaij7Wy34PaPL2XhntHODoVoPwAMaStHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHgQaEQlYkn6ujYz+MSkx2F0GoQDIkTIsN6UEGGddHU=;
 b=agW42Vu+96EPQMuNxvqEp5Vi5QSqAdnzzDcyr66egv67oT7BPoBnwlW0PC2jIs8ttkxqMRYhmOXqs7np+mNozNZPK2bIeHeM4nIfjSQp8ImSlJsVs1p9yF85s870M9BBbTAmPm/5BV6XVzFxqc5ykVxCqA/hdFb348ViXBHg3joqVp7BE9xyage3WNhhfj00UuiVHuHjVeyjmLJMimAeQa89A989NqDgkPGFLUTLimaHf/ZSx8AbV/pbgCUxb4d/a15cD43/YptHgbo518V8k2V5Yb1glb1r7FgEULQCtw5+CKxy017fvhghnyQtD9Ml6AN4zTP5XwH1m7Bu97wAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHgQaEQlYkn6ujYz+MSkx2F0GoQDIkTIsN6UEGGddHU=;
 b=vmy4feFrPlTBOXAns3dqA4uO+afC873moZ0XJwoPW0Mre6VV1p4l5bmlpH/aoY8Y8IAfc4NtN/30BCk27jVs9+YxyV2ce+KPYoXD0P4SQNZKXG9hZLeCWraTd9c0TsVk/XbUIF62ZY5/kmliBxp5za8VqqRfbE7fydsp8/VGOQVW4SF9jpQZNv8TzEFVPXi4raac0MB56ntR/T+N9+8/euSDlZ89HzqNnr5V7GURufkHJD0lEPVZHn60LaZjJBIk8WssJq5+dYmHaOoHvSjr4rv0ntBDRxMzNPo2BQxwfKyqaqodtVQS1DVB/PAbZNCYQefpiL1niRVhEgwU1LBfnw==
Received: from PH0PR10MB5419.namprd10.prod.outlook.com (2603:10b6:510:d6::15)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 22 Feb
 2024 20:02:53 +0000
Received: from PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::8905:d9d:43af:3692]) by PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::8905:d9d:43af:3692%7]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 20:02:52 +0000
From: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: RE: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe drive was
 leading to a hang.
Thread-Topic: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Thread-Index: AQHaZKMbpqMFJd36skG9fWJcUpl/8bEWjt4AgAAv9dA=
Date: Thu, 22 Feb 2024 20:02:52 +0000
Message-ID: <PH0PR10MB541949F6392DE75106A93A0192562@PH0PR10MB5419.namprd10.prod.outlook.com>
References: <20240221084340.825068-1-michael.kropaczek@solidigm.com>
 <Zdd2BOp6DEC6N51V@kbusch-mbp>
In-Reply-To: <Zdd2BOp6DEC6N51V@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ActionId=416f1eb3-d2c9-44e9-a587-028404d1f433;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ContentBits=0;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Enabled=true;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Method=Standard;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Name=P2
 Confidential;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SetDate=2024-02-22T19:19:26Z;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SiteId=4bb44aac-867a-4be0-aa34-30794e8470dd;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5419:EE_|IA1PR10MB5971:EE_
x-ms-office365-filtering-correlation-id: 3f82124c-bc8a-4cbb-670b-08dc33e140c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAEePdtYD8y/SdnrV3SuUeHrC7TUZSs/RA5a166gnoLVYS5uRTrkl3qYzwanO3wiyB8wQXueqC5A1jcTt/hX8xt9DFXyhJj7NLyBdItEPh7EBQ6dkVd9lZEUuchbvV/Pqdt0ZrAuSut4kWp6cn5cmek4iqonaBcPKX6TV37MqqBAUOqB6L51D3JT7PevTkPDJxOaxKXbLr+9nTI2JnVXTGNIHVik15vjEgL7JFpdd0BO1s32g2JaydRWycrTnIkeU9GW17713h2f+S+/cCv897lpnfplGMFhTBwuI2CTLvmHZiH2pv5iVXMGq7M9RDkhL9c6v/m9wieyQrrPB+a0TwumI8WpK5LwUsZtAxWrza6e49qUtZECthsoBY3BykERushwagaDw97mjkwTR1bBNd9VvXcU5YQl2RIIdr8jRAbYxa9PKybxLpnI8E/mU8ILEueaMVX9M1lqp7iPrvH1vVpczsvnBZs3yqCgmZb4aSLnN+uxwEb+MYqiQmJuEXo2PV0l8TDeMjeWG5Qn3DS8QcEEPi3wi5ufCt2BMsIdMVRDmB3/fajtDBVvO6r+l06CHZxuAwVRl4cu4msulk5HmY0SJyCL2ljD3X/S2ATrLPD0/5KoiiSCFREBBa7JUYuC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5419.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ReAl8bcZsN+Tv2WD+Hrl9cwr8HgGj5ylUwnq+BtaObGGYnymsGVSMWwHOp14?=
 =?us-ascii?Q?G0LiPzIlg0Nr7vau2tVFd9mh3jg/YUWybwpKWjvyIYZkx+LOglh5yC1pySoG?=
 =?us-ascii?Q?6T0093+svmEO+vfUgvGjq/kUIG+BzSADT0gwvGoE/nqPtQATPPryD/ByIqLl?=
 =?us-ascii?Q?cHDKNNqCyfTv9XXEPgOg+fUR+l+3gy3xByD/Nq0Q/y1ghqFpDSNXgmcx/VFe?=
 =?us-ascii?Q?FRD6+kkOrAg+db9oZTD+xp+laCQZseYXoPPw0rXbjpQn7wN2QXi70J3lzUvr?=
 =?us-ascii?Q?UFs1GEplcDyE6e3R71uUwSnBCT5rAPOdSioYXNdpUL02sTmqrtLdaSjO9VbL?=
 =?us-ascii?Q?SkGpu7J20TlKjs7OuSX0M1hqiY/ZnNodwmlzoWyiIeEM/6QtgaQIT7plwnri?=
 =?us-ascii?Q?RDUKIbOwMVefz81s56Bubf+Jw/6hfkAUy+vVkYKnPSXqixCaizt9yA9gQffb?=
 =?us-ascii?Q?snz8UWBSjazJzWilOyvHX5n7cY3UCSbPflc+zxplNWZ3RTRJWu4aiTyruu98?=
 =?us-ascii?Q?a0ry1Dghf5ST94gzviLNYE6ahhazY5YSGM+Grh51GxyAS8MY6/IOvALxX+n8?=
 =?us-ascii?Q?9q7DqfhfcwXj4BwdoKcGBKxuFWbYfHQEj1017wocj2ktXJT8mad4CPLoxcnG?=
 =?us-ascii?Q?EQt2la+kbtx/jID6DYFJj91YINzt63/WTzELGIObQPzIr+0I6V7xFQ37Qg0I?=
 =?us-ascii?Q?7p04KepKuPZyUtDAn0ZpJ4Zq+Si7TTrWTOnWttVAGWIPgr0kN2MpC87i90hD?=
 =?us-ascii?Q?a0prYUqttrEK35tJQ5wUOhOBZ7Fiu7iNNa+CXqqWdSMRU1MssPYMW429Nh/d?=
 =?us-ascii?Q?joJS2PDIVNK0nEVHrhqFNfE4K3jnL2A+GaIxWm3rWwTg1tdHgZNyueeurKUK?=
 =?us-ascii?Q?ZR32bmWnm53NJbDEjsGfYFh37tmhQO6KJCsBA54oG9s6FBoSCeLDI6thflCc?=
 =?us-ascii?Q?WHektlrVC810pHjy7j85gLxCZeYYCRs26csxSaOAH4dSUNN/6AXep3NsvBtI?=
 =?us-ascii?Q?S46VMCbUSwUQg5s3syq+6cCDfr7bGr3/su5ufY9YpWBIQICiCqHQXHrva9ga?=
 =?us-ascii?Q?VhZtnyz5WQbaHAF3krzM9Ub6FCYraABkR+qeD4wiiroNJswLItxFdkhrB7tK?=
 =?us-ascii?Q?fAieEmYBrels3Hrzmda4Sk6PKtmlvE4dHI9VOmOpMLLNdwtpjjkMajloskKl?=
 =?us-ascii?Q?EYJbiF4Nmlf4fzxCeCwHWlZ0UMgQUHuXdrDagQGz+P4g7x4cmppGs9xj/Ovc?=
 =?us-ascii?Q?Su6mtM+aVMhkBwfeipeMUUXJIv8qAICE4yzFVAGozKKcXy4y8vhCZ8kXelMQ?=
 =?us-ascii?Q?yZtrqsyXrE2P+Jo1Mxa7piimcxiRv7rEDIR8LfXUAfAmMgsudWv9Y7ih5tUp?=
 =?us-ascii?Q?7k3by9ZqzWWMrlx5kMMqjj3ArLIjS2RDWfTWCq8agETTL6QVULKd9cpb4iEo?=
 =?us-ascii?Q?iOqoVAERfMtKysBq/VYj+7J8FZZgUrAbzVfiFNc4w6k0vuoeJ691vvzLpvwf?=
 =?us-ascii?Q?dVjO8b6qdblEp2CscCkRga9TY69BjpDd3XJFuVb1e1ypL0jAhkoxlkR78P1q?=
 =?us-ascii?Q?1YB9BiYSYX06kGZjZ/6v1iOULztrtLxA2I2T2OCKY3XlgGHV7ZZcY1bEdT8l?=
 =?us-ascii?Q?2UsbIaSu7Sha1GtszBq36do=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5419.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f82124c-bc8a-4cbb-670b-08dc33e140c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 20:02:52.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31ZpkD40Z7yimT3R2FCWPmduzHM90BxgOilJaurRGKmsBBVMGxERLwYlVqPy3Kpf+CGbdJsOwBhMMRYuCc9NPCWuefyh8PqmiB9uypWFB+E1EnVEDelpQScac/SV89dD+gjbCwxSFl5zedMEv0raOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_120319_539218_D058B478 
X-CRM114-Status: GOOD (  18.25  )
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



> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>=20
> Sent: Thursday, February 22, 2024 8:28 AM
> To: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
> Cc: linux-nvme@lists.infradead.org; Jens Axboe <axboe@fb.com>; Christoph =
Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
> Subject: Re: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe driv=
e was leading to a hang.
>=20
>=20
> On Wed, Feb 21, 2024 at 12:43:40AM -0800, Michael Kropaczek wrote:
> > @@ -2593,6 +2593,16 @@ static void nvme_dev_disable(struct nvme_dev *de=
v, bool shutdown)
> >                       nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIME=
OUT);
> >       }
> >
> > +     /*
> > +      * On certain host architectures/HW, DRAM was keeping memory cont=
ents over reboot-cycles.
> > +      * It was observed that certain controllers were accessing host m=
emory after
> > +      * resetting which led to undefined state preventing proper initi=
alization.
> > +      */
> > +     if (dev->hmb)
> > +             nvme_set_host_mem(dev, 0);
> > +
> > +     nvme_free_host_mem(dev);
> > +
>=20
> Shouldn't this go in nvme_shutdown() instead? I don't think we want to te=
ar down the controller's host memory on every controller reset.

Thank you, Keith, this is a valid point.
The function nvme_dev_disable() changed here is called from the nvme_shutdo=
wn() subsequently through nvme_disable_prepare_reset() with the flag shutdo=
wn being set as true.

Considering the re-usability of the code, would it be correct to wrap up th=
e change into if(shutdown) statement?

The reason for asking is that disabling of host memory should follow other =
calls as well and placing it within the body of nvme_shutdown() would requi=
re more adjustments.

The call to nvme_disable_prepare_reset() with the flag shutdown set as true=
 is made whenever the NVMe controller should be shut down anyway.

