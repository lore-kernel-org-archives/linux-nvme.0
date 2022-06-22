Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C16C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYuzbXj0pKdeNiXuCJ+3x67yhmq5AfBSInyiXOMrExQ=; b=eTdHMWQgGQ476+uVtZRpHP9wHQ
	mZEp9/BksKssRzV1+Hj07afxcdHLD3Adkf7upQg75sxeZfcO8bFOrad/J1fvU9PlMmBw6tMDDr0GO
	pjybRVGji4am17CLgkLP/5642XrtZPCmsNnQ2zW33YQ+48EMi5MVAMY/oux8N61FsNzy5JTsWkhXx
	jm+jc+K1rZAwa9OxIR0OwP499WVSo/wJ44ObWXBWY+7f3a++qcFuu7Vgpk5UT6MqYQ22o23ITHuM8
	Jl9teMPRNclAaiVIg+uB5jCOUIAicvxeDb7xnwtJQXAKj5g1sQh6KeLXLUON88oWXugvmw1+kz2he
	f/J6SYQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Yg-00BF0N-NA; Wed, 22 Jun 2022 15:46:22 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Ya-00BEyx-ES
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 15:46:18 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFeCZ9004680;
	Wed, 22 Jun 2022 15:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZYuzbXj0pKdeNiXuCJ+3x67yhmq5AfBSInyiXOMrExQ=;
 b=UTOLRVd1fJFCrPuRU3mh4191Zp4m4gizO00d+eayULkzRfOZtMcrkpde7ZH7NXmzbW5w
 5Jenwd2N2G5I21E+r4LoN/xhmyG6WMB+TmegDpEFvCw6iQqOcwovkiLVdpYwFS0ndbJZ
 /sZhCmPFeCS7O5aIzDJboqMFtPRiKTBliXMbYbJI4Gutn5Mrv+fM5emmu7uJ6uf7KpoI
 uyZeUCXDBT8RHLIEapAaQbO5wBnXEHKeAjn5LyJ7hO7U/WoHVnV4xxI3Ofzc0CMsTEF+
 ovA6Ay87br23GXIcLwFDw8/JwR/97l7EgQasVSFqfHkA46aRQVl+myKfiAOAmXTCsJ+0 Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54crsy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 15:45:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MFUp3h025186;
	Wed, 22 Jun 2022 15:45:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3whhgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 15:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYjo9bf6hDaAYnydwuJE2Fr9dn9VZKEUU/0wtjzo3Ub9FT5NxDDjpwdlpluPlfBIs0Ct6D/NMe9RgFDVb9cJse+XMsj1ULij9zxe4mALdbDJ983mCXH1tzrVLrKRaDbhaXsZWWzdX9HviqfvE1iUIhOs2XMeVR5XKowVIQ486AyyXquTxa05/QtpniX954M5rBykuWuU8DsngFZI4lqsHGfLQeHe+OZ0dF4kuGCnmBlfP4cq+w862PNoh//vikU16QY4+g1h6q2M24cJKp1JwGwNlfl5bjVxV1YqI0AB+fGDxQzaqR6bCmABw28P9QEWJTgPfB/wyIUATVlaGSKODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYuzbXj0pKdeNiXuCJ+3x67yhmq5AfBSInyiXOMrExQ=;
 b=LmcAkakeaxzAWzSG2STHNFvgszLFOkGuM32AG9Co0EbuEvXynzDWcM26FqP7ukuuXAu+mJKsatvbegM/YlyYsvOWQgWjTqaLyvbvEjPg4TMSaLiZjL4DelvbWptxkUKuLIqUfR9sANImBaSJ07fiecyDn8Dx734ssn/aNMhEz/c6gm9VYcLvoUegnS7PeGNS7uk6CtYHCQ8QzKt1Wka7KjApsgt85NXL0c2GX8n+TBCK4hGRvgnr1El8gTSv6bQnxFTSoSNmqp26X4KF5XdBU1aZv0VOVqFXPdIK21MfL7Rlhw76whka3ObniUqiw/28vQ4Gkf06QMDjFVx+qVMFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYuzbXj0pKdeNiXuCJ+3x67yhmq5AfBSInyiXOMrExQ=;
 b=OSsNgm2XhXJqeCttao/IadkdrfiFQZXXoELKPKkfALNB3xi4uFVCPVDV6DeB6W2dgMK3GPQg1cULhTquORbSTNVpFN1j4ZSPLt7P5/6MnfzZ7WhHZ4k0cMoIm1N6rkLFM747MmXSfmkODcWGNhbLZiakMCzbaDZk9ZAawLWnk0E=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM6PR10MB2780.namprd10.prod.outlook.com (2603:10b6:5:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 15:45:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6%4]) with mapi id 15.20.5353.021; Wed, 22 Jun 2022
 15:45:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gIAADwUAgACTr4CAAVjIAIAA5nIAgAhBGoCAAmhFAIAG61AAgAAImYCAAQkrgIAAT7MA
Date: Wed, 22 Jun 2022 15:45:53 +0000
Message-ID: <DA4CBACD-8455-46CE-BB4F-8D2350BCFDF1@oracle.com>
References: <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
 <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
 <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com>
 <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
 <20220617090100.GA7767@lst.de>
 <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com>
 <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
 <20220622110037.GA27411@lst.de>
In-Reply-To: <20220622110037.GA27411@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b19c48-9708-4c5b-cbb5-08da54664a3e
x-ms-traffictypediagnostic: DM6PR10MB2780:EE_
x-microsoft-antispam-prvs:  <DM6PR10MB2780749929A536DA6061527FF4B29@DM6PR10MB2780.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  rHqgLzC2dKrjlfLf2Xw58qQU/rdhohbG8V52EIQJ9LH1Jrltn9N8X+xhnBoGcYbF0cGuq39MSkN32RFBv0v4VT1Vv6i6Hw/oAlhBCSvo1XJXIKgEBaN6+eTz2AHnSocpAFiX1y2mBu+FSXPDKfRBXMraW0su3NY5ywP/SM5PTBZ/xWvPHfy1seIGixOwSWNqM+z2mXRUwObfJjrWBfvW5EOuqhBtMpj8JpwosRt825bEdggyPqK/JJ0JnJC4VzARTQ78MrCAZMTSFm/TSygJacQ0/amKCQFhlxrU7d6E/d2Gzq9B8tXW0wPmy+T72hzvtEfiJ8SdESKnszqx9XfvvRAscJDSc2GDbx9vV3w/wyvTK9wa+6M/CWEDMArKdF2+F1nsAM5F0KGXWJ5/LsM+BKStuLY24Ahf+jBY7ushRJvvEC+HYA52ukrYH+L3IlH4EB8j2v8IFGjEf4WO4TEvhuj/dfYtX5ED3hqQGMOeb6AZM6qj4YhIWp0gsZM/uXtJ4LTbSmwbaz5qnU6Hub1QDCbw0yMsGj56BUldNFYI460wQ1sE4ROzUAdhv7RGJN4u/W663dUTKqZ+dIE3clysqXZXOD7zqAEam166+/EtZ/R0xp2cHh5v8UY7UXwlLnw2U8gXbz0dbpXqiUgoduB5rMyBArtj4abnw7vEenSKKb7FrR8L5iPISfs5sR/DjP4aHPLzq94TmcHgE6W1phtSG5c3OnMuDrI5PcE7SDsuD7uKxRvvVx8NN8bZqcxPRzqpUcdXpj6vK9Dj0XDsX5UWU0EYovtujec/Yrx7TknQ6dg=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(6506007)(44832011)(5660300002)(6512007)(53546011)(6486002)(478600001)(76116006)(8936002)(122000001)(83380400001)(41300700001)(2906002)(316002)(38100700002)(33656002)(86362001)(2616005)(71200400001)(186003)(36756003)(6916009)(66556008)(38070700005)(66476007)(4326008)(64756008)(66446008)(54906003)(66946007)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a1kycnF0aEdyaTZJVWlGWHdERjV0eVdwb2dFblM3VlBxSVV6bVNGeUZWdmJh?=
 =?utf-8?B?Z3FudFI5ZzI3V3FOclppOXgyY09aTStRLzVURmRzWHpQaGd1M1dYRnJDeE1L?=
 =?utf-8?B?UmRwWmpsalVyUHhsWGtEelp2c2VPUm1VTkREWmUwdExCeEZGT1EraXhRMHo3?=
 =?utf-8?B?aS9JMW5SYmd0NzYwOGZZWHlCOVQ2eFhPdlY4aEtpdENkbDBVWFdFc1Q4Mkl4?=
 =?utf-8?B?UEtobHJMQmptOHNEaml4MVEybXNPdngwMnJxS2ZJY1BESWNhV0VkckhxdHJv?=
 =?utf-8?B?WmJHRlNkcE5CbmtzMnQwTk4vT0I1LzJLUWl4SjFQRjhzWDNVQ3JNR2dxYWxz?=
 =?utf-8?B?V1ltY28xMnVHSjV5TGNLZ3V3RFd5czRVTDZmMGkrZC9FNFNIVHlzQ2hieXhD?=
 =?utf-8?B?YTVHZGhEckdCZEtacVd2K1BYaFk0U1dGUTI1T1pibCthd1VkZW9nZncrRGQy?=
 =?utf-8?B?clpIaHZtRHd6TVRQekdqQUFKbnY4azI5NUZjcThiamlLQWt4WDV3bWRXV3JG?=
 =?utf-8?B?emZBZzZIb2t4N1p0T0ZWVWhOVHJPenhwMlVDenExUEhOQ2JsT1FlR0JYYnpu?=
 =?utf-8?B?YnFXYzZtMjd3bEIwOGtKNFNaTzFTdXNnVGQraGhpSUJRY3NteGxGYzR5dkZ0?=
 =?utf-8?B?bmdsVzF0czBVb2pUZkxEYndWellqaXpYOW5MTE9GWlY4dm1NM2ljRUFpUWk2?=
 =?utf-8?B?NU4vWXJUdU9tSTNMYlVQdEJ2V0dUcVVueWJjOCtJcEMyY1pGdlNRcVhCc1pN?=
 =?utf-8?B?MzFSRlVVN29jbkllVjg0KzVHbWFXaFNLdDdhczFWU0lyb0J0RzlPWDFNaVdP?=
 =?utf-8?B?c2tRM2RUMUNlWW41VzlwVnpQYU1Qc1FwVWZydnp3aFJuczhjekN6OEVHUXk3?=
 =?utf-8?B?ZGRwTWlJN1lZaGUySzR1VHRjYnhMeDFYU2prY0psenN1Q0xMV3ZEZWpNcHYy?=
 =?utf-8?B?bEdBb0lPRCtYbGFaYzh3NnMxSU54NFErVWhXbEE1eHhSKzlPMlZPVUpiQjI2?=
 =?utf-8?B?dkhCYzAvV2s4blUwRlFtQU1DZ0pneU5MZXVYOWlkNFNJYmRLclU0UGdNdlpC?=
 =?utf-8?B?TTltYVhEM3lSczJPZGxyQzAyMjZHT2NTVWRnUmNxbFF6UlRaV1hINHVWRW41?=
 =?utf-8?B?UVdKOUlWOHNMLzFZV29jdnJPd2R3UnhVM2dpb3hnNzA1bk9IYWlzc0VCYkxu?=
 =?utf-8?B?eUxXeW9lL0lxTlgwaUdlQzZHRmJRNzhac083VjRXQmowQ3ZuS3FxNEhobXNz?=
 =?utf-8?B?SkxrYklydk81S0ZWSlNkdGlmSXMvdGFrR25qNTVGMExvcWdqUFMrbXUxVGdF?=
 =?utf-8?B?TXRTcG1NLzdLbVlnUEx2S2FmamFBZHNUU2h4S2d0UFR3OGtLYzRQdG5oWW93?=
 =?utf-8?B?WTdaaUJFK3NFTHhhYTBhemtrS0VRU2VxMmhReHNOekk4TnpnZHBxZXI3R3pG?=
 =?utf-8?B?bTA3R0EwRnR2dXlYcUI5WkRVZTJ5ZTQ1cjFrcDhycm9wanJOWmNHWFRJVTgr?=
 =?utf-8?B?bHFtSHhVbXJaamdVU1dudm1zR0IrQ1dhVUtmb1hoVVRkVVM1UzYzemtRWjNs?=
 =?utf-8?B?Sy96Z2c3ckpkU2ZoK2EvNkNYK1ZFbStndFA5OGVlSDZQUHhvMHV1TUlTYzk1?=
 =?utf-8?B?K0N4dG13UzFleEo0ZkYveFoveUJuWFBLTXhma3BORGJER2loclRmL2tMNGxn?=
 =?utf-8?B?VFMxWmgreTVrYmxjQkVqb3FmQjBhc05UT0QwVFhoMkVxS3RlYURFYS9hcml3?=
 =?utf-8?B?Ky9DeTk0SmwveEVsZGpVZ3dKMzZXRUZPWVg4Z2tsRzcyQ3l4bmdMVThwRmNh?=
 =?utf-8?B?eFpRNHJpWUtqUXNiVEZpbGlQSlMzaTlQMWZyNUkrdVMrOUNtY1BQZ2lwNG1T?=
 =?utf-8?B?WWw3Y3ExRmlvOVlDTWtxSnJzOStOL2JlUXR6SWFGNFd4UHV3OVBxMjhENVlP?=
 =?utf-8?B?MGNqcUdDT1pEb084T0JLNTcrSzdiQW9GS1JPdXNwa3lCWkJMM09RRlhydjBu?=
 =?utf-8?B?SW94ZVNMdEcvY1crb3ZYOFM2d2FFazh1S2JkQmlNYWlqdk1tWFZockRMakV3?=
 =?utf-8?B?dVAvUkp5VUFVaFNZdDUzQ0poeGF4Q2ZZM0pXenZ4NWhhNytGdEI5OFJwS1N2?=
 =?utf-8?B?MGk0UjZsclovOFQ0UFUrc2Nka3BnNVdXS2lENHpEQWxCVWxrQ3FHdGxGMG9D?=
 =?utf-8?B?cnFGRHBVVFdQc256SjhsYURhWEVpT3dSWjhVbFZqVUV3RFBjdHdtSSt0eHZX?=
 =?utf-8?B?cllNN2UrYkRPNlprVWdBYlhDSDRXcFd1V1BKaXhobEdRK2IyVm92V3gremhj?=
 =?utf-8?B?RHdxRVFGLzhuakN3N3l1Q2VseldralcyMWd5eStVNGYyZTlPRE5XSVl2aDJ1?=
 =?utf-8?Q?oeR+/DMpeU2g5nzHHS47TIdM/yW7ayBSDc/8ktvZVnoD4?=
x-ms-exchange-antispam-messagedata-1: NFGu16ORVKtu4g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C2F5F12104CD24A87543F326B5B13DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b19c48-9708-4c5b-cbb5-08da54664a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 15:45:53.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwf1zQWhNN5UQeoy7iKRXR8aaT8GZ7OG9jfRvvddwXVrqNx8llKqX/KGvCiKF9lvC4XGLgmCuzv3xH+qb1wZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2780
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_04:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220077
X-Proofpoint-GUID: yonblBZjJhuSPai42Kpw4B8gJCtFo1IJ
X-Proofpoint-ORIG-GUID: yonblBZjJhuSPai42Kpw4B8gJCtFo1IJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_084616_632329_C18725C9 
X-CRM114-Status: GOOD (  26.70  )
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

DQoNCj4gT24gSnVuIDIyLCAyMDIyLCBhdCA0OjAwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEp1biAyMSwgMjAyMiBhdCAwMToxMTozM1BN
IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IFRoaXMgaXMgY2xlYXJpbmcgdGhlIG90aGVy
IGRlc2NyaXB0b3JzIG9ubHkgaWYgdGhlIGNvbnRyb2xsZXIgYWxzbyByZXBvcnRzIGENCj4+IENT
SSBmaWVsZC4gSSB0aGluayBqdXN0IGRvIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcgb24g
dG9wIG9mIHlvdXIgcGF0Y2gsDQo+PiBhbmQgc2hvdWxkIGJlIGdvb2QgdG8gZ28uDQo+IA0KPiBB
Z3JlZWQuDQoNCknigJlsbCBzZW5kIG91dCBhIHJlYWwgcGF0Y2ggcmVxdWVzdCBpbiBhIGJpdCwg
YnV0IGhlcmUgaXMgdGhlIGxhdGVzdC4gIEFsc28gdGhlIGJsa3Rlc3RzIGNoYW5nZXMuDQoNCkFs
YW4NCg0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS9yYyBiL3Rlc3RzL252bWUvcmMNCmluZGV4
IDk5OGIxODEuLmRkZmE3OGEgMTAwNjQ0DQotLS0gYS90ZXN0cy9udm1lL3JjDQorKysgYi90ZXN0
cy9udm1lL3JjDQpAQCAtMjc3LDYgKzI3Nyw3IEBAIF9jcmVhdGVfbnZtZXRfcGFzc3RocnUoKSB7
DQogDQogICAgICAgIF90ZXN0X2Rldl9udm1lX2N0cmwgPiAiJHtwYXNzdGhydV9wYXRofS9kZXZp
Y2VfcGF0aCINCiAgICAgICAgZWNobyAxID4gIiR7cGFzc3RocnVfcGF0aH0vZW5hYmxlIg0KKyAg
ICAgICBlY2hvIDEgPiAiJHtwYXNzdGhydV9wYXRofS9jbGVhcl9pZHMiDQogfQ0KIA0KIF9yZW1v
dmVfbnZtZXRfcGFzc2h0cnUoKSB7DQoNCg0KDQoNCg0KDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMN
CmluZGV4IGU0NGIyOTg4NzU5ZS4uZmY3N2MzZDIzNTRmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9u
dm1lL3RhcmdldC9jb25maWdmcy5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2Zz
LmMNCkBAIC03NzMsMTEgKzc3MywzMSBAQCBzdGF0aWMgc3NpemVfdCBudm1ldF9wYXNzdGhydV9p
b190aW1lb3V0X3N0b3JlKHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwNCiB9DQogQ09ORklHRlNf
QVRUUihudm1ldF9wYXNzdGhydV8sIGlvX3RpbWVvdXQpOw0KIA0KK3N0YXRpYyBzc2l6ZV90IG52
bWV0X3Bhc3N0aHJ1X2NsZWFyX2lkc19zaG93KHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwNCisJ
CWNoYXIgKnBhZ2UpDQorew0KKwlyZXR1cm4gc3ByaW50ZihwYWdlLCAiJXVcbiIsIHRvX3N1YnN5
cyhpdGVtLT5jaV9wYXJlbnQpLT5jbGVhcl9pZHMpOw0KK30NCisNCitzdGF0aWMgc3NpemVfdCBu
dm1ldF9wYXNzdGhydV9jbGVhcl9pZHNfc3RvcmUoc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLA0K
KwkJY29uc3QgY2hhciAqcGFnZSwgc2l6ZV90IGNvdW50KQ0KK3sNCisJc3RydWN0IG52bWV0X3N1
YnN5cyAqc3Vic3lzID0gdG9fc3Vic3lzKGl0ZW0tPmNpX3BhcmVudCk7DQorCXVuc2lnbmVkIGlu
dCBjbGVhcl9pZHM7DQorDQorCWlmIChrc3RydG91aW50KHBhZ2UsIDAsICZjbGVhcl9pZHMpKQ0K
KwkJcmV0dXJuIC1FSU5WQUw7DQorCXN1YnN5cy0+Y2xlYXJfaWRzID0gY2xlYXJfaWRzOw0KKwly
ZXR1cm4gY291bnQ7DQorfQ0KK0NPTkZJR0ZTX0FUVFIobnZtZXRfcGFzc3RocnVfLCBjbGVhcl9p
ZHMpOw0KKw0KIHN0YXRpYyBzdHJ1Y3QgY29uZmlnZnNfYXR0cmlidXRlICpudm1ldF9wYXNzdGhy
dV9hdHRyc1tdID0gew0KIAkmbnZtZXRfcGFzc3RocnVfYXR0cl9kZXZpY2VfcGF0aCwNCiAJJm52
bWV0X3Bhc3N0aHJ1X2F0dHJfZW5hYmxlLA0KIAkmbnZtZXRfcGFzc3RocnVfYXR0cl9hZG1pbl90
aW1lb3V0LA0KIAkmbnZtZXRfcGFzc3RocnVfYXR0cl9pb190aW1lb3V0LA0KKwkmbnZtZXRfcGFz
c3RocnVfYXR0cl9jbGVhcl9pZHMsDQogCU5VTEwsDQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQppbmRl
eCA5MGU3NTMyNGRhZTAuLmQ0MjAzZDU4MjM0MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvY29yZS5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0KQEAgLTEzNzQs
NiArMTM3NCwxMCBAQCB1MTYgbnZtZXRfYWxsb2NfY3RybChjb25zdCBjaGFyICpzdWJzeXNucW4s
IGNvbnN0IGNoYXIgKmhvc3RucW4sDQogCWN0cmwtPnBvcnQgPSByZXEtPnBvcnQ7DQogCWN0cmwt
Pm9wcyA9IHJlcS0+b3BzOw0KIA0KKwkvKiBCeSBkZWZhdWx0LCBzZXQgbG9vcCB0YXJnZXRzIHRv
IGNsZWFyIElEUyBieSBkZWZhdWx0ICovDQorCWlmIChjdHJsLT5wb3J0LT5kaXNjX2FkZHIudHJ0
eXBlID09IE5WTUZfVFJUWVBFX0xPT1ApDQorCQlzdWJzeXMtPmNsZWFyX2lkcyA9IDE7DQorDQog
CUlOSVRfV09SSygmY3RybC0+YXN5bmNfZXZlbnRfd29yaywgbnZtZXRfYXN5bmNfZXZlbnRfd29y
ayk7DQogCUlOSVRfTElTVF9IRUFEKCZjdHJsLT5hc3luY19ldmVudHMpOw0KIAlJTklUX1JBRElY
X1RSRUUoJmN0cmwtPnAycF9uc19tYXAsIEdGUF9LRVJORUwpOw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS90YXJnZXQvbnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KaW5k
ZXggNjk4MTg3NTJhMzNhLi4yYjNlNTcxOWYyNGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUv
dGFyZ2V0L252bWV0LmgNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KQEAgLTI0
OSw2ICsyNDksNyBAQCBzdHJ1Y3QgbnZtZXRfc3Vic3lzIHsNCiAJc3RydWN0IGNvbmZpZ19ncm91
cAlwYXNzdGhydV9ncm91cDsNCiAJdW5zaWduZWQgaW50CQlhZG1pbl90aW1lb3V0Ow0KIAl1bnNp
Z25lZCBpbnQJCWlvX3RpbWVvdXQ7DQorCXVuc2lnbmVkIGludAkJY2xlYXJfaWRzOw0KICNlbmRp
ZiAvKiBDT05GSUdfTlZNRV9UQVJHRVRfUEFTU1RIUlUgKi8NCiANCiAjaWZkZWYgQ09ORklHX0JM
S19ERVZfWk9ORUQNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCmluZGV4IGIxZjdlZmFiMzkxOC4uZThj
MDMzZmJkYjVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQor
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCkBAIC0zMCw2ICszMCw1NSBAQCB2
b2lkIG52bWV0X3Bhc3N0aHJvdWdoX292ZXJyaWRlX2NhcChzdHJ1Y3QgbnZtZXRfY3RybCAqY3Ry
bCkNCiAJCWN0cmwtPmNhcCAmPSB+KDFVTEwgPDwgNDMpOw0KIH0NCiANCitzdGF0aWMgdTE2IG52
bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lkX2Rlc2NzKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCit7
DQorCXN0cnVjdCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCisJdm9pZCAqZGF0
YTsNCisJc3RydWN0IG52bWVfbnNfaWRfZGVzYyAqY3VyOw0KKwl1MTYgc3RhdHVzID0gTlZNRV9T
Q19TVUNDRVNTOw0KKwl1OCBjc2k7DQorCWludCBwb3MsIGxlbjsNCisJYm9vbCBjc2lfc2VlbjsN
CisNCisJaWYgKCFjdHJsLT5zdWJzeXMtPmNsZWFyX2lkcykNCisJCXJldHVybiBzdGF0dXM7DQor
DQorCWRhdGEgPSBremFsbG9jKE5WTUVfSURFTlRJRllfREFUQV9TSVpFLCBHRlBfS0VSTkVMKTsN
CisJaWYgKCFkYXRhKQ0KKwkJcmV0dXJuIE5WTUVfU0NfSU5URVJOQUw7DQorDQorCXN0YXR1cyA9
IG52bWV0X2NvcHlfZnJvbV9zZ2wocmVxLCAwLCBkYXRhLCBOVk1FX0lERU5USUZZX0RBVEFfU0la
RSk7DQorCWlmIChzdGF0dXMpDQorCQlnb3RvIG91dF9mcmVlOw0KKw0KKwlmb3IgKHBvcyA9IDA7
IHBvcyA8IE5WTUVfSURFTlRJRllfREFUQV9TSVpFOyBwb3MgKz0gbGVuKSB7DQorCQljdXIgPSBk
YXRhICsgcG9zOw0KKw0KKwkJaWYgKGN1ci0+bmlkbCA9PSAwKQ0KKwkJCWJyZWFrOw0KKwkJbGVu
ID0gY3VyLT5uaWRsOw0KKwkJaWYgKGN1ci0+bmlkdCA9PSBOVk1FX05JRFRfQ1NJKSB7DQorCQkJ
bWVtY3B5KCZjc2ksIGRhdGEgKyBwb3MgKyBzaXplb2Yoc3RydWN0IG52bWVfbnNfaWRfZGVzYyks
DQorCQkJICAgICAgIE5WTUVfTklEVF9DU0lfTEVOKTsNCisJCQljc2lfc2VlbiA9IDE7DQorCQkJ
YnJlYWs7DQorCQl9DQorCQlsZW4gKz0gc2l6ZW9mKHN0cnVjdCBudm1lX25zX2lkX2Rlc2MpOw0K
Kwl9DQorDQorCW1lbXNldChkYXRhLCAwLCBOVk1FX0lERU5USUZZX0RBVEFfU0laRSk7DQorCWlm
IChjc2lfc2Vlbikgew0KKwkJY3VyID0gZGF0YTsNCisJCWN1ci0+bmlkdCA9IE5WTUVfTklEVF9D
U0k7DQorCQljdXItPm5pZGwgPSBOVk1FX05JRFRfQ1NJX0xFTjsNCisJCW1lbWNweShkYXRhICsg
c2l6ZW9mKHN0cnVjdCBudm1lX25zX2lkX2Rlc2MpLCAmY3NpLCAgTlZNRV9OSURUX0NTSV9MRU4p
Ow0KKwl9DQorCXN0YXR1cyA9IG52bWV0X2NvcHlfdG9fc2dsKHJlcSwgMCwgZGF0YSwgTlZNRV9J
REVOVElGWV9EQVRBX1NJWkUpOw0KK291dF9mcmVlOg0KKwlrZnJlZShkYXRhKTsNCisJcmV0dXJu
IHN0YXR1czsNCit9DQorDQogc3RhdGljIHUxNiBudm1ldF9wYXNzdGhydV9vdmVycmlkZV9pZF9j
dHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCiB7DQogCXN0cnVjdCBudm1ldF9jdHJsICpjdHJs
ID0gcmVxLT5zcS0+Y3RybDsNCkBAIC0xMjcsNiArMTc2LDcgQEAgc3RhdGljIHUxNiBudm1ldF9w
YXNzdGhydV9vdmVycmlkZV9pZF9jdHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCiANCiBzdGF0
aWMgdTE2IG52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lkX25zKHN0cnVjdCBudm1ldF9yZXEgKnJl
cSkNCiB7DQorCXN0cnVjdCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCiAJdTE2
IHN0YXR1cyA9IE5WTUVfU0NfU1VDQ0VTUzsNCiAJc3RydWN0IG52bWVfaWRfbnMgKmlkOw0KIAlp
bnQgaTsNCkBAIC0xNTIsNiArMjAyLDExIEBAIHN0YXRpYyB1MTYgbnZtZXRfcGFzc3RocnVfb3Zl
cnJpZGVfaWRfbnMoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KIAkgKi8NCiAJaWQtPm1jID0gMDsN
CiANCisJaWYgKGN0cmwtPnN1YnN5cy0+Y2xlYXJfaWRzKSB7DQorCQltZW1zZXQoaWQtPm5ndWlk
LCAwLCBOVk1FX05JRFRfTkdVSURfTEVOKTsNCisJCW1lbXNldChpZC0+ZXVpNjQsIDAsIE5WTUVf
TklEVF9FVUk2NF9MRU4pOw0KKwl9DQorDQogCXN0YXR1cyA9IG52bWV0X2NvcHlfdG9fc2dsKHJl
cSwgMCwgaWQsIHNpemVvZigqaWQpKTsNCiANCiBvdXRfZnJlZToNCkBAIC0xNzYsNiArMjMxLDkg
QEAgc3RhdGljIHZvaWQgbnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWRfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKncpDQogCQljYXNlIE5WTUVfSURfQ05TX05TOg0KIAkJCW52bWV0X3Bhc3N0aHJ1
X292ZXJyaWRlX2lkX25zKHJlcSk7DQogCQkJYnJlYWs7DQorCQljYXNlIE5WTUVfSURfQ05TX05T
X0RFU0NfTElTVDoNCisJCQludm1ldF9wYXNzdGhydV9vdmVycmlkZV9pZF9kZXNjcyhyZXEpOw0K
KwkJCWJyZWFrOw0KIAkJfQ0KIAl9IGVsc2UgaWYgKHN0YXR1cyA8IDApDQogCQlzdGF0dXMgPSBO
Vk1FX1NDX0lOVEVSTkFMOw0KDQoNCg==

