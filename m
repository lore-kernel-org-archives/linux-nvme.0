Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFF2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrltvPiSFTQ7EHX3GlxhAJ5xt6q2ZHjzkt2iHrR7Fmc=; b=MduAfCoI6yaYxTX4j2ySjR3cNQ
	fKu3oJNgqQtTukOlouJzNF6+rGc5KmDaA1scNBlF47Pk4PORE0fz1q7lE90IUYqMq/p0YntIpE32/
	7bnWiaeKePZGnnPV+/KdABMaOvErpKaHwOScAtufAgbOIkX7sz+so7pjTCXG3tArWSql25r20CDkY
	heuJujYpCvRxlpEk75HgfXWnDE8vwAEGc2eQMNgW2ZD+RgtClHnyE3Yr3oOfPqeblVQD4cvLhAUxC
	hlx9NjbT6wlYJInerBlM2UCn2dMTPvsUPQox9UTSlisSJKrjnv9KcMNqQwJQVvjaED1osEXhhnDq8
	YyTIsq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC6n1-005IsU-AU; Mon, 24 Jan 2022 21:22:15 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC6mz-005Irz-2v
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 21:22:14 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OIvuSc005517; 
 Mon, 24 Jan 2022 21:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rrltvPiSFTQ7EHX3GlxhAJ5xt6q2ZHjzkt2iHrR7Fmc=;
 b=ZPCnoPWlPtLawY3OYq6Ik2nXol3+lGxfYRPicCMHlLSdnpRgz/q4kmqJhqBADB7qH7+W
 PjvAjfXgZcs1cPlY+P1c+dQ/q5775WJKjCGrxhVOxYN6Cd4C1USxoHuC7B9PNJ2k6TGe
 GgQ1DfKrrGIG4DhnVo6rhu1NcwJuFE7rzTMJWn9jXF/ENeqsrTwJNhq9qYwRbEjom6vM
 d37v6I1spNesuQD/MsC7Rb4UpD4q4Dwyj2YN0D93cYSRIvZp/X9tuI08d8Y7/BM5s9Cr
 7dyGrGRIX3Gp+lXl+CANOVPZaL1O+xNy9C+DQnJ8r9Fm5T9Hd0ahAOfopWv+ey6xlHfa 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9ha56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jan 2022 21:22:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OLGvTH067835;
 Mon, 24 Jan 2022 21:22:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by userp3030.oracle.com with ESMTP id 3dr71wcqtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jan 2022 21:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxFtB4MfnOymHPRzcE2NYy4C+llgB3wg2b9ROVBmEn8DShxPZ5vB5eNj6nV9VlgeK4B51rYBzDRwlTnFFMIVMnKxeHCslzcpy8g6t+U3E68Yeclp82MJ2uZiOe4lBjX8zv/S8WKrwLQaypt0XkW049Y99AuqjM1i0m/qTVhgUikD5V8FeLBGOVb4qDvE1UeOftjTG/3kWAjfUce9BH0NgvCRWKzG7VTijdA5Zs21vsWGtHCDXGrsCx1yMvzcIOmykITXIuOvl+I7Vm4bHxYdeWVk3X1Wzm4nl2yJH/dwjqX1FEfteQMHdsP3Xh+rbFegcLe8lLLqdpnRisbnuYFQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrltvPiSFTQ7EHX3GlxhAJ5xt6q2ZHjzkt2iHrR7Fmc=;
 b=W6lbAa2mfR8XVpmJp3kXNMUNFqqh75YAmYx/nSRBKCRCCFFIMsN8AvCUgJ+Oh8KhkYvScV+orwmyjhTXRduUOHXtDCjkGVlhjiksHgkSEyE5PwIrVbE4AaqxVYYhTNo3OiIIa9+XBcIi61X6Dx6h+OUZHbsJvJAkYaQVK4rZ3jzGfXaVZPmVVp1SaMv1O6HQDveChD4dw1AywNLNKXRc0iDhZ3ms3a4IUL1NxviV1wiqfOsNJw6f/mjs5kdXW6jCTEOK62ySaj7IYg6uKM3wgqEbp5gE4Dg/w49tH4kLJ5yqpFFfvpQEet2e9bwXrurCP+P+nbZwviXQsal/xDnjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrltvPiSFTQ7EHX3GlxhAJ5xt6q2ZHjzkt2iHrR7Fmc=;
 b=kaBlXMjaNBjuG1vfpuc86ZknNOh+GoGIuF4NKyS3+rWoQWL77HEcrRnErf5Bl5BhRv/KUfQyVMDJa87MoWxywBEgWTrTctl45oCYGnwxrkhXwur8EEtyNJH9cOGRHaP2QdLOjxlWya7NzK1IYKvBgy6aA78HaQcxp5nBH9Ya/RI=
Received: from PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22)
 by MWHPR1001MB2304.namprd10.prod.outlook.com (2603:10b6:301:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 21:22:00 +0000
Received: from PH0PR10MB4807.namprd10.prod.outlook.com
 ([fe80::85e:badc:9527:5e13]) by PH0PR10MB4807.namprd10.prod.outlook.com
 ([fe80::85e:badc:9527:5e13%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 21:22:00 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V4 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH V4 1/1] nvme: Add verbose error logging
Thread-Index: AQHYEVOCjJcCogv0VkeuvVM/pcPtAaxynQaAgAARKoA=
Date: Mon, 24 Jan 2022 21:22:00 +0000
Message-ID: <3E924BE8-8BB6-4A89-85ED-7F1D75D56BA6@oracle.com>
References: <20220124185144.53810-1-alan.adamson@oracle.com>
 <20220124185144.53810-2-alan.adamson@oracle.com>
 <20220124202033.GA1683949@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220124202033.GA1683949@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5112f49d-3343-4bf0-cbc8-08d9df7f8f13
x-ms-traffictypediagnostic: MWHPR1001MB2304:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB23047FBC27D165CECF5170F1F45E9@MWHPR1001MB2304.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvmAqizuW/T1AVx4n3wEBqadog5MC26wfR0Tf2gWHwphvLhoBOgBXhqXXw89Ni205ExbMDgGJWOkJvuzCMT2SVFdE23nlAXdjKhGXaEwPj0Fy56GJMYN3X9tlJHCfsi7TcFo45hTr4bXuzv66c9arRj1NZkZGJW7iLDj/knxP4msfWyTxA/g6RBo6k3tbLC6i/VjdtPzm6S5goTp/2P4Gbv7K+Fzxi9M0VMVu/m0NAyHT6lOrEoct/Sy1bdgyyBew0WmMgvsqy+x8SRSF/VWsWvukDF9W4oKcSGQBKFIk68DdJptRgss8XyzvZyFT2gFW+i4MCO3DW7sggGJNBcThEsJwe/53nv5LqBAU9SNxrCFpHkvmumfVb3CQ/CgxT2DyLx7brrdeXHy9RvuPRfAugu+mVH8g6+0HdWJVOUAL3wDMpTYT75J7T5L/KUhgvk9TkLFgANd1dPuYeIOkDRPbUUEacmK/K6g8X4VlMuchLsdO32wG+WaXq781zr54P84LGTaLUZtJPfLbvJ39+DuM8gWiaOwwIqof4pb/pouSurqB50/wfeCAJINuY6lZOhAF9rYpc1IMrxKkacIh48wgTE9qu7oQ8WQCb+EsswmbQOeJIZBydRmEd6Ih6K+K6epDMjgsMAWz3QLDyy0CFKbd/IhbNICejFYjZpPFxnAfQcPWsCx0O5hX3kX6acoNugXt3W+QwDNfuxAeFyb5CwIfhNZOZhmgr2cHV/3fZMfeoGSg8sKOvCSa2jL+6DpBn7S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4807.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(6512007)(186003)(122000001)(508600001)(4326008)(38070700005)(54906003)(76116006)(2616005)(8936002)(33656002)(86362001)(2906002)(44832011)(71200400001)(6486002)(4744005)(66946007)(64756008)(36756003)(6506007)(6916009)(53546011)(66556008)(66476007)(5660300002)(316002)(66446008)(38100700002)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xdM4qfYnWSPIvvR+nl5/uRGdCwaLI113h5P3MBMLwEojqUTBe6vXZSjU4zDO?=
 =?us-ascii?Q?O32hl6n+GsXS3/inVGR/h5Eg2zYROIDOGin0E5M5Izt0cCnAT3EZhkUDcVa8?=
 =?us-ascii?Q?9cF9zXdy2jI9+5jDhOQOp6vTWSV/FzCkBAYCoZO7z+LMgu1fAniXVn8Xyqes?=
 =?us-ascii?Q?6CyPmMtBRRUiGISHr9OLFiwqdgNDTO5Y3pzcDhWQzTIZkI31sF7pnz8r9zeu?=
 =?us-ascii?Q?B3YmdOv/Vv3ofZCMc2sfECSAr/h+o1NgGmeqQ6i8F1n7tg/HIbKRAf5cHm2a?=
 =?us-ascii?Q?HvfKajcfcmLb1gM8MYNGWicMFod4h+G+v1co8MGnkub7NZovH3OqD8QciFKb?=
 =?us-ascii?Q?o3d8IZVRDs/DmEAWfSUTvRnNiAKlC9JdhLuACnWmBk2Ccvle/xHzNVN/buRP?=
 =?us-ascii?Q?YPQx39KPp0NAS5j4ta6EBvEFuQ4eRek3FE8u2Gz7IYix+u7m+lJkIvDgC3yj?=
 =?us-ascii?Q?H3dECg65ZCCiGD0fEQ1lqYeRYdjgsgheBKxog7jX2HGUm/32Wkm3yCioVudO?=
 =?us-ascii?Q?bu8fRS9ftaz3WRGeZP+XhhlT+Kncc89WyD0sNFnufQVL7QR6GjX4V1B0bSxY?=
 =?us-ascii?Q?E4Or9Jv928JZv4klqnzFCbwRD2BZHGlrkYoi1zJIcYrMLwx4DjnxrUzhlfkj?=
 =?us-ascii?Q?8Ufw9JMtf4OxTOiJmIeeU57pNgIQZ0N5f8juGx/3PGk1f7hQk9zjfKxmuc4V?=
 =?us-ascii?Q?f4GuCLLavQeVxkZ7tVZ/MqKQOVZ1qhzegWriIeIxq0O+1tD0P32qt5WMJo1Y?=
 =?us-ascii?Q?k50WMsBm8beZ/Bv2KTlbbnjn2etbL7ZlAlZnj1SY3JuoO8lRpUMM5jJcBnx3?=
 =?us-ascii?Q?clP7QdnBV9inCWu+YvOFIEGGyWxBzjKf+Ut8pqJdi3sTbRxkMT6Uv1BjNBNF?=
 =?us-ascii?Q?x/xsOqWeIHOIbmWDOt3TL2m4eko735jSFzcb29jOKS4qhCTZcCuYDxg+k44O?=
 =?us-ascii?Q?JNbwOz6pk9BRT0uzSENzXYi19BW6b2YKC0UcWIui8cP5/jWKYc9fTC0uApKL?=
 =?us-ascii?Q?Nw4efI0LbT8cfMGzCty+Us3ClP6sHR3Asx+RoexmUL6Y8/0Kc/9DKDPg7nCZ?=
 =?us-ascii?Q?xL/bbCaLE2M/GMFzS7bj7uTGTa/RWHSabNb1HfNdFCw4I9jzT2TAtJMuYWE0?=
 =?us-ascii?Q?9y8dplMhiTfLXkiPFjfUWfOO4ouKp7fvBaN5Lu/xwXXlte0ZpZ8+jOspUewA?=
 =?us-ascii?Q?1nFY4mIYVhPp6SVSqkimg+bvfDdB7tekxHNt/TpLraEnRb+qeFrBwmH7Bkjw?=
 =?us-ascii?Q?nDz64rR6TuOWrufbN/0BOpwFPXHVptRQBC9OtgeFiApp5VMjdGcGgFHeix0I?=
 =?us-ascii?Q?nLunhsA5xupXfshHdRT5nwyjy7HrXVB+z/2qphZ4AWd/Atc3Sw1RguS2niJI?=
 =?us-ascii?Q?sswfZUfqnscq6obAa5cISIov900/zZ6p71x2DvoIhefXo1/V5mPBTYcbGEFc?=
 =?us-ascii?Q?G0gDDI0Vo8BPWXM5xXAFx2wiuSTZWG5qv5TX0rm95Is9FxKOa4rJbGaMPyV1?=
 =?us-ascii?Q?vUtYQxKvnk8MYtS1AMWHutjj7tHGhPiz6b3pdrIuoSbV4DEvm/V1bUpDSmRQ?=
 =?us-ascii?Q?kmcpETneG23Ke+Ymv0DU2fyuxsLHp0F1pe0dq3DqAtvUzsW4KQRS9Z2MotKS?=
 =?us-ascii?Q?QNKYTmj2ENcnznCRmjr9TgZzN0mYCqCK881P8qJZJi57Eev5WJQ+pBFOTTNO?=
 =?us-ascii?Q?FA7xyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F85F8DD972B3346AE0EEFD2AACB60DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4807.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5112f49d-3343-4bf0-cbc8-08d9df7f8f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 21:22:00.3121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyOkothUVqJOViwrXGkHcIGvbJg8WwaVLWVWTc1udzbqdMRew/9t0HWP8qRB6wU5bxjDTciC51I9Qeiq9bJ34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240138
X-Proofpoint-ORIG-GUID: wvY76K0ob9B3IdzmA4L2TjFCrbIAcNIp
X-Proofpoint-GUID: wvY76K0ob9B3IdzmA4L2TjFCrbIAcNIp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_132213_238372_75C3C765 
X-CRM114-Status: GOOD (  17.71  )
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

Thanks for all the feedback.  I think the patch evolved nicely.

Alan

> On Jan 24, 2022, at 12:20 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> On Mon, Jan 24, 2022 at 10:51:44AM -0800, Alan Adamson wrote:
>> Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
>> a verbose description of the error is logged, otherwise only status code=
s/bits
>> is logged.
>>=20
>> Verbose logging examples:
>> [  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Er=
ror (sct 0x2 / sc 0x81) DNR
>>=20
>> [  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command =
(sct 0x0 / sc 0x2) DNR
>>=20
>> Non-verbose logging examples:
>> [   41.280509] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0=
x2 / sc 0x81) DNR
>>=20
>> [   77.249153] nvme0: Admin Cmd(0x10), I/O Error (sct 0x0 / sc 0x2) DNR
>>=20
>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>=20
> Looks good to me.
>=20
> Reviewed-by: Keith Busch <kbusch@kernel.org>


