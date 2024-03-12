Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A96EC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hK5R5dKB8yUZRLr2tHIaQvfBpXkAtActOb+Zym8j4qk=; b=kiLSNcBkdbxumLC2MqvVRESVKz
	Ncd5q6HpLGyTdOXYKcKPnk9OxNL6f+44kkc011tBY25vfT3gpfpWHC3TDRuj+ZelHdNWRsLrvzs+O
	WecVbIY9QqTQWTMUgLNBipxhEKd8zZ7kYUxF+kEVle+ossWngJvjvy3+SpYrBNBny7noMh4bvPC1h
	3DPjHDOHR7ddMVCAj5uqNvQWGx9KLuKoPISh81y1cphxqZ07SRJy3O8uaNklRRDWJyADbZnZwuBBA
	XWClXij11PoqLJHdq2FNNfu1EJ0umqqv3dZOw60ubbGDTSiLrCDAUZbBq/4sJPiWGrcWE4anseEEm
	domoopKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3sv-00000006KQB-0FFr;
	Tue, 12 Mar 2024 15:17:45 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2414::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3sq-00000006KM1-3VIU
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 15:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW9MnXQR8h1jAc+p5dnet88pxvrnMqW9NpUPLjKPVqvWaGjhIxFYt/N6J051hPw6t0rNy78nq7C6J9NA9NZzQ7ueyxiLYdE4QxchofARKxHVByHOKXM1vJQs8NPFsuGCOPcst47WmDKX45hb7jPpvONirfGfZ08464loPRWNyJiNDQ8/F9XL/rGKK4ZB2U+8mR9g8aNqjRo0LhEo4geSUS5QoYSadr6X/oDWjUrIeZSLc0oN80wrB7tKN/EzhVojeNTRrx1d7kfXDBhapgidU3lPxwWKKy9eEMaBcQQ4OR9/d/G88W23Mho+gqrCIwdEJwi5k0N4ES5F7UTBAUEoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK5R5dKB8yUZRLr2tHIaQvfBpXkAtActOb+Zym8j4qk=;
 b=PXd9YXxh82cDw6g3RJxT0j1xTXy1eVr/8LBD8piAqskIqoXKlTHBMetssJhz4xui5KVrxJPS9bZlsFIWYIBVVqnjSJbG7c6N7sozxwHqXpUH5J0/mOJKA7HLObff4QHukyROycfvnbMU1aA+7HNbZv46JKV32TlaNX2+gCOvHcZyIA9/mn22UooUUwhRxcyD0Ayq81AnfwfjLFHzsy8R7w+n5lAk1J9tOv4j3t9DUGNAjULYo4vbwX6tQS9tv172KpbrIl8hrv8KLIGmanxeIMiFveES5KTNyQECB6gvQa8KYeF0BrYnZX/a7CYUmgCfvYBF1sS2uytZ0uAKatCQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK5R5dKB8yUZRLr2tHIaQvfBpXkAtActOb+Zym8j4qk=;
 b=MV9QzsaV1F+nP0NN59T3XEX2b0pMJtcLHUbSe3q+ClaxazBkvQG5yno2tymiUgi7gdC1KMLKSU2P5TYVLHBCu69vARGdCbLyi53C1pdbj98StDeA1I65cLFizjuyCg7hNXrcDYbnFFzYllMLYEak6LbjJxAB+ZieQtpAOBvhfll3tkqUjCYFhd1Yn9XDJjDTkpFDaNoEibRYb7D0jyJ6YXvgIA0F2fdWL841naPoxQv6zhNz4Srav4ha1Frsq/RWAgSkJFUomeGpLDP95409Wr7KgUNz9TxU1OX3b4sZMxQXKyMncSqTyGc621jNfz+xbYsO8WC3eHaG5Pkf0tWAww==
Received: from PH0PR10MB5419.namprd10.prod.outlook.com (2603:10b6:510:d6::15)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:17:21 +0000
Received: from PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::1f83:27ff:fc3:cc23]) by PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::1f83:27ff:fc3:cc23%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:17:21 +0000
From: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: RE: [PATCH v3 0/1] nvme: Fix problem when booting from NVMe drive was
 leading to a hang.
Thread-Topic: [PATCH v3 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Thread-Index: AQHadAGnadJodPJYFUSa6HC1UwL3jbE0LgaAgAAKQdA=
Date: Tue, 12 Mar 2024 15:17:21 +0000
Message-ID: <PH0PR10MB541950146350B7B4D863CF8F922B2@PH0PR10MB5419.namprd10.prod.outlook.com>
References: <20240311220811.3011800-1-michael.kropaczek@solidigm.com>
 <ZfBpAw_4e-xfAHW8@kbusch-mbp.mynextlight.net>
In-Reply-To: <ZfBpAw_4e-xfAHW8@kbusch-mbp.mynextlight.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ActionId=fd7cb415-c53f-4a09-8f6f-f1e175f0fb0a;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ContentBits=0;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Enabled=true;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Method=Standard;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Name=P2
 Confidential;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SetDate=2024-03-12T15:15:41Z;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SiteId=4bb44aac-867a-4be0-aa34-30794e8470dd;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5419:EE_|IA1PR10MB7336:EE_
x-ms-office365-filtering-correlation-id: c36417be-2ee2-4708-0560-08dc42a783bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loP/dFq7rYJjkTYJcIalU39kIPZiiGFX5DzdaC5efgQe4CjXhxf+HdStovVNogUeZon9v5XpVNZCSWbB6kGp1BSevRTKSROoWJ4xHGROzfaQAVGd39vgTDe42mZrhuwa/c4wujt7Vj6rvRy7HJEOvJlAEeh6j/dCTBnWcq20mdkX20WNTuwxwPVyWYtk3VyqA63s6lLHOLm6NZXeiRspbGv4mx2KOjfuoWP8yS2HIySRJY/GkaVc2ljFHeZYsibMNJVu0+ECzqBQg2ZOq8HMkrwLKxysKnzLawo3ehRUoH83YHh1+MsrjNWEyQKnPUFMNYc+fSms8J35KcqWB6cUjaFd6DaoOQW09tzojpZRkxuh7oH3T1rb8ZkT/UXQYhPK4Uy5eeOVwVTMyHsKETODI+/02z6Yk0XqBbnDGnZdMIrZifct2G4GQwvcl84FmgwpU2ug9PollJxwoiMoHGRpymweyWPq6Ycw8KFvbBJKV+gWSlq/AZu6dA2J4gqSNG4Ala7djqq682Zss0fIH1dT1qSfJ/vheAR+Lt3p9TthtAN34yZH4oS/bZQknSYH/8BAtThZjvMRrv1mff+keEFqbzdB3ba2r9vvLyJ8ngVttUnIIAB+uN1gtWX1JOaM++s+21vL/JLmYpc7+TYLJaIMzN/H04CKueC1Q3B7Dw2/3sJuEQ+RRU5K5TBFbYoJ/8slQn6xlarmSzfr4ClIVAOP3wjatqskxcIxuEVm4fiV3S0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5419.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O5AyDISx97cyZ84F8CrzWT6TvjOM/UEO5ZqVk2XCc166xs47IWarlOiHcHD1?=
 =?us-ascii?Q?ZUO6qUaYRFX1znZuEDPxn1HXR6qZKz/3hRUS/D2kaB88JWGF8eYi5ndCd6ui?=
 =?us-ascii?Q?qv2GUOOqkGa2yzmYsdIGT/kk1nK6wMBdVdrahgzUfXnxeav9riG8tzLPQZyP?=
 =?us-ascii?Q?fuRTxrfurULisloG8gKOsl7Je0fqw8Ja3sMB10y1mzpNxb66yWrxssDw36NY?=
 =?us-ascii?Q?zkbViVOLyrZyeODeh8qm/08f7n2SU139q9CNZqwp1Uls463FO26RhdEdIE6K?=
 =?us-ascii?Q?EOaxw3GZMWf4jA6eJbda+KFOI0h6/YbPZdHrVc3gjDxjiR6xSjvUnYjhI3UV?=
 =?us-ascii?Q?hZBS/xlEf3ttVbEE4peUQEDQIcUWwIz4zYlYZIxnWufYGqv9K2U+4roy8gAE?=
 =?us-ascii?Q?NtwDLHYJD4sl7W5e+qyV14eG+xuohMANXVGjE/No0L3+ZoVB60o7oOqLIEFf?=
 =?us-ascii?Q?hYfdXRKhkKCV7LTh8FT0ZnMwPNmxgBx2y6rDPHseC9yvrg2Wtgq8SLk3WN3X?=
 =?us-ascii?Q?U3z65uFKi9H7/iRlM/TfgZgIOlJQhDxY86FcEA1B5RNvM9T6UAy1wa+V+IiL?=
 =?us-ascii?Q?rRNz4YubsF8kv2sntZvQM8d6wTlvWktgAMZH14qiXM+ta8yRGmUqHktDaprx?=
 =?us-ascii?Q?5J3HThrnA0QYFGd/4sMyHCGqRrUsHPdY5qLozvJvd21CwAEvPk7wWqzbXNEV?=
 =?us-ascii?Q?5eIwaNeAb3CYvwJmSezgRuXwx6m2GScYO/80IUtEpG4IevkbWihA6lZXl+HN?=
 =?us-ascii?Q?wEkasmLkpT+3hsTTNC1Fvc2ZwQStv2skkueIbCnM17ZUamduvWu5qrxYBqMM?=
 =?us-ascii?Q?v3tOPe0q3mtyXcTGT1fEg9tvbT0qT4xw5iFAdh5bdv1mayNLGpzv3pXGkmsE?=
 =?us-ascii?Q?XOLFU4E1QNPWF49yrYmaKH76vGUdcbd7wPROJ2Y88eTX/moEMnanbH9rj0xN?=
 =?us-ascii?Q?8bpUVf22viq8r1k6QWAEr8RRmjF9nCDTS8MEIAF8+BHPu4EGThEb+Uxj2SKg?=
 =?us-ascii?Q?amQrnaB0ST3zlwGZpQmkDPTBLNENdm44o/WQUSTxp0HAn1bnj5wn0nfK76uj?=
 =?us-ascii?Q?HBl17eW2hraAmtDTe5Y9Sx5KrAbrw4t6KMTHro+i/0zl8NEBZF2xN1d9PjkA?=
 =?us-ascii?Q?ECKscdH2gTiU6mFwDm4RPT6C+xtBoCB+Nk0I/tcuMpmYQMLfqh9/RL5YZZ9a?=
 =?us-ascii?Q?B1myXgqsvVR0kie/aj/WjG7ADeZDBb0NVl6jFa8sw2E/iAWO09dqQW+V4yZX?=
 =?us-ascii?Q?MxTJp5lWuacRXdN/b4eDATaTMkCDBDEmhiKgiQvgzolNFdY6bknFKpk84LwA?=
 =?us-ascii?Q?EeIw3K/lPCGodLBd3TpfC2s592c+KLXj0E4CGLv68saXFYhknvuyugYLskR1?=
 =?us-ascii?Q?6DdFeJRQJRVvu8+QKyjn8tXvw3zj4u9GI/JnMQcZdZkYN+Wqxx2TulG6bffq?=
 =?us-ascii?Q?Q48uVX1Sitp9uh6jVROMoADTdV3kVH18H6mNWrwcExKT7RIkTBCi+85Mmq5F?=
 =?us-ascii?Q?eF4zDW9m7zGBMP9Yu87BwOp5u9KHZLtfo9OzrZr6UM8AMlJkfYFSu8ZBvgdD?=
 =?us-ascii?Q?LxDiRLbXMxZwV4pG9JeUU0TbwRDovIMoT6OJKdFRNJk0xWqsQEjmUjshYqRY?=
 =?us-ascii?Q?1/OEnrDh3a0N175st5JY9zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5419.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36417be-2ee2-4708-0560-08dc42a783bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 15:17:21.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OHObYUrJ8onUeRlBQQ79o9nMayfGwBcsXPA62uCaJUaFyvDD7k2OIZFgXjL6b0/LhdUBcEXIFK+l0mtIYtWioemZkCBEkbgPj5zN8YXGR+k7zCiv2XiZAZxWg46VVGjmauZLLldC9fnhTHxDeERSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_081741_084743_47E74841 
X-CRM114-Status: GOOD (  13.34  )
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

Thank you, Keith,

Understood,

  Michael=20

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Tuesday, March 12, 2024 7:39 AM
To: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
Cc: linux-nvme@lists.infradead.org; Jens Axboe <axboe@fb.com>; Christoph He=
llwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 0/1] nvme: Fix problem when booting from NVMe drive =
was leading to a hang.

Caution: External Email


On Mon, Mar 11, 2024 at 03:08:11PM -0700, Michael Kropaczek wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index=20
> e6267a6aa380..bda7cf5ff674 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2593,6 +2593,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, =
bool shutdown)
>                       nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOU=
T);
>       }
>
> +     if (shutdown && dev->hmb)
> +             nvme_set_host_mem(dev, 0);
> +

As I said last time, this deadlocks if the controller doesn't respond to th=
e command. While that shouldn't happen with a properly functioning controll=
er, we can't count on that to prevent a deadlock.

>       nvme_quiesce_io_queues(&dev->ctrl);
>
>       if (!dead && dev->ctrl.queue_count > 0) {
> --

