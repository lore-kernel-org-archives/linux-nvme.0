Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:17:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E8665253
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8665253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=6vlmjfrWK8FnuyGZEoQG5ob9TTpeZ7VifaBuXNyQNYg=; b=OtxfV1t1GzTQkoU2aLE0vb7GB
	ChMVzW3o4L2qy5iUv1vDao/oG7zfXpeMre2Rd4BGu+i5zUEe6uyKKqpqVQTQvrV6K4JVUbLCMwdek
	0oz+Ktin6L95NZ8dLpg54uGnN+Ykhg0AEaWZ95y2DDpewKbwnisFNOeDlSVDtPTuQquQZkKwP0jTq
	ugDBuR+eixUlAwNhNZacpF5WafVxAWHy//hZRJp/Gi+MDrWxjyXqytxYvLER96WtaH5Ekre9NbHzF
	cWDGQQYDeCHwl77njdQcUhsvGnI19bES9BK+noViPsftigXLNEoWqmL+Vq/X2GOE4JsyXRDJcAXBl
	2hMeXByAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJjiy-005QuT-Gg; Tue, 09 Mar 2021 21:17:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjfo-005QLQ-JA
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 21:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615324428; x=1646860428;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5hwT7n1NuWqfBHtwTe3yQawjtC6FLR7i/7f9fgVtAGY=;
 b=F5k4bRraxgqtPL8q1Y/x+3woQ05VXS+gAvQ2E2H+vuhvervN5qTiJvMg
 tIdGNcXCqrNxH2C1SMbts8ETQpb/Gn2NZGFvudBtB/95k3AWRPDDirK25
 LeoVFPxacRuhLhIvVIBAA2dz0Jw/Btv1gxqbfV3jkkbufusr9wuP2FWmm
 6ZAzroUn3OKzh3sWnq1AtAMrZ/5MvYox+W9wPKo4Ah980TSxzUysQsBj1
 pyQEqX1IeZLwsWyXbc5GU1FMhoniuXcXK660VacX6xO+HpCkbIIWn+p6y
 aP7Y01Oi2UbkBJWd5RSGBCjERFojD4/oDpaMifaepx1jR2vIDnGa2YeR1 g==;
IronPort-SDR: 6Th3Yt0UvL/Wc9Y+w23fojWZUlf2CZZLOxC3XoCZAYMWJK6KHvlwdVrnsKGAfuWdyD7w3GR1bh
 e0+6mO00reR65Aou/tRJ7zTkF3ezW9uvajw3yb96mrjnz1cPwixWSuFz44n3TUy2f/LAbZy6c/
 utmg8wIQhGvC69jcCK+TGfArsqeBQ1eVseD7tgMHChuiAbCMG2aSyJV/lXHsUQXuqG54uaUVsq
 7TaTS9OQekXvBy7w3DDpDCxXSexLjgbJNQcV2fSVDLQ7Cnu03uX3VQgwyhR62Myiw4uUw/3YjC
 FWE=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="161773325"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 05:13:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1KOwGc1oyJ/WLgVTmxuVoymmZoVB/chyM6z1GqxRz6sZd5zlVSlJcZb57hZGm5Q1a7qyFzkwcfGs/OGBM1PThnM6ShtQl95S3cFo29LFtEE2rMWcMHpW0aNwNHAzAGr3EGJVYufdYDACXr5lPMVUMyzlZJPQ7XuDLR9NJCjCqo4fWtzkPz/TZIcOR60pm4/Dh0EBwC3PvDrwDM5BRXObfltwTXh5e6dchqnkHfe7YREjo7Ic+hTu8t6KJg146EaJGs5T+M2/brvvIYyVAC5UqUGc07p1SEzFPSjZdLB389P7mkMOI52RSnusmZbm/YuUPSUlP2SsHjjYmDnLcbiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHUCXZVUWh91knOmhAftiB0yY2JycS/D1GWyLkTMda4=;
 b=F79t6Kp7aZ9Y7hE5+sYdlAuO0eILT06DtDy8xyO5ORQvjNpxqxVflu8t+cxfZUjF3w7zWwBWOq9hpJA6xrZba6nxLS/2mEQUWTzAP8oeImKQmNrGn1mTy5s/227pJoCm3q/yQkpAJdizdbPpsgkdtZQOePnAD+tWz6PzfuJAgqf5CIrAM/KPz1n/Avmj7AlEA3QS6TgzYWki+tHHddRqhd2Fgr4YQ79kJdlDPM9HcBocdO1txX2xJn7FfZEOjq6T3oQkHLJxsM5I4ftMJC8Yb9d0y63w8nbtxtheZKxHHmA0tv35aIgo9GnnYa704TZHENl+c1YArmdahiDd5lHZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHUCXZVUWh91knOmhAftiB0yY2JycS/D1GWyLkTMda4=;
 b=qVlXpZKQLQSTdeQrrFAxJL1mPR6rXKZExPVNHvD9hZRgFIJQsFl1R4nu2h7R/k/g/fjKPvHxqOVc6VQaVsrQJeYojVSdjd9jmQgh0p+qXAwGT8K8h707jMqZk6KJo15iJqmIL9YknnbwsYAGG/toL1pzbGNH0nZLr1D+ua2Tr84=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6916.namprd04.prod.outlook.com (2603:10b6:a03:229::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Tue, 9 Mar
 2021 21:13:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 21:13:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 4/8] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V10 4/8] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFKDv18Syn5Z9FUiTAD5nbIw/jw==
Date: Tue, 9 Mar 2021 21:13:42 +0000
Message-ID: <BYAPR04MB4965291573F34312249DA36B86929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-5-chaitanya.kulkarni@wdc.com>
 <20210309114127.GD9520@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb423890-c8a4-4a35-e21f-08d8e340380c
x-ms-traffictypediagnostic: BY5PR04MB6916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB691689A2A35D63820821E2FE86929@BY5PR04MB6916.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xODcZYCJK0lcNb/6sL0AKbU7B6G102WgmmfMMMZU5DmIxi2DzeVx3CjaYJCkWt/yIF3TctwHsmastbUVR2ZsmW0KKkZQ/7mRAr6WfxMbrzAT6xAp8y2LUAKiCKcJqiI4IWTr06sa2F75WIcrdMCDO6/YkBExzy6NLnuah8XFKYpYb0BpYXqsWWJWLYU77ZkgLjNXsrODAt7qT51JtrHiGSytGjsINnRYDLGVO5fEPH/vdj47NiPn8aUkbaKhxlG4ryDb0/JcsJ3iPe6Qn4vjk8srSPUzvYz5E8/5+WOaizXM+1WN4P4lr17wnRuLqAO1lQ3nail0Ux9IpJlt32fi4VnIAr33JT6NWOIduus6ktrEJOlRDD/H8L6bogHPdDZYoX6b+603y99xcVH5IDMpfzU/f2qucG8PgAkDZI8zS2JERMVBZb1rol4ZyAlCndDTmQU7jR7xdn0FLh9rJGMwrtP+1Jekb6tpoKsYs0E6EYFsQv/+NwWdYLmRPd1QKc124cLOpDl5ZSyVhFO27I2oWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39850400004)(136003)(396003)(71200400001)(478600001)(26005)(316002)(52536014)(6916009)(9686003)(7696005)(33656002)(5660300002)(64756008)(8936002)(83380400001)(66476007)(186003)(54906003)(76116006)(66556008)(66446008)(91956017)(4326008)(86362001)(2906002)(6506007)(53546011)(55016002)(66946007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?RIVM9AvPJjTePKGbmYs7Q0UchVmefX8WVvb6XmsKvYQP4KO/0oUnX2pV?=
 =?Windows-1252?Q?/9xV1gwrMv6yYJ3lWjAq1b+YgPxn2a9KNa6qVgbZejNFtHTwx2672P2F?=
 =?Windows-1252?Q?RMgQB+dQ+XWi3qbWKW9Hs1sCwbCkmbqUvej63ZvP7YoaC8o2If0/6nop?=
 =?Windows-1252?Q?v5HN48emS9ahzI12IWDeDgQMzSRlWyizKQ4FpsOrVWshKJO36QrgZCXB?=
 =?Windows-1252?Q?n/RbxfTGdIBuEXY5wDVai53uQsibUwFerTMliGLSE2Yv5MEqcpaPClvs?=
 =?Windows-1252?Q?Pbu5ZyVdWIZwQDGOfurIyiJD7Rui7dUXmGuxMABzYxJ+YidT7FRGbqW7?=
 =?Windows-1252?Q?f5iGCzEouwv6DuAOx3v8qmtgpTQGfgK7RNtqNU/T/6hU4Zxuv9f32Oer?=
 =?Windows-1252?Q?6MW7XKNuGE2luJZNHIDcteoDvF3zA5c1akkqtE+ALyvDWOM71h6FLhd3?=
 =?Windows-1252?Q?7Xy2AKyzUfvmEMDDUIwoI4/tAU/bUjnJmb4t/YcjWxq4725966QJ4qF9?=
 =?Windows-1252?Q?lFjBaPc+EYeEuRLxpxHDR7TWRaMCF/k14pjoLpqsEHW3ZqvsEAERSJQx?=
 =?Windows-1252?Q?GBQTglGKcEjCZEYabuCD5iyzF/FYo6xw7KF7YNWO9VBYDMKu26JcIcFx?=
 =?Windows-1252?Q?dHQJbqgaQ0ce06t63QYy2JnAFZicR+Ol/mqx6GnjfsUx0oDOhVteLlJ/?=
 =?Windows-1252?Q?a56S8UsZhRpfs/+y9c4PmCqZ6RSw/WvSibFj9/ctIWkYC6WDov1Iigsm?=
 =?Windows-1252?Q?zKo1P1VCSVI7n77d/8Vqr1Bie1sFKg1G83sf+ah5AZbaz2YnqtRy5wC0?=
 =?Windows-1252?Q?bdJ1QY9vOJRPPaeNBggQmsDanhmEsCmCgoT9ispznX2ZsEgNPkuNjPvH?=
 =?Windows-1252?Q?4TmjvkkeqtnZxOkZLUBeKzykS4amYwMc93Xx6B2Hd52BolOHXqPlulqh?=
 =?Windows-1252?Q?YjlDaj+evrr1D4pB3EDSTKXPXybAwikfmK6M5ve9AlSwLcUcY0ZSZd3k?=
 =?Windows-1252?Q?RfMONuB90KW6PaA2jRckTe1+MyxvSY1wUeD3EFfR9a4/t3W9ugCt6qzE?=
 =?Windows-1252?Q?FpUWLDXzn7Scncpg9woFOlBIZGEr4at2azXoP/GtfGrk0lr8GrKD5GUL?=
 =?Windows-1252?Q?WyWZHvqYqOAcKyAPUDcHB3SiPm390UD7KcUnGWpmtoQ50Q7dnGEycDiI?=
 =?Windows-1252?Q?fAKjiENiNBwgs8uQfVXwggXItsfCD3C7CCTBnc3T1meDAcv1mnc6Gj3E?=
 =?Windows-1252?Q?qjLg1wl47tdB9CQ170IIBTZUJA+JKt5s0rLbF06Wjhw2R/rscvzJPUSP?=
 =?Windows-1252?Q?JReyK48bnFLgUZMZN8JOaD0qCqYItpKFMHPhp9YABc7RosFI1pJb0aUc?=
 =?Windows-1252?Q?IIpLZzFH9PW18CjJMNTU6+g+IYyrvQRWDM0CxmNDxXjH+rfO8jz3W3td?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb423890-c8a4-4a35-e21f-08d8e340380c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 21:13:42.9476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzRkZDNWG4JRTB69jWoUTWVGqK0kU3AGiR6a/bXUvBYSNE2liNXFMEn7tvuMFpwHDvSdEFkAz1sD7vTI2ZHnlcJpQ930erQlRt87b+Upx6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_211349_083940_9203C221 
X-CRM114-Status: GOOD (  20.15  )
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/9/21 03:41, Christoph Hellwig wrote:
> On Mon, Mar 08, 2021 at 08:58:19PM -0800, Chaitanya Kulkarni wrote:
>> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
>> communicate with a non-volatile memory subsystem using zones for
>> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
>> Protocol compliant devices on the target in the passthru mode. There
>> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)
>> HDDs that are not based on the NVMe protocol.
>>
>> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
>>
>> This support includes implementing the new command set NVME_CSI_ZNS,
>> adding different command handlers for ZNS command set such as
>> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
>> NVMe Zone Management Send and NVMe Zone Management Receive.
>>
>> With new command set identifier we also update the target command effects
>> logs to reflect the ZNS compliant commands.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  drivers/nvme/target/Makefile      |   1 +
>>  drivers/nvme/target/admin-cmd.c   |   8 +
>>  drivers/nvme/target/io-cmd-bdev.c |  33 +++-
>>  drivers/nvme/target/nvmet.h       |  38 ++++
>>  drivers/nvme/target/zns.c         | 308 ++++++++++++++++++++++++++++++
>>  5 files changed, 380 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/nvme/target/zns.c
>>
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index ebf91fc4c72e..9837e580fa7e 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o
>>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o
>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o
>>  nvme-loop-y	+=3D loop.o
>>  nvmet-rdma-y	+=3D rdma.o
>>  nvmet-fc-y	+=3D fc.o
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin=
-cmd.c
>> index 76d9fc0f48c2..05ef362d70b7 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -719,8 +719,16 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)
>>  	switch (req->cmd->identify.cns) {
>>  	case NVME_ID_CNS_NS:
>>  		return nvmet_execute_identify_ns(req);
>> +	case NVME_ID_CNS_CS_NS:
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)
>> +			return nvmet_execute_identify_cns_cs_ns(req);
>> +		break;
>>  	case NVME_ID_CNS_CTRL:
>>  		return nvmet_execute_identify_ctrl(req);
>> +	case NVME_ID_CNS_CS_CTRL:
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)
>> +			return nvmet_execute_identify_cns_cs_ctrl(req);
>> +		break;
> I still find the way how this mixes the CNS and CSI fields in a single
> switch weird.  I'd expect an outer switch for CNS and an inner one for
> the CSI value.

Well it just a sanitary check for csi, I think identify.csi checks
should be moved to nvmet_execute_identify_cns_cs_ns() and
nvmet_execute_identify_cns_cs_ctrl()to keep the code simple here.

I'll move that to respective callers, if you are not okay with that
please let me know.

>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
>> +{
>> +	if (!bdev_is_zoned(req->ns->bdev))
>> +		return NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +
>> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT)
>> +		return NVME_SC_INVALID_FIELD;
>> +
>> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL)
>> +		return NVME_SC_INVALID_FIELD;
>> +
>> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)
>> +		return NVME_SC_INVALID_FIELD;
> error_loc information would be useful here.

Okay.

>> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)
>> +{
>> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;
>> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));
>> +
>> +	if (ns->subsys->zasl)
>> +		return ns->subsys->zasl < zasl ? false : true;
> No need for the tenary expression here, the comparism will autoconvert to
> bool.
>

Okay.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
