Return-Path: <SRS0=Ql1M=JB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B6C433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Apr 2021 11:41:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278F261386
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Apr 2021 11:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F261386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IaFnMR/Pgvsww3DlvxARcrzi+cOlOuivb+/v5GyjtE8=; b=gOPEaCIeqzGN8skWEWezar29s
	pRXY/CLa/0Q4thfwoQp+qdcTMTf0yr0HB5SR9mVIc9m0fqAVUuo4bnK2eevGggFDihye1yJ3M9gFd
	bSUX0/9sQrIRCpnCxJvQKik5rFW06Th6TSC1/09aPfCIBk7u9/LSLXX8Lhh/9t9Yclps/LD9k+FkF
	+ENqXDKyU+xUmfTlIc4CTZtlm2yqKUMJxEAEo0VIdiOMrw6GrF94v0VGwC32LTIH92moj8av5NJjk
	V1uDB0uTC/XVRwUYQP/aGbguHINKuFEHLxI7xWHRhD5dbmx2DH0nFNjcOa0XfkgqJcTP/v3bJJUb9
	ZhK83mq1Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lT18I-00Fh22-ME; Sun, 04 Apr 2021 11:41:34 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lT18D-00Fh1B-3H
 for linux-nvme@lists.infradead.org; Sun, 04 Apr 2021 11:41:31 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 134BVQGe022550; Sun, 4 Apr 2021 07:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=TYdRdWCWBZSkt0W7IGIby09UGi450IX1ngeDTOFv5dI=;
 b=W2RJmihosOZTIsSzoTNM6HOLgOE6sTjxTcCRGpnNX79lTyNOFK4OhVuPjBuhYUM2vIVQ
 0DboBxB0XPDsHyDBIPaoH/LkE67lQxlQROmTcjZO7SzXPJzjMmGg/+UTm5prSYWgXfC/
 a6kaq31sazRCb16j42/ZS/EJeSLR+Hta+o36Sej8yzT5GGb+g409h9EU0h5M0Qrd66lJ
 cjxBQDvZl20UDFjOch51C8cLq4QPPdvwWBW7qBcmlY4BBfZwlu8gREAkyf6Rb7+SUg1F
 UcL8K3jzJEM//GTgUS2gA9zAlHUoHsR1qsJT6olE8Xk7B64/4ep288azdFlOzzK2A3De Kg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 37q2n38ug4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Apr 2021 07:41:23 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 134BfNT8090186; Sun, 4 Apr 2021 07:41:23 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by mx0b-00154901.pphosted.com with ESMTP id 37q5keb0xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 04 Apr 2021 07:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqvBcDdC94RC6kMjI1hrFra0NyWuyeiCPhXR2CUSg3xBYTcRhRuuOoJInHjQqFNuhsY/XOW81cW/hh9Tm0HLW6vL6PO5HoA7jd1rYX+Bmr8/XC5KJzgDTx9G3yh08F6tqQizmJbd52DOYuheOtvB8wYYkqv10qeE0CO0zZvRL2vfN4M1yI7KPuO6sDqgh5QI2SoFUuMUpTJJa49SkrIHT3+L1+flK4Gc6NebS7jw2dOvOUAwqHY1WVHqr7c5rHzOTz2OYfVqigLT9bISsve6FRqmQlzgoFhDxhne1z+QTkENSEcwQKrOZsCUWYVLbsBTZxRUurYB1XwTmKsEHCw+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYdRdWCWBZSkt0W7IGIby09UGi450IX1ngeDTOFv5dI=;
 b=UMzJ3gbQj/hu5doE97YYysYHxGV/GyQlBExKReMnigzLiDenHy5G2hCFumpXkHbgf35UpPnZTdWtywyq2hG6MJdKI+SNN6aAYwNTpEgSLEpPGk2UoddxyPCIhE1Eltwzjtd1bWjqv/mOMaoiRKcPeMR9DCx2xA74abVFQHi1jENTdH8SJsOCKdNQLZbLDPBljhnHAD5J+htqyOi1F+RIRFSW42zPKEO1djnf9S159aCkqmEiG79YmrsGtXl2YRgqY7cmlFgisMzML6AnDBfOqGTx6m3pnDJLXKRONBz8F1uGP2XcoTVScnJjdgAsgvk2hvEz6oJ238zfY5GMgPCMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com (2603:10b6:805:9::16)
 by SA1PR19MB4944.namprd19.prod.outlook.com (2603:10b6:806:1a2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Sun, 4 Apr
 2021 11:41:22 +0000
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::d5e3:6223:2f08:2c2a]) by SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::d5e3:6223:2f08:2c2a%7]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 11:41:21 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: RE: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH1WeSduPwBPbw0yAK6Yfbm2yC6qkUAjw
Date: Sun, 4 Apr 2021 11:41:21 +0000
Message-ID: <SN6PR1901MB202980A3FFD39B4B6F2163B3EE789@SN6PR1901MB2029.namprd19.prod.outlook.com>
References: <20210322195717.13094-1-amit.engel@dell.com>
 <BL0PR1901MB2020C91B6489355411A00578EE619@BL0PR1901MB2020.namprd19.prod.outlook.com>
 <BYAPR04MB49651D211A8D26C40EB52C0386619@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49651D211A8D26C40EB52C0386619@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-04T11:41:18.3263304Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c3da42a8-c6ae-4486-9853-6ed2ea162d8f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45f86cb-d681-4586-f692-08d8f75e91a5
x-ms-traffictypediagnostic: SA1PR19MB4944:
x-microsoft-antispam-prvs: <SA1PR19MB49441112283C671FE98015F6EE789@SA1PR19MB4944.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/Ue3OgbooQDOZAmDUavVrsY1vTvPvGiDbJpY7k9fMJg0ZvTKC4eSl6WXnHq7wk5FnMoTKYVOicqPVlT9t0iKBiJ0t98eYlhtTVv9JvQLDDjZdzTziD+jGSxhjRw96yukuY7v6+ZkOYzXz7AZRoA/mgemZlPjYFCL16pgBpSc6PhvbpGcfNioH9uc479Tye6p97sHzQYvmEzSbRh5aV4hf1t7MSBSf/l0E3rl2L0qkm/jRNHwX6KFfCOEF+vDgwvUZEftukJTgUOtPeYDJh++hdP12TBGCI/OAcdV5nG3QH9TOQxZseRbTQkWYG3e8lU+ap442THBNNbnK8gu383EEimUgJ6ZqXOx+nBxtDsdpGCN/S1EuqYKsKKxbBhPgwhC/jrJpRZonzuPhhxMK9TuvMjOdRfkrV1Ws9MrX8c+IJtTgm6O5KKJVCpXZhOWBoIPbsnMoIxL8rX607CFOPqb7H0uQQJfg+o1mM4WGIBLzqXMX5jROBg9NiWvBQCvHHy0YTyBOwbDPuY89GYqqgR81H0kxjTUnzjDZE78ukgpZdZ4GQSNj6/2X4Bumep2FJVqlGj2hf6MgGvF4Fuonc7cLEWHFkt4jP7AZWu1vrBHCcxgyXXorNCnB3LnAMdY71IAuYK2NKWhtgbzgjZFYkKmllsVzYJuvBIXc/it3hVV4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR1901MB2029.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(26005)(33656002)(110136005)(9686003)(53546011)(6506007)(7696005)(186003)(478600001)(2906002)(71200400001)(38100700001)(8676002)(86362001)(316002)(8936002)(4326008)(83380400001)(4744005)(5660300002)(786003)(55016002)(52536014)(64756008)(66446008)(76116006)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BM759xZiKxRaZUQOJpqUb8o+ZSl+SgjStSQNCW926TN6lglYWxOb8NzzwC4q?=
 =?us-ascii?Q?DnAg7yltzLaiDCcz0i8ixbfvykwhN1iVex3PKWmMU2+zUXVbrZtTtOuRvjA+?=
 =?us-ascii?Q?Hccb0kaJpvIMSjQAeAzHpqBQ4DbNLln/SlHOWG7yPC05SAkDKrftZC/f295Q?=
 =?us-ascii?Q?ukOif6fcNf1lyvDC+eZj4O3Z5Qqvs8VEnoec3c7O69RIpMNXyFYzkZJssIaH?=
 =?us-ascii?Q?lqxW/VFgyzF62CXojwBsN5cg8Vxyhtl+1+QMK/2kYt6d3BckJJ+WR7IgvAOa?=
 =?us-ascii?Q?JJYgJIA3cEeQgjHlU+l88oL0EtievSmM2giKgsnuMPSj2VkjeicS1W95XjBn?=
 =?us-ascii?Q?i4+TgBRBCfVLTqrIKJ+iYMWfz8b9aq0v4pVkwkzM+N5gQJXFfVSBO8uIbuA7?=
 =?us-ascii?Q?gk+pWBHcokocngeVPLOy5Dp7IWPg+LaMGibc0EfxWSMPk7rPzeClA8Z6eZQw?=
 =?us-ascii?Q?CI9jU/EfTxZtIqxEGYfJP691k5WglUQo4VZunrFZd9A3JbP+PxCLHUenVwOr?=
 =?us-ascii?Q?90QIjcfSlmnZYReckjaxWv38mF5nyoV2b9Fg/EzO/zLWwvNxULQ90vSZ41Pe?=
 =?us-ascii?Q?yvREcYjiUi6g9NAJMR+tHW3PibA7BRm1NPXDj22DT1d84xlqFap9J9bStefI?=
 =?us-ascii?Q?lZc9S5ESgUVQnrCDu7yJoyc6xPfse0JmrMnZHia5EwxAK9JkFZpaLVCjp8UX?=
 =?us-ascii?Q?pbjVj4ZsKLbrarUmMcwdNKp5dHSOCgwaS8HlLfpxU8DnkMqc1hNhltVfJgUJ?=
 =?us-ascii?Q?lTOL0Dq5+vEyBM+ENSUOPaKN1PSm/wFohlPzQzr5v0wU+0fhjhE1wEjQKysP?=
 =?us-ascii?Q?VUkqD3+98n3w3T4gS5NcyEuJbMfC+tFSqhItXG6tdaXEj2pYLPQZRD3pm3UL?=
 =?us-ascii?Q?tWEBpokTRDwBJfW1mP+D362zWzrr/F3Yep98r+eGlNUWxpJSkEyu/9ZKUPUa?=
 =?us-ascii?Q?dujJx4QVpF4p6RKYOnVx286TYuzKOlQrZ7BtMLvUmMFRHPlBSgdKdmWAOUIR?=
 =?us-ascii?Q?RPXJVqumwjw4xZjThcWT+X+q5q8aW7x+ZC6tGqD6MKq+I67UmIWCz6qnoT/Y?=
 =?us-ascii?Q?YyPFe/wEPfpQOJZNcWXMs2/ajFV+3MJPM5XijkLwhwNfrwLrrG5oC1OXYL1o?=
 =?us-ascii?Q?PNotsoMNZuWLuMjItve54v8eGELjQytvSmxyXs3QvNy1+Q9ufsIQMv5W5hGz?=
 =?us-ascii?Q?nBwibGmFpSc6JeMiObb1MnX0DbfdjeUUJdrvGSsQTf08kbahMe3CnmGKnoaU?=
 =?us-ascii?Q?9Dg9e1UD3APTAZly9exmyfHWpCJwbPr6jwfNy3wnTrDIVazH/5B+ic7TOdVt?=
 =?us-ascii?Q?oVFnu7ww/5kdJq0crDvKBylh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB2029.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45f86cb-d681-4586-f692-08d8f75e91a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2021 11:41:21.4145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d1FBgbHdAk0QmMu1dw72PGmH4LZ6LuREndhcsTF9/R9FrYm/wLu3pmOmnPc7rGDqF6KtyF/XvvV35LM1govvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4944
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-04-04_04:2021-04-01,
 2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=885
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104030000 definitions=main-2104040079
X-Proofpoint-GUID: xhnolHe7rpAHWnLXGgaYNqNETOm_hhyF
X-Proofpoint-ORIG-GUID: xhnolHe7rpAHWnLXGgaYNqNETOm_hhyF
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104040078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210404_124129_970765_FF13EF3A 
X-CRM114-Status: GOOD (  15.41  )
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

Ok, thank you

Amit

-----Original Message-----
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 
Sent: Friday, March 26, 2021 10:03 PM
To: Engel, Amit; linux-nvme@lists.infradead.org; james.smart@broadcom.com
Cc: James Smart
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport


[EXTERNAL EMAIL] 

On 3/26/21 06:32, Engel, Amit wrote:
> Hi, are we OK with this patch? please let me know if there is anything that is missing/required
>
> Thanks
> Amit E
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
