Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2D1C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8r+hTcovRfJm/i1BNZu236sHD7ToPnkoVRO/23pV6g=; b=Z/gdouzwFF/UdG13RFLWcFmQ0P
	T9whH3nk47SRqW0awTuMbhPuBBWDCAgrNkT7GcyWKhouhPJDuxuikWEY8oUX6mQxGb51wzWh4Kr/h
	KAyKY0uA5FWyCQJT9V/udq6xI/gr3Z3dlTTOFDNMR0BtySKehfHfYEmIUq1kb5pH7eOIkf82pydad
	lhCYKOLHzCNHtJr2Dxm6svmAD+kNlEnmnOS7E7xFLB5akbUN1pcmt8BPNvpXsqrOxraLtVOYJLsWW
	36al5kg+Twmwi0umthm0TYfxv2ER9etPooWNchgavd46zp3L4SNrydinuPQiVOqb/rDBmoMfUIpvO
	+ILWpqcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px9Pb-009P3I-2O;
	Thu, 11 May 2023 16:45:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px9PW-009P2S-1N
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 16:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683823498; x=1715359498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g8r+hTcovRfJm/i1BNZu236sHD7ToPnkoVRO/23pV6g=;
  b=UN9ZKaXF4mE7GSG0ea9apeVSZMUl/bYOBSBtMoFPUhCQ7m2o2832cq5Q
   JhrwEk5UERkmBsuFMEhscXMS/TgTgU5+VSV4Sexb/u1bDEGcmTVErHkXo
   s7GvKxbpitNFSUnO8suF2aT6kj6+RZGuc7cS+IRxoI/x4/mfaZlEnqmWM
   yFjXPOloV0gQuGeeoffFULNuFNMeNeIupwNneAcTd0t/maFoMCGV2cRjN
   8IhLiOGAfAEQmLu0Rq5m9D2GL5jIAfy8GSTcRgoK7JvUdi5tVq9O5JwVG
   cTGNnwJGB9f18/97aezlgZ2YXxzn4I5tYuy/o8/VnyXiJ1oysyDErwF1j
   g==;
X-IronPort-AV: E=Sophos;i="5.99,268,1677513600"; 
   d="scan'208";a="235442698"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2023 00:44:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaWGDrpL4kNEXsUr0e4IcjLhLeZCWwMAeS46zwSLR/y+XDZfeagRfNNWBAyBq0boxGm3mHYkfVWQtwIp1fNwksBXoW/oKItGLdefxWXznaSNWqrkNfo83+T6Ii4ZpVvNCTgxmqeT5B3CIn24rt0rUiAXvek0ARznwFya81EAmMXI0UL1uO1A6n49FY7qFE//dq+g//A4jEE8hLWSxqqfrCwMfd+ewlGL56HJ33whgd+wgIFbeX7nBmpJCEVwJkgVUYDDy9IwHHfmKbu0D9TfIqd/cW4f12CfasRW6l27Vv2oNUmwocjfkRALmme1c62ocHfnkcYsvJrFNBHwegwjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8r+hTcovRfJm/i1BNZu236sHD7ToPnkoVRO/23pV6g=;
 b=lA8c/4R7coP8GboEf0DdJP2+v/0GEmiLiuQQUpIAurVSXO6+UCUiZei868ssMw2mdqVLZNjAu4Fnr3PubhX7CuU0YBBxcsv3G3DVxhVI1Dg6ihgS0CsQLN45ShHHDF3diGkQ/gvqgEWZ/3pf5Hmy9KXEfsQ/2r1vH24lS1mMGbsaFPORJtZY4jyCceX/+k1NbhodSbYa/UijNQdlrHP2Mp0nxIJLz5PkOp2RLCWIeHn14yMek4eduERIcBQEfMO0FMLgYSYzkL85vN1eOgrbPJUzGcfsZcaTgLqccJ0Dsdy+nSWrfjvYqLrYnZ6AvLDnhwYTJ7iDPoFEsGZHZygEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8r+hTcovRfJm/i1BNZu236sHD7ToPnkoVRO/23pV6g=;
 b=JPTMa6yuvYKiKclKoIdomtSd3vfto3+EcnhTbs7uTNqDS+2ojajM1QMynwHBtBZOQZdc7helgFkS2NDlCdgo0bq8emOYLW1YlSM4mp75lH9Skpd/t+M9Vsv9vz7H/ElFC6k2HDzpr9kdS0wS6QPTyR5SFIg8HPKwP3hhD7seTJY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB7118.namprd04.prod.outlook.com (2603:10b6:208:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 16:44:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 16:44:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Thread-Topic: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Thread-Index: AQHZgTyFD/YYYRDKLEuLLtG7PZkYY69TxfyAgAGHWQA=
Date: Thu, 11 May 2023 16:44:52 +0000
Message-ID: <74gmncf3mmoymdj2ranyzgzohv4m3osnnyckiwj55a6j7pi2lg@524euomat43i>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-12-dwagner@suse.de>
 <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
 <5mizvgs3mwoxbkgb3axuhgkmjjxa6svi4laksdccg3oue5fwf7@4mqtz2dm6phj>
In-Reply-To: <5mizvgs3mwoxbkgb3axuhgkmjjxa6svi4laksdccg3oue5fwf7@4mqtz2dm6phj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB7118:EE_
x-ms-office365-filtering-correlation-id: 9384eeeb-ea1e-41de-09e7-08db523f0b28
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LZVzuTTk3flcF1OEFvpCNGpRCcBoVYrTKO4tJ8NPf3g6NPEQ1uxwf3FB8qjUq6u5ttXaiN39cUH9Sn3adniN9tDjYYKu60TXp/NNcw7RLUB3sgMT+Kf/AVP/7LhBwqy2vy6bS1atlCMcRFQ9O0tgoBCZdnB0hfl42QdiL2Ck2LfV4XZL1k2fBP4OAHrwHqVSO7n7Hh1D47mbMh0o0rwp9pA3AryupzE63dnAWTrBr3gmmlMskDAvi3DNXb0oqqXl7nYvAy/QImo04UonZdvqNKwgHbLy4Hk6saKXucReeHziSwc0qdxZsJfeGb9/QxGJUANkqzEkpS6Pud9k6+Csls+LU8fzFUgzc00wUREHnOW2+ltZIXVOuhP3BaNVUVKoJD1aOq3XA+XI41+mK1T0yNdsK2a5QPEfeQkittoBV0tx04Y+6tl5p/V0HaRiS3DEsx1PapIoWbAY2NjjdOmxn9EGnjy3ERbZtuBQqGuLKua0MfN2bIaG6NeMXF2p2pv4G79XjgnvLmPAorfFz0e4RfnVgbIXvUQYTN4xhedS2vU8RX6ujmVOxeZm+myciYgr06SNnmyuBmUj3rc50DDlEIRP64c2Zc4eSgdhcnvPK54FjqIB1j5KTyXed7iWabE7
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(186003)(6512007)(6506007)(26005)(82960400001)(71200400001)(9686003)(6486002)(316002)(478600001)(54906003)(122000001)(33716001)(6916009)(4326008)(76116006)(66946007)(66446008)(66476007)(64756008)(66556008)(91956017)(41300700001)(38100700002)(83380400001)(38070700005)(5660300002)(44832011)(8936002)(8676002)(4744005)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?28e6ZiZuo4PEGJzXtGX5+qjN4LZ961LTXuY1xksvlcMUFgADT2u0MTv6gQeo?=
 =?us-ascii?Q?S8loD0SnJ7c6n129rYueg59Vn+FoIZ2NvwP4dTXycQybIQu0lLRaKduWUdjL?=
 =?us-ascii?Q?c6IaQmm83ProFfh4AFfB5+r3a3kYDgZJREZDFXcj2jxpCJZcYtp/jykMjjVr?=
 =?us-ascii?Q?DrKjx80UtLIgA6GMvp2GfWQ0lZf7kPDItJWuNFJfyhWao5Otkg7uVuqKmtck?=
 =?us-ascii?Q?7xIgPGZiNI71Ube8oStlgVyIlcQqsFmZERM9SWe7n+ni8wYMRAzAWu3H2XZs?=
 =?us-ascii?Q?OtVFu2sanWVREP4YAO9/bylw9Law8ozPP9vviMHByp4XapmtlRSZj1GvrI3F?=
 =?us-ascii?Q?yfQbiMex3AhFuDzILcdQlzDptl1P+hd5DlzdLo66SXldUrH7gbH3dYqiNEKA?=
 =?us-ascii?Q?Xv1jqKUg+rkO1JnXga2xuM3izc5vHwJp5SRSL7fsa8J8DCoNivNkOePoCFpN?=
 =?us-ascii?Q?5f8tcXJPHa6OAZOmsSZqvqA8l5K6qkZAwWRfn/gkPR3ujus1mkprsp4etVoq?=
 =?us-ascii?Q?mmaGoBWf7PFdKV6RURVTcdWmxH8Qs1UpEMm2Yr6PjhsbZvSRY9fqdicC0Q8j?=
 =?us-ascii?Q?DFfawGU2N72b01LiQI5ejXNfqFO7PGSzvAubJBDNl3pO/A9q4Vgm5rv8wfnM?=
 =?us-ascii?Q?ssGDEUjZYl9PbJooiPcziCBzin8AuSfdVSUvAgE7x/7o4jkEsgHVJJ4u6pbX?=
 =?us-ascii?Q?XJZjlUIJG55Ke1zyoClyJLH7HVaNCYufH2p1O17OXGZ7CKTCSarNam0IgbaW?=
 =?us-ascii?Q?wuK50b1L0k/3OWflOcav8jop1+EjHe3lvHv4UJ3ytmpIBvykUUIlLPFBfai8?=
 =?us-ascii?Q?7t57kLu7ZGrPFy9aETMkCprRwk82ib/+aBojQLLro9Wu4+ITgvY4HUnb32+R?=
 =?us-ascii?Q?jrcUOFI//y98ub66pYCthDJv4EXu6nyLEkMvuBTkuRSVlBd4AO9fS+/nED6u?=
 =?us-ascii?Q?GNZjen1o680To2oxw5mD5QRJz2zGp/tW3tQAEHnpMBQIoo+VNfRjZFZj5z/q?=
 =?us-ascii?Q?Uv9CLlY0Ip1XCR7dk3pDboAtrk2u5pX+CZZTZ9A9xdrErskGbAC2InKuePAi?=
 =?us-ascii?Q?TTehTgUfSWpLXFc5H+VjYMuTFjY+wHZF/aBjfEifUOD9AvehR3UfsEYdrjwU?=
 =?us-ascii?Q?6f75J6c/4MkZliCRmIqfGVe33UxR6Vya79azOHTAcpOilwcd5c3EyHB8URnk?=
 =?us-ascii?Q?cNhSQJfAXqZNh4nAVeSPu3624eB6pWbXjSAgFfvmRqUocVRGIN1R6kDlOPHs?=
 =?us-ascii?Q?89zYqTJBMc+IubHo5UTUgbR5tupDTnicA1DDp66HAZbK7fvHLT/hWTb39Iay?=
 =?us-ascii?Q?0dun2H6f1nlV4dT60aQYaaDPh80wrlYDFHMv1AZxZevZ7eX7riciYjFydowe?=
 =?us-ascii?Q?pFqEdfCGg7RpPlF5loeLyMEoe124wwe18lwdIqD1pszGkBKwXiQVvNkaG8jx?=
 =?us-ascii?Q?8dQyE6GxkwMA5lC/DeG7n8rvn7gucR9IPlm7dAKfZNMaAdzPy0MWt7Z3FUef?=
 =?us-ascii?Q?KygJFLxR6EZy7hAOcC8MV7AcesHclFPFiVhRZKXUv03kd2TOyvM1SCKdboV/?=
 =?us-ascii?Q?OuJEQNYVA9JXaypAUA0QYqxlHwjOlrnC2nKktQu0u65jZ1lWCkr+Mg7GkRKH?=
 =?us-ascii?Q?PrNFsDYRiTklhybVbG/pFts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BC9B46033DEAF4B9F5713C0115112D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	s8mhuDEhURXz/oOntCZnYg3rdYsTOg2fKRzHAUdkZPbuyRObQSt0QCfWF+3LuAOJHOM5qf25Gqfg369POxTt3hPIplz4XHqQBhKCkEdguQy4dyBim3uzAkltonCQS1MBPMOqgLIlZA4Qq6XLITRF9d03vgfxq1PNftQeArg2afyr4lo+T2x2d299K1f+pESYmf6RcjfM2GObPV4FtyQIxpcZbIYV5km8K+VTZ5MEy+JL+/p+Fx1KlF18yTxGJjY7/yEO/hXlrqkAflr6OWfJMm5JKrClzNosxhKSACC/I4wUYhQeqyxyryDdIvplIY/M3uMxHWc2bvgdhx+w0npZHFfSwRBTFMRzIyfD8bqBtrHNgZsce9qD6M28O8ZdPX3uxH0rd0NjHzZ5cwR6NPgjw2eufBASDRlfbtqpKQ2kpvaRGDjZepSJS+Zv5ss/dQuFSaRAlXqWsiMSwaSfEoYLc+PrqqCbaAoPSY+UOwE4g35e9nueVEnS+JheV2Sp3gzzjbhoiSn8CIT/tKY2lVK6oBfLQlJgibHpPo90PZsGbiebMQWkr619SMuIMEDJedPCHyc8qMVwUakspxCP2Yi9tAoyAyaM9DVKwIQqMrvxnLfAOX6+osnn8fR4UXHeB0poNfWbZBjBVX8RylcF2tlhK5LuLNx6A7Gi4ju3/xd701Guyi7xuZ/BAZ8XXHhf9YjXSBSsbmHyMnIOnLdef2waQs5GWtwdStcwL7m55kWhcS3KgPgJLi0X4AJEiczFHMvCpMLYE6gX4pojkVYQ0ioM56FtMd7RcjHEGjxwNdcSYA2dFK3ts+X9YjES0+KlaLL4k4TFW9+0GTb++6jicHzCbvrA4cbZqDFk5fAtIc/khqvZWq18TwxVFzLWwCuZg52t7sg+uHkX8sHvp9MwvIrXL/vJhG8wrpVu+sS7yOCf608=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9384eeeb-ea1e-41de-09e7-08db523f0b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 16:44:52.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycGWChTYSh41soWyIsF3NMv3u7R6WwG1cVvz31HaTtkYztD+LDlgt6c5ZETr4sHpKFz2862pt7SQrioJpSKQ7Pb2d6WvBHhspQj0IKrui20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_094458_523465_97E932B6 
X-CRM114-Status: GOOD (  20.23  )
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

On May 10, 2023 / 19:24, Daniel Wagner wrote:
> On Sun, May 07, 2023 at 11:34:51PM +0000, Shinichiro Kawasaki wrote:
> > On May 03, 2023 / 10:02, Daniel Wagner wrote:
> > > Move the discovery generation counter code to rc so that we can reuse
> > > it in 002.
> >=20
> > The last #12 patch no longer touches nvme/002, then I'm not so sure thi=
s patch
> > is valuable. IMO, the lengthy 002.out has the role to check all of the =
1000
> > times discoveries are successful. So it looks the better to keep curren=
t
> > nvme/002 as is.
>=20
> While we don't update the counter anymore, I still think it's worthwhile =
to
> do some cleanup. We have two tests which do the same thing so why not use=
 common
> code?

Now nvme/002 checks 1000 discovery logs, and nvme/030 doesn't. For the comm=
on
code clean up, this patch removes the 1000 logs check from nvme/002. It loo=
ks
for me the check to remove has some value. Do you think the check is
meaningless?

