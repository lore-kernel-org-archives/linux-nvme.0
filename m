Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFCC433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 18:01:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045E961A2D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 18:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045E961A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T4vm9Ow0v60+cxekiWeXkuU4FudmW0eV/Zc7wFAbgwA=; b=DDzBT/hxddh2d1dF4GWdIttJv
	T3oK2COMLvturoG59H1quNISsPET0w/+yf68Q0JUMbGPajSVrDebiIaozGzs/jhvD843ktYFcOd1k
	kfVQOM8MHn9M1ueGkIHub0rzEs84iORQ1gGzIIm36e7S26mDXxd+gyV6lmPZYYqw6GV+aZU3QEJxw
	ha7gJXW32sBmS999OSBhCiCosd/hWQwlWErbsxHYc1YkoDRMvpA0WWPBB6J05DlqUzPEldm7Vv1Ou
	Y9OLuE9mY9iZ5OpnP/GN5AzkdbHSQ87a5EPJl3jufXJUXsTTQ8UaIw7w67JERlImcs1EjyMagxsy5
	zDlYcqs8A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPqlO-0046OO-Oz; Fri, 26 Mar 2021 18:00:50 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPqlL-0046NQ-81
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 18:00:49 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QHuqer028213; Fri, 26 Mar 2021 14:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=XeDmG0FvcSweviLBwsWtVvmyXsb35GY3lYZKV4r+4I8=;
 b=plxTiFtrjZq2/HqQW4gJ5OLxCo8tellt+VYtEKdlrI8vJVPcj0TZqxHZK+wMJdlbld0X
 AYHYBuD0MGoOvpCbQxz+gyUxDdi0ooYJ2rlz3yCudzVfxV/rre3Hs3TRkUGGjPeKthNn
 eeXUIM4Lol4Vgkl/wANL3e+eygFhkeJFeSoD2HJcBme+xSXjW5W248OH53/BsPK3Fj5l
 gMVzKzRcJj3DMNiL7IEml8ejYkflKwKw9dLVOSEtwKz79piz1hxaLT4NSapwCwJm9pYI
 E5NRokhGblN2K0NNojOTH/x1JF+A1cOb21KwOMrZuXAZ7jkpYOMJqaVYRukgZs45Bvg5 XA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37h12h3npw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Mar 2021 14:00:39 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QHxQ83045053; Fri, 26 Mar 2021 14:00:38 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0a-00154901.pphosted.com with ESMTP id 37h13v6qxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Mar 2021 14:00:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR8olgDDsN3JHlPUU9RsPG+hH4bSFemisAvJoo+v2MsPLIfB8rrKux0mRnNnSB54xmWRvbl0GfTdT7nkTsO/QFhJNqZzuF1XVsyBdWV0WJMJUMBWH0A5Xhmfqzz4oEUMinExHL7zNqKOLHIYbgg8uJrE8GcTSf9x76rAYGQQzVBNRzI6hgsNLUwPYLrNGm2dZhPmY9pyIMzzCM7Vmh2NdHseoHvBnqLvd7kaK5m9SILbtMSnyra9KbgsEOAOqKbS37yzqyRjnt6J1YznVyuUW/+FEiVpobvDval2RBwKo+oP25/6T+I2LwhyrPVqdm4UQjRdkTsL2RUgXni335Jqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeDmG0FvcSweviLBwsWtVvmyXsb35GY3lYZKV4r+4I8=;
 b=VHKNmu3XmlZVqJvFHyLL8yBHiEFmAMjlyuLzyqqbeLHS1EGfyVUUvoqbluP10G8cd3AgVGDKPmEYgfHQetOyway2v9IuxyLP+Z1CrrGkpwqmaE65SaAayBeL9ceUL5g3fBghk1rYDUsDNL7hJoGqbRp7GKyJvGLeT+ekhCDb0TlfBE+XBf/wWNqxpsthyYuzx9nLDbd4S+urDZ4uphK2unxZ6ek5OaI1xNxFGK9x4Ok21riB9qByaqphDLlsabL3lthuOhPwFueIQQrfs6TzHJX9fmMSHFCPMWHPhaQQbhaGggRYyFtyVyeV44QGLLBE5BbxLpq29J6qrRUg0Jj7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4327.namprd19.prod.outlook.com (2603:10b6:5:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 18:00:36 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 18:00:36 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXIcky/f49j1KIYEu00rREtL9RJKqWEW0AgAAAh4A=
Date: Fri, 26 Mar 2021 18:00:36 +0000
Message-ID: <DM6PR19MB4011343E6FA2ABAAEB219D73EF619@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210325224952.18311-1-elad.grupi@dell.com>
 <20210326102636.55949-1-houpu.main@gmail.com>
In-Reply-To: <20210326102636.55949-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-26T18:00:34.8973323Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5317b8cc-875f-44c4-8095-a40e078f957e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 644c75e9-24f0-4d70-9dd6-08d8f0810f22
x-ms-traffictypediagnostic: DM6PR19MB4327:
x-microsoft-antispam-prvs: <DM6PR19MB43272D7FFC4BD3AC3FB2F960EF619@DM6PR19MB4327.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrVvOaaKPouesLI+cqWjFl3wgvhqNk6iY0dyCKcTU5I8kAWmvCls2Q9fOrlvXGVhcJzrcyhLr+IzNuY+5pmUFvgF8UWMaf48JqY3yZb/yibGyF6rWatGtayLmwsci2fbX1gkfNjpfn3KR7i24ZX4bSeXRP+zJfTzKsrOZTz1rBriVOQgpsZv/ydP7YYstjExxNc138u2bzs0jPNPagic4/HfCNuLLu5j4ieaXq/jSe7j4+QoIoECqXbrQ5pQ7te6GXom6ULxzj73flPmsQ+vZtAHjNAkWQ0Gxg1lahNTvaYmgw3ImD1WOAL2GXr6hjk+UVRj8XSjz2lrjqhW7qfn3X3GdqHRQY/Nqrpj/spMkArl9hfQbJ16q/QhjeFRBnULOXJxwYTHXueJ8ZiF19xCJdGOIaWD1XkME/Omk77p45VQmJHinAC5NN646AOjW8HVCgbqKnlimSmejjJRGScl1v9dVSr2t3D7m5MSqVugBoz3rcSChyPvEfJDORFokMRoQY5NMpYwP32k8xjRiJdal0rHz0cYWdf7TPg/xkQzUPv45//UwVIaA8R8Ju2j3K8At3xmNKD/P+2EwbN9GSSfgpzEGPMdXk7UFkwP4xhAF/DAmNvCXcDmDWYgtEpN04FuTYfvvYFkVVKjABkPzS6nt+/u4Q3kEdxiyHS/TcW4OMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(83380400001)(786003)(6916009)(8936002)(316002)(478600001)(9686003)(71200400001)(8676002)(5660300002)(54906003)(4326008)(66946007)(7696005)(64756008)(66476007)(66446008)(66556008)(76116006)(6506007)(52536014)(2906002)(38100700001)(186003)(53546011)(55016002)(33656002)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?M2F6SDZ0TVR5aEwyQmlGSTBiR1F1eDJpcGh3T0pjcjV6WFZGWjQzTHVjV2cx?=
 =?utf-8?B?MzJqNnMwOG5PRHpsT0RLamdLcXA4NzdsMWNkY2Jhd1FnYmJPN2RSQ09zays2?=
 =?utf-8?B?QlRHaG1DTnQyenA0bDUrOXZYQTNiOTJuYy9BWThWcmNDK1ZhKzZiTlA3ejYy?=
 =?utf-8?B?eE1xM1g5Mk9Bb0JBOFdQQUc1WmkvcTRkMkxES0RNS3Q2emJiYTFUbHhCQlZa?=
 =?utf-8?B?RkNiN3ZZa1lCQ1Juc1ErTm94QnBxZVg5c1g3UGFxZi9kZzJRVnlHcjNuWURN?=
 =?utf-8?B?ZGo1VVJrdU9mMitXWVpKay9LeUNoUTFxSXRxa2dZN20yc0t4ZDJadjVqNVpI?=
 =?utf-8?B?bUhZOGdHTnFYZGtxb2k1WlhvYm0ydGg1aU5NQlFyclpPRHB2bzU5U1hvV2Za?=
 =?utf-8?B?b0JMMnZ2MUJIeHpuRG40MUhCdWpYOWdKUXloVHZlYzk1UEQ2RzNoRE8yZElt?=
 =?utf-8?B?L1FsYlluZjBwUU1QZlR2Y05FdTczUmM3RG5IZVozSjNjRnhoUzZFMXNuQ1cx?=
 =?utf-8?B?b25IanJGMVQyNWFmODRodXBGMVdSUUpkbkxnSUlhRDVHUGMxKy8vTUJmOFRL?=
 =?utf-8?B?dHBBZDdMZVhLNVRzVXc3RFBrRkJGQ3M3MjRWMGFGZTRoLzhyMXNBZGJFbU4r?=
 =?utf-8?B?YjJ6bzBtcXVXOWFwd0NyWGVmTCtMdEIrSGpwQjM1TG5TUGtiYjY1aVZSc2hQ?=
 =?utf-8?B?akxIeGErREJkSUluOFFteE01MmdMU2FMZmFpTWNzSzZMdXMya3NQVWNtWTJW?=
 =?utf-8?B?TFRsQmd4dEdaelhDRW8xazAyWldHZ1NnUWxZZTI0VFZpd3VnQWVFazhvRGNn?=
 =?utf-8?B?SGJZV08wSk9URzBjTkFqdXlZSXAwNzgzUytaZnZJOVB3NUdac2lobjVrS0I3?=
 =?utf-8?B?UWd3K2FTOGZHbzN5emNEYWdRUWVXV3h4MzIxVXNkYnZ3N0M4K0FFb0V0WFpJ?=
 =?utf-8?B?QmJ2dmc0dC9ITjQzckFzVGVKR09td2JOckN0VWhKT05DcEhCT3dNS0I3bExX?=
 =?utf-8?B?eVovNmh4RzY4T3VYTW5mS2ZTYWdPNkwzdVhic1lhWDBkaXQxejROTFlnVjl4?=
 =?utf-8?B?cG1qYkhCUXlZUm1uQ2tBT284dit3SDh0WVFvVmlGQlIwcnIrZzB1L2pFbkFO?=
 =?utf-8?B?c3BSZVIvN1lPM3J3dkRvMk93K0ZtTGNIbTRBbVRXeE5od3hkT3ZZUFZiaktm?=
 =?utf-8?B?VkpwMXlRMm9iNTB2Yy9WM3JiZ2VTWHFSeXFDMmEyZnhRMngwUjlkaDBWQWY2?=
 =?utf-8?B?L3RTNllwSFd1NFBkTk52UGV1WVZFNkV0N3NUbUx4UU5jWGlZNjNjZEx1Vmpy?=
 =?utf-8?B?QlpIaDkyd0NqbGZxYjZWOHJkRUxDU2dPRHg3M2RhNHNkUUNqUTRvNmdLOFBV?=
 =?utf-8?B?U0gxNDVVT0YzaEZVTDBNTGF3M2RneUxuaXA1S0ZpTGFSTGJ4Vk83ZDJkVmk2?=
 =?utf-8?B?cTJSVXR4WGtObkkyZUtpTlN0SEMwRWVOR05iZlltSzVpamtvaUcwdWF5elND?=
 =?utf-8?B?WDFLTjBiNzFWcFI4bUFVVXRsblVFcUx5aDYxOHJ5N3h5bUFiWjVXOWpiamVz?=
 =?utf-8?B?aCtjWjduUVFxSDdTT1FMMGpQM3RmZko4T3U5QUlSdElvSkxvZzFlTlEvUkxI?=
 =?utf-8?B?RGVhdjU3ZUpUeUU0ZFNEMFIzNUhkRWNSMmgrQUpkcVlJN0JEbEZhV2c5bjFz?=
 =?utf-8?B?S2trcVR4Vkd2c2ZUcjNBc01TZ0VzYU1xcXdweVU1WTF5MW5hTy9xN2FJUzkv?=
 =?utf-8?Q?rDmpol9wrsCQf/0I80T5fdwf0S/B+y8LoQufDxq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c75e9-24f0-4d70-9dd6-08d8f0810f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 18:00:36.6656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mI5q2r+3DXA/OuAkA59q5/dCV3OfLg2rDoT58m8RkQcRl724ORfa7dTwzCWt7bhClgP66HbIkXtWkmgjZNsQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-26_08:2021-03-26,
 2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260134
X-Proofpoint-GUID: _O-g6jS1YZVIhMxNUzGXApAc8TWXDB4u
X-Proofpoint-ORIG-GUID: _O-g6jS1YZVIhMxNUzGXApAc8TWXDB4u
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_180047_931006_9C179E13 
X-CRM114-Status: GOOD (  21.60  )
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

Correct. Fixed your comments

Thanks,
Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Friday, 26 March 2021 13:27
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; houpu.main@gmail.com
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Date: Fri, 26 Mar 2021 00:49:52 +0200, Elad Grupi wrote:
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 70cc507d1565..f10fa2b5aaeb 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -154,6 +154,7 @@ static struct workqueue_struct *nvmet_tcp_wq;  
> static const struct nvmet_fabrics_ops nvmet_tcp_ops;  static void 
> nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);  static void 
> nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);

Do we need declare it here?
 
> @@ -1103,9 +1121,14 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  		return 0;
>  	}
 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else {
> +			if (unlikely(cmd == &queue->connect))
> +				nvmet_tcp_executing_connect_cmd(queue);

Is this in somewhere not yet upstream? I did not find nvmet_tcp_executing_connect_cmd on upstream (5.12-rc4).

> +			cmd->req.execute(&cmd->req);
> +		}


Hi Elad,
The patch looks ok to me except these 2 question.

Thanks,
Hou
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
