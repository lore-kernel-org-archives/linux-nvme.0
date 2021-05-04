Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF8C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:33:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D181B611AE
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D181B611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h4Kz7zJ13pbyetYJg2YargyDGWFq5jZLX+FCcUpEUxg=; b=n2BbNqFXrjoIx1ZjPs78MaSBn
	hdr3ryrurSUg97s7nz+/geTeHjm3mnPcWteekqlRaQemIx5CzIG5ulhLVGKsxN6MCfy7+u6Oi4n4m
	kx/bAYcuvC5rf50HgNlB5go96QiYbFD/E0AaZk15zW5VKysi8uTc/PoOkJnSNn2n4cXHKHRW8Hzp/
	JTAkNinSMseBuhXOK4I0CZnFxJT1bLZz+FuTkygVaAAEjhuiO86zVeDZBmUNn8mVJJ3he+uI8L6Gh
	8RTXsRzohJFDI/Q/98jfFfYZoq6D6FP+SjJTJeqWgFBxVcSWmiInCV6YN5UgtTIdfy2rjLe/9i8LQ
	NMzXWpXPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldqUZ-00FkL6-CI; Tue, 04 May 2021 08:33:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqUV-00FkKb-80
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 08:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=+0BVraZlOdbgBgTP8x6XgQFl/T2oSNeE9tmPvDVVP3Y=; b=Hx3JXdYInZ/b6+UDx6EhQylc4V
 t9DEoEofPW8UrM8cvU/1SBQmnglm2IYHow/k8wjSBWn6V7K9BAPgeuszomoqhwjBvYBMLVxKRUduM
 1JzF7nItSXIZ9OrpGaHOxp4FwECOYaYsUczPbaEhHMuOsuU1ToNii4Klcvnll2BOXLHqlInMhm7W4
 kobanjYwV+R0fXurcy0R2yAPxBaKgf7EUjJ+CGnAxmW5Q2jsTay2Qp0alrmrwNDz5bHY2wKjFZ5i8
 PRDrvtd3BTMQAef8vHwEbvcpykU5SXm45uZqvS6bi4L0ZNjo9f4sbhe4JDbd5wXEPQGIQMFec3k+F
 8HgfZJVQ==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqUR-003ojW-Qk
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 08:33:13 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1448RCAc023285; Tue, 4 May 2021 04:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=+0BVraZlOdbgBgTP8x6XgQFl/T2oSNeE9tmPvDVVP3Y=;
 b=zBAkC5JPY39BBuc3pWKGLsua1fUZuTtbmCsnX1B9B2sUxwPeDI76pUPAkVScGxvtBv8O
 02gVXcArbgxnMZ4OZImZFI+hBX5AqIxWL/El/3cU2c70OpynjuRo9IQ6Bw9qsSqhvZ4N
 xkvZd8QN7sQQoiQV39X2szhns/xhp7ZRyTQoFo46Yvh6sqalwyFTO2NOzNy9IyGEi69l
 wlZWt28vXz86zzPnfGZ0ROt0PhkS8qTHNp+wxDw8ik/ZxFs2p9c1UdSqx9DVftmq62Ww
 qjVKfCl6CX3C/d6WeeckaATHNWX1S4TwRHMpFX+UwMUDGxkGC0KS3YU21lMvlxFF718d rQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38ak7mkptw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 04:32:50 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1448UbkV147601; Tue, 4 May 2021 04:32:49 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by mx0a-00154901.pphosted.com with ESMTP id 389mm0b9fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 04:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVrFh7ZpSy5Eg8RDqdDIP2T2UZy5MyIAEl5vkhxG+B60TdrHcgrpNghTZAefkOcaHTrCp1bLINuDl5oEkhrTKphJvkxlWC91GvlHdH5VhX8XlQc/K8RSD0vccz45/8IDfbrISl7SprpjbHQpTdsXqIbBgwKJeK8FOQxO/Q3nYK9iAdkyQxMg/m0hwijyIDBEfNjk0Y7w9Fsw5tJx0SEyysxuEwUvU7Sqw2W9z3eLn0PoyCPOsgXkMoIJCEZu0rscSIemt7MPtsel5rtcOn8hDi6V0WH9cCI4bjbD1rPyfYfVHaAIwsLtSv3s9s7EtA2qv4Xpc+sAx3hjystmkq9D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0BVraZlOdbgBgTP8x6XgQFl/T2oSNeE9tmPvDVVP3Y=;
 b=KfFwU2qB7Td6jGG/bzqfXTkXf05gr6coDB1YrReWKTHBJbOsizmYCcaHYiXmJtHceD1EifO/e9oOPiAtOLDHUCZ8cT1f1zpoAG9gSEVJI0BdfF4xlm9PhQK9uriCo5h60Pvbof78/KBUDS1XBne1hTPRlRCA0XsmuQpwvzCCHfFVVLUo+iSTsWHHhm183ZVW9toJeW53eEIEVw3uwynVmuPnmGqYVcspF+SahBZjRSbXOxFwU+7WWY26ktByHmVnmq4MEkvcSeONME83JGShG5QcZ+ILM6ni+f2kG7xCj8BeTcLT3JkLrquFqIau3YJ6WSexInZKhCQyQsvskmGc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2935.namprd19.prod.outlook.com (2603:10b6:a03:b5::33)
 by BYAPR19MB2326.namprd19.prod.outlook.com (2603:10b6:a02:c2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Tue, 4 May
 2021 08:32:46 +0000
Received: from BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca]) by BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 08:32:45 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Christoph Hellwig
 <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: "Belanger, Martin" <Martin.Belanger@dell.com>, "Hayes, Stuart"
 <Stuart.Hayes@dell.com>, "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrS9ddQ
Date: Tue, 4 May 2021 08:32:45 +0000
Message-ID: <BYAPR19MB29358DD73BFD034E84C9602A8F5A9@BYAPR19MB2935.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
 <BN8PR19MB29290320440FE9740E699BAC8F5B9@BN8PR19MB2929.namprd19.prod.outlook.com>
 <BYAPR04MB4965C4F33AC9A888930DB272865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965C4F33AC9A888930DB272865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-04T08:32:45.2030320Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=0a4208c1-f66f-4a11-9d9e-adcb0a4f6b11;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [49.37.18.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74d702b-fc98-4421-53e7-08d90ed73172
x-ms-traffictypediagnostic: BYAPR19MB2326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB232637BB2266DEEABA488F268F5A9@BYAPR19MB2326.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yk2S4NYsqTTNhiNeubsmVhclyuYMEP2lYCBkxLmIrgoHREEmN3h3YKeM0njf7Ooo0ALiK1GyHOsSRCOKVZtWlA5IocbQX7T876lACPnxyqhlVB9qr6AzH028FVDaXirgn8kl436ayRGkGxZZWayv07J670mVq+oKVOPgs9guLU86GfhxfFol+dL0VjIWbBFFG8XR4Eac3Xl3cwbXrN2Rj4v5CpzcNcOxX+t8tgm6MDfkox3EX311qZpnE/j5DlJ3QWivRm/NZPRArnnL/8ItrEEZLffBIquSeFqRTb2dQeu92q74BaJHrpHZB9lHw/PqeCunY22mhSSAttDTx7iGBEsKj++t4/F+VCc5UmdwqrX8M9gSZS5iso2+mRVKL1NIEhaBf/9UETV7xj5VWn8DQecQ/VEx39M1TEL3woUqqUCIMydLvzMYlpIFLu2npAVgb6y57jyavDYBoBidOh62izeIOuqrl3RQbL7TFz4/GaIBGwQSVn4XlQb3dRoWPoj5aULDtzYQtGB0N+WelBwC6BmKTIwPnV4oP5cBhx/SPy33R00VxrpglBqcaKusfi7QpLpJaF2ev5dJ2USLYk84Y43ie078SZa/a6F8hA0FQxM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR19MB2935.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(71200400001)(26005)(478600001)(64756008)(8676002)(186003)(4326008)(53546011)(86362001)(55016002)(2906002)(83380400001)(786003)(66476007)(110136005)(9686003)(316002)(7696005)(66556008)(38100700002)(66946007)(33656002)(6506007)(54906003)(8936002)(5660300002)(122000001)(52536014)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?T04Ne+vg3vZwQx6J5MFfL1nInPwOFKIh7WkzTBVsfhBsyFeFccEtN0EewsDC?=
 =?us-ascii?Q?oSTKp8ykmZeP/cjGQvi4avctzPt0HmbrmbmyEsr8tZqEeu+JILSXh9otzuvu?=
 =?us-ascii?Q?MntdnK1qyLqXBv+UY3nQ6T8kioGrcTCaxGGoHaeUuixm7nIFdm5ZqDkJ3Izl?=
 =?us-ascii?Q?kMi6HfQEFr4nTHrAzitAAEa4pb5vUlGTeQCkpyiNjC3Zhy98Gy86kdrBEs8z?=
 =?us-ascii?Q?iaN1Sxniq5fHKNHgx1fzvRw97D74ZHmFll6nxWRxbn6RLGbwmKxZZgtvilYf?=
 =?us-ascii?Q?8l4eDqovnORZywfKHZeIB6vKoPRxChTXL6QerN31pd6pBDoH/j8luXnBuvWb?=
 =?us-ascii?Q?bFeS2aAgbsHymB+V0GhFar03nVshK+xr+QCYx5oa/OBAk23sOQN41Blu1nqx?=
 =?us-ascii?Q?6NlVi25XUwDVznaul2o2e/KOOlASb/9I6yNMAsZoj7I0cvTlsTK7vXSN8hm6?=
 =?us-ascii?Q?WIokKW01N2Fx4B1ISIImmkBnLNxcRFoVcXP4Cl/1SvlpK45iw+SSJtmHl0gk?=
 =?us-ascii?Q?cNMBwvtU8oxseRnkoVYRzNEMKKzysmQnnBEuDA6L/zjB5Go0NL2xe0FB3YWq?=
 =?us-ascii?Q?XLDtxamGRepR6lryrqGYIOFnAWi6Ol3k6KK+pGXCFpwgmWNn3bCJ0W52lU6e?=
 =?us-ascii?Q?xcMJgZeCoyCccMPcX81ItSDRxi6yHRESAGOpb6HKhspiChkspH3VCW1pl1mo?=
 =?us-ascii?Q?QZtWZWDKhmWZyKmJmJgJ8oeJyIEj96Lxpb5yqry9Wdi3GAzqyqovzIogpePJ?=
 =?us-ascii?Q?33MNYaGaIAc5uk7Rfxg0IFjnqLBb86bDsZxDWyx1Wjqg7GP5N+6wj8cgyyvH?=
 =?us-ascii?Q?AAcSphAW28nXKvZIWm5TW/T2dSWBOX/FlQW//Er+VlvIF2bODs7ZdeM6QEEj?=
 =?us-ascii?Q?jyAMBIJhQ/2pJxTaxPoz1KhCdcTio6i2NTeLf7boN/HEG1qHHQbq9U+uc4yS?=
 =?us-ascii?Q?NxgBd8F+Vghn42Em+bQg9QcmVqhdBaseIHukAxZzTIhJbCSRLUGIxdFVFoMV?=
 =?us-ascii?Q?DxfHonqjB5oCnLX/JX+zn+xPNZgg+uCQvm861wt0aG+GHEwMhej06BcEMwB4?=
 =?us-ascii?Q?uNQqwa/VLhN8mg9X5J045xKkZlvMbC6NvKoSvUY4bmSdfA4g5oDIkPXhB21n?=
 =?us-ascii?Q?nLlVQXST6KvCJfbzvBJWeZVFpsBTuJqIUoZJzu8Qe/DexLjvDnaaEMvNIKmW?=
 =?us-ascii?Q?rbRCrpNC4xml5O5XaRXgzudf6r1jK5t2Z2xavlxszE+BkwljZjBYR1iCm6cA?=
 =?us-ascii?Q?5Wm6RpdrG90YQ1aiB+R8MvY6h6Zul7zp4w2nS84f43KB59NiepxiqMsxABp0?=
 =?us-ascii?Q?H9tRvKFHKy+0ACd/2TxBp0ya?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2935.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d702b-fc98-4421-53e7-08d90ed73172
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 08:32:45.8390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MzelmTDrC6PnEXYPeK25vxB0w1/PAvLqr5MAaWVR7i1Cw4EUQ7VHqW9EXahp45/5iudWe9IE7wW9diEOFFxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2326
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-04_05:2021-05-04,
 2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=751
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105040062
X-Proofpoint-ORIG-GUID: iZBSJVp8GvRSfUwozbYY0H2nNM8wqqAq
X-Proofpoint-GUID: iZBSJVp8GvRSfUwozbYY0H2nNM8wqqAq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=855 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105040061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_013312_057850_8104708D 
X-CRM114-Status: GOOD (  20.32  )
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



-----Original Message-----
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 
Sent: Tuesday, May 4, 2021 4:52 AM
To: Rao, Vinay; Christoph Hellwig; Keith Busch
Cc: Belanger, Martin; Hayes, Stuart; Tarikere, Madhu; Martin Belanger; linux-nvme@lists.infradead.org; axboe@fb.com; sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL] 

On 5/3/21 00:21, Rao, Vinay wrote:
> Forcing RAE bit on all the log pages that kernel cares about is one of the option.
>
> Can we also think also think about an another mechanism where the kernel would generate uevent after kernel does a get log page. This would make kernel always to get the get log data first from the controller. 

to read empty log page ?

We are interested in these two events NVME_AER_NOTICE_NS_CHANGED and NVME_AER_NOTICE_ANA. 
-- NVME_AER_NOTICE_NS_CHANGED event would require the host software to do an nvme identify namespace to see the change in the namespace. 
-- NVME_AER_NOTICE_ANA event would require the host software to do a ANA LOG page command to get the ANA log page from the controller. Even if the ANA log page is sent from userland after the kernel sends it first the controller would still return the ANA log page. It will not return an empty log page. 



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
