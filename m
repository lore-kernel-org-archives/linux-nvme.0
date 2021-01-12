Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26645C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:11:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C6B22510
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C6B22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nxgrm4UKrHUBiCYSfgPuN0X832c1/mwlwYLcC4wIHUY=; b=XVu+fAEh3fl4xB47Pjd9P9gM7
	2k37EwfcI3t3j3htYrRAxVVSzJFJf3Qq4voyqVQtLY7K/y3lTyCK1V3nuqn8N9kBDbDqdFsuo+0Jw
	Jh81Dz0TDxXCBur7XkL74JYc9Q53KLkNpqi+2fkr3IdubcgrthT4K+/bSdJ+zCN5W8knRIWGRK/SI
	XIy3rN4L2HASKdQDZhejZelCXClu1o9hMgMIAyxlBn0Sz8bO8sc/EV3A9ytx+YspAilgbUM70FZVq
	0WiXh7h0lmiYjec8B5IIa2BjCkFsw1GDigGUcb4B73hKMpiRrgK4lCdmUreRRA/tj/jIV36EoUruT
	zeejy2k/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCte-0004Br-Nx; Tue, 12 Jan 2021 06:11:14 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCtZ-00049N-Bq
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 06:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610431869; x=1641967869;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+tYsHpvd5TfHaSEJ7eFZA3GalNj+Bs6tWv6uN7zRN90=;
 b=LwhrJJ21OfPas77IJbolDMUnmbjPx4lN7lh6iPcbFVHrP3GxjXQAU2qk
 nedbU6NfbbpaikC0lPbz56EKlYunJuxvmP5FzE2vA+jo4nx3lS2+QyXea
 6Cwo+rQ9VIfmRLu6sq9y/k96rFEC2Vnn4+X0NGmskDL4dhRLEKLIVNOAa
 TvfKkKLdX2plwep2UrQwaPgc4ZhmuCKk8xt6Raf0xOT4EX2dfnM8rl7Rn
 qwuB6hHr5Y2zxEsQ1XNNBRMNuMIgrDzbrK1ldEhj7KbV98HNYXHGYQpMy
 Xm0sV/JmqtGhfmsg/buRsjSz+tiu8xk45yMgLexK/JWV0UpZAejsMNh/S Q==;
IronPort-SDR: yPQGWeg/+FmyaSTvd2EpKGN+vB4yApR8KjazorE36DRPnxwLlj7zP31J3op3s2wKGAl8E2vkiX
 VUo/P5+8VMcXelxOW6mUDECObd05iTHNJ11cinJ/wl49vm6oa1l/4+c1uLnp5GxWmkiGmhw/qx
 /uPaK7/M0T76c6QSZ6vYkIdRnj9hwfxWf4YxIW37GQFRL8oBN0mE3Ed/dUk7OcPTWmO3AP1AdL
 dFhziGDPKAArTNEkDhmvnPbNZ1PdhzmWQNP0+Ys4JNI7nohGVEqFszGwgjQAiSV4kB1VWusTGp
 e8U=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267511075"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:11:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Z7OoSqr8MOLkqY0B8R3kE2EVwRfAEA2/i+3FdUnujvymTT0TRrV4PN9VPGQ1i+xtXUToPUuq0XqHm79ikgvfAcmUdAGEB8T33gNfkR1PMYio5dl+pjsWgYuHA+Ol3+fmgzTYSbi1vocFkSJeYZovK1qMe8kX5VvhldKBSzsvbR/col8lj9i8CahG/RlK7ABVEblXp5YAerDpsIYHoaAQHxZA+4S8dFuxesvAeZ8kd31aopeuwuOojsQhD7BYBhykwo+/uUzNTDC76jPrufKYsSyfYnhXOF2UQHYrQyXhj3DVRli8apLugyvAo8A2m79cFDj0y9i/atsgHzKwVf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKCcHYzNFnZLctoinG3z+c92ZMBQGbgMK3mVwbOv4Qk=;
 b=Hs8Gl3UGdtzmE0vWgD4euZSUZB1D49TC45X7mLWhi3xL+ooCbWj1jGXhk0D4m9cszcnbjnU5p5rgm5HxrEoQMSCWSi/PvYio+t+Xx/ZO/3nNUWzD4rIVVEbQ2y9EJZy20cZC9zYfBezPeL0R2R9HLvfZnSm8o1iX71yD5DGMV9TINYAEZtLtf3AnkUf9HPGRUQKNLxiNO5bWHhzbqeKtDD8VOGJCG+flfWbNYhgbMcaA/YRwZYnq0BeBmk9jkOmiUFaWI5AOlHY6vIlRyHXL6iYQ+ciuKJgg1oJBKEkX62DjBiK1ybsm0PSYro/3UCac/2ITn1WDcBVcPqM51+bhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKCcHYzNFnZLctoinG3z+c92ZMBQGbgMK3mVwbOv4Qk=;
 b=rfrOVhRMH+EKxm6qs40zSVtf4Pp/90F6u5HpoC3qlkl1cuZ87oJF4gZlOe6KEyyqHeJE0x7jlQYj1U4uSMbjoVNfNAtMuDDNIVIq8xrDKHlSpG2xRW4SoiLsji9Z+QSwlh4XMYB7yBsojHFbVTbx0IHrATgRCG2xcMLQU9YdU5Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 06:11:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:11:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6JszE74B7v3S90G6ql/DwDLtmQ==
Date: Tue, 12 Jan 2021 06:11:02 +0000
Message-ID: <BYAPR04MB4965A589B5D8F480355AC28986AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514A4C7F0F7A2627C4639B3E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85385a76-8f6c-4d7b-3721-08d8b6c0d6b5
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5895738F8FD52C82A1D0453F86AA0@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dT9gvHduBFCytXjcAys4mn6+1nQ4+EhU8ok91HzLE9xO5vOCrv3LhRjLSHGJXBx62KEOop97C9TXdwuxjXCGtvzSCWFnQW4vK4SBCwbkW+Izp11q6NOk6AG2oV3BonW5LgGLYHVdWTOGCRD4jaOGeE0QtkMN9MGdOcjKhNW7z3rbeNApeo3r3quq2gLdFcxBGhVdx1ossEOLezSPc7gbIN54ZcRDOQLqkkBi9VZ6QTY48jRIqTmdvqGMarqGfSjygyEefZiw0hgahNIkobHYSHT9DuLqpdPJ1Db2MuLpZnMC9YRtKIY8/mquwY5GEfSU2GlRCmANoFg/uESIC99gujQd8TDOrIdH3/DviS8yILjJImXOa51vDkYyXqC6Xa36hIbzH/85XnNzKEYnwT5zxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(110136005)(54906003)(6506007)(316002)(5660300002)(53546011)(2906002)(33656002)(71200400001)(26005)(186003)(76116006)(8936002)(478600001)(86362001)(64756008)(4326008)(83380400001)(9686003)(66476007)(66556008)(7696005)(52536014)(66946007)(55016002)(66446008)(8676002)(30864003)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?LBIq9p2RmNLezkCjhVeqciyJfWz7USmxnFHT6oMCEyoKuZCRrDmNFghC?=
 =?Windows-1252?Q?9fWDsiDVJR7IfquP3SswKvxltEhx1edDZxhDew7pwrBMT67GliP6OC00?=
 =?Windows-1252?Q?tejQmomcWkIoPuBuS0rYA9Y2VaxTdZ1DTdzoO5MApNd1g9siBTG90oRd?=
 =?Windows-1252?Q?s+8eLS5HRGR9SoVNZ7IJ5xgP34GAIQ9wLWRo+Z68u7zKth2HZcOmHkOY?=
 =?Windows-1252?Q?lhhqKzncaRvyMmH78AoCJDGgkziSP2jdNQzvj4OstMSwiRXxSrqSKdPI?=
 =?Windows-1252?Q?dVHjfoxA5Q8r8ADwlOyLr9WYfAnDobQCddkNQu6P1WKjlfxsQKEBlek1?=
 =?Windows-1252?Q?7wEt8YSIbBjlHnA8RkwA/UH8qTSixyIBt0sRf8mIcahJqMuvdBr6+rcR?=
 =?Windows-1252?Q?7FvUuMmM7N9mM+V3PkpB/1UEZSNn+s+OpPN4GxuAVhBJgyUefKRd+gfw?=
 =?Windows-1252?Q?55fhJrP1/wrR3ZLeavD42cCahZ0VJupgzFXbw3cgjfeUkD1QdAO8ggT/?=
 =?Windows-1252?Q?tl7CPAXKcKMvTvDLEPmw6cFnc8Vi0R4EQQG/9gnbdPaBzW4mjVbm9D4s?=
 =?Windows-1252?Q?JwPdIee8MjJ9eMjzq4sCSjmPKlni0Zx3MldG9W1UPog+6F2g9ojRa3kM?=
 =?Windows-1252?Q?rWOuSmErjE4I+sm5s6H0SsT5fcrbiKIBTYm1zB9DtgnPpqASbQeWmZya?=
 =?Windows-1252?Q?dJglhTnLOgfbXl2TPo0D35d1wEnTN0iM9Um3+w4EDFQW6GzHgPXXvjwI?=
 =?Windows-1252?Q?eVIre8zvx9epJ057z47XiJl5rKHtyKAiCeUvLa/wqr1NYqxTFd4b4E2r?=
 =?Windows-1252?Q?ookDLGM1VdTi+yy5N+ZcWtKF+LuwztoxRKHQmgdI6l9DXeKCd8MoQdDq?=
 =?Windows-1252?Q?2rkAgEuhNXt8Xb1Tmm5hmcScpdLG7QN+IbqItfi2teDfRv8JXZqRT0X8?=
 =?Windows-1252?Q?He77UVCoO3Wk4wWHtPkxjzYCz7biXOp+nixL/CdFNquT64Ddkx+yyOFI?=
 =?Windows-1252?Q?Or2EK+J8eDtYkXF6O3cm3GJ/Q7LU7CGZvDjoOVmgKGt+Sj+dJbPgn1zQ?=
 =?Windows-1252?Q?GRVEuLePFDgkvrjp?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85385a76-8f6c-4d7b-3721-08d8b6c0d6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:11:02.3135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKzOcqQALewCxw1AcTbnFLoIZLCKQe+m87bznd1zNDoTq2kRlgVQQZ++VBs3jcQqziWWDsyN1coivXbZBYEmoD7Cp8e3vzYLOPI6ZU1m5Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_011109_782006_E22DF141 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 21:32, Damien Le Moal wrote:
> On 2021/01/12 13:27, Chaitanya Kulkarni wrote:
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
>>  drivers/nvme/target/admin-cmd.c   |  28 +++
>>  drivers/nvme/target/core.c        |   3 +
>>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-
>>  drivers/nvme/target/nvmet.h       |  38 ++++
>>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++
>>  6 files changed, 437 insertions(+), 8 deletions(-)
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
>> index a50b7bcac67a..bdf09d8faa48 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(st=
ruct nvmet_req *req)
>>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);
>>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);
>>  		break;
>> +	case NVME_CSI_ZNS:
>> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> +			u32 *iocs =3D log->iocs;
>> +
>> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);
>> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);
>> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);
>> +		}
> Is it OK to not return an error here if CONFIG_BLK_DEV_ZONED is not enabl=
ed ?
> I have not checked the entire code of this function nor how it is called,=
 so I
> may be wrong.
Since we only set the controller cap when CONFIG_BLK_DEV_ZONED is
enabled we should be uniform everywhere in the code, I'll recheck
and make the change if needed.
>> +		break;
>>  	default:
>>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>>  		break;
>> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct =
nvmet_req *req)
>>  	if (status)
>>  		goto out;
>>  =

>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> +		u16 nvme_cis_zns =3D NVME_CSI_ZNS;
>> +
>> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)
>> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
>> +							  NVME_NIDT_CSI_LEN,
>> +							  &nvme_cis_zns, &off);
>> +		if (status)
>> +			goto out;
>> +	}
> Same comment here.
I think same explanation applies here too, will recheck and make the change
if needed.
>
>> +
>>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)
>>  		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
>> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req=
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
>>  	case NVME_ID_CNS_NS_ACTIVE_LIST:
>>  		return nvmet_execute_identify_nslist(req);
>>  	case NVME_ID_CNS_NS_DESC_LIST:
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 672e4009f8d6..17d5da062a5a 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>>  static inline bool nvmet_cc_css_check(u8 cc_css)
>>  {
>>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {
>> +	case NVME_CC_CSS_CSI:
>>  	case NVME_CC_CSS_NVM:
>>  		return true;
>>  	default:
>> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>>  {
>>  	/* command sets supported: NVMe command set: */
>>  	ctrl->cap =3D (1ULL << 37);
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> +		ctrl->cap |=3D (1ULL << 43);
>>  	/* CC.EN timeout in 500msec units: */
>>  	ctrl->cap |=3D (15ULL << 24);
>>  	/* maximum queue entries supported: */
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-=
cmd-bdev.c
>> index 23095bdfce06..6178ef643962 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvm=
et_ns *ns)
>>  	}
>>  }
>>  =

>> +void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>> +{
>> +	if (ns->bdev) {
>> +		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>> +		ns->bdev =3D NULL;
>> +	}
>> +}
>> +
>>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>  {
>>  	int ret;
>> @@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
>>  		nvmet_bdev_ns_enable_integrity(ns);
>>  =

>> -	return 0;
>> -}
>> -
>> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>> -{
>> -	if (ns->bdev) {
>> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>> -		ns->bdev =3D NULL;
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {
>> +		if (!nvmet_bdev_zns_enable(ns)) {
>> +			nvmet_bdev_ns_disable(ns);
>> +			return -EINVAL;
>> +		}
>> +		ns->csi =3D NVME_CSI_ZNS;
>>  	}
>> +
>> +	return 0;
>>  }
>>  =

>>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
>> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>>  	case nvme_cmd_write_zeroes:
>>  		req->execute =3D nvmet_bdev_execute_write_zeroes;
>>  		return 0;
>> +	case nvme_cmd_zone_append:
>> +		req->execute =3D nvmet_bdev_execute_zone_append;
>> +		return 0;
>> +	case nvme_cmd_zone_mgmt_recv:
>> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;
>> +		return 0;
>> +	case nvme_cmd_zone_mgmt_send:
>> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;
>> +		return 0;
>>  	default:
>>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
>>  		       req->sq->qid);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 476b3cd91c65..7361665585a2 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -252,6 +252,10 @@ struct nvmet_subsys {
>>  	unsigned int		admin_timeout;
>>  	unsigned int		io_timeout;
>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>> +
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	u8			zasl;
>> +#endif /* CONFIG_BLK_DEV_ZONED */
>>  };
>>  =

>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
>> @@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvm=
et_ns *ns, __le64 lba)
>>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
>>  }
>>  =

>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>> +#else  /* CONFIG_BLK_DEV_ZONED */
>> +static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>> +{
>> +	return false;
>> +}
>> +static inline void
>> +nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>> +{
>> +}
>> +static inline void
>> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>> +{
>> +}
>> +static inline void
>> +nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +}
>> +static inline void
>> +nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +}
>> +static inline void
>> +nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +}
>> +#endif /* CONFIG_BLK_DEV_ZONED */
>> +
>>  #endif /* _NVMET_H */
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> new file mode 100644
>> index 000000000000..2a71f56e568d
>> --- /dev/null
>> +++ b/drivers/nvme/target/zns.c
>> @@ -0,0 +1,342 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe ZNS-ZBD command implementation.
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include <linux/nvme.h>
>> +#include <linux/blkdev.h>
>> +#include "nvmet.h"
>> +
>> +/*
>> + * We set the Memory Page Size Minimum (MPSMIN) for target controller t=
o 0
>> + * which gets added by 12 in the nvme_enable_ctrl() which results in 2^=
12 =3D 4k
>> + * as page_shift value. When calculating the ZASL use shift by 12.
>> + */
>> +#define NVMET_MPSMIN_SHIFT	12
>> +
>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
>> +{
>> +	u16 status =3D NVME_SC_SUCCESS;
>> +
>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {
>> +		status =3D NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {
>> +		status =3D NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)
>> +		status =3D NVME_SC_INVALID_FIELD;
>> +
>> +out:
> You really want to keep this (useless) label ? Without it, the status var=
iable
> can be dropped and the code overall becomes so much easier to read... Not=
 to
> mention that life will be easier to the compiler for optimizing this.
>
Will remove it in the next version.
>> +	return status;
>> +}
>> +
>> +/*
>> + *  ZNS related command implementation and helpers.
>> + */
>> +
>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
>> +{
>> +	/*
>> +	 * Zone Append Size Limit is the value experessed in the units
>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
>> +	 */
>> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
>> +}
>> +
>> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)
>> +{
>> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;
>> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));
>> +
>> +	if (ns->subsys->zasl)
>> +		return ns->subsys->zasl < zasl ? false : true;
>> +
>> +	ns->subsys->zasl =3D zasl;
>> +	return true;
>> +}
>> +
>> +
>> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
>> +					    unsigned int idx, void *data)
>> +{
>> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
>> +		return -EOPNOTSUPP;
>> +	return 0;
>> +}
>> +
>> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
>> +{
>> +	int ret;
>> +
>> +	if (bdev->bd_disk->queue->conv_zones_bitmap)
>> +		return true;
>> +
>> +	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),
>> +				  nvmet_bdev_validate_zns_zones_cb, NULL);
>> +
>> +	return ret < 0 ? true : false;
> return ret <=3D 0;
>
> would be simpler.
>
> Note that "<=3D" includes the error case of the device not reporting any =
zone
> (device dead) as we should fail that case I think.
>
hmm will make that change.
>> +}
>> +
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>> +{
>> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
>> +		return false;
>> +
>> +	/*
>> +	 * For ZBC and ZAC devices, writes into sequential zones must be align=
ed
>> +	 * to the device physical block size. So use this value as the logical
>> +	 * block size to avoid errors.
>> +	 */
>> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));
>> +
>> +	if (!nvmet_zns_update_zasl(ns))
>> +		return false;
>> +
>> +	return !(get_capacity(ns->bdev->bd_disk) &
>> +			(bdev_zone_sectors(ns->bdev) - 1));
>> +}
>> +
>> +/*
>> + * ZNS related Admin and I/O command handlers.
>> + */
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>> +{
>> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;
>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>> +	struct nvme_id_ctrl_zns *id;
>> +	u16 status;
>> +
>> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
>> +	if (!id) {
>> +		status =3D NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	if (ctrl->ops->get_mdts)
>> +		id->zasl =3D min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
>> +	else
>> +		id->zasl =3D zasl;
>> +
>> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>> +
>> +	kfree(id);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>> +{
>> +	struct nvme_id_ns_zns *id_zns;
>> +	u16 status =3D NVME_SC_SUCCESS;
>> +	u64 zsze;
>> +
>> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);
>> +	if (!id_zns) {
>> +		status =3D NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsi=
d);
>> +	if (!req->ns) {
>> +		status =3D NVME_SC_INTERNAL;
>> +		goto done;
>> +	}
>> +
>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto done;
>> +	}
>> +
>> +	nvmet_ns_revalidate(req->ns);
>> +	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>
>> +					req->ns->blksize_shift;
>> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);
>> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
>> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
>> +
>> +done:
>> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
>> +	kfree(id_zns);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +struct nvmet_report_zone_data {
>> +	struct nvmet_ns *ns;
>> +	struct nvme_zone_report *rz;
>> +};
>> +
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int i=
dx,
>> +				     void *data)
>> +{
>> +	struct nvmet_report_zone_data *report_zone_data =3D data;
>> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries;
>> +	struct nvmet_ns *ns =3D report_zone_data->ns;
>> +
>> +	entries[idx].zcap =3D nvmet_sect_to_lba(ns, z->capacity);
>> +	entries[idx].zslba =3D nvmet_sect_to_lba(ns, z->start);
>> +	entries[idx].wp =3D nvmet_sect_to_lba(ns, z->wp);
>> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;
>> +	entries[idx].zt =3D z->type;
>> +	entries[idx].zs =3D z->cond << 4;
>> +
>> +	return 0;
>> +}
>> +
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };
>> +	unsigned int nr_zones;
>> +	int reported_zones;
>> +	u16 status;
>> +
>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /
>> +			sizeof(struct nvme_zone_descriptor);
> I really would prefer this code to be moved down, before the call to
> blkdev_report_zones().
>
> You can also optimize this value a little with a min() of the value above=
 and of
> DIV_ROUND_UP(dev_capacity - sect, zone size). But not a big deal I think.
I did that as per your last comment, when I did the code review with
host side it didn't match, I've a cleanup patch series to fix nits and
host side css checks for zns I've added this into that series.
>> +
>> +	status =3D nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO=
);
> Shouldn't this be GFP_NOIO ? Also, is the NORETRY critical ?
Yes on GFP_NOIO. NORETRY critical means how we areallocating the memory on
the host side nvme_zns_alloc_report_buffer() ?
> blkdev_report_zones() will do mem allocation too and at leadt scsi does r=
etry.
>
>> +	if (!data.rz) {
>> +		status =3D NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>> +					     nvmet_bdev_report_zone_cb,
>> +					     &data);
>> +	if (reported_zones < 0) {
>> +		status =3D NVME_SC_INTERNAL;
>> +		goto out_free_report_zones;
>> +	}
>> +
>> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);
>> +
>> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>> +
>> +out_free_report_zones:
>> +	kvfree(data.rz);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>> +	sector_t nr_sect =3D bdev_zone_sectors(req->ns->bdev);
>> +	u16 status =3D NVME_SC_SUCCESS;
>> +	enum req_opf op;
>> +	int ret;
>> +
>> +	if (req->cmd->zms.select_all)
>> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);
>> +
>> +	switch (req->cmd->zms.zsa) {
>> +	case NVME_ZONE_OPEN:
>> +		op =3D REQ_OP_ZONE_OPEN;
>> +		break;
>> +	case NVME_ZONE_CLOSE:
>> +		op =3D REQ_OP_ZONE_CLOSE;
>> +		break;
>> +	case NVME_ZONE_FINISH:
>> +		op =3D REQ_OP_ZONE_FINISH;
>> +		break;
>> +	case NVME_ZONE_RESET:
>> +		op =3D REQ_OP_ZONE_RESET;
>> +		break;
>> +	default:
>> +		status =3D NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
> GFP_NOIO ?
Yes.
>
>> +	if (ret)
>> +		status =3D NVME_SC_INTERNAL;
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;
>> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);
>> +	u16 status =3D NVME_SC_SUCCESS;
>> +	unsigned int total_len =3D 0;
>> +	struct scatterlist *sg;
>> +	int ret =3D 0, sg_cnt;
>> +	struct bio *bio;
>> +
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +		return;
>> +
>> +	if (!req->sg_cnt) {
>> +		nvmet_req_complete(req, 0);
>> +		return;
>> +	}
>> +
>> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio =3D &req->b.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +	} else {
>> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);
>> +	}
>> +
>> +	bio_set_dev(bio, req->ns->bdev);
>> +	bio->bi_iter.bi_sector =3D sect;
>> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>> +		bio->bi_opf |=3D REQ_FUA;
>> +
>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
>> +		struct page *p =3D sg_page(sg);
>> +		unsigned int l =3D sg->length;
>> +		unsigned int o =3D sg->offset;
>> +		bool same_page =3D false;
>> +
>> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
>> +		if (ret !=3D sg->length) {
>> +			status =3D NVME_SC_INTERNAL;
>> +			goto out_bio_put;
>> +		}
>> +		if (same_page)
>> +			put_page(p);
>> +
>> +		total_len +=3D sg->length;
>> +	}
>> +
>> +	if (total_len !=3D nvmet_rw_data_len(req)) {
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
>> +		goto out_bio_put;
>> +	}
>> +
>> +	ret =3D submit_bio_wait(bio);
>> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,
>> +						 bio->bi_iter.bi_sector);
>> +
>> +out_bio_put:
>> +	if (bio !=3D &req->b.inline_bio)
>> +		bio_put(bio);
>> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
>> +}
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
