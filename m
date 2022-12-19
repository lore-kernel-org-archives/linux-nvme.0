Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F067DC10F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4sMmJ3mtCpazHSedXAdEEx2AYmjd5oWCxFbdpgCPTpw=; b=I9dMtVHNtEb2a2mQU2VBa0Oqlg
	aJIPoVlSeQm56vOCs/lcWBLIIaXEzsFmyLRtMfCGgpfLK5x50pnxxAkbBcPtSlHQGD2AiUmG0dKl5
	zXT8NoNn9sN1xxo0TyCx5Ffl9HiqK9q3Wx2DWCg2LmZ9FX7DTR0ZC4tII6uMAtptB6Jv81Z6nvDX/
	nxlESg4neF8LQAp5CJNiO7JzAXJwDBYeheD+EwtE4NPi2jJCpTIOojd1pg/2y8npz5EwRd1PT5AK6
	x1IpwOAdIf4HxQKf8IvVpvjV4dCevhMp6TYQWIvQhdBKB1ygZjWJc6YP+dg4BgF7PrK6KDrQccfY0
	14aE11OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7IUp-00Fi5l-37; Mon, 19 Dec 2022 15:56:07 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7HKB-00ErTc-FM
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 14:41:08 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJDWEHo021394;
	Mon, 19 Dec 2022 09:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4sMmJ3mtCpazHSedXAdEEx2AYmjd5oWCxFbdpgCPTpw=;
 b=c/z3+4UZMlmRpZRBtjObpPdNhKTaX1CJI70ZdFFKRH6tOfPS6SFAtqrFBJlowR4oGfyk
 kv9DTDcgKdNaZd6Reqv1ngGqYURmTzqczzO0hSwNFUvxSzss6T8xhTEk2h7PetdxWzRI
 nSBEB/Z+kCA3FrHAVZ21haBmJSO3MN4LkvrIMst2y+8U7WIPbLKCZg0i0+w5VltoRN7e
 OKlDE0McyrYCYbwpDJ6s4Ew8fGR33JlZgNGyGUPHsW8VUtmVQ0jxsvXanqM7saSTwva+
 FPyqOfGZj31OUOt/XWhk7C5Z57+Eppkj+md9CMp4MpXMAXk0ybAngiRCUjjS+PGWdf/3 cg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mh9vcwwur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Dec 2022 09:40:55 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJDeIm2009643;
	Mon, 19 Dec 2022 09:40:54 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3mhv6f68m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Dec 2022 09:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPLcQ2g2j3cenjs/8u5FwIhb4WCemIN5pQ+lY7uZ6IMDcFgl2FWMjnKwLUcKUTU8eN+VgknFvo9VZIM8xPRprIW9e66jzZwSO8oO8F99CRrvRRdrrBFJJIq3osMaw6zKpACjHkLWtdRgHaIab+idBriFhWnlQMJNLQp5CclRgQT8sdG1o21YKNz4+xZMogYwscxog1E3iu5ff1Y4K5f+dckRRVqpVTlCYnP7zzv731Gfg5vm8ZkTt+qlUz9oEiL8un/JSTfciZtCGIt8W0o2hRpVPj0VMiggjjRe8BYqQ+GpCaIpq8ofvtbdvNoOWseGZYhhu1JHva0/tWRrHf/wvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sMmJ3mtCpazHSedXAdEEx2AYmjd5oWCxFbdpgCPTpw=;
 b=MogPHs3PkCVsLwjSHZwc9iT0wScipwKeriywbtLR56H1Zo1+eUGCJrlRScQKcLnXc7e6CGLbf638orzLvw3T6lGBpUnH7/i2Ec6jSDIuzX7uRDuj472N+uBK/cVIE0Y+K+Dxe6crgwUKkJHIjhwGblsxm22zqi5jvVotEEXJCkPwnQechfKAqEixXudTWcM5s74gxPzNRMDsP9DhwkQdDEgdQ5cZcLOistiPQz9fx9HGRV+frNlmdomlE+k3w8GeecByJyhAe0JIMyrF0lOXvKEc9Zb7nV1s0qQlORWPFr7mqm35B15SVaw9xmaEF+Ar2nqH/ZgDqhc/fvQtsWIPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CY5PR19MB6471.namprd19.prod.outlook.com (2603:10b6:930:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 19 Dec
 2022 14:40:51 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 14:40:49 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/2] improve nvme error logging
Thread-Topic: [PATCH 0/2] improve nvme error logging
Thread-Index: AQHZDmGgXH2WIGD1VEK2bYu0fSbGkq51UmuA
Date: Mon, 19 Dec 2022 14:40:49 +0000
Message-ID:  <CO1PR19MB48854DF53647E006465AA0E2EEE59@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
 <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
In-Reply-To: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-19T14:38:48Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=0fe6be55-e2c6-4c4d-9e43-240ef97b4037;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|CY5PR19MB6471:EE_
x-ms-office365-filtering-correlation-id: d68380ec-491b-40c2-770b-08dae1cf05ae
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  sx4Yzbkr2UbWsNLoOPALXtSQt9mdEJR/1VGe2o0l8SeQWMbUcec2FkjEnCZvKZCWashVhI5+QSTxpHAO4SiM0yc/mQ3plmsBxBByQwon1AagTnvpOytJ2SzzfIzjWCa2fap93hS4ZRbUzhyK6eZ8Bx1YaekpqbIPz5b1cj5ftWQCAfZnTkq8XCui2Yh340RdHbTq6w1+Lk5xwxOuMKwrO3oihxbE8tNc3ZhY8TFrsp/KoSD/7xuhSs3VsmRr7HFzQ6ZaIFNqBayYDNEOoE9fAcaVcO/fsiZCgJJkt9nlyUA9IGs1CqACylwPK8aSGGp8J/3w1MX8PuS3GsNBffqnGScXLM2Y2jiNUnE6OW9MgYUysxz3e5DZ+gR+CWhoBnSjOnyXG0QIiBqVFt78BU5MEvJ75K+bO5mAxxOMqBrmFb8kpgO0dXST2UazA6Xr3MI5Ulz41pOLEZ8sAhnA6/GZfG4oSJ4PApC7Fb4yCSZ3OqJGgOqkIwRzK14dbRpEIhn4G8iSfuA3oFg/zjNv6VWGASC62zRJrAsaLOCdjWdRm0cBK47OBFS/AHZSQnS66HqePrr0lV6M2IyWNifVxTdzJLkMMM7xFTDtCZrSydgM1UPv40SZaabK/oC0JAqdI9NTglwE010AFAhcSNoHk2rcPG3kiBK6DaxDwoh485rRy0TUuCD3R20PqxA7Mo+XhF19EjD1tOmVWD0Tb+uicdvdXQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(8936002)(41300700001)(52536014)(4744005)(2906002)(83380400001)(9686003)(26005)(5660300002)(6506007)(186003)(38100700002)(66946007)(53546011)(7696005)(66476007)(122000001)(76116006)(8676002)(82960400001)(66556008)(66446008)(64756008)(316002)(786003)(110136005)(478600001)(86362001)(33656002)(38070700005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?czUzRis4WHdweGtzZEM1ZDg2eTZoOXdhelUyd3ZjZFlKZFk1TVBFTTdNWUJF?=
 =?utf-8?B?NG1CR2FrVVRlbU05THdBYUZ1SU8rSC9HMjFRamRtamdPYmxzbStSeWpKSXBm?=
 =?utf-8?B?UE5zNHBNd3BMcGplZWhHM2lLK0NneWpoQ3I0d0p5aVlleXd4ajg4clQ0akIz?=
 =?utf-8?B?NURtb0pUKzhKMmQ0SlNiM2x4b2xHWXh0YkIyczh1M29jUENVN0l4V0o2NlZu?=
 =?utf-8?B?QkVzc0tUbTZRYTJiYk50bCsvZGUyZkdBT29BZ2VsK3JaMDVDdkw3WUoxSXJp?=
 =?utf-8?B?OHUzVDkwSDZNWW85dVg5VDlYZ0VkK0w1ZFNETi9UeTdjbUFjM1hZRTBqQUJL?=
 =?utf-8?B?MldyUEZQNW1kbWlWV2cwWEE4bk5lbm1PaHN2SzFhUDBUNXkwcDNmdlVsVGZk?=
 =?utf-8?B?WEtsblVlTHprM0ZzK0IwNFREZG1iQ01ZSURFV0l5QVlwSHROc0J4M1BzNXNS?=
 =?utf-8?B?RERHaks5OThCWW9HMlZqTUUrNWNWaVU1YTBScWF3eGlkUjh2KzhPc0VSL0gy?=
 =?utf-8?B?Q2hKSlV0TWVsY0J6cVhYQy9vRU5MbVh6UVJoRXk5eUxrOGZXdFE5UGhMVmRN?=
 =?utf-8?B?M0MwNkRSaURxQlF5WmZHTlppcVI4RHdnZ1NMNjU4Zi8zcElmcmE2dG1nUEk2?=
 =?utf-8?B?LzZOek8wU2xaSEN6QjZONEMwUGp6Y2o5UVdMaEpqb0hVVlh2czN0azlWK1NC?=
 =?utf-8?B?QnQ0cmZZcWpTSUxnamZiT1hNOHlnMjVHekRvR1ZmNFQ1MkpQVGZWZ3NOVWN3?=
 =?utf-8?B?RjRTcGdhTXNGRnNkYmYvTjVDcnM1Zi8vRHZSL1BYUnVRT2tkRHpGclArbXpa?=
 =?utf-8?B?YTVNKzdWY0h6ZVZLalZUYzUrTk52SGFUK29sbDhuQUgwVG53cWxhQW80ZHVP?=
 =?utf-8?B?ZHh2bTZFNUNpb0EvY1lISEplcXdubDRkRUhnVnkvaFBSbkZVM3BtWmZXZ0U2?=
 =?utf-8?B?QnlFTm9zSFp3U1JQMC9GU3V4NDhRbG9VaTlrOXZMSHV6aWZTQ1FqSGwza0pm?=
 =?utf-8?B?NCtpd0cxSnNFZ1FMV2o4MzdlbGVWNjNSQUxFMDJEcHVMR1Foa1RCcndjM2t5?=
 =?utf-8?B?Z0JPQ20zdHN2aDNBUGloc1JZbHRzZDZISWlkSXhNbUNRVmxMRWxZb0NzKzVp?=
 =?utf-8?B?OWYzZWJYRUxmYjZmUVZZMlo2VGUvNnpqcjBXV1NqYmpXSG4wODAzWjg0dHYx?=
 =?utf-8?B?d3lxM0svcGZLVUx4VkJVSGdkc3pPYll5bWVvVGVOYWpabUdUTlVxSU1LcUxk?=
 =?utf-8?B?aHIycmJNYXgvdi9vZFlQREJIYlB5RHEzaVhuVXh1VjlBTVZ3N0hBaERPYnNp?=
 =?utf-8?B?QmNWbnBaVmJtbWgvWlljZ3JadVY3elFNQlZCWmQxV1B2RWRFWVJoeWRSYkNL?=
 =?utf-8?B?YkhUMHpjRjAwYno0SVJaSFNhZk1ra3pYNXNKRzBFcmpnYTBXejRGeS94SUhO?=
 =?utf-8?B?K2o4STZPSWxtdTZTT2RyRW9OSjhwNlEzVWwrSU1sY2w2WlU3blg2NlY0RGV6?=
 =?utf-8?B?RktJZ2ZDclVHL2ZoRDJBQis0YmVHeitCd3pnS2QzVHRqblQ2VTIzcHVvajV6?=
 =?utf-8?B?L3g4RmRScXRwSlNFSGozZ0k0dko5YnRKK21iZmtFTE93M0tSQWdXUlp3NFEx?=
 =?utf-8?B?R2ZsSS90dHlYK1FmUDg2QWs4RCs2YkFwN0hzSGJWWk1UTWNGOWQ3TElzb1NE?=
 =?utf-8?B?S1hKVzB1U2c3Q2JtaFVveXhyZGRRWXRmRlJCc2x6bDM0Mkh2S0VhbmgyQ2py?=
 =?utf-8?B?YUd0Rmh2QTU4eGxNZnE0M05VcjZEVWhxUGNWNWZHRzg3WWdYKzFscjNKcWhL?=
 =?utf-8?B?QzNYUlJDWi9LNmsxM29YaHMrSndTNWlLd0g0emtIZGRIbElrQ2N6WEJrbmNP?=
 =?utf-8?B?enZZL2V6UXY5MlU0d0gwNjFYQ2tySG1OTDNRMm1kdEl5c0ZCQkJYelU0OUlk?=
 =?utf-8?B?UVlHTjZhcDBtZklodzljdTRiaWVlM1lJYjh0Z0V3NklSY25HTWowZHp1Vmky?=
 =?utf-8?B?T2tJR0RFNVRpWmQ4YnlIaCtjM0dSQXQxMzdvaE9GLzF2NnJjTnk2TXo2VzdM?=
 =?utf-8?B?dVVsVlJKejlrSHVFbXczbDlab2FKOHVWWlo1K3l1VlY3dENxUmJVcU1YVmVv?=
 =?utf-8?Q?MWXr3pLzbu5xfqQGyjumn6XEv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68380ec-491b-40c2-770b-08dae1cf05ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 14:40:49.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ck85P5r88eaDkjv1zgo2o0eKNyJvHtYPGB0HAX30C+pxJBliFLTnBSXK4HZnqeqIIwPJ6I3tam49sPjjQ9BcGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=919
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190130
X-Proofpoint-ORIG-GUID: -6Dje9h7mEIPLhxAfOQdfFf-k69a7NMQ
X-Proofpoint-GUID: -6Dje9h7mEIPLhxAfOQdfFf-k69a7NMQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_064103_763235_46992158 
X-CRM114-Status: GOOD (  15.30  )
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

SGkgU2FnaSwgY2FuIHlvdSBwbGVhc2UgcmV2aWV3IGFuZCBsZXQgbWUga25vdyBpZiBhbnl0aGlu
ZyBpcyBtaXNzaW5nIHNvIHRoZSBiZWxvdyB3aWxsIGJlIHJlYWR5IGZvciBtZXJnZSA/DQoNClRo
YW5rcywNCkFtaXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEVuZ2VsLCBB
bWl0IDxBbWl0LkVuZ2VsQERlbGwuY29tPiANClNlbnQ6IE1vbmRheSwgMTIgRGVjZW1iZXIgMjAy
MiAyMTo0MQ0KVG86IHNhZ2lAZ3JpbWJlcmcubWU7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KQ2M6IEVuZ2VsLCBBbWl0IDxBbWl0LkVuZ2VsQERlbGwuY29tPjsgRW5nZWwsIEFtaXQg
PEFtaXQuRW5nZWxARGVsbC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMC8yXSBpbXByb3ZlIG52bWUg
ZXJyb3IgbG9nZ2luZw0KDQpGcm9tOiBBbWl0IEVuZ2VsIDxBbWl0LkVuZ2VsQGRlbGwuY29tPg0K
DQpBZGQgbnZtZV9vcGNvZGVfc3RyIGZ1bmMgZm9yIGFsbCBudm1lIGNtZCB0eXBlcyAoaW8vYWRt
aW4vZmFicmljcykgQWRkIGFkZGl0aW9uYWwgZGVidWcgaW5mbyBmb3IgbnZtZV90Y3BfdGltZW91
dCBsb2cNCg0KQW1pdCBFbmdlbCAoMik6DQogIG52bWU6IGFkZCBudm1lX29wY29kZV9zdHIgZnVu
Y3Rpb24gZm9yIGFsbCBudm1lIGNtZCB0eXBlcw0KICBudm1lLXRjcDogYWRkIGFkZGl0aW9uYWwg
aW5mbyBmb3IgbnZtZV90Y3BfdGltZW91dCBsb2cNCg0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvbnN0
YW50cy5jIHwgMTYgKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAg
ICAgIHwgMTMgKysrKysrKysrKysrKw0KIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jICAgICAgIHwg
IDcgKysrKystLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCg0KLS0NCjIuMzEuMQ0KDQo=

