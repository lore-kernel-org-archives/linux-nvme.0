Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F74C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDHSKPkaFXUVcDuHF2c8ryuK0eiYj8RU2Z9eskKLq48=; b=E2tNelUCJmm8v/vHBlXT39XcOp
	njv9zBDPncAI15iz/7OR9ktACD7x8YqlVZEtQPPG3wZCx6YbdKw1SSIHIRYOqWf2amFNotbQoyC9d
	hFdqrQ/sYmmFca3rCegHIMWJMscePibraGayMro2F5+EnS10ccUaPrMYOODBDXMAr+7i138rPWklV
	hxlBhxhXiD5OiR99LLN1FXMaQzpB2dIf9C/7QBt0doY+M+DeqzjjGD4EL0SGPL7nVXOUvscbI66h3
	JoJZJbgPl6xEDiJTdUgPY1Y/kyWP/3Y2K0Jyl5zjsAG33oqk9jj7V+KGESM3kWPGvcacxHMrkd5eu
	ty+CIvtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onkpl-00AUks-9g; Wed, 26 Oct 2022 18:08:57 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onkph-00AUiy-U7
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 18:08:56 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QGKxWL021472;
	Wed, 26 Oct 2022 18:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mDHSKPkaFXUVcDuHF2c8ryuK0eiYj8RU2Z9eskKLq48=;
 b=2+AhfYfIX78620WxB4nvZvQ88EXfvxMv79T49gHml7u9+ISSkedrgKnR2YqhNfyQuOzl
 8bCkwJSH0xy1Hvi6DPQ6fvQMdKCPaXn533NtAN+1S+ds8jFOnxIUSpqgUvUQnp77yfq4
 tLebm1whOcwfjs3WIA4oXIT+K3uxc2cP2UT+/sAd8WqapJEm4YHIRtbwavYqmaTdU+HN
 N68Plm4RyM0ypNviLrfnwZE8v6+gfzrMtfe1QmZ4k7FZizsm+gozW4xPWx9tO8u+Wao9
 64pFJygrqxGew23Ylgm81JEAhRXwYfsNU2lkJaKJKFqDpDtTU9fNZEHyTR+FXZ0WUeCu GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc74202yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Oct 2022 18:08:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QHJ0YB020893;
	Wed, 26 Oct 2022 18:08:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y6075n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Oct 2022 18:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkMkGMteGPA3vQXNy/nszSUkHlUrULnJ6plnbDH5JuYqEv9u1XL2eRF0xvdyrLWohfSDD3Vnvjo5fwimG1deQ2bl2IYFuOZysj0rc7hwv2Et4483T/sY3hg1lxbJQYJRXC82oWyLz9KB1uipQet9GDeeQuNiJ0eAcFeHqkaFNFuG6BP6dYGh9jzhWvKib/28xjp5fhNMhIS9chSOmqG63HzCn7+Gx+8HMBn2LE0yRZKnyNS8RVUfpdlZSivBk1CipxsXHP1Axt3llVrrr70xTJHO9WD8KPwhA3Qva/tMwN+4L3LTWfOkpoqGziuuE6poMK176q9iijp11SlOD+WMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDHSKPkaFXUVcDuHF2c8ryuK0eiYj8RU2Z9eskKLq48=;
 b=WryJ7v3feZ12SasFHo+NIeTxn7I2DSmKoosXx4jlqQdh6kaub+gwOREFrtA57rJawOF5Xd+z0GMRAbVz3YLPWV0JVVBdQX3pCvlTFMBlWyOsBPFggoZ2x14ESyevTqPue+BU8O73C+36YM3emA1WfCqwKEpp7rARIaOiRIMJetr4Dww8+Jv5OfsYIXDcYPFCfRJrrwRM3U75ZJDW/YQlJMKK5nE2b/6SCxftFed1kIAiqgAso6S3zxnHHa3PMd9dBcPzl8UqdrGzqaAesK4BULICiLxH5KEebP3WEYcsn9KDElgmn8QKQKAOoJdogMyahMAIuHbAy6Cx8HmuJ5BCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDHSKPkaFXUVcDuHF2c8ryuK0eiYj8RU2Z9eskKLq48=;
 b=I7SlXLfKMJfD49wH3u+C2ZpRhE8ADuIEWj/+0+LpXWi0YnHv3PPe+wIWqDVDgcvauLqqfNr5uexDPDb8TyAVhGLHHY8byzOBDng+gPPT2iop2S+tuDTPkQp1i0AtAV9pchjJqidu6v6I113lQOjVNy/TvwD0cUM1e+NcAY5puIg=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MN2PR10MB4336.namprd10.prod.outlook.com (2603:10b6:208:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Wed, 26 Oct
 2022 18:08:34 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2%5]) with mapi id 15.20.5676.036; Wed, 26 Oct 2022
 18:08:34 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Thread-Topic: [PATCH] nvme: quiet user passthrough command errors
Thread-Index: AQHY6V1ukevfyd7VB0isdL1YlJjCFq4g+BEAgAABH4A=
Date: Wed, 26 Oct 2022 18:08:34 +0000
Message-ID: <D94917CF-9369-41C6-8F83-FFC36BEAF8BF@oracle.com>
References: <20221026170715.2657664-1-kbusch@meta.com>
 <52e66f7f-30a8-0726-3db5-dee2b010c1a2@nvidia.com>
In-Reply-To: <52e66f7f-30a8-0726-3db5-dee2b010c1a2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|MN2PR10MB4336:EE_
x-ms-office365-filtering-correlation-id: 0444628b-7544-48a8-93e7-08dab77d190f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HDak7DY8LSckvyKtdSOpQvk5RzX0nLvtRCQQKR3f5dlRYZq6GQqrBbe1TGcstEZUtSwM2Jy1Uu2q78mKdjwjgCVW9NBwz6u/BRokExdRLo9bevBUjqrskD2nJlOgfJdRnUKEadfFLL1cEQ8yK7Qufh/0tRV1jOPuAyVLrUWvGtkAwNfv+dOJIlykY3XM+7GSaVyPD8HiMX1xDmswuOU8yqiSNt0Jn2G75nCfRrFZgoLsPyPlxJiO4QaJQ6lQs4lQSj/KF4HXP55o6lxyj+zDmI9MdSgHlTSeiuLUy1M3TaBTqdIVcd0cYFkFpdgI8kCHXIRDoszkjMQApy+NrvsSkCsAUsdWpcCA7bwbW4QvL+sLoAHn1wo3UXP7JojDexXJGnuZTCtPGpTCtVaASvvIm1HWFk7K2Lgh6NZBCeswypP3a3xLMCUTjgZmw6wreluIgY7cSI2q9xB6A9PES6cLfr8J9TQBlkMmxm4+sDiFeQFi5KcuPaiUJZkWJeYChE3IVC0ZTiUt0fodTHCwL3thIelf0hzISWGloSgS25PTVawutBl28H5oC2gVwvZjoIZtJd+2C4ikZKLWagOhIE0oiKFnO4CaH0sobL1ZgxJAOeY1hMQO+PsMmGMmqpa1mNqpj5V+knBUyUl9AyTdQzhD5ps44TDRP7pP3PIhgiyRt0b/FZ6y1NcILbSjw3PUTkDbVjqNZ/yhEdS6WvPzBpeYbs0/FB4Pgbj9ZD+ylB1qQzwRHe/0qB4L3I3gBGfcckn4HsvedZiAOk1D7yHeg85rIfdkwET1gh7rb5DiNuDVbFA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(36756003)(38070700005)(8936002)(66946007)(5660300002)(38100700002)(122000001)(83380400001)(66556008)(33656002)(2616005)(4744005)(76116006)(6486002)(86362001)(6916009)(71200400001)(186003)(66476007)(6512007)(478600001)(66446008)(54906003)(64756008)(2906002)(8676002)(44832011)(41300700001)(6506007)(4326008)(316002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZEpTeU1haUtnTC9CWno1NEtXUWd1d0xpN1dhS1V5Z1Bmam15NTNzTU9pOW0y?=
 =?utf-8?B?THZhOERlUmx1RStzY0FBT3Q4SkZFM1pVZFAwMC9LbG1qdUtkWDVBNXZLMldJ?=
 =?utf-8?B?WWNnbUhNOHpzQ08rWjI1NENXR3ZGUldzeDZhMDM5OTFPdGNwOTVsUW9abUg4?=
 =?utf-8?B?b291TlVydFBFNGx1SHh0OVFaeDFEVFVtdkVEU1Bsb0w5d0MxVGdMMXd6Mzk4?=
 =?utf-8?B?NXJjb0FFS0Y0R3U3TlBvcWY1WVo5VDdYTkNNRVQzYjRsdGRTQzFRM3l3cnpW?=
 =?utf-8?B?S1ZJZDVMN1cvMW9HSXZwSjZCQnBQRlJEUUJTeEI2YmNNVDV2ZDJCeHRtSkdU?=
 =?utf-8?B?MHdrWU5KamJKNnZYbmgyNTJPYmV2MW5qL1hFRFVwQTllbzBmYkloUnY3RjJj?=
 =?utf-8?B?T2R6cStyTm1NaXpRM2VJR3ZGYzZ2SUtEdFY3M3dDNWJ1M0hPTGVrWHp3ejV3?=
 =?utf-8?B?ZnAyaTNxWEZPSDdhVVVvVGkzY2J0d1E5ZHdBdFBERzgzdWtwZWZvOUh4SnJq?=
 =?utf-8?B?ZnFlNk1rWThlSmZzYWpSZ3hvVnBqb2dZNVd0N3cxSnd6MHhud1d0WGtIQVo0?=
 =?utf-8?B?OWRsR0ZvY0ZVNDZUNnEyZ3BhbUJDWkZpQU5OcTc5cmp3T2k2UlZYRkhCcVR4?=
 =?utf-8?B?RW8vbGQwTFhteUZnaDBYTGdBc0xEY1JjSE41U201bzJNSTJJZ1hlWnlzNVZJ?=
 =?utf-8?B?YW93SytuMWI1YkNSRHpBWi93NzkrUE5xSEJOQzliUEhWZjVoeGk4dEl5NFI4?=
 =?utf-8?B?aTEzZVA4L1lCN3ZDTEw0VVdLN1Y4VnlMa2hxSGJkd1ZTVkhJcFh5Y3M0TkIv?=
 =?utf-8?B?MDBkVnJOSUZxTExzYzhYQ0RGVHd6SUY0RllLVEMwZjdNK3Q2NWZ1MlhHcjRF?=
 =?utf-8?B?SHIyd3QxUW5SZmdNdlRLUTc1aWljY3NxVFA2ekJXbGVITkFKQWF0MnRSSm1P?=
 =?utf-8?B?ZDBENEhlNE11NUpIWDd5ZGk5V2daMWZPR0Z4TWNrVTR6MXcwVi9qcXlHM3lC?=
 =?utf-8?B?Vnh5R1hjWWc4WUJTZnBmbUoybGhJQWgxNXQ2czlpdUhUVEdtVkpqMTFaRDR0?=
 =?utf-8?B?eTFQQWZId25rWVYwNGNBMTN4VWgvMFR2bE1OSDVjMDFhRGUwRTRqSE45L0x6?=
 =?utf-8?B?Syt5d2JEdXNOclZPNGZabG56bmVuUWFaSFJiRTVwNm5CZmZHMjdobDE5MkVE?=
 =?utf-8?B?VDdaeUxhSDVSdXhlMElTYlpMeHB6elppTWhQVm1LVHc3aUxzaXE5QW0yaXla?=
 =?utf-8?B?M1ZUYUNPRy9Zb0pQZmZ2d1BXN3RyS2RpRDhHRm0yNXRPQUNId3k2NFpQSHBX?=
 =?utf-8?B?RDIzTVJOS08xVlYzRW1nbjVoMi9yNkZUYUdlRUJMQW9oMWl3emZXVlJIcmVa?=
 =?utf-8?B?UHJwRFNSdVFPTElwVytMenZNdFdqcDBCVDQ4aEp5emNGNk5RV05hVDZKcXg1?=
 =?utf-8?B?RkhVcHRRU0gwQkoyaEMvdVZkeU1rYmlyU0FEY2RrVGVJRlVpZ0lBZU9aOS9p?=
 =?utf-8?B?V0c3N1kxaU9FUlh0WFpUR3FUdUVncUpSaUtFU1p0cHhRZkJRcHo2Vjh1TUxJ?=
 =?utf-8?B?cnNFT2g2UG5qR2lZeFhDejlsSEVrdVU3bnZOYjV0RzZ6d0FMdFdiWDF1WVFi?=
 =?utf-8?B?QWtSYlpHWjJudW9EdmtxdzRmVWxZOWd6ZUtqRzJPZUhiSjFEeitUem1obExa?=
 =?utf-8?B?S3M2cFNRR1RZSFZoc3NvYWd3T2VBZ3RpZURBZmtIZ3oyMzZJR0hRamEwM01j?=
 =?utf-8?B?dDZ1d1ZYNUl0RkExZU1CSmV4eExQVHZsVTl3RHFzMDlEL1laelE3TkNNWGtK?=
 =?utf-8?B?b0hHSi9NUlcrdUQ5eTZGYXA2UlRsSGhOdzQ0dzBqNnZQZGZNWWhDMytGUExI?=
 =?utf-8?B?MEthdE8wejRFLzduYWJRbXA3cDkyKzRVL0tsQ25VRE10b2lzWU5mVXZqbnFX?=
 =?utf-8?B?S25lU1VLS3VuQW1WSzNYOCtWTmJrRUJ2bVhkZDdKTUEzSnY5VHBSSGx1V3RB?=
 =?utf-8?B?aGlTdzY2TTc0Qm02Ukc2V1huMTIvSnpBd2VGd1daeTVaeVZqV3lGcXlRUjg1?=
 =?utf-8?B?L3BKQm0zNkRKQjVLQ2thWUxEb0ZWZEo2WWQ2Y1FUcVlTaVAwaEFiaVVSN2pB?=
 =?utf-8?B?K3RjMUFGL2piSFNIV3R4bGp6S1E1c2Z6OTZoNmdXYTFzMWJBY00veUsybGNL?=
 =?utf-8?Q?rRddwlna8NPyWSP+BYJvSIz4yPHqqTEyo/RkyPZkDVXn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6347A28B96528E4082EA9D6CCDBFFAF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0444628b-7544-48a8-93e7-08dab77d190f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 18:08:34.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwIvIjAzyBkdPtTZ1MAqeKe3XSFUzOg2RUCa+C3TSfvqQc1gzSGQPZJsfpWMOW1WHlf81EQjTYdsn4V65gwRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260103
X-Proofpoint-GUID: GxEkbmvHgsEoJSJEjqH9GC13cubm7bYS
X-Proofpoint-ORIG-GUID: GxEkbmvHgsEoJSJEjqH9GC13cubm7bYS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_110854_921453_D74E3816 
X-CRM114-Status: GOOD (  21.48  )
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

DQoNCj4gT24gT2N0IDI2LCAyMDIyLCBhdCAxMTowNCBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIDxj
aGFpdGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTAvMjYvMjAyMiAxMDowNyBB
TSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+PiBGcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5l
bC5vcmc+DQo+PiANCj4+IFRoZSBkcml2ZXIgaXMgc3BhbW1pbmcgdGhlIGtlcm5lbCBsb2dzIGZv
ciBlbnRpcmVseSBoYXJtbGVzcyBlcnJvcnMgZnJvbQ0KPj4gdXNlciBzcGFjZSBzdWJtaXR0aW5n
IHVuc3VwcG9ydGVkIGNvbW1tYW5kcy4gSnVzdCBzaWxlbmNlIHRoZSBlcnJvcnMuDQo+PiBUaGUg
YXBwbGljYXRpb24gaGFzIGRpcmVjdCBhY2Nlc3MgdG8gY29tbWFuZCBzdGF0dXMsIHNvIHRoZXJl
J3Mgbm8gbmVlZA0KPj4gdG8gbG9nIHRoZXNlLg0KPj4gDQo+PiBDYzogRGFuaWVsIFdhZ25lciA8
ZHdhZ25lckBzdXNlLmRlPg0KPj4gQ2M6IEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNs
ZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+
DQo+PiAtLS0NCj4gDQo+IA0KPiBUaGlzIHNob3VsZCBkbyB0aGUgdHJpY2ssIGhvd2V2ZXIgaXQg
d2lsbCBiZSBncmVhdCBpZiByZXBvcnRlcg0KPiBjYW4gcHJvdmlkZSB0ZXN0ZWQtYnkuDQo+IA0K
PiBSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gDQo+
IC1jaw0KPiANCj4gDQoNCg0KSeKAmWxsIGJlIHRlc3RpbmcgaXQgdG9kYXkuDQoNCkFsYW4=

