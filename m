Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02146C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bp2fqyyKUrCUoqcTQcgDfxFkfq7ihOHtituknGPPr4g=; b=ResnEzJsYoaZUpxkpOs8AIaI3M
	ueKcic3MOkfW5hYiX1NAs6u97B1hFSGmS8DTpJ2Kq9x2ZOFuKVsDDD7zjO2JKTA0UYRSpL/hfMcUV
	BTLt38fGhExqAYlJjw/ej5phosbBAcqX39k1FID70yS90L00M9dS/WOb+br3GO69/TLhcYz6yMFKz
	a9FsR7oNmkaepKeMIi92zhkTW2KZjKJpPKs3l4kaPueUygJYvf2meHLXdOkX8gbXDPg54ILFMj94P
	DEW17OaL4ULnBFiRveR0RyBer1QP6tjVfr0NQszptlqvPL0k4LTQtq8olzRFPKXgkQWEUly9vZAbv
	9h3vlWfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKdx-002wKC-32; Mon, 06 Jun 2022 21:52:13 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKdt-002wJI-G9
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 21:52:11 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JClIn031745;
	Mon, 6 Jun 2022 21:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bp2fqyyKUrCUoqcTQcgDfxFkfq7ihOHtituknGPPr4g=;
 b=bV0i3SWjwQn/vICtnk+Jf/6Ts/uULzEIytIRvRhYW2XQJAQ+mXoRsU1P9dJCJktiSCy8
 GGIfraP7+Gj4lS12JpIhIYer9MPfFlzLdRRnVDYVOjNym/AAMvfnUhMINTXNMYVXMgYu
 DvgUbAkuP8J2PFGT3zM2vtu0CI0uDjKw5MxpjHTeXqx70w8tW2U1/h9C9GR2zVLxbpQ/
 JHYyaEMBgYIt5ugNh87BiNsaFdV7NkfpldmVgS45KLVSa2gEqY5pvdikBymhl3ud6S7W
 KzbSKgF6aCVJrOH8hXQMH6MBZQLA5lDOJggig62YAN1X+bi47zN4o3TMmXuCueAHpAY9 YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe9m73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jun 2022 21:51:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256Ldwpe035175;
	Mon, 6 Jun 2022 21:51:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu22f7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jun 2022 21:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLCn0r5UMsSG2NNyBFIFsKlkPQCmHQZINdxVTDKvK4jAz3U0fakyd1GWIuh6o93O1ZgmUUn0Qssqq49VKUMkbfrEG2a8f1yefAHpjb4mV6t8sdj3qEdNAxv0w4TEyri6JZrzGTdFzuPfIHzr5pM+xmR+RmDAMvmKWw/3uDF1d/2cTBsqkJEHaOu3nkYDJY+OnS8vLHJoAv0zN3AO+RjgB6fOTZN8XxZHz86peJkrKliaajUtLyvF0bYShBDzeGt2Ulgxhdhh9eob5R1jrOMd83ww9B5RevaY+Dt48cHmyCu91NWzVylAIvwu5b21Nme2Jv61Tv3qi8O0waZTg9OBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp2fqyyKUrCUoqcTQcgDfxFkfq7ihOHtituknGPPr4g=;
 b=HnhX85sIRbdzVum8uUHl+aU1UTLuXUK67BGNtG8L+KkNpTnJ4jIFq9DXsbcAqZwhAcNFhdvYPWpbMKYsEU0I2vgGiFABrfFp8gVydTTLb4L9Xu6o7noN5EKlNS8cCOOurr6HG4bnSwTHcNNdc+q8mNjkEP6Prz5dbxjQcrPIY4nEJYhRwTTbZtbz8E50E+sMjBoAeJCiB5M2ms/qQHlIRKTLYcVDEvZzB/Kp3mgkyx7+OZnjBtIBq+6yTFUyxpDJZ2OiLmONilWME3yh28/CU2g3DFjTUkdzvH0xSmiotPd94K7LboIqWacNx38ze4dDYqwVbEpgcz26lN99dPDqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp2fqyyKUrCUoqcTQcgDfxFkfq7ihOHtituknGPPr4g=;
 b=bGbyfl9uP7yN4RKYesaW3IQ6fI99Ewj2XP5QWsskBQ7yyYZMeo2ubsmhXJj9N74LeK0CjCkRBZjXcPrS0LofGScukW3LGrLtHbOY+3OJNJvXPLLbOYw33e1L1VLWU4wsCHp8aIpwcqO7+mt/0UOzocs5t3LqYATc4iIP3RxH/dw=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MWHPR10MB1264.namprd10.prod.outlook.com (2603:10b6:301:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 21:51:55 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 21:51:55 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAARsYCAAAOfgA==
Date: Mon, 6 Jun 2022 21:51:55 +0000
Message-ID: <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com>
References: <Yk+KO8hEYpnKdGu3@garbanzo> <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9efeddde-fee3-4906-644a-08da4806c629
x-ms-traffictypediagnostic: MWHPR10MB1264:EE_
x-microsoft-antispam-prvs:  <MWHPR10MB1264169187B999F63D5EA6DAF4A29@MWHPR10MB1264.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  AxoIIy5CdrP7YVZmLVUPbD52NlfNer5expIP2LHKi7VXNDQUUd8zcpm1plELE+VvRlcD7sewIAfsljzWqtWel0A6C4XlAGLUFC4VNvqJRyNbyeb8qnK700Q4MQdbPcizIcDdnnEBz7KhS8lW5ZEw7z7Af5yB5fDvisLSkezW9Z583CmZ6fMhX8vYMC/FMfEagjnSugTasXAYA7luA0hpVKNCsJIuNwnZzsB36ZLFhZJ/ig46QFHbzOFbETZRVOPnfSsYrY345ArcuXnxO2yx7NSBfkouF08gdfEH2ZVquwxxm6Kf7QHnUguw+a9L6oWgMig1ozWpTMf7kzRzxH0/TXEyIOzXc3syx9PrwARqxfeCBfGJhhuu7TX+GJYJqPlNPc2xO6NMfDo92Bi8npQl6W9ej75eFuYboxKs4mKif6FF4+zV6ixS/BqK1/RO6D41lurzFv8LbA8/UGOmcVOil/oMbyZezj2bea0Qfw0kSTqRbu4XatjRjmFL6rqV08Mk48emXbi2pNfklzZWpgErvxcLcdAQXd4M4E3p3X+U1GR3QgTR+VP9d5V7A2CfyCCLN57NuNxsMoGr5NFMJ72QIEXr2k3ZqwYnTYUNeb0lucikT/i5RBXJrMT77NnZ3Bc/S+FZmpZiOW90LLiikMLFx1VfUAckjrWI29jGCGeMSpvOYxB1IWCcwSLhuRvdVv6btZ5AVve3pjghfrz2sGsVa82pFLnNVwmJzKooNwxDwGw=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8676002)(54906003)(122000001)(44832011)(53546011)(4326008)(66946007)(6916009)(66556008)(66446008)(33656002)(8936002)(6506007)(66476007)(316002)(76116006)(2906002)(36756003)(5660300002)(508600001)(38100700002)(2616005)(6512007)(64756008)(71200400001)(38070700005)(186003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RHJyd0FRa3N6L21RUDhaRHU1Ri9VZ2VlRjBNSzQzWEVXWTh5VDdybkE3WXZ2?=
 =?utf-8?B?SDQxSDlTR01MMjlrMnQraHRpOER2WnlFR2FlcjJXSXVHU3p1Y2RDcTBuTENE?=
 =?utf-8?B?VVEyU3VsZkVuYlRjZ1dnS1I2bFVtWXZWbmlrU2p1L3FHYW9LUjlkMWVqNDBh?=
 =?utf-8?B?dGlvKzZoZThOYjdNQXlUcWlqMzVnUnVlNTVaYjF5Tkc4dmhKTjNmYThjTXV1?=
 =?utf-8?B?SFp1Q0ppc0dlOHdUL1A4K1JSSUp3a01JRjVSYk45bHRCQVZhL1F1RlowbGNx?=
 =?utf-8?B?MTNhejY1ZUZwRW1ORmQ1TEZQWUY3SEduUndPWmIwUVlYMFhueWpBdmE1R3Q1?=
 =?utf-8?B?S0hxcFN4UFpvNkNNYkd4b1dVWFFLbUV3OVVGbktoZ1U0emRXMWxGT2gyK0h5?=
 =?utf-8?B?Z3o1Nk5HT1FQczhKVUNLV0hFeUJHa3pPSEZBNHZCWHI5MlhicXFxME41djF3?=
 =?utf-8?B?b3p2SUY0a3Y2dDE5MURyalkveXMvQW8zeGJNNC9rTzhLMVl2aFZFWDFmMjZt?=
 =?utf-8?B?ek5qbTlaM0h3OUJ6QXhLcEtjNk5lSXk0UUczWW5NOVJJNi9FbTdtYXZaQ0dF?=
 =?utf-8?B?eVNhcjRKYmh6SDlqdWdrclRCcGFkU29zenJiQWJNSmtxWnBVNkU2MHZkd3Mx?=
 =?utf-8?B?SXlWQnFLRitESkpQVjlFODk5NExYRXRkSlhtc0owVmYwbVJac3Bibld0TDlh?=
 =?utf-8?B?REhQVk13OU9nZmNNVE5MVHBhS0ZvRUI3TjhKNnRvR3N2L3ZZTTAxK2NEa3pm?=
 =?utf-8?B?eWpHc0xpME1SK1ZnaDAxMDY4b1d3OXdIRUs4d2ZzUU1nR0tTc2ZMdml2b053?=
 =?utf-8?B?U2NuanhvcGtrZEpveHBhSXd3cFVUdVNTaGR2SjM1YklndldLaGZCR0E5L0RQ?=
 =?utf-8?B?ak5JREljR1IyOE1xYStINTI5NHdhYzhrN2IrWGxOVWU4LzJCVHVmTmlOc2RW?=
 =?utf-8?B?L1FYbnVrRy9ZaVZXZFBPMzNQQnk4a0NaaDUvUkpDOWJLem9qSG41L0tHd1lI?=
 =?utf-8?B?ZnkwVnArSEhYMHNzZzZIQS84bmc3ZHhOR1YxeHlEeUtiNDlzSTQra1liUC9E?=
 =?utf-8?B?UEVGdG1xRUhVTXRHVVpRdW5yUGR2WmVRRWRUemc4Q3BQcnY2Y2xEMnN6WGZJ?=
 =?utf-8?B?d3dpYSt4TlZiaGF1KzdTTDdOQTVHbmRrYmZtWHhvdEhjazAxUGs5cUkvTjBr?=
 =?utf-8?B?ZVcyaVkzV1k3UzRVbktVRmwxUjVKVVhIL29SQk1WbVR6TWlHem4zVjhENGlm?=
 =?utf-8?B?UHZWcjBwU2YvYkhGVWVkMjBKV1BTT0poc2ZJVkg3cXFtT0FwUjAreFBRMzVZ?=
 =?utf-8?B?NWcyRTF2MklXdHM4WWRzY3R0bXljOVlBN0VjY3cxN09nVFZ2eUpLWWFlMHlh?=
 =?utf-8?B?SmNENDJseEtZZXBKdlJYWlZRZGcrYzhrME9MRUFscll6cEh2SDlIcW1lT0p5?=
 =?utf-8?B?ZVFwc3RJMGE3blFGYUo0K0xKak03ejlwanBVWEYramdqQjl6R1dwV0hUNVNE?=
 =?utf-8?B?Y2ZnazI1dXNvYStieURIUVgvb3NEL0tCdjlTMFZJMHJNTGZsVXBNbnBwNEpY?=
 =?utf-8?B?QmNROWhmQlpwZUk5U3RQalZmeXlqczhWSExMNFhDbk5MQjVCRTcyS3I5YXRZ?=
 =?utf-8?B?S1BzZE9Tb0ZmL2t2eGdOT3RzTnBISXNVcVVsdm5sYkY4T3Y5RGhyb2gwQnd6?=
 =?utf-8?B?YTUzZndKZS9Ma2VGdHJRbzlrTVB1L1RaR3hFN3hjODc4NFdnenB0OEl1S2RV?=
 =?utf-8?B?M1RjYjBucjJvdVZsblRvQ2lUVVRHUzZOTUpudVNwQnBZcWVLNkRlalI2Kzk2?=
 =?utf-8?B?R2xOWXMzNmo0KzNlQzhkRjhwcjNpWW05UC9lOHR5aVpjbEYwaURxUXFSeitH?=
 =?utf-8?B?NDVZWnVLNzZlT1ZwZlNBTmplSERJOHM0V0h6U3BPaUUvZGlrd2FzKytyMFFS?=
 =?utf-8?B?TjdCdlpybFYyQ1l0cFUyUkJJVDNzZ0V5QkI3STRCckV5bHd1Nk1taXpEU1Nh?=
 =?utf-8?B?OGNFbmY0UEFFVHdQR0pFck5sZmpIcTZuUkZZTHRzZ3cwZ1VreFFmdVR4ckZG?=
 =?utf-8?B?YXE4ZmZNSXkzeWNWVmliRlBTOHJEa29OWHBaUmVhaTFRVXVsRk1RRTQwUWVY?=
 =?utf-8?B?SWFKb2s5TVdUUm9sMm5Oc3dVSW00V2VYcklEOXoxSlROZzluNFpURUM5WnZT?=
 =?utf-8?B?V05pV0lpYlV6QlBaQ1VOLzNwSmtvTlhzOVE4STBNUWpPVEZuMndiRFdrZVlS?=
 =?utf-8?B?a3J2aGxJQ0IrSmRkQ3VwY2l6MlNnQ3Iwa2RtVzZZWlJoSjZwOEVqWmVrTFdG?=
 =?utf-8?B?anIvWWZhMzZUbXJKSlhscU45V211TUpWaVV0cmM4bTJ3SEowNS9oL1k3b05F?=
 =?utf-8?Q?2wKzcU4stA1xljkZNmdKjHkkuxQQA/LHU1nUkJWOoF8o/?=
x-ms-exchange-antispam-messagedata-1: 7OrZ8hGwusOPdA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <62A7DD08D54FF24F9C150535F5BBB926@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efeddde-fee3-4906-644a-08da4806c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 21:51:55.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cItVKKbljiWk+FdHJyMUIl3pTHNioWa3e+IySjcX2pVNjaMTYRfnk44thIRZfghQEfXqpCKUm+Ju79rUonJVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1264
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_07:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060087
X-Proofpoint-GUID: 9NozauRknpbjW763Nalqzb1O5-VN2KrA
X-Proofpoint-ORIG-GUID: 9NozauRknpbjW763Nalqzb1O5-VN2KrA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_145210_513226_2E744F8C 
X-CRM114-Status: GOOD (  28.41  )
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

DQoNCj4gT24gSnVuIDYsIDIwMjIsIGF0IDI6MzggUE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAwNiwgMjAyMiBhdCAwODozNTozOVBN
ICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEFwciAyMCwgMjAy
MiwgYXQgMTI6MzYgQU0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBNb24sIEFwciAxOCwgMjAyMiBhdCAxMTozMDozM1BNICswMDAwLCBBbGFuIEFk
YW1zb24gd3JvdGU6DQo+Pj4+IEkgcmFuIGludG8gYW4gaXNzdWUgd2l0aCBibGt0ZXN0cyBhbmQg
bXkgcWVtdSBzZXR1cCB3aGVuIHBhc3N0aHJ1IGlzIGVuYWJsZWQuICBUaGUgcGFzc3RocnUgdGVz
dHMNCj4+Pj4gZG8gbm90IGNvbXBsZXRlLiAgVGhpcyB3YXMgYmVjYXVzZSB0aGUgVVVJRCBmb3Ig
dGhlIHBhc3N0aHJ1IGRldmljZSBpcyBjb21pbmcgZnJvbSB0aGUgYSBkZXZpY2UNCj4+Pj4gZnJv
bSB0aGUgc2FtZSBzeXN0ZW0gc2luY2UgdGhlIGZhYnJpYyB3YXMgc2V0dXAgYXMgYSBsb29wIGFu
ZCBudm1lX2dsb2JhbF9jaGVja19kdXBsaWNhdGVfaWRzKCkgZmFpbHMuDQo+Pj4+IA0KPj4+PiBU
aGlzIGlzIHByb2JhYmx5IG5vdCBhIHZhbGlkIHJlYWwgbGlmZSBjb25maWd1cmF0aW9uLCBidXQg
c2luY2UgYmxrdGVzdHMgdHJ5IHRvIHRlc3QgZmFicmljcyBvbiBhIHNpbmdsZQ0KPj4+PiBzeXN0
ZW0sIHdlIGhhdmUgdGhpcyBpc3N1ZS4NCj4+Pj4gDQo+Pj4+IEnigJl2ZSBoYWNrZWQgdG9nZXRo
ZXIgYSBmaXggdG8gbWFuaXB1bGF0ZSBOYW1lc3BhY2UgSWRlbnRpZmllcuKAmXMgdG8gZ2V0IHRo
ZSB0ZXN0IHRvIHdvcmsuICBJcyB0aGVyZSBhDQo+Pj4+IHdoeSBmb3IgYmxrdGVzdHMgdG8gaGFy
ZGNvZGUgdGhlIElEcyBmb3IgdGhlIHBhc3N0aHJ1IGRldmljZXM/DQo+Pj4gDQo+Pj4gSG1tLiAg
SSBzdXNwZWN0IHRoZSBiZXN0IHRoaW5nIHdvdWxkIGJlIHRvIG9wdGlvbmFsbHkganVzdCBjbGVh
ciB0aGUNCj4+PiBJRFMgZW50aXJlbHkuICBPcHRpb25hbGx5IGFzIGluIG1heWJlIGEgZmFicmlj
cyBjb25uZWN0IGFyZ3VtZW50LA0KPj4+IHdpdGggaXQgZGVmYXVsdGluZyB0byB0cnVlIG9ubHkg
Zm9yIGxvb3AgYXMgdGhhdCBpcyBwZXIgZGVmaW5pdGlvbg0KPj4+IGxvY2FsLg0KPj4gDQo+PiBI
ZXJlIGFyZSB0aGUgY2hhbmdlcyB0byBzdXBwb3J0IGEgY2xlYXItaWRzIG52bWUgY29ubmVjdCBh
cmd1bWVudC4gIFdhbnQgdG8gZmxvYXQgdGhlc2UgY2hhbmdlcyBwcmlvcg0KPj4gdG8gc2VuZGlu
ZyBhIGZvcm1hbCBwYXRjaCBvdXQuDQo+IA0KPiBTaG91bGRuJ3QgdGhlIG52bWUtcGFzc3Rocm91
Z2ggdGFyZ2V0IGp1c3QgY2hhbmdlIHRoZSBjbnRsaWQgc28gaXQgbG9va3MgbGlrZQ0KPiB0d28g
Y29udHJvbGxlcnMgaW4gdGhlIHNhbWUgc3Vic3lzdGVtPyBUaGF0IHdvdWxkIGp1c3QgbmVlZCB0
byBzdG9wIG92ZXJyaWRpbmcNCj4gdGhlIHN1YnN5c25xbiwgd2hpY2ggaXMgd2hhdCBjdXJyZW50
bHkgaGFwcGVucy4NCg0KVGhhdCB3YXMgbXkgb3JpZ2luYWwgcHJvcG9zYWwgYSB3aGlsZSBhZ28s
IHRob3VnaCBJIHdhc27igJl0IGNlcnRhaW4gd2hhdCB0byBjaGFuZ2UuIFNob3VsZCB0aGUgVVVJ
RC9HVUlEIGp1c3QgYmUgemVyb2VkIG91dD8gIElzIGl0IG9rIHRvIGRvIHRoYXQgZm9yIGFsbCBw
YXNzdGhydSB0YXJnZXRzPw0KDQpBbGFuDQoNCg==

