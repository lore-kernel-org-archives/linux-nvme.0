Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE748C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:36:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85522610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85522610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vYw7Xp+FSJCW0T3VClVqItOzD2+/Bj0M/9wn0i2Gbvo=; b=s52ESNFfmuREUD
	JJXwUhi9tXS6tgeDmYr+BWwRG2CWWmg+fG4PAtHFUgZcjBgtNXjKiKGsDC3Zzi1vhtEMCFgkBY8+F
	ReNeUYvDb75ZuUbuczES4WaNQ6qnSs5hE7Phu/0G2aeLN3g9Pbvt2g2C5eJGyYqQkPO10PIF7ZH9u
	MvH/WNEJOwyYFNuTgtG4+6TdrVpuiUDqDsqsg8KJVMup/zB9FHLqKc6tzlFXaK/77efEhBvXQMCyY
	H/v/H1p8MUcbvh/oMom6S2VhEiGpnwtfw151j9w1oo59Jn+NNoHLHOk/Fe6YoF3CsEm63jm64tiyv
	Gn7Fd8EK6ipfzusc06zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2QJ-008e7j-80; Wed, 22 Sep 2021 13:36:31 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2QF-008e6d-8S
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:36:28 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MCx6lG028873; 
 Wed, 22 Sep 2021 13:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ds4H7BMOFvznmu81it1b4oQ1ESUXWB3ra3SonMyZlU4=;
 b=ALPXBFMmxvd/QHUBFvxHl7Clxc10RaF9d0ddacZiNNbUznrz4N0iR/JmkfTuNSy/5mQ2
 PuGba+7JzQP8ZGDHXWc6bUH4CrtREL47Sx3jfbNQX4xZsy4H+/7+amD3beQiRfMqMomb
 24kshUYy4DN7aiqx4kcgY4/4ilIRLZXSAajGhZfwxBf6hk+0fYh1mIXl2YgCVQs9upg3
 n5CeWgnRvl6UIodeIxS9wT4KYlDB8LYcyw3nAYeyaZY/VNvKMZEOlVg57TPVdqZFP4PY
 shH1ZBpxalSQWqCg72bb1Iv6bY6yFtAcVAimVjwZNPDXn2O+EgIWvjFkPofXRq+AhAWJ dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rc0h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:36:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDYqoJ149764;
 Wed, 22 Sep 2021 13:36:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by aserp3020.oracle.com with ESMTP id 3b7q5apbwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7mpt4bAMbc+Ar9laTXc+PklFsFNBPboBVg84crlEj4Qn0QBrme2CAeRrs8ItTDttkPKnfGGLyayDvCNKSZiXiyMcQ2d1820ypy2cnzTtMCXuDa2e+nf3teYQAHyID9qC+VEql9qddfTaGSMd9BOPPgG3lh2YlUNNvhw+cdBPq4gn9zWFZm3hRHU4dhJhxK0Mh47D+WbgyNZxX0O8IMXuLqvzZ4/heOftcenRwj9tOOc5RsmICefM1YWxQMtiLWV1Abhy1K+6hzvCUu+gWTD9KVLKSH5kGxxHHA5OtLD5Ta5z/u4nLRpCCXZBOWNARMCc7teEHV/ntiV94uZqTYCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ds4H7BMOFvznmu81it1b4oQ1ESUXWB3ra3SonMyZlU4=;
 b=UkK05DAHtcCLZAMr1rnWIu3ellS+QWtaVo689Q1gWevklkY+/9x393nfaLm9nIsH/6GHhAgDA0ZcMDCZONGAHiDouTzgTMLVLpi4eN4CP4opgp9nnllonkVG1l1wTHXTrbA195E23TitzVdCiZvF+kT6BBuDFJ9jZIncXZvPWTecW7GKC8GTNMTNPUQ5lhkALcUyWmGUZiQs13Sv7iw4G5Ni26iI5sovO8JNSbk9oec0GVPacSwZj3Pgvy3HNSf2USASrN4SGDN/Xq21YCaXLk8KaWCiYMto0UcsTSec0TCx+qdAchWLoOVhmmYWA1LAn+3PrHcaCIrFDf2ywdEChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds4H7BMOFvznmu81it1b4oQ1ESUXWB3ra3SonMyZlU4=;
 b=yczxqFHGMlgqVRayUqbFQ33Uw/h2Fns8NXLBfLQdLaC3CiMbPVTGT322S8/bmsdsSA3nUELAMxyeTCgCj6SYNL4+crbv111dKFmiZfutB9WqBo2hdmB7rJZa4EyDGTpdnlqU639VbGpv6l4w9bxI720VnUzQp5Ujv/AisaX8ZPA=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3087.namprd10.prod.outlook.com (2603:10b6:805:db::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:36:18 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:36:18 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/7] nvmet: make discovery NQN configurable
Thread-Topic: [PATCH 1/7] nvmet: make discovery NQN configurable
Thread-Index: AQHXr38db4jAl1U5RU+m22adj9LA9quwDqYA
Date: Wed, 22 Sep 2021 13:36:18 +0000
Message-ID: <9B79DB8B-3F01-41CB-829E-E9CBB4A2A306@oracle.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-2-hare@suse.de>
In-Reply-To: <20210922063525.143045-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76c37b40-4a0d-4127-9237-08d97dcdf559
x-ms-traffictypediagnostic: SN6PR10MB3087:
x-microsoft-antispam-prvs: <SN6PR10MB30877039D6B51717C65E7D48E6A29@SN6PR10MB3087.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4Cj/Yw1AH/7GCyNvEGpviygWJwO6b7BuW3iMU8aWM9U17Iv8nlhONcIqS+fZmrWuOqq3ODtvNCIY+tYHbRUP88+/IYqAn+Jpm1yJNmGy7nG0VNMZ+UQuz+pqEzswE3Gy4oFtObtCI9QBBypjtMFo7o82R4ACLPt4JjezFBjn13PNWpDgSn7cN1kar9SAfZcFWX/DBWGz+YXbxvZKl0RYQS3Q0bdd68CphzJRNxPIYkds7BBjJXKj71+myPDeRAMsMrhi1VRs63oOn0Jm0ZmhC0qkOMM5lKLOU3Grfd3E3L7y2XkyqEer0MEmk5O+MpfPReerGQZknsSTJgGwHS5zFUjzlMdP4UktvF7AQRyJ7rzGvge7MMTvn+e/E9fw1QvNPLTSl2pgsQa8UxnJDOkTPBLzOzo8pxijjxky8zP7vgn8qk5YtekWjUWonTZUR+XT+dTepUByC8eVKIGDr0Io6KrBJIM3RFh2zuAAYHWTD82TpdYPXKWyPSqJuYtPJODCu0VOXSrL2KyQXm+/4H6YnIzl33aWl5VKInGQEpQ4EmKJIlZS/GGIeHQuMq4TsdZmnxKx7LKum8hoScgpBX/Au5RiwPPW8fg06AHNYaRs8S/JSt/nvsuftDxMB2VVoaIkbsvqC3/nGlmZ5fc50FQtFQfPLH9SJC953holptDY91kosfHCg/WUeBf677hKOU6LHE2qpZOZhFV5dZAwyMhbKvrRnHM9/rR1fLkaS3pJfNXTjtAWUclygoPmnNpEXcFtZgmdQfdBJvVDY8oBoRGGcLHEoOAOwPvf0iFdyx0ykLmMnbMJiXtKnlUolRTjbCR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(76116006)(2616005)(33656002)(4326008)(53546011)(38070700005)(44832011)(54906003)(8936002)(316002)(6916009)(66556008)(8676002)(66476007)(66446008)(64756008)(71200400001)(66946007)(966005)(186003)(508600001)(6486002)(26005)(38100700002)(36756003)(122000001)(6512007)(2906002)(6506007)(5660300002)(86362001)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aSs1alJGMkFJamwwTjRYbi9Ud0owNDZmeDk4emNiTndNVkxBd0FhazNSc1lv?=
 =?utf-8?B?K09FYXFEbGRSSnBpRVBydkZJb0J2eGVGazRPOHJhSTUwQkRiNENGN2kvZFB5?=
 =?utf-8?B?NlczVVhYUmNSYkFrTklwZVVZNFhmQ3pya2dBSWljMmRPak8yZk9yQ0JKd3Ns?=
 =?utf-8?B?MUxXQXRvUlhSYlo5ZkdKc2M5WXhVUmxEWW1LVEVJYWJpOUJYNzIybzg1Q21G?=
 =?utf-8?B?Z2V3cW45dDRPTmVhL3BYaDBST0ZNSndyVkRmWUsvZWl6c3dOUnVmWEdvZXhM?=
 =?utf-8?B?WjMxNGRsSnRGY2piZUk4ZnlPc1dEcE9TeTNyb3dvcnA4SVU1VldvS01RYmd3?=
 =?utf-8?B?K3FFWjNzcWNDKzBUZGF1SWVZMTZ2K3I5Y2RQT21BY244bml4TFFZOVEzWXRi?=
 =?utf-8?B?UGxJUzQ5R0MwM015WnM3N0lyOWxmUGNqeHV0SVIzUENEM3RIQ3V0REdSWlow?=
 =?utf-8?B?UXpEd2JCR0tXM01QRjV4MlhjRDhYUWsyelZwbms2YWwySUwvcXpnVjlBOXdq?=
 =?utf-8?B?bXppcDFvcnh0STcyMXJyT1lubE9BUk5tcEVMeXJnSVQxYnhLMWR3ckdVOUhC?=
 =?utf-8?B?bWwxSkxkeXJrVzR5RlJvNmRvdU54TWpRdzFEWUVOeHJEeEh0NXlrUVR4MmNQ?=
 =?utf-8?B?MG9peXB4M3RYNVF0SmFUenhiNE1ZYVdGZzl3SEJkU3pDS1RNeFl0UG1wMG9l?=
 =?utf-8?B?MVBKOVJjRGg0UWFDSSt3VW45eHNlQUJKb2lISEtLeHIvNzc5UUhmZFBWcU9P?=
 =?utf-8?B?YTlPTmRESGZzU3YzOGZlNnVQdHBScmUrdEQwZXBBYStqSEx4SG5YYllsOEVs?=
 =?utf-8?B?V2xEQXluYjRXT1N6RnQ2UU1WcXR0SWtXQ2pIV1pYaVRYeHRZalFsQ3NYcC9i?=
 =?utf-8?B?R0JzdmtnVkRsb0duK3grWXVBY0pCd3JMa0JwNUFxT0dBOG1xYXZHZkZSdndO?=
 =?utf-8?B?QTFVa2x6TUhRZlJsVkR0SmMyWWJDSkorc3ozeVBnUWxTOHdRRzRCNE82NG1q?=
 =?utf-8?B?QUMzSXFEb0tpWllWbkU1L2RiT1QyWnBWQ3lDNDEyVnZjMnAxRHpzbEZzN0hD?=
 =?utf-8?B?b3JMaWJKOW5pa0FGekFLeHRxL0hLOFFOZ2dPcUM0QWxRSFREQ3FWc0haWG9s?=
 =?utf-8?B?anFSWm5FUmZzeFYrdkx6WjdaWnIzclM3ZjJvU1VUSXF1THk0OVB0a29MS0RD?=
 =?utf-8?B?dG5oMzBoZUY4eFI4czdkRlhCd1BITmhPaG9JdW9janIrMDlEeE1FYVpSbi92?=
 =?utf-8?B?dlZhMy9DYzV2NE9tTitiaDczc2hwa1dHOC9vMDUwMTBLbXZvZzZnL2t3Tncy?=
 =?utf-8?B?dVc1SUZuOFhVVXUwazhtMjVacExZVW9QWmRpQXAwdkw1a0cyWGNkSUROR2Nn?=
 =?utf-8?B?S01ISGpYM1ZlT08reWhhTHA4TDJFWGZ1UWVvT2VTeko4eWhsOXFIYVRJMW1X?=
 =?utf-8?B?VUtxSmRwRnU0aFBGQmZ3REtSLzVKY28rSzR3L2h6UEs3R2dnSmdnbTh1T0RY?=
 =?utf-8?B?Q3NRYzU1NklSNDE2bFYzM3NpR0NITTA3TXZHSGI4YVRmTzFFZGEvcGZqbkxu?=
 =?utf-8?B?Y1hXMFJSaWE5U0NabnMyK2V6L3N5MmpFcXpkRkxtVHJuMzZQcG8rekYxNE1k?=
 =?utf-8?B?QXBvYXArcTZQamo1YmNqZysxZUZRczZjYTNXcEY2Y3YxODlkRVJHSWhhOThI?=
 =?utf-8?B?eG5rME10YmkwU0JLLzFjUnk1UThsbHB0UW9ZaDhZMjNOVkthUUtFbXhFRW1m?=
 =?utf-8?B?dlZjMXJBWkVoNGhiNEJsQVhsMjNtWE1NMlNMdHVISW1iSkVIcU5DUGxWVC92?=
 =?utf-8?B?MlFMYTJnU3BRd2M0OGxhQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <DDD2BED558F1D04EAEF03DD89E7BE46A@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c37b40-4a0d-4127-9237-08d97dcdf559
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:36:18.6412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnQiVIHXwpFJFaf7YWWBuOvcWN60p6bya16stzxxtTbiz4gdgjpaydIiX5cWjQ2T9ewwejts6VQgZGZf93Cp0ZAnobX0iX5g43RN1Bk4KD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3087
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220097
X-Proofpoint-GUID: az5KL7dNsd_0Hv6O0657Ie5Yu-0eQenQ
X-Proofpoint-ORIG-GUID: az5KL7dNsd_0Hv6O0657Ie5Yu-0eQenQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063627_371398_BD87BE1C 
X-CRM114-Status: GOOD (  30.19  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQoNCj4gT24gU2VwIDIyLCAyMDIxLCBhdCAxOjM1IEFNLCBIYW5uZXMgUmVpbmVja2UgPGhhcmVA
c3VzZS5kZT4gd3JvdGU6DQo+IA0KPiBUUEFSODAxMyBhbGxvd3MgZm9yIHVuaXF1ZSBkaXNjb3Zl
cnkgTlFOcywgc28gbWFrZSB0aGUgZGlzY292ZXJ5DQo+IGNvbnRyb2xsZXIgTlFOIGNvbmZpZ3Vy
YWJsZSBieSBleHBvc2luZyBhIHN1YnN5cyBhdHRyaWJ1dGUNCj4gJ2Rpc2NvdmVyeV9ucW4nLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0t
LQ0KPiBkcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMgfCAzOSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+IGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jICAgICB8ICAz
ICsrLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMgYi9kcml2
ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCj4gaW5kZXggYmU1ZDgyNDIxZTNhLi40ODczNTY0
Mzg0YTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0KPiAr
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCj4gQEAgLTEyMzMsNiArMTIzMyw0
NCBAQCBzdGF0aWMgc3NpemVfdCBudm1ldF9zdWJzeXNfYXR0cl9tb2RlbF9zdG9yZShzdHJ1Y3Qg
Y29uZmlnX2l0ZW0gKml0ZW0sDQo+IH0NCj4gQ09ORklHRlNfQVRUUihudm1ldF9zdWJzeXNfLCBh
dHRyX21vZGVsKTsNCj4gDQo+ICtzdGF0aWMgc3NpemVfdCBudm1ldF9zdWJzeXNfYXR0cl9kaXNj
b3ZlcnlfbnFuX3Nob3coc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLA0KPiArCQkJY2hhciAqcGFn
ZSkNCj4gK3sNCj4gKwlyZXR1cm4gc25wcmludGYocGFnZSwgUEFHRV9TSVpFLCAiJXNcbiIsDQo+
ICsJCQludm1ldF9kaXNjX3N1YnN5cy0+c3Vic3lzbnFuKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IHNzaXplX3QgbnZtZXRfc3Vic3lzX2F0dHJfZGlzY292ZXJ5X25xbl9zdG9yZShzdHJ1Y3QgY29u
ZmlnX2l0ZW0gKml0ZW0sDQo+ICsJCQljb25zdCBjaGFyICpwYWdlLCBzaXplX3QgY291bnQpDQo+
ICt7DQo+ICsJc3RydWN0IG52bWV0X3N1YnN5cyAqc3Vic3lzID0gdG9fc3Vic3lzKGl0ZW0pOw0K
PiArCWNoYXIgKnN1YnN5c25xbjsNCj4gKwlpbnQgbGVuOw0KPiArDQo+ICsJbGVuID0gc3RyY3Nw
bihwYWdlLCAiXG4iKTsNCj4gKwlpZiAoIWxlbikNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsN
Cj4gKwlzdWJzeXNucW4gPSBrbWVtZHVwX251bChwYWdlLCBsZW4sIEdGUF9LRVJORUwpOw0KPiAr
CWlmICghc3Vic3lzbnFuKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCS8qDQo+ICsJ
ICogVGhlIGRpc2NvdmVyeSBOUU4gbXVzdCBiZSBkaWZmZXJlbnQgZnJvbSBzdWJzeXN0ZW0gTlFO
Lg0KPiArCSAqLw0KPiArCWlmICghc3RyY21wKHN1YnN5c25xbiwgc3Vic3lzLT5zdWJzeXNucW4p
KSB7DQo+ICsJCWtmcmVlKHN1YnN5c25xbik7DQo+ICsJCXJldHVybiAtRUJVU1k7DQo+ICsJfQ0K
PiArCWRvd25fd3JpdGUoJm52bWV0X2NvbmZpZ19zZW0pOw0KPiArCWtmcmVlKG52bWV0X2Rpc2Nf
c3Vic3lzLT5zdWJzeXNucW4pOw0KPiArCW52bWV0X2Rpc2Nfc3Vic3lzLT5zdWJzeXNucW4gPSBz
dWJzeXNucW47DQo+ICsJdXBfd3JpdGUoJm52bWV0X2NvbmZpZ19zZW0pOw0KPiArDQo+ICsJcmV0
dXJuIGNvdW50Ow0KPiArfQ0KPiArQ09ORklHRlNfQVRUUihudm1ldF9zdWJzeXNfLCBhdHRyX2Rp
c2NvdmVyeV9ucW4pOw0KPiArDQo+ICNpZmRlZiBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkNCj4g
c3RhdGljIHNzaXplX3QgbnZtZXRfc3Vic3lzX2F0dHJfcGlfZW5hYmxlX3Nob3coc3RydWN0IGNv
bmZpZ19pdGVtICppdGVtLA0KPiAJCQkJCQljaGFyICpwYWdlKQ0KPiBAQCAtMTI2Miw2ICsxMzAw
LDcgQEAgc3RhdGljIHN0cnVjdCBjb25maWdmc19hdHRyaWJ1dGUgKm52bWV0X3N1YnN5c19hdHRy
c1tdID0gew0KPiAJJm52bWV0X3N1YnN5c19hdHRyX2F0dHJfY250bGlkX21pbiwNCj4gCSZudm1l
dF9zdWJzeXNfYXR0cl9hdHRyX2NudGxpZF9tYXgsDQo+IAkmbnZtZXRfc3Vic3lzX2F0dHJfYXR0
cl9tb2RlbCwNCj4gKwkmbnZtZXRfc3Vic3lzX2F0dHJfYXR0cl9kaXNjb3ZlcnlfbnFuLA0KPiAj
aWZkZWYgQ09ORklHX0JMS19ERVZfSU5URUdSSVRZDQo+IAkmbnZtZXRfc3Vic3lzX2F0dHJfYXR0
cl9waV9lbmFibGUsDQo+ICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0KPiBpbmRleCBiODQyNWZhMzQz
MDAuLjg4ZWQ3NDZjNjc1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCj4gQEAgLTE0OTEsNyArMTQ5
MSw4IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZXRfc3Vic3lzICpudm1ldF9maW5kX2dldF9zdWJzeXMo
c3RydWN0IG52bWV0X3BvcnQgKnBvcnQsDQo+IAlpZiAoIXBvcnQpDQo+IAkJcmV0dXJuIE5VTEw7
DQo+IA0KPiAtCWlmICghc3RyY21wKE5WTUVfRElTQ19TVUJTWVNfTkFNRSwgc3Vic3lzbnFuKSkg
ew0KPiArCWlmICghc3RyY21wKE5WTUVfRElTQ19TVUJTWVNfTkFNRSwgc3Vic3lzbnFuKSB8fA0K
PiArCSAgICAhc3RyY21wKG52bWV0X2Rpc2Nfc3Vic3lzLT5zdWJzeXNucW4sIHN1YnN5c25xbikp
IHsNCj4gCQlpZiAoIWtyZWZfZ2V0X3VubGVzc196ZXJvKCZudm1ldF9kaXNjX3N1YnN5cy0+cmVm
KSkNCj4gCQkJcmV0dXJuIE5VTEw7DQo+IAkJcmV0dXJuIG52bWV0X2Rpc2Nfc3Vic3lzOw0KPiAt
LSANCj4gMi4yOS4yDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QNCj4gTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQ0KDQpBYWggLi4gLmRpZCBub3Qgc2VlIHRoaXMgdXBkYXRlZCB2
ZXJzaW9uIGluIG15IGluYm94IHdoaWxlIHJldmlld2luZyDigKYNCg0KUmV2aWV3ZWQtYnk6IEhp
bWFuc2h1IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4NCg0KLS0NCkhpbWFu
c2h1IE1hZGhhbmkJIE9yYWNsZSBMaW51eCBFbmdpbmVlcmluZw0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
