Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B777C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woVmE4lWDjKCtTns2kCFZde0eSFi4aM4g95xc1HTi70=; b=DYG9jEZRRlB3D5OBNPq2Sd/BRQ
	vRsbnMGcF1atCMvJTSXA0XTv5hdmDdgtN/c8nlY+TSUrOUQUt/43ldzqUKN/hoOQE9N2DZEDkxzBc
	EN4YOc9EdoqUlO6Kronvkw29/foP3iWvVy2srHWLmcOL5PNeONm6EybIE9ZgeArNk6B9BvZcqmvPq
	Aw3wCSzjcSuWq0kNJuTd+NzW7FJ3zp/Rdy2ybBKMqU2xLG2D1JPahIFok5D9Wqch/lIsxeyOCg0n/
	Z42uHtU2TACp/YbSuUCykdPLYeF2nC4zznCJdmtqpdV9/hrJvq/p8YZqYSr/JEOs4T21CNlr1kZQT
	twGLL/Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZU8T-000000051xe-43yc;
	Mon, 12 Feb 2024 11:06:05 +0000
Received: from mail-am6eur05on20700.outbound.protection.outlook.com ([2a01:111:f403:2612::700] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZU8P-000000051wx-24hf
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 11:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2ndnDvLsUz/2uzd1myP2vSGS1aPVH5+Sao+otgcRg6uSSwQS6gmNntkCy4lYN3nqq6eyABv4s/pejIszGC3RuWVf37YQ9rdwUepl8m735XzoRIXqfCq08KWoxsUs0NtRUYi99fUNweulwl8AGKIt3M47uGWnrdqL8kFasiLVPlQ4eXlUfd6jMvLB2w2XdVK2TGpL4bhUhCQyQYr30pIS3llPCwOt1dF2vu7FPAp+ZoGukanOsI1Zk2p24lDdYUFDdhIHvJHRdocSinHeUeab5Ctqi5XWxb+YzUWdzs+fTHLvnuP+OrL77thJLW9e8AFIyioR6JkDaGsbqmwerDSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woVmE4lWDjKCtTns2kCFZde0eSFi4aM4g95xc1HTi70=;
 b=GeBYCF4qV1FMzTFoFTrKBzVoSkQNG0IXcRMlrhjEsQZcHYXTmYo7XHh+8TOkCjGbkJsE9gD+SpMBjkksz4ORUkiYOkWK/6K3Ce+cRPX0PhnPPmjQ5umkJAY4k8VsooDmWVvefiTsVAV7XQbAos3DKFDti1RI+SYgc8wO1tOPqgp0In7faL6t370llp7rM+Z/nWzj1fMRJV5dkB0CL2Xh2fEM5AOH8oTvjJjlWHt+I7c/VUfso91IeBbbIy+jJvd0DcA/UNVavINKE7r1/E2Azr7g/TiHRIGA+24hOR5JL+gHcFx+TavSVq4KvJUHVbT9HfjfWEYZnM6jQijVYods5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woVmE4lWDjKCtTns2kCFZde0eSFi4aM4g95xc1HTi70=;
 b=iuogh28We/yk4PhRYSBsnpVuY6XSHEM6Olah3ZCNe3iyFSnbUSLbt1DQRPiK+xwxAJPWxf02/EJMIFPpo8XmxDpoM2uZoGRf4hNlNVVhimSOh32u6iUzvg4TLPEZ24OIqhbz5ibXZxKk/egdcPJNOtD2oPHYylA8rPDtBw4ii9g82itsUt2TCMqcofhw/1rT/Z5bDWThWFfZKTdbYwqrVaZjKFWhXvLlWZcRga5uovXwREh6Vr12nU6Ij7t7LXFrI3r8Rd2CxOaSAGlLqtMrJS7kEdLIUstTFJjvbz/4bB3At+NOPZ9jdDPrjnlkl1ta6q4e8iK8xRYHsTi2Pja29g==
Received: from PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 11:05:52 +0000
Received: from PA4PR04MB9392.eurprd04.prod.outlook.com
 ([fe80::75fe:3ccb:3912:80cd]) by PA4PR04MB9392.eurprd04.prod.outlook.com
 ([fe80::75fe:3ccb:3912:80cd%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 11:05:52 +0000
From: Nir Rigai <nir.rigai@volumez.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: TLS over TCP connection failure
Thread-Topic: TLS over TCP connection failure
Thread-Index: AQHaXPu9kiNOhVlRU0WK7YtbdD3LqbEFzsQAgAC+GYA=
Date: Mon, 12 Feb 2024 11:05:52 +0000
Message-ID: <179679AF-9C44-41AE-BC6C-A597E10FC85B@volumez.com>
References: <587CD834-9978-4D44-BA69-4AADE3DE2E06@volumez.com>
 <a69a47dd-bb86-47be-ae74-1d26c64bd409@nvidia.com>
In-Reply-To: <a69a47dd-bb86-47be-ae74-1d26c64bd409@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9392:EE_|AS8PR04MB8867:EE_
x-ms-office365-filtering-correlation-id: 4ca3d5e5-8909-418c-8917-08dc2bba9404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOGcr1bCwaBYCgb3PqkdoqlaKLiShy4NBleg9XISukp6NGlRXV6wvh77c47o7NkHxnEKt91SJHtDq4zqCFdGGnAhIgEPKjHv4N8bidmtzwnAvVODNXDOmfX7pyA48X4WIVHaZoIhq4gCiqPbKg6cQtXMquYeJyu7xwSzeC7D1BFH4+TOJRLGpa6cndzSO7RJ3HS2jy/fq6tpcQbNBT/PaSgkRtQSzmYeIJEBG0NS1W4MNYSPbVsXK+60u024HLw4NnQtZnUPEiItFX4YhZWcJ7pvPPNJfaYB35i5i6F9FtMPMHS6QfLwAt3hpW7spxv4gwL1wvL+/Bw/ugNS4Dm36gmLELFVDgibbLoGmueGnaom+xackCINVyEnC1q4q4Xp7SzT0/H4rRVo0H+7Co1zl9QsjpA3f4Wxfhaeh+Myw5UtrsmmdR/TSuEkzjOE6ZtnRNKgjNR+lrS78W5phDmTcUUY8LDnm8/ArsZXCIzx7Gegz48BqXtZAZ+njYLKVcy/5nQiRfoqeOnIPSSrx8BFYdUkRbNL3XwNj1chdP9MCjNgPkq2BYOULamFK0rIzvPdmQBi9QaOlxo+YvxrckIJie5VDxVnEnY75vgx7NhOhV4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9392.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39840400004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(33656002)(38070700009)(478600001)(41300700001)(2616005)(83380400001)(53546011)(55236004)(26005)(66556008)(66946007)(76116006)(66446008)(66476007)(6512007)(5660300002)(8936002)(8676002)(4326008)(6916009)(64756008)(6506007)(71200400001)(966005)(6486002)(316002)(54906003)(86362001)(38100700002)(122000001)(44832011)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TyKCDiLB5svRgvoaYgQ39VPJyE2UyC2hEFEaQiRQeSiJSUd2Q7i7LiSpaj+x?=
 =?us-ascii?Q?vJItt0XktEgTXimtTkf/MwIMGBU+XeVY4pcRA9rm6HPLFTjWsdy7wWVq0qVN?=
 =?us-ascii?Q?rL6tAcWAkpsLMhqwJpfk90HiUQgE/2Njtg/h1vbW5qKW+XZjl8B/d1Sw7g/a?=
 =?us-ascii?Q?ODgJlAHLSpqOaEPWy7RAtOOOkmG9AejaCwbIrl9Q+VeUfPk8h/G4nkuIvify?=
 =?us-ascii?Q?ubw3uGeY9asu1kU3hlgH7sE0RQKlP/9iM60Cm/8avbl9DTD2h6sqbUQaFTXr?=
 =?us-ascii?Q?JdrVPJ0cZLrtoA9K2+otQrqQ9saFO8iNX5/782wGAPPJnqciPQdVh98j8aZv?=
 =?us-ascii?Q?OoHTyWm2zHzDOsTvXWalGWJGeJKeMV3SJoxAmGDFC2E7SLNmAcpnV+/+8Chz?=
 =?us-ascii?Q?zOY5lVefRKkEcwMwyjWv+HsqND/jWSonOu1LFFi7aK1xTj8AB22HYDQFHjpJ?=
 =?us-ascii?Q?KXIjUH2q9mPneGCeACIm+kaEKRfOqIKUqOewjOef7cKDMw8ZKBxYN1foC/hh?=
 =?us-ascii?Q?W6HzSpsNeucCPeN72uGJKrqKAFfvqL89R4JYXCB3FmiYVe8buDL4IyJZXe5i?=
 =?us-ascii?Q?bowqSpUTSsfVJIm6ufzuG+KhETOCHevrFRefJyRDEl6YCJlCF1VUFis5O77h?=
 =?us-ascii?Q?jkoXPemflWrAXsoxFjglUGVnV0Q+Zhwa3cJTZ7IYjPVP0AfRfeonQK5A4ip4?=
 =?us-ascii?Q?xFv2dqkMRZUuKUTBcqK67ArlrQGfYBdyAephWF/R6IGYLnlv/8RQ43i7McgZ?=
 =?us-ascii?Q?Zlbm0FeEfc9MhrfnCKyCufi2Ws5aJvUuu/54wpX0bE3oaJIoEPApa6NpB0Tj?=
 =?us-ascii?Q?Ss8u54kIuf0Ca+bchorjcUUJEUeEdmCp8L1hM3Hq+5IbdtYi626Ygi2Y1VrN?=
 =?us-ascii?Q?ReLrU5+6r1KqJPZefMt5GAs2dpedRYXIcP+2r6SMG7U44CwLRK4w/+Bmf/mR?=
 =?us-ascii?Q?fwZ7at/rwajz09+4AHPnxL7EaUV2x9r45DxMRobZs1Fg8mOPvxy2EJfYU4s4?=
 =?us-ascii?Q?hSJzDFkSaPYM076G1OEr4P1wj+nAs/cFVKNWSqR5XNjExFvGHC6opBVUejEb?=
 =?us-ascii?Q?a2JaPMBi90ktDviqWvx/rqsRF12GYw/XBYXquWBb8L7ZObCwy42sC4QyDCQB?=
 =?us-ascii?Q?9KCfRY64jye+LL755i5NXmC2kC/+vC+YkFiSA6p8slHVyqVcqzWH7mOL2So3?=
 =?us-ascii?Q?IwTRyL0nV0Gi466M/c8Z6Af6NzyQjmMM3rw0hY+yQiGmIjJ5q8CxWTyEDeEh?=
 =?us-ascii?Q?yrorl4oMjXejhqWK9B2FwxFCn7GZw1xW0vAOrUbI6kH7bOt0//hSU6d4uuCR?=
 =?us-ascii?Q?MAIYtoQn6fnvfqgSOSIZA84DiJR+ixY93g9FUElr+esxEBcgfI+BfA/6ljP1?=
 =?us-ascii?Q?gzS76qX93aSkksujm6n/25NCEETEbNbw9h4/o/4XBLyProbMXeEcfYiqOBTJ?=
 =?us-ascii?Q?S4sfD2/NvLECnCe2h1oh5oqVdTl0VP7dwgF3I89w4cpr71hTNx1Wzkm2Uvnz?=
 =?us-ascii?Q?rfMWhmiLKhbM2Tvq4XPrkhvG7hof+MoDXnsT0Om79zmQMlIJqvP9NSA6Wxfa?=
 =?us-ascii?Q?1dU4NjBx8XuH8k6VSS4N8tX3Mihc033k0BWgeJWZMOi6x9ilwZxpZFs6qCM1?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7C2DAEB5F5C694A9DF3E4F88114C116@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9392.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca3d5e5-8909-418c-8917-08dc2bba9404
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 11:05:52.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cS33E58AtZEFekW8/F+8xmbcsDhsBq0WRrISFkuaAMFK5wK5ofV79wtVZhkex6/mzLMMEQN2ZYEnSNDWCgjurQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_030601_894426_62952475 
X-CRM114-Status: GOOD (  12.07  )
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

Thanks for the quick response.
The issue is related to an unsuccessful NVMe connection to the target. In t=
his case there isn't a block device available to test with the blktests fra=
mework.

Nir Rigai

> On 12 Feb 2024, at 1:45, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote=
:
>=20
> On 2/11/24 07:05, Nir Rigai wrote:
>> Hi all,
>>=20
>> We failed to enable TLS over TCP with the latest 6.8-rc3 from upstream.
>> We have followed the guidelines outlined in https://lwn.net/Articles/941=
139/.
>> The NVMe connection failed post-authentication
>>=20
>> The steps and the outputs from the process:
>> # Targetreation
>> modprobe nvmet-tcp
>> mkdir /sys/kernel/config/nvmet/ports/10
>> echo -n "127.0.0.1" > /sys/kernel/config/nvmet/cports/10/addr_traddr
>> echo -n ipv4 > /sys/kernel/config/nvmet/ports/10/addr_adrfam
>> echo -n tcp > /sys/kernel/config/nvmet/ports/10/addr_trtype
>> echo -n 4420 > /sys/kernel/config/nvmet/ports/10/addr_trsvcid
>> echo tls1.3 > /sys/kernel/config/nvmet/ports/10/addr_tsas
>> mkdir /sys/kernel/config/nvmet/subsystems/nqn.test
>> echo 1 > /sys/kernel/config/nvmet/subsystems/nqn.test/attr_allow_any_hos=
t
>> mkdir /sys/kernel/config/nvmet/subsystems/nqn.test/namespaces/1
>> echo "/dev/nvme1n1" > /sys/kernel/config/nvmet/subsystems/nqn.test/names=
paces/1/device_path
>> echo 1 > /sys/kernel/config/nvmet/subsystems/nqn.test/namespaces/1/enabl=
e
>> ln -s /sys/kernel/config/nvmet/subsystems/nqn.test /sys/kernel/config/nv=
met/ports/10/subsystems/
>>   # Create keys and start the tlshd service:
>> modprobe nvme-tcp
>> nvme gen-tls-key --subsysnqn=3Dnqn.test -i
>> nvme gen-tls-key --subsysnqn=3Dnqn.2014-08.org.nvmexpress.discovery -i
>> #tlshd -c /etc/tlshd.conf
>> systemctl start tlshd.service
>> nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.test --tls
>>=20
>=20
> can you please submit the blktests for this if it is not there in nvme=20
> category ?
> it will help this to get regularly tested and establish stability ...
>=20
> please CC Shinichiro (CC'd here) and me on that
>=20
> https://github.com/osandov/blktests
>=20
> -ck



