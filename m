Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572FEC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6eWFLJwy1nB5WuGN8L0yapp+oyC92eyiEXTg2EztxM=; b=Bv3q82ccm0Y5ccapNS6z/IO4P1
	zf/3+5x0IhY+00bv+ceELHCLAXLpOBH3VLt/PY4S55UZPiZAn1IYJN4GD/6fEm2kBR2cTg3zuXIAe
	ewoQl2Ew7SuIFQgGZyjmBU2Xl07NrHUOVHigEbCB5FM8ZahqnIiBJCMvEg2rcabB1zItCibpY6V/R
	0abXvtaUmjPqaYHLZnvFBvJBqgN6jlYZnBQV4cDnZEb1ppxRnhbBVWf1dSJYbTZzmHaYrbmGAwAUs
	Q9CeZ7QfOerYsp5JFJkQVYVOvik1erGFVlf7ukGAmKZjY41EHZ+PyzqKsJPUd0y5V5dwogkVpNa4y
	xkM2LXYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFamW-0015b8-9t; Thu, 03 Feb 2022 12:00:08 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFamT-0015Xa-HT
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 12:00:07 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213378M9022197;
 Thu, 3 Feb 2022 06:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=G6eWFLJwy1nB5WuGN8L0yapp+oyC92eyiEXTg2EztxM=;
 b=bndoRmt1jA5tFbJ/VL6o0Tbu54nM7bLHBff4DrzKtkHSJWdazAdV9yGvStMt8D9mhbBj
 ZpcoXReDX2j/eJap7AueArH8LpPqYmL29aegStig7AT1nrYk8ZkcJCtmrh82NAcsmZbe
 rUUrGhJImhoyRxDBuPPsuoOJQt9o0OmFwroEzc47nB+bWRX6LJLT02tXfiIqpjj2t4c4
 YTXYTq/xBKEu3U0aZeyib+I6sHjkbyM/0VQHEbItNcP3mlW7Ok/EbjoQKSI5bxPEFHF6
 Ry4FlNnrerkITiKnfpKMTjd8oFlBY1ql1sYDwcbq8jl8QF0pL1GVynOXNu3aHyfI+uGI bQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3e06uthfkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Feb 2022 06:59:36 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 213BtKMC189094; Thu, 3 Feb 2022 06:59:36 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-00154901.pphosted.com with ESMTP id 3dyb18bjq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Feb 2022 06:59:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFsiuehWzvyLE867iZbGp/N8/nXpNpZGt8NdNpe4uyBgeX/Dh+eH748yCTnFLSU+Ljidk73mozTDN+jTq0ZYpbX5pAY7G3rntjLwRKczPgKJ0ixmYZ2C5QdcHqfCnHATHOOlv7cSRZxUzaE/EzWdwH46CQCmp+t3vWOIhnfKVMUKSm9arjE9PlLNH8ri+wmDCyuHLX+NkWuboMU0QFXbdWZut0uDgXiFK8oLztLNeYapTGVEbUYhWLfT9ZVd8wiM39lGhYhA8CGmEA8i+jy1SSqDZhD6wMMetueWUW5HEm529q9zPIMeGV5lJA0oLTxQrDTNCiq3cqNbFjcRPjqTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6eWFLJwy1nB5WuGN8L0yapp+oyC92eyiEXTg2EztxM=;
 b=A5QVrcF9ZPWKB9UQ+VnkjXNQxB5VPbZfU+Xxb5Ypf87GwGhzkg8RlicDEWt8tuM9OHN25aP/+MTo0A47OOHB6neCJsXb7X9LzSdykpisTcN9UmvFqBaX6wDYIR8MS7JNCdoTiegWU+liUsU7I9zIN+9Hjb4GBTw0zazhUf7eKaAZo1mef0pJQ1ZQZdOpr18/PE0JNcXSUoHCV9mYIsQ7HycDxc2Tr7pfZkfQUoRHrVUj09FbKvDq9owhR0I779zoi5ArclcKydSqQuOxOKLQgh5pg8r/05PYDFo7Tb6cw1uPYkSI8OcB6OYTYegS7AMr6JCJQ6ULIlq0IpdWpoXPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BLAPR19MB4531.namprd19.prod.outlook.com (2603:10b6:208:29c::19)
 by SN6PR1901MB4718.namprd19.prod.outlook.com (2603:10b6:805:df::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 11:59:33 +0000
Received: from BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::918f:610b:43b3:4646]) by BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::918f:610b:43b3:4646%7]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 11:59:33 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "Hayes,
 Stuart" <Stuart.Hayes@dell.com>, "Rose, Charles" <Charles.Rose@dell.com>
Subject: RE: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGHzVH84DVIVYUE+St1ikwYiM3ayBa48AgABM5JA=
Date: Thu, 3 Feb 2022 11:59:33 +0000
Message-ID: <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
In-Reply-To: <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-02-03T11:59:31Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=578cb23c-459b-4573-94d4-757b00b02ed4;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c563a9-6952-490f-ce74-08d9e70ca4b9
x-ms-traffictypediagnostic: SN6PR1901MB4718:EE_
x-microsoft-antispam-prvs: <SN6PR1901MB4718E74CD6787729B1BFD719F2289@SN6PR1901MB4718.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0T9OZEAb9Vbq13ofBZYn7iXP1SZS2bzWy3hoerbNmtG+Md5+D0KHQcOZk+4bwjgeTGQ/N/c3SpBegbLdD48xTDWt2ij1nqtR+Qa9o+/CXt1rIIUGftMPzXticdfqbXvep5C0LqSktsfs0wtXz8I+FbiKEuALlhiA/bdkNXmxeNdMb2o3nHbNXitJWgqWu3ultUlV55gJbotOgIWgow7nuDAnh346bpkM3LXaefmgCZ6sg4WwnOPpKwSBR/du7/E68yH9ezJOb28mIJoS4RSMLDB1i6LmdEq7gxfPLKEgYBQrK+i3GTwvu4J912c4CCEwC6ZATFLYuxtE2TOflqIvQ3T89SPT553aFu1CM3dTuaCBVionVXKXTslJJOqUcUFd+kOLbXEl9zpMSGjPzYXOpNca62R7dY3J2ysTM1hD4rkzzkkS6xVAhKP7EUxv3cMK0v53Yb/l1cNGBA4nyi5NA8/CgDPV8gAdqyp9ZC2reo2L4I/REuGmsM1/kp7AzvRhyV4wi9pcDJ1Un8bEkN3xenDiOtF6Puh8XA7s3k9sSxN4dv0aTS1sVzmrIkQA9VtZwtlE4RrIcZjeEnQ48KHMa3K0HG3aDWFUg188bt396JRP4OjTPLwoi8BmgR53HUVQPQ2896CV/8FWea0lq2U9aVxLk3FKpRrJ7VOGv3X2C2B2kI4g6aa7jQP9ImNiv91kGW8N4c4YuaTA10ARqAJmTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR19MB4531.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(8936002)(66556008)(66476007)(66446008)(4326008)(64756008)(52536014)(5660300002)(107886003)(786003)(316002)(54906003)(2906002)(76116006)(110136005)(33656002)(55016003)(7696005)(6506007)(82960400001)(508600001)(38100700002)(9686003)(53546011)(86362001)(66574015)(122000001)(26005)(71200400001)(186003)(83380400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhLRE45ZU5lRGdDVG0vdUtEM3FLaVVZT1J4bXlBRk4xakZPY090OVFrMjhq?=
 =?utf-8?B?WUlTZXA5dFA3VzZSdlMrbi9nY2lNU2lxbDNlV2V6SGZhY2tXNEVmTnQ5UVVz?=
 =?utf-8?B?RmpzU2NSTzZlbFJFOVZEZWkvbmMyQ3J4ZWJwS1hadVU2SThnaHhiTXZJNzJV?=
 =?utf-8?B?SkZCanJETklFakdlbUxrcnEyS0ZhbE0rd3Z6dDJJU2FYTXQzTjQ4RlB4M01X?=
 =?utf-8?B?K0JzMEFKVUZSVThkSTlFUk1ZMEsvdjArYWNWbWVla1RldjRsQWcrNmZmL2Ev?=
 =?utf-8?B?RUhQWStXRHNsRGJIUmlVMHZnaWpQaElWbytsVUZQbmJuQjk5MXdtdStCZERr?=
 =?utf-8?B?eGNsY09IYXFpWTkzNHJvVGFEbG4reUl5L1FaaFpVWHBrUXd5QmsvNzhxVUpa?=
 =?utf-8?B?ZjZPclRiWFpwcWFlZDM0MW9rQTZuK0dBWVNyZkpUcUZVL2wrTGkwSy9WdnR1?=
 =?utf-8?B?SVZFVjZIcHhnYmJJaTFtNmc5MUhZR0tQVUFJTFNaSTJmVTI0ZmxWbWVlbzJR?=
 =?utf-8?B?cWJVdTlOaHRPMHp3UUhuQnJheS9xa2VqeXdBa0lRM0pJN1pTM3VYZURIdTNr?=
 =?utf-8?B?ZTYxSzRpR29oZWdRMERYaHViaWlvMEs0cG9tVGNJUUg5ZXJZMU5GdExmRTNm?=
 =?utf-8?B?bEVIcjM2QnRCT1VoSit2eVdaTnI3WS93NnR6eDVFU1BLYlpFVGlNOXJiV2NG?=
 =?utf-8?B?TzBFL2d4SEIzcldiaU44OVFncnZ0TnVPdWZ0LzJNMEF1K3JVcFZwVDZKUjk3?=
 =?utf-8?B?WWRUaXB0cy95bGEzN0hjSUVNVjNiVnY1YnFGZjlKN0JXc2FmdUVqL3FKUGJw?=
 =?utf-8?B?Unp1d3ByZ0xwOXN4VFpPbjdWb1RqRnhoOW14VWl5T3NTYnJpekhUUmIxRGp3?=
 =?utf-8?B?K0E0OUF2NzBKcm1Tc3pwd1BSVUdOUlR6RzZ0MUlkZi9qV1grbTNyVDBvb0Vy?=
 =?utf-8?B?Q1RlMUJJNlIxQk1BdkNvQk55MTBTeFFNMnVaOStnSm5kS2V5WkVPcGdnMm4r?=
 =?utf-8?B?bXh2YWxVa1owQ0ZVNGdBWjZnS3Q3U3Z4K0p3WlhEdlZ1NlJGb3BRRE0xM3ZP?=
 =?utf-8?B?eEtWdHpKWCtQVlNveDlSWFNDM25VM0pBWU1qTGRONHFNbU1uOVFiYTBkVzlC?=
 =?utf-8?B?eS8vSThoK3B6a1FaTXNiMFMzUldaeTZ5c3RaWUJFVlRUYlAzN0s5UE5Cc1Y3?=
 =?utf-8?B?NjVubjR6VnZtay9PNys2MkRmUGRKT0lySUUxdTE1TFI1M0V0NThWd0Faa0tl?=
 =?utf-8?B?dWNVNFNZVDlQNkFoeEM3Qk16dkIvR0tJaG1TbzlZOW9hZWNNM1psWTZCNW9y?=
 =?utf-8?B?K2lXeFBkV0ZMRHRsSUF0eDhKNFVDWi9xYldUc1EwTTFsMDdSZkRSWVJaeSs4?=
 =?utf-8?B?VmtkS0VJaWxlNEhEOFNua25jNjEyd0NUOWdyamVwa0loY1A0akRmbTRla3Bl?=
 =?utf-8?B?R2NIQW9VdlNqeDlXZkpOODgwYWVrNGo0MUs5cU9ZamdTUW1HMjJNNW95NXNB?=
 =?utf-8?B?RWlMZ0wzZ005QUQwcHpUb0EzVEZxL01KSjlhTkZJNW40dzVhcTdVRWxvMm02?=
 =?utf-8?B?WmVnSVQ3S1NjZTZUSGxHUzFad000VmxsVWZ0QUg4OVdKM0FBT2g5eW1aS1lW?=
 =?utf-8?B?cnNsa3M3dExtSU12Qk5HZWxibGF0V2o2K0VZTGl3NXdMTExPeVF2bDhFRE5o?=
 =?utf-8?B?OTNUY3M2S3ZZOGdzQ1UyYVFlMkx6VmtGV3hURHl4eHF5cTVic0VxODBldThs?=
 =?utf-8?B?YlcrbEJ6YmF1YUJtREQvVlZ6Z0sxS0Ztd1QwQ2RNVVVVcXlsM29nTjk3U0hl?=
 =?utf-8?B?bUYrSkFvMlpJZUhGMENBL25NcEgxcDdMcUNPbklML3M3OGFPZkN4VlNBSXpU?=
 =?utf-8?B?WnZqMk52b0QrcEFOK0RFYmpzT1g1Q1QzbG9ZeG5FWkNmc0dTL0tXRk9KaG14?=
 =?utf-8?B?STFmMWdjWFBacDJHNHBtZkZpZm40aGZrTDZYd0ZhdTFqWXdsQkdmenBSckZP?=
 =?utf-8?B?SnJaa0kya3A4QTNodnkxaStuck51azREMzZWVitQSWgrWG8zSGxBNUZaTXZh?=
 =?utf-8?B?OUkwUDdRTldLNjJiUUNyYXZwUHJJYWptVnZnUHNVdUFyYndCckZFcFBZbnBF?=
 =?utf-8?B?MmtoQzJEaUJDVVJDWHFNNkV0aFVLMUlFdXBFTHJYMU1XaGFCNG5sVGRiQ2pk?=
 =?utf-8?B?czNGWUZxS1NtZGFIVTJuaVJJL3YycmRWdEZkRWE2UkZ4eDJQdDBQSXNqMzJR?=
 =?utf-8?B?QnBXdU04ZzM5YVdIL3RGUDBPS1JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4531.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c563a9-6952-490f-ce74-08d9e70ca4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 11:59:33.7806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsuCbuT2uPdLyUktKYuYl89wdqAmnIeTEsOMsK/GBP0fAmxlDIkqGfKkAcuhEQ7AWzMVEnHogtMgeWNs2VaihpcPkGoMMiiPcVNRiKsKix0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB4718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-03_03:2022-02-03,
 2022-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2202030075
X-Proofpoint-ORIG-GUID: sp9U0mzEwx5aMUNKPPt4FFgPHNYjLhyt
X-Proofpoint-GUID: sp9U0mzEwx5aMUNKPPt4FFgPHNYjLhyt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_040005_676608_FC2DF3FF 
X-CRM114-Status: GOOD (  32.36  )
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

PiBPbiAyLzIvMjIgMjI6MzQsIE1hcnRpbiBCZWxhbmdlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJ0
aW4gQmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gPg0KPiA+IFRQODAxMCBp
bnRyb2R1Y2VzIHRoZSBEaXNjb3ZlcnkgQ29udHJvbGxlciBUeXBlIChkY3R5cGUpIGF0dHJpYnV0
ZS4NCj4gPiBUaGUgZGN0eXBlIGlzIHJldHVybmVkIGluIHRoZSByZXNwb25zZSB0byB0aGUgSWRl
bnRpZnkgY29tbWFuZC4gVGhpcw0KPiA+IHBhdGNoIGV4cG9zZXMgdGhlIGRjdHlwZSB0aHJvdWdo
IHRoZSBzeXNmcy4gU2luY2UgdGhlIGRjdHlwZSBkZXBlbmRzDQo+ID4gb24gdGhlIENvbnRyb2xs
ZXIgVHlwZSAoY250cmx0eXBlKSwgYW5vdGhlciBhdHRyaWJ1dGUgb2YgdGhlIElkZW50aWZ5DQo+
ID4gcmVzcG9uc2UsIHRoZSBwYXRjaCBhbHNvIGV4cG9zZXMgdGhlIGNudHJsdHlwZSBhcyB3ZWxs
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIEJlbGFuZ2VyIDxtYXJ0aW4uYmVsYW5n
ZXJAZGVsbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAz
NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9u
dm1lL2hvc3QvbnZtZS5oIHwgIDMgKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L252bWUuaCAgICAg
fCAxMCArKysrKysrKystDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgaW5kZXgNCj4gPiA4NzJjMzg5ZGM2ZDMu
LmM2NWQ0NGZiNjVjNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPiBAQCAtMjk5Miw2ICsyOTky
LDkgQEAgc3RhdGljIGludCBudm1lX2luaXRfaWRlbnRpZnkoc3RydWN0IG52bWVfY3RybA0KPiAq
Y3RybCkNCj4gPiAgIAljdHJsLT5tYXhfbmFtZXNwYWNlcyA9IGxlMzJfdG9fY3B1KGlkLT5tbmFu
KTsNCj4gPiAgIAljdHJsLT5jdHJhdHQgPSBsZTMyX3RvX2NwdShpZC0+Y3RyYXR0KTsNCj4gPg0K
PiA+ICsJY3RybC0+Y250cmx0eXBlID0gaWQtPmNudHJsdHlwZTsNCj4gPiArCWN0cmwtPmRjdHlw
ZSA9IGlkLT5kY3R5cGU7DQo+ID4gKw0KPiA+ICAgCWlmIChpZC0+cnRkM2UpIHsNCj4gPiAgIAkJ
LyogdXMgLT4gcyAqLw0KPiA+ICAgCQl1MzIgdHJhbnNpdGlvbl90aW1lID0gbGUzMl90b19jcHUo
aWQtPnJ0ZDNlKSAvDQo+IFVTRUNfUEVSX1NFQzsgQEANCj4gPiAtMzUyNSw2ICszNTI4LDM0IEBA
IHN0YXRpYyBzc2l6ZV90DQo+IG52bWVfY3RybF9mYXN0X2lvX2ZhaWxfdG1vX3N0b3JlKHN0cnVj
dCBkZXZpY2UgKmRldiwNCj4gPiAgIHN0YXRpYyBERVZJQ0VfQVRUUihmYXN0X2lvX2ZhaWxfdG1v
LCBTX0lSVUdPIHwgU19JV1VTUiwNCj4gPiAgIAludm1lX2N0cmxfZmFzdF9pb19mYWlsX3Rtb19z
aG93LA0KPiBudm1lX2N0cmxfZmFzdF9pb19mYWlsX3Rtb19zdG9yZSk7DQo+ID4NCj4gPiArc3Rh
dGljIHNzaXplX3QgbnZtZV9jdHJsX2NudHJsdHlwZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gPiArCQkJCSAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1Zikg
ew0KPiA+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiA+ICsNCj4gPiArCXN3aXRjaCAoY3RybC0+Y250cmx0eXBlKSB7DQo+ID4gKwljYXNlIE5WTUVf
Q1RSTF9JTzoJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiaW9cbiIpOw0KPiA+ICsJY2FzZSBOVk1F
X0NUUkxfRElTQzoJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiZGlzY1xuIik7DQo+IA0KPiAnZGlz
Y292ZXJ5JywgcGxlYXNlLiAnZGlzYycgaXMgbWlzbGVhZGluZyBoZXJlLg0KPiANCj4gPiArCWNh
c2UgTlZNRV9DVFJMX0FETUlOOglyZXR1cm4gc3lzZnNfZW1pdChidWYsICJhZG1pblxuIik7DQo+
ID4gKwlkZWZhdWx0OgkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAicmVzZXJ2ZWRcbiIpOw0KPiA+
ICsJfQ0KPiA+ICt9DQo+ID4gK3N0YXRpYyBERVZJQ0VfQVRUUihjbnRybHR5cGUsIFNfSVJVR08s
IG52bWVfY3RybF9jbnRybHR5cGVfc2hvdywNCj4gPiArTlVMTCk7DQo+ID4gKw0KPiA+ICtzdGF0
aWMgc3NpemVfdCBudm1lX2N0cmxfZGN0eXBlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+
ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+
ID4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4g
Kw0KPiA+ICsJc3dpdGNoIChjdHJsLT5kY3R5cGUpIHsNCj4gPiArCWNhc2UgTlZNRV9EQ1RZUEVf
Tk9UX1JFUE9SVEVEOglyZXR1cm4gc3lzZnNfZW1pdChidWYsDQo+ICJuclxuIik7DQo+IA0KPiBQ
bGVhc2UgdXNlICdub25lJyBoZXJlOyAnbnInIGlzIGFtYmlndW91cyAoJ051bWJlcic/KQ0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuIEkgd2lsbCBhcHBseSB0aGUgY2hhbmdlcy4NCg0KUXVlc3Rp
b246IFNpbmNlIHRoaXMgd2FzIHBhcnQgb2YgYSBzZXQgb2YgcGF0Y2hlcywgZG8gSSBuZWVkIHRv
IHJlc3VibWl0DQp0aGUgd2hvbGUgc2V0IG9yIGNhbiBJIGp1c3QgcmVzdWJtaXQgdGhpcyBvbmUg
cGF0Y2g/DQoNCkFsc28sIFNhZ2kgbWVudGlvbmVkIHRoYXQgdGhlIGRjdHlwZSBzaG91bGQgb25s
eSBiZSBleHBvc2VkIGZvcg0KRGlzY292ZXJ5IENvbnRyb2xsZXJzLCB3aGljaCBtYWtlcyBzZW5z
ZS4gSG93ZXZlciwgSSBmb3VuZCB0aGF0DQp3aGVuICBudm1lX2Rldl9hdHRyc19hcmVfdmlzaWJs
ZSgpIGlzIGludm9rZWQgdGhlIGN0cmwgb2JqZWN0IGlzDQpub3QgZnVsbHkgY29uZmlndXJlZCB5
ZXQgKGkuZS4gdGhlIGNvbnRyb2xsZXIgaXMgbm90IHlldCBpZGVudGlmaWVkKS4NCklzIHRoZXJl
IGFueSBvdGhlciB3YXkgdG8gZGV0ZXJtaW5lIHRoZSBjb250cm9sbGVyIHR5cGUgcHJpb3IgdG8N
CnJlY2VpdmluZyB0aGUgcmVzcG9uc2UgdG8gdGhlIElkZW50aWZ5IGNvbW1hbmQ/DQoNCj4gDQo+
ID4gKwljYXNlIE5WTUVfRENUWVBFX0REQzoJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwNCj4gImRk
Y1xuIik7DQo+ID4gKwljYXNlIE5WTUVfRENUWVBFX0NEQzoJCXJldHVybiBzeXNmc19lbWl0KGJ1
ZiwNCj4gImNkY1xuIik7DQo+ID4gKwlkZWZhdWx0OgkJCXJldHVybiBzeXNmc19lbWl0KGJ1Ziwg
InJlc2VydmVkXG4iKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICtzdGF0aWMgREVWSUNFX0FUVFIo
ZGN0eXBlLCBTX0lSVUdPLCBudm1lX2N0cmxfZGN0eXBlX3Nob3csIE5VTEwpOw0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpudm1lX2Rldl9hdHRyc1tdID0gew0KPiA+ICAg
CSZkZXZfYXR0cl9yZXNldF9jb250cm9sbGVyLmF0dHIsDQo+ID4gICAJJmRldl9hdHRyX3Jlc2Nh
bl9jb250cm9sbGVyLmF0dHIsDQo+ID4gQEAgLTM1NDYsNiArMzU3Nyw4IEBAIHN0YXRpYyBzdHJ1
Y3QgYXR0cmlidXRlICpudm1lX2Rldl9hdHRyc1tdID0gew0KPiA+ICAgCSZkZXZfYXR0cl9yZWNv
bm5lY3RfZGVsYXkuYXR0ciwNCj4gPiAgIAkmZGV2X2F0dHJfZmFzdF9pb19mYWlsX3Rtby5hdHRy
LA0KPiA+ICAgCSZkZXZfYXR0cl9rYXRvLmF0dHIsDQo+ID4gKwkmZGV2X2F0dHJfY250cmx0eXBl
LmF0dHIsDQo+ID4gKwkmZGV2X2F0dHJfZGN0eXBlLmF0dHIsDQo+ID4gICAJTlVMTA0KPiA+ICAg
fTsNCj4gPg0KPiA+IEBAIC0zNTY5LDYgKzM2MDIsOCBAQCBzdGF0aWMgdW1vZGVfdA0KPiBudm1l
X2Rldl9hdHRyc19hcmVfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPiAgIAkJcmV0
dXJuIDA7DQo+ID4gICAJaWYgKGEgPT0gJmRldl9hdHRyX2Zhc3RfaW9fZmFpbF90bW8uYXR0ciAm
JiAhY3RybC0+b3B0cykNCj4gPiAgIAkJcmV0dXJuIDA7DQo+ID4gKwlpZiAoYSA9PSAmZGV2X2F0
dHJfZGN0eXBlLmF0dHIgJiYgY3RybC0+Y250cmx0eXBlID09DQo+IE5WTUVfQ1RSTF9ESVNDKQ0K
PiA+ICsJCXJldHVybiAwOw0KPiA+DQo+ID4gICAJcmV0dXJuIGEtPm1vZGU7DQo+ID4gICB9DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9o
b3N0L252bWUuaCBpbmRleA0KPiA+IGExNjJmNmM2ZGE2ZS4uZTMwNjI2YzAwNzkxIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaA0KPiA+IEBAIC0zNDksNiArMzQ5LDkgQEAgc3RydWN0IG52bWVfY3RybCB7
DQo+ID4gICAJdW5zaWduZWQgbG9uZyBkaXNjYXJkX3BhZ2VfYnVzeTsNCj4gPg0KPiA+ICAgCXN0
cnVjdCBudm1lX2ZhdWx0X2luamVjdCBmYXVsdF9pbmplY3Q7DQo+ID4gKw0KPiA+ICsJZW51bSBu
dm1lX2N0cmxfdHlwZSBjbnRybHR5cGU7DQo+ID4gKwllbnVtIG52bWVfZGN0eXBlIGRjdHlwZTsN
Cj4gPiAgIH07DQo+ID4NCj4gPiAgIGVudW0gbnZtZV9pb3BvbGljeSB7DQo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbnZtZS5oIGIvaW5jbHVkZS9saW51eC9udm1lLmggaW5kZXgNCj4g
PiA4NTVkZDliM2U4NGIuLmFmMTQ5NGQ4M2E1MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L252bWUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbnZtZS5oDQo+ID4gQEAgLTQzLDYg
KzQzLDEyIEBAIGVudW0gbnZtZV9jdHJsX3R5cGUgew0KPiA+ICAgCU5WTUVfQ1RSTF9BRE1JTgk9
IDMsCQkvKiBBZG1pbmlzdHJhdGl2ZSBjb250cm9sbGVyDQo+ICovDQo+ID4gICB9Ow0KPiA+DQo+
ID4gK2VudW0gbnZtZV9kY3R5cGUgew0KPiA+ICsJTlZNRV9EQ1RZUEVfTk9UX1JFUE9SVEVEID0g
MCwNCj4gPiArCU5WTUVfRENUWVBFX0REQyA9IDEsCQkvKiBEaXJlY3QgRGlzY292ZXJ5IENvbnRy
b2xsZXINCj4gKi8NCj4gPiArCU5WTUVfRENUWVBFX0NEQyA9IDIsCQkvKiBDZW50cmFsIERpc2Nv
dmVyeQ0KPiBDb250cm9sbGVyICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICAgLyogQWRkcmVzcyBG
YW1pbHkgY29kZXMgZm9yIERpc2NvdmVyeSBMb2cgUGFnZSBlbnRyeSBBRFJGQU0gZmllbGQgKi8N
Cj4gPiAgIGVudW0gew0KPiA+ICAgCU5WTUZfQUREUl9GQU1JTFlfUENJCT0gMCwJLyogUENJZSAq
Lw0KPiA+IEBAIC0zMjAsNyArMzI2LDkgQEAgc3RydWN0IG52bWVfaWRfY3RybCB7DQo+ID4gICAJ
X19sZTE2CQkJaWNkb2ZmOw0KPiA+ICAgCV9fdTgJCQljdHJhdHRyOw0KPiA+ICAgCV9fdTgJCQlt
c2RiZDsNCj4gPiAtCV9fdTgJCQlyc3ZkMTgwNFsyNDRdOw0KPiA+ICsJX191OAkJCXJzdmQxODA0
WzJdOw0KPiA+ICsJX191OAkJCWRjdHlwZTsNCj4gPiArCV9fdTgJCQlyc3ZkMTgwN1syNDFdOw0K
PiA+ICAgCXN0cnVjdCBudm1lX2lkX3Bvd2VyX3N0YXRlCXBzZFszMl07DQo+ID4gICAJX191OAkJ
CXZzWzEwMjRdOw0KPiA+ICAgfTsNCj4gDQo+IENoZWVycywNCj4gDQo+IEhhbm5lcw0KPiAtLQ0K
PiBEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdA0KPiBoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OA0KPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcgSFJCIDM2ODA5DQo+IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlh
bA0K

