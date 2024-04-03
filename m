Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E5CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNqXScGwst+5CBx2UEUpNPdUFqcVIcVITKoThApgr5U=; b=CGjvjJGItYTMqb6p1Zyc9zdH5G
	OgD66Q9bROnNSbeZz5x5UCAgsJ9yUgunko6jj9YKPY96l3weZ2FiaX9/5nokwZxPHCRri7oAxzBhK
	QYFzZRUjKl9H6fDMmhXgMUo7QNO/haoroMr+g8ped1h7wnQp/J3QowVFYVMMciCEREgYfYW3MiSlT
	ZGat086mABNq8B3WBliK2KLcr7KuxRKfpcrQOy720ZzjKbIOm9ngsg2O6v1AGm5ANyf6lY/QPsNVd
	ajujXfOCUkJyxNR0o73BGTyQgJEokhgeh+AUT6QKP2UZG6SE0xDVDfSLdDWHEwTQ5aZV+dh3zF5eu
	jCt4Zz6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs3i3-0000000H1HA-3nEZ;
	Wed, 03 Apr 2024 16:43:35 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs3i0-0000000H1Eq-2I9J
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 16:43:34 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433EOTXG016940;
	Wed, 3 Apr 2024 12:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RNqXScGwst+5CBx2UEUpNPdUFqcVIcVITKoThApgr5U=;
 b=JhNijoeJWpjIGDvy+5yNJ9jwMU6SPWON3Aom8E19OzD3ObEJyJG8zaZ54UbsGBK1kp9U
 PNLHSsMNw86Az3MxJs00Mfhch6GyF/h3AMTO/xOlgtLaowJXiasaMBHQ88FKt/4Fx8NR
 bDWeE2dTRLLUY5ygh2vKMWMoAgI9BZrlx05zeZKbShk2GCYb1Wsfb+OfcAl5W2wWTFKk
 PJtlOQeVCxvoF/N6mKHJLoZG0SOvZMNV+4e8/yb9InM926YGMOywjY43rDUAZPORE+Cq
 adxbjR3CIBdtiovUeGeRujmaPBm6PBWUwe7j1zmfN4232FqrOP3sWXLKeCBw1U/yU9lI Ww== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3x6dt5qf0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:43:19 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433GdGbC028711;
	Wed, 3 Apr 2024 12:43:19 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3x97dn3nmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 12:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frYgIHdKfM4Jk+ut4wXWIIv/EusGHQ7TPNfLyrbO6sloWH4NRtgfEYoH94qXpZcpN8Xu+yjwUo1P+0iP0C5NYU/+9BuUqVDPELnYYngwUCSJ52AUlxgABO28/4J33AR1oDVDOUTeEMVnw9ZCwXLuE6ngRfiTunDHcV/vnqs+hWZleEetrh/xUf0T+SbhoKqhJedCc3JgsYjILXCkXd1IpOLzAUK2L3bjLnRfx2g8CMtmfCwl6ZfpNtnzVXrsLWlvmZOiaFXvaInHkpIqL9RMFqjAs4h4UYLOxBoZN6GaHK8vxIqrEDxGFNyFEWkjDkDKLhI9Qi974j6tZt1x/uIfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNqXScGwst+5CBx2UEUpNPdUFqcVIcVITKoThApgr5U=;
 b=LagEvEQaOKUhgBJyVn8hNSRUePg0bhDBPnjuBgo8d3qnQxa3hy4agVp+YN9HMH7CDX+/9bi30BdoBrmWBm19dQuA8/oVG7NS9iO1wQO89/dVFR5vs4wXMF6a/f7iQK0NxS7Zd1TkGoiqp3WI5ITnQmx+ZHCUQTzsampHP87NjYcetrxkG/DdJA5Rp9Etb0MrZ2K5q9XJIuZ6LUAVzJZhCLoubimoDXE/KHD28VpM8rWiMlUY5gv496LJ7vEn1/Xd4gywjJkjho9BT7KaBdtCE7piNn6Aus7+755Z3P9nvJZB7GnxFZx7nCGA7ohwcvdeVdVQPjv6rCHzpFdL8Bk0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW4PR19MB5589.namprd19.prod.outlook.com (2603:10b6:303:168::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 16:43:13 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5e50:f156:27ee:9dfc]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5e50:f156:27ee:9dfc%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 16:43:11 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Nilay Shroff <nilay@linux.ibm.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: RE: [PATCH] fabrics : allow host to create duplicate connections to
 target
Thread-Topic: [PATCH] fabrics : allow host to create duplicate connections to
 target
Thread-Index: AQHahcu1m6JwsVxiLEuVMDgRFpowGbFWkImAgAAvzbA=
Date: Wed, 3 Apr 2024 16:43:11 +0000
Message-ID: <CO1PR19MB4885EF4B56B817B4B1C3FB24EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20240403133438.161916-1-nilay@linux.ibm.com>
 <171215230057.21309.17076148857202676100.b4-ty@suse.de>
In-Reply-To: <171215230057.21309.17076148857202676100.b4-ty@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=9c3d6e75-6072-47dc-86f2-804695808b8e;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-04-03T16:42:50Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MW4PR19MB5589:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Fo03Yi1lD1mb1SEcaX4xDLWFhWR+FXySb38LTEiwCfZkhUEJ2BtLCk1yQSwDcceU/zhHAjM2HkeeAdHtlIOXd0JlVVSECliS1dTB88pTY3UAewTPvuqss4Ni1tB/j8kJrfjDkJLIQDVDRKi1L79ovtin8W5jF1dy4x94dykZ4G2A0pfQWXDvXLvsNPYQBfUzYgxSczWqrCJkCcpzltfLg3lUDYzJPHBBZgXsI63JOJNkJCC/DCOjlMltskv/K+r2/6lcVKH17epajuDYhAYW00BvJjttA9RZmJpkzDx+jr7FotfWvPcg8xRdpEndx8BJmKfNPPCYdF9K8sxn8s7t4sinE12ltyoxppqEe7lJq7tCY+rWMgtjYrOZ+Zqx4EVcROfKLlCShNIBjOSoEJ8K368x/7qTlO8WbL49R0Qj2tQH3lgkwhJ1vT0wcZmJvnIckHI8ByViq2K1yjiRAQHQj4i23pYUL9R7jQulDlubtGa1DKm8AdCgpjChcEtkldj1RDQfWv9/n/Tuk7FJQbvjzuahGYyMt7XlH9S7YibNIqfzXJN1WLyL7vsGllHss6aW9wjPkkq/91B+Wsb6o6+XuJ5UHFo1SSTce459CFmTjiZnUah8Gontt9zP/TQuoGvxMjdi0iIsVt76kivTfPe+hYQLo+OhvPLexZv7Qe1dJE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?RURpVzJERUhqb2oxQXFVKy1WdWJTb3BsVmV3d21XdmYwMVFLa0pyMEcxSkk4?=
 =?utf-7?B?ZlY3VXJRNmdYR0llVnhKaGVhUWVnOTNFZkhoQlpxeDdTQ0R2MDhRbDczZzFM?=
 =?utf-7?B?cFNlRXgySERqaEZLZjhncWhzYistVzNOT2R5a044Z2JYaXE3Uk85NVhQNist?=
 =?utf-7?B?QjdzcGZRcHJHOTNHKy1Ma1ViQ3Vzd1h5UGtELystT1ZhQWVRUFNRc01OWXNp?=
 =?utf-7?B?U2IrLVBJZHUvQnQ3QTdVVTFoUExSMVp2aHZpTDY5RmVZaXhBeGNneWhIZlBm?=
 =?utf-7?B?M3AzNG1nU0F1N0FNcmJDUjBHcGZNZ1EvVWZzcXFxdXh5SGJmMXZvZmJWbXAv?=
 =?utf-7?B?R2FhdTNLN2dJM1g1UHhWQW1CcU9FNEFPREJaclFPNk04VDdMSVY5VGg1VDFN?=
 =?utf-7?B?elM0ZmxiOW1SeDAzbFBaKy1PY2YvMHFzZmJseEVnRDdTOEdoMzFCS1M1aG5Q?=
 =?utf-7?B?STczVCsteHNIalY3aXc2MkVUKy1aUW5DblZXeXVqQmZ3NjFvSG1MYistVDB4?=
 =?utf-7?B?SnQxbEs3RFZ3STZsdUtMeDhLMFVQL0lsKy1VNVI2SmFhZVB4emlVKy1BZ3pJ?=
 =?utf-7?B?L05ybzE1YXdvSHVYM0o4M1oyRW8zQVBZUDU0NURxR0EzMXo4VXFINXdJdERs?=
 =?utf-7?B?cUR1M05tcUcvczFqKy11aGRMWExOVGRhVmprOFpjdXltWHkwQldoeTd4dzkv?=
 =?utf-7?B?UkE0SGpvU0Evay9CeTh1V0Y1MFdnRjFKWU5VTC9hKy1WR1ljY2pmdGtHNmJk?=
 =?utf-7?B?QnFjbXZWMlc4L09lWDlyRHJJclF5U0Y5QWdFaHhKaDJPQmlIV3p0SFlyd1VP?=
 =?utf-7?B?bEdBTUpMdktWMk5jbzJHQWMycTlzcWNkdjFGbFBpdjhtdUNGSFErLThxRUM1?=
 =?utf-7?B?NXlyMVpkMElFL0NEc0I2RVJPbHJHNGdvUUp2ajl3cTVqNlh0VHRVbjdVdUY0?=
 =?utf-7?B?eTl3aERTU3E3dDh2T29rUzU4cFd6UDUwcUJiQVFPUVg2S21JazRwU0Mvd2g4?=
 =?utf-7?B?UVFmMDRIV1Q0eGtxeXZ1MTl3TUhCamJYei9ldlhuVSstWk8vekFTMmhZcmsy?=
 =?utf-7?B?MVYybkdKWnY5T0tDUFBYdkFvU01jNzEzTTJrWTZVTVdxcktPSVB0a09LWUN2?=
 =?utf-7?B?UkJla1VaSnIrLW4vYmNoTm05M1k0VUZaL3J0b1VDMXNXYy9HeHNoeVlBV3Ri?=
 =?utf-7?B?ak91b2VFYXBObW8xQWNQMWRuQlVPZzl0RjYxQUQ3NTNkb3pyYnFDalhzcWk4?=
 =?utf-7?B?Wk9CeGtQbWNUTlBzRE00WW8zWVFReGEydWpKdlhMM0luNHBZVVZGSW1DZWdv?=
 =?utf-7?B?bEVKN2JWeDRLVE1zanBpOUsya2lWd2lZKy1xbjBlT2RJeWRtWVhnOTc2ck44?=
 =?utf-7?B?TXNjNzJlQVNsa0RpVWVRZ1lXeXJjVDZ4ek1wUGU0d0gxKy1zNW1VM1VBN1JX?=
 =?utf-7?B?ekhvTDA4MThhWVViaThFNnVhQjRWb0hNY2xEZXdBbElQVmVsNEp6d2l5Qzh5?=
 =?utf-7?B?dSstVjIwYkZPYmxHMGFlZ2I5OTd1UHVkU3NObmNFZ2FsWVBTcGt0dmwzOEJm?=
 =?utf-7?B?U3FhN2lQajhMQ1ljemVwd2MzZmp1NEN6dE9LWE1uaFY5aFcyc2F2R1Y5ZGhV?=
 =?utf-7?B?MkNlV3JtdGJXVzFyVWFWVWNDOGgveTdyRystdWpIbGtIMXgvQkZrUzUrLVU=?=
 =?utf-7?B?QistNHJHeERSemRPOWx4N2R1VmEvcnc5d1NqYnZoRHNkTVVkcHN0Z3FlTTZT?=
 =?utf-7?B?dmpKWlJKZnoxNkc3aistM3RDSHV2U2FkU1hYelBFU3VTeWtwM2RtRnhEKy1u?=
 =?utf-7?B?RGF1cXFpQTY5WkJ2YjFueGxocktRKy1BQkU4d0pOemJJV1hZa0h6TXM0TzJP?=
 =?utf-7?B?THo1amZWUzVOb2ZucGNic1VSdENOWUh3U0dhdXllb2lWRXh4Q1FIeXpBZUpy?=
 =?utf-7?B?OWo4VFB2VVdzSlNwNVdxaFFXRTlOUlB2bEVOR3JpMjBHTUNIUXRXNHcvNmxF?=
 =?utf-7?B?b3RqcUIvaE1Lb0VUOXNSL2lNUGg1VlJ0SkVZREd4djYwZmYvRjUwbjVYVW1U?=
 =?utf-7?B?Z0d6Z0lDZFdIYkZaWlJsUTJWYTNMYzdJTUVPUUt0QlpsMEwvanZzZnd3ZjZ6?=
 =?utf-7?B?bUMxcEFLRFovZ1BqWTJCUWdhN2hxZkV6dXpSbHhVczA5M2ltS1k3MXVOdlpJ?=
 =?utf-7?B?dXdPTXZCeA==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53eef3c-4770-437e-3288-08dc53fd2634
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 16:43:11.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1V63nTVA72KJb75aLR0BmfCu4cckzPqexAW5bY8S4/UEdHY6IeFonP3Gy9vT4xspIYngxYFJtNLegrLxg/4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_18,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030113
X-Proofpoint-GUID: ulL21B4swJrL6nhvx5CDFPsN4NANTkRA
X-Proofpoint-ORIG-GUID: ulL21B4swJrL6nhvx5CDFPsN4NANTkRA
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094332_667930_8949FABA 
X-CRM114-Status: GOOD (  12.87  )
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

Looks good, thank you+ACE-


Internal Use - Confidential
-----Original Message-----
From: Daniel Wagner +ADw-dwagner+AEA-suse.de+AD4-
Sent: Wednesday, 3 April 2024 16:52
To: linux-nvme+AEA-lists.infradead.org+ADs- Nilay Shroff +ADw-nilay+AEA-lin=
ux.ibm.com+AD4-
Cc: Daniel Wagner +ADw-dwagner+AEA-suse.de+AD4AOw- Engel, Amit +ADw-Amit.En=
gel+AEA-Dell.com+AD4AOw- kbusch+AEA-kernel.org+ADs- gjoyce+AEA-ibm.com+ADs-=
 Engel, Amit +ADw-Amit.Engel+AEA-Dell.com+AD4-
Subject: Re: +AFs-PATCH+AF0- fabrics : allow host to create duplicate conne=
ctions to target


+AFs-EXTERNAL EMAIL+AF0-


On Wed, 03 Apr 2024 19:04:16 +-0530, Nilay Shroff wrote:
+AD4- Apparently the nvmf connect code doesn't allow creating duplicate
+AD4- connections from a host to the same target even though user specifies
+AD4- option +ACI---duplicate-connect+ACI- or +ACI--D+ACI-.
+AD4- This patch help fix this issue.
+AD4-
+AD4-

Applied, thanks+ACE-

+AFs-1/1+AF0- fabrics : allow host to create duplicate connections to targe=
t
      commit: fd8ecb054ce53acae504e54666bec6c9976a82dd

Best regards,
--
Daniel Wagner +ADw-dwagner+AEA-suse.de+AD4-

