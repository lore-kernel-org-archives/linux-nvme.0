Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7473CDB47E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X78d61eR1zN5YHeM4Zxd7S8CiCahOjd95t4NBaxBlXc=; b=rlBhV5Gxd5OX+lSVMzYxWrQuFF
	42Y6F/0TpII1W4feLRnpDDk1h0J3tB9J3lcNvGRXJEWBOAJxF6DMeBLHtFiVMRMczZwhdnZT8kq8z
	9N/RzxUmul8qndCokLriu6Ntxvbs0vW2itxRVfRnJvfil6L/5C38F/3AwFNbF2n/blpAZkrIj5Tai
	Gu1H/iEgjztDfqxBbnD9JhOqBpYRbv9ufJ2k9SSbuV2OufLhgPKODhhN3n7VjcYpqXBia6FUaXUyC
	mwdXiOwHJ4fWbQ+Dldy0XexaJnPO9BWF9AlakP+36hfunm0SA6LErPIUKDW72fdExlbILfuIioIZq
	aaOfNJog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqwHY-0018uO-2H;
	Thu, 12 Oct 2023 14:03:20 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqwHV-0018tj-1B
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 14:03:19 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9FcNo029727;
	Thu, 12 Oct 2023 10:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=X78d61eR1zN5YHeM4Zxd7S8CiCahOjd95t4NBaxBlXc=;
 b=N22X5UVtaKqTkyzb0GBqmupPLP2QRlDgMXzF2gYUeJ6rmkHNXyrEuF/Tr0QMY5WOSpLX
 kLfjs+cCC55M0A+uE1NL8y51Uzzc9Z0zfr0JR5myzohmNbY5Zsai2Hat8z2njb6TWDcE
 5EFxAnqWU1CanKU8KpIRHcF1M2poCM4CBHAzG9ZUxtN11zVJEHtVoS0p4RkoSNbkD2h/
 aK8gWaQF7vqe/3jWwlxcQW/bYR7I4mmBDLQObkVCP99GcUWBis6p4v4O3rQFlsZ/+osH
 VLfTMK7Pk7+dOKkGJQ9eQUfdY4llHKxq5Srr77mTOJqUKBk5RjvtTsUz04+ho9aYeDCp Xw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3tk2nhfy1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 10:03:11 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBo7IA016930;
	Thu, 12 Oct 2023 10:03:11 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3tpg92an2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 10:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eak/pccnSGxUrF8F/gCweETpkMY2cMk4kjov8RrmPb5+dxc+Ku8y/TCjdl+2q3Vu4yu8aTEkptn4L5M2+4Olu1xSDc60sNBF1lodQUB0Tt1V/vOywv79jWcrTFH8G8uWhj7ysJ6qHUdZXQAVO5MtWl0xbGb2gXmKNs0mhOV6QEJNkhRDpIek1xLh2ML1Vepj9gGvFnINb51DeuIq29NgY2wen2TIUi0QaPtPwZNTXzocGnVQGrOduC1lQhG7M5Ke2dQ+ZGpE5rwjMymF7yOCMhLofKDctGEeMWlB9bvph72GwoBjYlaSSho043YUeUNVLZ/py+JJxGDMo7a3DK+s3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X78d61eR1zN5YHeM4Zxd7S8CiCahOjd95t4NBaxBlXc=;
 b=L6NiOV3qAZHTEPKPGK2DPOxiA+sh6ePdR7M53CWKlBaqYZHXxalvag1blk6VMhifvL+Wq1b1Hl3KzeQvdLQnzmqV4OT31h7K/VpqE2whJHhyd464SijaIHYsekH6RxAzvdW7q5e0HGsSevQrgdHy61RWR6QT7ldLDTmTcFzSD6g/ozpTLdBMq+JtgyI26wxAoWKq/jzz2mOnbI1rTqzBdll6giFxa1WUrjv+D49j3wLbPd1ooszmQn/eapePOc9THctZp9wM9U6zLHT/Nwybwokv/Kd6PPtkFt6Y8hd+90i8Fum20ohqGYr9qjHFu7yvvOvXb1RdZwbL8iDXMOxckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by LV8PR19MB8249.namprd19.prod.outlook.com (2603:10b6:408:191::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 14:03:05 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::9e4a:1e0d:3a93:f7b9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::9e4a:1e0d:3a93:f7b9%5]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 14:03:04 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>,
        "Zinger, Eldad"
	<Eldad.Zinger@dell.com>
Subject: RE: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Topic: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Index: Adnq7iO1RAClALWAT0iWmuSPClnDIgABdewABIf6UoA=
Date: Thu, 12 Oct 2023 14:03:04 +0000
Message-ID: <DM6PR19MB4011AF5CB8572996E0D8E855EFD3A@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
 <8e8072d2-1564-4879-8f00-682f5367bee0@grimberg.me>
In-Reply-To: <8e8072d2-1564-4879-8f00-682f5367bee0@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=cacb747c-2f09-466a-b520-8dec822e9e7c;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-10-12T13:56:26Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB4011:EE_|LV8PR19MB8249:EE_
x-ms-office365-filtering-correlation-id: 005d054f-dafe-490d-0039-08dbcb2bf479
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+8/UaRWhuc9/iAWqDszgY0njJ69iMGNEKvfBbmBsAXYpsNvvHtO5tN8EgISbXF3/gCT5Kbyc92Mtcn4jd2nxJQpUoAwUbv6J8cz/d6POM0BiEiE5QdEf5f7aXFD9AGm/987KlAXwAZfVXQxgOaz0MzeU2ZL42HTwVpheV1qyCgF4d+e9UYQz+VQr/2joceGFrNio6tSwaGInAerVfh2UwMa2dP3jVcwIGkdL4Tq2NkKbkgiLCLQO9Xv5FPVoKVYXPnZdnMl4Bn5+QqGmqeamJRgqb6gU9aueQyUgfbcCQEW/L3O33yxntgaCM9QKvkHadd+VkV8EfUsZts8sxs8GCWCiZrnkvSf4mdpKBB0uG1WGobB1B+oTOekdHZltaSjGz5Gdb5pjHEAIX4UqS2mdngPGOcktDpwz0sDOD5Xp+GHvT6xggpHThMO12UGC50KcPowUi4GF8ttgln/hDTLYoannvaoXlzdJoozrSYN6z3EVZ69dDYntwW9x7Ncc0v6h3y4v3LCOga1QHmLwEDL2FDs1iZR5YU/8K6NADIhpxwXC78fCOlSsDUy6RZagTZV0H5AT5oaYUfnDj8LAgmTy4a+RswXrKIMPanmmvMU/5pPTVyXKtITV0TFGGKzp6HZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4011.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(122000001)(9686003)(55016003)(38100700002)(38070700005)(26005)(82960400001)(107886003)(8936002)(478600001)(86362001)(5660300002)(52536014)(8676002)(4326008)(33656002)(2906002)(71200400001)(786003)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(41300700001)(66946007)(110136005)(76116006)(53546011)(6506007)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?Wmp0VWlENlV2SFlNcnpCNW1rWE1Kc2ZOaDZhazMrLXFzRVdDcmd4RU5ucEhD?=
 =?utf-7?B?MGUyMWtHQzlRU2NJR3VNam5tRVIrLWZRbk9OVkhVSWpnMFVGTm5CRXc3Vyst?=
 =?utf-7?B?QzRvSTRPVFA3akVaVmRVWkpEN0NDdDRPczhOZHF2NEJnR3puL1JSc3Q4dkZG?=
 =?utf-7?B?TTRQL21ENEx4U0ZkOEVmYTJFYkN3bm9EZXRMKy0rLWx5RTh6Ky1Oc0dmWkZO?=
 =?utf-7?B?R0IwNnRBVFRHbGUrLWJQZWt3VHFMeXhjeS8vMkRtYWVlV1N0S01McGxRaUxk?=
 =?utf-7?B?UXNrTkM3UU53bUxBMGRqRUxPbEFkMm03cVRqSVZQTU1kUEtndFFWS1dvZVdL?=
 =?utf-7?B?UWZIay84ZHBqUjh2WGw0NWxjd0hZV1lla0NFbVo2SHNaNFlYVmdvNVM3cnlj?=
 =?utf-7?B?OUI4bmVQc204QndISHRhdVdYcS9BMHUwOU02a3liNVptZystc1R1S0QwSkkv?=
 =?utf-7?B?Mm4rLUNHL2dhTXQxc0tZa2xZcWdSR2xMeS9tNnk1eGxEanVRWFFJb1haQUJN?=
 =?utf-7?B?SDFlbktYUistR3I4UUg4T00wNistakhwcystT0ZRTUs5eWRHSEN1ank4L3dP?=
 =?utf-7?B?UVJkQ29yaXZaRystTDY5dktzSXhUVmpISHNOUEZPNG5iSUJlVEZGcEFwd1dk?=
 =?utf-7?B?NjVndHVJV05sKy0wKy13VldpdElPZ293MDNDVFpYVk4rLXZsZGNjTW82SE9S?=
 =?utf-7?B?WVBicDU0bDJ6V1FxNGRQcU9NT1JQQkFZWnY1em9Qc2dTRVZvOSstUkZNNVhQ?=
 =?utf-7?B?bmNISWhvazBqUlVDOHMyT1QrLVZINWM1NGJFMUtlTjRhNTVsNE5DeXlnVGZz?=
 =?utf-7?B?MUI1REdDR0JrNWxwaFRlZnFBVlNSQnZqSzVzaGFHODlVbUhQVzVYM0txZEZy?=
 =?utf-7?B?c3ZzSnJra0dZYnVBTHBoM0hvZXprUVNHMlRzZkVtRXFxZ2Q1V3BZdkgyZFdJ?=
 =?utf-7?B?b0lsOTc3cmphYTFxQXdoRzNGKy1aQm5OWHNmTUhBKy1sM0VkVmNJb0pJaFRJ?=
 =?utf-7?B?cTg5OVlEaGlHTWlCcjZPTmRuR2FnTistN2kwVVpjMTdneWhuQmNiKy1rb2ll?=
 =?utf-7?B?d0Z0RXZ3L3QwaUxlNHdiTDJZQVdVSFQ0YjBQQjRmVzFVaDU0dm05TC9nUzI0?=
 =?utf-7?B?ellTNDdHT3c3WGJ3bHNpQzdDUEhOdmFnOHJMUElqVHhYamdoNXpOLzRrY2lG?=
 =?utf-7?B?NEtTVUQxNmFVYWc1WCstSHpNTjdpZXFGV1pid1MxUHVsbUd2b0pLNVRaQ0RX?=
 =?utf-7?B?Rm5aaGZZV1RybGFUa2ViM1pZL0ZEV0hKYmtLV0pFTWljQkJaWkd2VTgwOHBJ?=
 =?utf-7?B?VE1QZmVGYXgrLTBEVHZvU1htSUhPRk44R2xvR1AyeFROczg0bjFhVWpOeGxH?=
 =?utf-7?B?Zkg5T3l1WEROcXZsZUMwVXhibTR2RnpNMTYyZGdOMHRiWCstWXMxQmNqZFls?=
 =?utf-7?B?T2hha3N4dVI0YkNEYnRUdlBvemRLNTg1eWNPWnVqbWxvMllveHdqN1c2Q1pT?=
 =?utf-7?B?VzVDa0FUTXJmL2YrLWd1Q3c2THRoSnFOM3o1anhSYXdRNystRTl5Z2tXUE95?=
 =?utf-7?B?WDg4VVlIRHVpRWYxZUpoQjA0a0RRVFY0Ky1scFJrcmw4T3JDL3N0QzNSdHRY?=
 =?utf-7?B?VlBiWlVxbm5Od2lqbjNnOTJyWDZqNk5HelJxZTloZ01ZU2lEbXJ4ZjRvcVJB?=
 =?utf-7?B?ajNYdistR2M3ekc5blFmeWRFdVp4b28vSjF3aHlaOWd6aDRodklBS1poWXVm?=
 =?utf-7?B?bjFGWm9FZWtYWWRJeGQ3NnVqcmlLU2U0cWt3QUxScm1SM3VBdUk5NGtYSUJh?=
 =?utf-7?B?R3dHL1JZN1VXQzZnMlB5TWhTN0MvalJQdU1WNnlDaG51dnF4bEVxeGxGRVBI?=
 =?utf-7?B?a3IrLUk0T2NPaS8rLUVJTXQyT0lVWGZuY2ZOSllRVUp5Qnc0SGh3SjduTEtL?=
 =?utf-7?B?SkIxSmk5YkowU3M3aXV1dSstSExRdlVSWXV5MUxkR1lvMkdVQ1E5bDhwUi9x?=
 =?utf-7?B?dFkyMEM0NEVnSmNKVWpXMklNLzJoSTlzNUtkVk0rLWk0UDlDNHJVSkovUWc=?=
 =?utf-7?B?VistSkNyd0NHWXdzVTArLTdzUkREMFpQT2JMY0Y2SXBOVjByMVpFVktEbjJT?=
 =?utf-7?B?YWNLWFlMMWw5T20yQndXRy9qeGhFd3JFUk4zMHNZOFliSFRjRTRFcytBRDAt?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d054f-dafe-490d-0039-08dbcb2bf479
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 14:03:04.4187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hyv//3RPSP555wBcmjO9p9eC+Wcgbhacvz5Du+THj3GmrSJKvSeJnxoYzb0Rh3AZ1o+fQNU1FgC+IBQrI30JBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310120115
X-Proofpoint-GUID: PnisEDErbcFfRJ2feMk_BC1zbTJlfzbi
X-Proofpoint-ORIG-GUID: PnisEDErbcFfRJ2feMk_BC1zbTJlfzbi
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_070317_460175_E8BDC82F 
X-CRM114-Status: GOOD (  20.06  )
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

Hi Sagi

The patch causes double completion when 'cmd-+AD4-exp+AF8-ddgst +ACEAPQ- cm=
d-+AD4-recv+AF8-ddgst'
Other than that it works fine and solves the issue

With this patch, the meaning of cmd-+AD4-rbytes+AF8-done becomes unclear to=
 me,
It is now more complex than counting the bytes we read from the socket.
If the IO is split between multiple PDUs, the rbytes+AF8-done represents th=
e bytes read in each PDU not including the data+AF8-digest except the last =
PDU.


Internal Use - Confidential
-----Original Message-----
From: Sagi Grimberg +ADw-sagi+AEA-grimberg.me+AD4-
Sent: Tuesday, 19 September 2023 15:23
To: Grupi, Elad +ADw-Elad.Grupi+AEA-dell.com+AD4AOw- linux-nvme+AEA-lists.i=
nfradead.org
Cc: Engel, Amit +ADw-Amit.Engel+AEA-Dell.com+AD4AOw- Zinger, Eldad +ADw-Eld=
ad.Zinger+AEA-dell.com+AD4-
Subject: Re: nvmet+AF8-sq+AF8-destroy stuck forever when data digest is tur=
ned on


+AFs-EXTERNAL EMAIL+AF0-


+AD4- Hi
+AD4-
+AD4- I have an issue with nvmet+AF8-tcp+AF8-release+AF8-queue+AF8-work hit=
ting hung task after 2 minutes of waiting for nvmet+AF8-sq+AF8-destroy.
+AD4- This issue reproduces only when data digest is on.
+AD4-
+AD4- I am inspecting the code of nvmet+AF8-tcp+AF8-release+AF8-queue+AF8-w=
ork and I see
+AD4- that the code handles 'data in' commands This means that it calls nvm=
et+AF8-req+AF8-uninit for any command that its data is still in transit.
+AD4-
+AD4- There might be commands that the data transfer is already done, but
+AD4- data digest was not received from socket yet (aka rcv+AF8-state is
+AD4- NVMET+AF8-TCP+AF8-RECV+AF8-DDGST) The data digest will never be read =
from the socket because the socket is blocked by NVMET+AF8-TCP+AF8-RECV+AF8=
-ERR Hence nvmet+AF8-sq+AF8-destroy will be stuck forever waiting for nvmet=
+AF8-tcp+AF8-try+AF8-recv+AF8-ddgst to execute.
+AD4-
+AD4- Can you suggest a fix for such an issue?

Does this (untested) patch make the issue go away?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index 97=
d07488072d..f5eaf3457ada 100644
--- a/drivers/nvme/target/tcp.c
+-+-+- b/drivers/nvme/target/tcp.c
+AEAAQA- -204,10 +-204,16 +AEAAQA- static inline u16 nvmet+AF8-tcp+AF8-cmd+=
AF8-tag(struct nvmet+AF8-tcp+AF8-queue +ACo-queue,
         return cmd - queue-+AD4-cmds+ADs-
  +AH0-

+-static inline u8 nvmet+AF8-tcp+AF8-ddgst+AF8-len(struct nvmet+AF8-tcp+AF8=
-queue +ACo-queue) +AHs-
+-       return queue-+AD4-data+AF8-digest ? NVME+AF8-TCP+AF8-DIGEST+AF8-LE=
NGTH : 0+ADs- +AH0-
+-
  static inline bool nvmet+AF8-tcp+AF8-has+AF8-data+AF8-in(struct nvmet+AF8=
-tcp+AF8-cmd +ACo-cmd)
  +AHs-
-       return nvme+AF8-is+AF8-write(cmd-+AD4-req.cmd) +ACYAJg-
-               cmd-+AD4-rbytes+AF8-done +ADw- cmd-+AD4-req.transfer+AF8-le=
n+ADs-
+-       u32 total+AF8-len +AD0- cmd-+AD4-req.transfer+AF8-len +-
nvmet+AF8-tcp+AF8-ddgst+AF8-len(cmd-+AD4-queue)+ADs-
+-
+-       return nvme+AF8-is+AF8-write(cmd-+AD4-req.cmd) +ACYAJg- cmd-+AD4-r=
bytes+AF8-done +ADw-
+- total+AF8-len+ADs-
  +AH0-

  static inline bool nvmet+AF8-tcp+AF8-need+AF8-data+AF8-in(struct nvmet+AF=
8-tcp+AF8-cmd +ACo-cmd) +AEAAQA- -265,11 +-271,6 +AEAAQA- static inline u8 =
nvmet+AF8-tcp+AF8-hdgst+AF8-len(struct nvmet+AF8-tcp+AF8-queue +ACo-queue)
         return queue-+AD4-hdr+AF8-digest ? NVME+AF8-TCP+AF8-DIGEST+AF8-LEN=
GTH : 0+ADs-
  +AH0-

-static inline u8 nvmet+AF8-tcp+AF8-ddgst+AF8-len(struct nvmet+AF8-tcp+AF8-=
queue +ACo-queue) -+AHs-
-       return queue-+AD4-data+AF8-digest ? NVME+AF8-TCP+AF8-DIGEST+AF8-LEN=
GTH : 0+ADs-
-+AH0-
-
  static inline void nvmet+AF8-tcp+AF8-hdgst(struct ahash+AF8-request +ACo-=
hash,
                 void +ACo-pdu, size+AF8-t len)
  +AHs-
+AEAAQA- -1221,8 +-1222,8 +AEAAQA- static int nvmet+AF8-tcp+AF8-try+AF8-rec=
v+AF8-ddgst(struct nvmet+AF8-tcp+AF8-queue +ACo-queue)
                 goto out+ADs-
         +AH0-

-       if (cmd-+AD4-rbytes+AF8-done +AD0APQ- cmd-+AD4-req.transfer+AF8-len=
)
-               nvmet+AF8-tcp+AF8-execute+AF8-request(cmd)+ADs-
+-       cmd-+AD4-rbytes+AF8-done +-+AD0- NVME+AF8-TCP+AF8-DIGEST+AF8-LENGT=
H+ADs-
+-       nvmet+AF8-tcp+AF8-execute+AF8-request(cmd)+ADs-

         ret +AD0- 0+ADs-
  out:
--

