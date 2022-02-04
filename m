Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C69C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hohR9WhaVtc522/P3SHGcIo83Trv/JL6Fu6aC0PEVU8=; b=eXNtEBBc7DHiQ7AAKer4MQqYfD
	RowboMI2RhTNugDeIzxGylTNdXWQUfanXR0INzEk+qi6HIeAGGtfUSkZF5yN1RROgcHf8L+nBBOSM
	UETQbqCxeLpjE6zM4pEzfCViN7+cyj1SbaDJZ7iYs0AuGlhT12hZ2sWiwzXnYY/G7omDJktmFTKBR
	mE3+pxWgQiHs7An3uwEvrpx1fEDLYC7PpgLJ3cI6P0VtF5YqPEkJ8w0eWTSV7ybTt0OFE4b6UZUDu
	lAn+5Ee1GYQ4QkY6SAOPwImGz05e5c0PjPEElx3SIzKPRsYJGtmewFx160xu+/bsxFanEnJZL64eN
	SKnoroDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFz0v-004S3F-1Q; Fri, 04 Feb 2022 13:52:37 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFz09-004RhM-RN
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 13:51:51 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214CUrCt032547;
 Fri, 4 Feb 2022 08:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=hohR9WhaVtc522/P3SHGcIo83Trv/JL6Fu6aC0PEVU8=;
 b=Bml9gvNecTM9lBRPlHqewyZqSVmrDirnX46qI32yPU2usGgsrCY+jFdB0FzrsiNiY2ox
 7nJ/zFTo3whvhlWzqBbWl6NzBBO0rBO55b5tWzqVjiHKT20H30DI7PV5xk9InWBu6z2M
 O5oHm6h8IJBv1QJhDZeh8LZ2OxH0GLRvAZ+Gsv6fjgpWP7c5KyZKeHtwrvuuJf8BsKPc
 trCGj6tPdSYgGQEfGCh5LIWWJfCvqOrF4vcE7r4PC4hZ6JVLQnImwj/6GNbwqomPS0yD
 GBKqUJY1E5BG0dVF142i4RDUFNdJWtjRc8gYU4eI8cILxxy4g0iWK2lALT3mxlUALHQ7 wA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3e0qyvjdrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Feb 2022 08:51:30 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 214Dp5Bn088840; Fri, 4 Feb 2022 08:51:29 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-00154901.pphosted.com with ESMTP id 3e0rcxrq34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Feb 2022 08:51:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBPeRRJr7OUTPOkSQ0sHDPQ3IYZKXlKc6VdtsSj/1SP50xG90iksS1CoLFV4qhk6aQIhjfny8vlMYwHZBd5PGC4sGU9hgPUqus04PdD7rbDNNE+I8OzHReBPVaUtnMAqEVYPUvVQneOZA3Iv7DZJndvLlcDudp25p+SKcNf1fpmOKxbx4gliOW4otbEZQuDUwsabIqIHWEZeVhb0i8AWO7KO7oVQJU0EIFjlsFjFVE3dMxfWwZLt4A3lp/OLX0z9CwCtCoCPglFh0YsTmN1S2fQ4NrINH5VBLtoqt8Kz6T6z9DvWDSq4sruZ7dQ7qg9gP4PFMJ3I5PXwgc3l3E76xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hohR9WhaVtc522/P3SHGcIo83Trv/JL6Fu6aC0PEVU8=;
 b=I7hwI6kZWhGRuIKIxQI+pbJrHO9XXyglPWKBD//hVaCaAnIxbABaF8gbwom51ffH4FNo95gl4NZX0+ANQKqSWUH033NZzZWbhHDcyjNeJ5/8CzKrzFBSxkUOhhp9xJkRpAt1CXvuHzFvbctIaylrl+VcBxY9to3OA6JUUL1l46rOOl590eF68olwGkqfN+UmQBT76k/YFktCIOd3n+tnY2V50lQQJxcK0dEDlaFI3BL8jrx7FtUTv/NuZESyy92W3qkHv2p+nFEAarwOlv86/LMAErYfDIbaCuMAIz8mvX7woaTa1TXlBdq1YpWzopuSUQ/6xDNHu2Lb6p9WYHcUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB2542.namprd19.prod.outlook.com (2603:10b6:208:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 4 Feb
 2022 13:51:28 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 13:51:28 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Greg KH <gregkh@linuxfoundation.org>, Martin Belanger
 <nitram_67@hotmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "rafael@kernel.org" <rafael@kernel.org>, "Rose, Charles"
 <Charles.Rose@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>
Subject: RE: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Thread-Topic: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Thread-Index: AQHYGUOendWsW+a1ZkSNb4HcstEb/6yDA9eAgABfJ0A=
Date: Fri, 4 Feb 2022 13:51:27 +0000
Message-ID: <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
In-Reply-To: <YfzZmxPrtXwavoRZ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=true;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2022-02-04T13:26:11Z; 
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ActionId=10f0b7d5-0223-4d60-94de-f59c9fe19ac3;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cbbfcc2-697d-40d3-e539-08d9e7e57126
x-ms-traffictypediagnostic: MN2PR19MB2542:EE_
x-microsoft-antispam-prvs: <MN2PR19MB2542B9FE9557472F59B4DE45F2299@MN2PR19MB2542.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TDRxlYs9f+EMsKa74tPCSLn1hkDWVaIHyJzs6lrwb+HdIrP8xt8UqWE/COPCCkrAwttWFoxh+4yQ00SqaTvUVKjre2Qh2xQ5I9LvxcsxktizSoOavAWd33JJPRB4ImstTBp015eaD0YcHGDF7FPz7cGWEpBCNB3qCuGdlpmH7XCO7E95GJfD/5qo20sSla2uTWKZ6Ke9iztbW97neGWhHz1ZjzXqIVu8lw/fZ5X71jt+IjoqxLmIr985r9jiiqfhClBOIhJYSxfCs06Ojig7acUpaQ9x1MNOxKCPO0jpoKG9Xi67JIPXz4+5TfgNqQTG90ctKmWoI+4dgZQd+B2kMDGCOxC21jztCkaavNM5l1PrZ460DecZcu9GvWZlU93E5+9rJ3RoTJIpUO7jdZEeifWgsc+rACHpHOAC7fjCm5s5Yyqckkf/hslKS/jWie75ktiZazzPVbABVLrD1eZ2qIQazHUPpsYYmALHCCcTf/3TXtlGDgrse8fTldv+12ElLPudm9ZeW1z5DhBClkAX32OhuYJzdv5MaqWy3FDySqicj2qj92nNZO73NeSouzia9Or3+xSe9NKwJxgDuDX+2C7gg/HD8KzxmHaocOFDvw2xveBRdkpp7w+2XZJnJSi8/nV7EnlglR7vnzvhYeW6oJ5fKCXjqfHEdEafUXxWuLLa4SUeDi1JwMVgDPM2K1Gp4J3aUIh6O3gyrfxC4DuMRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(7696005)(71200400001)(4326008)(8676002)(8936002)(508600001)(55016003)(76116006)(38070700005)(26005)(186003)(107886003)(66476007)(66556008)(9686003)(5660300002)(64756008)(66446008)(33656002)(66946007)(86362001)(38100700002)(2906002)(122000001)(52536014)(316002)(786003)(82960400001)(54906003)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qe0MN3H9G8jYW0BPu8mT10IB+tA1IZ8EQzlzjogSpcpP40nUb6ATknYgI+Wq?=
 =?us-ascii?Q?2Na3ZRJbcrU5hRDyLAnjEoM62FwaxUDieUgen5jnhea0sV5D3cAzwSXtk/Aw?=
 =?us-ascii?Q?coZHeCj1mfJCjuFrgFk421dh/PoTGCYYUqRg/d3DNR6M1mZ6NCKXY0h1X/Za?=
 =?us-ascii?Q?d2xqLYrW+Eq6ocPcUZY+m/E5miyTvYV+eJyTuy8IISstiCAwzHuN4ab7sM6x?=
 =?us-ascii?Q?53cxaQoFZ79JwnOGyVbYFxmi74KDMniQc/yZeHdF/nCDLkxZZt9Qvy5qJ1Pk?=
 =?us-ascii?Q?B3V6sGu4c3Xenzwd5NWMlRCBdZ8iOd+DdzXRqS/YH5flNMCbPKoM5wF9EJ3n?=
 =?us-ascii?Q?MfWnxi+bbO5O2PVgarujTtAy5lDqbjntGqKG4Et4wNF7LaUJ27l2e83rHbG3?=
 =?us-ascii?Q?2aaCBPbGiAhaEdUbYLAENkGk75YJDIvk3TBKGz8IW4leaavTkTACVj2OMIsQ?=
 =?us-ascii?Q?qp4R9BKk4gZaeh2vB5dTm6Y432EogSDSmNfOqTLhzfYC/R1kCN3V53JcqZAy?=
 =?us-ascii?Q?HHRi5SwEYukSQSlJELv/fp6pwOzvGOw+f+R4xXQf+Oz2IoaRNG9nA6mpB6DL?=
 =?us-ascii?Q?QF5CJy8FMwc+MmxLxaBSWpiUp+EIAIwyln5S9rmYu4yKFfqOVR1pLfnX0NhS?=
 =?us-ascii?Q?vfD6Ff+rl0eROitPZoaHLvrQ6SAOWnv1PDlL2dTGn8Su3coZdAAUwc4sS3b4?=
 =?us-ascii?Q?eBdNlJJq9HBVKUANHWQm1p7Nuc/4B5qXTuDnzFleBVYPFiOPsD9cV4OjTrvm?=
 =?us-ascii?Q?XSvky9iuCRd+oZaejAkazfY8HBwxC2l11GHKc/SX/355q3rLR5yFsvy+Os/h?=
 =?us-ascii?Q?GvFSl1QmWuk/ZyEdQQMhX0cwlX+1z1/q6bePEwMMPJFgO++gW8S9i6e98Iz+?=
 =?us-ascii?Q?rnJDr2uYAy8TKLIJopWc5swq6wixT4eQRmJmkGYSuB0htIGoj7XTBOc1Qcq+?=
 =?us-ascii?Q?Ax+WOCg3bmHLAr9vYpJXeBuyQTyJV0N/J7Tds7ZDTGKrjqtL9eEbjl26QFpm?=
 =?us-ascii?Q?cMKJCRHpO4RtRDJdTdRUh3kmMJkQNmAyk+6aJfS4N2FMr88BOrIRzNxuJVqj?=
 =?us-ascii?Q?fEt+fOEeMYOBsuAa009BsvJKpMA/BToSU7VypDIh9sNIE6eM/renHJ0Klpm3?=
 =?us-ascii?Q?Iivfnv07xIfz588wfhc0BJjAdv1UqlkDRHtoJbP+o0UkXYJNUg2lEqC3UqrF?=
 =?us-ascii?Q?6PklC30k1LwcF8Brz+JcvmacdctTKAlRteD2cT0jcguRt2T5DdZIjHFvEx8B?=
 =?us-ascii?Q?uTf28XykHoP50j1Z8Xa0yc7UD0GVuQJv+dU9PhDpVFwDHPUQkZiRxzo7N4GR?=
 =?us-ascii?Q?HZbQPEgbTBvOtqnYGdRoGFkN1ns8POEWBkfotEEi7JqwO3Giz8Q+p5TbVrYi?=
 =?us-ascii?Q?0+aP0PJ3XHbzZHw960tmEQITWThbGsuLG7v/uHHTfc9iyqpiZ2xHGIF38mog?=
 =?us-ascii?Q?EprHcOWypGuz/OQqFbx2gD9sSgmLfpXYYLQ9xjz7JL7qpTdCW8aZfcn3ULBy?=
 =?us-ascii?Q?hkH0HDf0skl7CqIDL95ZH/lUyBIoMz6reifdb9I1lU0DOfBaVT4fcAQTGnNl?=
 =?us-ascii?Q?MbM4dnQBs9h8O7BBqPCRDIYL+xpo1E68ouTKJnEN+G1KHM6bL6tYvZq3Xgd4?=
 =?us-ascii?Q?ndfD3LRSPYsLtM1d4XLpdXqiIjmEI/RZTmdETN7kG8iLQ5VizRDFLPnnrvxT?=
 =?us-ascii?Q?MUtuTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbbfcc2-697d-40d3-e539-08d9e7e57126
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 13:51:28.0443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNukcr3w9CMuSTxyZ2pRdEhH7i+TSjvQY2vPCeH/LjAcp+EjBCw3fh7IadyjNuMXluhg9k2BlZiS7sjW2KMjngkU2lL2hJSw9jFFfwEGhy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-04_05:2022-02-03,
 2022-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2202040078
X-Proofpoint-GUID: 0dAGVs8Q2fYdXgzP4Se6IVrij5DQPxf_
X-Proofpoint-ORIG-GUID: 0dAGVs8Q2fYdXgzP4Se6IVrij5DQPxf_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_055149_967477_0EBE117E 
X-CRM114-Status: GOOD (  36.73  )
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

> On Thu, Feb 03, 2022 at 04:17:48PM -0500, Martin Belanger wrote:
> > From: Martin Belanger <martin.belanger@dell.com>
> >
> > TP8010 introduces the Discovery Controller Type attribute (dctype).
> > The dctype is returned in the response to the Identify command. This
> > patch exposes the dctype through the sysfs. Since the dctype depends
> > on the Controller Type (cntrltype), another attribute of the Identify
> > response, the patch also exposes the cntrltype as well. The dctype
> > will only be displayed for discovery controllers.
> >
> > Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> > ---
> >  drivers/nvme/host/core.c | 45
> > ++++++++++++++++++++++++++++++++++++++++
> >  drivers/nvme/host/nvme.h |  3 +++
> >  include/linux/nvme.h     | 10 ++++++++-
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
> > b5e452aa3c0e..4e3db5ec3924 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl
> *ctrl)
> >  	ctrl->max_namespaces =3D le32_to_cpu(id->mnan);
> >  	ctrl->ctratt =3D le32_to_cpu(id->ctratt);
> >
> > +	ctrl->cntrltype =3D id->cntrltype;
> > +	ctrl->dctype =3D id->dctype;
> > +
> >  	if (id->rtd3e) {
> >  		/* us -> s */
> >  		u32 transition_time =3D le32_to_cpu(id->rtd3e) /
> USEC_PER_SEC; @@
> > -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> >  			return ret;
> >  	}
> >
> > +	ret =3D device_update_groups(ctrl->device);
> > +	if (ret)
> > +		return ret;
>=20
> Why is this needed here?  How did the class or type just change?  That sh=
ould
> never change over the lifespan of a device.  If it does, you need to tear=
 down
> the old device and create a new one as something really wrong just
> happened.

Hi Greg,
I need to expose 2 nvme attributes through the sysfs. There is the controll=
er type (cntrltype), which can take the values "io", "discovery", "admin", =
and "reserved". And there is the Discovery Controller Type (dctype), which =
takes the values "none", "ddc", "cdc", and "reserved". Note that the dctype=
 is only meaningful for Discovery Controllers (i.e. cntrltype=3Ddiscovery).

In my first iteration of this patch, I plainly exposed both attributes for =
all types of controllers. However, Sagi asked me to only expose the dctype =
if we're dealing with a Discovery Controller. Unfortunately, both cntrltype=
 and dctype are not known at object creation. This means that when the is_v=
isible method (i.e. nvme_dev_attrs_are_visible) is called, it is still not =
known whether dctype should be exposed. The value s for cntrltype and dctyp=
e are only known after a connection has been established with the controlle=
r and we have completed the Identify command.

Hannes suggested that we combine both attributes into a single one that wou=
ld take the values: "io", "discovery-none", "discovery-ddc", "discovery-cdc=
", "discovery-reserved", and "admin". But Sagi did not like this proposal a=
nd instead proposed the changes that you see here. Basically, we want to be=
 able to re-execute the is_visible() method after we have identified the co=
ntroller so that we can determine whether the dctype should be exposed.

So now I'm in a bit of a pickle. Sagi suggested this current patch set, but=
 from what you're saying this is not a good approach. If you could suggest =
a solution that would satisfy all parties, I would greatly appreciate it.

Regards,
Martin

>=20
> thanks,
>=20
> greg k-h

