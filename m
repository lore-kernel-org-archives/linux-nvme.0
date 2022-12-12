Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797D9C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y0Hrpn2J82cl9ckpJNiHPVsMeaOXkop2x05lCSKe18I=; b=dw7fJZn7Qb0UwoRR5gFVvemBjl
	nYHBKpB5bZ16GO0iv4a5caRI852WDE7QR+SW/jPJ/c2vSxL2ESCj/FwDp+QviHGkVxkGl71Mh/9AE
	wY0uD6X9V5nbZgtGciHBw9En7Xik+v1Zmu3hp1atJAmjW/lcAYsu0Tg4XHnQSf69QeLWwq9paeHV5
	QVJq0fZuPnPMfzJgJ8nXhs9J1fxfG1gacPd3e88OwDeRYEgcVNd9kfUt0/EiHpebZuKaDrYjWWb3f
	T8bBy5uJt0sqN0qSDpRfsrts3A90NR75bPsiuExEYKg1JikE5LCRX1F+TC2Gb/Y6qHeFwlqpZx1RE
	XppIdk3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ogV-004fcC-2G; Mon, 12 Dec 2022 19:41:55 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ogR-004faD-TR
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 19:41:53 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCF1p24021698;
	Mon, 12 Dec 2022 14:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=y0Hrpn2J82cl9ckpJNiHPVsMeaOXkop2x05lCSKe18I=;
 b=pZ+Gi3nP68xK6PaAe64RZ0B3ZBu47RmQ9BPkXXfWz+w/yRoaIG8/Szc4pXI+qZXNwIWJ
 2k1fs/Bwicrcs2wFh877IYQePiS/WAPzsgsgRRUzJpvdOp4Ohvrxhl78KR9FnXg3Jcqy
 YslUvd+lOTTNpeBZ9H+DADzgHEnw+vc5yApu37xpGe5dC2QbPpc1C3XWpN90aXfCIico
 YQkcR5Nxgue1lk5U43mOAm4fl+bY/3wVqqZ+4xC6DwNAjART9HuiEUo91iNovjWTEQ6v
 +0P2LP8tpHDsADEE8WZ+kb8WE/jHOsUoLo/IGj5m2QwO3/t+4juhvj4gqyEadDPtEsC/ vg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcpaqkay9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Dec 2022 14:41:45 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCJTwUf024792;
	Mon, 12 Dec 2022 14:41:44 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3me7h9trh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Dec 2022 14:41:44 -0500
Received: from m0089484.ppops.net (m0089484.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BCJdJ1e025753;
	Mon, 12 Dec 2022 14:41:44 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3me7h9trh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Dec 2022 14:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItT21ML8t3amaHxCuToxeIoINNPncc7gg/vB0ML4b7wWmnex2sz+ZqjBNLt8wOD473Vt/SU5sC+3gysLJ7sAtOUXxzlVp5Py+cIV+ie3dP2jSGhMzklUKixvcI+clne8TqJJI9++Xr+hPSzRQ/u6U3YsV5i318GMTY/Acl/3IwcuEMxPLMBk+u72WULty612nJ57Dl3JHTStQcLCESq7SEBhoc/bEVov/nZcz/qjOePi9HRDoFgwppiroxGRKEZcYlPWfzPB4AZNqhje232IUrmSIhxRcYlq6E/ogfJqya0gVCR0wA8PmP6e1dIWi2oAZKvcjcF0faMIlnD8ahbf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Hrpn2J82cl9ckpJNiHPVsMeaOXkop2x05lCSKe18I=;
 b=RAQhcho4bIl4oxzcOButRkktCxI85QN+sAr2BxAcrDy7f319ZcvnieW7L3Oac1zS6A6N/mr7dMvoh0ls1+793MdOqG1b44NEmAMSJBhgEUjenIO0xOI/EgBv/f/Kn5sYBbGzkiuTz/OUJA2Z/mkFfdDXBO1qF16Tg7ahzt8RftHfn+ACz+gHwcgKJKmUAXc2yQ8PxQfMYolUviyIH/xt4mj1yhNHlzzoRAKCJA9b8Lh/XmCm3bGlWon8pbixo1Jz0et8QpNHnwZ8z9aVgLtFu43zEhakHnbbr+BtM3alJ4Y68jECK7f3EExHUXpJdR/MqHRgfNtfIL/boXUr0eRhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SN7PR19MB6609.namprd19.prod.outlook.com (2603:10b6:806:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 12 Dec
 2022 19:41:42 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:41:42 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Caleb Sander <csander@purestorage.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Topic: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Index: AQHZDjW1GXOjLfG15ESK+Cpp6Jy2Cq5qck6AgAA0kQA=
Date: Mon, 12 Dec 2022 19:41:41 +0000
Message-ID:  <CO1PR19MB4885973C3DFA52FC1A6D09BCEEE29@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
 <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
 <CADUfDZo88Z5Es4CF+X0LMOJChsRCXK23xzo9xQfd-pAdMFATNA@mail.gmail.com>
In-Reply-To:  <CADUfDZo88Z5Es4CF+X0LMOJChsRCXK23xzo9xQfd-pAdMFATNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-12T19:40:58Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=554543ec-4706-457a-bc3a-e104221a25e8;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SN7PR19MB6609:EE_
x-ms-office365-filtering-correlation-id: 448a36e0-0e50-4b2e-21fc-08dadc78e4dd
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xlt5zhKNVHMdzAoFa3+TmdK5WAFqRjTquQkyL2CQNeu+kQ+lb9yAFlQRW2vbRu2aeJxZI+mgoXt6qXcbc85OIQ6zJZcbBtLsNh8tAmiUy2tDMW2K619upoaQjOAgcu6XNbk7mD5h8cyMuGPIzaXtmj9mvYox5Hp+keQKYc5PqzsgqVvLR9x2SPMIuBfmqdMzOfTsf7rk5EEfHJJlNAU41UYDQpbXPtE9n8qAfL8gIcW93D72aVkIlEIs3FYolq337cplvDQrytD+KCGjMCUdLimxqq9CGGBPFY2eSAsZIVxPSi7FNkUNeH/AyRg45RJBTQcEFGdwiQZwCGC5OgSObtN+ns99NYpa5TnYVmVcfIbJcm5allGvezYMNJaL+ePhF+y9ao7gP9pssZHfrbm3RWyc8wFfmZiHcp2PeC2tzU5Ethl7e6B4Ck4zZvadI4nf/z+1MrTbNj7P8G/EFE1lBggYRtE2kBIsd7XkD2u47uCLZvDPjStvOJCHe8/B9rmcFL+o2igfi+1mjdC0vhf+I60qE30MKHQDQHdpJQ2PEXWmyiyBYHDGU78FS5JLjl7330qjdmBmvyUx+aXVgMaGPTwvoDAkyrgGSJfTbfUbdAb/oeax8E6NghgXyWKwubrvJDa7GXDhOHJR0znqpvxerIyWEF51yblLrZIoKHm3WkuLXGeq62zfvVVvM2ZM8MmeU+wbepx6ArKalboP5Xhv1g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(86362001)(38070700005)(122000001)(38100700002)(33656002)(316002)(8936002)(82960400001)(786003)(54906003)(8676002)(66946007)(66446008)(66476007)(64756008)(6916009)(7696005)(186003)(71200400001)(66556008)(83380400001)(76116006)(9686003)(55016003)(4326008)(53546011)(6506007)(26005)(478600001)(2906002)(4744005)(41300700001)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MkV4Vzl6WHlQMkFrOHQ3aWw0SllobkJkZzlPempqeVpRUGpPMXBVUVk0b0d3?=
 =?utf-8?B?QWEvd3J1WlpOK3ZPY0FRMDlBZStLNHFVUVN1K09TUU9pdlBvQWYwU2RSUWEr?=
 =?utf-8?B?T2VmWVhvVi9uT0tQMXc4UEhaZDNuRlNQUWw2dVJTUHBOMEFsbURWOWVZZmJQ?=
 =?utf-8?B?Vzl0bVY3dmRXWnJEWjY4c0Yzbkx3V1VuM1VVdVBrczhoSXU1WldwQkk4R0pV?=
 =?utf-8?B?ZURmTGV4NGZuMTB1c2pEZE0vSFpidEEyV2pNU1UxdDJ6TDBKOERITnVoS2o0?=
 =?utf-8?B?WlJvSnFvYy9aNFJ5OHA0aGRZMjlCVHc5WXQzQy8wdExDZmFXdkdUMTRJTEdO?=
 =?utf-8?B?Y1g5c0RvSjIrc25TNTdIOFNkT3pzTW9XMnFaZGFzWkR3QUlJVjBoT3NJd2wx?=
 =?utf-8?B?aVlEMElBVFRVbXJRS3FHTk9mS0x0bmhjZ0ZhcHFkck5rTEd0WkoxSUdSMGta?=
 =?utf-8?B?WlJXNjNiYlNVRXRwZ3RHVEpEUGQxdUorakpBTXlnZXVoaFYzOTAzNjdicHpE?=
 =?utf-8?B?V0sxMlhUZzlTckJtbXkyQzJNSzM3TlVrYkRpQUpWcURMVXAxQlh3cm9MS0tv?=
 =?utf-8?B?d2xHbXZhTE9LQ3NOOHQ3b1N5ZU1RVytMcVhMREdsMGdCMEZlbnFYblFXa0tR?=
 =?utf-8?B?dHAxRk5YK3ZidHA4cjBCRXhVaGR3cEVsNzJHSVlOd2Q5eWI1RWhpQzZBUGFS?=
 =?utf-8?B?UlFCNE5JYk8rYjF3eWwyVjg0eXVHSlkyKzBROEVsdzZGOGVOMXZBR1JLbEZN?=
 =?utf-8?B?dlZaclJxdUNieUxsaWplRmlKT1U2UHdnb0dSbkVaSFhjdWxrYTU1UjluZEJh?=
 =?utf-8?B?UUVYL0ZhR21xZ2k0Q2xnTEJvREh4MnZzcHdRZ3NEbjEyTERuNkxRZkJ5R2w4?=
 =?utf-8?B?ZkxoTXZtY1RrYUVHSEhuaXFyaURYWXNMSXo3aVovTUxJTjhDMHhaQmhvajJJ?=
 =?utf-8?B?NlI3Qm95NzFCbTBQblRpc0JIRkt6UXgrQ1ByMlhld29CSklUcGR6NDgwYVVq?=
 =?utf-8?B?WFZCd3BDNURSZmxLVGN0UjFwMnJST0JHVnNvMFIyUG5Yd3NDYXRid2h0UldS?=
 =?utf-8?B?MlJ4ZjhUWFdjeU5kSXpxY1hRdytnWktuWEk3VmU2NEs5Y0ZPTVc1NzVQeUg3?=
 =?utf-8?B?cXVJU3dLYWl0andia0hlbjRMOUpmSFpwWHJMY09yTmNiSU1jQ2Vvbk04cWE3?=
 =?utf-8?B?UUthTC9KYktEZzFKR0M1cERDN0ovNWtWWXNJRnE2K0ZHVWRxNXF5dmtGMEQ0?=
 =?utf-8?B?dmZuR2FYUjFSY29QM09vYWJncHZMczBST2JsUDV1SjlwOVViRUtoSFVIekYr?=
 =?utf-8?B?MzlhaFVQU3dyVkE5bXMxU2lvR2wzUjYvVnhLd2JxY3AyWkVRdE1KWkZwV3JD?=
 =?utf-8?B?eDRkSEpaMHczSFJvazlKRlJmSGJydnA2K3llSHF3bmQ0MEw4c3p0YTZCajJF?=
 =?utf-8?B?R2I5OUFUd3I2bjAzYUNTYzhDWmx2bSsxMXE4MWw3R29YRGZaSURiSDlKNlFH?=
 =?utf-8?B?aHBqY0RTUy9IbUluWmE1UnN5ZThaRFo3RmxqWWNsbVBuUkhQUkFYV1VzQk1H?=
 =?utf-8?B?TFU5UlJuVk15Rk5hTnVpeWdlU3lQVmtBREpoUmpUVUlCQUY4NWZVMzJWM0o3?=
 =?utf-8?B?VVcvYmp2SkxTbUp5UXloOE9IVSt5THg4dElkckZPeEp5cGZseWJtQUpjczFu?=
 =?utf-8?B?WVpJb3krYXlpZ2JFVWRnTkREVkVEcS8zUzFhQU1MNDZ0dTNsUVpWZGRaeGxS?=
 =?utf-8?B?OENBVGt0dmdLMTcxdFgvM3JGZzAyZjViQ3NyOVF2TEZqSkZXcmlKWU5zaHhZ?=
 =?utf-8?B?eDUxZlZ6ZTV5KzhOVXp0Zm5Gd3crdGxIU0g1QncyeGJUQjdoakw3N2Q4MEJa?=
 =?utf-8?B?QzRyUWpiYjZmc25vbHptcEFKaWJ6LzZENHI5M3YxbWNZdnlKOEtlazVCSDFy?=
 =?utf-8?B?SDh1a2hyVkxrN3FRaStGVnQ3c2NhUS9DOXo5MnhUL2VYU2tlT05RekhIUnNF?=
 =?utf-8?B?R2JrMXdDT0NJdDZiZXVhc1RRZk1UUDA4eS9xb3VzQ3hFQ2l0b21WZEZDNkZO?=
 =?utf-8?B?STc0Tnd5b2xPTGxvd0pUeVV5dCs1bjR1QWpCSjlzdzMrRkVQQkN1Ujg4b1ZQ?=
 =?utf-8?Q?0aY5HYrBnaEmxhf0XkmQiLQ6Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448a36e0-0e50-4b2e-21fc-08dadc78e4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:41:41.9761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh0/EADJl3JTv8C9Bq6Gdn8jFQCOgie3KlNE6juDfMW6SmkCDq0u2eF1DyZ3IlPzYqBM2tPkvJj1/HtW1+BRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=716 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120176
X-Proofpoint-GUID: 5w3IYXCEYPOPXqAwdhIdtYGlyQ-nnKyd
X-Proofpoint-ORIG-GUID: 5w3IYXCEYPOPXqAwdhIdtYGlyQ-nnKyd
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=659
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_114151_977702_C51B1DA4 
X-CRM114-Status: GOOD (  15.68  )
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

Q29ycmVjdCwgZml4ZWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENhbGVi
IFNhbmRlciA8Y3NhbmRlckBwdXJlc3RvcmFnZS5jb20+IA0KU2VudDogTW9uZGF5LCAxMiBEZWNl
bWJlciAyMDIyIDE4OjMzDQpUbzogRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxARGVsbC5jb20+DQpD
Yzogc2FnaUBncmltYmVyZy5tZTsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gbnZtZTogYWRkIG52bWVfb3Bjb2RlX3N0ciBmdW5jdGlvbiBm
b3IgYWxsIG52bWUgY21kIHR5cGVzDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KT24gTW9uLCBE
ZWMgMTIsIDIwMjIgYXQgNjozMyBBTSA8YW1pdC5lbmdlbEBkZWxsLmNvbT4gd3JvdGU6DQo+DQo+
ICtjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9mYWJyaWNzX29wY29kZV9zdHIodTggb3Bj
b2RlKSB7DQo+ICsgICAgICAgaWYgKG9wY29kZSA8IEFSUkFZX1NJWkUobnZtZV9hZG1pbl9vcHMp
ICYmIG52bWVfZmFicmljc19vcHNbb3Bjb2RlXSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBu
dm1lX2ZhYnJpY3Nfb3BzW29wY29kZV07DQoNCldoeSBib3VuZHMtY2hlY2sgb3Bjb2RlIGFnYWlu
c3QgbnZtZV9hZG1pbl9vcHMgYnV0IGFjY2VzcyBudm1lX2ZhYnJpY3Nfb3BzPw0K

