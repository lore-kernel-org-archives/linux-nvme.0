Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E83C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:52:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD1C61355
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DD1C61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T4RjuP5AQEpg+OKaIdpNxSy+JXB/gUeUo9yOxeJezTs=; b=BTCi3O7O6Y3HJk
	3toNMllY02Y9F2xi7YdKryCMWbrQVf+NLA3S11ZZFsoUtnkTQbiNcgiFjOJMLUteLg5C3L3IMw96N
	Pd91vqVTkk0UxeYkyNWvEs4DpWSqWNzOg7uTlvfd575rUTTl2okA0z2qc1z4rKXvvm1CP9ErdwNub
	xrIo/HmvrZXp0YhfT010wkLK1LWZVzJyxVXAmQ8C0YmCWBiveZAHY2iUecl5F4SgDobBoNrxrNsDy
	ZMA2a5Br6TUVvzVbO6hnw/itooTwI6aFUWDz4JyUnza/WkDJepRjcVj+N+DlZgUDWH7uzNAIXj/8q
	SEEYFbMm7oDy1X0Kqdag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ3Ek-004ZnO-4C; Tue, 14 Sep 2021 07:52:14 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ3Eh-004Zk5-By
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:52:12 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E1wma6006028;
 Tue, 14 Sep 2021 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=q/ZzyIUtl/73RKnJ4+4Vs18+NYTO577kJuoN4l4FYtc=;
 b=LDcL0E/mBvEBI5ENI1ydL/PWXCzwDE2kGTwO7lRH75hKyz0FP0TVE5BbwUambxx5YKgn
 pof3PLfML89BbcbEpIkg4hPl2SvE4ujX1ugyxYOIZYsm6eFXtyhHf199B3e4JeXOO6Xf
 YcMPiqY/VvVplmjhBSEjTqb+Ed7lCHepPCYBHOPBPPdwOickpkWasCAVhTNB7EJ0HJ4F
 pDxnc+DSSZNZ7I/1Cs2rF9LqD9nCv+GxeLJcXikgssss0IQFRt82jSR7VzcXsZUNczFp
 6J4IKscuQN56jHWAoTbxCLleaClsGf/qMKlaAoemmpXrz5RLinn1yaDwJw5hFVGMOlL5 IQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3b1xbe5y27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Sep 2021 03:51:54 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 18E7noAZ186676; Tue, 14 Sep 2021 03:51:53 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
 by mx0a-00154901.pphosted.com with ESMTP id 3b1a1kpn6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 03:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0DoIB3t69wkUid3Qfm5Dzpef9jjT3TjPGyE0irI1bnFKiY+7q9BQpgw1DLCTj1PavES6ZubAk7c+Av57p3hYGCcVVtKgBgdQRHmMoIxh8GPD/D0pohniOTfOD+HHi+NaOL8n3Ng42YTv6v8McWGN41w4CT6HyodFyKIVOmFSLR3kzKZhLZ+/xm5aRAIfmBdtEZlYpAjGrZINhL1ehXkHEnv4mCCl1sPc5nhxv7IMjaSjt8/p8iivEZDgo6F6UbIiLYPFgh2G9+yDfU/8qV+AN9XO0rKHoZ1C315plub2A/uNRSMp7n1UE8AmyYLmO3ZdQxf9DS9GexBHWb1nwbJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=q/ZzyIUtl/73RKnJ4+4Vs18+NYTO577kJuoN4l4FYtc=;
 b=hp94xDdpar30kqIgtUVNR82wQZsw+mrrDRaDzGNvg2O8/S/JCwK+6kL801JyiRo2Dxas8rbHiMZLrlzyktjz/noIGXlqhxHZABLe2egG0q9nHtcRMNfkgw/pYDEzRdCUSbOdOjGr8GufDm29m1Cz97hqOG/YYeFVeqWGriMLgEeofdgQT60ETNpzoAcM9sIMZ5gBvSv+rausWDyRmla+KswHWHZYLlLB338E0gZ27C90A9I77ohUJqHvAcoDg5Aj5H1aVh1qRRWKoKUSAaTiZQLghRRaBUNanuano3MwKu88Ta6UmGIl6NQZGpNsf62Q9o4do5UoaNC4MCOz9DqB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW2PR1901MB2156.namprd19.prod.outlook.com (2603:10b6:302:3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 07:51:51 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::9507:7302:e791:504b]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::9507:7302:e791:504b%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 07:51:51 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@infradead.org"
 <hch@infradead.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet: return Invalid Log Page status code for
 unsupported lid
Thread-Topic: [PATCH] nvmet: return Invalid Log Page status code for
 unsupported lid
Thread-Index: AQHXn9gHZ5FCMNOZ8kO3wjOKp5/SBauQgyUAgBK28zA=
Date: Tue, 14 Sep 2021 07:51:51 +0000
Message-ID: <CO1PR19MB488588825A8B8C5EE29ADA61EEDA9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20210902085333.32107-1-amit.engel@dell.com>
 <YTCg1pXB83YsEDvD@apples.localdomain>
In-Reply-To: <YTCg1pXB83YsEDvD@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-09-14T07:51:49Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=f151175c-a786-489a-83f1-6cd02331bfd5;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28ddc445-9c7c-435f-4951-08d9775483aa
x-ms-traffictypediagnostic: MW2PR1901MB2156:
x-microsoft-antispam-prvs: <MW2PR1901MB2156A83F94D38B592E170E48EEDA9@MW2PR1901MB2156.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWYnyeVEPUgimUep9PuqIhnkXYJCxVDvreU8LQ5i3IzpSszSkFGbNyAD1hi8Pjt1LewVO1h6YcJUu14Z6flpACtgoy+RzcQVUDx5ht5MIix1M++h7Yv3o+KPPq4cixpbZXGUk3NGrvUJnfdnJ46ZPZGdawd8wGiIan3t44Hatycu77E7Y132GMOLB+1YyA1wc1UzyjegtvtZ1MczaQZfkFuQG4YrxIPlbDb8BG9yQcLMBSZ1W59lmr5kWZ944fJdP+tYlRd6RfNO0SMpPNw2sc8byqX5TI8Qvs3/dJUIkbafOMvPuxx6spBaBQapwE9Uy/gOEsJ0vowr2ZsBX0E/yCvrtl+qUrLRQR1IPJWMuxBhisrR/vWz/9mFCefSnqfd6extgZaLk/WsycIQe1zHKp70eHl8LLyo54syG73UL+vq4+Lgek9dqn1j0pk4dOZ5JwS3qTFXZEGmICGV//F2Ri+Muujv/RPhyuWorq2QpCWM97xIMwIuLLy/vPDoPAkdf3wcoIdxvEjqLKuTATg/Cpg8ABdcdUCJPA1FLsBjpaoGbgDuQkglTV6wWbmDmd/TZHPhOf3NXgNXGPkJ29EXEsynf2FSDxlzLHEHn8eXOf63mYA2KmBaOLanz1ADv90nHiqoch5rC+ZR8kU2f0bgp55Z/IYVGkDQnJzDddK3QXX3Pju15Gl49K6Zlz9SDtZ6HvkGIqpNKLHc3scvA8/K7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6916009)(122000001)(5660300002)(7696005)(66446008)(64756008)(9686003)(53546011)(52536014)(6506007)(71200400001)(66946007)(38100700002)(66476007)(66556008)(54906003)(76116006)(55016002)(316002)(26005)(4326008)(186003)(8936002)(38070700005)(33656002)(478600001)(83380400001)(2906002)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmxQREpWaWVEWDQwU1E4WlY2T3NRWU9nWmRZNEdBSCtURmtTR01oSE1XSjl5?=
 =?utf-8?B?WFpxNVM1amV2dE5ObzFPVjFTdzl3TVVVclZORmVNS2VFTmVXMDFQYmtiQklt?=
 =?utf-8?B?M0ZQaHFiNG9TUkN5TVlQUlJuUjl5SHRKczBwQmV3cUlpcmJ3L0tBREtNYnFH?=
 =?utf-8?B?ZUQ1c2RNVzBWRzNuajhiaitacU5mL0lnV1ROOEMyWXhFSmlKYm40QU5GWncr?=
 =?utf-8?B?ZWJvZ0FxVFBOeFl3SmdFdFFFL3o2eVVOdFcvbVQ1TEVMTXdGdDY0R0pkQzYy?=
 =?utf-8?B?c2dzV0k2c1dESHhITUVBNTRxZjJFc0RSWkF3MTAxdi85ejk0c1p0QnZnbmJF?=
 =?utf-8?B?anlINEd0MVpTYml2L3BnNEZ4M0wrRjJjSzBSaURNa1lNUkU3MFltbFBzSXNq?=
 =?utf-8?B?a2xtNmt5TXo1c2NMdWx2UVRwam14bjVJVlpwQUtpaWpoM0xhRHR2SDVBZTB6?=
 =?utf-8?B?b290dzFMd1JJMXk1NlpVNEo4OWJGRmNqakRwUE9UYjZ3MTdBV285NWFIZnJq?=
 =?utf-8?B?eEplMVZpZTBocGQ4SDVTem5xaUg2STN2L3lhbkVrSXNaYUc2L3VIMGRUaVVO?=
 =?utf-8?B?bFdiUnNNaWVVbVc1ejJGaGtnZzN5N2FNak9CdTNiMnZRaHpPTE5uZ3BLWW54?=
 =?utf-8?B?c2MrcE9uWFltY2l4YnkxenNzYlduNUJOLzJySWtuSG1OMDBuRWd1QzI2THJX?=
 =?utf-8?B?bmdSRW5BVkRCT3JVYW1UMFVZUys1VDZMSDcwUkVTU0hJd2RtbkQzdXZBMkx6?=
 =?utf-8?B?QlBSczFmdmpJcmtzQksvc1pLNDNJVVdIUG5McGNvV0dmNkJiaDlTS3JGYTVs?=
 =?utf-8?B?VllqcFBzaXhXclEvT1M3NnRYS1hOOVFNWjRMbE1Gd2pSdHhJUTRmWnlTZkph?=
 =?utf-8?B?QmZXNmt0WmJuMlJXMGRoNDMrd0ROMllvOWc4b2VGdjBNOG5GbVZsU1cvVnFN?=
 =?utf-8?B?UDBscVJ0ejgycFpPQVRhTHp1NHl1aFhXWWw0c1FFbXhlL2xWc1RGV2o0UGFN?=
 =?utf-8?B?M21Jb1ZVeGV2WmZNVmw4ZnJIZXZnL0dBeG9PSWd0NFBZelJFVzRVQmc2b2E0?=
 =?utf-8?B?L2pqZEkrdWVlWktEZG5JYWM0MmNSQkRaZ0JKSE9NeWdKSFN5RHlEbDV5ZTlY?=
 =?utf-8?B?R3VJMG5MQm10N2xWTmVGN0t3UmMwVDRNbVI5MVRaS2t6b0k2R3JZbXovZVVH?=
 =?utf-8?B?TmlMdFZ3VmFqWDllZFFXSFhGUzlVWUhTa3FwZGxWVjhrZ1FnbGpOTnh0MzJP?=
 =?utf-8?B?MnkwSWpla3RVc0lxdlNXSkVleDhuVUlhK0w3djI2UXI1b0o1RXVwa0FYWU9H?=
 =?utf-8?B?TGxDMFI4ZGd2SlRUanVPY3F6YnVIQlJ6b3FSSEVKcUxJUWZmdnV3M1VWRUlY?=
 =?utf-8?B?VW91OXZQMEZueXN3a1FBV1Fudzc3cjUvWitOQzJ6aDAyQlYxR3VHTFJiRThC?=
 =?utf-8?B?dTdhQnFMRjN0RlNkajRoQ2JHcGpzY3RSUllqWG9KOUJKZG5rZGVlMEhuTis2?=
 =?utf-8?B?eTdKRDN1aVovVHpzbHpVYjlwemtlSnk0UmtSMUVmdkpGS3BrS0dqVjk1WWVQ?=
 =?utf-8?B?RHRJZFU5eS9UNjB2KzF0VGJkTWdEZWZlSUdLMmNWdG5KRlNsNUZ4WU1ZMWJX?=
 =?utf-8?B?WU5PSDFvNE1hU24ydkxVTkowelRxaStZTGlxYVhXZjBTb3dMb0lCaHhiMjdM?=
 =?utf-8?B?NmJ0QXFaUnZoMTBjYWd5bGtId0xHL01oNTg4a0ZucnRldVZFenhmcmlkbFk4?=
 =?utf-8?Q?cu65fRs8Z31/oSZU0yDNvL7KYR51HCqdHQTVW3s?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ddc445-9c7c-435f-4951-08d9775483aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 07:51:51.9106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgDfKZgsFSrfTY/aATmxscowZFB3hB3h9jvjo5RukFqQMQiX72RLoJ8Dt/ABEW5a2LUEJISJb2g/mDQKFweogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1901MB2156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-09-14_02:2021-09-09,
 2021-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140046
X-Proofpoint-GUID: lu5hwgSHrmFNg33Ed8F8hI2ihgpaDmDl
X-Proofpoint-ORIG-GUID: lu5hwgSHrmFNg33Ed8F8hI2ihgpaDmDl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_005211_427949_597EA52A 
X-CRM114-Status: GOOD (  28.92  )
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

Rm9yIHYxLjQgb3IgYWJvdmUsIGl04oCZcyBtb3JlIHNwZWNpZmljIHRvIHJlcGx5IElOVkFMSURf
TE9HX1BBR0Ugd2hlbiBhbiB1bmtub3duIGxvZyBpZCBpcyBiZWluZyBzZW50IGJ5IHRoZSBob3N0
IChJIHRoaW5rIHRoYXQncyB0aGUgcmVhc29uIHRvIGludHJvZHVjZSBJTlZBTElEX0xPR19QQUdF
IHN0YXR1cyBjb2RlLi4pIEJ1dCBJIGFncmVlIHRoYXQgaXQncyBub3QgY3JpdGljYWwNCg0KVGhh
bmtzDQpBbWl0DQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0BpcnJlbGV2YW50LmRrPg0K
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyLCAyMDIxIDE6MDEgUE0NClRvOiBFbmdlbCwgQW1p
dA0KQ2M6IHNhZ2lAZ3JpbWJlcmcubWU7IGhjaEBpbmZyYWRlYWQub3JnOyBsaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG52bWV0OiByZXR1cm4gSW52
YWxpZCBMb2cgUGFnZSBzdGF0dXMgY29kZSBmb3IgdW5zdXBwb3J0ZWQgbGlkDQoNCk9uIFNlcCAg
MiAxMTo1MywgYW1pdC5lbmdlbEBkZWxsLmNvbSB3cm90ZToNCj4gRnJvbTogQW1pdCBFbmdlbCA8
YW1pdC5lbmdlbEBkZWxsLmNvbT4NCj4gDQo+IEluIGNhc2Ugb2YgYW4gaW52YWxpZCBvciBub3Qg
c3VwcG9ydGVkIGxvZyBwYWdlIHJldHVybiANCj4gTlZNRV9TQ19JTlZBTElEX0xPR19QQUdFDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbWl0IEVuZ2VsIDxhbWl0LmVuZ2VsQGRlbGwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCAyICstIA0KPiBkcml2ZXJz
L252bWUvdGFyZ2V0L2Rpc2NvdmVyeS5jIHwgNCArKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIA0KPiBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4t
Y21kLmMgaW5kZXggYWE2ZDg0ZDg4NDhlLi41ZGNkYTJjODdmZGQNCj4gMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3Rh
cmdldC9hZG1pbi1jbWQuYw0KPiBAQCAtMzM5LDcgKzMzOSw3IEBAIHN0YXRpYyB2b2lkIG52bWV0
X2V4ZWN1dGVfZ2V0X2xvZ19wYWdlKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4gIAlwcl9kZWJ1
ZygidW5oYW5kbGVkIGxpZCAlZCBvbiBxaWQgJWRcbiIsDQo+ICAJICAgICAgIHJlcS0+Y21kLT5n
ZXRfbG9nX3BhZ2UubGlkLCByZXEtPnNxLT5xaWQpOw0KPiAgCXJlcS0+ZXJyb3JfbG9jID0gb2Zm
c2V0b2Yoc3RydWN0IG52bWVfZ2V0X2xvZ19wYWdlX2NvbW1hbmQsIGxpZCk7DQo+IC0JbnZtZXRf
cmVxX2NvbXBsZXRlKHJlcSwgTlZNRV9TQ19JTlZBTElEX0ZJRUxEIHwgTlZNRV9TQ19ETlIpOw0K
PiArCW52bWV0X3JlcV9jb21wbGV0ZShyZXEsIE5WTUVfU0NfSU5WQUxJRF9MT0dfUEFHRSB8IE5W
TUVfU0NfRE5SKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9pZGVu
dGlmeV9jdHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkgZGlmZiANCj4gLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2Rpc2NvdmVyeS5jIA0KPiBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZGlzY292
ZXJ5LmMgaW5kZXggN2FhNjJiYzZhZTg0Li5mZGQ1MmRiZGQwMGYNCj4gMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbnZtZS90YXJnZXQvZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3Rh
cmdldC9kaXNjb3ZlcnkuYw0KPiBAQCAtMTc2LDkgKzE3NiwxMSBAQCBzdGF0aWMgdm9pZCBudm1l
dF9leGVjdXRlX2Rpc2NfZ2V0X2xvZ19wYWdlKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4gIAkJ
cmV0dXJuOw0KPiAgDQo+ICAJaWYgKHJlcS0+Y21kLT5nZXRfbG9nX3BhZ2UubGlkICE9IE5WTUVf
TE9HX0RJU0MpIHsNCj4gKwkJcHJfZXJyKCJ1bmhhbmRsZWQgZ2V0IGxvZyBwYWdlIGNtZCB3aXRo
IGxpZCAlI3ggZnJvbSBjdHJsaWQgJWRcbiINCj4gKwkJCXJlcS0+Y21kLT5nZXRfbG9nX3BhZ2Uu
bGlkLCBjdHJsLT5jbnRsaWQpOw0KPiAgCQlyZXEtPmVycm9yX2xvYyA9DQo+ICAJCQlvZmZzZXRv
ZihzdHJ1Y3QgbnZtZV9nZXRfbG9nX3BhZ2VfY29tbWFuZCwgbGlkKTsNCj4gLQkJc3RhdHVzID0g
TlZNRV9TQ19JTlZBTElEX0ZJRUxEIHwgTlZNRV9TQ19ETlI7DQo+ICsJCXN0YXR1cyA9IE5WTUVf
U0NfSU5WQUxJRF9MT0dfUEFHRSB8IE5WTUVfU0NfRE5SOw0KPiAgCQlnb3RvIG91dDsNCj4gIAl9
DQo+ICANCg0KVGhpcyBzaG91bGQgb25seSBiZSBkb25lIGlmIHRoZSB0YXJnZXQgaXMgcmVwb3J0
aW5nIHYxLjQgb3IgYWJvdmUuDQoNCkJ1dCBob25lc3RseSBJJ20gbm90IHN1cmUgaWYgdGhlcmUg
aXMgYW55IGJlbmVmaXQgdG8gcG90ZW50aWFsbHkgYnJlYWtpbmcgaG9zdHMgaGVyZS4gSXQgaXMg
cGVyZmVjdGx5IG9rIGZvciBhIHYxLjQgY29tcGxpYW50IGNvbnRyb2xsZXIgdG8gY29udGludWUg
dXNpbmcgSW52YWxpZCBGaWVsZCBpbiBDb21tYW5kIGluIHRoaXMgY2FzZS4NCg0KVGhlIHNwZWMg
YWN0dWFsbHkgc2F5cyB0aGF0IHRoZSBjb250cm9sbGVyICpzaG91bGQqIGFib3J0IHRoZSBjb21t
YW5kIHdpdGggYSBzdGF0dXMgY29kZSBvZiBJbnZhbGlkIEZpZWxkIGluIENvbW1hbmQuIEJ1dCBJ
IGFja25vd2xlZGdlIHRoYXQgdjEuNCsgc3BlY3MgYXJlIGEgYml0IGNvbnRyYWRpY3RvcnkgaGVy
ZS4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
