Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618AC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 23:06:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83212224C
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 23:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83212224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=i94tpR7dLcuGSGpRsikRMU/GsP/ORc2gGMs2Bx2MjXI=; b=rC+YAmLcVnzUW5b4D9aU7leoq
	7BAwWSGzwij0p3AOmjiGwdyyA0RJyJcPKDbQ6OOt07+1125aTGD5r/7ZZWMU1Twg3WW70KT6B+rCJ
	4pQNMvXeuRwEFMwKIumyBcgafeLvhVlqjHHhAMbcYW14s3MFHIJNqWfO1w9JKuMXLTqDmx6C//nLq
	HiC5Oo4ISZz3d+SQr+dvd67F7wWvF20Xz4vYRwdh+EfCnHdzk3tp7eZC78vuofY6iwpq84Cd2mT0N
	47oU6CIC+iW1kj4IJ5ld5rl9ftXFYIyS7Q9TFVTa2Hj7Xm17pPHXc2twLtG4W8V15zzcNB1VtqT5B
	+gj+MAvKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpJP9-00065w-HB; Tue, 15 Dec 2020 23:06:51 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpJP5-00065N-QZ
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 23:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608073607; x=1639609607;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aRkGOR470Zuxt/V0ggJhuetGmFG3FhhOfATDOrSRte8=;
 b=Mt1wl7H+nvCIuZUkcTVD4sg7IObahLr4zmLfVdfRNSOaCkTS7dyKrIS9
 1d34rI9Iw0UlR0+Z1eB33dad47OLRWUFyAlGmxGet1x280Y5qVAtiVrc7
 d+Q0Z45tAg/iDongb/aauMOJStSIOWdrf4LxXGK5D4fbHrqdPMVkCxwuU
 gMng6KS87GB22BNM3TF4FimM8Yb/okOczlfPMoFUX7YAQnHDieNC4Xuf0
 JIwlAo7y6WLo/xBVt5YyyLQtXfAUQ9NGiuItAkTulT52VJeBu7jWy9r+7
 o2+mqNWj32BU4r8C5NCbMCdiZ1sH6dcBeJbPIw9U7YPsJUK7/bZ8XqMux A==;
IronPort-SDR: 2mzdT/h5fHcvKWPizE3lWVes7uKb/2fmeSPorIAdB0rDldz/g3K5YIA8Ymn/yXW4I/cruno9ko
 /MOr3JdbOlaJ5sRiQrE4fjpYSPCWPhZoNZWyvt9givqYXaP4XD1hdEtBVic0WizBAlCIlJ5jDA
 O90zgu+6u/kPpvm7pP2/BsTTBPEo0EeJIFhsJF35GQEEivG4yaDSH/NH4sowFY9aoyoJ6apUto
 ArQp8u+EWiElFyoK2Qkbjpml65W9vhzdIXnjcq872OEpAnXKwNLuqATqgxodfvZKYTSz5cBaNy
 lQ0=
X-IronPort-AV: E=Sophos;i="5.78,422,1599494400"; d="scan'208";a="159684467"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2020 07:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwnONT3xR1odg2NsKNXLQsuvzhG+QLwUq9YaXKv6J88Oe/GyJ8J+Vuju3ZyE4IEx07Wp+OydjWSyknlxrYJ/5hAFgXsAiA4vzQ50+xgsFli6CX8YyNinEkEovJv5QIFmZdh68VVsV3vFqumdIBrlGej7eUXUDeqTfY5jHSgU3jMufHlqXLqdct7NPbrt43ixYMwn0TuYbfSbEqoEH395q+gYV6m7Zp1Uj+hK9bC1v+I6aj1oKly8EiNIULdSdEA6VFJ2WTNN44wC5c+MXY5kcwPJTqSwxfaUb2sNu820U/T6DItDuGgutxDxdnrX9cSTi2N/mUce/GlTXs7EMd7HwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsNv9XS8b2vT+Ldk9d+urz17+znaO9P5Wa/WcKgqcc0=;
 b=DRFT6WG3KpFWi8gGFTJVfPTNKaS40/B3dFOPO9XiMgDffE+G1YUT9qXYSmdDOEFcaofRl4EqIWTxZ95YkixhSvtctPAiFvf8Q8/WScmcR2ZqiiXOYvT1oQk3/8uJHLYUgQJMMz/gvZU+em6UfOECxrnzTGAM5vkraFnNnCcNOXIDJo7e2wjSJtD4EVjp41qymwd6VOSTGOnT9Nh+i5ynslihJ5FbRwOuV8Bf0ZIwfEC3Xi/t6Du0bswGonBUhYVMCAtn+mE7H2TvEW+fHh9crTRTeQ8HnfAh/HOjuD9tBklQ1vtn6SIOzfyHFbUSBT5sADcRB0kqUwyGxpHH4qqIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsNv9XS8b2vT+Ldk9d+urz17+znaO9P5Wa/WcKgqcc0=;
 b=PrpTWWL7iuHPAngEhM9bCzsAgCTsP07feYn/uWN3qmAVG83qYmXIsMnzxqAw7ROz5pNF49M/D3Ptf3ZFPNzkcmp1WKnMR6GfkzRaQPIsE4LZxrrVRCCYis+m6pWmVob97kotJgSLIgAFUejzchrdOvXJV8ZEus+FynLuVkQjWx8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 15 Dec
 2020 23:06:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3654.020; Tue, 15 Dec 2020
 23:06:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRNy69mNMtIEqLi2NUVHmAXg==
Date: Tue, 15 Dec 2020 23:06:42 +0000
Message-ID: <BYAPR04MB49659C0D80D3D3EA2F2D24E886C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83b999fd-373b-489c-cd24-08d8a14e1681
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB71236DC357BC76521E2359AF86C60@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICMSOJ2FLiY2mUo9Td0lUWyKa+OHIMzeuOFRV7u09UUygLi+ak1rdR1igvNfNvsZUWfJUN2kOf1I1pZFrPaB+L5n9ESri7tgP/7Nevn8FrN2K69dr1nOmcBaVcjHyTdCVx8Rlxf+GWQMETPePLX4MuZm587+BhAsxdMuObQjsY3JyJqwltWRu7MWzUeB8bf6C4m4nE+0mxMBLVSBefvYONpVHO6+flicfzNgxOkAIv5WJtmCu1B5nQezmOUBObKb+eHjDOYm8Rnyh8FlDg/eCgbOhrGd2aFKFAIOq8k+q2H00c6JcWvipK8WhieeE+Nc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(396003)(366004)(136003)(55016002)(316002)(9686003)(66446008)(478600001)(83380400001)(54906003)(110136005)(66946007)(66556008)(76116006)(6506007)(53546011)(33656002)(52536014)(26005)(64756008)(66476007)(4326008)(30864003)(5660300002)(8676002)(86362001)(71200400001)(8936002)(7696005)(186003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?OSLt9GEv+AdphvW8ImmmzZLgP9oi3bNAqgZ3mII7bvP7lRPOzZ3S4zDb?=
 =?Windows-1252?Q?GT8vTKtYmymbCTAX/mgc65CnJfb1B9Gry/H26HCc8Lz2Q2WvVf9Oaywb?=
 =?Windows-1252?Q?u6/e0nHlQ7f9k2YfBt++YqF6O5cVOtvJ76IRm67vSWUPnaVgE/eh5e8j?=
 =?Windows-1252?Q?Z1DfsTgH6GWmvVlCkGMeXF5GK8Gy/8g5GHWnWHwYSbT50NAcRlExnGLh?=
 =?Windows-1252?Q?r33gPgVGr5NXFU2hpD9a8UDLHuWvI7qSzhpqVrZQWLigIL9QauciSxpm?=
 =?Windows-1252?Q?pR8R5ZnCyNcOMNCfmb5WnG8TozgdSXspgsTHg9jab8/LhYolSC9QnAcY?=
 =?Windows-1252?Q?RtDcd5/jYKf/UfoiG52GvfqtYtPxOepFYsCE7YySA6YsNjl7sPp1IQE/?=
 =?Windows-1252?Q?OA+qh+KWfoVLrbC5dfyMgM/Yk3XggSBHGBAAn/pEo/s5Kd4nvbVu+JrU?=
 =?Windows-1252?Q?nz9UoBsEtnP+wS/TT50CqEfze3a5A7HieHZ7rPxJAetP8FUNc114CLvx?=
 =?Windows-1252?Q?zrsgCpj31VrsXwb8d3XxoxkqjGzkMjWsxwyVMvLMO06d/9uLyp7NA5H9?=
 =?Windows-1252?Q?+UNxq4GjrmpcXvKlocfggPUryJYK9L77b9wlwowQvSbft/tTohHHavVX?=
 =?Windows-1252?Q?VDWjwRBkXZaBOHkSf/BrK5I39e+zrf4zEwu6qT4Fjj1Z/x7QuAtVgPjV?=
 =?Windows-1252?Q?FuNnxkOiO3SkEncUBkLLh7sNqEHIOTwHwyb2kOkfPmBXdJh0/3EmiHiU?=
 =?Windows-1252?Q?z8Cv6OdO8o3vZpwZDzmBHZT74SrCnYnlI6ZbPdwvwkwQ0kMVH8ztyJgP?=
 =?Windows-1252?Q?pd0a6khQlNZZa2CYkH47EstUja3UbCejx6ML8rUAhHDotpaCEkR9y/68?=
 =?Windows-1252?Q?2lqc9nEUC2zlNX+ZBOJCHSwV5r1hB6QxFoFp0fdH8LlMsOzgcxsGuAdB?=
 =?Windows-1252?Q?bZZn8uf9mnQpn57uh6QgP6TMy8ytkjlUKsTSW2N3Cbbp/nRKd38rsHXV?=
 =?Windows-1252?Q?i8vplupeXLj+aS7Phr35cuJKzpGHQDpUsodglEpQ1S1vwjdNFBn0NeB+?=
 =?Windows-1252?Q?cp9+RfBtk4Aiamho?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b999fd-373b-489c-cd24-08d8a14e1681
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 23:06:42.8722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pwTJ6wrqVrty5bC8mENHFEia5UXqErJnFJerr/qfzrUOXCcQWtJ+VlY44KbCIEpbMInZh1YqXWqWqgqZWE3RZIS75t4YZDnIPBSaUoExCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_180648_684186_CE1AF594 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/15/20 01:06, Damien Le Moal wrote:
> On 2020/12/15 15:03, Chaitanya Kulkarni wrote:
>> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
>> communicate with a non-volatile memory subsystem using zones for
>> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
>> Protocol compliant devices on the target in the passthru mode. There
>> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)
>> HDDs which are not based on the NVMe protocol.
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
>>  drivers/nvme/target/admin-cmd.c   |  26 +++
>>  drivers/nvme/target/core.c        |   1 +
>>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-
>>  drivers/nvme/target/nvmet.h       |  38 ++++
>>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++
>>  6 files changed, 433 insertions(+), 8 deletions(-)
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
>> index f4c0f3aca485..6f5279b15aa6 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(st=
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
>> +		break;
>>  	default:
>>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>>  		break;
>> @@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req=
 *req, u8 type, u8 len,
>>  =

>>  static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>>  {
>> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;
>>  	u16 status =3D 0;
>>  	off_t off =3D 0;
>>  =

>> @@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct =
nvmet_req *req)
>>  		if (status)
>>  			goto out;
>>  	}
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)
>> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
>> +							  NVME_NIDT_CSI_LEN,
>> +							  &nvme_cis_zns, &off);
>> +		if (status)
>> +			goto out;
>> +	}
>>  =

>>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)
>> @@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req=
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
>> index 672e4009f8d6..17a99c7134dc 100644
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
>> index 000000000000..3981baa647b2
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
> You could move this right before the vmalloc call since it is first used =
there.
There are only three lines between the this and the vmalloc, does that
really
going to make any difference ?
>> +
>> +	status =3D nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO=
);
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
> Wasn't it the plan to integrate this function into the normal read-write
> proccessing ? I remember Christoph commenting on that.
Yes and I did that, it looked ugly and there is not much common code
apart from following 12 lines :-

        if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
                return;

        if (!req->sg_cnt) {
                nvmet_req_complete(req, 0);
                return;
        }  =


        bio =3D nvmet_req_bio_get(req, NULL);
        bio_set_dev(bio, req->ns->bdev);
        bio->bi_iter.bi_sector =3D sect;
        bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;  =


Instead of saving 12 lines of code I'd prefer to have clear modularize
zone-append handler and not touch rw fast path. I can add helpers to trim
downabove code which we need anyway in V8.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
