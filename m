Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C047AC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tTWEbvYKrxIPYOqaRHmIKCAGqTiD3exGuRNCvMgU1nA=; b=LYPJae1EdLEThM/CV3g2CnFyae
	W/MN869yf04Wa91seofeUJQPXPbdVRmMTmvCtwUGtZsf3BuryUDEWvu6nApGkmWpuoK0x11FhX2s+
	hYgs7NOGK7BROKHGOntcthIXprEzWPbJBsf5KMlAwWWopsrPGcq4rmGgoSOJAtAWlhLQDUApfB1Nn
	D5JuAPkVBuedH3Z9o/kycDkqRGGYFK1eSvLUCr+EF2PQEUwW2eGsWPO3NyPHlvEXM28fmTdxxuc6+
	zkTIQP9EbEVSerNzTJpMtHzURCGBNarfJkUPaa9YhLgrEcDd6MMeihJitRq0mLQSfxuLgodxPJH1F
	oFKGELag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVmx-00EE3Z-1w;
	Wed, 15 Mar 2023 18:23:51 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVmu-00EE33-13
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 18:23:50 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FDraq8028336;
	Wed, 15 Mar 2023 14:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=tTWEbvYKrxIPYOqaRHmIKCAGqTiD3exGuRNCvMgU1nA=;
 b=lDwHRPtqAf/KRDb8nzFfaYmGr+dR3kigQjJaQl4qx9ZcyVdY358S5NC+sLhOfIHhtcsX
 ved3Ne4sAUbMHsz4pMiXTUfy6s88IL0BT7dmaUH+l+DnARhJGpQtf9gYf78vlGF1nVyI
 +T7yQyhpKk6FX+1dJg5ENRKeAeriXtbd1ZRfRMl248Jyb9gpANnoqaneqATDjbc0G+S2
 utTh5gGrFWZof9iTUSDp9Tv/Ve9N6p4BeqJI3tFocNCPaArgs9aXy7ZO+fkN+P0qThGL
 xmyAM6FFJv/TJQmBnBsQnk6vjkDypuupWsSRw+htoq9SnMsVpyoqf5a5t83BBhGGu5UP 2Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3pb2a26v2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Mar 2023 14:23:36 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FIFjR7004468;
	Wed, 15 Mar 2023 14:23:36 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3pbf6u5gcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Mar 2023 14:23:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+Q4UkPfGpXxDCgxbMb6z9+Esi9+fg5hWIs5zOZVGfztYzIMTMbse5WH+hdZJMIV4SMhzOFfe26FMP1idi4B//K1keH5y1lU2AMDC9oqz3wga++HA/x2dQhlMucpWDf0TkAj/a73cfbk7HJstID7E4SNMF1WEWjYRvFi5b09TvlMraXpR5MbXqWiC8sUMxdikc8ji90I4TIXqkzZw2TyJxJZPTlrP/5hnZ0q7dp7je7KMTujLt7W7Qtf09nDrTtnetUAJ/fgd3FlHGSsSwcna2dSp9b2b70Wh83JlCZVh72yQnMjXp4wEJ5J1hVt3ZY1+BNl+dMpERFO1ZcZFMSARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTWEbvYKrxIPYOqaRHmIKCAGqTiD3exGuRNCvMgU1nA=;
 b=A7q53L8myQtKf0KgHKG8H8ED2C5hL5f/T/+tY1rm600qfL4eyAF27uOWlpjh6I1b3kro+CVIqgbKdESlisALdOdwZw/7fns8ncLLKh0Ua5O7LFysbjFkaGPMcwyDfUieR1iapCEcaOMlHy93VrqO8JXJhPE/4O3ojP3kB7qP3V8fsprVLtf2I6KZoQU6SuEeilb8sIZhQpq757k2F4Aa4q5hKhQW+zwHHlxt9InrSlwuXd4wmn0mhBbp6nzLce/zEZEI3oNY5YNk5gwf96HJtbzOug5rkx1yO1C8MwoO1TXv2EdSaZUKdOreVvTbLejDk0GlXAWDbQQYUcn1UgfmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CH2PR19MB3813.namprd19.prod.outlook.com (2603:10b6:610:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Mar
 2023 18:23:33 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%6]) with mapi id 15.20.6086.024; Wed, 15 Mar 2023
 18:23:32 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Thread-Topic: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Thread-Index: AdlXZV3LgjsZJGHIQ4uZAsfmw1ybfwABGvWAAAA+U6A=
Date: Wed, 15 Mar 2023 18:23:32 +0000
Message-ID:  <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-03-15T18:23:46Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=d3ae2831-3c8c-4585-955f-52f545165dfe;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|CH2PR19MB3813:EE_
x-ms-office365-filtering-correlation-id: 26720c09-a175-4340-e102-08db25826215
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  mJgiWJHs9FBGDJ7JietJiyhkVH6irgfgKsqQvOryKTghVvU3rWoPRnsbSCJ8kbRQpwZ7snO/oMFA49110nG9lFPnk0RStImVVrUDp09G/H3iJmjBuvdrntbfkmWMYzrE1l6e22pSgRDf8VzfOJjYM/V12qIUfVkBl39YhHe0LpPjuLdN5nUC2FzH3FQgZHlsQSwrebVbz+O8q8SgN0/IIJ3CNYFrMTNw5cctlxjyHBQqiwYB24WCfViJXS6SYUxUCV3952ywMQ2bzApXPZ2M2sPzTjEgwWDMyoj3zih1/IB7YAaTQqzhi4CvpqRD/dDVVrGR8tat5ZKfenItx42JqgpOJqfzc0PGG82hIsN71KQpNaGYLAYGduXF5MECKP3PI9N6uQ7WUlHb4ay8p9TfjRVtBjd22lIOpyZUlIa9axXYg6f5tLbT8/4nRc7GfXIMHl2p0A66GwK+D/2b5W913R1CySkXuQnvNXjHG9Q9XGxAbfqqs4Cte6qtbTCZLENNsAiW5bU9O8K2o/A4n16gJQyb0ZZelfTI08If7LhRXNJBGB3bvPc5ci5+RAtFYeXqyJUH/Ap+kwwZD+LAJV2pPqsyf5ouOw1TgvGpdupGsJnYm7btic+FMJrExwYJFiyEbMjkDuvcrsesGCFL5U06IXz0dxSJtuiSzw8x+XkWw0a26JBHq44Tbioi2Z3go4vZI0+eJTc6LP9Ol2YEd9hCUw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(5660300002)(41300700001)(4326008)(66476007)(52536014)(122000001)(8936002)(38070700005)(33656002)(86362001)(2906002)(55016003)(82960400001)(6506007)(7696005)(478600001)(71200400001)(83380400001)(66946007)(66556008)(6916009)(66446008)(64756008)(786003)(38100700002)(26005)(76116006)(8676002)(316002)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?tjmcRyT9LElT/UK8dnVQYCxjFyrM8MLJQWzPTBujKaSs5su3Fk7x+5htJHkv?=
 =?us-ascii?Q?+aK88pH+ZPad1/l+9wpUbqQVlSYnlS/wsosUmRxqkxUdasGOmXoaG+t7Yocy?=
 =?us-ascii?Q?LYdREtOQK+vqip3oISE8lav+Dz9VO7tTTis9EC5HQFEroLd3trQ05mlgW0e+?=
 =?us-ascii?Q?Mgq/scxJRoIEIEnCDENgIFFKLl9aMR7IWdiwLHgMpG/Kdj0dISDqFWsL7p4V?=
 =?us-ascii?Q?e9YR3tprw1dIvA88EHtlcdDC1b1i6FLleBkbGUcvlJKEnEIbss12SuvXYR9T?=
 =?us-ascii?Q?pxNFolI79KNX/RYpwmvyJkq86tAc30xdY/2UTU14bAIm/JFGreNHt4wsmtcl?=
 =?us-ascii?Q?9mch3RUqBf8J6JTQtd0K5NdlUJI0qvWAbKeRRwpqIcNtmegg8Rlgk360SlLU?=
 =?us-ascii?Q?faVroee6oQUIZ9J4X8ixYpUSPiwaRg47vrN0gbxaWFo4y/E5ZDu/lNThkbvw?=
 =?us-ascii?Q?2tQNTrpAFdLNJK/J4e8Km1stkK6XhlNvWxTowP0lc+vywtOaHVFDeLUZnsVj?=
 =?us-ascii?Q?aa2Br1H+JGdWfBkN3zM0ocQlgXHzFxpep8SHqvlMezbmOhtenJg1vyedVW+B?=
 =?us-ascii?Q?DsPs9Pd7a+f3SRVplXmNZe6fFPo66xxIgkAfpICT/0G6GqKkyGgWF5uQrgJ3?=
 =?us-ascii?Q?0ZsThp6FIkOkDLdnNYRz81+8lVzbZpwi3ZySA0hWCv1V4s0wKm0XKkjj8vzG?=
 =?us-ascii?Q?NDklhwYmJTimQReA9Gh+D1ufh6s1FUU8mmKR7hkOzn/nas3tKD7qQiASSdob?=
 =?us-ascii?Q?us0yIXKuThUFkEKnX4iqeMVDSImCCctgV5vAbFhR4mUAUwnHnlc1gXLFR7ib?=
 =?us-ascii?Q?nMB14MPUYaeBOwoz+nEmfrdOtXjPDN3N/y3w+re65Jwz+ZhFLsqPCiof7CeN?=
 =?us-ascii?Q?7YWfw/H0omU0BeJHTXPnBxytjWkg68ItZvQhsJpmy7xR11eIqsGUxKohgoEX?=
 =?us-ascii?Q?0uIoJTZB9+XLdpO4ZHZp/dNrPAOh+jBil3mF2Lz2k2yP4hkQ/NjVzP+dsjp+?=
 =?us-ascii?Q?GKZXxS+OrYWOEckBqYZKK7LMBPVbsK7Sil3ipxD0AviZipB+MNK2mZX0f61Q?=
 =?us-ascii?Q?/r6yz3O4bSJNLtlWxKrP2OYoMBII8bBrFnG4bbZ7fzOE9HHOPyiK3pOzeit+?=
 =?us-ascii?Q?8Ug0ptXnokN5SHcoADzoFsHsqHOkji7xBEF/AKHLxmnesD7AQTRXzGoR5STG?=
 =?us-ascii?Q?o8iPl5vQh/5hSVJ4mCK/1tx65n7Y3hhOse6JD3nq1P8qib7miqqIpZQtqHoB?=
 =?us-ascii?Q?qnghjoo8+cEGO4oMRJ40iD4X/zq4DRa/BC/dFXXKUgCYkNf5n1PO7o6djVqM?=
 =?us-ascii?Q?yE5UL1lDWfKp/nVqg3fDo71tOPxCIwsGQADzFuwC2FJz5gUcQ4TyBgjXg/8b?=
 =?us-ascii?Q?YH89fJarQpCKTa6sOh+Ikq+kOHbeWL3APB9Q/tcWB8v+3NoukkODN0uVKxyF?=
 =?us-ascii?Q?9qMYQQ+tccfP1EgN2jgStqxs87mN5TJT53EMVN945joJlRBP1YdYzQRw+M7Y?=
 =?us-ascii?Q?0sAo/7TPYwtTi1ZlKBsmGgXRpcI9yA+Nt9+lTfn8ynNFtVTliR68yIXqOqAB?=
 =?us-ascii?Q?ZqSHeCfOD44S678xDGKJZF/lbiVacvrVWyn7LwvH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26720c09-a175-4340-e102-08db25826215
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 18:23:32.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbPKyb68CCkCMogHKDf/7Q21sCI4whdS7R7m2Uax9R3rWO8HleAlT5QifnenfxDSolio8LIqEfNk854vQSHQVKlQjWkWGHPOT93Z8gOGLtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=901 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150153
X-Proofpoint-GUID: XH9NnlfChjVYQyT7_qkzXlRBhXntbjY7
X-Proofpoint-ORIG-GUID: XH9NnlfChjVYQyT7_qkzXlRBhXntbjY7
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=970 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150153 domainage_hfrom=7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_112348_505742_8829B1D9 
X-CRM114-Status: GOOD (  26.22  )
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

>=20
> On Wed, Mar 15, 2023 at 05:48:14PM +0000, Belanger, Martin wrote:
> > I'm running tests where I connect/disconnect to/from a few I/O controll=
ers
> using the nvme_tcp driver. I use nvmet_tcp with a null_blk device to simu=
late the
> target. The kernel module crashes (trace below) while trying to connect o=
ver
> TCP. This happens on Fedora 37 and Ubuntu 22.04. I also recompiled the ke=
rnel
> using the latest nvme-6.4 branch and I'm still seeing the crash.
> >
> > I'm not sure how to debug this further. Any suggestions?
>=20
> Never seen anyone try to use poll queues with nvme tcp before. It doesn't=
 look
> like that would work for a connect command since there's no bdev at this =
point,
> and polling needs a bdev.

Thanks for pointing me in the right direction.
I wrote a test program that exercises all the different options available.
The crash went away once I removed "nr-poll-queues=3D4".=20
But this begs the question: should a user-space program be given the abilit=
y
to crash the kernel by simply providing the wrong (or weird) arguments?

Thanks,
Martin=20

>=20
> > Mar 15 13:30:22.954399 fedora37 kernel: nvme nvme1: failed to connect
> > socket: -110 Mar 16 13:30:22.958393 fedora37 kernel: nvmet: creating nv=
m
> controller 2 for subsystem nqn.1988-
> 11.com.dell:PowerSANxxx:01:20210225100113-
> 454f73093ceb4847a7bdfc6e34ae8e28 for NQN nqn.2014-
> 08.org.nvmexpress:uuid:f9ef75fc-1699-418f-ba45-49f9fc766e1b.
> > Mar 15 13:30:22.958453 fedora37 kernel: nvme nvme1: creating 12 I/O
> queues.
> > Mar 15 13:30:22.960320 fedora37 kernel: nvme nvme1: mapped 4/4/4
> default/read/poll queues.
> > Mar 15 13:30:22.960862 fedora37 kernel: BUG: kernel NULL pointer
> > dereference, address: 0000000000000034 Mar 15 13:30:22.960998 fedora37
> > kernel: #PF: supervisor read access in kernel mode Mar 15
> > 13:30:22.992915 fedora37 kernel: #PF: error_code(0x0000) - not-present
> > page Mar 15 13:30:22.994551 fedora37 kernel: PGD 0 P4D 0 Mar 15
> > 13:30:22.996135 fedora37 kernel: Oops: 0000 [#1] PREEMPT SMP PTI Mar
> > 15 13:30:22.996169 fedora37 kernel: CPU: 0 PID: 3953 Comm: pool Not
> > tainted 6.3.0-rc1-stas+ #1 Mar 15 13:30:22.996192 fedora37 kernel:
> > Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox
> > 12/01/2006 Mar 15 13:30:22.996210 fedora37 kernel: RIP:
> > 0010:bio_poll+0xd/0x150 Mar 15 13:30:22.996227 fedora37 kernel: Code:
> > 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90
> > 90 90 90 90 90 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 <8b> 6f 34 48
> > 8b 47 08 48 85 c0 0f 84 a1 00 00 00 4c 8b a8 60 03 00 Mar 15
> > 13:30:22.996245 fedora37 kernel: RSP: 0018:ffffa561851bfae0 EFLAGS:
> > 00010246 Mar 15 13:30:22.996266 fedora37 kernel: RAX: 0000000000000000
> > RBX: ffff8ff38ae60000 RCX: 0000000000000000 Mar 15 13:30:22.996311
> > fedora37 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 0000000000000000 Mar 15 13:30:22.996369 fedora37 kernel: RBP:
> ffffa561851bfb10 R08: 0000000000000001 R09: ffff8ff38cc0e860 Mar 15
> 13:30:22.996410 fedora37 kernel: R10: ffff8ff3887af388 R11:
> 0000000000000110 R12: 0000000000000001 Mar 15 13:30:22.996430 fedora37
> kernel: R13: ffff8ff38fbd9c00 R14: 0000000000000400 R15: ffffa561851bfba8
> Mar 15 13:30:22.996450 fedora37 kernel: FS:  00007f9aab2ff6c0(0000)
> GS:ffff8ff84b400000(0000) knlGS:0000000000000000 Mar 15 13:30:22.996467
> fedora37 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Mar 15
> 13:30:22.996484 fedora37 kernel: CR2: 0000000000000034 CR3:
> 000000011439e002 CR4: 00000000000706f0 Mar 15 13:30:22.996501 fedora37
> kernel: Call Trace:
> > Mar 16 13:30:22.996518 fedora37 kernel:  <TASK> Mar 15 13:30:22.996535
> > fedora37 kernel:  blk_execute_rq+0xc9/0x190 Mar 15 13:30:22.996552
> > fedora37 kernel:  __nvme_submit_sync_cmd+0xa5/0x160 [nvme_core] Mar 15
> > 13:30:22.996572 fedora37 kernel:  nvmf_connect_io_queue+0x10b/0x200
> > [nvme_fabrics] Mar 15 13:30:22.996589 fedora37 kernel:
> > nvme_tcp_start_queue+0x1a/0x90 [nvme_tcp] Mar 15 13:30:22.996606
> > fedora37 kernel:  nvme_tcp_setup_ctrl+0x410/0x7e0 [nvme_tcp] Mar 15
> > 13:30:22.996626 fedora37 kernel:  nvme_tcp_create_ctrl+0x34f/0x460
> > [nvme_tcp] Mar 15 13:30:22.996643 fedora37 kernel:
> > nvmf_dev_write+0x5da/0xec0 [nvme_fabrics]

Internal Use - Confidential

