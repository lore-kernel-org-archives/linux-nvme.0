Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDDC433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 19:37:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6E664E04
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6E664E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3kaUFYFXojTmYuw/WQ0T07UMr+4NNm/0h55yCeg8SfA=; b=DTmfvSWK/bQcL7d99JNjMQrcK6
	5Q6cPR9/L+QCSQ89mFEFDsITSQSMpFvg5MHnLAERx1QesQzYrPeBv+xDfcg/gUHLSYO7IaDXRP7+y
	yyYs8K0zHLHw4JjDEQ3xYhNpYSM0lxtbBZi/Y05kWDe+ZdEMiIGGVMCLW+n3Ubs6yfC6VIwPJrQ/m
	nnYoel6/G64Erh/Wrg/5F3Pwr8Z9hBaaFAAbz2ibJOXaraCsAK4pOqGKvpEYH1L8nSi6Kq7+Cu1g9
	h1ozZU+pXzbPxC7UHxgAPZdQcTzMPZK2l5hYWDJZBWzvPcJXT5RN8X5Xh6oVHq3eitw0+3dL44R9c
	ROnzBwew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDuXz-0005Nl-MI; Sun, 21 Feb 2021 19:37:39 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDuXv-0005NM-Jt
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 19:37:36 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11LJWF0a018495; Sun, 21 Feb 2021 14:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=o5sY+nZROQOyBRJ5CflnCg2zTi7JRAy0aPLVhFgLZDA=;
 b=pwWyL0QG6JsJeQlwb4vFf+YTy4CMOYt6+DqNidoYff+8G+xH+fSzpxRq8UyY01bExI3u
 eeeNgT+GMDoFIyu9CzLoAiipb/C8ZBY+N5JwkGqY4rDwEa6HUVRa4xIcy2TT3XFyAhVq
 Y2aZOC3lvbp+ZPMPos0tZUXmqhyc6W1OPd3Wld8mMNFC7miGcEW6/YKCxu/PA3FXET56
 pAV1l5IAbfPpzCf59DHkAII86NSfnQDpjEImai81F+38IbdMQBrZDzqAMIwXP5wLeVlv
 MxToNa6+NHc4sil+A/KvSgu/joGu1S7IXn8Mz2XVfYCKyUcDoR/tb9/5UzSPLvdXo0w/ xA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 36umrf8m74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Feb 2021 14:37:29 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11LJZ7Dw069436; Sun, 21 Feb 2021 14:37:29 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-00154901.pphosted.com with ESMTP id 36ug9n5tf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Feb 2021 14:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8c+Rhm3K6YXiIw3Fw2QKYMUZ/do0oiMwIP9DIvUWfFAFWQ4C7n7PBYR1AXPfyFNFaDW+WxxevZQQoqYuI+NReX/m1RDHfjdgnqSWXYbkltiigzcv/+5oOXABxyLsGDjsyc0wD3d5nIQs8oTYevioMxf0V9+CrdUDIeZMmrl2d0scOqlHilsAOqsBquf34f9Y0djT7fpk1Nn8302IKgV0/GhlqXVcYEMzMt1pjBQ2sTCfdH9FINRYW4/iMFqd0jLS1RnUNfrLCaJOurc2hxb21yLQ05rt96v7a9EK9oJHYqbMsjOo7uWJ/asSTzFV3+NaURPeRaqowKNofgw6kLoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5sY+nZROQOyBRJ5CflnCg2zTi7JRAy0aPLVhFgLZDA=;
 b=KieAxrBrnP0et4E2weGxmx2HULNH2sO0lSLtgmq/7/q3DM9jp4AU5n6N1XlF688cryLRzaQhW17IqXSsYOKl4ZlGi/cpddsngHduXy8Y4AcYwGuky2RISgFinLm4IZGmRE8WMyx0DH2fFMvRj9I64ETzg05zEO0Jw+1OPquHQckmOVc9vC+Gs9dFKthUtIiYAgvUem1WvyfqqxXIRvjsy06d2zUvx8iV/OlNZRC3pqggpl2LseVgWBQJdYzvC4Jt3Nq/fkeS2AnqnvszJ3kHQQmSC2Ad1xwB3gJgLbgfoQxRDY5ow20SMk/u94kOI+oVtodRj7xFFmr6Dh2i/EKhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3851.namprd19.prod.outlook.com (2603:10b6:5:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Sun, 21 Feb
 2021 19:37:27 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%7]) with mapi id 15.20.3868.030; Sun, 21 Feb 2021
 19:37:27 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: RE: [PATCH] nvmet-tcp: Fix receive data digest calculation for
 multiple h2cdata PDUs
Thread-Topic: [PATCH] nvmet-tcp: Fix receive data digest calculation for
 multiple h2cdata PDUs
Thread-Index: AQHW+oCxe/2V259TvUG9tx023am4J6pjG21g
Date: Sun, 21 Feb 2021 19:37:27 +0000
Message-ID: <DM6PR19MB40112D4524285D2D496F2186EF829@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210203230001.18797-1-sagi@grimberg.me>
In-Reply-To: <20210203230001.18797-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-02-21T19:37:23.0414497Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6aad81ca-63dd-4440-ac7b-89805e27b2fb;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e10fa49d-484a-418f-762f-08d8d6a01ed1
x-ms-traffictypediagnostic: DM6PR19MB3851:
x-microsoft-antispam-prvs: <DM6PR19MB3851F87CE06CD645B19EAE28EF829@DM6PR19MB3851.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGsu6OLNXZaDvtXMCX0xytrclvQu8zT0OaVmF/H32iw27Kvzinz0zmlPQsR1UaTSdBpKOzM89yVjXIN/vPDR13ZZIWs33Xs83UNmToNxVt66JutsBWELbv6699uO/1gkRffCcTTLs4K8IwRrqqH0lAUIQXPshmnrds2b7II4FxHFzVL6lzw/ao/knzqq0LN6GEm2zJ0GjJ/BPqjHLHrrShOnvniSMjWejPF1HQiXU5G6krF9/GCLOIk6YNC5OHAiT2Xars/VWPnUE7JDUZ+aK4YXVSwplENV1xgq+mRBfRJ/iY3EGm+Sq9TFZ+OJkUwKk6tHjDDc/9iWzP7QqqQVCmpat7mbhZWZtDaKaGoAUfH6QVuVbqqGPh8vkGhcGtt7nnOv9IhSU7UrT9mYquT0t79Yre7TVIy9Z86GI3EdnD9tWFWOtPXI+vuiH+W0FqnExbM/sqZbp+ONqVJczsAeHId+kr5Lhj6zP5Sk9bIdh9tev3A0SZBOsPLbeAg49rwXM9hMubmjexURshyQwp54yTaQbSphjOlvn+PHSU1iUrxE23Le36AxzEG6a9fnJp3FHzvCO/lZaULxTPXrpJdzchQHQ2wsLd8wuguUpZfw6Es=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(64756008)(66946007)(316002)(66476007)(786003)(66446008)(71200400001)(6506007)(5660300002)(83380400001)(7696005)(966005)(8936002)(66556008)(186003)(8676002)(33656002)(478600001)(86362001)(26005)(76116006)(2906002)(53546011)(55016002)(52536014)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RUFtUWlsS2FyMGdaY0huak5rWGtLemE1K3gxTnoyMHV0L2VoVm5tVExCWURr?=
 =?utf-8?B?YWtvdC9EdFZDeHJhbzJCRXBTWFgxS1cwOUV6OEFOa2xIaUlUTFBaUU5yOGJG?=
 =?utf-8?B?OWFSR01ISWtiK0ttNkp2dnpsVlBxZTE5aDBFcGxFTGhTNG5IYVBKZzQyemhQ?=
 =?utf-8?B?UlBpY0xZb3l0ZlNtc2F3bVJXbHc2KzFnTVZ4R0FiS0NqSXQ3Ri9LUUZTaG1B?=
 =?utf-8?B?dklkeGMyRy9OejBEV3BscGxIcDlzVlJqOEhXd3VhQm1vaHhCNFpmeDhPL0Fn?=
 =?utf-8?B?dkFncnhCMDVObW9WamlNYlREU05jUTdJaUpzeFNtRXVNWSs0NUthN3k1bXBC?=
 =?utf-8?B?ZGVuU29DK3g2NTZremd4cWtoQlFKU2N5am53VVVsOTZCNVdZNjJOL29SVEh2?=
 =?utf-8?B?WE5SVmpPQ25PTFhObjRRVFVpQzd6VG12U0hhMWtpdkRrUDdETCt0SGE5eStt?=
 =?utf-8?B?Qm05NXY3Qm5RU3UybHZmZ1IvOGkrQzRtTjBmdmVRaG8zRXBBQzVSWVB2cTVo?=
 =?utf-8?B?YVk1M2FTaHRWV29FK2d2NnFTT0ZZVWVkUXdvL3ppNUpUbDRELzg2eTdLaWdy?=
 =?utf-8?B?NjN5OWlDZU5sdnllTWVNdUxmeEJ1cTdKMFRubkdJNmdZMkZ2MGlPQUJGN25w?=
 =?utf-8?B?aURoOW4yTElDcEcrdUErVmE0NFJRc01BWlZYaERmd0RGVjA1VitURzY5eWl1?=
 =?utf-8?B?d1p3cnprQnNxMVdudDRZSHYwSXFUVlFaUnFHWXR6YzlpdzdiY1NuNkZXbHd6?=
 =?utf-8?B?Y2l2V2hTQ244Mk5qK0VBRFR5cW1jYjRzQkp2WUZHRCsxYkhEMDBxdytnYksx?=
 =?utf-8?B?b0duNlg1THRWcklqbVU0T0dUdjN5QytkNzBCWVhoZHBaQTk4MG5ydkN6Sm1S?=
 =?utf-8?B?TTVKcUtjc1ZleStWbm92emx3L0JJYWhqY25rNHJqM1MxR3RGOUNraWNDcHpu?=
 =?utf-8?B?MHg3WkdmY0pxaVV0T2lDL1FiRCs4OU5tQ0hUT0Z3QkRmK1FwZjgreXdxY3R2?=
 =?utf-8?B?by9kUmlZWWplbHpHdGlDeEMyYlp6SjRRaDNLSG9tRHZsL3FOOCt3STRiMmRP?=
 =?utf-8?B?WVJ0MldvSWFocnVWR2hLRUErTUsvbzZPUmN0MG15TFRCVFJxdHlkQ0JteWd0?=
 =?utf-8?B?ajBlbzBCRlp1ZmRoWnlGeVdFOW1lV0JDWWdjS2pvM1dCOHFseHM2Z3N6aVVH?=
 =?utf-8?B?ZUJ6WGVSU2xvU3docDJjSnJUTXhmTmJhMGo2UERLZkJ3TEp6Q2xpM3pna0J3?=
 =?utf-8?B?WUxzQS9PNDlmcnYydi9hL1EvTXc0VFc1QzNza3pjSm5ZbVZNV3FGYjVpZmIy?=
 =?utf-8?B?Wk13VjJxR1ZEWmpFOEU4WHdmVG5Zcyt2U2VsaGpvVU55NXc0NG4rUWlWSE1j?=
 =?utf-8?B?bFoxQTVUL1N0d201LzVycXIyRzYvOXJtc21qYjFTS01zdFZJeWV4STUrQkpT?=
 =?utf-8?B?UCtjK1NZRDVnU0FwUmM0MFFVTytSRUhrWHRjWXVEdGVkQlkvYlhFemNJTyt0?=
 =?utf-8?B?ZFByYk16VjR2VWQ3Ky81dEl2RnV3WW9pTmw3NnRtZ0FnMjRUdm95UGs5cWZn?=
 =?utf-8?B?aSt1QnkwazltUlBmWDFEc3J1N3I5WCtXY0d2aldlWmZUbFlCV21aWk52anR6?=
 =?utf-8?B?S0JzY2QvNXJ0dFBjbjJqVDlLdkFDK3NhZDlGSGNaRFFUaG5mM1UvdUxhaVVu?=
 =?utf-8?B?NGRVMkc0ZEcwMFlQUUg3aE0rd2tOc21COElEbFhWYTRIS0tYVEZSMzlIZE90?=
 =?utf-8?Q?1nKF8U30v9Pe0Kv/DTDnbMthufWlLHL78OOdPmf?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10fa49d-484a-418f-762f-08d8d6a01ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2021 19:37:27.1825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vGJ6HKK3rb0bT9qct3Nc5codA8cG4XFyslxU5+XvZ/1ic93y95EuAMWTBtFmpo5xXnqYU/+hmccXlp3beADUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3851
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-21_10:2021-02-18,
 2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210200
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102210200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_143735_781153_52F98026 
X-CRM114-Status: GOOD (  23.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

Can you please explain why you avoid calling nvmet_tcp_unmap_pdu_iovec on data_digest PDU?
I don't recall any other case that unmap is being called on good path.

Regards,
Elad

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Sagi Grimberg
Sent: Thursday, 4 February 2021 1:00
To: linux-nvme@lists.infradead.org; Christoph Hellwig; Keith Busch; Chaitanya Kulkarni
Subject: [PATCH] nvmet-tcp: Fix receive data digest calculation for multiple h2cdata PDUs


[EXTERNAL EMAIL] 

When a host sends multiple h2cdata PDUs for a single command, we should verify the data digest calculation per PDU and not per command.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Tested-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index aacf06f0b431..577ce7d403ae 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -379,7 +379,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg, @@ -387,6 +387,23 @@ static void nvmet_tcp_ddgst(struct ahash_request *hash,
 	crypto_ahash_digest(hash);
 }
 
+static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
+		struct nvmet_tcp_cmd *cmd)
+{
+	struct scatterlist sg;
+	struct kvec *iov;
+	int i;
+
+	crypto_ahash_init(hash);
+	for (i = 0, iov = cmd->iov; i < cmd->nr_mapped; i++, iov++) {
+		sg_init_one(&sg, iov->iov_base, iov->iov_len);
+		ahash_request_set_crypt(hash, &sg, NULL, iov->iov_len);
+		crypto_ahash_update(hash);
+	}
+	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
+	crypto_ahash_final(hash);
+}
+
 static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)  {
 	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu; @@ -411,7 +428,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1060,7 +1077,7 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)  {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST; @@ -1081,14 +1098,14 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
+	if (queue->data_digest) {
+		nvmet_tcp_prep_recv_ddgst(cmd);
+		return 0;
+	}
 	nvmet_tcp_unmap_pdu_iovec(cmd);
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
-		if (queue->data_digest) {
-			nvmet_tcp_prep_recv_ddgst(cmd);
-			return 0;
-		}
 		cmd->req.execute(&cmd->req);
 	}
 
--
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
