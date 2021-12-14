Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0290C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpRnxgP3IvsvCzgtP/EBwOue5jwWg7qtT+MxQfFu44g=; b=yGmGedvjo9d6jtY2HoJoeBXj/e
	gWP4ZZZU7UKs1K71T7TDU+PkBX3KIldrwkRDboM+wdwcVG3D+fBT+yrb5y3s4RZKe9V8SQuJnFtR3
	R2bxXsy4uo9dsBj3fPMeLhB6HVevRd2FRLWUOdV1HhI/ATc8OV3hqJ7XUdB7nXByanrI1MYuolHUf
	NEoviuQRaMgKv9gIJ15Sg/M6MdI1tqWqw8K3bHvjNkw6dt3Z2TqxI21an++eQFny4KHiIOhiJJRxN
	cNS092hWs+HAh0hB7lcJYitM1/xXKFtXWuOVfyksAVJHacN/WKW664zbhiLHS2/qzma6808d3GAo5
	8x1CHPbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwvjl-00C4TF-SP; Tue, 14 Dec 2021 00:32:09 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwvjj-00C4Se-9L
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 00:32:08 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLHvtO004117; 
 Tue, 14 Dec 2021 00:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jpRnxgP3IvsvCzgtP/EBwOue5jwWg7qtT+MxQfFu44g=;
 b=ffCxC9wS9ObXY/m7V0oG3zBfWEO7gKQSgrOor5n24U9fBM+Dhpm7wWmSJ/TVjJpOHwll
 a4eKc161mMFxGGBS2QBxj9hNHFj+wOrxONxikIm3vTUBrUWDOuv6asNKnS5ttMkpyMCX
 6Y1P/L6HD2/UeGK1KV1DsSREnOCKLr0E2BXQj21h/7UpPf9/un39B/5FG/MFK0vxhGQY
 Y0HzMEoG8WKW5/0o8ir0QA7BgqRXtAzLpYqdplmewz1x2VQJAcWsEfxUy1OuwpMVKFRP
 g2i9cUHnH6jUn3krVquEEypEC9iTYZDeV6cecSFXc5CzQ+2VXTVGpVKNIYXHOPycxTMu 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py2akm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 00:31:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0UQb2067579;
 Tue, 14 Dec 2021 00:31:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by aserp3020.oracle.com with ESMTP id 3cvkt3ry7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 00:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKj6sco2SIYCE+sn2+0J17XkKhC5aYt6kA2YFI/T9mCS/bpYfG6YBWYYOLs4JqJAejM2EybjnFTd4G1JNZs4UQNxMg2VMXfOXE3ea47NWwnVpxriiz6wlgBcSdDrMfX5iSCNBdtODJzhRDS6WJkcZ7hOcp7UHSHVwJY0gZD6y7IBmh7XPTBJMcis2uYbH/6jeo6QtSV1k7Re+nCxFaI8LJg3RR3aNgcfHCskuBPRUGocnbVVt8lHn+2+I49Ro3aKWCTqz6uFd8WdAuveyoWql/xMoak8sVdrIO0V0msN7ful+NI65SvnSL1rYJ3/5ygwdBZYeCTCljLb8qKTMKMTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpRnxgP3IvsvCzgtP/EBwOue5jwWg7qtT+MxQfFu44g=;
 b=Ntcer4A0KSZV00s69/TM64o8+kGRcSNH+UBiQunCqSLxo5vUyf3UXh719o0nN1uiZHTa32J+0q6FP+Dhl7msImJe6uL6jOrMlBuQIX5ymiGxK1yf3wN59PoEl0HMO8giMfZIZXgutJFgCG5Zmfhd3S/t/u9JPlMHarSOWJbjOdNytwVJ/W2Sktrb/yE8nUWAHVn65h4/ZQZWTWE3CgvAuV271tArM4VMRdPpvdoU5sRmyOYxnAIVqEWb75upLepNERFpodb1gB/Ks26QT9HkNUFP1Qx/C/69aGaLaAOR9yJPsL+NVdDRdsreytsg9p89Ak9imzoDlbfVFIAvVuVhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpRnxgP3IvsvCzgtP/EBwOue5jwWg7qtT+MxQfFu44g=;
 b=Yp/giXz24g43p+tFHHBQXNgQvNXg4f6U7yD5IpODjmDO+lKDRIJu87OU8+Ns7oTyhaoslUOOy40i9PBa+TGKymXRGLlX3Mm4j/uT2Vagdrscc3bIZSeAwMMZmifMEURoLzGbQ50Hb7Cn83J6Cnhys8HDwECDJ1RfrGPMTxbed00=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 00:31:55 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::a9e6:aa56:78b0:8e6a]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::a9e6:aa56:78b0:8e6a%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:31:55 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Martin Petersen
 <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH 1/1] nvme: Add verbose error logging
Thread-Index: AQHX7SLIBlia1z4/6UmpTvCtrrj9hawrmh0AgABIIxuAABFRAIACrhkAgAKIDQA=
Date: Tue, 14 Dec 2021 00:31:55 +0000
Message-ID: <0E595C93-789B-4B70-879A-B5F3E9BDB581@oracle.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
 <6d23d067-9115-a295-1bcb-ad28679dc4a3@grimberg.me>
In-Reply-To: <6d23d067-9115-a295-1bcb-ad28679dc4a3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d3f8e45-438f-4842-0faa-08d9be9921a3
x-ms-traffictypediagnostic: SJ0PR10MB4576:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4576B5867D8D1D81A7351F0BF4759@SJ0PR10MB4576.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uuwUWlnZxTk4EU5LxKMRTtYYdcM7fSznDXGFfMx2rxi3rgh1B8lvREj0VOlfEBj3U7n+Wji+RmfFQoP3opAULqhtou4v+KcXdcsv0D0QreqoWCptWRzZXPEuPjpIwRvP3+fRfCF2Sq5NLnCwq1E9l9mbPilEsCQIEHWagwSJS8pdERVZEVs+5zFyjfdtGlfHm9ABwFGvpB0nxwR4uexKCz9Wz7rHv8JpsvZit/V+Jd3FI9y/b3yp0cY6nxq7CSR5MZHa/269IvIMCZZHr+yC+3Qj785FZHAsuBVJ+2nYGz5C/hMwdxg0fuCyAastxjywOupNq5mXwCKLsOMZa6mtq3GUuwokdSWA+t0i2k1XI2pT2BO0tt9GBrrmrHk9BGEZZsAk0LRQlgwmfe80NdnmsdV80WN/+3mxecCGKcl5zXqfOlRM8t6px3V6ERR5rfQJjL6hcZ+nv8jlEv7zTkcgVCloK4ufDEUjcY19ITw9WF+igmXhgdwVJ3Uq9sXcCY1qtIt8f9jOe+MCmq0n6OMEpUiNrs6u8lQthmFHHJfF7BLuDDpB2FTzYQdgKerIFgXtjemvZeYHxwDmUJg0Pu6IN2VCT/71rmuVxC+tiAIhqo578uW/9U26OjzQFJJPGkffzdWgy/WZdYTcknymReZQQEvg6Zb1xdcSbC54qQfwJz0lRh3R3YHSKYPsKpC86HGYW6oocTdeMPzpGEcbqYxnEewAyPx1zV6fjmvvmq502/fpZHekj/uk8lDSnO6cbxf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(186003)(53546011)(6486002)(71200400001)(8676002)(2616005)(54906003)(316002)(8936002)(83380400001)(44832011)(6916009)(38070700005)(66946007)(6512007)(38100700002)(5660300002)(508600001)(4326008)(122000001)(86362001)(76116006)(66476007)(66556008)(2906002)(36756003)(66446008)(33656002)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UdKOl2/zOrgvOw3kIPViZVp9Ud8R3oZv3V741x2LYDDBSbDohjkjP8b+i3Qb?=
 =?us-ascii?Q?xG3+UmeYcc6We7xrcMbkzRkzCy6SEQOseh0jiN82q6APfP29S9eG02uRN7+O?=
 =?us-ascii?Q?zB+z4sk5/9olNGtUofb+v2nNlNwJqiDmtcpASGRFoUgE21NPXFHWftkMLR3w?=
 =?us-ascii?Q?DFkKf4EtKv4II7FtEn9hWuU7f0LWyqqcDhzfn26MMBCH8E3FIl9s+AxAETaE?=
 =?us-ascii?Q?58qd9arudzWtFCrWZhuSsEoL3ZNF9nQdECGvm2JyTNdgH4pKrnR8/HDefB2g?=
 =?us-ascii?Q?d+OR8GIRjUjUMckY7aX56CtqDkyA6KPUBk4CAsERYdnhXfSQ225hj4V/bgpZ?=
 =?us-ascii?Q?CMIFxgmqCe3tErjissuoIDy64ep8Epwfwglo7j8pG+5bMz2MrsLtsOYe+v3J?=
 =?us-ascii?Q?OWi+nBA01K4Wb7q2GwpSQ0mHq54stoNmZkp492b2xQfZm2zbOXwUbLgr6DvI?=
 =?us-ascii?Q?DZBIlPv7Ws5bDWbNgHL5aMxApYmWvcS7Ro6ynMokJaXzuOh6IZcTu2LrP2mT?=
 =?us-ascii?Q?UOAi6U4QUXhB5w8vCM//9uEtfnlfCb40qhP6uQYfmbaKgymE3lWNLYFPSgBr?=
 =?us-ascii?Q?yGDwXwmWBNrC/vQgFKgMkmwYpfVLpJF3qhE9chElNelv/0kQPMWTo55bOTE6?=
 =?us-ascii?Q?NdAG42vFpB7ZssVlEsXoZLa2dIXeptf0lyc7JlcomP+50fOzFxiZcroGqVGt?=
 =?us-ascii?Q?57EX+gNJQ4fNcEajDG1yd6iwrOq9etB4X0Y0Z3IUKgGOTNJxRRw0zw5J4WaF?=
 =?us-ascii?Q?/QjfJQkTtrRxoo63m1N8a1dSdn+vPkQ+AKu6rZiTki+AcMWeueGH7jowYECO?=
 =?us-ascii?Q?VTKSGdsf7NnzN8T6aai284loeruVGfcSuNv7B68rsvZul5AzEtLgr9ix+rOt?=
 =?us-ascii?Q?Ab2obOFck9s1x0mCVHl/sWO6MsJfqZNQlZ7IiRrNVdJVDr2Fu74VnsVPSZJN?=
 =?us-ascii?Q?U/Lvu9FEVZfAb1XAmak5dSjJAK2cAlvUROJ/eNQsli2JNoEmxhwCevDLm0d6?=
 =?us-ascii?Q?X3WL3e5ylthAXuThSET+oc2HGv9UQcKdMWr88sSjtppgD3l3cVACzQm916yC?=
 =?us-ascii?Q?WXIegRM8p7gTWOC5GvHlM6PR21vyCvYb1pzDAYkVjjJdcun/K194omgH9ZG9?=
 =?us-ascii?Q?yJotBGM+Niu9TMEX1lbCOVV1GFeUyEeMLLD/wHz4eueKfC2yRd2DW4cCFaBl?=
 =?us-ascii?Q?dAPfY8U5Iy+ykh4yLXjPcckwEFvMRHZ6RvS0VJ9v+3EX3qXLWyUUSoqZ81TA?=
 =?us-ascii?Q?Kjh4PxJ0VQ8CN7zSA4MlAtNGac04iFTrpVrXXFXQspUiMWEPmh9kkezWSc8G?=
 =?us-ascii?Q?i1eW+JWlztjjyRQfDbPn8qf3N1t1zvDFmYfOSXVgRUSipW8Qi31t9gJ6LWRu?=
 =?us-ascii?Q?J2TxWd72ATVz+iGMP3R4lrXfEyEST3eQXf5QqJxCo/ApPUZDsArnqfpAdQeJ?=
 =?us-ascii?Q?k2bAT6/+hIMU2a4H16tfaf2MaHd6bTaA/30rCmzQSvldSojS64VcdS1paf3o?=
 =?us-ascii?Q?zYYXGuRHLoypQi2G7oN4mnOy71ce8FTzmomlZhwZeUKVxloYwgIsBlSPRDud?=
 =?us-ascii?Q?cIx9g2cx7B4a1abTNzrBXD5Zo7kslJN7gLLmEU5PfX9yTcXkfc8thWgXd+1t?=
 =?us-ascii?Q?ZjprzM0mLUN8EVfRuZsLqlzTiEFeki9lJzW3vXhb4/r6EBIez4V9VQIQnc7t?=
 =?us-ascii?Q?tS6nag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D00DADCB7F3C7A44A4D99013ED38F872@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f8e45-438f-4842-0faa-08d9be9921a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 00:31:55.2127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8qxjHRJq3birLU3x/eOjIa2AX4LQAxM3YH03+thNpwtt64K6NotE2UIfoa3+tq4nseTiNzq4IJNPV2bou31Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140000
X-Proofpoint-ORIG-GUID: o7CnSECN6PsJX2efXwzmDF_37VbWuGFu
X-Proofpoint-GUID: o7CnSECN6PsJX2efXwzmDF_37VbWuGFu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_163207_363690_3AF3E4E0 
X-CRM114-Status: GOOD (  35.83  )
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


The main purpose of the patch is to get a bit more info into the logs on cu=
stomer production
systems.  =20

What if we drop the string and just display the status, DNR and MORE bits:

[   56.058003] nvme0n1: Read @ LBA 2048, 1 blocks, Unrecovered Read Error (=
sct 0x2 / sc 0x81) DNR MORE
[   56.058075] critical medium error, dev nvme0n1, sector 2048 op 0x0:(READ=
) flags 0x0 phys_seg 1 prio class 0

This would be extremely useful when agoing through customer logs.


Alan


> On Dec 12, 2021, at 1:52 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
>=20
>=20
> On 12/10/21 6:56 PM, Keith Busch wrote:
>> On Fri, Dec 10, 2021 at 10:54:45AM -0500, Martin K. Petersen wrote:
>>>=20
>>> Hi Chaitanya!
>>>=20
>>>> Although I always prefer descriptive error messages, I've not seen eve=
n
>>>> half of these errors in the field. This will :-
>>>>=20
>>>> 1. Increase the size of the driver code.
>>>> 2. Require constant patching of the driver code when spec is updated,
>>>>    I'm afraid this will turn into churn.
>>>=20
>>> Updating the corresponding list in SCSI hasn't been a big problem.
>>>=20
>>>> Also, we can easily track down the error in the NVMe spec from the
>>>> error code that driver is printing currently, is that not sufficient ?
>>>=20
>>> Only the block layer status is captured.
>>>=20
>>> In addition, customers are not really armed with the NVMe error decoder
>>> ring and are left with no explanation as to why an I/O failed. We have
>>> had good results in the field with the verbose SCSI error logging and
>>> that's why this patch was modeled to work the same way.
>> If they are not familiar with the decoder, does seeing something like
>> "Conflicting Attributes" really provide the user a better sense than
>> "0x280"? Either way, it sounds like they'd just open a bug with someone
>> who is familiar with the spec, in which case numeric codes should be
>> sufficient.
>> Are the existing nvme trace events not providing enough information? The
>> existing ones appear to have even greater detail than what this patch
>> provides. Or is there some other reason why the kernel log is preferred
>> over the event tracer for capturing these types of errors?
>=20
> Maybe the string info be added to the trace events? If so, we may
> need a verbosity level for the trace to record "only errors".
>=20
> Although the one advantage for the log would be the first time error
> status (or for generally rare errors).
>=20
>> On the patch itself:
>> I'm not sure having it be a new Kconfig option is a good idea since it
>> requires a recompile to enable/disable. Could this be toggled with a
>> static_key instead so we may disable/enable verbose logging at runtime?
>> The new "struct nvme_string_table" is a bit inefficient. Unknown errors
>> will scan the entire table, which will slow down our hot completion path
>> on any error. The codes are small and mostly sequential, so I think you
>> could create a sparse "static const char * const[]", then the "code"
>> becomes the index that can be looked up in constant time. The total
>> space of the array shouldn't be much different than the proposal.
>=20
> 100% agree.
>=20
>> A significant amount of the new strings are specific to admin commands,
>> yet errors for admin commands skip the logging. Why define unreachable
>> strings? Or perhaps a better question: why skip logging admin errors?
>> IO errors can happen in large batches, so perhaps pr_err() should be
>> ratelimted.
>=20
> Agree.


