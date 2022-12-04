Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B8C4321E
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Dec 2022 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySOA1BW3Qz1OGm5tsC3c/x/r+iyD9e6tV/R9dVhau5U=; b=rlODGBJ9Slfji50aw8Ew+k/QdJ
	HN8xdVNyddpMs7SpL69r9qjZIU1d4TaznhpUq3vjHHy9KMOmKIpaa7CnA7dPpkOjdkkdCfSjlFF80
	HhaC3aSUs94pTxPnIsBmhRDwHXuZf9oKztbwQpRNo3MAOwfkeFLOyOvssIG+hTrMtRuj7U3I74H5+
	WhpfIn54bSShWwXvWq/glkZ+sQE+GJ8q6iDMvdBmrQoX1vfWzXxd/Mankd8TLkrHbiR/eM/3+gXDq
	6Izx+A0REMtdy/cB37Fuojsb1KCxliqdWRdjg062EplGUCh+bNWkrEVnieCdKuXng9gAKIpMbsEob
	QM+3ihzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1sqV-00A1f5-5R; Sun, 04 Dec 2022 17:32:07 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1smr-00A1Fu-ND
	for linux-nvme@lists.infradead.org; Sun, 04 Dec 2022 17:28:23 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4H8TIt013774;
	Sun, 4 Dec 2022 12:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ySOA1BW3Qz1OGm5tsC3c/x/r+iyD9e6tV/R9dVhau5U=;
 b=Ad51nw8HDrzYKTR+YTbRS98S9ENH10/dV7fnKVhrpwNN9ODG7w+PMTb2NBJAzcTS76O5
 9Foqedvz+s5RWcYdXxaV0Eb5eMcvDmNOGEqn6TS9NojDg9YR1QUiVv8txo8GHQMzFmeS
 GUqKAaCZ/k2pRqYXcb0VGgOzgDXit22AkKHXhfkQLA130HhUHOXymoO80RkVfFx6b9I6
 kqWks2BLwESbrCQ5IN8PRVGyyyuGq/h1yYvNyabewB4t8sVyduMW8nr+1qGfMo4JidhM
 upX8AKWhnqedPaRCuexH3q+OS9VNMlp/PsrBYZj9LHVZRPk5vLDDP9AtvpJB7qJkSO6M pg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3m82nq09p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Dec 2022 12:28:09 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4HLUme034864;
	Sun, 4 Dec 2022 12:28:08 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3m8mejqyun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Dec 2022 12:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU1k7+uoD9HH/TlmsXuiCcpJVXB+bNto69IBB0nE9SLk5PObRzDeBUkPftRrlzxqeUOmsi8yjXaBFmULayUSXHFnm8JsGq9rkwsjIHf97/JjphurqXgM8SAq5VBM2oJV/t/zJcJVrlzv7mKSkuhiM9M0PbEi4tMOIdTw0aGpSwqELBuuglh5YThEXIiLzL7iPuWjQoumYf3b5TV2mA9/yLxv6S+ZZCc7uZ91s/NkGKsgECxnAEZKZGqCqJPM4H2eg8B/8BS3arpk4BmGju2hZTv6blLJpM+5bkAPPdFE/SaoxnVeX6edM84v2hnARHY9hOiZ7Wei6k0EZiOxanimzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySOA1BW3Qz1OGm5tsC3c/x/r+iyD9e6tV/R9dVhau5U=;
 b=mXU7IbWTAFcWeVNPileWlNQSUVXLQr6PXMnozRJ65sqdfSKqtjiYJIVR7zNoCS4nVa6IE0UZY+H0fF+exzX+M8i0gYlq5VmVjukDLe/Ajej6RndZLfFD9KRxoYx3W9UPcMr7qO5pWTtE/MZ3wDqGZeriseiCnPWFprn3RolZ8KTqC2RDNyBP85eSeo41jMFCR/0BaVAOm1MEsB84x4JncA/vJgp5ZYGsQo3FA3KWBUktuxh17h/5Sds41ludGuQI3qK2YZSLePQR2FezrN1or7gMlza/MS8S9S3Te+aW8e3udE56vd9246UMcnX11loIh4vXXUNOez2o1k/snyPwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW3PR19MB4345.namprd19.prod.outlook.com (2603:10b6:303:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sun, 4 Dec
 2022 17:28:05 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 17:28:05 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index:  AQHY+oZ3D5fYZrPgTEKaaKTSawClOq5HuhEAgAGKjLCAAAFEAIAABSLQgAAsj4CAFIQ9EA==
Date: Sun, 4 Dec 2022 17:28:05 +0000
Message-ID:  <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
In-Reply-To: <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-12-04T17:28:02Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=47233735-10e5-40fa-9681-96624d32171c;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MW3PR19MB4345:EE_
x-ms-office365-filtering-correlation-id: a833be66-9a4d-400b-a883-08dad61ce73b
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4GDqsXFqMHtR6E4lLl91V7wJ1fXv8j9a1FqHn0Lzi+fvNuVvUXuJoyht4ucvL/vt2qOqTHxomriwv5qwpFbkyI8Ccnfu8yLTXxzXUhV1agSfjvZiSszZjkAnHd3T++HUz5y3TsXVA9omFRKjTaGO6mYRMhvrCWXaK9pIBVMWA4gr1zGaApi2SuyeOeqWGSt8Q2S4sAlAT30fdmsLUIQo0MiJhQGsNyxN2IXERMT/PEerVL+FLgdfr4VtirHTe3jUKuCqVJd3RL+stQ71DDLPplx1q27NwoBJUzw82wGWsD+pICMu+oIi/IkEaeaRdT2zDK8fwBS4G8c+CqZPaYgBrAg4JO+C/5gHHZat4NsJw3ImHchFrBBiEZpfrr+Q4y/pihGCpuHBfLEFktgQNw4rpOmwDcRnIgxwDsDhpRHOyMBHOXvotfpkaWBOpxdF6mUnSxLRUenfEP6pj1qo3lm3L0xMQYRHy9uMtjBqFFumE9i9gMA3cz7eNioh+DCsCcfsWyKOxYHg0F7S1DBytMiPC7k1AXWzQsgQnleJNYTGmsNlwjhaIoQQV9E9D/LBtV/Fk9AdkYR7XnMyhDQJ8+EWzg1lhI/r02FxrIdbZm6cbiEVA/2QQuV5wH1QU5Pf82AapZ+6xq2mbdnYWyKXSzPg7DFkq+NOsIMKgwyb5P+zEmw1pjgJr4Lmz5993fRn8JeeyNjhm9Gzgq1IAUg3w+XhoQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(38070700005)(55016003)(86362001)(33656002)(71200400001)(53546011)(6506007)(7696005)(478600001)(9686003)(26005)(107886003)(66476007)(5660300002)(4326008)(8676002)(52536014)(41300700001)(66556008)(8936002)(316002)(66446008)(110136005)(2906002)(54906003)(64756008)(786003)(76116006)(66946007)(82960400001)(122000001)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bDdSZUdZelVrWkR4MURSSnN3NXBYNi9WM3FWYUx3eWIzRjFydW5pYVh2S2h6?=
 =?utf-8?B?YlY3TFNsaVMwMXZBcXN0RXhLc3UxNUZ6cGNDOFFheHJlaG95R1hLQ3EwQnNa?=
 =?utf-8?B?bERsZWpvUWFtMjE2UitpUk5LNTVmZ2ZQNkJhUjhDRGUxV0g2Vk1lWFNVZDBx?=
 =?utf-8?B?VVF6VDlQY3J5SCtGME9sbUJ3elh3Y3M4dGRDbVJXK3QvMXJhZ2E1YU9uWTBo?=
 =?utf-8?B?dkVNREJLaGtYVVZRd1BOSENCeHV0UFdYVjB1SUtlZmpxelFlNC9KcUJWci94?=
 =?utf-8?B?TFlKa1cxT3hqQWp6aS9rTHdHcUdQSDRwbmZxc28yN1RwVitOd0tFaUNwV01w?=
 =?utf-8?B?OHlPS0l5RGZCMTVCa0s3R1BvV04xLzlpdkJubmpxZFVUTzNxbnQrV2dSZk93?=
 =?utf-8?B?TlAwczMrMFdOKzByU0Z6dGs5QVk2K0dBRXpoQkNHVmhVZ0s2c2lNZWE3ZHJM?=
 =?utf-8?B?TGpTMkZKT1ArMHpKWXVwbWc0cGVkaFYxQTJqUGc1VmR2NHlOVnNHMExDUGZN?=
 =?utf-8?B?a2xETGt0Y0V2akFXbVBobWxpQXFiTUROMFpmdHgwd3F3OTA4WmdFTDFFbjQw?=
 =?utf-8?B?em9MNzE1VnRBZnFsbHpFdURqMGx0bTQxTjYxS3c3NVNSVGdqaERsS3g4ODVS?=
 =?utf-8?B?TkJTYTJLOGYybFA3Q05ocnR5bWJQQ3dNRGtNSlIwRFNwa3lVL01jdUpnRHJK?=
 =?utf-8?B?aTdBZ2gyLzR6NzVXWWtYSWpjWlJDSi9lYS9aYXRRcTkwVGNaOFpscVlUZjhH?=
 =?utf-8?B?eHRxRXNpTVA2a3dnemVmb3RoRGNYZE9HeHA1M3I1ck9UMklwQVlWVENYbXJ6?=
 =?utf-8?B?a3YydXZCSExHRmtTK3pKdzNTRU0ySTB1UVAvRnBmWGEra2dNT21uZzBwK3RU?=
 =?utf-8?B?L3h3aVQ1Si94amFkdEMvZUN3ZjR3TVlSNFE4bWJNZWxBK2ZIWVR5UER1UXFB?=
 =?utf-8?B?YVFFRDRIbStLNDJUTVdJZ0F5a3JZZnNBWFBHNFVENGhhUUwrNHVSdDJ3bm9I?=
 =?utf-8?B?NlNGMzMxODR6SWVGODgwTjBoRUFFaCtjTWtWc2QzY2tES0oyenBTYXJGRXha?=
 =?utf-8?B?UEkycVhuYlhoSUwrcHRzeThucHd5RjZvK0x3Uk9JNkVXOG42TGtaS0pDWVhv?=
 =?utf-8?B?S0UrNENld05YbzIwZmNjeitFaDRTU0Z5UHp2SmRncCtLaDlCTHFtTlNnbkJh?=
 =?utf-8?B?d3ltQTl6M3lWM012cUdCSEtZeGhhbEIzTTBaNTdJUWVSK3VFdnBBWlpUV0RZ?=
 =?utf-8?B?U3JSbFZIUTZpblE4VnFOcjVCVE10LzE0d3l1UGFpb0JvZDdVeE53UHRFbWZK?=
 =?utf-8?B?RjFXMHlxZjJ5UVZMdGc4ODZXUENtbEM3SEpCYTBvR21mdU91cVVpdUZkdjgx?=
 =?utf-8?B?SmhaYVVtV1NGZ29xa1pUS093K0tWUW1zb1Y1U2xqOXRBZHRaVEY4bTJMNk5n?=
 =?utf-8?B?VEROcjNQOGpXSU9VVTVnZWFDRFBMNEl4bmhmdHB3OGpiUWR4YjA5UWdIQ0lW?=
 =?utf-8?B?S2poYzV2aFREYmtDTkRJcFpacWlXOHoxY2VzVVREOVJteFBsQjZYRDBKUjRv?=
 =?utf-8?B?TC94SEJ2RXBoVkgwZ3JLTXl6TUhzNkFPc3pEb1FrSXNZbWNlM3JCdU9rM3hE?=
 =?utf-8?B?Q0tuSUd0YXF5dlNwQ2pSYlFIQXVLUmFLc1dBcEFZRkE0UTJ6RmtPcnU1MWhy?=
 =?utf-8?B?bXlEUHRHUWNMcExpK1JiYUprMHFxUUZNZkhKTzlJS1VIZTRzcjQwNFppeUs2?=
 =?utf-8?B?ZVMwMkdyLzgrYzBKWDRrMnNaUC9DQUl0cS9kSWJWdGNuUXgwVXVDVEN2Visv?=
 =?utf-8?B?RDFySXRHV2NGazVqbWRrbWJWQ1BwS3ZVRHdBM0RFRDlLeWVvMEg2Z01YOUhL?=
 =?utf-8?B?UFRpKzRmU2h4bXQzekN6UitPUmxkUmVFaGM5OEpWNjF6dGlFajdjVXN0d295?=
 =?utf-8?B?UXRZSVBZUlBOSFR0MWViT0Fueld3QWVzaE90di9BcnZMWHdHOUo0QVdSZHdY?=
 =?utf-8?B?eTJ4ZGw3TU52VlRMNGpNbjlVQXRScFVoYTF1SlhNMGtPUDgreUFXaVp5cUdN?=
 =?utf-8?B?ZFIyclFkZUVjdGFnTDJUZWsva1FDdFBZY245a0lCd1U0U3hveUtRT3RrNVYv?=
 =?utf-8?Q?tiPSgo/UJ60303hUScVJ54OW1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a833be66-9a4d-400b-a883-08dad61ce73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 17:28:05.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtY07U2Nk/NOD+bvylNhWUQ7Fexp7NXMFQyq+UVszxmdparSo160hE0WnlsA+Xg55JyixpiVbvHD8/5PmKyT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-04_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212040159
X-Proofpoint-GUID: 7LJeFX0KgaRVRBMTj5OhnexJOwT9-QUi
X-Proofpoint-ORIG-GUID: 7LJeFX0KgaRVRBMTj5OhnexJOwT9-QUi
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212040159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221204_092821_911487_DD4120DF 
X-CRM114-Status: GOOD (  27.59  )
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

SGkgU2FnaSwgdGhhbmsgeW91IGZvciB5b3VyIGlucHV0cw0KDQpJdCBzZWVtcyB0byBtZSB0aGF0
IGxvZ2dpbmcgbnZtZSBjb21tYW5kIGlkIGlzIHN1ZmZpY2llbnQgYW5kIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gbG9nIGFsc28gdGFnIGFuZCBnZW5jdHIgc2VwYXJhdGVseQ0KVGhpcyBpcyBkdWUgdG8g
dGhlIGZhY3QgdGhhdCBjb21tYW5kIGlkIGlzIGNvbnN0cnVjdGVkIGFzIHN1Y2g6DQoNCnwgeHh4
eCB8IHh4eHh4eHh4eHh4eCB8DQogIGdlbiAgICByZXF1ZXN0IHRhZw0KDQpXaGF0IGRvIHlvdSB0
aGluaz8NCg0KUmVnYXJkaW5nIHRoZSBpbyB0aW1lb3V0IHZhbHVlLCBJIGdvdCB5b3VyIHBvaW50
Li4NCmxvZ2dpbmcgdGhlIGlvIHRpbWVvdXQgdGhyZXNob2xkICh3aGljaCBpcyB0aGUgZGVsdGEg
ZnJvbSBhbGxvY2F0aW9uIHRvIHN1Ym1pc3Npb24pIGlzIHN1ZmZpY2llbnQNCg0KcmVnYXJkaW5n
IG52bWUtdGNwIHRyYWNlIHBvaW50cyAtICBJIGRvbuKAmXQgYmVsaWV2ZSB0aGF0IHdvdWxkIGhl
bHAuDQpUaGlzIHRpbWVvdXQgbG9nIGlzIG9uIHRoZSBob3N0IHNpZGUsIGFuZCB3ZSBjYW4ndCBl
bnN1cmUgdGhhdCBhIGN1c3RvbWVyIHRoYXQgaXMgcnVubmluZyBudm1lIGhvc3Qgd2lsbCBlbmFi
bGUvdXNlIHRyYWNlIHBvaW50cw0KSW4gYWRkaXRpb24sIHRoZSB3aG9sZSBwb2ludCBvZiB0aGlz
IHNwZWNpZmljIGxvZyBpcyBmb3IgZGVidWcsIEkgZ3Vlc3MgLSByaWdodD8NCg0KSG93IGRvZXMg
dGhpcyBsb2cgbG9vaz8NCmtlcm5lbDogbnZtZSBudm1lMDogcXVldWUgNDogY250bGlkIDEgdHlw
ZSA0IGNpZCA0MTYzIG9wY29kZSAweDIgaW8gdGltZW91dCB0aHJlc2hvbGQgMzAwMDBtcw0KKElu
Y2x1ZGluZyB0aGUgY250bGlkLCBjaWQgKHdoaWNoIGluY2x1ZGVzIGdlbmN0cit0YWcpLCBvcGMs
IGFuZCB0aW1lb3V0IHRocmVzaG9sZCB2YWx1ZSBpbiBtcykNCg0KY29tcGFyaW5nIHRvIHRoZSBl
eGlzdGluZyBsb2c6DQprZXJuZWw6IG52bWUgbnZtZTA6IHF1ZXVlIDQ6IHRpbWVvdXQgcmVxdWVz
dCAweDQzIHR5cGUgNA0KDQpsZXQgbWUga25vdyBpZiB0aGF0IG1ha2Ugc2Vuc2UgYW5kIEkgd2ls
bCBzdWJtaXQgYW4gdXBkYXRlZCBwYXRjaC4NCg0KVGhhbmtzDQpBbWl0DQoNCkludGVybmFsIFVz
ZSAtIENvbmZpZGVudGlhbA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBNb25kYXksIDIxIE5vdmVtYmVy
IDIwMjIgMTY6MzQNClRvOiBFbmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT47IGxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZS10Y3A6
IGFkZCBhZGRpdGlvbmFsIGluZm8gZm9yIG52bWVfdGNwX3RpbWVvdXQgbG9nDQoNCg0KW0VYVEVS
TkFMIEVNQUlMXSANCg0KDQo+IEhpIFNhZ2kuDQo+IA0KPiBUaGUgcHJldmlvdXMgbXNnOg0KPiBu
dm1lIG52bWUwOiBxdWV1ZSAwOiB0aW1lb3V0IHJlcXVlc3QgMHgwIHR5cGUgNA0KPiANCj4gV2Ug
Zm91bmQgaXQgbW9yZSB1c2VmdWwgdG8gaGF2ZSBhbHNvOg0KPiBjbWQgb3BjIHRoYXQgd2FzIHRp
bWVkIG91dA0KDQpUaGF0IGlzIGZpbmUNCg0KPiBjb21tYW5kIGlkIHRoYXQgd2FzIHRpbWVkIG91
dA0KDQpUaGF0IGlzIHRoZSBsb3dlciAxMiBiaXRzIG9mIHRoZSB0YWcuDQpZb3UgY2FuIGludHJv
ZHVjZSBhIGdlbmVyaWMgaGVscGVyIHRvIGV4dHJhY3QgZ2VuY3RyK2NpZCBmcm9tIGEgdGFnLg0K
DQo+IFRoZSB0aW1lb3V0IHZhbHVlIGZvciB0aGlzIHNwZWNpZmljIGlvIC0gaW4gY2FzZSBvZiBh
IHRpbWVvdXQgLSBpdCANCj4gbWFrZSBzZW5zZSB0byBrbm93IHRoZSB0aW1lb3V0IHZhbHVlIGl0
c2VsZiBtb3JlIGluZm8gYWJvdXQgdGhlIGJsayBycSAtIHN1Y2ggYXM6DQo+IAlhLiB0aW1lIG9m
IGEgcmVxdWVzdCB0aGF0IHdhcyBhbGxvY2F0ZWQgZm9yIHRoZSBJTyB0aGF0IHdhcyB0aW1lZCBv
dXQNCj4gCWIuIHRpbWUgb2YgdGhlIHRpbWVkIG91dCBJTyB0aGF0IHdhcyBzdWJtaXR0ZWQgdG8g
dGhlIGRldmljZQ0KDQpJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCBhZGRlZCB2YWx1ZSB0aGF0IGlz
IHByb3ZpZGluZyB5b3UuDQpBbiBJTyB0aW1lb3V0IGlzIHVzdWFsbHkgKGlmIG5vdCB1bml2ZXJz
YWxseSkgPj4gdGhlIGRlbHRhIGZyb20gdGFnIGFsbG9jYXRpb24gdG8gc3VibWlzc2lvbi4NCg0K
VGhpcyBpcyBkZWJ1ZyBpbmZvcm1hdGlvbiwgYW5kIGluIG15IG1pbmQgdGhlIHByb3BlciBwbGFj
ZSBmb3IgdGhpcyB0eXBlIG9mIGRlYnVnIGlzIGJsa3RyYWNlLg0KDQo+IFRoZSBsb2cgaXMgYWxy
ZWFkeSBleGlzdHMsIHdoeSBub3QgcHJvdmlkZSBhZGRpdGlvbmFsIGluZm8gdGhhdCBjYW4gaGVs
cCB3aXRoIGlvIHRpbWVvdXRzIGRlYnVnPw0KDQpXZSBjYW4gc2F5IHRoYXQgYWJvdXQgYSBsb3Qg
b2YgdGhpbmdzLg0KDQpUaGVyZSBpcyBuZWdhdGl2ZSB2YWx1ZSBmcm9tIHNwYW0gaW5mb3JtYXRp
b24gaW4gdGhlIGxvZyB3aGljaCBpcyBkZWJ1ZyBpbiBuYXR1cmUgYW5kIGlzIHNlcGFyYXRlIGZy
b20gdGhlIG5vcm1hbCBlcnJvci93YXJuIGxvZyBpbmZvcm1hdGlvbi4NCg0KSWYgdGhpcyBpbmZv
cm1hdGlvbiBleGlzdGVkIGluIHRoZSBmb3JtIG9mIHRyYWNlIHBvaW50cyB3b3VsZCB0aGF0IHNv
bHZlIHlvdXIgcHJvYmxlbT8gS2VpdGggaGFkIGEgcGF0Y2ggZm9yIG52bWUtdGNwIHRyYWNlIHBv
aW50cywgd2hpY2ggY2FuIHByb3ZpZGUgdGhpcyB0eXBlIG9mIGluZm9ybWF0aW9uLg0K

