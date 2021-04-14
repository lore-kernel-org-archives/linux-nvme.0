Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29711C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 19:17:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8CE61132
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 19:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8CE61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FKXDI1PC0soLHdllJE0LarnhuUVxA5etLHnWNKzPVPw=; b=TzZmab+L8W2mXS
	KQBgJ+YAKbmKBtu7CwO6kt+oIff/qTK8kpDJOJ5w0zwcuWOrwOGA7Tani5DLsqxWWkTY169dil1x7
	bAzKTvPe5iXJ903yFr8J4eNiiE3u8gcDuNC1L7B7q0GZaeZHaploXvLhK/9IE9Hz57eyg36ET/u1D
	DH0vc60uVNZGuWi6H1UpGMDxEz5Pg5XpRcvBJqQx+416TlSlqCoOK4P2eFni/4byjgNLZ3a39SBQw
	dUHE2DLiqEb4MpRzqBRhA3Pback1adYQcGglJxDcNE/Pmtk3kzI8yNzcBvf1JaFcJbm10sOQcPLBH
	SGJoxWQtkstC/MKDLQRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWl0S-00DWbL-UM; Wed, 14 Apr 2021 19:16:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWl0O-00DWY1-2N
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 19:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:Sender
 :Reply-To:Cc:Content-ID:Content-Description:In-Reply-To:References;
 bh=fCaOgllbOe/1/T+qu37ouYT2NzGB7hqBYRoIToNSv7I=; b=vXJuPgqNjiTrOJPKEXxCyPl9NG
 BkdI71G0XroLsD96zXgoyWGbBCsbMxG8SBO045ISao7fi5otAFYICNnjgsz72pKwIqhHhBZUbwEoQ
 0OyxC4QumGoV/DLra2tWW35DqVXENAl6LecI+n2fUD0YSarV49fg+dinSLUsxtIMRlU1uaj0PRncg
 oRvOnt/JkwpTlLmWJi/9NfoyXFNUYU68mV68Fhiy3vkWsYhXQh7OxdEt3/oW5ec/UwH6x4FCeEfKi
 r+H5nnk/7UqKWoqWseFtxUe4oONDP0oJcZylIb22isFeEav/F+9ySAeX7mzxlRZExLEMushA/jwBC
 JlvJsUbw==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWl0K-0082mc-PB
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 19:16:50 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13EJ7stC004284
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 15:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=fCaOgllbOe/1/T+qu37ouYT2NzGB7hqBYRoIToNSv7I=;
 b=ucND/swC1OWaYUrsZlJJkbOnWYP9/G4jG6WAkxYvqOLPGUe4xsHGU0ZdM8BlH+6KL77l
 kEe3eDb0MpLmLx99v4rbKFvMKUDIVXqG5b5LuR4wvTMIbE4BKVm/aMxKxalDYu6DE5V0
 +p/vpKbDD4/XYdcBqk1u0F5MM1MFDLz3elq5nJmUUqw+bVlHQ7aWUA9TBzqxToGEwu1b
 KciGmvqLaP1RTWp8UFIe0JVwedazhwk9p8qyXhPReVWvKV5cclBWZtyQP2INlHgPEiAp
 uXlUqZF4zKpwLObc6HUgdGxu/vCLenira8fNxd6VZc1p5z3kivHyBAX8uJNjPxOVnI7V oA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37vv6sh4wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 15:16:44 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13EJEYlZ076576
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 15:16:44 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by mx0b-00154901.pphosted.com with ESMTP id 37x0xm6e9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 15:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9LqLcCrBdHofuB3ELuJo1f97MPBS+cDJYOqSIgU9VJlv6CNbLZZXx9w+plQW03mBhgvKOlNVjhLq2oLi5imkr/E8oX+K43v6XHEtNnTtZ7RTtaAy/h72aB2d4yaDFBpprjjFDTwxmZ3NTfzHP0FjbmzDLiBaQV2TzNEtKW0LamJ6n2bjrH5qDDtsrYvi0q40SQ/tjWU9dN3X6RaCza9gGsaRW8QQPtNs0DCTpbTN4STMKoacU6iti3avfriFUCdZiQi/XKOahuFev4d+ITI00ccC6KCMzM/jARR38alKTVCwaDS4XB9xVsAMwRYWe4RR1O5X5nYWMX4n7oxe8IdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCaOgllbOe/1/T+qu37ouYT2NzGB7hqBYRoIToNSv7I=;
 b=S8+ak+cZV9WU989K8U4941MDHCtaRF4xDpHHdcWmenYDOWklDN4J9oP88KvS8SZ/h/UM6qhlglS8O/tbhyi84G1YVKVqF4cptVpOgSp3Y575CSPXlj+OjBNhQQRCzTaR7CwoKG/2GewPyH91XGg7rN3orKd0eyTQ1XLKjvucRofqg9c5fdlgyRnUYZ4Xge47273xzwTRZ6RlueTIvRtIxd0OLMQn4S2ehtUr9cMMN8IlZo6xnwoEalcSYWanEdP6012qTY7cGB1oqlyGO9On6R5r7gRXK45+5h+H40rnJUBA9F/5AFjeu4PKIyjob2vpJTCg3yRNCxgd33/6h35NGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3972.namprd19.prod.outlook.com (2603:10b6:a03:225::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 19:16:42 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 19:16:42 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: How to submit a patch to linux-nvme
Thread-Topic: How to submit a patch to linux-nvme
Thread-Index: AQHXMV05jmLJ2FYcgUOho230grpqlQ==
Date: Wed, 14 Apr 2021 19:16:42 +0000
Message-ID: <SJ0PR19MB45444DF2DD618E99148344DBF24E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-14T19:16:41.702Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 540694b8-6dc2-4ebe-b7db-08d8ff79d644
x-ms-traffictypediagnostic: BY5PR19MB3972:
x-microsoft-antispam-prvs: <BY5PR19MB3972F33B9F39275B5D5F8A20F24E9@BY5PR19MB3972.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Na0RHgMhYONruPHQtFaByDIYdvRvydxg+GKbiiYMw4/PJaEXHAUc967ORysfnRMJYlFRUzqDgU1i4Uj5Nr0oU5LsMEpm7Mm1StPchmv7Bt7BYe+D4ddhwnW4CDg8GiaxdGP3rU5d+8elHFr8wD+2qNmhCfi23+z0c6VGgQhBhlAdeE1b+6kFpmX+7WZOwBuXbfvzrdAd69b569lh4bk9gbbpvi14SoPvoxpWmPdbX912rjPE0b245FSd1htZRODpN+iYPqlSmTKHeP6DXJEoCktfyLPtiLInJu8B0c0pM5kaWKNeSeqUDVEWBPomn9p5gUJ55O+ZXjhsfPMTV/bBEpeBonerUzrLo267TNoUNDAiGSzVM8XWCPgtztDw/n871GkXHi8H98nFHB9wDtEZLi01BBOIDWfYRvq5Xk5VGHE8mAICrA4S3ZpXXpaMKjR4BAhtaShTeUIJ3kHS+YuprKYfS9LI6tFA/2qIR0eh2FPB+okPMtvYbZzjBSE2TJRkPdwahHKFPKiAEo5tovxstQU3nQ2iHmUGb7uis1fzINq0hh11Ut2zAg0oF7IYTf2yKZBcdvOnalfGWgwjBozFpyFQGrDroWJuE1gNxpxlcvZEx3oA+vqo3VP55uDsBZBR6awwn/7rSRfCigFn8Rp/3I19AI3mH64QWqdZF2LnWvbZTh1GALRIGQBpZjuwMXAP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(122000001)(316002)(26005)(786003)(86362001)(186003)(7696005)(6916009)(55016002)(8676002)(4744005)(5660300002)(52536014)(8936002)(83380400001)(38100700002)(66446008)(66946007)(91956017)(76116006)(478600001)(6506007)(2906002)(71200400001)(9686003)(66556008)(64756008)(66476007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Ket2QB30N7eEZvdQGpomWR0e9E2SeD2Ip8XLjofVWpKhEpImQUtlJMagf1?=
 =?iso-8859-1?Q?Mx3KQBrCvNjgEny3ujy5gXdnre3tD3ocpWkT0vj7HebJpE7vjltkeiYST9?=
 =?iso-8859-1?Q?q+Paktqr83dALCqsCQslHYTQFToOGQG3NzAMSC9Z1H1KbFNMYaqIHm6c00?=
 =?iso-8859-1?Q?0nWe08puyTolmZNMFRDSqCwufpNYTgs7gHNkIDeZdDD4yS0A62KVzkSRvu?=
 =?iso-8859-1?Q?l7gusHPTqBHyj9vjdywB/sKUC+0ygwz9WZLMKl+65TjxV+C4IKwjMnXZbn?=
 =?iso-8859-1?Q?sxP7mFuZE1XBZUz+70ypcAKerwO5TTavsp2fIY9xi5B3YcGvrr4AWOwiNl?=
 =?iso-8859-1?Q?1YMPJ/PKWrKul4uiYQ51n9Q0+UnbFcwyg68DygKVOZ8oxG4uqrNQEuIRtY?=
 =?iso-8859-1?Q?oLAFC+vL/92KIFd6qO9k/vGBUfWx5pMBwyJIMrFjk9rcy80KdqMLmJYig/?=
 =?iso-8859-1?Q?krSjJlm6ooMc5QbRakTMkK5vkxEs5nuDkEge28JbepseDgrZIQgiCsPm0S?=
 =?iso-8859-1?Q?pcZc73cUol6Hp2yvZeG+iR/Pw1DO+2/wthAX58HywAP7Z3ddmNpjdkOfiR?=
 =?iso-8859-1?Q?X2mrA7Tips+o531kflqPMVCeWKzgKO1BOH3imddW/rWa7LZnTrgZzgCAdP?=
 =?iso-8859-1?Q?cnaZqrnPB1TYRgF+BXf2aDuq9iv8KYlNTfyzX5csRMVfcclnH/1BZAPv3v?=
 =?iso-8859-1?Q?pzfaKIfXivREmAprb7plvc3QhJfUXBdoPmMIpjbK1m5ORkax92ehlCQaub?=
 =?iso-8859-1?Q?NCIfWxlTbD3aJKNNB8JKDr2PJivUatM/Y2LBjI4FTMapsz555Jkz8ZauhB?=
 =?iso-8859-1?Q?NwIp/plo/2z+JbqWpsVwKmb+coJPrhypFqS8Fi7UhN1bxQI8yb9k6hJnAr?=
 =?iso-8859-1?Q?2ZtR1sHY7cedc3BSHYIseRAHlqNvmQx/AzRQ0vSzhOHpbYoeCswmTrtYHM?=
 =?iso-8859-1?Q?07WnxlBo0li9WhJ86btlFc1PnZYiPqPN2HTrGGSbNZuWQi7aBsIkrKvXoW?=
 =?iso-8859-1?Q?q9ujj0Ou1bLCnXd1m0Pgu98T+g89E2+sppeFsPVI3o9wJttxbq7y9WtvyX?=
 =?iso-8859-1?Q?hR8i7ux8i2Ub9w7Gm6/c7pfowtsa4Or9B1eWSLyx3FgpQfAjpGLmSC6jC4?=
 =?iso-8859-1?Q?Z5XE4v0sxybiim9GEcUx582hghOkYrcAelgWmObonhOVQQTuE7Idkm7Nt4?=
 =?iso-8859-1?Q?sGGbF4FPA4R3GY4UYvcWVUtP2Z/60ABONt+w49s6UvmRnb0ubOMGI1BPYO?=
 =?iso-8859-1?Q?iZ3wFytu+0J8y2Oikj2Wr6dEgZIrPo4DGTZ6RXDRwuwCFuACAxPDx2RKzj?=
 =?iso-8859-1?Q?GatrE9XP5UxThNc7ItPQLoKr4XPYuiZFxZif9aaaiux51F64FqLi9s+p9C?=
 =?iso-8859-1?Q?ap9P4QEkb8?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540694b8-6dc2-4ebe-b7db-08d8ff79d644
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 19:16:42.2255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsg8fKw8J6DDkN/8h2/KiXOAmw78NVT5rkYW4ZaZMjYXL2H+ON/OXTDtfQOtvbF0cgkF0/TThGt7BB4DfHMPqsiP8qWEm4GohsKeaK2Jczw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3972
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-14_10:2021-04-14,
 2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxlogscore=618 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140122
X-Proofpoint-GUID: Cx10rLzc4Y0SgaVlPeqr3fWOY3ZSbcpo
X-Proofpoint-ORIG-GUID: Cx10rLzc4Y0SgaVlPeqr3fWOY3ZSbcpo
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=755 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_121649_026919_5BEF3D2B 
X-CRM114-Status: GOOD (  17.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I would like to add a new functionality to the linux-nvme driver. I read the "submitting-patches" document (https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html), but I have a few questions.

The document recommends asking maintainers which tree to use. The file "linux/MAINTAINERS" shows that the tree "git://git.infradead.org/nvme.git" exists. Is that what I should use to make my changes or should I use the mainline tree "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"?

It is my understanding that patches should be submitted to this email list. Is that the only thing I need to do, or should I also submit a pull request?

Thanks,
Martin


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
