Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39F8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/u5kZG7bwBxDYXd9GsLlLG1rxPEsuSvCwVwEctzR1g=; b=c5hpuXuX2cga4YddJHWdj7imuc
	OimbxGldMASFZvyikJ6aF9oFUU+hV9jeBRyenG5U5oJxxCGNc7fN4iwdaAMyZJhl4t+u6ZC8it5fL
	zwVmI53fNxuxv/4ML/xzCIVD8p9ftrUl5JUYiJ8ZwwVdbAaAH4P5e7ySC73d3KFrY3RluEXWsiQU6
	rY6ib8hPNCpRLWjXc/MyWBsBto+uKhNXBGTRGVPyfoH8022hFmBPPq8s8UYgtWS4sSi7RUO5D0h4+
	9Nc+2E8VK6xKiOx1hM9uxA1uk3ZHZjZRs1fUyD0oGpmWjIfZr+CRmTgWD6z0l/Cwa9l1Bt0/2mP9D
	XI6yR5hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncZS9-00E6Mk-W0; Thu, 07 Apr 2022 21:14:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncZS6-00E6Lu-7f
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 21:14:03 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237IuiaR014690; 
 Thu, 7 Apr 2022 21:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m/u5kZG7bwBxDYXd9GsLlLG1rxPEsuSvCwVwEctzR1g=;
 b=D2tVCVINaeqzmyN/bHXlrXmXXCiExQY7GCO2stctF9wcGezvvYYmDJL6Cnu9tDBDMbJf
 p6xznbryEN0fALZW4T2twEel09uEL3djosQJWoxC+BuyEK3TLeVx+zL5QoQz9XJ2Jebn
 yNJ9JaO/KVQRovPzP5xA7h6CbWkZ88SUCw1nZKdop3cCDnd9a6QF9WdTxWBSpIHuQVAT
 i62cH0+QpcB3otihc9pls7Alvq+Sb93soIwb8kMnSlaXkjA425KzgR5KGJWPc0fnkGmT
 Sf1u9PrDwdxVXQ/N45z180a1X/pJc8u0eKrRq2is4D38kMUI7fy8/AUQdOaByWNP6pQy pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9vuf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 21:13:55 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 237JcjQa036871; Thu, 7 Apr 2022 21:13:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f97uxbm5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 21:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF9X9I+Z3Bz9rkShtL7HsP3CSCpiBmgs/gT85TtEZSeQVK35HhjHnYU7gIqthc0q+iVkSCZHIgO3j6veEiGr605E46A58uBY5zGq/kJdVbl1HEyqISgyNj05LG05DJP/sety4der8VFI0VqGg2TPdspjSxUBtad5wcoL6zEgvTj+TyfHMMSdb3xSt2ap5qt+QbhLT+M2Vku1h0yxFex+w1Zv1eQmEyGWZJPVsBnMIincqULmXKrWevHno5frRr3hAVZim6i1ymvEFnQmU4Xzbe7fuelUSHHV1R6yT9/wcW6bEKMKLh2+ZfNC74KlhSoRdgiCa1GiQ4n4G9VYsGQCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/u5kZG7bwBxDYXd9GsLlLG1rxPEsuSvCwVwEctzR1g=;
 b=oQfKYViVn43r0z0xJrg0BHfTTdphrRZ5UhkNzkcztKqCOhi2rgfK27hdrcBMoCIFV/raZBIDZcEyJPIkKdgevLafhutDmN6uE5uoZSAnQXqDZoNq6PFA//luTZz+17DhZrAlY81jZQ2XX6BrR++TGXIv88Rs1mDGdOP5ul8eCnI/IqmKp8rAsOmcuslORHSeLOw4wdqMCTNsVvdMNKe+D4Ne0L0z2p7R1XDEodKDVlm/ULH98SH6bfA5ZVIWoe7jRvuQNRiS9WhL4OxZYTcBukS0Fu8d5s2TZSckFB1xj0fcwCwtPTAVt5HRlXMqZXdJnwOpc3jrJMRwQ55oFbTwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/u5kZG7bwBxDYXd9GsLlLG1rxPEsuSvCwVwEctzR1g=;
 b=JosdX5qazqQR5pWTYBqFj5enqv/c1gdyckjeqXJ8vDlIsgC2BqMwo1pZdy+PuPTP8y2vtg0ATNsf/XE0RIDrIEWNHrNehFRkN0CuSpnX0EtIF0+EDsGt6a9/u532pllmuMOaYt1Id4+tjtODAFlvvucPQ8Vn/qe6WH8zUiCLC/I=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 21:13:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 21:13:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAC0P4CAADK+AIAAiyIAgAAGzACAAAbzAIAAA96A
Date: Thu, 7 Apr 2022 21:13:52 +0000
Message-ID: <C8570F84-276F-42D0-9914-4440FAF64B5C@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
 <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
 <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
In-Reply-To: <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17368d0c-931b-4a9b-7ddf-08da18db84c2
x-ms-traffictypediagnostic: BY5PR10MB3972:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397230230760B7E476884524F4E69@BY5PR10MB3972.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: slMpSq+kIY2Xg92k9rtOLOGF5xG1yybhbJFThX0i5yr6CW7V3sk9kUOKT+8rrYzsIbZxw+rbbzjgrzGKASY5TSppAjvGiEt4MklFYPSG6K+c7yDeLYvufvqNYRuOoOC0Xnn8q2YSBOxVXRP9b8XEx2Zj/6XfISpKX34nvvbngl+pK5SZicsJpWNyu0Yh7LHyRCCLPTzi3a7J6EZ5qvb2kbC/CvtLWUzyXgOgqEPn8lg+sgkelcwCoaHJTv4IBucJcPrDnaXF7BS4OqUN4wQEmy06VnSBS/caikKrJyi1PF+HiuV2z4SMpVQmoT8W3mQGHkFy9ms/QLLsCz7pHxKjFCQlD5EaGLc3Aqs8WKRFc5cVHemxKccFKoyxrAuKTDuDx7D5Otb843o7TxA7k+ht7dNjB+1zpMt3uCFrLVYK3KVVXTyVbB+9TxsgNAcOYlMWxfwoIH2TK4GWLRJEXRY//2vLSCstGoMa+YaZN613tLSLBY7lSXt318dqEzAFBoPdNDjK8H7/B70XqNNF7gMbeK1siiqUS4pms4n4xXvy9RYRSNMcBjdxX5YBE41A6dyyTRV79gsBhTLfgwn6a2RdATXk92Gw+ZMro6VWRz2zRUyEaHNZpEfuoxCbud/ZxUEF1/jiDPajN6zENmjqTRE9id+tQgRX+PQAOCHftFaJ6X/rYzlWOoKcYSjSpknsTJlpbvQDTJJM/aRgLGz1YtdRpVnt2hM3Awf+6zILS49/bYVFg0VTp17ZmYryU2bVQ2IjoAzG9QvvSV9AV/8Oo+vkLte3I9wgaR4IAq9IY42sqRrResBLEe5GND9njoeGxy6F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38100700002)(6506007)(8676002)(316002)(66476007)(66946007)(66556008)(4326008)(66446008)(64756008)(122000001)(86362001)(83380400001)(76116006)(53546011)(6512007)(6916009)(508600001)(36756003)(186003)(966005)(6486002)(2616005)(71200400001)(2906002)(38070700005)(33656002)(44832011)(8936002)(5660300002)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q01HMVVIYmZGcTYwejdoMVpBMkFtVWQxem40STErWEhYT2NWenE0TVVOeXVP?=
 =?utf-8?B?Nm4rcTV5VXljZ1htRlZSd3RGdVFTV1gvak9oeDR4K2FGUGdVSVUxeWtTRWpu?=
 =?utf-8?B?Rytqcy80Ny9tcVl3d1llVTVWVmhaak5CV0JoK2p2YWNoTU5vdFIycHlnTE5S?=
 =?utf-8?B?UjlRd2U1UFUxcGp0YXl6bGVQeS90WWxPS25kMmkrei96WDZXRE5CcVg1WS9V?=
 =?utf-8?B?ZHVsMjBNOUJtN1ROK3pJWWpYMWE1V04rd1hUc1EvOEdBVGdJdlRUcnpiUHE0?=
 =?utf-8?B?WXNlcktEK1doZjlHVFZkZjFZcmI4empnR2tmWFdjalNXR2k1c09IS1BNZjR3?=
 =?utf-8?B?MGFTbW05S3JZWGwyYytUdVRjZWRKN29tYmdkV2FoRXloVm91RXliWjlHQVp1?=
 =?utf-8?B?N1IxajlYUHBKbVBZazh4UzVJeEVNRlNtNytyWklkVTd5Ky9sNjRuaDFrVC82?=
 =?utf-8?B?K21jV0dBZm91K2I3Zy81aUhIWkZsQ0I0elRVbFZ4cFkyRFRsbDBENVNuZmQy?=
 =?utf-8?B?Skp5c0tvZVN3c0htOVdvbWc1N3hjRHNqUTY5ZmZCK3ZTbWowbVl2MFNOTHQ0?=
 =?utf-8?B?ZVdJWTdTbzgySmU4Rzg3akphNFdIZStCZ1M1SnhZcm9tWEtxL1hPWVR3OUFQ?=
 =?utf-8?B?UWpobFFyR0FHZmc5YnY1VDRHVXd5MjMwNEExc1lUS1B1UkpwSmNqS0pQUDlE?=
 =?utf-8?B?ZUE2SjZvdmdNbjZhWmVnZm02WU9FVXVZeklhaVI4NnZ6T0RKMzlEL1BPQTgz?=
 =?utf-8?B?UHA3aGg5cHdnRXpDNjBMVis2bys4ZjlDdUFuVno5MlR3cVpJVUdXblhKV3BW?=
 =?utf-8?B?QitzQlllM1h3Y1pDZHd3VzV6VG54eS9iNkRRZzNOT1BtUFdwVTdMd3M0ZHFT?=
 =?utf-8?B?U0s0Z3R2NVJNUHN5elJxdnF2aGhveExRVHlPcWM5U2liYjlyYXUwV2trTnFJ?=
 =?utf-8?B?T1F2ZGNMdVRzL084R2VSNDZQSXRsdmhqMWhxVjdDaWZpRnBtM3A3dXoyc1JK?=
 =?utf-8?B?ZmpMK0VINWhmbXdBZUtjZmVEVE1WdFpXa1FVWGh0OXBiNC9WZG5QOVVHSTk3?=
 =?utf-8?B?YVdHem5FQ3AydTNvRWVWQVZSdDNldEYvTUVtcThOeTRpb0M4NkdMZVl0MWxU?=
 =?utf-8?B?NWJEemhRY0ZVZFBpdUtyVm9Sc0I1VGZjZ0kreEZXMkVhVTFkTUpxeTAzT1ls?=
 =?utf-8?B?UWxYem9ucWROZlNRWVpGeGNSZTFPTmkySTJkektWMFE4U3BnUDM1SVFpdVQ0?=
 =?utf-8?B?Q0Q3L0dIWVZiVUNSSENWQm1zZWJ5SUdqQytCUHcwVnlzMWpLMUtWMEVCRGRE?=
 =?utf-8?B?SHhLS3JxQlRrZEppUXJpc0FiRnkrQmZuOHdyQnRWKzlUVWFoL21JVFQzb0Yx?=
 =?utf-8?B?YXRpYStoZDlTTDFhSmEzU2JtWlM0cEJpbHU2Tmx2VWd4WE9pQzJvVUlpNWdN?=
 =?utf-8?B?TlgrOWZRNWRxa21RNDBNZWZZRVV3K21xWGlBb1JjS1BrSGVQM29CSElJTWh3?=
 =?utf-8?B?ZkhCWWZvamVtRjg3OGZGL1h0am0rOGRkbThQQTdtMlIvaWljeFhocWNSWnNF?=
 =?utf-8?B?N3RWdW9HTHJaUWM2UjhHNS9jSzdvZ0lTM1ZjVXBMNDlyM0F1N29aU1VDc0Ux?=
 =?utf-8?B?TUdneXAwd0FVQ3ExM0JlWURVVHdmRDZqbVFQYTdYd29rYVRNSlNXaWl0NE5w?=
 =?utf-8?B?WEhSeW0zayswcHQzeVNXb0U1c0o0VXhLVkpCNlBRM3Rudi9LVVh2M3VPdVlw?=
 =?utf-8?B?b3Q4OEY0c0lGbmRsK0o0Rjk5RUJRb21oYTF0a1Juc0p6c2R6YnY3NVFvdnFr?=
 =?utf-8?B?bGFaUkNORml2UlAzajA5NjV3WG5UWUhLSXFuT1ErRFdNdVZDbUQrQTl0dTcy?=
 =?utf-8?B?VC9CcFdmZU1xN2FYelJkNi9ibnJONlZ5dXpZQmZBWDhGbGRqd0FsSzMwWjBa?=
 =?utf-8?B?ZFlueHNzWmFrclNNbnp6aUczVldQVmVGVnN3NU50dUt0YzlsQnJab1JqamJh?=
 =?utf-8?B?S016OVJ2MDRZaXBFUlhFY1FVWjcrdWtjSjhwa1ZuNzcvN1ZlK05aY2hpZHZF?=
 =?utf-8?B?ZkcvdU5WUTJNZGhHb2dvYk9QZDJSNFBhZ05SYkdVTnN5QXJTaGZ4OU5VekNI?=
 =?utf-8?B?alJaSk1pam9KVlVjWVJGRkpOK2RWU2N4d3VKc3A4WlZxcVN1TVdiK1JJVTdZ?=
 =?utf-8?B?Vk5ZdVE5S04xWFhLdWx6Qjg4Y2ZVbTFVWUZ5T29sSUt0TkladVdRSUZ1Zjlv?=
 =?utf-8?B?bEJ2cE5ZVVlqQldiYzNMYkxCYkpsS1htQ0ErNThlbEFIZnMvdUpId1hVSHRC?=
 =?utf-8?B?YktHcXYzK1g2b2dHc2lCU2IzbC9ONkhwMVRjRXRTTG9ZbXZETlM5YmNzNitR?=
 =?utf-8?Q?920lvnDv4wu+7Ej5x2NjOhrUiF30XMpiqdnpIvUC4p+wx?=
x-ms-exchange-antispam-messagedata-1: 1KdF0fcCK4zLVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <58F89EF9B872BB46A5E08FDFF3294823@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17368d0c-931b-4a9b-7ddf-08da18db84c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 21:13:53.0120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gB6bffNcEMKHSW/ySGR3lsE2rHaaLvHrKFsXGMRt1vnDedb+mF5aA+tvX7LfFGKQfH6R8GevR/l63xznTCDgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-07_01:2022-04-07,
 2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-GUID: TTL92IwvaK-zQR6_HqO7RWG6Ay4Sr6hD
X-Proofpoint-ORIG-GUID: TTL92IwvaK-zQR6_HqO7RWG6Ay4Sr6hD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_141402_319366_931CCD69 
X-CRM114-Status: GOOD (  29.57  )
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

DQoNCj4gT24gQXByIDcsIDIwMjIsIGF0IDI6MDAgUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hh
aXRhbnlha0BudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIDQvNy8yMiAxMzozNSwgQWxhbiBB
ZGFtc29uIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBBcHIgNywgMjAyMiwgYXQgMToxMCBQTSwg
Q2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IE9uIDQvNy8yMiAwNDo1MiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+Pj4gDQo+Pj4+Pj4g
VXNpbmcgUlFGX1FVSUVUIG9yIGJsa19ycV9pc19wYXNzcmhyb3VnaCgpIHdpbGwgbWVhbiBubyBu
dm1lDQo+Pj4+Pj4gYWRtaW4tcGFzc3RocnUgY29tbWFuZCB3aWxsIGxvZyBhbiBlcnJvci4NCj4+
Pj4+PiBJIHJhbiBpbnRvIHRoaXMgdXNpbmcgdGhlIGJsa3Rlc3RzIEnigJltIGNvZGluZyB1cCBm
b3IgdmVyYm9zZSBlcnJvcnMuDQo+Pj4+Pj4gSXMgdGhpcyB0aGUgYmVoYXZpb3Igd2Ugd2FudD8N
Cj4+Pj4+IA0KPj4+Pj4gV2VsbCwgeW91IHN1Ym1pdHRlZCB0aGUgbG9nZ2luZyBzbyB3ZSdyZSBj
dXJpb3VzIGFib3V0IHlvdXIgdXNlIGNhc2UuDQo+Pj4+PiBTQ1NJIHNraXBzIGxvZ2dpbmcgZXJy
b3JzIGZvciBpbnRlcm5hbGx5IHN1Ym1pdHRlZCBjb21tYW5kcywgYnV0IG5vdCBmb3INCj4+Pj4+
IHVzZXJzcGFjZSBwYXNzdGhyb3VnaC4gIFNvIHdlIGNvdWxkIG1vdmUgdGhlIFJRRl9RVUlFVCBp
bnRvDQo+Pj4+PiBfX252bWVfc3VibWl0X3N5bmNfY21kIC8gbnZtZV9rZWVwX2FsaXZlX3dvcmsg
LyBudm1lX3RpbWVvdXQgLyBldGMuDQo+Pj4+PiANCj4+Pj4gDQo+Pj4+IE1ha2VzIHNlbnNlIHRv
IG1lDQo+Pj4gDQo+Pj4gVGhpcyB3YXMgbXkgaW5pdGlhbCBwcm9wb3NhbCB0byBmaXggdGhlIGNh
bGwgc2l0ZXMgd2l0aCBpbnRlcm5hbA0KPj4+IHBhc3N0aHJ1IGNvbW1hbmRzIFsxXSwgc28gdGhp
cyBzaG91bGQgd29yay4NCj4+PiANCj4+PiAtY2sNCj4+PiANCj4+PiBbMV0NCj4+PiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIyLUFwcmlsLzAzMTE2
MC5odG1sDQo+Pj4gDQo+Pj4gDQo+PiANCj4+IEl0IHdvcmtzIChzdXBwcmVzc2VzIGxvZ2dpbmcp
IGZvciBkcml2ZXIgaW5pdGlhdGVkIGFkbWluIGNtZHMgd2hpY2ggaXMgZ29vZCwgYnV0IGl0IGFs
c28gc3VwcHJlc3NlcyBsb2dnaW5nDQo+PiB3aGVuIHJ1bm5pbmcgIm52bWUgYWRtaW4tcGFzc3Ro
cnXigJ0gd2hpY2ggSSBkb27igJl0IHRoaW5rIHdlIHdhbnQuDQo+PiANCj4+IEFsYW4NCj4+IA0K
PiANCj4gSSB0aGluayBudm1lIGFkbWluLXBhc3N0aHJ1IGFuZCBpby1wYXNzdGhydSB1c2VzIGRp
ZmZlcmVudA0KPiBpbnRlcmZhY2UgdGhhbiBpbnRlcm5hbCBwYXNzdGhydSBjb21tbmRzIGkuZS4N
Cj4gDQo+IG52bWUgYWRtaW4tcGFzc3RocnUgOi0gTlZNRV9JT0NUTF9BRE1JTg0KPiANCj4gIG52
bWVfc3VibWl0X3VzZXJfY21kKCkNCj4gICByZXEgYWxsb2NhdGlvbiBhbmQgc3VibWlzc2lvbiBu
byBpbnRlcm5hbCBwYXNzdGhydSBjbWRzLg0KPiANCj4gbnZtZSBpby1wYXNzdGhydTotIE5WTUVf
SU9DVExfSU9fQ01EDQo+IA0KPiAgbnZtZV91c2VyX2NtZCgpDQo+ICAgbnZtZV9zdWJtaXRfdXNl
cl9jbWQoKQ0KPiAgICByZXEgYWxsb2NhdGlvbiBhbmQgc3VibWlzc2lvbiwgbm8gaW50ZXJuYWwg
cGFzc3RocnUgY21kcy4NCj4gDQo+IFRoZSBpbnRlcm5hbCBwYXNzdGhydSBpbnRlcmZhY2UgdXNl
cyBpdCdzIG93biByZXF1ZXN0IGFsbG9jYXRpb24NCj4gYW5kIHN1Ym1pc3Npb24sIHNvIGlmIHdl
IGNoYW5nZSB0aGF0IGl0IHNob3VsZCBub3QgYWZmZWN0IHRoZQ0KPiBudm1lIGFkbWluLWlvIHBh
c3N0aHJ1IGludGVyZmFjZS4uLiB1bmxlc3Mgd2UgYXJlIHVzaW5nIHNvbWV0aGluZw0KPiBlbHNl
IGZvciBpbnRlcm5hbCBwYXNzdGhydSB3aGljaCBpcyBub3QgZ29pbmcgdGhyb3VnaCANCj4gX19u
dm1lX3N1Ym1pdF9zeW5jX2NtZCgpIHVsdGltYXRlbHkuDQo+IA0KPiBJbiBzaG9ydCB3aGF0IEkg
bWVhbnQgaXMgZm9sbG93aW5nIHBhdGNoLCB0aGlzIHNob3VsZCBoZWxwDQo+IHVzIHJlbW92ZSB0
aGUgYm9vdCB0aW1lIG1lc3NhZ2VzIHlvdSBoYXZlIHJlcG9ydGVkIGFuZA0KPiBibGt0ZXN0IHdh
cm5pbmdzIGFsc28sIGNhbiB5b3UgcGxlYXNlIGNvbmZpcm0gPw0KPiANCj4gaWYgbm90IHRoZW4g
SSdsbCBrZWVwIGRpZ2dpbmcuLg0KPiANCj4gbnZtZSAobnZtZS01LjE4KSAjIGdpdCBkaWZmDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMNCj4gaW5kZXggZjIwNGM2Zjc4YjViLi5hMWVhMmY3MzZkNDIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMNCj4gQEAgLTM3MCw3ICszNzAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lbmRf
cmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ICB7DQo+ICAgICAgICAgYmxrX3N0YXR1c190IHN0
YXR1cyA9IG52bWVfZXJyb3Jfc3RhdHVzKG52bWVfcmVxKHJlcSktPnN0YXR1cyk7DQo+IA0KPiAt
ICAgICAgIGlmICh1bmxpa2VseShudm1lX3JlcShyZXEpLT5zdGF0dXMgIT0gTlZNRV9TQ19TVUND
RVNTKSkNCj4gKyAgICAgICBpZiAodW5saWtlbHkobnZtZV9yZXEocmVxKS0+c3RhdHVzICYmICEo
cmVxLT5ycV9mbGFncyAmIFJRRl9RVUlFVCkpKQ0KPiAgICAgICAgICAgICAgICAgbnZtZV9sb2df
ZXJyb3IocmVxKTsNCj4gICAgICAgICBudm1lX2VuZF9yZXFfem9uZWQocmVxKTsNCj4gICAgICAg
ICBudm1lX3RyYWNlX2Jpb19jb21wbGV0ZShyZXEpOw0KPiBAQCAtMTA4Niw5ICsxMDg2LDExIEBA
IGludCBfX252bWVfc3VibWl0X3N5bmNfY21kKHN0cnVjdCByZXF1ZXN0X3F1ZXVlIA0KPiAqcSwg
c3RydWN0IG52bWVfY29tbWFuZCAqY21kLA0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAg
ICAgIHJlcSA9IGJsa19tcV9hbGxvY19yZXF1ZXN0X2hjdHgocSwgbnZtZV9yZXFfb3AoY21kKSwg
ZmxhZ3MsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHFpZCA/IHFpZCAtIDEgOiAwKTsNCj4gLQ0KPiAgICAgICAgIGlmIChJU19FUlIocmVxKSkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJlcSk7DQo+ICsNCj4gKyAgICAgICByZXEt
PnJxX2ZsYWdzIHw9IFJRRl9RVUlFVDsNCj4gKw0KPiAgICAgICAgIG52bWVfaW5pdF9yZXF1ZXN0
KHJlcSwgY21kKTsNCj4gDQo+ICAgICAgICAgaWYgKHRpbWVvdXQpDQo+IA0KPiANCj4gaWYgbm90
IHRoZW4gSSdsbCBrZWVwIGRpZ2dpbmcuLg0KPiANCj4gLWNrDQoNCkkganVzdCB0cmllZCB0aGUg
cGF0Y2ggb24gbXkgY29uZmlnLCBpdCBwcm9wZXJseSBzdXBwcmVzc2VzIHRoZSBib290dXAgbWVz
c2FnZSwgYnV0IGl0IGFsc28gc3VwcmVzc2VzIG1lc3NhZ2VzIGZyb20gIm52bWUgYWRtaW4tcGFz
c3RocnXigJ0uDQoNCkFsYW4NCg0K

