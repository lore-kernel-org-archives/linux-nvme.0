Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/J5OMURa4LqepNmsZdvxT9SveFgz+VZcwK5aoezR3I=; b=azAE28mXX6orpLl0WroraQtnHP
	cBRAkqbKfI82km5FSY/def1X/zcGNM22L34j/tDnvBZYwCcd19Nl3Pl/B3+Wug7uf5qu2hOU9pCOj
	OsPK4c5ehSX/kacFcz3WXPfuh+45nl78RzXJ+OK2XfhRgbWPPVe4hzBDiP9u9KodJGihvenrLqJ+G
	C9l7obzd3K1nVmFf7E4ZyTg5/nc2nOXpLXdV3hSeBfPVFM4thuzZRtD1SeQV00R5pou/rYe3kY8KY
	U3OWrPJAC+NYMciTl2non2fKsvgk8jY96AtMeUQjPmptMGhcbxP5C5C/qTat8+WcNWkITyWY12IL0
	EYOtFS9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5y6U-003FpA-03; Mon, 27 Jun 2022 23:25:14 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5y6R-003Fmn-6m
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 23:25:12 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJTpQc002063;
	Mon, 27 Jun 2022 23:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9/J5OMURa4LqepNmsZdvxT9SveFgz+VZcwK5aoezR3I=;
 b=HCBeM+EpnWourBpVyUgVSb50g5w4hLHMetUke88HM1E1ks8wtxFrr0IsrkcCB4v6ZpU/
 OO3Wi67dvvthGLXHG9klg/rYul41mejW8S/40jTgR0SI8L/tICYUvmtl+bcVCK1Ul9tM
 6jM26ScEyXie19+Fv1faDCBa6tzBYrdRdyxI/4b+9yqdz0D7FWyJjNskmkJEarci6KHT
 Rq6BzjkpgJpPhnvGKbRnTSH3AcwA4spHhunTo1iMa2+9nGMzEv9l1nZZ1A7iswdzMeOa
 63CwvWbGq6Virqlo89lY7hDOF26GKWJZp4b0tfj6BiI9Tj7J4gD5PJ5Rjngmor388ogC rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0cmq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jun 2022 23:25:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RNEsPq009519;
	Mon, 27 Jun 2022 23:25:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt2205b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jun 2022 23:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfqPIrzPRvv5yoXkZpkD/ejAIFhpkiby19+MNhmnKrgyHPvQsxrwXpY2kpFv8gm89fgttklHL8ORJBrosNSZDUntFO5K4rLG72VLmDJCgbthd9nbIDL9wdwsWhjUy074ROi6cKpPRQVv2PwFe/dkDKnhnH6Q94XF2c9bMSxwkqTOoueJuju49ABKuqrOUROynC0JwqqMdbx95cnkWcxMxdyN70hzb96QeqETwRkMxsrzra7+BTbuVH5zzqI0jTH9E77LP1OO8YZUirW0WZx7bo4Wl2+x5u4/Y6VfqcwHMYoaoa1TsuulAM3uk2sQ+8n5s6LQOKEqE/wPfp8DrpSYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/J5OMURa4LqepNmsZdvxT9SveFgz+VZcwK5aoezR3I=;
 b=RzsCG5hECO4nbQaOEvFYjeJRRfVVZ7dIUdAjTObaoJDt7+NoWbyNwsnaAyeT/Z/2DiWuy4NvnTPWDFE+wZLuLrPw6WX/nWcXX3z3z3PJeg3/MN5GMY7xCpDs7kh43GSRGUfDejjw6L5kHyEBKAbjIi/H7zti0bAlAffzAX8ITRVgxt+bcMHqSmB0IYupfoyRbiccppA1tuN5SVsxHLy/ETA5SBp4DqvqvTK9JmZj+idX8VbJjDigDn+EyWQN0eRlaFLEuEpMrNpC6df4c/StZdZZrFdZuR2XWfIL4GqLXIdbEkMsePi5QEc8/zjm7ZdJAV3a4h0pOpLfKYujdL+jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/J5OMURa4LqepNmsZdvxT9SveFgz+VZcwK5aoezR3I=;
 b=d+ze+/zTWn2EBnJXHBonxwDAzh8xM4bpWUpyIfE/BTkas/vYg6+7csUHE7YVkG4gBIjrmtATv8RshyqJelRjyGwatqPGfOZeN0X8gJjqYa7DSE5WLhZab0JXhNUtdo5KO9gG9BTXeTMsHw0PNVFYMexdSmvu9tEvUCynI0MxaMU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY4PR1001MB2312.namprd10.prod.outlook.com (2603:10b6:910:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 23:24:57 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c%3]) with mapi id 15.20.5373.017; Mon, 27 Jun 2022
 23:24:57 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Add new clear_ids attribute for passthru targets
Thread-Topic: [PATCH] Add new clear_ids attribute for passthru targets
Thread-Index: AQHYhooVn+4Kbfc8TkmruMbBfJWAQ61jxMAAgAAoZYA=
Date: Mon, 27 Jun 2022 23:24:57 +0000
Message-ID: <2A294473-CD52-4AF5-832D-522D6BD88145@oracle.com>
References: <20220622224724.19623-1-alan.adamson@oracle.com>
 <553974d5-bbad-2356-0aa8-90cea88be01d@nvidia.com>
In-Reply-To: <553974d5-bbad-2356-0aa8-90cea88be01d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d93e930-9b59-4b5c-c2a7-08da58943fb0
x-ms-traffictypediagnostic: CY4PR1001MB2312:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4wLRdis7kXcSUDN5AfXVBOGuaLjbSEkxiq1H73MoyhZDKJbZrrbAE0PyXv+i2eQa+EkiED876nEM4015OQvowKW1IhMJfz3Gf94nfBN36rf8QDhSXFwmev1Chf3sIPTaw+ZfAjRpZv5/Yn1tvHOIlyKQEjGKbHIkBVSzfs4+KwPAQt/NQYLGEZvFjVUNMQ+ydKxH6FZ5BWr5UNVbbiPg4+YNO69PhbtzmV7B3R8rlcHLcd1pT/1ueLlb6pX4E5FqMjgVQgzOGfyoP5aGxeCRSKkVr0BjyzS5aMlpzyrWrGwpY4RJ4kZsucTFqxkmnFwDh+qp6a3Iiq8UboN34OmGJBHvVI3XnmJnFoZcCZu8G79ySdhxBSGQlO5LYCMJP5y0b7zlDauV7w0eXtgN0DVy3WvrveE7s0iMhBWpQF0RUB0hpu0dlzkP9qPcr9dcMHRjuj2wKJIDLsXbZVaQbslpmZFVBXamQKpzDZ2te10EiaQrc9Lu6ahAJzTJBSMM6hFmg6bWB9dMJl820zTliFRHPAqgD9w7TwJbzyNYkFtKuj9nhnXGDH+5XLHErmCBsNCE74rtjTG2Xp7pu7hi//pYJlNe8h99hr2kxxT/Ry1i6zSgveIer6OZsOZBFj3CxFrK9y6I3y0pjmG9t5XF3AuUkOf4lW7jC1wQ9qiABbHiUAjChhF0WACj1bmNaEB9Ycrt6l9t9AdNx/hrnXOlKUsO18GNLpeOGlXJouaKVOmsTQGIUOcvky0JI14+9SFlONqwLFwWlgEBeKnyuzM8S7C1ZTIUfDb6zMfGT+vuzSRVFPZ2yyGbEIhPiyFKfQMbcUS29FNGE1LP0Ggc3ep7OA6LnQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(366004)(346002)(66946007)(186003)(66476007)(76116006)(91956017)(4326008)(6506007)(2616005)(6486002)(33656002)(66556008)(71200400001)(38070700005)(6512007)(66446008)(122000001)(41300700001)(316002)(86362001)(64756008)(8676002)(5660300002)(6916009)(36756003)(44832011)(53546011)(478600001)(2906002)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bjZpVm9wYWE5dVFOZW5QRWVGeVdDT1l6N0JsWTIxVngvVG9uVUpzZ0JaNnpT?=
 =?utf-8?B?Smw1aXZYM1g4YnBMY1ByV0I0SGtxM2pBcno1Nng5OEx2OUVaem5CVThLNXBO?=
 =?utf-8?B?OVJIejk0RERuVHFXcGwzTnRqaE5xdjBLVjdHYzB0aFlSM2xDcGJkYVZvS0dh?=
 =?utf-8?B?L1REV1JSRDFxbGRnWTJKSkFtT0xmUnBkbFo4TGJzNE51bmNELzk0TjNiVDFR?=
 =?utf-8?B?MzZOc0EwankxeFRhenRxZUdrQTJRQTN2c2ZzOVZSYk9kV1NPWks3WE1nZlVa?=
 =?utf-8?B?blNwekFZOTN1WGZXK05WNVJQU3U5WlRFVnZpWm9XSVJQVUl4cVEyRDl6VXpy?=
 =?utf-8?B?ZkcyNE1GSENuSEJ5V3ltdjNrei9FUFBFR0s3MWFBUjV1RGNoa1g2a0hIcU84?=
 =?utf-8?B?bjhjSnBJclpIYVh5Y25UOW9aejlKd2MzQ1ZiOXJZaTVUMU1tQlFJTkVVL3hM?=
 =?utf-8?B?OFFqMjZCZFdScEtZbFM4YlZuYmFKOFpBcDBjSmFLNGdDWi95bmJYbkZ2YS9M?=
 =?utf-8?B?UFA3azltYmcvTTlKQnRkZm9yQ0FZN2pmTVNKbktYekdUNWlHNjVjY3AyZGw4?=
 =?utf-8?B?UnFheVJMRUYrS2h5QktydmR0VGFaRVUwRXBrcWFqNmlBUG9FaDhtamNzZ3lR?=
 =?utf-8?B?WTBORlVJNzVDN2ZWOXRIUnNZR0dUbXZ5U00yaHgxSXNSbkN1cTdCZTFrNG1l?=
 =?utf-8?B?Q1k3U3hlYXEzTGUyVjdhVFJPQWtMc2tkekpKY2pxRnE3TUhTMFEzTjZpSUdx?=
 =?utf-8?B?Nzd3QVFoMTFYa1dzSFVMZy9WY3cvVkZGbFlXQlVCdTA1bUVWV2pCZXJxaXY2?=
 =?utf-8?B?RmVuM21FVHpDbFR5NE5kanlScTNucFpWcU8zU2gzdFgyWTZGNndhUXlhTVNI?=
 =?utf-8?B?aGIycWVzK3FDa3ZHTHhKYlhWSGE0bUJBNEo1UkREZ25KU0E5MmRGVTlaVjI5?=
 =?utf-8?B?aUovQjdPSnFTQjB3RXl4RmVFQlNDNjNuZzJwMXFva0JJSlliMzNaWmo0Z1Ni?=
 =?utf-8?B?Nkx5RW4wZWFLUzZxQzJOVU5LSWVjTVBMTlBWbGZCTGZzc1VPN2RPbm9KZ0t2?=
 =?utf-8?B?Z2ZUREg5MktpV0VpQWhqWkc3ZCthVitQOUVFLzhaUnhIbkpJcGY2SjlVdXlr?=
 =?utf-8?B?NFYvL1llRmpQVUtHeHBPSGdmUi8rZ1YyZkYzdGtJM2szakNMQkNqZUtVQ2pj?=
 =?utf-8?B?N2ZtcTdnRGxmM2U2S1R6RHpRMDM2Y0tDbTZCM3JtMk1YempHUFgxb0ZEU25h?=
 =?utf-8?B?T3NBUmgycGd3WWJRZWdjaldRQ0VMd2pXaGxNS2cvTXgzaUZIamhhY01iUFN2?=
 =?utf-8?B?aFhaN09mUUEvRTFKVFBnUkdCT2FWQ3U2T1NFdmRkZkZMcnFkd0tmMllOQnR3?=
 =?utf-8?B?SWN2bEh2b3lVRmtwOWt5dlRWYytnL0IwU2x6TlNZRmNubzl0a3ZBaEpTeXB0?=
 =?utf-8?B?ZmliRFlkY0U4YjQrazlBZ1FzZ2luK2JhS1B4MjFsa0lpejgzb1pQNkZEaGtl?=
 =?utf-8?B?NHJPTERhZDlveUgzUlNRV1pMQjZ4YnppcE8wNjN5c3J0RjkycmFDUisvUVBj?=
 =?utf-8?B?ZE9rYzExOUYrU3NpYjFwZWVNc2VFeTEzOHpxOG9nQk4rdWdHS2xDYnhYRWta?=
 =?utf-8?B?TE8zc1NieExjQjYxMG5BMzVBKzg5dzhhNi9OVUJmMEs4eFRlV0Q0QlFjeEds?=
 =?utf-8?B?dWs4SzVWTy9CdHlUZ3hsc2pSOERtVi9hakZpM1lDRExzcDBjcDdxd2ZoVGpQ?=
 =?utf-8?B?Z0RSMTU5UVdEUnJKbEVJYmN0Umt3bWg0RnhsSnRHVlAvZ1ArUW94cE04cmda?=
 =?utf-8?B?ZGFENDVQMEI2OFFzQWJETVdtOWhSOUpUTGZSTnE1aFJNM2U2bVlrZ3BpQmxD?=
 =?utf-8?B?NzdQaDJsWldqdTlZK0RvcTRVNEM2SUU3OUs1MnJYYVQxZmhXTlFEczBxaWty?=
 =?utf-8?B?ZDAxemQrZ0U1dSswTGU3YVJHakdUVTU4Vk5yK1d3Z3RsYituZTJKUWtOQmUr?=
 =?utf-8?B?RTRUeHJzS1NNdk5hajRXeGRHK1FVdzhVdG55ZXlDa2lROXZlNVJ3eGpUSC9Z?=
 =?utf-8?B?ODArU1hrUklCVGNPMG9iY05memFnSG43djJMK3VDcnJaSFV2UDVhd3JSVVB2?=
 =?utf-8?B?ZjY5bUVvMmlidkxkekZleDEwSHBDYnhvaXpOQzArY1ZNLzljK3E1Vm5ITzJZ?=
 =?utf-8?Q?M3dcDjoQrC+DsAsicKizdUKCfq1VQ4DiOb4DcpI1qN3u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF422F5FDD552140A71BC7E7A0CBF47F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d93e930-9b59-4b5c-c2a7-08da58943fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 23:24:57.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lyd0B45bX9AyW8yqW+8tAa6g3fFpfxSCQ5PzPRN3wm+2lMHny+2AArV62vjz6vjrjWjeYlRloca6/ripRCE6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2312
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270095
X-Proofpoint-GUID: zUyvOwcNb3eVTxe01n17P1uceSpaci9J
X-Proofpoint-ORIG-GUID: zUyvOwcNb3eVTxe01n17P1uceSpaci9J
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_162511_484752_E9646F19 
X-CRM114-Status: GOOD (  28.71  )
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

DQoNCj4gT24gSnVuIDI3LCAyMDIyLCBhdCAyOjAwIFBNLCBDaGFpdGFueWEgS3Vsa2FybmkgPGNo
YWl0YW55YWtAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA2LzIyLzIyIDE1OjQ3LCBBbGFu
IEFkYW1zb24gd3JvdGU6DQo+PiBJZiB0aGUgY2xlYXJfaWRzIGF0dHJpYnV0ZSBpcyBzZXQgdG8g
dHJ1ZSwgdGhlIEVVSS9HVUlEL1VVSUQgaXMNCj4+IGNsZWFyZWQgZm9yIHRoZSBwYXNzdGhydSB0
YXJnZXQuICBCeSBkZWZhdWx0LCBsb29wIHRhcmdldHMgd2lsbA0KPj4gc2V0IGNsZWFyX2lkcyB0
byB0cnVlLg0KPj4gDQo+PiBUaGlzIHJlc29sdmVzIGFuIGlzc3VlIHdoZXJlIGEgY29ubmVjdCB0
byBhIHBhc3N0aHJ1IHRhcmdldCBmYWlscw0KPj4gd2hlbiB1c2luZyBhIHRydHlwZSBvZiAnbG9v
cCcgYmVjYXVzZSBFVUkvR1VJRC9VVUlEIGlzIG5vdCB1bmlxdWUuDQo+PiANCj4+IFNpZ25lZC1v
ZmYtYnk6IEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMgfCAyMCArKysrKysrKysrKysNCj4+ICBk
cml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyAgICAgfCAgNCArKysNCj4+ICBkcml2ZXJzL252bWUv
dGFyZ2V0L252bWV0LmggICAgfCAgMSArDQo+PiAgZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhy
dS5jIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDQgZmlsZXMg
Y2hhbmdlZCwgODMgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL3RhcmdldC9jb25maWdmcy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jDQo+
PiBpbmRleCBlNDRiMjk4ODc1OWUuLmZmNzdjM2QyMzU0ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0KPj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9j
b25maWdmcy5jDQo+PiBAQCAtNzczLDExICs3NzMsMzEgQEAgc3RhdGljIHNzaXplX3QgbnZtZXRf
cGFzc3RocnVfaW9fdGltZW91dF9zdG9yZShzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sDQo+PiAg
fQ0KPj4gIENPTkZJR0ZTX0FUVFIobnZtZXRfcGFzc3RocnVfLCBpb190aW1lb3V0KTsNCj4+IA0K
Pj4gK3N0YXRpYyBzc2l6ZV90IG52bWV0X3Bhc3N0aHJ1X2NsZWFyX2lkc19zaG93KHN0cnVjdCBj
b25maWdfaXRlbSAqaXRlbSwNCj4+ICsJCWNoYXIgKnBhZ2UpDQo+PiArew0KPj4gKwlyZXR1cm4g
c3ByaW50ZihwYWdlLCAiJXVcbiIsIHRvX3N1YnN5cyhpdGVtLT5jaV9wYXJlbnQpLT5jbGVhcl9p
ZHMpOw0KPiANCj4gc2hvdWxkIHdlIHVzZSBzbnByaW50ZigpID8gKEkgZG9uJ3QgdGhpbmsgc28g
anVzdCBhIHRob3VnaHQuDQoNCkkgdXNlZCBzcHJpbnRmKCkgdG8gYmUgY29uc2lzdGVudCB3aXRo
IHRoZSBvdGhlciBwYXNzdGhydSBhdHRyaWJ1dGVzLiAgDQoNCj4+IA0KPj4gK3N0YXRpYyB1MTYg
bnZtZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRfZGVzY3Moc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0K
Pj4gK3sNCj4+ICsJc3RydWN0IG52bWV0X2N0cmwgKmN0cmwgPSByZXEtPnNxLT5jdHJsOw0KPj4g
Kwl2b2lkICpkYXRhOw0KPj4gKwlzdHJ1Y3QgbnZtZV9uc19pZF9kZXNjICpjdXI7DQo+PiArCXUx
NiBzdGF0dXMgPSBOVk1FX1NDX1NVQ0NFU1M7DQo+PiArCXU4IGNzaTsNCj4+ICsJaW50IHBvcywg
bGVuOw0KPj4gKwlib29sIGNzaV9zZWVuOw0KPj4gKw0KPiANCj4gY29uc2lkZXIgZm9sbG93aWcg
aWYgaXQgd29ya3MsIHRvdGFsbHkgdW50ZXN0ZWQgOi0NCj4gDQo+ICAgICAgICBzdHJ1Y3QgbnZt
ZXRfY3RybCAqY3RybCA9IHJlcS0+c3EtPmN0cmw7DQo+ICAgICAgICBzdHJ1Y3QgbnZtZV9uc19p
ZF9kZXNjICpjdXI7DQo+ICAgICAgICB1MTYgc3RhdHVzID0gTlZNRV9TQ19TVUNDRVNTOw0KPiAg
ICAgICAgaW50IHBvcywgbGVuOw0KPiAgICAgICAgYm9vbCBjc2lfc2VlbjsNCj4gICAgICAgIHZv
aWQgKmRhdGE7DQo+ICAgICAgICB1OCBjc2k7DQoNCkknbGwgaW5jbHVkZSB0aGVzZSBjaGFuZ2Vz
IGluIHYyLg0KDQo+PiANCj4+ICBzdGF0aWMgdTE2IG52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lk
X25zKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4+ICB7DQo+PiArCXN0cnVjdCBudm1ldF9jdHJs
ICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCj4gDQo+IHNpbmNlIGN0cmwgaXMgb25seSB1c2VkIG9u
Y2UgaW4gdGhpcyBmdW5jdGlvbiBkbyBjYW4gd2UgZ2V0IGF3YXkgd2l0aA0KPiB0aGUgcmVxLT5z
cS0+Y3RybC0+c3Vic3lzLT5jbGVhcl9pZHMgPw0KDQpJ4oCZbGwgaW5jbHVkZSBpbiB2Mi4NCg0K
Pj4gDQo+IA0KPiBJcnJlc3BlY3RpdmUgb2YgY29zbWV0aWNzLCBsb29rcyBnb29kLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+IA0KPiAt
Y2sNCj4gDQoNClRoYW5rcywNCg0KQWxhbg0KDQo=

