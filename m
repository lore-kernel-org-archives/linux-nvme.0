Return-Path: <SRS0=Hsw+=FQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA20C433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 06:54:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FA823125
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 06:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FA823125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7MCcxVzp+JCli+CREVIuDaw56StkOqyH5P/zSzuOgZQ=; b=VuZVUU3uZ8lnLvsFqmw5Tuc/q
	cy8tbNRBtVEapVhQwyShDpChHBpm63TeLAvyt/EFjlmab84tLGWhXzYoP+XLGp/DhAIGsiwEh0Xwf
	4gje+i5tKkZFWVWy7FzSBvEwBDGwU+9i+nKIcxEJZ1/I0pXgU9tyap84MVO4gJCRthjuMj/NwU1BK
	IBtEQstj+XbjDZsh7gy82nKO5QZa8f7Yr8QuWv5XWhkTLNZL1m9SYNVzvXGjrkIBQ11HyPlW+tRue
	zopde7UFC1En/pU0s6r+C7gqe/hAJ9PqCQOWep0BtABzlO6PId2cqKx874pRf/XrxxnQwgflUWI+i
	/ZJOS4Pbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knynZ-00055e-BM; Sat, 12 Dec 2020 06:54:33 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knynT-00055G-Sq
 for linux-nvme@lists.infradead.org; Sat, 12 Dec 2020 06:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607756067; x=1639292067;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FTwjlZWdAQNidYAsMOJg/47ptiBhDrN7KMSV42ynrXU=;
 b=PxqMfmAVrWK+q24e0tuu5XKIguC6dXyWZAzKranuAZTAPoAo60CgNfnI
 EbM0kyXL2j9yw2jj5lY8ork750KAOHgPlnPESHvuPnml8kqIdb2BuJlme
 tOCpiwXTPqAKE40JwZoYMa1zZYbdvKuHpHmmxopw0raAt/mKs1swgYjbq
 KQhJRcFpymqRPO9tOS3WIFBU6WXZbmqvNAfYrHfhchFci35XnTtpTMsyD
 wfZVgTnEq7Dx64I0+0UmLPm+x5/5oMAxUDgtfVbL+SstbKmO3lmXrtfnY
 vbzLcmun/XocwxO/xlDJT56oK12GvrNqDAR02xrUcV4MJc8CCAJxgblb4 Q==;
IronPort-SDR: UvgiLr9ziT6sVzhIAdr/n00GLAm5o3nQ/G9/76etN6+N0bfS0rn5XUBznr/bBqFzJGkrGYrmn2
 FDCC5ILExx6V1CUH1cDIeOPInsQVR1dkj3OBQyX8O7JMPQLSkjMkNCXmXIK2K+Vwi18eNsmWKP
 z9HKYkDJXxllOvkTUtY33of+31Wq4zxGx2w9e8hzli6znBIvFVR4rbxprs2eUbPIeimaYHbHPY
 F+fM4HNt7RnBGW4qSApsQhsdFf3m0vFqrU+pkJQQx4S1NuXYNCOSbZfMe0yhaE8eXE/5bmoqXk
 QPo=
X-IronPort-AV: E=Sophos;i="5.78,413,1599494400"; d="scan'208";a="159446394"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 14:54:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2qA1eDBQSXiuOZM6YLpkLHdhUJtBGS5fLRjZnrRyh6cn4f4mYdUzB/lfpWKvBboF/2OICK37tIXtlP4z6H6nw+KWWYS5hr5p3KPztjJqnQ/CaZJwJw6I/yyQZqNnLF66I10Yb/NENx4hdojDPopIlFPrVBE/nxvZS+NCwKVyLldw58wj1juclqSlDWRZcPJOoxwLhtL7NOXeftJb3CRMSGujTpTvLhzFH3ka7kv47DCAEcyq5PnvMITQS8yZHT081J8phwDAS7v33x5VqHtfMrXjtecol9eEU5GBRvElqexqcPfv+egYrltylZbkfhfdPwGw0sYCL7yOXi1+umkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBOh2ttDYMR8UUXsnBYksTnQenzk6JAonT+dbbzPR7M=;
 b=grMJNtDjWVIZgDneZQPvQU1EkMvE6T/ewL7IrZAfxuMFiCx9c9wDtaHZsZexTnCL6YUVopzaFFT+JxXdzfhaMeZmZA77m3yimJa21umFK1K+DEqJgFB6e8xsPysbCaxHsxH3AGn9C6DMV2SjoAh8k2W05s1Apl6WwtLJvPUN9/nueBxuPi2ywAElpwKWqwyxqxnJG/oRMho0sP0w976xcRUGjYGKQERRt0Ve5MTpIY0jhTruneJe16OEimGPLJE4OSI/wCxSHY198Iux04hIjAGuqQbkqfebjgGu9daO33rHRkkK5tgwOzUIWRuvcpDRPBR5Qf0frO4Z6gx3tS3STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBOh2ttDYMR8UUXsnBYksTnQenzk6JAonT+dbbzPR7M=;
 b=tRfEV1RLAAM+/VG1LcHJHKXwQbsHf8lDqUPGtmXaSHpa0AD2StC1OzFEnD1M9OlAcz6vZ+mGigHn2RWixFpaSTh2NEu5x2FhpWDAAyr4BAuWOWUFzk6AoTDyXp+eL/PK786sJF2EtVNgepa8r9hCH4PohV4Kh63fR24VqahHoPo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4662.namprd04.prod.outlook.com (2603:10b6:a03:14::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Sat, 12 Dec
 2020 06:54:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Sat, 12 Dec 2020
 06:54:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHWzr2FuszvFJU9HEW4WB60UcvV9w==
Date: Sat, 12 Dec 2020 06:54:21 +0000
Message-ID: <BYAPR04MB49652F762776AC04BC2719A386C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652299EA78B1304157CC8234E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f51d0bea-e8dc-4deb-e8a1-08d89e6ac12c
x-ms-traffictypediagnostic: BYAPR04MB4662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4662B87351930B45BCB248B786C90@BYAPR04MB4662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqY3yCmCryln9PDg0p85uFOBTG/+Lor1/SZwyEfyxzRCGXWfWC0UXmKqW24AKAt77d+kHhEV02jA+08lxa9RU+JMvJS+6/G7iqeqNsWhYQYPo7LbHGnQBB0eEFJAu3F/UuUG5ECi3jgQS23RKU1kc3p/SjHXhpdkBmnEsQum0c7CWjbBB3B7FivfylAJXPn0SbgIeQdSRXVU8J18K+vnG1knW4yQdUtRbxt7Sc62nICFGUqC9CU2r2LUzZjbbKFJklvfzKImIvCmdviE86k9Nkg+BnzXTPMLsiYg2Vze5WALb1gGcKrucx+hBhot0mEr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(83380400001)(6506007)(55016002)(9686003)(33656002)(8936002)(8676002)(4326008)(30864003)(66476007)(2906002)(66446008)(53546011)(64756008)(110136005)(52536014)(66556008)(186003)(54906003)(26005)(76116006)(7696005)(71200400001)(508600001)(5660300002)(66946007)(86362001)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?ot9jYQV6rWdzm2jEK22WJUK1gQ0DNz622oRinWM2vRN8IlW3hdMyc9j5?=
 =?Windows-1252?Q?VPdnh+5TG9y5VNlanRh2QZW20xCaSW0UUC/J+x79wdwEMjTWS/KDIyhR?=
 =?Windows-1252?Q?Mf6zlZ6uXW+n5fkGuLN9QAokmNeP6ZVktrSRxkcNVZqisB7DU5DDq8Ec?=
 =?Windows-1252?Q?KI5BBIqmBLvRiub5+MMXXT8uHAnM+eXja1Iosj+l1f2tb0NvCyUM7WyA?=
 =?Windows-1252?Q?p0k0njS7To3pM95bTJ/99dfdpYpf692nVPTRpT6CUcmBvkYe6RIGYEoE?=
 =?Windows-1252?Q?pns5R/wIvWk8zhMcIy50TO28wOLi3qPE571ArBdU+48OI7GQniO4w3Fg?=
 =?Windows-1252?Q?eC9P64X2xVd4CzlSFRPs9PWl00PvQ/EGtG60CVP9buvLxW3Aktn4yN/0?=
 =?Windows-1252?Q?3QZlTm6nsceR4u86jax1JVxCqiJx5ceq+04jqxY7CCY8JnmcEqh/vKhU?=
 =?Windows-1252?Q?my/4ZSX0u9wwzg1ZA6JitPgpxICqkcNKqraFsE2dT1kGJusYr8/3rROz?=
 =?Windows-1252?Q?lyOpr2xqPSqN5xSbdRT8+26HkRzjs+XGn3uRiltnDM/Y2QT5g//Sjwzl?=
 =?Windows-1252?Q?tXiNw27APd8TZiBl6UNtbcXzt0rDt7WWLrzXGmn1rrOianzFCR32irOp?=
 =?Windows-1252?Q?Rm+8V4PjFI1ermE20+KYEgNaChnpBwiElQbFYRbEFtHJ1FePqhyoAlBQ?=
 =?Windows-1252?Q?PcVWxzYaE1urztLT+J0sG8kIx8DtrMm7wevPzaF8HYzWkeLMOTqFDC/O?=
 =?Windows-1252?Q?Uf3lqJutkFr0f4qAC34sFKSUxZN6FN4FGSzqotCkXMznE9+mp/8l6l7o?=
 =?Windows-1252?Q?PY/RptSb4/LN3vGbjzGokg20R0wMY/IFhtA/34x1qpDrz9XUjE93MZ72?=
 =?Windows-1252?Q?sJLFe353LvovqJX9Fs7JsDf5lE2dNIaQv8qx7Wx6i0SF9rPOKUVhefNB?=
 =?Windows-1252?Q?C1Jd0Vr66RqF9h9K3xZTa2iqzdA0dMkiEoaXwvMAh3SpUyoZ+mTTZtTJ?=
 =?Windows-1252?Q?AJ3gGkqxdbWSQxGkklNSZWt10fb14uwFrUyIqZnu6vMwZt4dfeMht6g1?=
 =?Windows-1252?Q?rCiayRjPJF1nYnEW?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d0bea-e8dc-4deb-e8a1-08d89e6ac12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 06:54:21.6033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbvxnzNeNIct8mcRL2asxvvK+BsTLuhTcklkJiiAOD/5mz4XagUq0Ymyvb9JESr3O1H7fODoilfQNWcfNbJ1sXv5FHfVa6X5sOjIxg5XJr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201212_015428_447934_6BD02E96 
X-CRM114-Status: GOOD (  17.24  )
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

On 12/10/20 17:18, Damien Le Moal wrote:
> On 2020/12/10 15:27, Chaitanya Kulkarni wrote:
>> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
>> communicate with a non-volatile memory subsystem using zones for
>> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
>> Protocol compliant devices on the target in the passthru mode. There
>> are Generic Zoned Block Devices like  Shingled Magnetic Recording (SMR)
> Please remove "Generic" from this sentence. It is confusing. Also, I do n=
ot
> think you need to capitalize ZOned Block Devices. That is something Linux
> defines. It is not defined by any standard.
Since target supports ZNS in the passthru mode term generic is needed
to differentiate the backend type.
Regarding zbd I'm fine with that.
>> HDD which are not based on the NVMe protocol.
>>
>> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
>>
>> This support inculdes implementing the new command set NVME_CSI_ZNS,
> s/inculdes/includes
Okay.
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
>>  drivers/nvme/target/zns.c         | 327 ++++++++++++++++++++++++++++++
>>  6 files changed, 418 insertions(+), 8 deletions(-)
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
>> index 0360594abd93..dae6ecba6780 100644
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
>> index 000000000000..ae51bae996f9
>> --- /dev/null
>> +++ b/drivers/nvme/target/zns.c
>> @@ -0,0 +1,327 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe ZNS-ZBD command implementation.
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include <linux/uio.h>
>> +#include <linux/nvme.h>
>> +#include <linux/xarray.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/module.h>
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
>> +	u16 status =3D 0;
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
> I really fail to see how the gotos here help with the code "being better".
> Are you absolutely sure you want to keep this super convoluted style for a
> function that is that simple ?
>
> +
> +/*
> + *  ZNS related command implementation and helpers.
> + */
> +
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	/*
> +	 * Zone Append Size Limit is the value experessed in the units
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
> +	 */
> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
> +}
> +
> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)
> +{
> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;
> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));
> +
> +	if (ns->subsys->zasl)
> +		return ns->subsys->zasl < zasl ? false : true;
> +
> +	ns->subsys->zasl =3D zasl;
> +	return true;
> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
> Hmm... BIO based DM devices do not have this bitmap set since they do not=
 have a
> scheduler. So if one setup a dm-linear device on top of an SMR disk and e=
xport
> the DM device through fabric, then this check will fail to verify if
> conventional zones are present. There may be no other option than to do a=
 full
> report zones here if queue->seq_zones_wlock is NULL (meaning the queue is=
 for a
> stacked device).

If I'm not wrong each LLD does call the report zones at disk revalidation,
as we should be able to reuse it instead of repeating for each zbd ns
especially for static property:-

1. drivers/block/null_blk_zoned.c:-
    null_register_zoned_dev int
        ret =3D blk_revalidate_disk_zones(nullb->disk, NULL);
2. drivers/nvme/host/zns.c:-
    nvme_revalidate_zones
        ret =3D blk_revalidate_disk_zones(ns->disk, NULL);
3. drivers/scsi/sd_zbc.c:-
    sd_zbc_revalidate_zones
        ret =3D blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);

Calling report again is a duplication of the work consuming cpu cycles for
each zbd ns.

Unless something wrong we can get away with following prep patch with one
call in zns.c :-

From abceef7bfdf9b278c492c755bf5f242159ef51e5 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Fri, 11 Dec 2020 21:21:44 -0800
Subject: [PATCH V6 2/7] block: add nr_conv_zones and nr_seq_zones helpers

Add two request members that are needed to implement the NVMeOF ZBD
backend which exports a number of conventional zones and a number of
sequential zones so we don't have to repeat the work what
blk_revalidate_disk_zones() already does.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-sysfs.c      | 14 ++++++++++++++
 block/blk-zoned.c      |  9 +++++++++
 include/linux/blkdev.h | 13 +++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..f10cf45ae177 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -307,6 +307,16 @@ static ssize_t queue_nr_zones_show(struct
request_queue *q, char *page)
     return queue_var_show(blk_queue_nr_zones(q), page);
 }
 =

+static ssize_t queue_nr_conv_zones_show(struct request_queue *q, char
*page)
+{
+    return queue_var_show(blk_queue_nr_conv_zones(q), page);
+}
+
+static ssize_t queue_nr_seq_zones_show(struct request_queue *q, char *page)
+{
+    return queue_var_show(blk_queue_nr_seq_zones(q), page);
+}
+
 static ssize_t queue_max_open_zones_show(struct request_queue *q, char
*page)
 {
     return queue_var_show(queue_max_open_zones(q), page);
@@ -588,6 +598,8 @@ QUEUE_RO_ENTRY(queue_zone_append_max,
"zone_append_max_bytes");
 =

 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
+QUEUE_RO_ENTRY(queue_nr_conv_zones, "nr_conv_zones");
+QUEUE_RO_ENTRY(queue_nr_seq_zones, "nr_seq_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 =

@@ -642,6 +654,8 @@ static struct attribute *queue_attrs[] =3D {
     &queue_nonrot_entry.attr,
     &queue_zoned_entry.attr,
     &queue_nr_zones_entry.attr,
+    &queue_nr_conv_zones_entry.attr,
+    &queue_nr_seq_zones_entry.attr,
     &queue_max_open_zones_entry.attr,
     &queue_max_active_zones_entry.attr,
     &queue_nomerges_entry.attr,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6817a673e5ce..ea38c7928e41 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -390,6 +390,8 @@ struct blk_revalidate_zone_args {
     unsigned long    *conv_zones_bitmap;
     unsigned long    *seq_zones_wlock;
     unsigned int    nr_zones;
+    unsigned int    nr_conv_zones;
+    unsigned int    nr_seq_zones;
     sector_t    zone_sectors;
     sector_t    sector;
 };
@@ -449,6 +451,7 @@ static int blk_revalidate_zone_cb(struct blk_zone
*zone, unsigned int idx,
                 return -ENOMEM;
         }
         set_bit(idx, args->conv_zones_bitmap);
+        args->nr_conv_zones++;
         break;
     case BLK_ZONE_TYPE_SEQWRITE_REQ:
     case BLK_ZONE_TYPE_SEQWRITE_PREF:
@@ -458,6 +461,7 @@ static int blk_revalidate_zone_cb(struct blk_zone
*zone, unsigned int idx,
             if (!args->seq_zones_wlock)
                 return -ENOMEM;
         }
+        args->nr_seq_zones++;
         break;
     default:
         pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
@@ -489,6 +493,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
     struct request_queue *q =3D disk->queue;
     struct blk_revalidate_zone_args args =3D {
         .disk        =3D disk,
+        /* just for redability */
+        .nr_conv_zones    =3D 0,
+        .nr_seq_zones    =3D 0,
     };
     unsigned int noio_flag;
     int ret;
@@ -519,6 +526,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
     if (ret >=3D 0) {
         blk_queue_chunk_sectors(q, args.zone_sectors);
         q->nr_zones =3D args.nr_zones;
+        q->nr_conv_zones =3D args.nr_conv_zones;
+        q->nr_seq_zones =3D args.nr_seq_zones;
         swap(q->seq_zones_wlock, args.seq_zones_wlock);
         swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
         if (update_driver_data)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2bdaa7cacfa3..697ded01e049 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -526,6 +526,9 @@ struct request_queue {
     unsigned long        *seq_zones_wlock;
     unsigned int        max_open_zones;
     unsigned int        max_active_zones;
+    unsigned int        nr_conv_zones;
+    unsigned int        nr_seq_zones;
+
 #endif /* CONFIG_BLK_DEV_ZONED */
 =

     /*
@@ -726,6 +729,16 @@ static inline unsigned int
blk_queue_nr_zones(struct request_queue *q)
     return blk_queue_is_zoned(q) ? q->nr_zones : 0;
 }
 =

+static inline unsigned int blk_queue_nr_conv_zones(struct request_queue *q)
+{
+    return blk_queue_is_zoned(q) ? q->nr_conv_zones : 0;
+}
+
+static inline unsigned int blk_queue_nr_seq_zones(struct request_queue *q)
+{
+    return blk_queue_is_zoned(q) ? q->nr_seq_zones : 0;
+}
+
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
                          sector_t sector)
 {
-- =

2.22.1


>> +		pr_err("block devices with conventional zones are not supported.");
>> +		return false;
>> +	}
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
>> +	u16 status =3D 0;
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
>> +	entries[idx].zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
>> +	entries[idx].zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
>> +	entries[idx].wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
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
>> +	u64 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };
>> +	unsigned int nr_zones;
>> +	int reported_zones;
>> +	u16 status;
>> +
>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /
>> +			sizeof(struct nvme_zone_descriptor);
> This is a 64 bits division. This will not compile on 32-bits arch, no ? I=
.e.,
> you must use do_div64() here I think. Or just a bit shift since struct
> nvme_zone_descriptor is exactly 64B. Or have bufsize be a 32 bits. There =
is no
> need for that variable to be 64 bits.
I'll make it u32.
>> +
>> +	status =3D nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
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
> reported_zoned may be far less than the request nr_zones. So you may want=
 to
> recalculate bufsize before doing this to not copy garbage data into the r=
eply
> buffer. Another thing that needs verification is: don't you need to zero-=
oput
> the data.rz buffer with GFP_ZERO, for security ?
With __GFP_ZERO used (for data.rz) we need to use the entire buffer size
such
thatit will zerout the command buffer that we get from the host. If we only
use the updated buffer size function of the reported_zones then rest of
the buffer will not get zeroed.
>
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
>> +	enum req_opf op =3D REQ_OP_LAST;
>> +	u16 status =3D NVME_SC_SUCCESS;
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
>> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;
>> +
>> +	sect +=3D (total_len >> 9);
> This is incorrect: sect is the start sector of the append operation targe=
t zone.
> Adding to it the request size does not give the actual sector written on =
the
> backend. You need to get that from the completed BIO. And do not add the =
request
> size. The result is the first written sector, not the sector following th=
e last
> one written.
Yes, indeed it should be bio->bi_iter.bi_sector correct me if I'm wrong.
>> +	req->cqe->result.u64 =3D cpu_to_le64(nvmet_sect_to_lba(req->ns, sect));
>> +
>> +out_bio_put:
>> +	if (bio !=3D &req->b.inline_bio)
>> +		bio_put(bio);
>> +	nvmet_req_complete(req, status);
>> +}
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
