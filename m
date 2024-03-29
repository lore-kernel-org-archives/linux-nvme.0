Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC717CD1288
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHGOif1hfDQPKXS2Lwq6Nzci1WPK9+O5uKm/AqOibLA=; b=hy4qlaF7nvBQK5CvXW9kyVJNZ1
	L5CXSd6gWINOKb9WQolUz/lPHFttqKb1BoHvrr4MnZd8bQ6OOEFFz6tf5yxoAlaeZ9Aa+RbZ4eyhX
	sjlAttAByT8Qt0g+OSzv3ul+UaSUHdJthn8PUto35JGT+pSOLH65Y85jypD+7b7PplMEzuP5lPJVT
	/2MdVtbG4IfmlOu8YU/46k9jlq0GlhUv4mYd7EYbT7qJcBOZ3QiEoRSKbjhtVCnWZjk/jmrdrQ6gp
	ss4QrG4Xd6icRqIkPE8lDLMBszpil1RSv+HkimJfHQcEbKxJzUkxQeX8I14Vnfdmc174k/F86bxAV
	IcWcOi5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq7FK-0000000HG8W-1aMD;
	Fri, 29 Mar 2024 08:05:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq7FG-0000000HG6c-39SQ
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 08:05:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711699550; x=1743235550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MJpWk7AqQS2jpnLBGFv6c9ojRP8BxFaCsjF3EHYpzPE=;
  b=kiMO0pijrXzJO+oj/3wCPDqu7Jqhvf98K8H1bxrh0RvjG16w8x6WdyCY
   rpzxb+kB/oblh0CdJopWH+9+xpsULpnj31+SXKxs5uhBr/nKPW4m8sO//
   dlO9ZDGT3cDScvRJrlrtEyiGaj8tgR+d6JEnJLRhqnjLzj1qsp2q8prwG
   RRbzszl52aYkVnQga98XH6szxx/gQhLoCrwEgjJ11OewPdN4H+4wXIWKI
   cjKpGvkHaGngkvdr1H3nDJMF5c/yKxSwr7wdcYWWS8eBx41hBIldxWm0I
   4E7g0Vl+Q7YW2AyYk8s4g0/45fl5VBjD2+tnRId2etKLqxTbOb/hXCOb1
   g==;
X-CSE-ConnectionGUID: d1Z4MS40Tqa3pLTGBmmYmA==
X-CSE-MsgGUID: BYHRJ+s2RW+fiWtJiTl8cg==
X-IronPort-AV: E=Sophos;i="6.07,164,1708358400"; 
   d="scan'208";a="12777425"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2024 16:05:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5+I6FEf1+rXcUbqpPZBCmToCw9rRV5m5b2Q9ZKDkYmH7/0M+D8tq/e8hXRdQ8GvfHNs67C1Yy7r/R+T0l+gCBWAe9WAfuulXySRw2uJz63Gzmg9kB1VxoL1S9nTrhmU5iqPiervX+Cb69hJ1IbpsjqHoDnQkTx+aKLY3rQeKf18GoIqK+/oyDKaxy1YPwTIkPsYgQPoSeXRIKHiBaObdBKsHpgvZM9H4XC4tVZHlSBp5QmBWU6IDsYJMBk5mHx/uhcLNJ/BahN9Hz1lXVuMSABNlkSTAzgkoecO56JbYAcpQx5nygPD9Voeesa+TxBdqPNOgpmg5fJ8EVpHIsUe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHGOif1hfDQPKXS2Lwq6Nzci1WPK9+O5uKm/AqOibLA=;
 b=D/joiprcw82Ok79sJq5QzcJzDHXMi945SuYw9WKkRXvXXih7kfFwkivgh8CHNGqPB1xqi9ItYrZi3qTPj4paTtLgY7j9hn0DqPp39HvlnyG0ajpIWaAZ5GZ78kNJNcI4Yn/wQtE3QeIZ5F+G/uhi/j57qsi/jFtmxCWavCSX0kPSXvlj3YJOf+s5pikLwg2xNZOpUkffOWAYeLfae+lWNpxfDn/KZjoP0otJNKM8sRJcO9y+9a/aVHVwWEc+y7JXG74HvDmdZYz0aRV4+5wjXKURneid1FmJ2pVYPZiiinzEA4Z5q2o3Uf49Mw3hKWnoHB9CUvDD3SIuQz8sb+F1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHGOif1hfDQPKXS2Lwq6Nzci1WPK9+O5uKm/AqOibLA=;
 b=ZIwrrFidnrQZaeXu1CH8tuMEhChRMhN8HOOsw76Q1gBNsHuTRYwwWpuGYeVr1fVMXfOML30gKI90B9xbgulIEgR/pWUU8VknztGVDTjZONOrMT5IKA2K57T3oemzv/7yDS5pcyw5i1t3OCUsu4vTPslRiR4woUnix+v01LfUAZg=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CO6PR04MB7876.namprd04.prod.outlook.com (2603:10b6:303:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 08:05:46 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::602e:e063:814:c285]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::602e:e063:814:c285%4]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 08:05:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 00/20]  refactoring and various cleanups/fixes
Thread-Topic: [PATCH blktests v3 00/20]  refactoring and various
 cleanups/fixes
Thread-Index: AQHaf39/0QzLck1nqEmUIWq2mRNwbrFOYMoA
Date: Fri, 29 Mar 2024 08:05:46 +0000
Message-ID: <6foqfrw4amrpqoaiov6tyr7dhlnlm5tpeb6unfxpbrvsc6zals@lcbxl7pljbso>
References: <20240326131402.5092-1-dwagner@suse.de>
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CO6PR04MB7876:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/h2+MJC8aiuyUIfYpfl920Z0w6TzRJy3O7SAG0NVVf+zJ2oL3mQzzmTX1tXleyyipygCnoxsW4JhYh5JplPHFsPqqNRMk8JBqoU1Z5jmAVYRNzvQECTw7w+ZMFVGdNuJ72kEmtgWKJhDXwNt0rwTG1mdj7Cxu7eiZWpN5hAJ0IW8MBud44yIYYcPSmhgrSdBL4th5ggi+EBX6TdLPM0/5ZYM7nWW9K+pwamyLkZwI0ekFdKpCWFdtOSrWhi8SWytwuR5hhv4M530tT09TBG/wZlP4ENA+hCPLQKVIXe4D8hxQHKH18j8K610NaN/LPTkRA03X9hSaDcUwtiqZSJKf7LlRexFeAMfLSQRPRi3eValakcA+v+EcSiy8T5tArUQtF7BMlaotrBULeKB9DKJaFmQjMjlKUvV3i2FNv1ZDqHxin/Ire2u90huWuBh3fpv/NVXEcrv046oHp9yLCFO0hkzmo2OKxx88K0TtNcqoktZ8Bg+BXInTH+1TJ84FehJA6Tvpg0vMzmwryYmyU0rOxT72AM7t6Zz0z+3Agx6335UW4GWGGBfHlhUVoD3yqQzcTGKBx5E5TCUdl4B8eXZuWvgShfxkh55PzvrvPln+XW5Rju25CWZPHaJ+vGKERmKkvpo5maz1i8KpjIQyGuE2shhanB+3bjHegItGCcKVg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qZNetq+WSIAju3pA7U+HMq3ZvZm65yl9TKvf6HadFiicg/sDnx37Eo7gz0hB?=
 =?us-ascii?Q?ad33sE8sXlNHdupRM3Q2WIPlSIr5TnKn7aFgp22YH+8RaaEN59jr7Qp/mlP0?=
 =?us-ascii?Q?AbQA7xIF/qtunSpE8R0ZdQ7sdjRIuo+pvedNz/kYm9U1wLEGuSwSRqksgDzu?=
 =?us-ascii?Q?HGypgFAL7ssJ3xtzlvD0L276F5fR8VxjrlNcFFehgrnt3BGWrLbK7a5xTkzC?=
 =?us-ascii?Q?RdIXWc5C/VAu2d2ROWjBw6CB0YKG7lkkXrX29D2Abl6F3iUzJ/2qxZI1wrL9?=
 =?us-ascii?Q?SGtLgnHvOOiiXySvmzTQ+o/GyS3J6QhCMNvTq4iHixYY82ztJ2ymOlJk3r8v?=
 =?us-ascii?Q?n/1YWxBXVDRvGJ+Kgnu2cwNea4Lb7zG4QS+GPmGWL+OMLVdLAEOpermmoLUI?=
 =?us-ascii?Q?3V3UoJUN/0yCygvTdCcfWW478bWjQ6+zH3zOeXxfvHL6a+4RUHHgZf9vm/3V?=
 =?us-ascii?Q?USoMDrFam3eIoQU4IVVoA3HWnj2WSDVngKoVVRX5xlPbG5zLs6aNVWFz9FA9?=
 =?us-ascii?Q?zEYMZSjvWnEXLIARCQ5R9wCIPhUUwvFbB579lHH+FZ2MJRB1N4ypSNjTpBZA?=
 =?us-ascii?Q?iSQS2gOAmH5DW+nIOhAkL7X5czsY0s2LrHLRT3N/WYhkJMirvbYa9RGjgiKC?=
 =?us-ascii?Q?IFvjm39II7O2v/jOEtK5VcXyPpDhtJn+j8oiaWjC0Vro4K4urFv4pkrW8eFQ?=
 =?us-ascii?Q?uFkCsuRBgtqg1kRfeUDifdWdNSEm2G2u7xKben/8gC8wurfLhdWlxZkvBJt+?=
 =?us-ascii?Q?+hNTF+LUBLVmy4gINz3chGHN1j/itSC73t6Nw04mlDZnegl9Qgd7/0ShgN2Z?=
 =?us-ascii?Q?1sHT3j2aQm11g3v7yUI8DckK3hYOjK0aGanu0kFp9QjaymoLWpcpvEvgayg/?=
 =?us-ascii?Q?p+HwkAKNLbLH62bqMzB0/nkkgOAJZnPyKRVqtnNWtQ8WPmK6s3RSguNxsxzE?=
 =?us-ascii?Q?iYnLm9qCmNVy1oKRlqzk1BP1hOkiXd2Egj3uSukL46OpLQpvOHbX4hwoG/ir?=
 =?us-ascii?Q?TUUJeYsPh8tn2AVHrzeHvxLQw5RTAGvmb2/PBDUN6AW77vD8zUcGR0CvuC5P?=
 =?us-ascii?Q?6RKLOk+9n08mpeHjX50DZlXXlKA1XEb/5qAlhRpLdowP2t/uc6CPMXOr7cGG?=
 =?us-ascii?Q?LAo1JeP63ym3v5V2IAmxR/9t61zK/TQXAwDh0JRtFc/RMSbdArPII2czWa9J?=
 =?us-ascii?Q?+kW3pR7FE/yVLeZ5eunvUHGS1R1xqi0jVYtCbYTTXZhQYMD4oFffYA7yzwK4?=
 =?us-ascii?Q?2Cn43EnYSS+kffMOkweLLaOQS0xaNmLrO3kNiyTK4HQ7WeiIghdtrbK763QZ?=
 =?us-ascii?Q?YuI7dIlLkKtJ+TDHzSMw7IeRIHiYuoMkNZW03EHz5uePEZFJG/mKNabdqzu0?=
 =?us-ascii?Q?MA/5vkwLgyny0cvCLEPqulo2NwFcXCzyLHFF1BHvmkceh+H4YDR8UUbcQe94?=
 =?us-ascii?Q?tD+KoBx0ljZ92buWuYx+M3taNg7b3efjAwHNCGPJHqo7hQULaYywX0lpclAE?=
 =?us-ascii?Q?8edEnW4JP+5P2+sD1KsZhHNQ3+hhSFr2bZebsfykv85lzGLsvcg+4Rc5R1zS?=
 =?us-ascii?Q?XsXChO5KuWtrW7VV/cKo7/A/qMZYNkGH/nvk4ue2JRgOf8HBuEYV1xgPXo8b?=
 =?us-ascii?Q?vPoRWG1dLAX7K9M0ZL3q52g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5A27FF375F34B419052A1E7CB7DDE78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HNAeK2Xal7eYd8Diq4mV9kmXfupCXVsSAQcnBaMPKNotZxyq6E+Ulcm5UWm21WCG5rwPbV01G7yGpdvEUTykTwzWdylHxCsbNzUZIzJIAEWp8Bp2+XJ9YGvol598onuCfpJgGMawQJDCMiAWK5d91RpOefG72UR6cONDGrYC9jo+rPXmrGW7694Sb9P1MCNNaZIiSkNGlz8pxA3dSmQFUQXQiAuaKhWRt55WdkRBfLHD0y2znN4NVBIbicvNHPFS04YTJ5YV4tcwg2RUcth7sTUH13suO7BNbtEQzqzvnNyLcfWnAdNuzwylyY9yardheTv6NuNVRYIBuVXeplrMrUNdRIHDeDXavrENj27PPT/fv8jFqDzBVXoXiiHR84i3XHLfXjEH5FnYRSm1CO7vUnnClPZCA88810Org2B2JHL8sq64rZIxljbdY9eUDQ+Opzvar5Jqw5ZhHF865jRla7Itjlg87otvHxNlCxoUBHZKffo0pzvGkg8M5R+lJ3UBKY4KFd+tCWes64m3OjHIvK1xGG9O0VI50rhttBHF4HAOxhXWNGt4Vx/I9F6OtBlNl1FVsnLm5gomWkTzu0SXtcm3MtZGNsPElsOWPc8vlrzqG6t/wuen43q4W5zdva5N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a975dcc8-d0f8-4298-a9c0-08dc4fc70a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 08:05:46.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj06X+2yJL6rzMzcLqhGQRGjIbgdILvKu1rF3OHFFkCrHqlToFlxHP7CHuFAo4dnAbCFSUYxlgZU8ZdREk1By1GrEaMgzj8h0FuH9VApmNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7876
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_010550_903836_4B460369 
X-CRM114-Status: GOOD (  10.41  )
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


On Mar 26, 2024 / 14:13, Daniel Wagner wrote:
> I've updated the passthru tests in the same way as the rest of the fabric=
 tests.
>=20
> changes:
>  v3:
>   - streamlined passthru tests according the rest of the fabric tests

Applied, thanks!=

