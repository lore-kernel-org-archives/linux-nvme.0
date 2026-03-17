Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E43FF6E9A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+IHqfGSG9Ta19NWRvYvcnFWEFFdN+hAcDl0NrTcGHs=; b=GZLOtpxWUGkyNN+DCho9Oc5V8h
	8ZoNMF+q8bQg7DFqnhPJv6HuMdlD4IZlomF+3xGlzNInlLTwykecchdOOefTyObunr+dNjCuxTJsB
	V76EA2hqk+gONfXNM7h7dUZG8kK8UMtfPY/PV2KwhRDRErRixLy8QDaqYk/z/XdjqCJVjLmGGYc9+
	l3uSH3oylsMmj7FGBWZg9bQ7aJdvXqcBn/ICeNDFLVp3hkiHuMelFG2OzZT51dOftbnRl8sydnUXL
	4kPrAPJTfHqj+Q37pJrpZX3YJ1bNb++zOYuF1Z8Q/UlwvyxrVe8e0R/EBMs129U1dUdXx/3q7tWI1
	CBR9m/XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dYf-00000007R9R-2SIg;
	Tue, 17 Mar 2026 23:10:41 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dYa-00000007R8V-1etu
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 23:10:38 +0000
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HK30ZS3474251;
	Tue, 17 Mar 2026 23:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=7+
	IHqfGSG9Ta19NWRvYvcnFWEFFdN+hAcDl0NrTcGHs=; b=GO7i5uLWAZN95XEg31
	kwbq1/WXviNnrsC0UMaLFgbAg4NKwiVwY0kW1UK35MTS5ZwqaVTyqCVnN5Qj/TDI
	T/WeCS1p4eNGIkoUQj9IAM5+ZOF81HyhQvMEANlWqwAAT+UOkOyInqmMXUHlifk7
	AOD/JHsWyfrdYolFQI4NgcKBZ6fMuHloZY+/Jt9LERZOWB4Um7M5rDlmvFqrhb0L
	EvOsjTB/T02k9u5icUdDr1+kjtOqH4UtR60MIAd/3ASIqYstobh10AmMGonVB1gy
	mFW7oK6lOGouh2Ivf/x6vrLu6BPDH3y0UEAi4dy3mfbjTfZRiEHv21nDql6fZ1SE
	PCXA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy92d5u08-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 23:10:12 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 87B0A802BA7;
	Tue, 17 Mar 2026 23:10:12 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 11:10:12 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 11:10:12 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:10:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcc0liy2EQD9Y2FLTA1VKInNOREGK+3fP3gKiXwMI5bAs2BgqvS1zXFTHRhrOhkkz/TgdDKlAfzRcc03QdJnPI5SaaBFbUjKF9654ygSSjHexNqclFMEW+GtE9GObtuLDBJHBkGJdGculkD+RMHtebE2NgbJplIFbgMW47g6L9+098KuWxUccUUPH5dtUq9uczGcCKHvKzer8hRi7KQwqxZWDFYGPeRLnSAD/CKXKpIeXex9KGKxezdQp8Nj2l7R72m69+7ZUCmHU3GJe9seMeLNAo6uEtEQsM7S22bISFT3oWYGb7zZpxAGcjIdT7Hy8PEdZwMoDQ3UD7ZTfXlWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+IHqfGSG9Ta19NWRvYvcnFWEFFdN+hAcDl0NrTcGHs=;
 b=UWF3Qysy5VLi+9rfBFKsDcdzuTl7n/nAMScgwc3jek+/M7I8v7RgrMY86HaYAl/zT4pUmlRqcqCmu0GiRtcE0TErCEt3T3MFdxPyLN6U2sLubLwDoAO6vH3NiziRzCrj4vf+Yd3PZnwKZ38AW3HtKdKYyuU/q/pG3hNQvL5S5fXVYyEfOfEYNBYDlQQ/OXYtDbP2UXvHxZP79AgMh3GOJEr9lDcGoDHsEfGy65XdoI0C3+/voh0VZcwOjj/AmzQp+FgVIvHoJtuxXIPhCCij1qvP8WgDrf05iXQq2MASmSOnSwgCmBD129Znes6uVjQ5+ML0wscQwUIUhx3qr2Bz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:439::21)
 by PH0PR84MB1528.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 23:10:07 +0000
Received: from SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ce99:823a:6d2c:c390]) by SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ce99:823a:6d2c:c390%5]) with mapi id 15.20.9700.025; Tue, 17 Mar 2026
 23:10:07 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        "Sagi
 Grimberg" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        "Chaitanya
 Kulkarni" <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: libnvme API review
Thread-Topic: libnvme API review
Thread-Index: AQHctS/BFbMIDt4Vo0eUzl2gyYBCNbWxSHFAgAEtcwCAAOUsIA==
Date: Tue, 17 Mar 2026 23:10:06 +0000
Message-ID: <SJ0PR84MB2231AC08CA04F54CC29F03319841A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
In-Reply-To: <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2231:EE_|PH0PR84MB1528:EE_
x-ms-office365-filtering-correlation-id: 8b9d68fe-9038-409b-3f85-08de847a5459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: dPPNNNqJvzZ+D66PPgIC4O/nBfb5sqQ7yc2aCP20v7dLMmHl760FKDDc+odL+r7H34hyGchowyQZpM+SjkwjhO9NOXx1vSHDv44RIZ7CrjU6ISLXzJ7dWpJsBBf/RU4oykjLIEvB82Jxj9QOfl3Jkn8ObdFVNG+R6dE1xHwe4kxhVdhraYDso3XnmsthXRsmU6O8WaY3aoQ2H7tV8jYqoDET2I47SK88nyO44lNJBpsHTb9pEFgftoedtqTLqyz3SZaJnlxu2IqjRy3UzUB3kqfHITbWgUA+DAfHc4TEjJJynOYfyOski9NNpAihudp7GPy55VEn3b4gmpG5bLyGBpHeXvFYQarNW79235vRef9PoAYjhmI9glQy/GKx6dT6TBRGRxhO4oie4YjWo9N3Ma1mHC4Pc7n0piaDwR/s+IPBwS1OgsL9DyFphWhQQi3yuNnqRQnMC436uGyqycd29uAX88HYMSut2XDlP/XAkYdmvevIpc0ayfKNbWZgutr5Jj7xSDlV3jLep1BF2pzrRNqaRwBj7MjRedwPNlFeqzahwbjkEEfAN9FhsEgpy/b8+1iBs4Lskbnlwav0t8tyAH9FcHC2swPnzFlXt6hLtK8eLvqLG9F9mNZTrUuz39S6i6UuXKsPbqdhFr1Ot9KoguY3NhvrEMOsqi6ofpVkXgxvEbuUtd/XEL+gILHOA1ACYk3EM4u4wqb0vfSgCtYIONukEpO6/6VQiq9mhsyY3tioNytRcoy7ZkvSFHxgl+kdAAikkuUs2jYLnr6TaX3YqJcXzNDKMih4r0nCtlvv6DI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3RGbGV3SVJ1S2kxZHViRjExSlZnbnlaVk9yRUNCVlRRNkMrWTlaU0dFbmoz?=
 =?utf-8?B?VTNlNDBRaFU3MWNzcVFnODM1ZHZxWGpoazgzMkRnWnpXdUlkVWtMTUptUlhx?=
 =?utf-8?B?TDNsTE9ZREh1dmYyK2JKam9EM0hUNFdhMjR2NVRnN1dhNTJnc1F2cWhQZC9V?=
 =?utf-8?B?NE02NmVDMzEvcUM5TXJtUmJ0MlN2NmtwT3hsVUwvc0FDTmZMZTN1Wkg4bkR4?=
 =?utf-8?B?Qm95RE52RXg0QWdNRjM4VUtOY3ltREVmVmFEWXBMWThjMVJCU29hZzNmVXQ5?=
 =?utf-8?B?VXdaRE05OEdEOHNGeVllZWN0M0tTR2t3NHNpWW5sMWN6UzlZOFF4eE9pakls?=
 =?utf-8?B?K0NnanNRdGtwOXdyVVV4dFhPT1podFdRQXRvUVpJSERpa0FJOEdKcTNJS0Ns?=
 =?utf-8?B?ZHk3Sm1XVTBGZnNwaHNxQWswcWhrUnFuUjZ2OVg3dVNCWEg5QUtncXlhKzlO?=
 =?utf-8?B?Mm1ZbWd2dElrcmFTWjEyNVZSY2hDS2w4QVhzMmo1T2NRaDNqTDk0V2pEQVhF?=
 =?utf-8?B?VTdQWVkrYWZ0b3o5dGNzSjZGUnVLbGVJejhlY0NrM3ovY1NpbDhuSnN3M1o5?=
 =?utf-8?B?S1RqRU5NamRmZ1dBL0VFR3E4VldlajlYVDgzUkRpQ1pkSzRXSUVjeHVOWXRk?=
 =?utf-8?B?U3BPV3B6NmhGUFVHMWd5V2k4ek01WXRIeHdKWDFNU01wZVYwK0ZkSFNQOWdz?=
 =?utf-8?B?QWVneDM4dzBpYzhYK1dlZVBxdHUzdnZ2VmdtMHNUZGR1MUtrRFpITXF0NGxJ?=
 =?utf-8?B?M2NFS0p3WExzcjNyWTZhejVjU2VieXUyWWYxdzdBb0xyV3ZsUGRJWW9vdEZE?=
 =?utf-8?B?WC9lblppWlJTblB2WG5PRThRWXpkb1B3TGZkVXpMUzE1TEZHSHpQRDZCN2hE?=
 =?utf-8?B?dUFSWTlJcVpHNTg0cU1XalYxU25MaXA5d0lqa3p1Rld4OGR6RmdwZXo2Zzdi?=
 =?utf-8?B?QyszWUJ6QkVNcno1SjlGNUZ3RVAzTERxU1NFUmJuTHZtOGQwR21HQStNUjd5?=
 =?utf-8?B?VGFjZVVhQTI4MTRkWGlZcG0xdHRPa3YwOTZGaFlOcTloeVVobEV4Z0oyTEZ6?=
 =?utf-8?B?bzBPTldMTC9UR0E4b3RBQUovR2g2R0hlbStyUzVrbDFVNUdZOXhiTStGQVdz?=
 =?utf-8?B?VEtEUDM5bFdZZ2hnNk9ReWp5VExqaHZQSjRneFRsMHd3aEJiV2E5elUraDhU?=
 =?utf-8?B?RWhBcTg2Nk43LzJEeXlSRVJHK3JvcDRYUnRKbjRvRkNKSDVzbEJFOENlUzBJ?=
 =?utf-8?B?Q0tMT3g0elFaam5kYVMvYmk3RUFlcnQ0TjRBM2ZUQUJERXV5NEhXdWZyNEdW?=
 =?utf-8?B?SUxrWGxjT29VMUZTWUlORDV5ZkltdXRCT2ZWUGpGdVg3cVlzbEFDN1daTUxh?=
 =?utf-8?B?dTkyYlUwNmY5Nkx6dVF5RVBUa21CQzFiSGxSNnpZUlo2R3haOUFWenJNT3Rn?=
 =?utf-8?B?c3pZZUNOMXl6TnB1bUk0T0dZcHZOZy9BU2x2amwvQjhmY2IvNFdNZzN1RG0w?=
 =?utf-8?B?clMwRUc0MUp5YWExQXRrNzRCY2oxQUUvUllNZ1JNSHZ3Y3ZaQ3hhMkFLZXNu?=
 =?utf-8?B?K3JtRStCQi93aGQwUXA3NHExZXQzV3dlREFlWG5ienVSb0ZJNFBsQ1NRNmtO?=
 =?utf-8?B?TnE2enNBeStoRmhwdm1iNVNIdHRMQjgvUkZpNVlsOXZzUXBIWkpMRmRFeWxi?=
 =?utf-8?B?UFdRZ2tCWnZ2SVNTR29HWVk2a1dkU0R6NVIvL21SSjFWeEFobjhxSGlEY0lF?=
 =?utf-8?B?Q2xxK2ltOFZNaUQ5SjhoR1haNjZDbXVTTHYwY2YxMXhsOERvdmkrcGFrbkdu?=
 =?utf-8?B?WUx4N1VPQ2I5THl6bHZ0UzJWcFdnQTdQY2l4a0U3aUFPa2VLNFNualVUWVJW?=
 =?utf-8?B?c25TRWg4OXBib0VRc3hTWEFONmNZTUt0NFBTOHcyMFQ3TkhidUtHNnZ2RVNu?=
 =?utf-8?B?aXo4d2dmSzVkQU4veDNmc3dyM0JIYlVGZkhLQzlyNm5KSDVSV2tGOGFuY01O?=
 =?utf-8?B?a2thcERsbFc0eEc1enpXVVdra0pVVkNldmxBQzJuSVQ0dklnNVFKVDloSFRV?=
 =?utf-8?B?UTgvWFZ5TWE2OWlTcVF5ZUFvSm9PMGVsSjQzZ1FKZnREZHc3MXp5Z0tKZ21v?=
 =?utf-8?B?VW5aMU5VUklGT2Zscit5eGs5akFOTEl1WUZjQ2JWRjZFUFQ2L21NdUVEcTBP?=
 =?utf-8?B?eEl6UUZrb2FzNVJONjUxMGNYT2h1dGpUamZwVzhxb0Y5MGlTMnhBUnJuZGcv?=
 =?utf-8?B?MEJhU1R0R1BGYXliRHQ4UXJ3SEQ2Q1VZQ2JEN3NEOW5SdkxLY0h6dDlPNXRl?=
 =?utf-8?B?aXI4a2ZtYm1XcGVWYWtXdXVEYkdSb1duYVlYRjE0NVdXcGhzTWo1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rKCVxqdCIqyD/x4f5xF0hFAOSaWc4mpSgqufZbAlQjlWIJ9M2j7BvVKorM+YNAoLLczie+roXiA5qg+k7PdNEyD7wEMlWj21u40LuMe9IEPUrmmDx5k8WMwFjbk5hHJZ21YmkdWgTXrPfwo6ZVyHvYU0dovYtVk8Oeu81TdKBN5BZVLs4IS2Naq+FzNVPu+fkl14YGiDK7JWPbds+qVdpdr7u1wBKJulJ7c/3Sb7ntK8nJT+e1xrLw7UKRB9dZGgDD4lqmaLJb6DCZW9mErTqXZ+Z6vP+7O/VC6SFfTMxgKau9j2rpm5TcOCpJHVtYX1KITe+yGHA7Q/GLV9CION0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9d68fe-9038-409b-3f85-08de847a5459
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 23:10:06.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXdy+oGf8cM7k94CGvSDi4x0/kfDicPQSPk7QacM4vf0119KlrNDUgw/MdNPXGq+HfMiD9vHuU7q0MrkMHLK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1528
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDIwNCBTYWx0ZWRfXxWyso4EmlEmp
 4xDmK1TFrIBcvemJM65jUxogwSzl7bI0pdKJgpRjLJmpagepPurpoKWu+m+KiMvbP9+ZaWxjm8q
 WsBMZaQtWNn5o6g41Du9I3j2DOJvWl5uYARyclVk2TTso24NQRtcD+JiB74KmwzY5Y/GTE2fNzm
 /6ZqDQgaOq23B28/dNFa2HsB1Ffllf4I0iKDRUypaHMN2uTJxt2HjvJ2q5LQ0HryiX+iON9HWPF
 6+QhIDq53GbIsjdy+8CbNkxQ24X82U/EcU8M1vj8lIz7Prfou4QWgiWOZX42BuD3CHKkRMXNwve
 g7cO/L38NSr5cnR2oklwxF1JougmcQ3ysMSrSEaDmnhPKI0Qdw5E6xaQLOPxzhbB+jodYQpoMb1
 VG2J6DZ06uKzzGQ8OsyCzPDTrf5sue2pGSqAPma/6ugJhVbBJTEbpDYukv+c7R+MFsaQy9R+K7E
 KNPAkfvOWxU1jjYB02g==
X-Authority-Analysis: v=2.4 cv=A/Bh/qWG c=1 sm=1 tr=0 ts=69b9df55 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=_hz08ObbEinZYnsrOyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZXVivkiZmVuukegT53AfMeYVCmJ6YSXb
X-Proofpoint-GUID: ZXVivkiZmVuukegT53AfMeYVCmJ6YSXb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_161036_953269_2D9F9170 
X-CRM114-Status: GOOD (  20.62  )
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

RGFuaWVsLA0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZSBhbmQgYWRkaXRpb25hbCBjb250ZXh0
Lg0KDQo+SGkgQ3VydGlzLA0KPg0KPk9uIE1vbiwgTWFyIDE2LCAyMDI2IGF0IDAzOjM0OjM5UE0g
KzAwMDAsIEJhbGxhcmQsIEN1cnRpcyBDIChIUEUgU3RvcmFnZSkgd3JvdGU6DQo+PiBJdCBsb29r
cyBsaWtlIHRoZXNlIHByb3Bvc2VkIGNoYW5nZXMgYXJlIGludGVuZGVkIHRvIGFsaWduIGJldHRl
ciB3aXRoIHRoZSB0ZXJtcw0KPj4gaW4gY29tbW9uIHVzZSBvciBpbiB0aGUgTlZNZSBzcGVjaWZp
Y2F0aW9ucy4NCj4NCj5JIHRoaW5rIEkgc2hvdWxkIHByb3ZpZGUgc29tZSBiYWNrZ3JvdW5kIGhl
cmUgZmlyc3QuDQoNClRoYW5rcyBmb3Igc2hhcmluZyBhbGwgdGhlIGJhY2tncm91bmQuIEkgaGF2
ZSBzcGVudCBzb21lIHRpbWUgcmVhZGluZyB0aGUgY29kZQ0KYnV0IEknbSBub3QgaW4gaXQgZW5v
dWdoIHRvIGJlIHJlYWxseSBmYW1pbGlhciB3aXRoIGhvdyBhbGwgdGhlIGhlYWRlcnMgZmlsZXMg
DQp0aWUgdG9nZXRoZXIgc28gdGhhdCB3YXMgcmVhbGx5IGhlbHBmdWwgaW5mb3JtYXRpb24uDQog
DQo+DQo+IC4gLiAuIEFzIG91dGxpbmVkIGluIHRoZSBlbWFpbCwgdGhlIHByb3Bvc2FsIGlzIHRv
DQo+YWRvcHQgdGhlIG52bWVfVkVSQl9SRVNPVVJDRSBwYXR0ZXJuLCB3aGljaCBtb3JlIGNsb3Nl
bHkgZm9sbG93cyB0aGUNCj5rZXJuZWwncyBuYW1pbmcgc2NoZW1lIChhdCBsZWFzdCB3aXRoaW4g
dGhlIE5WTWUgc3Vic3lzdGVtKS4NCg0KVGhpcyBpcyB2ZXJ5IGNsZWFyIHRvIG1lOiBudm1lX1ZF
UkJfUkVTT1VSQ0UgYXMgdGhlIHByZWZlcnJlZCBwYXR0ZXJuIGFuZCBtb3JlDQpjbG9zZWx5IGZv
bGxvd2luZyB0aGUga2VybmVsJ3MgbmFtaW5nIHNjaGVtZSBtYWtlcyBzZW5zZS4gTlZNZSB0ZXJt
aW5vbG9neSANCmlzbid0IGV2ZW4gYWx3YXlzIGludGVybmFsbHkgY29uc2lzdGVudCBzbyB1c2lu
ZyB0aGUga2VybmVsJ3MgbmFtaW5nIHNjaGVtZSANCnNvdW5kcyBsaWtlIHRoZSByaWdodCBkaXJl
Y3Rpb24gd2hlbiBub3Qgc3BlY2lmaWNhbGx5IHJlZmVyZW5jaW5nIHRoZSBOVk1lIEFQSS4NCg0K
V2l0aCB0aGlzIHN0eWxlIGFuZCBnb2FsIGluIG1pbmQgc29tZXRoaW5nIGxpa2UgdGhlIG5hbWUg
S2VpdGggQnVzaCBzdWdnZXN0ZWQNCmluIGEgbGl0dGxlIGJpdCBsYXRlciBtZXNzYWdlIG1ha2Vz
IGEgbG90IG9mIHNlbnNlIHRvIG1lLiBIaXMgc3VnZ2VzdGlvbiBvZg0KIm52bWVfZG9fc3VieXN0
ZW1fcmVzZXQiIHdvdWxkIGZvbGxvdyB0aGUga2VybmVsJ3MgbmFtaW5nIHNjaGVtZSB3aGlsZSAN
CnRoZSBOVk1lIGFjdGlvbiB0aGF0IGlzIHBlcmZvcm1lZCBtYXRjaGVzIHRoZSBOVk1lIG5hbWUu
DQogDQo+DQo+PiBUaGUgdGVybSBpbiB0aGUgTlZNZSBzcGVjaWZpY2F0aW9ucyBpcyAic3Vic3lz
dGVtIHJlc2V0IiBhbmQgdGhhdCB0ZXJtIGlzIHVzZWQNCj4+IG1hbnkgdGltZXMgYnV0IEkgZG9u
J3Qgc2VlIGFueSB1c2Ugb2YgInJlc2V0IHN1YnN5c3RlbSIuIE1vc3QgY29tbW9uIHVzZSBieQ0K
Pj4gdGhvc2Ugd2VsbCB2ZXJzZWQgaW4gdGhlIHRlY2hub2xvZ3kgYWxzbyBpcyAic3Vic3lzdGVt
IHJlc2V0IiB0aG91Z2ggSSBoYXZlDQo+PiBzZWVuICJyZXNldCBzdWJzeXN0ZW0iIHVzZWQgcHJl
dHR5IGZyZXF1ZW50bHkgYnkgcGVvcGxlIHdobyBhcmVuJ3QgZGVlcCBpbg0KPj4gdGhlIE5WTWUg
c3BlY3MuDQo+DQo+SSBzZWUuIFRoZSBwcm9ibGVtIGlzIHRoYXQgbWl4aW5nIE5WTWUgc3BlYyB0
ZXJtaW5vbG9neSB3aXRoIGxpYnJhcnkNCj5BUEkgdGVybWlub2xvZ3kgY291bGQgY2F1c2UgY29u
ZnVzaW9uLg0KPg0KPj4gSSBkb24ndCBrbm93IHdoZXRoZXIgdGhlcmUgaXMgYSAnYmVzdCcgZm9y
IHRoaXMgdGVybS4gR2VuZXJhbCBzb2Z0d2FyZSBkZXZlbG9wZXJzDQo+PiBtaWdodCBwcmVmZXIg
InJlc2V0IHN1YnN5c3RlbSIgYnV0IG1hcHBpbmcgdG8gdGhlIHNwZWNzIHdpbGwgYmUgZWFzaWVy
IHdpdGgNCj4+ICJzdWJzeXN0ZW0gcmVzZXQiLg0KPg0KPlRoZSBvbmx5IHdheSBJIGN1cnJlbnRs
eSBzZWUgdG8gcmVzb2x2ZSB0aGlzIGlzIGJ5IHVzaW5nIGEgZGlmZmVyZW50DQo+cHJlZml4IGZv
ciB0aGUgbGlicmFyeSBBUElzIChlLmcuLCBsaWJudm1lXykgYW5kIHJlc2VydmluZyB0aGUgbnZt
ZV8NCj5wcmVmaXggZXhjbHVzaXZlbHkgZm9yIE5WTWUgc3BlYyBBUElzLiBIb3dldmVyLCBJIGFt
IHVuc3VyZSBpZiB0aGlzDQo+YXBwcm9hY2ggd2lsbCByZWFjaCBhIGNvbnNlbnN1cyBoZXJlLg0K
Pg0KPlRoYW5rcywNCj5EYW5pZWwNCg0KVGhpcyBhcHByb2FjaCBsb29rcyBsaWtlIGEgcmVhbGx5
IGNsZWFuIGFuZCBlYXN5IHRvIHVuZGVyc3RhbmQgc3BsaXQgdG8gbWUuDQpUaGF0IHNvdW5kcyBs
aWtlIGl0IHdvdWxkIG1lYW4gbW9yZSByZW5hbWluZyB0aG91Z2guDQoNCkN1cnRpcw0K

