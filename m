Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC153C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yGiChdgbKvdvrBtPKWjDijdIoGy+tFBmFdU8yeoOgkM=; b=j1l3Mu1+2BkzuGvq6GHbpAjtkZ
	GfcT5hI0XdrBujYv6nLNBzT7SPX7CtOeqyTJeMLs5SleMlGaCB4+e9LhGBHV1prFyPPovGgBZGDtf
	MCe4520D6eR1j5W/Fz4swXWGSoC2sV+On1MH2CC4/DM58ftbsjy4L/JqqOaPi+I0+Y5z0R/kcBlgs
	37vh7/MjEkUdS5vGQrgYpvYc62FUg88eNpkcb6Q0ysRogPsMii7kHxjXELfZBPh6NAweSuMO1lL6h
	875eG7w0X0kcicQdojlcUAiL0zCNhs9ngFPP5KeE+V4GFx/QNMAa+Dh9TRhC1l8ezy2wLP24XDNKF
	dHVvoX0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFqCv-00000002lnx-1MXP;
	Fri, 16 May 2025 08:14:17 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFqCt-00000002lmH-0UmZ
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 08:14:16 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6u2BQ022138;
	Fri, 16 May 2025 08:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yGiChdgbKvdvrBtPKWjDijdIoGy+tFBmFdU8yeoOgkM=; b=
	W3j9bN/jjiqdjZr8uHua8zq/D9NtLKumHDH/gYspiAuxNclOCLAJpo3gqTu6zWSm
	/QJAzSU5KKnVoF3WS1GviJD20BnoraFMfpJnhYoIh7Jvk70jDGQE5Vq/NQk/8X++
	h1HiyM45sa6EYjk8HSZBR37RgauF1KlGc6Nml0Ucul/RKlx+sn7nNre04AcmO4P/
	xT0CT9bEYkeDU8/2a8gq1C8K0yl6GYxgu1XdsI/RImCRtlyPMcgDf8m5+BLew3wr
	il/wE/z/x+MpLzs1dy1aLKrF/8L5Q+LfSIP2Sd8VnI2siq/8Q0kQurFlHXsl08oY
	EFQLbkR6CO9aPg7HdmisMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbjrvre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:13:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G7jv61033308;
	Fri, 16 May 2025 08:13:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbsbk2ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opGb20eRy724xZrcQf/QGk4ywsHZSHpbgA77oR/BY7PF/VGUXkAvNEA6U6/Wdf72vECmK+XpJlD4IeOEST5kG/UKEzQKQLmMU2KWXvu1cp9jIHUOJskd3Ckz2MCq5GjUfALPfnXlWRx+8hLnM4JxJzCNF4QA1A7p8/CQitGIUg+v/nCNQh2U0InofTIrk9Sa5Ie34BTpCenLxkz/TXKuYNkZpcEvTxNvBcLyECU3jmxVUGqBBdzrWiKjJ2IhGEgP7/afJEmZ8CwxCJ4+W8XyVh3T7cFCE1eoZ6+G/EPPYtW27NlMk6XWleyDavvvTIplJhwM4/E4MVkWfhzxLZnHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGiChdgbKvdvrBtPKWjDijdIoGy+tFBmFdU8yeoOgkM=;
 b=MME0/XRuZzbwEhyi/Kv9CBCVu91RKqrJHI2zzbLfxTBDtpPVBxEkIQ7Kcu4+NgMjQrEwWapXNN1Ivmo6Hz+FOZqeW8XKSTKqTQypGukHDubV1lTqD59mjC7jU90FLgDIZZaLwRNClZwUZnU5B+fCwBlP+2JSMI0AieYrk6PSu+0TWU84SH9g7XjuLL5uHNe9xzwAKA7hGa1BwH/zhZCNae0CZ+zf8jmXIxz50o/dbMx1+vfRwmfatz/BpjVYg1jrbxveS73WaJ7QQYL47o6RAWHNTSOuA824vTxDGt5R3H4VOWFFReJouvo0bqE04vkInvJOTMsabQ8GfHx6kFgJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGiChdgbKvdvrBtPKWjDijdIoGy+tFBmFdU8yeoOgkM=;
 b=o4dz46rZl56q8d4ZTnDWRGew/czOCLA35oh8Vk2rB7fJ6vOKCp3bH2EWSdl41WulU1KnJgQGQ+/gRl/bSffLH46FqywwY3ylN/8ozkDo0/h0rAdnMh9t7qJglevjRbdcQgePQmLqVzcCmlmeSyVF2ZgmcxuNFoo0sXzIj8XJRPQ=
Received: from CO1PR10MB5505.namprd10.prod.outlook.com (2603:10b6:303:160::17)
 by DS7PR10MB5101.namprd10.prod.outlook.com (2603:10b6:5:3b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 08:13:45 +0000
Received: from CO1PR10MB5505.namprd10.prod.outlook.com
 ([fe80::6f07:e5f2:9b4b:75f0]) by CO1PR10MB5505.namprd10.prod.outlook.com
 ([fe80::6f07:e5f2:9b4b:75f0%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:13:44 +0000
From: Shminderjit Singh <shminderjit.singh@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: RE: [External] : Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung
 PM173X with Subsystem Vendor id:0x108e
Thread-Topic: [External] : Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung
 PM173X with Subsystem Vendor id:0x108e
Thread-Index: AQHbxiwZPVUxVm00HUyKOHhM9mH4CLPUzWEAgAAIMNCAAALAgIAAAKQA
Date: Fri, 16 May 2025 08:13:44 +0000
Message-ID: <CO1PR10MB55059D6FEE48CD8448E6C78E8393A@CO1PR10MB5505.namprd10.prod.outlook.com>
References: <20250516063059.3456399-1-shminderjit.singh@oracle.com>
 <20250516063059.3456399-2-shminderjit.singh@oracle.com>
 <20250516063632.GA14830@lst.de>
 <CO1PR10MB550564E355727779E441B7558393A@CO1PR10MB5505.namprd10.prod.outlook.com>
 <20250516071541.GA15458@lst.de>
In-Reply-To: <20250516071541.GA15458@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB5505:EE_|DS7PR10MB5101:EE_
x-ms-office365-filtering-correlation-id: 1be14bae-c2e6-45fe-ebd0-08dd945193a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dzwybig7QxwY55yG8eD2cdvGB89jxh0815xdN/hdf9O0ZTl2WOJvzfWDORW+?=
 =?us-ascii?Q?IY1wtCEviHj06fhQ9yGYyaadH0HNl2Urr5AS9h+2hFGblxVjzbp5Hu3/vIhz?=
 =?us-ascii?Q?QczeiDBgIfqMh2IytrgIrzSnJ2MGJ2awF5gEXzOZwhPIWhRlCRzFvg+vHUqT?=
 =?us-ascii?Q?Q5Ev+FYvSZPVJWPvH62ow1/s4S4qu58bW8JaNc2tvQVOMQP26TQMsMCneZoE?=
 =?us-ascii?Q?1N4mhvq5ty2ooz8fZCGZs2QgtaEOyTM3S6yAkLkZ67NF8ZV8tb/ydLxbjNpO?=
 =?us-ascii?Q?UlAnb7rFZC8Nno9aJCegROdOCiHAZGieVz+liN6F9S7m7MeWw1Uw2XbeEE0S?=
 =?us-ascii?Q?hogX1CQZfasqSyNSJ4gM9ZA3dSwvjPPB3Z3x6t6u4eBnrop0iG6irC8zmOCa?=
 =?us-ascii?Q?3CmC7o/V0pYCXSELJSjNY7AkyKZ459Zh7WsA3xakceHQ/sxZesJBa3cnvzdS?=
 =?us-ascii?Q?vxvo9JhVbKu3dv1AOcq0gta4kvdUbGj0sXjRU5UWE5GPaowup9nhoSVsmFZA?=
 =?us-ascii?Q?RrkpWIR8Eon8DcRIhzPB94en4JwroUP7rZFw3hIvdwCeJ1OvBzwyjAad/+c/?=
 =?us-ascii?Q?FRdgGCFP46gxymMmlka3PCG4vH4yvu3i/EGDVF6ZCGI5j/Cbn6t/lYdon/UY?=
 =?us-ascii?Q?531OBUwLsI5qoFkKKbowqV5AePOxH8NHz2n/4jPIZWmM66/fIhxBlkcJz7Nt?=
 =?us-ascii?Q?VIIzYRdzTMBzl6AuwG3V0pRAt/oWp2O81as0al2YUprSX6I06yC5T7XBusyb?=
 =?us-ascii?Q?JKqpl4yGZN600hguUmrmS4JUhzkjnG854FfdtzQH/G6HELM1Zmjm3EtAZPdN?=
 =?us-ascii?Q?GWhe6WoX1e71ums9DBRr6D6E6PhTkzJqMvSHX8mL+QrqYaeaP7vgUkImRGTM?=
 =?us-ascii?Q?bIghWeAE3/Q3KjhvKbzYAFV3rEvF1qJ25zRY21zt8QohOf2gCBB6pUCkssZI?=
 =?us-ascii?Q?GS5eXt1GVL2VBCplQ7cM3tBp4B1rncth+5WFZo38/ZgWl9j5KrZrwzr5BaV+?=
 =?us-ascii?Q?Lbh4JmdGkki0Cq8f/yVAaLo5Oxh8SOece+v4HHhKaFa4Nqz0hiMwSjAgsh3H?=
 =?us-ascii?Q?U1QwpGl2u0R5AjHJRKZrHhwu96uHTZqxZnZvbsDSxO0IUpspOVhMUVD43Y7N?=
 =?us-ascii?Q?VMo6ThMFrv9meZrXjIw/MgfzPTqD3kzoI/7E64vunlux4NG2VwfjFzsT4jiT?=
 =?us-ascii?Q?ssRHZaLCs2nTFL/oWv+sOFpxYPRqwtIOaBLIdAfdl9f1komcvhjeeuQqVXO6?=
 =?us-ascii?Q?qwsHi59MbHz6scWu29XX7GjrIQF9nfVxJ+otmiONZUSS4tC3fLGBrbNKRpes?=
 =?us-ascii?Q?PMwo9K4OeSZ02E0SQgGrdHHjYkoEOlpyn6JHGfwjkj+tpuXIgsO0DiOlMELb?=
 =?us-ascii?Q?pdpHKNYYRiG/NydeDT3f4E1sDNTeoZiIjYCY6wzOr2zZL2sEF16Xc/1/RPFm?=
 =?us-ascii?Q?2L8qJTl9UYMe8pVcVirWKm9YKwrx7R+RR2KtRPdbpgJdm53+Tm6/jjumhYYm?=
 =?us-ascii?Q?jVP1trR2wIwcTco=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IawSlM+jO7gfZCWeiKUjI8HsuJT6wQVBaj0abVoLR12G5JH6B1fbN32VxqHY?=
 =?us-ascii?Q?0iMyLV8gtpRqxeM2ubINLQ/K85P8K+z7u9OZmnRRzNeYH8kiu1E4fZUK15r2?=
 =?us-ascii?Q?UHdDP7ytUnt7HSpZoUr+IjNHIouJbJnLIAsmV0n+ULoNsaua9GdXKXswttF7?=
 =?us-ascii?Q?P32oE27bTm4yxFnszxkZHQ/CJQ5/nbVBu4UEzKrL8SS55dQJAWaorEpmd/Fy?=
 =?us-ascii?Q?SW/PRXAlMYOT6EtAXcXOfJitQW2iG8RalGXBbzpRUlUnTNW0Crnp4ZjHBOYh?=
 =?us-ascii?Q?wQ+x90BLM5M4UGU+3HRWLXKGrfOKEY83kEZJrVxyqqqnEIVM6UbcZu9s0uPY?=
 =?us-ascii?Q?CTcUUV1Rk1dRlWeZxZS2jtNwPdqF1689do8uXCxpkjvvoCMlPSQE6ToCHBr8?=
 =?us-ascii?Q?AiMrtSKo0yck2HuRCnsjaRhVKFp/JpFOCQeWjK8tuLUXaO8wkg+wXBkG4rG4?=
 =?us-ascii?Q?ckDvtSfGVc0w6SHu8x43RE/UMIotcvAb+INl1YmFC/36j0m77Bv2LdVAlhkH?=
 =?us-ascii?Q?qPX2UMtxQfhZ64/zj+Iz5oX3Hry4TJCY/NZm8B5olfZPSujfv3mJQeGSdTOf?=
 =?us-ascii?Q?jP9F30F3RfJjT8sYABCvmvBS1AACFfXvCUiLfcV5za2M23LsM2n2KErp/jhm?=
 =?us-ascii?Q?sfAUDfl+MXefkJ3LRg7tJ9mNhRbE135mY6fuxjr+mAGZ3tfRkm0KZGhoyIvs?=
 =?us-ascii?Q?FwuaGVSkUYxh3OlYIBmFszVXlpY5hX6BEepYKo4IFqmW+3j1hIFP3F9mAKGy?=
 =?us-ascii?Q?OMwsphSM+FWf02t41IbNbxvc+BCyR+ibH+IjttzNb19GM7nXKhUq+Kyupvyn?=
 =?us-ascii?Q?9+Ara3UWz6LJs0/+62N8nwx8oX4LsB/aSIQdu//WPbyIF/2xfpgYrxuOkceJ?=
 =?us-ascii?Q?73VlIHjuiluGfKHcFG7Py8aOf1FgM4vYjBr3mjb7ZbCeJvsVJNrNJ0y/EbSE?=
 =?us-ascii?Q?oIOuKrZ6rnnMMUHCZhyRBQ6nzWuuvDnUDaH9kAvhh5qdmdFgEJJHZ0bE8872?=
 =?us-ascii?Q?UisLVT8bNZ+UsBL8WAIYJ9pvX0YVJh+hT+Pei4icr+BZqzjJJF9yai+k38c1?=
 =?us-ascii?Q?WPC0T52tozESOFjtr0rsYrNO4Yb0mpVvWu2CwLoLzX9aY/+3LPQfdxrwrwCA?=
 =?us-ascii?Q?8yM+I2S26jWPvCI7vGiZv1VlT1qYw1FQ+Z/NGtRAffGGu0Aj6OacwoAnsQNg?=
 =?us-ascii?Q?CZ1Pe9izDvc4eToaHwJCy3fYgyNxW9oIKpsC8g0creR5TsUMOcpmh98GXgqX?=
 =?us-ascii?Q?hJFjEOe94QjUDKstzJTaVPaKdy8lvjTgCn53w7GNQMuWYNp8hAu8cryiVNC+?=
 =?us-ascii?Q?l/V3MIXlPDCRbvzNm8ayXtecjcVb9Ai+hvN0GfRnDZRGINDwIhAaR5sN00qH?=
 =?us-ascii?Q?dAVg+E/P919qBX/W3fX+RC1TiPxxVuv7axLC+XnC+ovpdpZi0O5qg3l/Dh6G?=
 =?us-ascii?Q?qInU7WKFKbwelFcGShlnMKS2FXQ/DOkt6NWql16JyiUUtF8v5gBknfUMpCFu?=
 =?us-ascii?Q?bhGikGez3qLme+nHF2b4X7CmknUHoRNVqYuzErLGO+GqoBfBwwe4EETzxKSw?=
 =?us-ascii?Q?fkiLSY7QOoMZetb4xUDinJebpy+BjWoxJB1AQgEJiCqByDQx4SPVYdyKP6Th?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mxAf5QEBrJctJYtNLTdoSkVfWVxjjG3rEEsIUVENe6azYDG+d/P6OYQGmXKEbaPT6CGKtfCUQ6nPL4fmN1hQ/hu+LhuoIja1tZPA4iVrvlNnHkbtXq5TYOtvvt9NJXpI9VtBK59zh88TKJLNj25LwTTXC3+yZm3Iwu4chdnOWbAaU2x2+1+lIM1bwH1S2tf0oS3R0xPD34zU1ONrputSus+OazzxFmGSszGivNgU6PaGrDXS4ocv4CVcuHXZbXdXVrXCjY8FcAKFDLqN0cAdeILRGJ1VqK/vaRnS5CMlNOa6e/q0WqmZ2XEnUk0V/3LE+Dsy5bripG551FyIqH0dQTwXRtL3LaBlcwgd+xMDCFYqsG0ScTBp4a0YpT2tI2nooBcnmSDkWQoIIuFjc4zPa6IqucLtyZEkSnNAbOVE3ImZ2VelZsnfTqitTmozdNBlmtR8bX7oG6LpK8S46pLRcp1bbwxHw9Po8i6Vr6a1kosDj1W+8PYJsSLB5avWKcdSyv/auQB1rftQZI1Ev74/OyhyPgWtEuYp0stc4JLB9x7L5bZYLR0DqjldXMrRwW2rqkWvpIMsJcxVsyRolC/BP3XQRxM1yAxXJEfbDUUhzek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be14bae-c2e6-45fe-ebd0-08dd945193a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:13:44.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEh59NoH+mozMln+ngrHLrliNNglamSn9AqvO58/cJUpfPQzS6DzseIxYqi1bRDqMo62rvh2h/yvoQNP1dsBZrIcUFkxpnuy5aJxq57q1c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160076
X-Proofpoint-ORIG-GUID: Pc5L1eEKrpxDOn6gT5m-2R63yZc56_ug
X-Proofpoint-GUID: Pc5L1eEKrpxDOn6gT5m-2R63yZc56_ug
X-Authority-Analysis: v=2.4 cv=aYxhnQot c=1 sm=1 tr=0 ts=6826f3c3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=NwkyZCofpBYv3vRvoQIA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3NiBTYWx0ZWRfX0iUpC3HG9VTv i/XNrnlJFwioBem610CirbSDurlp9+Fk0XHi+viYT7FnD9os6adZdwQPUrghewLFd1aCEPQ6uHf skeTpc7qbTVZRzTqGdwkVqHRrqfMXJmABozKDGs1mvg9H0+HavElIQrGeyziflL7M1oP7BWzLoi
 CqMUmf5nzB0U6Ig6uJ7b0Nkw6yNfKG4afZG+ql/IHOrAD+2wunnIMZ4W7P6J3W2tllIt6NPa/d5 dtpz9qvlaMbLiHxUmNc/lnVkAfveHbJALmsL9RwJBZik8Pcn9BmJeYRwe/aNTTGt5ACmxHSPYmk hem7oWgpawFcXZvhMsRDjO/RMqIsX+HMYhjBNw0LUYuQAESBdiZDchsk3Z0nSA6x/OON8M/NXKo
 eoRxWRCcKFAwqSW54MLG40EozYD1JzDAyzNEvhzOlvF4/oKW55MJZg/nK42F5uCl2ite6Ey5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_011415_183345_FF712110 
X-CRM114-Status: GOOD (  22.24  )
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

Hi Christoph,

Please find below an explanation on the bug:

This firmware bug start messing with the systems when in lvm.conf file the =
default value of use_devicesfile was set to 1. Its default value was used t=
o be 0.=20
Conditions required for the issue to occur:
1. The system is configured for dual boot.
2. The use_devicesfiles value in /etc/lvm.conf should be 1 by default or it=
 should be set to 1 when during initial system setup.
3. An NvME device with firmware which has this bug.
4. The two kernels in the dual boot setup must differ in handling the nvme =
quirks, one kernel must have NVME_QUIRK_BOGUS_NSID set for this Samsung PM1=
73X device and the other one should not.

Behavior:
When 1st booted in kernel which doesn't have this NVME_QUIRK_BOGUS_NSID qui=
rk set. The system has root volume and other partitions configured on the S=
amsung NvME device, and the corresponding devices entries are created in /e=
tc/lvm/device/devicesfile based on the EUID. The entries made in this file =
limits the visibility of the lvm devices. These euids are unique and are re=
quested directly from the devic.
After configuring the setup, system is rebooted into 2nd kernel, which has =
NVME_QUIRK_BOGUS_NSID quirk set. When quirk is set the nvme driver generate=
 an euid instead of requesting them from the device, this euId is of the fo=
rmat of nvme-<vendor id>-<serial no in hex>-<model no. in hex>-<namespace i=
d>.  And since use_devicesfile is set, the lvm relies on entries made in /e=
tc/lvm/device/devicesfile. But due to mismatch in euid formats between the =
two kernels,  lvm fails to identify the device, as a result, any volume res=
iding on this device become invisible, causing the boot to fail since no ro=
ot volume available.

The failure works the other way around also, i.e., if system is configured =
with kernel with NVME_QUIRK_BOGUS_NSID quirk set and then booted into the k=
ernel with NVME_QUIRK_BOGUS_NSID quirk not set. This mismatch in getting th=
e id leads to volume not visible.

So, the issue is inconsistency in EUID between two kernels and without both=
 kernel having same quirk set or unset the volumes will remain invisible in=
 one of the kernels.

Thanks,
Shminder

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, May 16, 2025 12:46 PM
> To: Shminderjit Singh <shminderjit.singh@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>; kbusch@kernel.org; axboe@fb.com;
> sagi@grimberg.me; linux-nvme@lists.infradead.org; Junxiao Bi
> <junxiao.bi@oracle.com>
> Subject: [External] : Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung
> PM173X with Subsystem Vendor id:0x108e
>=20
> On Fri, May 16, 2025 at 07:13:47AM +0000, Shminderjit Singh wrote:
> > Hi Christoph,
> >
> > This device is widely used both within and outside the organization. Ap=
plying
> a firmware fix is not viable option. Since this is firmware specific bug,=
 I am
> adding a flag for OEM specific devices only.
>=20
> The general rule is that for enterprise devices we expect you to fix firm=
ware
> bugs in firmware.  And skipping all IDs suddently for an old device also =
seems
> like a really odd bug report that you did not even manage to explain.


