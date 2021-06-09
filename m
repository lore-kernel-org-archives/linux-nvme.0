Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D0C47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8E26124C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E26124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9LJGOU6vaUlHg63XgygRS6JbproDoi6bKMx9zqSWT0=; b=GfNyCodyrrUPHa
	VVFPzoJJKWWjO19KpB+M80dX5hCTEUipsqDKCkDctflE8ksG7DQsu+N+XfveHzbxWVorPryWPkZ1z
	gMtQvnmdEJfh4hND5Fhl02yJMOvCmGqQUzDAsvGetWQ6NWLrqYnisB8/74PrSWqKJD7Y2fTsGo9wf
	hGGAZBSYdYOBnm+OJdkdcfwj89H9Mgo+EEv57TL5wN6aFQV40cOm06NTT/k0/tkh03KMcTKd9UrfO
	Y7dz2/vryqZbcsapPb/Uw4qL4VETVNTR7pj8xe3qPmcVkr7pj5Uq21BBInq3D4Rq/j8t6HMQzyzEP
	ZZVFyzJkJVhtaIa5NF6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lquQ2-00CdpI-Ew; Wed, 09 Jun 2021 09:22:38 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqtkZ-00CPpa-6R
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 08:39:48 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1598bs7Q014834; Wed, 9 Jun 2021 04:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=znI2feB5QapMIJF0C9tB+HXEZrasH7VHjtjZ5hhf3no=;
 b=AEybQrT3fDpu+oIp5jJ0gHJcDsCbcyk0UiWpIYfVrCtjP/O8LB/v8aaM2ZtO72P5IvTD
 PebmJEybRQo0JIwa8UsHVs9ipTjeZ7wwZR1PCIPj91UF2W97wrb8Ja29CJqw+dc3TBVi
 W2PZc5cvuH2sy7ihT4ULkKscmBMpuSz+8aa20fdXjCk2MZxxJunWEoGLClK40N1rEOXC
 zCjZzLHpHXnF5nuC75Ve4+geKbyp6truhMV4UgNRVHT+HIWE+NED88WchmLRLDexmjTW
 xhUEByIbOSb2w/IXNbstr3tR8edIxOE6nUB2WkXPhjzvHnvjXG5CM3U/2kuFfUftk91g pQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 392rdx8f3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jun 2021 04:39:44 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1598aIC8066667; Wed, 9 Jun 2021 04:39:44 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-00154901.pphosted.com with ESMTP id 392rq81q4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 04:39:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj/lLO1fwCA97xq+LGOIxbjbeggfCEoMJqnw5rFRGiEk3MD+AVviFJzYEzn1thQGzIiZ+tCRpZQsD3jXX/L0Nx4HWGetP0x0dksgrmGRXfic/Ln1aPFFhPEKvCtG35BiUpVn9rChwa8/nEDpzdtnVobgi1QNRSJeHGFRdURjQ7SZDr7NAlZwNaBjplNvsAWXAxO6PjfJiE0/XwhRaW9ENC4efjbFPR5zc+RThGKS1afPHe5EjGfCjzuFUJRgDzqKNA+1joxJaaDQ5qsnvvlw6iQgLtfqz9bcPme7nq4kBTgpDFVOnv1S2PQarTzxA+SbsmZHZKo9+8xrfRiKP3t2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znI2feB5QapMIJF0C9tB+HXEZrasH7VHjtjZ5hhf3no=;
 b=mKq/OCPbVnqyerODTrY546Fw7MOo8mfUegEOsFeXv35VQNBsPPof+A4Fs6TOS2xFC0YJykctB3hi+UukUP/DwKouMM4YaXobknt0UKFM2Yg5adix5J8gnABEcvrywre2XiXosmnVG7odRkHRMQeKK/hG+30VDjmpdwVZxDcBZTPPd2adG2oHVnzU5PpGTEIggXspOhSihRKuXvgF9hFcQG0UycO2Cb+ksNPUCuBajHEpO/xv/rPWk8temNS8Zu4wt6sJMH4wecvaLQGI7lWYQK2hupL1//23BXbCD7uFj/om8hqH4Z5y6lYzFVMJWfCiz69d9uKVW/7r8PHQK+gciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW3PR19MB4266.namprd19.prod.outlook.com (2603:10b6:303:4d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 08:39:42 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 08:39:42 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOgAUVC6IAAEPeXkAAAsPoAAAD2GkA=
Date: Wed, 9 Jun 2021 08:39:42 +0000
Message-ID: <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
In-Reply-To: <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-09T08:39:37.9138225Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=471286f9-37d4-4b87-80b1-b80e4e04456d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c6c1352-7442-4798-c17e-08d92b222076
x-ms-traffictypediagnostic: MW3PR19MB4266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR19MB426659D2FC23D04687BB3C18EE369@MW3PR19MB4266.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahsA5Ps1DFrV7veYP6W7PBmMAEId+dFv9lpy+m88llCGTe71qv923TLylszOO0xFbLtZ4kB5xnN8snmWrCQzrsyqMegNvHbXtPbX5X3WStRNbaMevZbvBWbvVUwpF9K0l3UlLkH5Q4QSsS6Csw53VDYu5OkHl4AgDDCsCh3KpQQCPSuRYMXd0lXxBYG81iNDuULd7RvQuFuuahUKyQoGT+ZXaTA7V4lb6D1GWhtXsrg9OobF53pXGYYOoRs5IgTZcPT9YCBsvrLXkAaUR6xiq6hjTuSwVVK5l08bFdTIybR33/l5UTD9NgW7E7CAYLw1fQR1MqWzr5Tsbb178PQ3qu98tE8tNGxfhyhhXqtUKAimf8j9K/AOnzXG/w1Algncokx7fZEWgTLMko5IzQoJ6BDLhPRjSxvhr3yYJFYzV7xSVjjKxotnl6EkPDNY3js730NKQo5wFmo/ZdfV05Jbvxv5+M08viZO4bGvcpQCDEUiK2xIsHIC0hNVM3vzseBTLXhf83Nf4xgnIxkJykhzF83PMP+mqZmvDAjmCsoxB3BkDToG/u0A9pzud2eB6g5dLRpKWkgT19agOxWOBeEbm7muXkYEEnlEjUxlRIz/ZVY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(110136005)(66446008)(7696005)(54906003)(66946007)(66476007)(76116006)(5660300002)(66556008)(6506007)(38100700002)(64756008)(52536014)(316002)(786003)(53546011)(122000001)(55016002)(86362001)(83380400001)(71200400001)(8676002)(4326008)(2906002)(478600001)(107886003)(26005)(8936002)(186003)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3FyL2w4ZDZ2RGZ6WmpGZWFmYlBwcWxtcVpscktWZVBZdkp6TGs2Ui8ySlBm?=
 =?utf-8?B?QzNMZTBaeWR1VVZMOW1zekNaa09aemVLeVpFRWZDeGlMVDdTYklYRzlTMHhy?=
 =?utf-8?B?dTU2Tml0alRXUUNkUkY2bXJSS2VGSlVEY1Q1TkZnZ0xnQmRHZlBnZ1NNMFFX?=
 =?utf-8?B?SnprcUFhZUJ1TTdMYVJwY29kR1p4VGpsK202ckRLZVhLMUhvTE1OUGUyWnQy?=
 =?utf-8?B?VktIejF6d3k2NFNQcTNXMXVxS3RkSlZTb3hEdVRWMjNaRjF3d3NYem9YK2F3?=
 =?utf-8?B?TDBGVzcxSDFlUk9XakFoL1RyL3ZZaDBuVFBZelV3OVFNTUpqZkJnRWFOQkp6?=
 =?utf-8?B?RkVKMUNLaHVQem9mMlk1RTNKdmVNalZRU0xYUm9nSWVEUUszVE51R3c5WnFE?=
 =?utf-8?B?TlpvazBHZG94Y1loeit1aExCVHRub1lvaW5OY0x0SkJSQXBDQVZYWmw4VWo5?=
 =?utf-8?B?UDI1ZHVndmRKWWttcXVXZ0dCeUQrODMyMGxzbmd3NzNmL21TZFpIQjBmRWFo?=
 =?utf-8?B?eFRuNy9CUzRMWElHa1lrN3NqZHc2UjlCci9zWHYzTFNsTWFIRnBjeUpqTExr?=
 =?utf-8?B?dEdIbGFyRHNHVG0rY0hYTjZublBzZlpCL3MvcDl1L1FzRitwOGdIaVI2UzJW?=
 =?utf-8?B?RklvYXdWc1J0cHdDQmcwcUpEZmdXSHYydFpVUkpvWWZkSzhLV1U2WEpDOTZS?=
 =?utf-8?B?Zi9hNzg5N3NPZzBmYityTll1N21GaHNyaVRJN003VVNLdWdJanlGVFJSWlZU?=
 =?utf-8?B?ZmRUaGFjZ01wenE3ZERWR0dkcHRyTG1LUW42TVIvRndRZXZMN2dZbDFrQXI5?=
 =?utf-8?B?RWNtSHJoNmYzbFFuaEFiNnNjME5SMk5Ra1hZWmFFclFFdUI5eC92MWgvWFlj?=
 =?utf-8?B?S09iajdwMkRFWlFvaUVxYmRjaTBqMlJiRHRHSkNjdDQvNmpneG9tRzhOOUxQ?=
 =?utf-8?B?SThEVGFRaEh4U0NyYTFYWUtBanNKd0p4ME1adFZmZzJCaE5LeEoreDNMdWdo?=
 =?utf-8?B?MjFuc3I4b3QxSnA3MURxQ2hvNFZMZEgrOHQ1U1pMNWVNTGFYNTNFVG5oa1Js?=
 =?utf-8?B?NXYrbnM3MkdlTFNoMUVxai9NYnVjY2xXeUhxaGErVFVjVkJScldRVWNCUVZI?=
 =?utf-8?B?dnRTZ3JqZnpGUDNpamdsd1JocXQ3ZnZZdGpEMjhsZmdWRm5aZ3ZtVkttYndD?=
 =?utf-8?B?N3BKdDljNUNDL2gwQ1p4L1dUUjFDOFJsTWswOWpZZDRRUE1zQlVpazh2TUcx?=
 =?utf-8?B?ZURMTnZGQkY0cEZweldnd2JpT1E2VUNsRXVOdmNXSEYwcnk5UUx0QzdMOGpt?=
 =?utf-8?B?OUxzdDNDdUUxRmlFNlA3Mk5mVUxTa2tmOUFHb0YycGZjNEpLbWIwT2xwcUFI?=
 =?utf-8?B?MU1nYThhbmh4MjBDTGFqSDgzZC9MN3dzV0xMUnJLcVpEbWtZdEVja0JiQlpS?=
 =?utf-8?B?WjBWMXZvNlRNNGViNDVDc09pTkpwR0FLTUZxU3V2dlhiSjI1Rmpra1JDMnJl?=
 =?utf-8?B?TVhKZjFJNWMyMG5NUnVoT0wvQVZtbkZiUGphUFhxK2U1bU42SVg2eStXMjlO?=
 =?utf-8?B?bnRiU3RJbHYrNXZGR21BblAzZW1TNm9UUE1SVzRuTnZDS2Q3b29TTnV1dDdu?=
 =?utf-8?B?NERySzFtODZCd2hyNWtiMnc2R3NTdlQ2dmRjK2JwRU9FUHllVG5vaVM1RlRo?=
 =?utf-8?B?ZmcxeVNDU2NxelhPaVdsek9WcjR6SDdwcmVUL0VDa3RhL1BJd3hzTmlLZXFp?=
 =?utf-8?Q?LGP2YHPBhfEu4s9PNmmzKtGqe/hy7WWzi8zU6gz?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6c1352-7442-4798-c17e-08d92b222076
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 08:39:42.1987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMh6uQvBq1MOPPX+3dZEDxkRGGPtyp8PDEM1Dx0cUAt0WlyLhyEhBziFf1q2XPWkkT0RaN4e5DF2kTlnvbEUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-09_04:2021-06-04,
 2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=979
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090037
X-Proofpoint-GUID: 2ZIeCIidlugEQoxv7kKNUDr-epn53xss
X-Proofpoint-ORIG-GUID: 2ZIeCIidlugEQoxv7kKNUDr-epn53xss
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_013947_333885_0F97E34E 
X-CRM114-Status: GOOD (  22.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Im not sure that using the queue_lock mutex ill help
The race in this case is between sock_release and nvme_tcp_restore_sock_calls
sock_release is being called as part of nvme_tcp_free_queue which is destroying the mutex

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Wednesday, June 9, 2021 11:05 AM
To: Engel, Amit; linux-nvme@lists.infradead.org
Cc: Anner, Ran; Grupi, Elad
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at 0000000000000230


[EXTERNAL EMAIL] 


> Hi Sagi,
> 
> Indeed RHEL8.3 does not have the mutex protection on 
> nvme_tcp_stop_queue However, in our case, based on the below back 
> trace We don't get to __nvme_tcp_stop_queue from nvme_tcp_stop_queue 
> We get to it from:
> nvme_tcp_reconnect_ctrl_work --> nvme_tcp_setup_ctrl --> 
> nvme_tcp_start_queue  --> __nvme_tcp_stop_queue
> 
> so I'm not sure how this mutex protection will help in this case


Oh, well iirc we probably need the same mutex protection in start failure case then?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index 216d21a6a165..00dff3654e6f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1548,6 +1548,7 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
  static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
  {
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue = &ctrl->queues[idx];
         int ret;

         if (idx)
@@ -1556,10 +1557,12 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
                 ret = nvmf_connect_admin_queue(nctrl);

         if (!ret) {
-               set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
+               set_bit(NVME_TCP_Q_LIVE, &queue->flags);
         } else {
-               if (test_bit(NVME_TCP_Q_ALLOCATED, 
&ctrl->queues[idx].flags))
-                       __nvme_tcp_stop_queue(&ctrl->queues[idx]);
+               mutex_lock(&queue->queue_lock);
+               if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+                       __nvme_tcp_stop_queue(queue);
+               mutex_unlock(&queue->queue_lock);
                 dev_err(nctrl->device,
                         "failed to connect queue: %d ret=%d\n", idx, ret);
         }
--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
