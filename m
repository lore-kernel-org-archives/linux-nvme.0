Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEAC19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wkoojgYY1tNOL3RQXs8cayUMzpE0RwuAW2I9FfXCnMY=; b=b73ywSpJDPtji1Pjk4E/SOr9Bz
	qXS+CM66i4Qp9kO37SXLze/bF3plwaHLsbfX5mnAIxIbaUQvZLw3V4dwYR6HH+eQt1WRlt9mHuATI
	6LskHsa67GyFW0mRaYZPbYDpPJ/gJEW+ONrEjhFAOxIWYmziVk97MN9bkQZn5V/bnYWaLKZTdxs17
	GVBx4YmsAnBIIoLfQJ9i7SbBa+xTdupti/Q2/qIsmNMxa2QqJq+gXO5i7ai2OAZqlM9dG/DHArDvj
	+ugR7VeF6RC9WJwomq3DAX/bMOK3cajQWknsSu8pB4LHKnVruAc8rdQ9XfKlwkJJj8VPlQ7nztmmU
	YJaXrX1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKcVT-00A2Oq-IX; Sun, 07 Aug 2022 09:23:35 +0000
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKcVQ-00A2MK-Pr
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 09:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsXQ9U8RDuwXwyrDIOHcLyzZYPovj5nbush62/vazDvNdm2EyJTXX8BV8+NBzn6D0rq7aS7MxM5o4k3LRHnWyCsZdtV6OHFzh9BOjtwoAQPXAx4TzRxBwtrtjTlZQ8wnCwXSKIgDJlXVE9IfM7Wj+EaM6qoaIAE8ZVogK03PlVK3uViACNtlfkr27u//TG+zcVV8M6OVNBG3N6/Wht9lCq06AmNmHwfs9U7lO+WK9ZHwlx0NUYcY7cMrCItdi+JgUODGildc4COwfhCqOenJkEf730w/TuMiOAWE2dYnb9oyDkVUuVkhhEHH3OPcUiNwp04pRIRupye1nrWlitygBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkoojgYY1tNOL3RQXs8cayUMzpE0RwuAW2I9FfXCnMY=;
 b=mJ38RZXlrjbXq/RmTMCYf7rN2sWsLNZV3nM/ym52G9OvMv+Nh7h7tdu9iK2uaXCRVn1F5bg/qLFjVBgPUxcdXs9W4BAkGLHkNJJVgdZrUCFNClJMCW7o6/1nFC6qxuaCb97AsQaeGjYz7Rms7xMyIFEWO6uHTG5B7oX1x2cu0W+Kwiyv6TnxzW4Q1ECq6Q62X7PshfsJwUmiyoNMoqWUAl2a5kOb/UPizJdO0ER/asGhy9KstCoONItVI4pRixqWQH10aVVsL3aZRh3ThECYY4OxMvzA11P37xma/rpIzgJZR8MT+ZZ3l5wqw6SLoFqZsJ2fLXc+1bePXfTnzrcIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkoojgYY1tNOL3RQXs8cayUMzpE0RwuAW2I9FfXCnMY=;
 b=niJh3X2lPKJqHiTJfBSrUArSYpJPISlyR3z1b1bb+BZeWscVMyJiCTNo7JARuVt2Vj3FRwKjS8xLqachfLe34nh622r+O7UkimLHdWFBN+9O9Yc5hQNXiWSFMHQKInDMz1dvhFBek+FovqF0vL/qNjFr98dRlZWLLNvBua4zRX6zaZnUv7aar76sbUxV6AMETq3y+tqPExjfgb5BDEFuCVFsrwTV92RyUVBcnw/QxmR/MCT7jiufo+bidQM/T0+6xowzkIwVpK02Pr8sBB5Z27zh/lzYEwR/S6QUvKwmyziw0OPiLWUvehPGqXfSzpIqOfDBUPlJiJqh5T8a1l9Z1w==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 7 Aug
 2022 09:23:27 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:23:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Ewan D . Milne" <emilne@redhat.com>, James Smart <jsmart2021@gmail.com>,
	Muneendra Kumar M <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH] nvme-fc: fix the fc_appid_store return value
Thread-Topic: [PATCH] nvme-fc: fix the fc_appid_store return value
Thread-Index: AQHYqW8pJix/pqRxKECvniIAoTvBxa2jK9MA
Date: Sun, 7 Aug 2022 09:23:27 +0000
Message-ID: <d6867d59-9e1b-78c7-6832-3157bc0fda61@nvidia.com>
References: <20220806083228.3826126-1-hch@lst.de>
In-Reply-To: <20220806083228.3826126-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5025d8c-4eb4-4fff-60ae-08da78567c15
x-ms-traffictypediagnostic: DM6PR12MB3545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  lqnRYvBvcJPScHfEvj/7QimC92n+vx4ifEESgdQ1KrvC+C+EIAYViSEkydVF14DFUC0xNunaOv85O8NR8xqRfzyfSDJD4zkTwzJQUrqQgi/Cf8etPM70XMDjmkbsr2WJeMwdXi/GSXSINdD1ZKU0s+/1U42ISt/1a/qkSZSfCSegSmgVUn4bpEncu1QvU0/ZjIwVljq2flL3GqhGzcuWVR9c6tbP5ES+0Ou6q0rVKP+eTc+CnE9CnqUxDxnHV2AM/q++KlwLGDmxoZPBosX1iGg0bGxfHKOz0/XiptJyFzwoXb7ZM84cLimCzz8Hr+dyGQwYzkXLefD6FJD7rAQgrXj3j/Er5kRbXoPasTlha98j6WkfLu1cnmMVr30Pp0OTDz9DXZG3YL9Fbqs8g4TKFuiw7g8WBW25mQV/O0lfpCZV2oEG5MO6uV++x/9WWN1cqE1AakV5giHHlnDi5l4NB1hQUJDg5RW/ULiTQefHg/EHKqEv1tsdA0j9N+VtW3gTHY85MTeN1SgSd2P6g9a0FZ9OHwQsCeroRSX6J251DsJ+LzMjabNGzi2LrNWWZ2gOjX5JKRaOMoWxDeX+XMl6NT7/JuN+7ajlbRr6WRjqKTTtvqgxywM6EEHOUnheg+ZFf46BFSvPbndyvDDH/G40WK4Xb0ELDEOZXY9H073EdSAY0CTzFygX0KHYcZzoZJibqNWbeccGuZKQBa0bA+rEq3MQWb7vrvGg4LfQ2xWS4h/JtuPU7c4CyA9FFtFBDZmJ9s0/yNSViBfH7lsSFWbAhUyAZzFKqe2VnHMDsoPc6tQiw5QY2/Dg7l8sRphHHUdcnU9zde1xZNFX+VI9EVTgYt7859nQIyMmJUUIASRp6TyvsKo5+n0VhwdHxZ5tiVoN
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(38070700005)(38100700002)(31686004)(186003)(6486002)(53546011)(2616005)(478600001)(71200400001)(41300700001)(6512007)(26005)(6506007)(91956017)(36756003)(86362001)(31696002)(8676002)(4326008)(64756008)(66556008)(66946007)(76116006)(5660300002)(66446008)(66476007)(110136005)(54906003)(316002)(2906002)(122000001)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Y2J5SDVoeFdvazRkWXFEZEFsVzgycFNSUDl0VUNicWo4ZjRhbFhJblJXQlp0?=
 =?utf-8?B?SkZya2p4SzF6YUNrVkZiUWFnK0crMU14Q1RCampaaVFWNTNnVzdSZTdUNUpD?=
 =?utf-8?B?dVFMdXdhclNROG5ubE9WcVh0YUtYUVR4RTRQNnVEK1RCUEJEWkFKSDFZY2lo?=
 =?utf-8?B?dVk4MVBlVFlYcXYrbU1kWGdYTm1yWGc3K1QycmhLWkVCWFRBOXB3MTJudzdz?=
 =?utf-8?B?bzJPM0d2dEd5S3h4aXZ3V1dsUXd2WitpcE44Rlh1SHJJV2RYdE8yMkFzeVZX?=
 =?utf-8?B?Mjgwayt2RWpXQXhGYy9ZalRqbnl3ZkhoeVNhODhMTWtuc1ZqYU5ZQjhHNTY5?=
 =?utf-8?B?ZE1TeSsyTWkxakE2aWMwSzJXSkZUdUliS1dEMi82UDgwb3NrRVNIeSs0aWIx?=
 =?utf-8?B?RTUzR0p1V3NnakdWcVFtU0dvZmdGSDN0dmNra3BsOFdNenl2L1VRN0UxbFEw?=
 =?utf-8?B?T1dwWDBRMWpmaWMvNUN6OUkzUUEvbGRaTEgyWVpSaGlFbnVaUjRGUzVrenJo?=
 =?utf-8?B?RXVVM0htUlc1ZGR1R3MxZUJGUVlHcjlQT0g0VSsxemxCR3BFVE9yak5LZnBz?=
 =?utf-8?B?cjBpTkllb0hmTVFHS214SlcvMzBWQjRqQXZxN21NOTZ2WStlcDBJUTJNZW1a?=
 =?utf-8?B?UjR3RG5qMG56bWpDSmt0RjRSK1FBeTVsRWkzZ2lTQzg4QjR0Ym1tbURlanNs?=
 =?utf-8?B?TjNSd05WZTg4cUgwOCtDZEg2d1puL29ZNmswMDhjYVBJa1lERFQ1Zm1oTG02?=
 =?utf-8?B?a0ZGczlib3VIRytqZDJsbXBuT2Z6dWJvSlhEcWFXRjdtR1lYTzl0VldFUkpE?=
 =?utf-8?B?SmQ4ZnovUUNoQngzSUxBVXBGQUtQK3A3Q3VEbXZsT0U2bm0yQ3F2bVl1SDlt?=
 =?utf-8?B?UHB1ZmhZQzgzbVNjd3ZMN2Z3VlZrcEMwZW54bWYyOTk1MTJMT1Mrd1Z5VTI3?=
 =?utf-8?B?SVNzdGdpZTlKYmhkVkp4cDFkNUoxNTVyaG1RQkxweEV6ajdiUTBueTJHdDJF?=
 =?utf-8?B?RVhHSHZwczB6YzlDTm9BNGZrOG5DS0JULzA2Qit4bThKc0daaGM3QU44QmRt?=
 =?utf-8?B?Sk1YTVhVemVIb09qL1V3ZDFRTzFkb2k2MmxkYTZyNlhxUUVFQTlzbjFhUlVo?=
 =?utf-8?B?OFZuV24yclE3dGJkVVBnNm9md3NxQTZKRy8zRjQvcmNNMnQvbjFRaGFpak1W?=
 =?utf-8?B?RkZPbHFHSUx2YlJwUSsraUJFbEROeG1KM1Z6L3NMUHJmZi9la0s0S2dSNVZI?=
 =?utf-8?B?bUtsNzNxckhPSi84R3FzcHdHOG80QVM2ejQvemw0aDBHK2lOLytXb1Rwa2pP?=
 =?utf-8?B?YTBhVDlwb1NIdkpOVGZzUlRIS1IrYm43c1hZUnVKVzBVM3RtSHYvNGd6aSt1?=
 =?utf-8?B?MmpzdmVXamFVZHpFSEpQdkxvUlJJaGoxOGxWK1FIN3A4ZXI2Nzc2THlsTDJ5?=
 =?utf-8?B?aS93LzhWRTdtM0o4eVd4MDdKZ0kxb25Qdmd5c1F2bWNiWkVMM3lOSGs0Z0U5?=
 =?utf-8?B?djZ4QU5ERHk1eTlRRmplTlBXWXRWWGJ4SlRTWlVxMDR3alcvTTIrUEZwTzdL?=
 =?utf-8?B?dUJZUVRBTUVhMGJ2OGs0TlRTMXRNZ1hOSVZ2dlhuSFJ3dlBmR2h3dVUzTGlz?=
 =?utf-8?B?V3k2M0dvbWdaTVM0V3p6TTVOYlhmQXJEWldXUG81TklyblhTcklYMHZ0UEZM?=
 =?utf-8?B?cm1yaUhXNEFPV1NFMGJKUkNXVzR2QXJNSTF0OC9PSE4zVEtFVm9ZdWZON1Q5?=
 =?utf-8?B?QU1GZlRwa0JqZEtESEVPalpvM3ltN1I1VkxCZlptVDFCZXdiaTE3UjBuSGdP?=
 =?utf-8?B?YjhMeGZIOU9kTVJCMEZORGhrbUVxRkRCU2lvTFN2bjJCbmIybys1MFdFNHJE?=
 =?utf-8?B?SWg0b2tUOVlsSG1sMU9QWDlQaGttWmE2c3V2QjF0L3AvK091Y0lZVHQ1eXVY?=
 =?utf-8?B?NE5kVVNRMTBVZ3BaZGE4bDQ4U2tvUjF1MmxJR05uWTI5MnNsL3BhMFdpUzQv?=
 =?utf-8?B?VlpvUkc1UWFvMXRGZGhMUjd1MXZLWmhCNGZjRGpxT1FrU2Y1anZkWnFYeU1P?=
 =?utf-8?B?Z2F6WWk0REFMRnJsQXZ2UkFYdFRkcnhCYU9jK0s1bEltWmdWNWxDUklLbkRh?=
 =?utf-8?Q?50A4QLWgxXXt/TR+/ft4kaXBq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B465D65057EAC4AAD6AACB56D859C2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5025d8c-4eb4-4fff-60ae-08da78567c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:23:27.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbSYiSV14mY5du/A0sMmBeBj3xrY891Dl+q4Fgum/6FrnwJIZZo4IDgiEeVrrlklTAoBtvRAYRdSzRoHgsw5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_022332_860925_D1C16D0C 
X-CRM114-Status: GOOD (  15.99  )
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

T24gOC82LzIyIDAxOjMyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gIm52bWUtZmM6IGZv
bGQgdCBmY191cGRhdGVfYXBwaWQgaW50byBmY19hcHBpZF9zdG9yZSIgYWNjaWRlbnRhbGx5DQo+
IGNoYW5nZWQgdGhlIHVzZXJzcGFjZSBpbnRlcmZhY2UgZm9yIHRoZSBhcHBpZCBhdHRyaWJ1dGUs
IGJlY2F1c2UgdGhlIGNvZGUNCj4gdGhhdCBkZWNyZW1lbnRzICJjb3VudCIgdG8gcmVtb3ZlIGEg
dHJhaWxpbmcgJ1xuJyBpbiB0aGUgcGFyc2luZyByZXN1bHRzDQo+IGluIHRoZSBkZWNyZW1lbnRl
ZCB2YWx1ZSBiZWluZyBpbmNvcnJlY3RseSBiZSByZXR1cm5lZCBmcm9tIHRoZSBzeXNmcw0KPiB3
cml0ZS4gIEZpeCB0aGlzIGJ5IGtlZXBpbmcgYW4gb3JpZ19jb3VudCB2YXJpYWJsZSBmb3IgdGhl
IGZ1bGwgbGVuZ3RoDQo+IG9mIHRoZSB3cml0ZS4NCj4gDQo+DQoNCndoaWxlIHdlIGFyZSBhdCBp
dCBwZXJoYXBzIHdlIHNob3VsZCBjb25zaWRlciBmaXhpbmcgZm9sbG93aW5nID8NCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jDQpp
bmRleCA4ZDE0ZGY4ZWVhYjguLjdiYTM1YjA1OTIxNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2ZjLmMNCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMNCkBAIC0zODg2LDEwICsz
ODg2LDEwIEBAIHN0YXRpYyBzc2l6ZV90IGZjX2FwcGlkX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRl
diwNCiAgICAgICAgIGNoYXIgYXBwX2lkW0ZDX0FQUElEX0xFTl07DQogICAgICAgICBpbnQgcmV0
ID0gMDsNCg0KLSAgICAgICBpZiAoYnVmW2NvdW50LTFdID09ICdcbicpDQorICAgICAgIGlmIChi
dWZbY291bnQgLSAxXSA9PSAnXG4nKQ0KICAgICAgICAgICAgICAgICBjb3VudC0tOw0KDQotICAg
ICAgIGlmICgoY291bnQgPiAoMTYrMStGQ19BUFBJRF9MRU4pKSB8fCAoIXN0cmNocihidWYsICc6
JykpKQ0KKyAgICAgICBpZiAoKGNvdW50ID4gKDE2ICsgMSArIEZDX0FQUElEX0xFTikpIHx8ICgh
c3RyY2hyKGJ1ZiwgJzonKSkpDQogICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQog
ICAgICAgICBjZ3JwaWRfbGVuID0gZmNfcGFyc2VfY2dycGlkKGJ1ZiwgJmNncnBfaWQpOw0KQEAg
LTM5MDAsNyArMzkwMCw3IEBAIHN0YXRpYyBzc2l6ZV90IGZjX2FwcGlkX3N0b3JlKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQoNCiAgICAgICAg
IG1lbXNldChhcHBfaWQsIDB4MCwgc2l6ZW9mKGFwcF9pZCkpOw0KLSAgICAgICBtZW1jcHkoYXBw
X2lkLCAmYnVmW2NncnBpZF9sZW4rMV0sIGFwcGlkX2xlbik7DQorICAgICAgIG1lbWNweShhcHBf
aWQsICZidWZbY2dycGlkX2xlbiArIDFdLCBhcHBpZF9sZW4pOw0KICAgICAgICAgcmV0ID0gYmxr
Y2dfc2V0X2ZjX2FwcGlkKGFwcF9pZCwgY2dycF9pZCwgc2l6ZW9mKGFwcF9pZCkpOw0KICAgICAg
ICAgaWYgKHJldCA8IDApDQogICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQoNCm9yIGxtayBp
ZiBJIHNob3VsZCBzZW5kIGEgZGlmZmVyZW50IHBhdGNoLi4NCg0KLWNrDQoNCg0K

