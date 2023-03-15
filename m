Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F84C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=POgnRJViAylOGuD9onYEEOLsjPKOMC4R2D7ZXfWls40=; b=JsYO/0T4hDWxbH
	CI9KFLZTaXFs1B9o/HeuwsPqOPMi5cULgdqlwjc2RXQ/N1IXhoxkcLVM8Ui1a1c6pQowHnREQ5SoK
	Y7yAT0O3n3Hxupa5fvj0zV0JMns7AjFglfkDqJpL1uHLGVysGJ0NjxOiPIRZIWWgfsUeM2YOKPyCH
	JxfcVbZ78SMQdexHOqdtpJOTyJuvPuViXY6yVUC5Gu1wIEO/Wh6daYV6AnKc7xae1g7O3FveeInHp
	900C41cSpEaF+MqSiEki2HpDLwsBSqW3gX3+0eiREHsrV/COyf/tIwCrOX/nZGcEySMtu+HeeeNVC
	DhzDXisYzBORd7NYq36A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVEn-00EB3q-1e;
	Wed, 15 Mar 2023 17:48:33 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVEd-00EB2K-35
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 17:48:27 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FCrTm3019850
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 13:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=POgnRJViAylOGuD9onYEEOLsjPKOMC4R2D7ZXfWls40=;
 b=LvDB5Z8mp5sfp6Dcf7WK27OD7KaSGjiDeTKMwRnSD24e2jNJWlazp3sIZoSNAQKwP85a
 4sor26bIlFyEKq2KLrMw2H7V1SD5YIECfhaBMdetPKT5nLNWNUHSTphtmrWZHPNBUxwo
 UwGvTf2qDr8RHioKp/HzeDCDs9R//sZ+i5sF2fF4mkoc7I61Her50cEjxzmORVNciXnm
 D9x+ykBZbpxMC+ax3EXAfdIOy4hbrblitrAb0m0Nzaq4ooOvxHRDHDIA9kzGbU3/vNbo
 LDNCwWEcj28VTtKt3kBhRHEzh5cdOYzos4XcbcFIIDSdtctN6+yfNlNfQluZiQYqoxiY Tg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3pb2a1ecss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 13:48:20 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FH2FZm006868
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 13:48:19 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3pb2cb6597-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 13:48:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avW0Xl3aemXaqtnrRWJwkgylZsKRxc6l+N3qYu6O09W212DrhVThsJW8im3nNNDplVjMgifAK+Z8dnwVk2Jw3gumCLdRqBZTyj3glIFCmoAdM46/cNFLii9lZNqM7dWgE+q6zUrfK9vxQ9zw8wIfYa7TXhlr/NqxzYo2z82N5J/RxX/pnNGoiq7nOJqQfib6iuvTIQeGG7CDrKMmdxsrtIjx2ZRVlPiQqMNhHK9GOP+aPnerqflSDSl9vPHwAg5CkyIf4EtHdGt+dBCTplVCzWDpkAIzy1xYqsC/R8etRjEdKd7x+wZDAo/7cmSxkfAns08BdIEeQ/GvhIuEPjUqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POgnRJViAylOGuD9onYEEOLsjPKOMC4R2D7ZXfWls40=;
 b=PvM4l2FabYkmqyv3d3aSpbv5zN1edmw/Q1lLr9gh23kLMEPKKOmD/D7nZDF1+nD9vYvZT9S03fnbVTvnVDgDwz2LOeo4+a1mgDIbe4LAESIRn8mbgKbKZhCGrJcR8SFQ407sLjgG0ZkPiAwjYulKKBwv2z38IZnXTkbHwmd1YQP+B+deDibVksxY1zBt5c0X6qiJ+jb+Fd9Wm5Ts8pOzRk60uaVV37xoat1CWwVz+UVuh/iNiDagjRWJenzw3qCnmX7rd/buzSPzvjM3P8ySPIzhaukYesaHsQTboz8idHnlkj8RJ5wEXSNvhnEmDOL8j21kWAFeO0UdMbcZMd4xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB5558.namprd19.prod.outlook.com (2603:10b6:a03:427::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Mar
 2023 17:48:15 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%6]) with mapi id 15.20.6086.024; Wed, 15 Mar 2023
 17:48:15 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034
Thread-Topic: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Thread-Index: AdlXZV3LgjsZJGHIQ4uZAsfmw1ybfw==
Date: Wed, 15 Mar 2023 17:48:14 +0000
Message-ID:  <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-03-15T17:34:01Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=638a7dda-81e5-438a-95b4-55950be7c34f;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|SJ0PR19MB5558:EE_
x-ms-office365-filtering-correlation-id: e54fd0b2-9fcc-4214-b7cb-08db257d7404
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Uub6TEB1zT+uhBXt1agUYyg7rUHehqJS61aaQLJ94dMOInEpjOUOnDt2zl0ZtYog8nR57kpPrMnX2J9TS5HdZtvD06EssnDq4hBIwX2ezp1swx19XEgNbeaPgRJ4cMhLCpjtZskGMxshkb2NtvMnb2kL7H8wiwGQmmRT2M5XvtJ9DWrrhxnaIXwqDSOjrlmWLy+qRqR/Miwy9d2pc6/rseqSNd2lnMknpqG5GMPcjgjYsBC6TPR9DPyjHXZiDBwG1Kahia22FnDNDB6CAJT1TDdF9W4oSz4ablOImho4VTIU4efIypObkl8vqL3iSNqA5kA/p8oSK1FlC1FztaXg8HLHLHT3SWciqoDRfsWEM5DTpeWch0cPvQyhfx8gpWpAJIO7lK7SL8XswOgCOEdCfJNIuAfCycS3GWGlXATmBuojdMYqcmI4BmVL0G6hS7JpYr1p7y3uYtv0Voq7Y3B86/Uzx1GHIYQ78OLLItfhip2e+nC8rCUtKvqI2kID4RhNxhAvfxIulB1vjGTUBTkVeMRBTVZpqdaNy/u2TRpnxac375JxCD21rd5T950ZrTaaEn1FHv08OZrQ+p6DQrTS0HstOUdh3AqA2AMij417P0MAnmvWqc9kAPLhySAOmR6NwFTGb5cPgN/+DhjKPM9EjviARXBnCunYZJ7yC+/LIm93uF0qhmORZuzjXESmDsP/wrfJF9zpxI/inTAr3EMTXg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199018)(86362001)(66446008)(64756008)(8676002)(41300700001)(6916009)(186003)(2906002)(52536014)(26005)(786003)(316002)(76116006)(66946007)(8936002)(55016003)(6506007)(66476007)(478600001)(9686003)(33656002)(82960400001)(71200400001)(122000001)(7696005)(38070700005)(38100700002)(83380400001)(45080400002)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?6ucjGd2dncWtZ05qdxzGtPPFk3GYih5XEo3YZBw76HfGUP8mP3tpC4Iq1nR0?=
 =?us-ascii?Q?WxAom7yll24grG+wbij+y4ohXa4hi03mXAQpZdDSKGwd9teGC+L4+rj3dso2?=
 =?us-ascii?Q?QSg//jx2qvMnx/MDcCOFnueSFijBjAayzqK0PFkfRfVjjEfMZrr989f4Fpyo?=
 =?us-ascii?Q?ZZhRCydFBA/iX+RPbhxBDupBoY8aU4mP01v8h9r4ohFJuPQy2JV500u/7EJT?=
 =?us-ascii?Q?cwkhOL8tR8Ma9t+0k+ZrOfLFwGLSAGExf5ZjMXKrV0RqTBohD6k4u32vbV1+?=
 =?us-ascii?Q?eHEkX6rbpHYq8iKQijjElBDU1Vq6Uyl08cnQzEtwyEM7Al61brVcLlXN+gJU?=
 =?us-ascii?Q?pc5bW196OAewA1tLSI0CGBSe0NRjEc/ICzhd+zl/Y0AfhbeMMNeJa5DCpxXd?=
 =?us-ascii?Q?YQwg2lr4bzkDnkeYWTHb0uqpwuA1OeWG/MpkQP4x2nG0zT0B5rOgXi/IEuRM?=
 =?us-ascii?Q?eHRCar7PzrHdzVdSbJyKczBsRb671zp1mMl/dlA2/T2duF93dLgMFY/DyJY5?=
 =?us-ascii?Q?KZ7Tm+WIt3g5hOh2d2UWt09B9dbwYGhc5RudzOoXw6+wMe3PW6qRBHXZ4pig?=
 =?us-ascii?Q?FRqO+pCeFDGyOdepaiA2rEJiyMEzcGb4rQqS7roPLFIiPPtq+jq8efplogus?=
 =?us-ascii?Q?ihZn1MNb39ha750tDQ7n7Tf9i804+ODqy3SEU3+ebDAVamK/uDGCJmnKk8pG?=
 =?us-ascii?Q?CAM4LTTt7tsim15Xacl8bKkVLLk22D7qyQ0ndjlNT7V/4/W6O02EVlvIEmg+?=
 =?us-ascii?Q?6lIn7Jk5zCqdWBlYW8CbjSGtnm5s29asLs7gMByZPI51G6oGRZYW4P0QDvvF?=
 =?us-ascii?Q?gnsF3uhROo1JY4YBvXrFyrWpWX7fOtF53tioK50m+HyqtMGtPFMSg6K/jsKh?=
 =?us-ascii?Q?24d4ddKCLjcEKXrT1HCiW/s7yDFe1ua6RzBlX9GYg7E/wd8j1Dy4qCD36KwJ?=
 =?us-ascii?Q?8TfFj40z9WdZbe0UStYvRJm4llifDgwBSK5J8DZPNlFHPnc0hPpoMPGtHe2m?=
 =?us-ascii?Q?BtPn9Sy3AiYyW+AtIfn2ZLOa6SvVULZA11QK0WyAe6Wu5RxgxDx6YQ997uOF?=
 =?us-ascii?Q?shLw8Cesyzwf+2/prGK9L903rMxdEDIvIS2C7kd8ViqyeVsHgNplRrEvKTBe?=
 =?us-ascii?Q?RwRKszjYGaLr3Yw3uA7oCCtxdP4aupKFNNPzLMBN/waTvm/FzaEwigW/G6Y1?=
 =?us-ascii?Q?H5CDJMhpmyVJ9IRbWhkEALVvuag2eowkvzPql2VEN9RFD2h8v+vWT1xo/bao?=
 =?us-ascii?Q?TuCpE5ZbCI1mC285N56PDayOkANP9e7mxRQvX33J9J0BJC4FtHXhFOM5xDRe?=
 =?us-ascii?Q?omEnAm8J5749nv+6p7SsCZlxjp74fBiptKSxR/iL4+Jh1jM4SFkD8PZTdp2p?=
 =?us-ascii?Q?MlGOSZvTe0lWZXR6j7ZoJH67nwwVpl0nbwAQxlRvXRhHq8ClKe61r+LG276A?=
 =?us-ascii?Q?E6XHzBn1ZnrleO1wgljUdJPdKs3quSunxHJrZMXbJwC1z+5FZbGcbvLpEwoW?=
 =?us-ascii?Q?tS7daOMiJGeIMKMnD9ETMMJ0CJkXBUxi6e+cD00vdS+YLuUZ3R3m+z0Lv3EW?=
 =?us-ascii?Q?NSoeqtusyS5Hj8Ei8hCxwwoTr+W7XnxGm71YHoo3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54fd0b2-9fcc-4214-b7cb-08db257d7404
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 17:48:15.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3p9jjpe6BfHVO0hbrR0Y4xddfjT7LUU2zqOkTYgQfJHiaBfM/5zwwx/mszIYaC+dOBD7GjTzmhUqREkypQv0WsAP9XgRiYH+QtiYXkQZrSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_09,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=692 mlxscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150149
X-Proofpoint-ORIG-GUID: s6PPuiLsQghCiW4uCWSuitXK4ZAp8iwt
X-Proofpoint-GUID: s6PPuiLsQghCiW4uCWSuitXK4ZAp8iwt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=774 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150149 domainage_hfrom=7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_104824_553517_2E3D0E92 
X-CRM114-Status: GOOD (  17.69  )
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

I'm running tests where I connect/disconnect to/from a few I/O controllers =
using the nvme_tcp driver. I use nvmet_tcp with a null_blk device to simula=
te the target. The kernel module crashes (trace below) while trying to conn=
ect over TCP. This happens on Fedora 37 and Ubuntu 22.04. I also recompiled=
 the kernel using the latest nvme-6.4 branch and I'm still seeing the crash=
.

I'm not sure how to debug this further. Any suggestions?

Thanks,
Martin Belanger

Mar 15 13:30:22.954399 fedora37 kernel: nvme nvme1: failed to connect socke=
t: -110
Mar 15 13:30:22.958393 fedora37 kernel: nvmet: creating nvm controller 2 fo=
r subsystem nqn.1988-11.com.dell:PowerSANxxx:01:20210225100113-454f73093ceb=
4847a7bdfc6e34ae8e28 for NQN nqn.2014-08.org.nvmexpress:uuid:f9ef75fc-1699-=
418f-ba45-49f9fc766e1b.
Mar 15 13:30:22.958453 fedora37 kernel: nvme nvme1: creating 12 I/O queues.
Mar 15 13:30:22.960320 fedora37 kernel: nvme nvme1: mapped 4/4/4 default/re=
ad/poll queues.
Mar 15 13:30:22.960862 fedora37 kernel: BUG: kernel NULL pointer dereferenc=
e, address: 0000000000000034
Mar 15 13:30:22.960998 fedora37 kernel: #PF: supervisor read access in kern=
el mode
Mar 15 13:30:22.992915 fedora37 kernel: #PF: error_code(0x0000) - not-prese=
nt page
Mar 15 13:30:22.994551 fedora37 kernel: PGD 0 P4D 0=20
Mar 15 13:30:22.996135 fedora37 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
Mar 15 13:30:22.996169 fedora37 kernel: CPU: 0 PID: 3953 Comm: pool Not tai=
nted 6.3.0-rc1-stas+ #1
Mar 15 13:30:22.996192 fedora37 kernel: Hardware name: innotek GmbH Virtual=
Box/VirtualBox, BIOS VirtualBox 12/01/2006
Mar 15 13:30:22.996210 fedora37 kernel: RIP: 0010:bio_poll+0xd/0x150
Mar 15 13:30:22.996227 fedora37 kernel: Code: 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41=
 56 41 55 41 54 55 53 <8b> 6f 34 48 8b 47 08 48 85 c0 0f 84 a1 00 00 00 4c =
8b a8 60 03 00
Mar 15 13:30:22.996245 fedora37 kernel: RSP: 0018:ffffa561851bfae0 EFLAGS: =
00010246
Mar 15 13:30:22.996266 fedora37 kernel: RAX: 0000000000000000 RBX: ffff8ff3=
8ae60000 RCX: 0000000000000000
Mar 15 13:30:22.996311 fedora37 kernel: RDX: 0000000000000000 RSI: 00000000=
00000000 RDI: 0000000000000000
Mar 15 13:30:22.996369 fedora37 kernel: RBP: ffffa561851bfb10 R08: 00000000=
00000001 R09: ffff8ff38cc0e860
Mar 15 13:30:22.996410 fedora37 kernel: R10: ffff8ff3887af388 R11: 00000000=
00000110 R12: 0000000000000001
Mar 15 13:30:22.996430 fedora37 kernel: R13: ffff8ff38fbd9c00 R14: 00000000=
00000400 R15: ffffa561851bfba8
Mar 15 13:30:22.996450 fedora37 kernel: FS:  00007f9aab2ff6c0(0000) GS:ffff=
8ff84b400000(0000) knlGS:0000000000000000
Mar 15 13:30:22.996467 fedora37 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
Mar 15 13:30:22.996484 fedora37 kernel: CR2: 0000000000000034 CR3: 00000001=
1439e002 CR4: 00000000000706f0
Mar 15 13:30:22.996501 fedora37 kernel: Call Trace:
Mar 15 13:30:22.996518 fedora37 kernel:  <TASK>
Mar 15 13:30:22.996535 fedora37 kernel:  blk_execute_rq+0xc9/0x190
Mar 15 13:30:22.996552 fedora37 kernel:  __nvme_submit_sync_cmd+0xa5/0x160 =
[nvme_core]
Mar 15 13:30:22.996572 fedora37 kernel:  nvmf_connect_io_queue+0x10b/0x200 =
[nvme_fabrics]
Mar 15 13:30:22.996589 fedora37 kernel:  nvme_tcp_start_queue+0x1a/0x90 [nv=
me_tcp]
Mar 15 13:30:22.996606 fedora37 kernel:  nvme_tcp_setup_ctrl+0x410/0x7e0 [n=
vme_tcp]
Mar 15 13:30:22.996626 fedora37 kernel:  nvme_tcp_create_ctrl+0x34f/0x460 [=
nvme_tcp]
Mar 15 13:30:22.996643 fedora37 kernel:  nvmf_dev_write+0x5da/0xec0 [nvme_f=
abrics]
Mar 15 13:30:22.996660 fedora37 kernel:  ? selinux_file_permission+0x10b/0x=
150
Mar 15 13:30:22.996675 fedora37 kernel:  vfs_write+0xb9/0x3e0
Mar 15 13:30:22.996690 fedora37 kernel:  ? __fget_light+0x9d/0x100
Mar 15 13:30:22.996706 fedora37 kernel:  ksys_write+0x5b/0xd0
Mar 15 13:30:22.996721 fedora37 kernel:  do_syscall_64+0x5b/0x80
Mar 15 13:30:22.996735 fedora37 kernel:  ? ksys_write+0xb4/0xd0
Mar 15 13:30:22.996752 fedora37 kernel:  ? syscall_exit_to_user_mode+0x17/0=
x40
Mar 15 13:30:22.996769 fedora37 kernel:  ? do_syscall_64+0x67/0x80
Mar 15 13:30:22.996788 fedora37 kernel:  ? preempt_count_add+0x47/0xa0
Mar 15 13:30:22.996808 fedora37 kernel:  ? up_read+0x37/0x70
Mar 15 13:30:22.996823 fedora37 kernel:  ? do_user_addr_fault+0x1ef/0x710
Mar 15 13:30:22.996841 fedora37 kernel:  ? do_syscall_64+0x67/0x80
Mar 15 13:30:22.996856 fedora37 kernel:  ? exc_page_fault+0x70/0x170
Mar 15 13:30:22.996871 fedora37 kernel:  entry_SYSCALL_64_after_hwframe+0x7=
2/0xdc
Mar 15 13:30:22.996888 fedora37 kernel: RIP: 0033:0x7f9abbf1e2bf
Mar 15 13:30:22.996964 fedora37 kernel: Code: 89 54 24 18 48 89 74 24 10 89=
 7c 24 08 e8 19 c3 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08=
 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 =
6c c3 f8 ff 48
Mar 15 13:30:22.996984 fedora37 kernel: RSP: 002b:00007f9aab2fd500 EFLAGS: =
00000293 ORIG_RAX: 0000000000000001
Mar 15 13:30:22.997003 fedora37 kernel: RAX: ffffffffffffffda RBX: 00007f9a=
a0006aa0 RCX: 00007f9abbf1e2bf
Mar 15 13:30:22.997022 fedora37 kernel: RDX: 0000000000000166 RSI: 00007f9a=
a0006aa0 RDI: 0000000000000010
Mar 15 13:30:22.997044 fedora37 kernel: RBP: 0000000000000010 R08: 00000000=
00000000 R09: 0000000000000073
Mar 15 13:30:22.997061 fedora37 kernel: R10: 0000000000000000 R11: 00000000=
00000293 R12: 00005595f875a370
Mar 15 13:30:22.997077 fedora37 kernel: R13: 0000000000000166 R14: 00007f9a=
ac4a35f8 R15: 00007f9aac49502b
Mar 15 13:30:22.997097 fedora37 kernel:  </TASK>
Mar 15 13:30:22.997114 fedora37 kernel: Modules linked in: nvmet_tcp nvmet =
null_blk nvme_tcp nvme_fabrics nvme_core nvme_common uinput snd_seq_dummy s=
nd_hrtimer qrtr rfkill sunrpc binfmt_misc snd_intel8x0 snd_ac97_codec ac97_=
bus snd_seq intel_rapl_msr intel_rapl_common snd_seq_device rapl joydev snd=
_pcm snd_timer pcspkr snd i2c_piix4 vboxguest soundcore loop zram vmwgfx cr=
ct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni e1000 polyval_gene=
ric drm_ttm_helper ttm video wmi ghash_clmulni_intel sha512_ssse3 serio_raw=
 ata_generic pata_acpi ip6_tables ip_tables fuse
Mar 15 13:30:22.997178 fedora37 kernel: CR2: 0000000000000034
Mar 15 13:30:22.997199 fedora37 kernel: ---[ end trace 0000000000000000 ]--=
-
Mar 15 13:30:22.997218 fedora37 kernel: RIP: 0010:bio_poll+0xd/0x150
Mar 15 13:30:22.997234 fedora37 kernel: Code: 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41=
 56 41 55 41 54 55 53 <8b> 6f 34 48 8b 47 08 48 85 c0 0f 84 a1 00 00 00 4c =
8b a8 60 03 00
Mar 15 13:30:22.997249 fedora37 kernel: RSP: 0018:ffffa561851bfae0 EFLAGS: =
00010246
Mar 15 13:30:22.997264 fedora37 kernel: RAX: 0000000000000000 RBX: ffff8ff3=
8ae60000 RCX: 0000000000000000
Mar 15 13:30:22.997279 fedora37 kernel: RDX: 0000000000000000 RSI: 00000000=
00000000 RDI: 0000000000000000
Mar 15 13:30:22.997331 fedora37 kernel: RBP: ffffa561851bfb10 R08: 00000000=
00000001 R09: ffff8ff38cc0e860
Mar 15 13:30:22.997384 fedora37 kernel: R10: ffff8ff3887af388 R11: 00000000=
00000110 R12: 0000000000000001
Mar 15 13:30:22.997402 fedora37 kernel: R13: ffff8ff38fbd9c00 R14: 00000000=
00000400 R15: ffffa561851bfba8
Mar 15 13:30:22.997417 fedora37 kernel: FS:  00007f9aab2ff6c0(0000) GS:ffff=
8ff84b400000(0000) knlGS:0000000000000000
Mar 15 13:30:22.997432 fedora37 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
Mar 15 13:30:22.997445 fedora37 kernel: CR2: 0000000000000034 CR3: 00000001=
1439e002 CR4: 00000000000706f0

