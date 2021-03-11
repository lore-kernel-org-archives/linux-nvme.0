Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22833C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:43:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818E164FA1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818E164FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RdUFn1ByTeoyut04a/AO8fPtWgSNFhScnOv7noHw+7M=; b=LBDZpNa8uISbJdvDurnMcGnVq
	wDXDGZrXonWJ13Q4JCLHL8dxtxW7temJJzVFPc48DcinH2RtVhzzxVKytOfT2lLc/I/95C41HBVJn
	4rbfa28diQmLGTfYMoQwjpkCZJU2u1VTWse/GS69P/FqFadaKjYwjIjVaqkS6diHul9c8P0wr5GRf
	fV5Ao2SyMNL4yovClTUenz/90ubI5xV6DwpVZZSWRQQJQLk1RlSkVnr2H4xHNRWwpelvxrg19yUHn
	2Dwvm6pWEr/k5HyjFhunR7gZTmk16QTlfJ0/E6Tx17HAme1o0DXEMUxqNylhX9TU3qwpJX830nYYs
	/dN8rqd4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKDAN-008MKQ-Pe; Thu, 11 Mar 2021 04:43:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDAG-008MJH-4s
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 04:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615437792; x=1646973792;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=T/6LJ89/5rsAQjH/X4owBP7InETbGEW0P9vs3/em19o=;
 b=G4RaohtjihNQa4p7oHOwUR535vzidN3CU5pM3JZDGUXkuG2tjr3nHg3P
 27ztk0hojyvBR3EmzFIGIbY+QSBzUThGqlLgv/ceEYhCj8GlJLzNP15ci
 RtuJjinMzGWNYrZPBMhGqOFvhB1F47xvFeW2FqqIF03n7EcftFdH8QKJl
 LKiF3AzmNGshbkfT9apNraaIoujxNwwnYImM4GHSA3vqhTuGUUDmtHZP9
 7FD2YJUTYVS3hEPkqQK2iBRoPIv4ZmWYy3tzOV5BKLMGz/vrFmJGh7BD8
 hm5XGKkiEP8J+oRd/BLRFv0adYaGx5eEvsJQ9+46uSf4tGWfihNfN82DD A==;
IronPort-SDR: UK9D+ULPKktzckupDSplWwDtExibr76qRY4xRIVgo4ZS3kEZdoR+NqpCclpO6lrD0fjWbl9aXu
 nnm36YnzbSH2NePRZ3ki+FfWfp0OjgXRFFVkqZ7/N14CRejwlcbz6PPcc5FKwsOEeyGS8C0mM1
 qW7Gzr9SPULVetFgUpUbn0v7Q0q671Rr9YzfaUOG3BN/4khuGwRmrQ2mGgNfMWrl0/dkHyM1aa
 uVu89D2iOQRImL13hBORvieulZv0g1Orb+LnUd3MRQe5qen3psZDC4s4GbbCAayi+ntMTFw8ZW
 yRc=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="163040564"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 12:43:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcWBS381qYX22XN7YAj99sS8eGG9O0hBJGSEDZA4c5bSYQZLpLLhplMQHN/it+Ao+lprxk0tZtsE3nLek/nZsSH3T4u9oquw70wmUTQZabJEkcjjGIU1qJ9gSAD4HDftRDuDQriqWNWAsZturwzOI27YYGDziKJha0ucltb2OPhQuhPytVENIKWi2BFa4C8y1trruT2A2Az+keNkFX8B1GEZai2djOXkIMAFzhYEL8qf/SqTk2UQiCs/5NQ5SQN0G1n24lBrB40z/vhTzWvr/39VsZTmUnjUIgmkYqdSVLFaRahMs5cQR23dYpKmNg2rLdSYSRBP25vxx4FXYy03aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/6LJ89/5rsAQjH/X4owBP7InETbGEW0P9vs3/em19o=;
 b=PBgu2tvsZPI2V3Ku8OcvXsGtkODY35XmdcMlQqltMIQgw5+OCt/8P/5QQY73Vzy9CKAr3fQESU1lIfzz+G1xeCC5R6C2P8TMtP5rXJzTi0WrnYzdcde3mvcBlkSmf02hO8F6Oh2ljZmGx3F+CbwHuU4MInMt4QHd/nG2aWLyPml1gTVDnobohnPhKpTtzWaysKZm/MhDnnm08ENr/jGUMk34k5z61ybwxAnIsEB93fXiyIOlFDasc6Ou/wKJeqT8m3aSTUHIgbUYUrMfeuqWezxWPBreOZzO2lKaulBp7qYgjodjVhijmLG1oJSaz2W2x0Be704G72wuRgF7VSIpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/6LJ89/5rsAQjH/X4owBP7InETbGEW0P9vs3/em19o=;
 b=hCjwui7zdUKN0eamE4RxiIafqmeNBu9comtwdkI1gY8icb/+0l6fEfurPx0dLMlyDfEP+VImh2LNBMWK+6RCViNtxv4lswmNf5YeYh86OMqShdHRMcNJDOJt0zb9zl+afgi0ppP7xjrWiaGGZo3tCF7+8gc4GMK6xNmwX0StNgQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 04:43:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 04:43:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Tony Asleson <tasleson@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Tomas
 Bzatek <tbzatek@redhat.com>
Subject: Re: libnvme questions
Thread-Topic: libnvme questions
Thread-Index: AQHXEJkDKinop2xAF0e5sqK7JXt5sg==
Date: Thu, 11 Mar 2021 04:43:01 +0000
Message-ID: <BYAPR04MB49654A2227C054ACC903E2ED86909@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0e1a329-34c5-4746-d319-08d8e448272a
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104E1238423D00EB2EE79FA86909@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONbxCYk8Omv6CuoSNNkoS1GCF/54TDChKVGsoTNxmBRkuoqo5/jxyDyD+jqLWaandX8LEoY2LeKZNjj6YN4ji4j9Kpjk/qG0yaSnhZOGd5MT7NPg3Tp7gHdUHS8Fh5nb6fFLVJldFXvKuvtjNjjrZvqARBzK3HNNAkd4ADcVaOY/r55+qLMt25/ov4qQEBFMKxGG0ezg6eaL4SN3wyVUlNXP6zPDNaCiIWl9Wf0+2HufhAXomv/rkMAmyww09dw1pHawkgbwzigAvOmKtfupehQ2a+pfQrFAVxx1zqKBUas2Se5P+PMTt1HCu6TRoKSDAeuaMx2ont1wP7qCzHV8t+hOuVskR33Icy32atL5mSQXAtq3CvcvQDT7twn1YqR4hyq75r+wiwLo1mP6ww2Quv7pJYdWANkUOhZLluBSUkvNTnKzk4cvcTeHy2Lg+ObkFXbqoZbvNaYc9OxA1KKsOC7OUfnUiOugeIfHhsioSU0HerPE0im6cgnuYIYvU7dKsjgvyn/ZrBbaTHI7Wbz4aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66446008)(71200400001)(7116003)(55016002)(4744005)(2906002)(66476007)(478600001)(33656002)(110136005)(3480700007)(64756008)(4326008)(8676002)(54906003)(66556008)(86362001)(52536014)(6506007)(83380400001)(316002)(66946007)(26005)(5660300002)(7696005)(9686003)(186003)(53546011)(76116006)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?loXlbDTD3jOdp3ThjRS1ofLNcdLDdhQ8Xb+emLqd9qVxvxnCuIcdEFKFZiAl?=
 =?us-ascii?Q?9mJ27708m20LsStGUkNVCYMA6wo2srSB9so68BrOyZGQ/BTDoZVpGwHQkqzp?=
 =?us-ascii?Q?GPZvQruK9kKzO4l8FEGJUmKCBK+Spy9AVcygYjDInhEZvx40SFe71fNJj0aC?=
 =?us-ascii?Q?2QCOen93vWisn8MHptsPCrQORNvln0u+Z56YterB7g1O7/uPv//UBrOUvt0F?=
 =?us-ascii?Q?8UBtdAv70kiZJXJ2riH4lKDegqzuALsN8cmdn3WkiLnA/MUoL1H9ex1qRVVM?=
 =?us-ascii?Q?ZQkTcmUmsrQhoDyxc2MyqWDANvO9YZzsTjImwybhCI4SEml/if8BzXRQUFHQ?=
 =?us-ascii?Q?ij3Gn4DaaxcLc2cX5kSDG5gkyISpquQiQRa5+t0I7mT4Ida629SHiwqBekK9?=
 =?us-ascii?Q?b0B2swgq738GhDppS04dQEm5eSN/cSb7ae9eh9nVnhX3RNCOZnq74Xccs+R4?=
 =?us-ascii?Q?fqISlcuzl7pWnrhn1Vj1Xdh2dYXQ6EoLbLsX8buE+ULoaVJ2rAnnkpJ4hBxk?=
 =?us-ascii?Q?swVxVV1tpnJc3hxWUmjBP4zMqhW0Hr+FgoLP8itKFvKnQ11ycrslmUgAbNUG?=
 =?us-ascii?Q?id4wfkpVd1W/iEvAfh7jN2J6Lyp+ElrDSV1J4UfRn8HXMc9jsDWcRxIe+ehh?=
 =?us-ascii?Q?m9JwRVdyeQ+ljSeuIfR5jrCGXa9jjjJRiq3K8QVrr++b5ap00ptCwghb8/RA?=
 =?us-ascii?Q?UiYQj1m+bYn6eoYPJ5I+lSkrR7u86hF025j2fjjOuOjJlWr7LF5lbCayNtsz?=
 =?us-ascii?Q?OiigkNgsBJRmjIckbXgaBNtNcGP20ql6+iZ0OclTsrVocx1PXI0on5rUzWis?=
 =?us-ascii?Q?WDwk/GNT4KsNI93GlR1I549gERvgjRv/dGd7gzHLQzCDYFU9wHNI4iplG2tR?=
 =?us-ascii?Q?VIX/rfy4sKCwN+hujpgi3/p4z8+MT2sJAKCZuzOL1n2VePb0jjeo8WiOlUeT?=
 =?us-ascii?Q?e1kV6aSEQkrfbgbOleVnGGr6FpuqqQUFBkYA/V6IM6flm0x1hmwsZWV5pUd2?=
 =?us-ascii?Q?NhweKyNqmZcLxAdoIJda5XZx+urKJaG4e/PiGAYAUKJ0D8Ty38z9V6kmSJgB?=
 =?us-ascii?Q?VtdsY8NTdVPJflIlSlDoPobOF3FcxKtXPNr4z41LDNlSdIvZ712FSJs3PX0D?=
 =?us-ascii?Q?CNP4F8dLn1EtoeurK3/R3ZRJe4PU+/i4KMU5bTSX6IYlXCw6ypXkGZTWH0Hz?=
 =?us-ascii?Q?yRgOUxbGfNhagQL9BXv04s2JWayK7suFO4gN5smVu7g88NsPpcSSieXYMT0u?=
 =?us-ascii?Q?FnkUZckPgfg4o1Rky0nr/b1glWnokAgmfngwJi7IAo54Zsse3dpBCUgKzakW?=
 =?us-ascii?Q?/XLH8/Z3AFweJq2cNv05w0OA?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1a329-34c5-4746-d319-08d8e448272a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 04:43:01.7132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP7gV/o0JmJd1YxPdJh4cRgnQc724IORjcsHhrl/ybZ9sno4Kx+LWxCOQpvpUwk9KAT6Se0x3lbyjm4pwEmmv3q44+SwzLqEws+Xpn6oicc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_044312_582457_9DB8D432 
X-CRM114-Status: GOOD (  10.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,

On 3/10/21 12:56, Keith Busch wrote:
>> 3. Any plans on adding functionality for NVMe management interfaces to
>> the library, e.g. NVMe Enclosures?
> Will be happen to incorporate any features that are in-spec.
>

Adding MI support is good idea ? I think it will bloat the basic
functionality.

Can we consider adding MI plug-in for it ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
