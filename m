Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D18C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YwlgA221YcNOA4tUrmjSe99nUol08j1Um+K67WyGaJA=; b=zsDXUYhbYNshOp9pOVNHU3AUr5
	yoVuHAVAsMyrEhVynP3rRUG/Xg+QneMuEK0hbZhRHZUSzRXKlQvtw0uo2mp41en6BtvY8+zMkP9gx
	sl/5O84KL+HAMp+WeELrDmZZor9IMefKmcRCkoVJ2Q3l6c/aUwjIRmGRXwNTIa9FprTpL/+ucYzww
	m6UQJEdLHPRYleFgJMrUpEckSZKdaOLyBCGkBL6tdAAjU6fFSr9h0U/uKxYSb6eBiB2TTsib8LwcU
	ql6yIVltpuLA+bfOyzt+IaFk5h6+VBxQJwmjQFcEcF4vgq06Z4p8PKUIJLzW/Xw4MlxXUwBmiO/V/
	bojASHug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovexr-00EHpF-Cv; Thu, 17 Nov 2022 13:29:59 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovevy-00EGgC-FF
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 13:28:05 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHC0PwG012567;
	Thu, 17 Nov 2022 08:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YwlgA221YcNOA4tUrmjSe99nUol08j1Um+K67WyGaJA=;
 b=Lt86c25svY8hJIjM4ma9Ol4G4dZHXqfNfe6QJlwbulQHtCnky4S2Amkm/bWGgth6CvDd
 wv924pG5tJi2l+XWfAcvatzjn5ZwkDHOMeLcWWIFOSt+P5cJ3NedehoNm07kdLgcunX6
 hQYoGL+bDdQ8KE8gOWOAv1zGAXDfDle0VEu+wWsoUWFOXCl9Dy3sdtXA+dcRpNPPQNNs
 O4LIB0BZq4TGKxcYz+imUlA7uiCQ8i/OTr3XP1JP4IjtxoD9eLF5BH3/88Xl9Z4D4yHy
 NNGs3gP2ArDp1X9ak+FagTLxm2ovpVe1emNxQkS9qVcNPm2mI+HGLLC4mzmltOLcck2o IQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3kwmk494xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Nov 2022 08:27:55 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHDD5xw004697;
	Thu, 17 Nov 2022 08:15:37 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3kwnn30225-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Nov 2022 08:15:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq6XMY9N8AjAfvOsh1ZqIgFmudHg0YfK/6a3z4ILqz55LWAEhUbHjsXe88bvW9JuXqOB29eoCdwH5mvL40aaPNSQdxS5DH1Sz6FUWi6IVVIYY3DU+mt2AnmjcqQ6YYvdxFkoJX0wb3lRiPLq2vV75ATLgb5HgDl6vAvscgc9w41rQB+XJyLmo11ajHOeP/XpfyLX7vYnDkO0ypS/WvpM+hpTU7iUxO5huPywMPWPuBOYyDNeJr6uoDFZVdZtLmROrCRcZuMUx5cAaE1C+qbiDtmPFF5MtB/FqURgsBqvoXss0km4znWe5+IutcHP5Sevt+4cYczpwaZG974Y8HEJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwlgA221YcNOA4tUrmjSe99nUol08j1Um+K67WyGaJA=;
 b=lIhbCC27T1FezAj/azUaMgAt6VUFpeEKamnxFAQSwbvNnetWE4pYthcqCtroImyRalVmr5t/np+nQgShuzgJSD+cmXTBY6xn+pIvZWdjNv4UySiDY7257XhN+PmolH7edJ84T3aRjt3CPmIjqDEs6o9TB39cHyc1kpCRJYJ9jc/Mn5KuQ9d4a6XmgqXvfxwWVkZkkK+bhidKnNvyDHTTIjXUzXn3SpAjHqgaJaZt+shG8VK9scHjMz7YbnD3bkCrO7EEu800PMgk6fUDsXkobOry98vCJFzt+uYmHS7uynS4PpE2cqn+dSIcfhn3PbAsjOvrnWvVhxz6qsCjKuydPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MN0PR19MB5755.namprd19.prod.outlook.com (2603:10b6:208:376::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Thu, 17 Nov
 2022 13:14:45 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::1a0a:e425:3b88:cf27]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::1a0a:e425:3b88:cf27%3]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 13:14:45 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHY+cN2iOHRmL50FkmB9pfnpoYJlK5B4WYAgAE0i9A=
Date: Thu, 17 Nov 2022 13:14:45 +0000
Message-ID:  <CO1PR19MB4885403621D5700E47E4CA7BEE069@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <048950d7-2824-28dd-cf8e-32ee16bd124e@nvidia.com>
In-Reply-To: <048950d7-2824-28dd-cf8e-32ee16bd124e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-11-17T13:01:44Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=c3a83676-3e12-426f-b998-707aea1bfcc4;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MN0PR19MB5755:EE_
x-ms-office365-filtering-correlation-id: 7d89f186-ac6f-43dd-29a6-08dac89db22b
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  mSKjXctCcKebh+lyWmwuq6YKCztOecQdVXn+7ah9m1H6jMFTNKR09g+8Ywvw10vynMhVwAYSjz8it7JGLWUeusyUrAhx28V22SRi5H8/dBoFPci+5v8qeaFduduj/pJTa/iP+YnSY06XTJuJbzH4QV8dNcgukTTXIuyKnd2Wv3L9/smFKwrNWji+s7s3s/HMvV4xM1G7XpFS8LN5v+VZ+te/P6rIj3z0c9uky0lk92FdkljQ2/Z8DwrTxQAoVxzgmdzSHUcGaSI3gBrxd1zQTME0p4UxqhEzo9Ir0VAGyFc3iTSrIG9GreNSDO9ZPi4HANZWsVjch7dFIcr1ocdHg0PHUVPwjB7XdTJ/UgFJkgu8ExgZH/d8KfW2cceM1wpzY5wuZ0qDxLIXuL2ZwmkVliVIi3N3pth0s9pa9cEUyj9hkXqq2jSsVWlqlzSqdSs1Myaq3xINAm11WHvMzh8dFqz3b+TchQE34p/jHGlFVnQJIu9KVsiKlTWPiWIf+heUZjwu13FBmiJey3K+l1DvBY7ul+mVEc+ehAkkxKJx2jtnw0r6wOGs9qdKpyT7X23bfolmMeuCMhMcGsAjOpHHrR/NDp8i5EMYa8S13WPslBqG1g/XbX9Q4Qm7u0mRe/hFMJdURoVkAlZUU+ru1S3Sng2x810VxnKLjQHjeOvc62/Pjj0+ayutIRVHI+0chdinAfvAJADeMW6RKG9F8OS75Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(2906002)(66446008)(8676002)(55016003)(66556008)(9686003)(66946007)(64756008)(33656002)(41300700001)(52536014)(66476007)(186003)(76116006)(86362001)(122000001)(38100700002)(8936002)(316002)(786003)(38070700005)(7696005)(83380400001)(6506007)(110136005)(82960400001)(71200400001)(478600001)(5660300002)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZUg3ZjNuMGgrcTN2Tjd0M0kvZzUvNUVVckp2SDR5RUl5dVVHUXl2K2JqNWtP?=
 =?utf-8?B?cHBKQkM1eDZCREIvM1Z0bDlsSjVkb1Z5TWNqS2wwQndQR0xsQ2twdHFMcFBY?=
 =?utf-8?B?T1JRODJDeXJIUy94bGFZREQwMEttQjROVTc4OGJ3SkNXRWt0SVJLMDh3alM2?=
 =?utf-8?B?V0pST3BiRmJOUTkwZ2dOWkVXRUFkeXRLSGF3d0o3NHU5OGkwaXVSUkc3OXZr?=
 =?utf-8?B?RytBYmhoMnc2clBYaWk3Rm1FMUhkTEhGdlFxQnBtdzZKS2oxOG1aalBMK3F0?=
 =?utf-8?B?K3hmU2xqdUlaZ1pLOFN3VEhHeDZsbE0xRFU5dU1xMXAzbjZncGhIZlpCelcw?=
 =?utf-8?B?K3JKWDBkbDgvS00vWExkTWxURHBsV1oyMnNUU2xydGY0bS9OZy9lbWFRdFBy?=
 =?utf-8?B?ajVhVG5jSi9ESUFNSEZkd3B0RUh6TE1LR3hQaE52MFFEcWxTRll1TWhDbk5N?=
 =?utf-8?B?OUtBdnBkdm5EN0VleFZtOVlTSFd5K0d4VFV2TnlMQWRwSk9uR3NtSjhqanht?=
 =?utf-8?B?aGNLUWg3blNWb2VVbUlIbEtxV1NDQk40T0ZTVlJPd04xbktkMEREUllNR24v?=
 =?utf-8?B?NEZWOE5FRFJxR1BvNE1UcUozRWZzNHorMTNuVEhzN0RhWDgzL2hOeTJ4UXNx?=
 =?utf-8?B?YS9DVTVkYzdDMG9ncVlNZ0xXQnlWeWtCU1VBcTYvOUV1bGYwUHRWWERwVkxY?=
 =?utf-8?B?MCttT1VXazVEUnRVOWR6M3ZZMUtFMzRWWjZYL2t6ZFNuMVdmZ3RqODA5U1VL?=
 =?utf-8?B?aXBRektQcEViMkgxUG5YMys0ODBiZno3elUrYm03eDBsdlB6Y2JQWUFjRkls?=
 =?utf-8?B?ZlllSXRqZXVmTENZcHZ4ZmVEcXMzMmx5SWZhSjRnT1lNMlRudlYrbyt1cEF4?=
 =?utf-8?B?a3FTaVd0cWZRYU5WeUtCS2pVY1RyUWJ5dE9HYWtENVhEVzBsaWNMblI0S0Zv?=
 =?utf-8?B?clZxZzUyUDI1K0dpRjVpY3hGbnFtbXA4bmRyY0Z0elBKaVBHaklNUGJoVW1U?=
 =?utf-8?B?eVB1UndIdzF0TWlOSHBCcjlRTjNYNkEvWkNjemRYOVlWMk5KQTBXanUwaE8z?=
 =?utf-8?B?UXkvNi9FOXpyVlhnT21BSzI0WjhSc2dhdkFVS0Rld0tXNEZTbURsejM0S3Q1?=
 =?utf-8?B?RHNKWjF3WDZoSVhGN2o4YUZSdjI2ZHBuMmFTdDB5TWhDZnN0dm15QS9xdjBt?=
 =?utf-8?B?ZTNkQmN0UzNLaEFONXBoanNyMEIrK2MrUlkvVExrUHByaklXS2RLaFpTZ3p4?=
 =?utf-8?B?RVZhYVdYd0dNUnlRY3FITlNsR0g4cDVnMlVSRGlpQkpzaUJibDZQZnpKYXdD?=
 =?utf-8?B?NUQvejc5TXllQ21uYVp3RUpXK25nQStBQm11anBkWDBZL2J1NS8wdXFlQkdZ?=
 =?utf-8?B?Kzk4SU5UNXFIUlhFaHU1d0kyV3V3bXdWLzRpd3NBNldwSlljenhRV1hpQjhW?=
 =?utf-8?B?NlR1M0xxdERHSmFxam9yS01FbFo5V0FxbmJnVGxWc0J4dlpjUkUxUDEydjhS?=
 =?utf-8?B?L0dlVGo5dHQ0ckl3Q2VlWlBnZGtNMG1pdmprbys0cWpaMGZXbVNmbGwzbEZG?=
 =?utf-8?B?RC8rOFA5ZnF4aDlMcHZnbEpRaWFsaEFrZjR5a1V1UnQxYk5QbXFkazZFSVRH?=
 =?utf-8?B?bHBuNFJPeVg3U0V5dlZiYVZuVHl6ODFUNHBseENHVTg4VnRybk5pbm1HdW5t?=
 =?utf-8?B?c3RPcXVpQlR5UWtXOGF4cUdrYnJKY0NsU0tzMVRGSHl0dVh6YkxsaDRKVkNT?=
 =?utf-8?B?bXlpQUhZZkZ1QWRSdXNhZmx1YkxIbmkrZjlQM0t0ZjhtWDB4TDdKZW51OGRz?=
 =?utf-8?B?VEN5aEIzSEhZNG1NazN2ZVlNSEx4bDRqNEl4aGowVGg3c3JOaHFvSVhYYUQ0?=
 =?utf-8?B?Unk3N2dBSW5hKzduY1dlaHRIc3h6Z3lUY2U0VmROaG9NUTBTU084dG85RTJD?=
 =?utf-8?B?Zk1yT3E4WHVlN0VRZ2h2WEIxeU80aTRHRURwNkgvVWhTaERpL2ZDelVtVUpR?=
 =?utf-8?B?UE1aQ3UxNzZqMzVXZGRicUx5WDhtQUNYL1YzV1M1TmVDTHZaQXBsY3Z2N3U5?=
 =?utf-8?B?MVljM2JrK2JYMS9kQWNEUWMxdnNDQ3p0T0M1Q0JCMW95QWJsbHIwNG9JN1Vk?=
 =?utf-8?Q?h9SKGpOvciaFoIyIoK8ZTCGxV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d89f186-ac6f-43dd-29a6-08dac89db22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 13:14:45.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvDp5nXTnVnFo1KRpqc7OK8HoqzA2ed5taKyv7dZdEtrqJUiFutoGZbrZ8Ub0tidBKnbxah9lfbMqP93EbLe6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211170101
X-Proofpoint-GUID: jRpl_GW9mkKLOIqx2Ek9wEh4sxVTphus
X-Proofpoint-ORIG-GUID: jRpl_GW9mkKLOIqx2Ek9wEh4sxVTphus
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_052802_627642_38135EA4 
X-CRM114-Status: GOOD (  21.01  )
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

T2sgLSBJIG1vZGlmaWVkIHRoZSBjb21taXQgbWVzc2FnZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+
IA0KU2VudDogV2VkbmVzZGF5LCAxNiBOb3ZlbWJlciAyMDIyIDIwOjM3DQpUbzogRW5nZWwsIEFt
aXQgPEFtaXQuRW5nZWxARGVsbC5jb20+OyBzYWdpQGdyaW1iZXJnLm1lOyBsaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRjcDogYWRkIGFkZGl0aW9u
YWwgaW5mbyBmb3IgbnZtZV90Y3BfdGltZW91dCBsb2cNCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0K
DQpPbiAxMS8xNi8yMiAwNTo1NywgYW1pdC5lbmdlbEBkZWxsLmNvbSB3cm90ZToNCj4gRnJvbTog
QW1pdCBFbmdlbCA8QW1pdC5FbmdlbEBkZWxsLmNvbT4NCj4gDQoNCndpdGhvdXQgdGhlIGNvbW1p
dCBsb2cgaXQgaXMgaGFyZCB0byB1bmRlcnN0YW5kIHdoYXkgYWRkaXRpb25hbCBpbmZvcm1hdGlv
biBpcyBuZWVkZWQgYWxzbyB5b3UgbmVlZCB0byBmaXggdGhlIHN1YmplY3QgbGluZS4uDQoNCj4g
U2lnbmVkLW9mZi1ieTogQW1pdCBFbmdlbCA8QW1pdC5FbmdlbEBkZWxsLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgfCA3ICsrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgaW5kZXggDQo+
IDFlZWQwZmMyNmIzYS4uNWFiYWZmNWQ2ZjZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiBAQCAtMjI3Nyw4
ICsyMjc3LDExIEBAIHN0YXRpYyBlbnVtIGJsa19laF90aW1lcl9yZXR1cm4gbnZtZV90Y3BfdGlt
ZW91dChzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ICAgCXN0cnVjdCBudm1lX3RjcF9jbWRfcGR1ICpw
ZHUgPSByZXEtPnBkdTsNCj4gICANCj4gICAJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLA0KPiAtCQki
cXVldWUgJWQ6IHRpbWVvdXQgcmVxdWVzdCAlI3ggdHlwZSAlZFxuIiwNCj4gLQkJbnZtZV90Y3Bf
cXVldWVfaWQocmVxLT5xdWV1ZSksIHJxLT50YWcsIHBkdS0+aGRyLnR5cGUpOw0KPiArCQkicXVl
dWUgJWQ6IGNudGxpZCAldSB0aW1lb3V0IHJlcXVlc3QgJSN4IHR5cGUgJWQgY2lkICV1IG9wY29k
ZSAlI3ggIg0KPiArCQkic3RhcnQgdGltZSAlbGx1bnMgaW8gc3RhcnQgdGltZSAlbGx1bnMgcmVx
dWVzdCB0aW1lb3V0ICV1bXNcbiIsDQo+ICsJCW52bWVfdGNwX3F1ZXVlX2lkKHJlcS0+cXVldWUp
LCBjdHJsLT5jbnRsaWQsIHJxLT50YWcsIHBkdS0+aGRyLnR5cGUsDQo+ICsJCXBkdS0+Y21kLmNv
bW1vbi5jb21tYW5kX2lkLCBwZHUtPmNtZC5jb21tb24ub3Bjb2RlLA0KPiArCQlrdGltZV9zdWJf
bnMoa3RpbWVfZ2V0KCksIHJxLT5zdGFydF90aW1lX25zKSwgDQo+ICtrdGltZV9zdWJfbnMoa3Rp
bWVfZ2V0KCksIHJxLT5pb19zdGFydF90aW1lX25zKSwgDQo+ICtqaWZmaWVzX3RvX21zZWNzKHJx
LT50aW1lb3V0KSk7DQo+ICAgDQo+ICAgCWlmIChjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfTElW
RSkgew0KPiAgIAkJLyoNCg0K

