Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D0C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:51:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB38160ED4
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB38160ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ejPmYoXLt4t5mgEA+77NwX8dothw/9o0REZCiUfDA8=; b=3cnzef+xEogQRv
	E/XE3tP1SnxojVODKTnSpTSr0FgDjLjDlFBhjRNB9sn0JMsf4RghGHkibUfhnwPy8d8Tj2ILcnAbb
	CV2Ae/8qwn9LJ7gb4uf2MDoXgZufu4s9Hsd1u110dudxOgw0gai4ZEpfy8wi5/ctaYYu5q7TEBfyb
	V3sol+93TsimKYMgvC/iCCp+zrOKgjhR0HM+TQ7jwsztWvY/jWcBbnz37Gj5ABrHFdq3wYqC9F3mP
	Se48ncXYN4tXO3g/2Xo15MXOp1nudNwZsgR7v3HgYOZGhB1ump3yasZsP4jhUnWDKQogS8Qqm7+M/
	XX1ALAnVaWr8OmkaE8BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRaO-006IQS-P6; Wed, 01 Sep 2021 14:51:32 +0000
Received: from mail-eopbgr80105.outbound.protection.outlook.com
 ([40.107.8.105] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRaB-006IOr-2C
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+U4GW/uO9bUMwV66cweYR0p848GI+UMjYFF3hRzVUSXfXstUG6NBbMU7FoGb+/4lFMaG5xYPD8tDmtf/AcFfxYkPQyLxzBopJ+gBLag2Xf/zY3wrvhzkt7S+UWMfKhSaq2dukuQeAK45julE6h4cUm1YUnyUe88krJ05c4eqFCju87tmqEttC7n+K+72QLLtTED4isnk6ajmv5nW/idkXJEO5d/H6uAJLnfY362sH43lWMNt5nzWzYVZ4wcredNJzc8ALA7lDy/9aLJ4HVEpMXkIzkM2cMSBa9JhOY/TBVFAbxVX6AjMr1BpuSW3JEACMNoORW2X6OsEEXSjLXzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8omhjXvFWzD9VFUzVscic24Wb2wh6Vif3KRp7sQXpC8=;
 b=JL9sScxLiHhCwBvFFzfw6cyYTDDgZHbCRGVGwdmm4kkCD/g1Ccw53yNhK3Y8lf9DYrcyGiUobdYHcvaxJSdS9NW3k3hmzjmFwqZEdfWveH+hVLFTPhuLguqF3yct0uW7dvZssgFRcEyTgn7v68ydtwiPBilF2+bgwJeonTF4c1V3xWCaYvHRdHVIFKZwlKXPqChaxczDaqZBMZshIo1vL14arGnfvRCUpjh34C6Gv5dtVZGxTlxxHyuWrcoh4JfeQR6N892wDfLiRgh1W5PbXF7Ja26RFLcfGBWm8TFEbKj2SGbkL5v5D9/aFujIU3CQJUouRbnGR/fOKJUKDdYH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8omhjXvFWzD9VFUzVscic24Wb2wh6Vif3KRp7sQXpC8=;
 b=wq1hvOu09JGorjS60nbheKrutyEq81p+da9oGRzMEH7VlCKtgGqFdpVbycTBo6XtWWlVxoR+CDUjKizCoySWQ7ZZEsyfQk5u4HGPVm4vWOLNPbocGetvge+ta2vZnvUNGUttOY7L46uEhkHhWDQPR21dYLyquNo2ixFPneZ0NNI=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM9PR03MB6979.eurprd03.prod.outlook.com (2603:10a6:20b:285::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 14:51:15 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 14:51:15 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Topic: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
Thread-Index: AQHXnm4SW+F2pBQEIUGXFPYlGAQ1jquPI6QAgABCp4A=
Date: Wed, 1 Sep 2021 14:51:15 +0000
Message-ID: <0FA43353-7C04-4CAE-9E84-CA0DE6907492@primelogic.nl>
References: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
 <07e2bbb2-2b62-f0a3-b845-27398268c468@grimberg.me>
In-Reply-To: <07e2bbb2-2b62-f0a3-b845-27398268c468@grimberg.me>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72e65124-e7b2-4a0e-bf07-08d96d57f319
x-ms-traffictypediagnostic: AM9PR03MB6979:
x-microsoft-antispam-prvs: <AM9PR03MB69799B2283761184CEECB76DD1CD9@AM9PR03MB6979.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGBgNqglJAbYOI6dn61vbYzpAnqQCYNzHaPBK4vFJHfoGTSg6p1sB+2OJBa3vXB2zXyPXqPe3wmsRJUGuUZ/6F8kcUKCWv/NaoAftZNwJADb5SvYlmF0wn9D4WNV80yCUzN2ebrfu5RqvvQMkN+k7ziQVA/sDq78Wht3umZUU5Lac0AnkOFT3LKFhTdk66sgxyJJu8dBmvrdQZOkn/Qzu5OSLkh4xBPWgQGulQYccnFHGr5fWNbHVy3cGrR3Ev9DvSAWabtvQxlq0tYQFbKUtgiSiyO4CT6XiolTpHDAsUoiqbPeCXuWkORsSZAA9OO86pwIqsrQMpB1T2RUIWmvoxwQUNggAx2zgGZIaWr5SHSwOIEVSAAB8v+khISWMn/Mso5jJZRATfDMl73aBbcWIhs+0+nHY/rv86I3XdmoVhlez0A6YxKhozEirDWh399+1Noy/JpGqr4vvIQuWfaOpYSFXd8c4Qb9PdqbRSCOa4nJkWmKCHyKlBTk9+6dbMG/VzH7U7V+eeiaFqoac0WCndOHtPVUCW5o1pU3G2YKgjsRccMAJ2oh6AloRfVzQhYO2/zJ4bz+snvhXTwA28MauIt/qyFwxfu8KLdaMTWSbLz3iTh4gsn6jgbyPj/BicJxADfP3zUPAxvGnM2F8OoFST5IIoFcY11fBRpKurA0d0dGCyUA1Nu+MBXeJrXKFEnvH/WzshV2U7jHtc5vnXAN8kOZtXZbicRjvQUfI0LsfYw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(136003)(346002)(376002)(39830400003)(478600001)(122000001)(110136005)(6486002)(2906002)(316002)(2616005)(38100700002)(6512007)(66446008)(66556008)(64756008)(66476007)(36756003)(8676002)(76116006)(66946007)(71200400001)(33656002)(8936002)(86362001)(5660300002)(186003)(6506007)(26005)(38070700005)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjc2Tzhrem5kOGptTXI4bC9JSVVVRVJYVGVmWEtURkx3VmIrM1Q5a1hvVU10?=
 =?utf-8?B?ODVzM004ZjBldlFFbDJyLzU3MmxxbUpCSHhkZHlaVUlBd2RKU3dTQXVDK0Zn?=
 =?utf-8?B?UEhYdzFQaU0vNTRRdnZ5a3JxZEdkeGczeW0xZUFNdnVxODlXOHRWNGYwbFlv?=
 =?utf-8?B?OTNNV0VDZFdnNkUrbFZ5Y0xlK3hyWmE4bnVVRHZNcWl6bEJmeDhIOXF2OTNV?=
 =?utf-8?B?ODNMYVdBNTF5bFRqUGhnMXVmSXBPQ2dOQlRlSCs2dWZCMW9oY2tZazV2WUlR?=
 =?utf-8?B?VzRISTZFVnJwbjk0cUtUV2xjajlOR3hROHN5RG5PdEt6N3BieHQvWVpGVUhF?=
 =?utf-8?B?enNxWDJnUFhyRUp5d0dzdStQUG4rOXkwajVJcEZEdWhNaUs4Z252Vlc5d290?=
 =?utf-8?B?Y3NRS0JmMytKTUhpbHZaTjJLVEo2N0ZWc2NHcDVvcmo4ellWVXBrZ1pyWmJm?=
 =?utf-8?B?WkF2QmhEV005cmFrYlVlQ2tscGtoU0k1NFBKeWZRNjRuZ2F3ZlBNQXl2aGFS?=
 =?utf-8?B?MUgvL2Nkek1jY0ZzbkM5KzJ5UnJBMzJITncxZnJCYi9JTnNJR1p2T1oxY0pq?=
 =?utf-8?B?Q2puYkNYcXRyUjZmdGpIWjNTaDNzV1VNLzd0WkdCSjQ3M04yQXVVajNHaFB2?=
 =?utf-8?B?NFN3UkVrR24veVVoTytYZk5UNlpBUVBsSmRRVEQ5MjlRdndLenI1bTIwMzdO?=
 =?utf-8?B?bHpEZ01EY093VVJsOWZSSHRWazFzOUc1Qnl5a2xWSmFVanVBMXljNEJIYU9D?=
 =?utf-8?B?RWZEMjU4UHdPN091eGZXSnRNYWlFK1JxNSt2MGg0VUJNVTBjeXpNYlljYjl4?=
 =?utf-8?B?UzNuQTJOSnVEL2x2a09XSkNwUlJLVVRTMnAzT1pIbDNIcW9ibzBHQmpySXBW?=
 =?utf-8?B?Zml0UFRKNnhXTmFHeTNwVENwUW94UzhtR1NuaitOVE9GWEVCcWV0a1p3MDR0?=
 =?utf-8?B?TGoreVRwbVNIUEEwaXRZN0g4V085c3JFMHR1Y2FmRU8zNURtZDRQQy9YemYz?=
 =?utf-8?B?MWJETGVtV1Q5SDUzZGJudDN1VGp3QS9MY2ZJd09VUU5iRFU2dkdFeWxIOHZK?=
 =?utf-8?B?Z0dFV2NDd1JXY1NyU3phcGJCTEx4Z3BBbllIMkNjSmtyS2xqcVh6Y2tHQ2ZL?=
 =?utf-8?B?RnJ0Tkh4anZSS210V0xHQlpFVGZvSFJBUVNrQW9oKzNETFRtT3pzcG51N1RH?=
 =?utf-8?B?U0IvbHdaZzg3N2FOVlRVallGU1pyeERibUZUK1Vqb3A4Y3djK3lWM3B4ZnMx?=
 =?utf-8?B?U2ErdXhUTVJxV1RpZDNIWCtvYWV4MVNNVzVYdkVPZWROcHViVW9IK2dmbEln?=
 =?utf-8?B?L2hxTE81bWtQTGEwZVJmVEhkTlhHUUlaTmdudk1RdW5jTXhBeXFQaHhKOUJl?=
 =?utf-8?B?SnJGcDB1VGxuVEovbWtXS1VlN1NZUDdrOXdDN05xREduMVRPVThLQ0FXN0Rw?=
 =?utf-8?B?TCtJcjJNeUtnTGZ5VTlEUExZcWN6QksrRE9IWFFpNm1yWkRwd051dEdHc05O?=
 =?utf-8?B?QWZRdGRVOWRvUCtQOWFvcThtSXZEbFVvYmNlcHJKbWRJQmRUUkxKcEpUYlNN?=
 =?utf-8?B?SmI4TXdScURMSXV2Ylk4TkgvRXFZUEpXcDY4b1grcUJKMk5MZWZlcjZJd0dV?=
 =?utf-8?B?MEpUSHJYRXNMc1FBMzJaQlk3NmVoYlY2bVJkUE1NaHg1SmZLY3ArWE1yT1RL?=
 =?utf-8?B?TURrS1FHSFZKK2ptMElEM0IwSjZ4SVloSktaWG5oM3lMRWZQNDhkOU45eC9n?=
 =?utf-8?Q?gW7kabw2rZUrhhY2HgZ1v116KbHEjxbGXPge7/T?=
x-ms-exchange-transport-forked: True
Content-ID: <50A020E75B130D439BB8D020229B9AEF@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e65124-e7b2-4a0e-bf07-08d96d57f319
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 14:51:15.6599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USH2D8Bkum6WO6lwLNrmsTd4d3l4kptVBObXFx0PgeXlO3DufAdFCfLsMoJwFL2Esgi4mhvQz5wX795QRglGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6979
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_075119_165805_138DAB6F 
X-CRM114-Status: GOOD (  13.47  )
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

SGkgU2FnaSwNCg0KSSBhbSB1c2luZyBWTXdhcmUgNy54IGFzIGluaXRpYXRvciB3aXRoIFJETUEu
DQpUaGUgdGFyZ2V0IHN5c3RlbSBpcyBydW5uaW5nIFVidW50dSAyMC4wNC4zIExUUyB3aXRoIGtl
cm5lbCA1LjExLjIyKy4NCg0KVGhlIGRldmljZSB0aGF0IGlzIGV4cG9ydGVkIGlzIGFuIExWTSB2
b2x1bWUsIGhvd2V2ZXIgSSBhbHNvIHRlc3RlZCB3aXRoIGEgZmlsZSBiYWNrZWQgbG9vcCBkZXZp
Y2UuDQpDb25uZWN0aW5nIHdpdGggU1BESyBzZWVtcyB0byBiZSB0aGUgcHJvYmxlbSBhbmQgYXMg
cmVwb3J0ZWQgb24gdGhlIFNQREsgbWFpbGluZy1saXN0IGl0IGNhbiBiZSB1c2VkIHRvIHJlcHJv
ZHVjZSB0aGUgaXNzdWUgd2hlbiBWTVdhcmUgaXMgbm90IGF2YWlsYWJsZS4NCi4vcGVyZiAtcSA2
NCAtUCAxIC1zIDQwOTYgLXcgcmVhZCAtdCAzMDAgLWMgMHgxIC1vIDQwOTYgLXIgJ3RydHlwZTpS
RE1BIGFkcmZhbTpJUHY0IHRyYWRkcjoxNjkuMjU0Ljg1LjggdHJzdmNpZDo0NDIwJw0KDQpUaGlz
IHNlZW1zIHRvIHByb2R1Y2UgYSBzaW1pbGFyIHJlc3VsdDoNCm52bWUgY29ubmVjdCAtLXRyYW5z
cG9ydD1yZG1hIC0tcXVldWUtc2l6ZT0xMDI0IC0tbnFuPXRlc3RucW5fMSAtLXRyYWRkcj0xNjku
MjU0Ljg1LjggLS10cnN2Y2lkPTQ0MjANCg0KSSBob3BlIHRoaXMgaGVscHMsDQoNCi0tTWFyaw0K
DQrvu79PbiAwMS8wOS8yMDIxLCAxNDo1MiwgIlNhZ2kgR3JpbWJlcmciIDxzYWdpQGdyaW1iZXJn
Lm1lPiB3cm90ZToNCg0KDQogICAgPiBXaGVuIEkgY29ubmVjdCBhbiBTUERLIGluaXRpYXRvciBp
dCB3aWxsIHRyeSB0byBjb25uZWN0IHVzaW5nIDEwMjQgY29ubmVjdGlvbnMuDQogICAgPiBUaGUg
bGludXggdGFyZ2V0IGlzIHVuYWJsZSB0byBoYW5kbGUgdGhpcyBzaXR1YXRpb24gYW5kIHJldHVy
biBhbiBlcnJvci4NCiAgICA+IA0KICAgID4gQXVnIDI4IDE0OjIyOjU2IGNyYXNobWUga2VybmVs
OiBbMTY5MzY2LjYyNzAxMF0gaW5maW5pYmFuZCBtbHg1XzA6IGNyZWF0ZV9xcDoyNzg5OihwaWQg
MzM3NTUpOiBDcmVhdGUgUVAgdHlwZSAyIGZhaWxlZA0KICAgID4gQXVnIDI4IDE0OjIyOjU2IGNy
YXNobWUga2VybmVsOiBbMTY5MzY2LjYyNzkxM10gbnZtZXRfcmRtYTogZmFpbGVkIHRvIGNyZWF0
ZV9xcCByZXQ9IC0xMg0KICAgID4gQXVnIDI4IDE0OjIyOjU2IGNyYXNobWUga2VybmVsOiBbMTY5
MzY2LjYyODQ5OF0gbnZtZXRfcmRtYTogbnZtZXRfcmRtYV9hbGxvY19xdWV1ZTogY3JlYXRpbmcg
UkRNQSBxdWV1ZSBmYWlsZWQgKC0xMikuDQoNCiAgICBTZWVtcyB0aGF0IHRoZSB0YXJnZXQgaXMg
dHJ5aW5nIHRvIG9wZW4gYSBxdWV1ZS1wYWlyIHRoYXQgaXMgbGFyZ2VyIHRoYW4NCiAgICBzdXBw
b3J0ZWQsIHdoaWNoIGRldmljZSBhcmUgeW91IHVzaW5nPw0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
