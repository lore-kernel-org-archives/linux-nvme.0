Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C106C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:21:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB456197B
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB456197B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uKrOgomG/lAKkpz9kxmLE5SMG0+t9QC/YfpwZMwTC30=; b=LPQdg112XWfCqqzAYE1l1jZX2
	Y1wGh1Hs1u4Lmo7lqiOwbBIn7XyqlT9brnTi7H8mg4gWdwI/NtGKg1pH/NmFlWk7EL29VsgMWHY4l
	ruVhOLXdlu/24oCMfQ4rhju8XEUsICHDVW8nYeSR6w/+/Hk6FDACVv901VFtx9uHqTRJeZQH8uuEK
	aECIVOr/C1hl4+2XZDTiETT2WUvCfAirX985gR3dq30ts/jbTxzudFa79Rd0Jbp68UYsVwdyKFwuU
	nCMbBaoIWToB+WkcELEBT3/aWp2hjAsgRXTMbOQmLVm/KokVLHwlzZ0sgg3dUaL+eyOmp0OV41a9v
	oUwjuAU+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNIof-007q1m-JR; Fri, 19 Mar 2021 17:21:41 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNIob-007q1M-KI
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 17:21:39 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JHJF1q006504;
 Fri, 19 Mar 2021 17:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l8pYUhcATQJddscEN10qWIRKoQ9Ax8ks36Rfg8CmQ6M=;
 b=m22ZRNfgLeEDXf7byuvJwpuONJnaHZkQO04rGQXZIhLQNnbufh85mzEzdLcqB+/rjKbH
 GbhZCkEAKQ9jl7oCrBi+PUUxw7Rd6Je8zBvXneFbTUZOn7EWcEdgjh2ktaHE1zHByQ3k
 Mfk1PVpMFSkznyx46SEB3m6hfC9ppLJhw67tSZGf1MVUWg4ALRClQJmsSOKOwwJoA+j9
 yR8mFB/RzWpiQRCiSC/UAFe9OHR0OD2gCg5k2KphH9GUa+sdq64hNe+kwMKE1HZNTnRb
 I69bc+OrDyElPwwckeyT790JF8Ng/PeuQyUn72BXiQNA1UJjG1FdYDklJNdsY7bamMEM pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 378nbmkrp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Mar 2021 17:21:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JHKuO0156018;
 Fri, 19 Mar 2021 17:21:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by aserp3030.oracle.com with ESMTP id 3796yxq307-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Mar 2021 17:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWingOxH53B6J7nKdS4oM5RKgJA9d68YO8BFbZYesC6Qi1l6KD7ZdX+cqbjPt8BjIvVSqfSj8gIwFeYGAizgJFyaMfiEkXZ4YJhrTPNhDAGDnfbYT1XEVycswnDnUKi8fVWcHEf/4YeSxB8Mkb69zdvdNsf+n/oFDkSuIw2Z/DUJU6fBE7MAKIk/I7JHsFBXxxr1iJwwAnIPKs0nROk9DygD4yxHlrhNGzMN0Pib/4kj6Ppvtu96iQh3pOjnLoVuid85iOvIZvzXpEALYYIz4BMA69c99AaQUyS7sflzEu3YkxBfDxWosPhJVDv/+No2HHyhpb17j/KOerK3SMFlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8pYUhcATQJddscEN10qWIRKoQ9Ax8ks36Rfg8CmQ6M=;
 b=Egj2+oZGxEIFYyIE+xz3cT5stnL7uanYuoV3mS+HUJ6gDRy3p6Ud58Lq1nvi0g6tm8lTPMFqLzUVk6ED5wWgcLb1SuYA/e9I7sG38HPqts0ofwJo5ExVwm+4SZd2O6P5i5eneAp65r9Q389RzVvxIJ9MKkZf6bCahiSHQWUTjinB8zN+kSdGe+Gj4PFpH0/m8Dpd+SnK6AbXn3A0w3iLfNnGmnNphTDjdNusXcgJ5VORijsPSp0bltBxsOwHayM2tC/8nR3p0ESu5juhReL/gMg2vMUHIZnAivJsRHILQq4AV1JI53Voi6NVutfAX1H58dhLuH6IwEN75AwFUDQlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8pYUhcATQJddscEN10qWIRKoQ9Ax8ks36Rfg8CmQ6M=;
 b=CuXlNvmJUgH19qhq+nC8c5e1QoS1ZeErolTW7wGmzsk8mLQNJIPSctGToEF5mKxCYQXl3Dt+csZcRjH8Dq6LIevuTEnQdx+H0wp5n0uOxDVG2EVHAb3I8Qw0+fJ8npLdYEnX2voEnOlhTatJeFqWOKp4V3/UckaVuqQEuwSkrJE=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by BY5PR10MB3940.namprd10.prod.outlook.com (2603:10b6:a03:1f6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 17:21:23 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408%5]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 17:21:23 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgCAAAaogIAAHgKAgAASy4CAALnSAIAAjooAgAACPQCAAB8UAA==
Date: Fri, 19 Mar 2021 17:21:22 +0000
Message-ID: <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
In-Reply-To: <20210319153008.GA14280@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [76.176.17.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac135cb-68bf-499d-e04c-08d8eafb6b43
x-ms-traffictypediagnostic: BY5PR10MB3940:
x-microsoft-antispam-prvs: <BY5PR10MB3940593FDCC85B7E64ABE358F4689@BY5PR10MB3940.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QW2xfmW8rH+lBbM92436Lh9vOJanbS0ldLzAQzqR6Q1WaTEoFgwKtb+inQLzix+2qpjCaCrwrw55tyh5FTPorNc6ZET68swdO1vX1q4fPZd2FqEeh6/mVCeJM9cBpmgQXU8jc6QhKREWxwzgYc2W5yFvButANyBooiNqX2HFtpDvJxGQu0IIdUplrpT0BSjvPbeeH/s7jBp9CcujnZBmvCrDcVvBEN0xgwhYr4S7LDuM9bzNEXSWFt1Bqr41K8tJRCyXPq5z1IqJMsF/wR1NZVituvOV8P9Wo1OHs6Wm0Br1NricSl3ZQyBrqlevu/wJSJttFEkF+gjkcy5uPhdE8myo7YWVUdHDANVgIxFGa/7WceLSvjH8jbSCIF04MANIZGok8N2lXfyQOJtZu6xRs174m08ZufdHCb2oftOZpG+y9SWYTuTJj2uOWzBTyMW2Ksc2ElA5Bp9qE28FbrY+7k64crq1KNLiOLwo5bFk2rOt0NyX6rRgolUjn4OnoFY96JUUvE8crCNuUfu+cSL7Ho+hvpjXQ53QZxKeTGVeyWLoTufSDxhj2yxYtfbcIrmP0KyL3+BIz/FfG8gXLIDxeV3FENuSSv3DEj0XFb/O575YjqQu52eYubTrm3V4p762EAV8hseaIHRs7mJU01KzuvuwoWDb4swDXTi2C2NcNxPcvaxhkvK2cAeHn6cXTxe2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(4744005)(6506007)(53546011)(6512007)(186003)(8676002)(316002)(38100700001)(6486002)(36756003)(44832011)(478600001)(6916009)(71200400001)(86362001)(33656002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(54906003)(2906002)(26005)(4326008)(5660300002)(8936002)(83380400001)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YTY4V2ZTZnVMdUgzMHJXZGRFNWlTbDJJSG15aDUrOEYwWC9wREpSaERQSGlv?=
 =?utf-8?B?MVhSQ2ZzWWRSYjExZWdSeDc0dzRNMUQ2Qk4yMVdCQzBRTjlLeFRkY0JQT0dD?=
 =?utf-8?B?OWFmTHU5WGZhRER4UHFCaHJuM0REWUVGVmRPNHBzRVdKSTZIdTM5THZVYng1?=
 =?utf-8?B?cHprZXN3WjFMTzdrTThLZThreXBIUXNhMnpRWW02TEMwS055K244WkNiUGw5?=
 =?utf-8?B?QzYvUkZPQkxKTG1tM1lsdS9XYTFTV2JqQWUwQWVSQXJCU0dsYWtlZFdKNE1K?=
 =?utf-8?B?bVRyWmIwalozT0lyOTRjeElZVm1JNDNFdE9oQ1NYQm54WnJqZXcyS2pLdFly?=
 =?utf-8?B?Q2tzbHBiWVFZbUV5NERDRkNhaGxIYW5xbWZvM2l3RStYT2pBb2pmYnpiZk1x?=
 =?utf-8?B?ck9XY1RwYjM5a3JQd2pSSlFnd0lpR05VSDMzZm1CNHlRdlhaUnpuSzBFMGlp?=
 =?utf-8?B?TFI5YVE1RHFSYmpsSzBReTdTMEt4V3ByL0ZFanRvbWxrUmplZDl5VVlDc1ly?=
 =?utf-8?B?bGZvZlZpZ1hIdGxxNFVwQ24wODhvN1ZUTjNBWnlXcnF4RHRtcERZSGlDWXBj?=
 =?utf-8?B?UnFSdTVmK0U1Q3NOMm9nZHFabHlzOHRrckJTYTd4T2dtOEFiWGx4ajJoZGZV?=
 =?utf-8?B?dmdwOHllcXprdHM5MFhMMFJpaGRpWGxnY0o0R0VCZnl4UERUZnlRd2Q1US8z?=
 =?utf-8?B?L1htcGIxTFVUVHVZZUloMGVzSHJ1bWQ5elRpMUtOSWorM2pIVk9jV2hTRmMz?=
 =?utf-8?B?T09la1RVb1lpbytId3p2bmo1dmZDaGJpekM4SjNyUzhtdWlpekF1NVJZUFAz?=
 =?utf-8?B?TVd4Z2FuYnpjajkxdU9SZWZZTVU1b0krTXBSUFJYRVRNN1hxODlqc1NuK3E4?=
 =?utf-8?B?L0FBRklYV3RyT2FuWmFTdnBTeVBMc1hicGdIdWFZOE00TTl1dDdjNDdBYjJI?=
 =?utf-8?B?L01FazdHbFBCUGdIVlNhbTgyZllVamlKLzd5RG1XSTJ1cDZrTGRZcVM1Wld1?=
 =?utf-8?B?R1Rvbmd1YTl0SkxEeWZ2THpuRGJWekV0ZklOTk1Ia2VCUjBxd0tWbWdoM1pJ?=
 =?utf-8?B?TkQzMk44aVBTZ2cvQ0tRMC8zTEI0YTdsVFFvbVNzVHVjTWhGR2R4RlgwbUta?=
 =?utf-8?B?eUEzeXhocytLSzc4OWg1V1JqWjFIZEh4NVk4a2dydHRJQUhuYjJaTmQ4UzV2?=
 =?utf-8?B?K1ZUYWdYeDZobXF4VWZuSWFtdmErV0M2OVVyQlJ4L2wzelhzb0diSVJEbTZm?=
 =?utf-8?B?WGVpUExwemlKQXMycWJ1L1hlOHJMTzBNcCtRWE1TdUFTUGUvNmc3dkdLSVNF?=
 =?utf-8?B?RW9zbTRjNmNJcG0yNU02dEhPdlp1bzlnUU5Sa21RMjhhSG5qeHZPOGJoSWl1?=
 =?utf-8?B?ejYzTUZiRDBpbDkzMHh6eU1PU05URkdhM1R1elhYVmVLMHRrQXZXM2JxLzVk?=
 =?utf-8?B?YXVSSUVFMUlhU2NTdVFwYytEWEJ5dTVScy9OU1RaOVV6azhpcUI5Q0IvYVg0?=
 =?utf-8?B?VGVWOEFWSnZhVk9ncDBBWjNpUnRvY0pobDdZbFFGVlBVYTBUd0xQMWhSbldM?=
 =?utf-8?B?RUtNMGEzbGlsdUNwNi8rL0l1dmhlNkh4aW5OZTFzekt4NVhIMnZTOWUySDhw?=
 =?utf-8?B?UUdMaC9zd1B3NklnazdoaWlWYUtXLzRULy8yN3RIa0xEbWpDd1l5VmExZ3Z4?=
 =?utf-8?B?Mmova1VYajg4ZitWZzcyYUFuRU1nVzZmNW42anQvZmVOSlcweW93bUxVUTJD?=
 =?utf-8?Q?WXNZd0DYtUKY84tVZ0oXwpwLPCBqu6MUf+qphAA?=
x-ms-exchange-transport-forked: True
Content-ID: <38E5D0AA98EE344596F3058FC34EE8E1@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac135cb-68bf-499d-e04c-08d8eafb6b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 17:21:22.9599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bep9XEwKe4vfZDtcnhpYqeogRWuh00SAT8Rq5WLdC7X0dcVu+A+liyRcKng78cF46WYFlqvJdOmmV1YvENw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3940
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_172138_038888_143B88AB 
X-CRM114-Status: GOOD (  22.62  )
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

DQoNCj4gT24gTWFyIDE5LCAyMDIxLCBhdCA4OjMwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIE1hciAyMCwgMjAyMSBhdCAxMjoyMjowOEFN
ICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+PiBJIHRoaW5rIHRoaXMgaXMgYSBob3JyaWJs
ZSBpZGVhLiAgVXNlcnNwYWNlIGhhcyBubyBidXNpbmVzcyB0b3VjaGluZw0KPj4+IHJlZ2lzdGVy
cyBldmVuIHJlYWQtb25seS4gIE1NSU8gcmVhZHMgY2FuIGhhdmUgc2lkZSBlZmZlY3RzIGFzIHdl
bGwsDQo+Pj4gaW50ZW50aW9uYWwgb3IgdW5pbnRlbnRpb25hbCwgYW5kIHdlIGFsc28gb3BlbiB1
cCBhIHdob2xlIGNhbiBvZiB3b3Jtcw0KPj4+IG9mIG1pc21hdGNoZWQgbWVtb3J5IGF0dHJpYnV0
ZXMuDQo+PiANCj4+IEkgd2FzIHRoaW5raW5nIHRoZSBkcml2ZXIgd291bGRuJ3Qgb3B0LWluIGlm
IHRoZXJlIHdlcmUgcmVhZCBzaWRlDQo+PiBlZmZlY3RzLCBidXQgeWVhaCwgaXQncyB0b28gZnJh
Z2lsZS4gSSB3aXRoZHJhdyB0aGUgc3VnZ2VzdGlvbi4NCj4gDQo+IEknZCBzdGlsbCBsaWtlIHRv
IHVuZGVyc3RhbmQgd2hhdCB2YWx1ZXMgaW4gQ1NUUyBBbGFuIGNhcmVzIGFib3V0LiAgSQ0KPiBk
b24ndCB0aGluayBqdXN0IGR1bXBpbmcgYSByZWdpc3RlciB3aXRoIHNvbWV3aGF0IGF3a3dhcmQg
ZW5jb2RpbmdzDQo+IGlzIGEgZ29vZCBpZGVhLg0KDQpQcmltYXJpbHkgUmVhZHkgYW5kIEZhaWxl
ZC4gSeKAmW0gcmVhY2hpbmcgb3V0IHRvIHRoZSByZXF1ZXN0aW5nIHRlYW0gdG8gc2VlIGlmIHRo
ZSDigJlzdGF0ZeKAmSBhdHRyaWJ1dGUgaXMgc3VmZmljaWVudC4NCg0KQmFjayB0byBudm1lLWNs
aSBzaG93LXJlZ3MsIGRvIHdlIGp1c3QgZXhwZWN0IHRoaXMgdG8gYWx3YXlzIGZhaWwgbm93IG91
ciBzaG91bGQgd2UgYmUgcmV0dXJuaW5nIGdvb2QNCnZhbHVlcz8NCg0KQWxhbg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
