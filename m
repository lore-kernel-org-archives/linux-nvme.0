Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F20C79F82
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=u5vyVWBOdTo3sNFWNXNYTIq+kniImr1ZJCf+6UNi/8c=; b=h7/sIc7wnNrel2
	eS97iHGN0F97h4yjEKrDZH1qft0oEPto26fYc4Bo+zr0+/2VAuuhJDvsTqa/zLmk/+qmGuzR+I911
	goFe6sZrVbw5r5VFeQ5M4iBF+9tWiZ2NMcfTOMRYjY458RR8hBhGiRZHVLb6WFkCJ13Hn6dTfEsRs
	TJ9qRBYsmVylJs1Mq7hSAOjmzsDKK+FGLyr1CwvOF1WAmkGnbnBrmtHly27bbPwjG5nYsr5WZt12x
	uwk5+m1yryRLJm9vfhVo+ASx68eGgh0hop4/NbAJCMCbIuuQGylyJIzm/Uh00f8atvq4sLGCm4UMV
	e1QIghMiOsKK8pbJ53gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3swL-00000008khB-3r34;
	Tue, 08 Sep 2026 10:20:33 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3swH-00000008kf8-2Fq0
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 10:20:31 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688ACNvL3339040
	for <linux-nvme@lists.infradead.org>; Tue, 8 Sep 2026 06:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=u5vyVWBOdTo3sNFWNXNYTIq
	+kniImr1ZJCf+6UNi/8c=; b=EKg0DYk5BLg9+QQqWlD0pKX4hsgyhnFoHS7jABZ
	M4Ttt4fzMyAQYJVJMqchmZJIl5xIeDGo1SaQjFPNhZkF+GmlHopAtQJGsHsMIc4P
	6Zz4QTNyyXOtY/QDg3GS/9IHsFa0KmZOjpMzXJZFZl2oW+SoGMwMJ55d5DTryX3s
	CiZQt2wdX/aD2U9OtW6oTZxipLLNgxevQ1AmQEsRFUxYFPaaKkJI9EphAZY1FI7e
	f068+94vBejVqfAtjC09PPz6WQe3jQhXrcs9v5ttX+DDPJr//MGRvZ9qjiDy5Tie
	uFkq90wDpTbMP66lPZnrM2vonYnc3acQP8+Vjn77QnDcGMw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gge4w8nbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 06:20:28 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688AE3F93453696
	for <linux-nvme@lists.infradead.org>; Tue, 8 Sep 2026 06:20:28 -0400
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gjg6008yq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 06:20:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p46iTHuPFDWxBiD7fDkzScMQKSesMgjuq0EDl4b7hn4gE1ShXb5ft3pb7gw5nlciEn4wZt7yUia/Je6gKqS1eJ6ATRbiq39z0FVp9ejMKzSUnSq07KFdZ4vJS4d52fJeJxjQzhb+J9W3SPCy//LZikeBgQ1QimV0GuM+jqab9/8CMAR/7sph+FWJ44qV/6ZwVEAAUxcNLyvBpVHMk8jyyFQM3ojKuhA78VmlENigzomX1bm/IwClHValFKEJs5hxtyKQVz4ttkCMSNEe2jcW2p6+dJg2LDUBVI9oryxJp6BOV+LPtEAoZ2t5hmXKce3Xq8pvcx4eybuuxcRB1WNBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5vyVWBOdTo3sNFWNXNYTIq+kniImr1ZJCf+6UNi/8c=;
 b=MRMLo73pE1w6bBkHMou1zmORXwozv+SA9TwxUm3Ozmd58Ahy7OWSbxNY8YLQCmfSflNUgU31oYIeWfdb3MfWf6dpCeq2B/KfqMsXq8dDQaMu3mNa+UbZ7LTlh054nTkVfb3YJCbcjeRqbMv3bu0mppM2xuS/+DJ9/Gb5d3WMtBKcXvZ9yVeYBAeWG+ib6AbAFwIPQz3pr7W7dRvEV6PqWa0hw4iKQRdHXKLZ9ahe71lDMYc1dDaRc5ZYiG5WUyDI76OhnzjV5KLHD+uGjGUMaKctoah3M6y8jkdYxRxgextwamcy18axgrKtIt7+oPdVX8ttdUzDy3+5BmYxy2cexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CY8PR19MB7275.namprd19.prod.outlook.com (2603:10b6:930:9b::21)
 by CH3PR19MB8238.namprd19.prod.outlook.com (2603:10b6:610:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 10:20:23 +0000
Received: from CY8PR19MB7275.namprd19.prod.outlook.com
 ([fe80::9ecd:fb63:a961:bd47]) by CY8PR19MB7275.namprd19.prod.outlook.com
 ([fe80::9ecd:fb63:a961:bd47%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:20:23 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvme-stas 3.0
Thread-Topic: [ANNOUNCE] nvme-stas 3.0
Thread-Index: Ad0/eTsf/Oiw6NXuTwWsbZj6RdM2Jg==
Date: Tue, 8 Sep 2026 10:20:23 +0000
Message-ID: <CY8PR19MB72756F58E61F1736BC52580083B12@CY8PR19MB7275.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=3bbeecfd-f725-487d-94b1-b373c31068d5;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2026-09-08T10:04:14Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR19MB7275:EE_|CH3PR19MB8238:EE_
x-ms-office365-filtering-correlation-id: c954820a-a6f1-46d8-c679-08df0d92cb08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|786006|376014|38070700021|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|3023799007;
x-microsoft-antispam-message-info: ZL7VTHgswgiKRLnuIawld19Sda5CxP9+wSVnuereYCYzOnuN0tzVgE+FHxcZ5GbAMB+tZFZQ46Nq1ByvuqJnIzIWgEY6GJEUmMmluO0vlJjNKU9H6BhYB2mPBGdq1fe6OZupyTRJKtVlqwzwTZKwNzCF4heBiNpXbz8sDsJLZY7seW7bOxxu3htSyFniDhQueEPrpAxlpOZXJWxNd0vvz2shiA4TDQjHPJTIQ4yrplXHbc3RwHDrW/4zYLYXvJLPXdeHx5eGj5gqpdwff0pNAOYo33b8hh/qOYxIQM5IhztoVloDEleu4fcxA8Io4ZfX7tH+JW9ZaXwaCCMa9gg3uBR87F/43auIi5f7jA04giKGwABYzsFrjw7vGKtpjZWdu8KQjDGgHinBBg05A00DUnRIvca1II0EmtqLXxPzrKVG6nwC2rsadPnNrxnLz52Qpp9Nxc+Ch3gJkFMcF3kzOTf4scrqUA1YWWNsHN+V/IzPYofporyx5PjnGmE9VGgmWAm+VKw4xurOTO7n6Eebx0eX/PEKHwzs3Ip7Z0bM1QURN1L9VhXY3g/V7ruHhZnGcSIMks0rBKDn38r3PeePZqlK6M05XU1CrqZzZNjejcjALU65vd+wgM2tCiwx2dFVXMvBkwaSuTHcIptdeaoYWozRu5N6JAF2YX061ykMBB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR19MB7275.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(786006)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KZR9KoBZg1xyyrGyDzmqhR1R6FusJoHyVEMUvcsljXoUQvZT9mAmz0dG5bVX?=
 =?us-ascii?Q?MMiC8ZJkX4NcXz2XdC5cNHJvbLyud40LYP8rvPIooOtoyjeyFpLTzbNirrLJ?=
 =?us-ascii?Q?W1vI5NNAb1g3dl8ISftWagU485lDavrMd/aCGxgdBzj8iGwvXorfZ/pJi0UC?=
 =?us-ascii?Q?VKAYrc67gdFAeKRMnI3EC0N5djARtxsrwc98WtCTZns45s1DCZejf6Rs/s6G?=
 =?us-ascii?Q?3KMKttkjbl3qp+DBeQju80cGqATev+Jf1eQIX7yhTPgqBlP8J5IEE3D2x3gz?=
 =?us-ascii?Q?A9yBz7E9p9YrWupIfdEGLjCvJEglYaAappponRIzJVIJDj4VLPN6zQQHZ5QF?=
 =?us-ascii?Q?dAQ4+IUSkKdJM6NKSw6QqW+2HFjP/1uBietXMWl42J2runmvnL5gp8Epp5/o?=
 =?us-ascii?Q?VSNYFYURyax6A9amNAV+8otsnt0n0h+VKAPR+pfkKwdbr8tcoTrSHzDsNUb9?=
 =?us-ascii?Q?L8XrMp1rCYiufXgSq9TIBm/pgUpISktlPNp0xdJgxN4jWrluB469GM7Ekto1?=
 =?us-ascii?Q?P8kWWMxC4EvdHASyqksiE4RiDUs3APuE/21weZdqAzpA5QmNPIUW+7I/lRyj?=
 =?us-ascii?Q?1jICnVLjD4TCn51JYs387D0bFesWwO88XGlGPuj8FkCNMxYtxty0jJoPVMYA?=
 =?us-ascii?Q?6qpcPVK1wXHWCqccfiPqIIeLnqq4tqCKl9IWwRNTVgMMSfHiBmnU2YpLum2l?=
 =?us-ascii?Q?YQD3St7agVKLOlxQ6TN5227by4pqq0UQjC8gdrD/tJg77/3ykOEjqQn0iMe8?=
 =?us-ascii?Q?dquMEBrBwUzikcc/pmJBgWFI/jeeyKYFjiAciZ6rU46dzPrY+NM2f5oTsxM1?=
 =?us-ascii?Q?t4RH0Ab7Fh6v3r9MLRy+Fn3+iiF09HYaLlu63xpZwfjmFXvz90DYv9PH9QF3?=
 =?us-ascii?Q?ZIFU3sfRS/+YS4WfvPeHYYub1VXr6hYXhEzIB3+RtArHJnT1HG40IXzoiwJ2?=
 =?us-ascii?Q?aS2f13LHU2XGOGZgx5TRQtbSqgafa9hBexv8B2+4VWPlUBc0PQi7LO0EPHJo?=
 =?us-ascii?Q?GsBBmluhzvsuAEQJ2q7kqvm/+WN5Qo/EHT4j5guSm+HRIbRX1SuRxHtWGCbt?=
 =?us-ascii?Q?4vFpG2TgjT+1CcYUugEBVzdJDHEsNNojYLcpK47OFMNqhgs7jAR74N+hqBxM?=
 =?us-ascii?Q?w4ib3nFMrSIIj2QTdU2uyR7wznONSIZHyWzVSz5cu+3hLjcYOca51r3rRNmY?=
 =?us-ascii?Q?7rlZnQi2R367BqstZM2LB3N+eZLjonUToAEE0wOA14ukGZ2bAs0n2wq9Kmuk?=
 =?us-ascii?Q?le/rX0y5enIWOTUOHto11tAYIbItvbitVgJCQubCShMIX4bh5aD0ioyOTpDS?=
 =?us-ascii?Q?TjzoFJnp/rsscxvWq6qSE7pBguMeAREvSbFBTX4J9jdApyJcCsaM6gQMdeT2?=
 =?us-ascii?Q?Lr4IVW3fV6ZLytxHuPB3duO8GqZ2umy2b+1e57IvyNXSmq70S9Uva9Utun60?=
 =?us-ascii?Q?zjB0iqyGSID9V/XnBtOdFou9vvi+exuClU5JidaJ8nsTEZt0/ErLh+myLn7E?=
 =?us-ascii?Q?+/G1L7Tkhxs1lWB5pAcym69U/IiB/qOnDiN4Up4dblRixCbGAzIHCRZKvrjS?=
 =?us-ascii?Q?CjOimW/Y8PDnU5j5Bo0j7SIWtfmsGx5Nq5ovItS2y3V0mIY88DE7FUuFWXyW?=
 =?us-ascii?Q?lnAsxL3+sFVk8zRqHgskcM5IB0e73Y1Ixuhxh+CI5zbgsZZ0Ou03ksKudOdC?=
 =?us-ascii?Q?vUUGOkZQNgWUAtPFWPB9o56UoPnzzFuGs67KsLoIBR1dXK3lDABwSY6vxwrx?=
 =?us-ascii?Q?raUWSzkghA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WbichVn4opE61lAllpuODET23WT6+drf/9EWIkM38Y3zm+gxJSs5nVQqCDLddyKkUboJZQw6pop3+jP+rOYlne1ShUfWkFQ3nWO9sjBu+ugaZsppybtM1MBxhaHYgsQFKjwdqFp4ZpnTJPU+GG4kdmwNNvGBJv8GLrYjTYrvJvpAxcWfT0xopDuL9OmdpFlTlFFdgSs0Gn6uUNOG1LTk7d5XeYjaYE4EXKsJIIy8yIuosw3EMenLeNaSowYgEeeAY9nTloxWCs20pIRwNfNWjDFT311Ew9+AMhwC6eMFDN4In6omrSoLrUuxCvGXOJh+PF5wVDzDAFsO1ZdOldksig==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7275.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c954820a-a6f1-46d8-c679-08df0d92cb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 10:20:23.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbLAPfTW7ZQwzO9nhn89jp3koL9+GFb4MDnhOJZFHDo3wT9xoOgyQNN98nfaHbmbwdl9GDy4mnK+7l1t5oOpsu6tzIjQ4Ds3w5gKIsjYkrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080108
X-Authority-Analysis: v=2.4 cv=aLPAb79m c=1 sm=1 tr=0 ts=6a9fe16c cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=sEWawkeXllE7TocFc0N_:22 a=f1nivrkjAAAA:20 a=pUhYLadETE1gzg60Hb4A:9
 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Vnf99IiUWHKmezQcsaqhzz-6K3Nz-YIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwOSBTYWx0ZWRfX1a/edHDSbxC/
 OTnwLpxlbFOh5+HKLq2V57xuJI0QZ2lsVrxFgZ8tqaSY0Mb20yHgkyaHwKDoOUYkU3qMxPAyree
 bH7JuZAuza3jo7STIbv41uVYlZSVoOuHook4QXGuEyLxm4s+hDtvKMbGTu9oO3z40xsYzh8OVk6
 ldhk3A2ufpdYDigWY/rLEc6YAvVy/A4HeuQdt82oa+6b52rIr0XcuWQ9OTtvN8YpwS7qPUJv1uo
 B44SK/MiIkFejWwfqYjdZW33dtdzFCr5Ucc0YMHXpkAwf1KSco9QU8Hl20V14UL7Afy4ydROqdC
 u/r6Ygif0RctcPEoKQTSueUbd8fnucE9LzcbOi60/uJL11oX0+gxCMXAfMBQYqHHleSFqf33Gsy
 Eweo5iJlDpAKBtQ6VKzRNHn7XzAFRheEtCD5brlndRFCGFeiraE7/C1otEN7YZbFrrHYEQyRwA3
 rwWZoEx5d8UI8Zmkx4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwOSBTYWx0ZWRfX731781EvOsya
 1xfWEXAtFXezNbwLcNk6D8WTqJ4UWLdM2jgQZ/Yr8pvoqqOOm6l7KqkY3JRljV3VSL1xXk9bRSt
 Ei80sAodI0HNl6xbGYKpH/WRWoP13m8=
X-Proofpoint-GUID: Vnf99IiUWHKmezQcsaqhzz-6K3Nz-YIG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_032029_612208_C3B55DE3 
X-CRM114-Status: GOOD (  16.55  )
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

nvme-stas 3.0 is out. It requires libnvme 3.0 and nvme-cli 3.0, it is
a non-backward-compatible release, and it is worth a few words on why
it looks the way it does.

For anyone who has not run into it: nvme-stas is a pair of systemd
daemons for NVMe-oF hosts. stafd (STorage Appliance Finder) finds
Discovery Controllers, over mDNS or from configuration, and reads
their discovery log pages. stacd (STorage Appliance Connector) takes
what stafd found and manages the I/O controller connections. It
implements TP8009 and TP8010 -- the parts of NVMe-oF discovery that
need a host to hold state and react to events over time, which a
one-shot command cannot do.

nvme-stas started life as the only fully automated -- zeroconf --
connection manager on an NVMe-oF host. Connections could always be
made by hand with the CLI, and udev rules could automate part of it,
but nothing else went out, found controllers, and connected to them on
its own. stas did try hard to tell its own connections from everybody
else's by keeping a state table under /run and consulted it before
disconnecting anything. That was fine while nothing else was running.=20
It stopped being fine as soon as somebody ran nvme connect by hand,=20
or booted from an NBFT or now ran nvme-discoverd.

A good part of this cycle went into fixing that, on both sides of the
fence. We also spent a lot of it trying to keep policy out of libnvme
and leave it with the tools that actually have an opinion: the CLI
and nvme-discoverd. That job is not finished. There is still policy
in there. And functions that quietly do a great deal on the caller's
behalf. However, the mechanism that came out of it is what matters=20
here. libnvme now has an ownership registry and a host-wide=20
exclusion list, and every NVMe-oF tool on the host shares both.

The upshot is that orchestrator coexistence is genuinely possible
now. Every connection record who made it. nvme-stas consults the
registry before adopting anything and leaves alone what belongs to
somebody else; nvme connect-all does the same. The exclusion list=20
(/etc/nvme/exclusions.conf, managed with nvme exclusion) is=20
honored by all of them, so an administrator says "not this one" once=20
and it holds everywhere. nvme-stas no longer has to shadow=20
nvme-cli's udev rules to stay out of their way, and that override is gone.

Configuration moved to /etc/nvme, and which controllers to connect to
moved out of stafd.conf/stacd.conf into /etc/nvme/nvme-stas.conf, in
libnvme's INI format, read by libnvme's own parser. Same format and
same parser as nvme-fabrics.conf, but a separate file, because a host
must be able to run nvme-stas and nvme-discoverd side by side
without either acting on the other's configuration. /etc/stas,
sys.conf and the stasadm tool are gone; the host identity comes from
/etc/nvme/hostnqn and /etc/nvme/hostid, like everything else.

To be blunt about the compatibility break: nothing from 2.x is
aliased. Configuration keys that moved or were renamed are not
accepted under their old names, and the D-Bus data format shared by
stafd, stacd, stafctl and stacctl is not compatible with 2.x. A stale
value is meant to fail rather than silently change behavior. Anyone
upgrading should read NEWS.md before restarting the daemons.

The numbers are modest next to nvme-cli's: 165 commits since v2.4.1
(2025-04-03), 120 files changed, +7,866 / -5,882 lines. Test coverage
is the part I am happiest with. The automated coverage run now stands
at around 95%, and runs the daemons against an /etc/nvme the script
writes itself, so a run no longer depends on whatever the machine
happens to have lying around.

Like Daniel, I leaned on AI heavily this cycle. Most of the above
would not have fit in the time otherwise.

Thanks to Daniel Wagner for the libnvme and nvme-cli side of all of
this, and for absorbing a steady stream of requests from the
nvme-stas end. Thanks also to everyone who filed a bug or tested
against nvme-stas without ending up in git log.

See https://github.com/linux-nvme/nvme-stas/blob/main/NEWS.md
for the full list of changes.

--
Martin

