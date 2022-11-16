Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B760EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIYCyeeBZS/+Jd9CfBaNY67hhYDuNIfz8LdhaDjlwZI=; b=i1CoU+cFsGvNVkXJJRqLt0JSLQ
	3ebx33GaGkgQ2TpwsEjTSIn2qzTeWJPS0QgM1+osgH6qmAiEapNoIx0aFIyE6QUIzLzZL73JPppJn
	J+CQ8fkwtIdeDvt/hK739BeF1ZublUvuxPoZy6swL1KyPeNAuI2GdThPgQ6gRGJqhJafzNM13Mz6L
	zf6q8eZJPSPrXmWaA4N3/ZRH0EzpN1YxvrcTM91EO9Zw9iq3g9ApaJLBC1+Ee2EjF/o1Nb4WDfWwP
	y8dn+6Xn9al9TT1uhWQ93l/1HdTsMCmOIUaBTExbbvuxM9YEeU4zBT/SSZC2aXIkxh8LcVyXznqLM
	evvMwqfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNHx-0077CZ-4F; Wed, 16 Nov 2022 18:37:33 +0000
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com ([2a01:111:f400:fe5b::620] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNHu-0076qq-6g
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 18:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj+B1QjBgTP97QG8U60lWxUZJC1lyAt5knqwXkeoUBXsh5TvhFqXS6aRKGejb2xcnWzr4V+BQJg0PpHu/83s9+cnTFR8iyfUsZKjQS46pBX5L4aJoXpSzVHyobaWIdQen7U/0UkGC60atFEcDX4c9xeSRI3s71abt4FNMCAdJmmBYIrSx1KMgA0bcWfLU23xPn+k7UqmCWIMyY57k2hzRtfs3w/xDmlgppow4/7BvVXZEnocd5YOS2Ix53T/B4v1uqP7cPHLzSUyXg+o/jrJIyZ91uuKOWSChYS6vzuCNOp6y1qE5t7GEqrEb3ykZyjisbn+/wXIuVww9OCehraB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIYCyeeBZS/+Jd9CfBaNY67hhYDuNIfz8LdhaDjlwZI=;
 b=QSWD19WL4CB31n0kzd496n/vi3QEMKqjOQdZA7DMX4T/xx7DY6gaIQtT4Xt7Be6CMdYzdYfV52kCVzyEw6GIBpe1XSwBqoRlW0BXZmZM6jv9KRaz0T1olbJHkgBgrLLv5yXS9sR0cOGFPwtbNO+36CpiYM3FLjxR/i6gkUNw7K/V8k9BtlC+4mtfP3TTd2uii8LRYKb0XTDYNLvWVN8stzBO2jFkXGxwrFkkAJ+WyFezZkUikNaFSjUKaVHi8B0EuiHfumoFM5WowJb6d/5Ni8yMJuiGRKgC27sXyHs+6+gj20pmU2FmioyudcAnC7iyPblmMmCZ7R1bRnzT+UFqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIYCyeeBZS/+Jd9CfBaNY67hhYDuNIfz8LdhaDjlwZI=;
 b=Xz9qIbS6mw9MquyhDdXhR1vYmPsO9RgTETFo8k2rZ07nxrUN9s1newJOaysljCy6DkP9wvsH4/TULW3JWJdZu8XsySi3DqrEF4wNtKWeGxX9HRS0Uta/Iffz+txHFQKRP9ed4Zy8mWQib4vfoU2Fllh/qYXngcX4171aUU1kV9YDZ+eRQ1L157ReQ5IFnkNsLZKWtkY2EYF7t7GPeHjmyqCP6ehB1ek5CRBiBxU85r66+wVhVPOWL7e21KGYzV/2WXdrEgWMU5hru5ohsnr4KLfK63jba/4ymE/GWWTOaTAuremvRpJcAm4o3QeOmN+aV6KfYDp7/NPNkZwuQ7J62g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 18:37:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:37:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHY+cPD0r3cIhzYtkGWF/oAcRerEq5B4WYA
Date: Wed, 16 Nov 2022 18:37:22 +0000
Message-ID: <048950d7-2824-28dd-cf8e-32ee16bd124e@nvidia.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
In-Reply-To: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: 90ef0caf-d488-4468-861c-08dac80199fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  VD5HytzLTq8X0e34tRWLtRbEI+DekPuRPodq/PYJ49UQd2U1Gr720yJn8RhA4CCKjPvogHqk3WQgd4kKB7sJXsE251N2/FMA6rDimncx0m9yCI7SQAUdJ6XLqpg+2Ys6wMAEGo5j5R/k+W+taKwkgT9ay+8h1Qq367yQ8cISVm8HF+ANgitFFkkvkTbjp73tZYNkkmufYVLCbtAQqCleWuh8oLLWP2oZWH1mNG4SeE+3DlLILYq5GuBPZEfKMAS2evhX+ktKGynMlKAWn59aQHALpCvjew7Zdr2joedh1Rx2GsyoX4dPpmtJuLsZLIGeMQrzoDue5YZCg35uXVwquWtNZfi3Icx1bJREaUu5efJU0RGg9mA+iaUXSawF9NCJq3FDZngAeP2n07p+cxRvocYBnrxUDScdcmo1NPlIYaR0sU2mrkJThAT5dCYE+nL3WOvSaRPaYFl9LGtJTQUiA9MHfj74NJaXk1RiIczsMB39shqlFnftTKRKvPGGo8m+5oWM/9sF89KAoFbcxPJtD6DsY1AAapCPK5uCCyQ+RfSWlisRP5upDObfrKE8WX4CQEd6x0mL0Zwu+X6T1O/++RI/E8FaASIq48uNn1Ee8tZYl2eDA/CAiFSIJLxeL9H7q8rAlIywTG9bPUFQnlG1QfPRHYstKEeQpsfuCC5xi2ri4whiplws/udakPM/4MIsMCjgL57QR7Tw9Meh/uBBiC8OXJ4oapztVYZZFL03g1Q7+7pDK+u+nZ9BfrINr6uYo53Y2yo7vznO8H6FfWLLSSN7MbxihBBaUxs9xKeyiAO9hlTfdLBsyVr86rO3Cj7CEOmvht7yaEfeXSNiKeWlGg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(478600001)(38070700005)(36756003)(86362001)(6486002)(2616005)(186003)(83380400001)(122000001)(6512007)(6506007)(53546011)(71200400001)(31696002)(38100700002)(66946007)(316002)(66556008)(110136005)(76116006)(66476007)(5660300002)(2906002)(66446008)(64756008)(8676002)(91956017)(8936002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V0k3Mmh6UzNXVm9CWXJrZmVPcnkycEVjOERoaWlhNDUxZ0MrVFRVZ3FSdWRR?=
 =?utf-8?B?TkJpQ1Z1NTVwK2FFZ0Q3TkxOWGl0Q1FHWFdSeHIxVVpYS1R0ellzVFBGdXpL?=
 =?utf-8?B?ZU1OaUJkdXNXMDljWFdZdW9UWHBYWHBnV21ieUlLSCtLOWk1WWRKMzE5ajVZ?=
 =?utf-8?B?QkpVOFVSTnhDTDMwbFF3djhrQnAzVFNjQmEwQUJJOFh1ZE5TT0piNHRyTThL?=
 =?utf-8?B?YmZmTTlZZm9PZmtBaTBrRjZTdk0ybEhMdXVyT1FGN1d6OG8yU0tEdTIyVmcw?=
 =?utf-8?B?SmlXaCtpRFdxaUFMK0Z6UGswakVPdjJkUzMyVzk0dFJNNFB1Und6bWNRcnI5?=
 =?utf-8?B?NlNVUVJPMDdnWGxZamdrMGUxeFpZdmpIYkU0TXFlSlVmcXNNdW9ha0tibWR5?=
 =?utf-8?B?eUtuNkVLR1RaSXNTQWIrU3BNcVg2c2NhL1RlUVpTbENySXhWM2RSeTlhTmdU?=
 =?utf-8?B?WVo4ZFkvNlJtbzY0ZjA4RnloQ0E4dFYwY0p4d1FkRmZCNTY0V0tHYXdIRTla?=
 =?utf-8?B?RVpkcWxlUWhpWTVQaGZHak9ETWxjVVFrWUJLM1J6UGhhOWJTbitjdldLeVNp?=
 =?utf-8?B?RGV6TDE3YVJOSkxvV2hHWURyNUl5YWYxaFhVajhFSFVERHJOMnl2TGs5L0FF?=
 =?utf-8?B?TnNUcXQ2Y3JNeFlaVGh2eWNCUUtkOXRIYm9LdXN5WWQ4VkQvYTd6R1EwSUN2?=
 =?utf-8?B?azFOS3d1ZmVZUnBNeDV2cDNPRWxRVk90RVFkNHRWMHFxeFp0d0lJT3ZwUmds?=
 =?utf-8?B?NWM0WjA1K3ZCRjBIQkJHRXZTRkRIRU5ERXE0dENabG11VUc3ZXd1ekV2VkdV?=
 =?utf-8?B?VVR3cUJEeUdDS0RaWnVFNXNsYmNOa3NMWlk0R00wT3BTSE5yNS9QTksxbXVW?=
 =?utf-8?B?Q250dmYzRlU2QU02K2FORkx3YlJnVnoveDl2N1RENHk2d2VVYlpHMEF0UUhG?=
 =?utf-8?B?Z3M0SHlWbHRQOGsyOGd4VGprbWI0M2NBWW93K0tQWFJybFhrdjNEN1RZRnA5?=
 =?utf-8?B?UlFPZGR0aHMyRnYyQmFUQldwQVBScWNyRVo0NWZxekhPTUhxbmQwWEh1MDhm?=
 =?utf-8?B?cXVPZTlBbm9Oa201K1lHMmlVa3ZxQWtEZHdTaU5zNTNEdFBTN2V2RWM4ZXlE?=
 =?utf-8?B?UjVwRFhlSUJHV3VBMk9MamhkdDNabk9sWVpneTdnc3ZVb3oyNnNxQVV2cTZI?=
 =?utf-8?B?KzRsUU44dVovSkN3cE9obFg0d3JwMFRaeWF2Wm10OGN6K0tuRUFUVGsxWG9l?=
 =?utf-8?B?ZHUxbmFLcHhhaEdXRG04WDU0VjBZWlZaMEpETTljR0krUWlISXpOQTNDZlo3?=
 =?utf-8?B?ekhmR1RwQmRjN2MwOHNqaklaUEluNEZzMGxQeGp5UksybmFhWXMzM09wU2lZ?=
 =?utf-8?B?bTRmVm50ZWlMd1hwd2VNMU1lRGdLSXZDWDNtcWpTUFhMSURYOFp0aW95dktO?=
 =?utf-8?B?L2t0WXNMaER3ckQzN1RtRHdwNXl5bGNndFFKdVZOMktwam1KMjZiMURBMEUv?=
 =?utf-8?B?WE9CQUFvZVdDR0RhT3FqVkNCajdINzlnTzYrM1J6d2FBOFJVYjFqaytwYjVV?=
 =?utf-8?B?eUVXSzY0NmZYQitCVFA4NE55MlptSzhrTlpWOWQ4ZVZRS3NxVjBiN3pkUDlq?=
 =?utf-8?B?Z3dYaHdhNHZETGxNNEJUQWsyeE5JVVM0Z3BtRmlsWnNUVzdVeTN1WFRRL0Zq?=
 =?utf-8?B?a0V0cjFSbnpEZDlYcmV0bE1PTEFzVHlBWm9KR0dMY2EzeityNkhNYTNOY0V5?=
 =?utf-8?B?THNFUHZiS281UG9sWWdyMXhpd3pUYm1lemJaYXQyWjFrYy9WV1d5WmR0eFZR?=
 =?utf-8?B?SUtHclZkUTJKdlc5WmFDWVJsdzR6SFVsUVJEMTN4eS9YNi9sZVJmd3I1ZWln?=
 =?utf-8?B?b1NqSXlkcVJwazQwbWF2NlI2Z2tuS3doRHVUK1hLT2llMVFoR3cvMkUvcDdG?=
 =?utf-8?B?SlBQVHJLbE0wUHg2dituNTJVRXREbWsvb0VvTUJPbTRpNUR0OHd5dUR6bk9q?=
 =?utf-8?B?b1B4aVZTb3BJZmFHQmlGYUVwSEovUWJOSkVLc3Z3QjNKazZiYjRGMEM5SzV3?=
 =?utf-8?B?dkg1NTZWYjMyQXRHSWI5UUZ0c3JNb29RSER4YnpqVEZCb2ovSU8yeEM3QnVJ?=
 =?utf-8?B?a3NJN3hvSmpLQ0N4bUVIRm1iWmd0MnRUZDRGQmp4S25yNlhyR21tOU5xcHZr?=
 =?utf-8?Q?tN9Z/g/+WunxLgR0z3yoe8AyQTB6lBZ+BFyrASzuF3UW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D0EC9BA9BDEB43913B6B51FC8B36AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ef0caf-d488-4468-861c-08dac80199fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 18:37:22.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5/Q0l0iwLLMvBWeRQnd1KzuVswgmw50N/1l1exXvADqFOFEidE4DOPgJMrFgT6lxtn8KRPJByqOB34SWrIdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_103730_263759_44898AED 
X-CRM114-Status: GOOD (  15.48  )
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

T24gMTEvMTYvMjIgMDU6NTcsIGFtaXQuZW5nZWxAZGVsbC5jb20gd3JvdGU6DQo+IEZyb206IEFt
aXQgRW5nZWwgPEFtaXQuRW5nZWxAZGVsbC5jb20+DQo+IA0KDQp3aXRob3V0IHRoZSBjb21taXQg
bG9nIGl0IGlzIGhhcmQgdG8gdW5kZXJzdGFuZCB3aGF5IGFkZGl0aW9uYWwNCmluZm9ybWF0aW9u
IGlzIG5lZWRlZCBhbHNvIHlvdSBuZWVkIHRvIGZpeCB0aGUgc3ViamVjdCBsaW5lLi4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbWl0IEVuZ2VsIDxBbWl0LkVuZ2VsQGRlbGwuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8IDcgKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiBpbmRleCAx
ZWVkMGZjMjZiM2EuLjVhYmFmZjVkNmY2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvdGNwLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gQEAgLTIyNzcsOCAr
MjI3NywxMSBAQCBzdGF0aWMgZW51bSBibGtfZWhfdGltZXJfcmV0dXJuIG52bWVfdGNwX3RpbWVv
dXQoc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiAgIAlzdHJ1Y3QgbnZtZV90Y3BfY21kX3BkdSAqcGR1
ID0gcmVxLT5wZHU7DQo+ICAgDQo+ICAgCWRldl93YXJuKGN0cmwtPmRldmljZSwNCj4gLQkJInF1
ZXVlICVkOiB0aW1lb3V0IHJlcXVlc3QgJSN4IHR5cGUgJWRcbiIsDQo+IC0JCW52bWVfdGNwX3F1
ZXVlX2lkKHJlcS0+cXVldWUpLCBycS0+dGFnLCBwZHUtPmhkci50eXBlKTsNCj4gKwkJInF1ZXVl
ICVkOiBjbnRsaWQgJXUgdGltZW91dCByZXF1ZXN0ICUjeCB0eXBlICVkIGNpZCAldSBvcGNvZGUg
JSN4ICINCj4gKwkJInN0YXJ0IHRpbWUgJWxsdW5zIGlvIHN0YXJ0IHRpbWUgJWxsdW5zIHJlcXVl
c3QgdGltZW91dCAldW1zXG4iLA0KPiArCQludm1lX3RjcF9xdWV1ZV9pZChyZXEtPnF1ZXVlKSwg
Y3RybC0+Y250bGlkLCBycS0+dGFnLCBwZHUtPmhkci50eXBlLA0KPiArCQlwZHUtPmNtZC5jb21t
b24uY29tbWFuZF9pZCwgcGR1LT5jbWQuY29tbW9uLm9wY29kZSwNCj4gKwkJa3RpbWVfc3ViX25z
KGt0aW1lX2dldCgpLCBycS0+c3RhcnRfdGltZV9ucyksIGt0aW1lX3N1Yl9ucyhrdGltZV9nZXQo
KSwgcnEtPmlvX3N0YXJ0X3RpbWVfbnMpLCBqaWZmaWVzX3RvX21zZWNzKHJxLT50aW1lb3V0KSk7
DQo+ICAgDQo+ICAgCWlmIChjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfTElWRSkgew0KPiAgIAkJ
LyoNCg0K

