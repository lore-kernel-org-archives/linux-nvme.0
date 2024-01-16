Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CA3C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=; b=fO9Yb2YNtWeKYz2dmt1JKOO2Pt
	w/Dwsw35JXSMvftmbleviJ9K3QtsslJkE4cA+V42gHmFgSB7aZOScST+x1FSr+1g/65/1qSaRpTcE
	qFbTviYAmThVwYf3A62ytMQrsrj8MsjtC7+rLhTZZvr2vD3aOx1oG5i/HFSG9JFs8sJDr/yCr5EeQ
	tKz52GwSltNUBAQi5WBrYpKzVjUjCMrtmlYqcfAC6W63h3MVUYW8IwTTKg5FNaTDl/igUc4Yl69MH
	C/5hqqNm3pkNHWp/z1HFKYOv8fptrlBu5VbHwKTQ3AJNYp9yhP6V1Rvc6ecdhGdNVRFd80o8HVTjZ
	0OlEtoyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPqrT-00DcX1-0L;
	Tue, 16 Jan 2024 21:20:43 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPqrQ-00DcTt-1l
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 21:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOONQ5VOJzI/ujJbYYVRnFuuZESSb+EAfL+L17kVpuU06fS1+aWbHBiOhx1OIYSfLX+G49iH9XaLVwKYK0lmWR2ezTHWdUtL/4WDZ/XtYNppPf+X9IvQo1+aZtoe+snxnKXqgAcSey+3Be/JY+ask5Zm317eB78fFvwG+Hn/TF1Ddn+clmy36yLzBDdcLu/mfFVbzSYxgWffy44jK2dubx5isVsXA9Rvxntgq5kwGVqA9QF+oWX9Qi6XqkU/eHQlwaUBk26VRJghAqDY8TXmwoqvxdx0HrLRH/g5VU0EnpgViDcY3iqo3Y9T/icCQm6jsPUIaIng5Cg45vm7Tt0Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=;
 b=TX5hHQEGwTYum7N/lkomlSdSjC5qVm9MAJlySIkA3HLzEzgYH7/HNMoDkGVhVIk6kPcWG6chl/N4WNsZQuX4xF6tI5Jwmh7tSLEwnd9x0UzOUv8FqEsxRvE6b2H6Ko7P52ypZxZ1C56tcOaCd1H1+j/5Zsirn0FWZo66AKNFojV2LHXaQbRIt7UR5TFizkadRikowXIkBZmEFKYpSjwZTaHwlXKGkgErNy8FKZb+AYj3y7JaAIIr4wMvawa7vfNTJGfnupoZ8ZgHYFXlFPnbxalX+RGDs4oevOtZxfDOk65IAhg3r4Vq3n4OqQ/X3OpJ81LIvIe4CWPAjssmCeGnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=;
 b=YCEHBf1PRMbEsKhv5pYzyMv3P1HskezTzXd3eqFOCc3cSphVR+uw2lIApamIk/Bvh01E4d2Ux1NQkj79J/q2iVtgVG1IVjFPTgjP1W4IwZU9zqNbRemA4Vu4B/2wLBNeFOYcYqMUMh1zaQbM7uq5+ccaoPxxcu7MrVJq+n8Wewz2SqPjNIkYYD9n+ifBKZ29CQTRCpbKhauRH89BGoDxeNEz6FCSrSP5Q1CYHskxI4c/IIfGD2pOyoJRZKAd3a+lsV8uri2IBqnAGMLiTFYlTVjF8y/PeCrhDtUg9wt5hBC5lcE8Y/EGdkhsQkIc4D6XalGwCNb5RmdxACjMmYdc0Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 21:20:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 21:20:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: stuart hayes <stuart.w.hayes@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Topic: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Index: AQHaPyygJ0tk7b1GZk6+BJOtRok3pLDJ3RcAgAOo4YCACRkPgIAGQveAgAAjUAA=
Date: Tue, 16 Jan 2024 21:20:28 +0000
Message-ID: <385756c5-875d-4806-bdaf-70237c158e95@nvidia.com>
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
 <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
In-Reply-To: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8963:EE_
x-ms-office365-filtering-correlation-id: 7407e677-c493-41d8-372d-08dc16d8f68b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IawNFuWVdrUDKyakE0ypf4YeKN2YBLeXRji1zISA/rhLYNY/cZXtV49tttFZhYU1iCdx/FptownhmKBGMRLjcioZrsoXoi5HSrTU5gw/hKRy5lkHnGs3PdacWQH2seJZQnsXgKqaEAeqwNPRjqkkXrNJVvwzjbWJrb+s43ojJEo2PX/WLjFi9bB+Ms4ihWuWbc12920t4z670IY+Cd+by1V3Y5dvxdmxKI3dANoci3RNJpwbSyW2POULgkfqekkGmstF1anLWY0DbNlQG+PCa296b6vO6zfyImf2lDphgKCHb+iJukpJRiJoYCGXM/GqI8dHPYbUSDanEO2M0vo3aeppwmZrOWVFkQDUElvDYKn21FxxOxUKF8VhBGfrxuQF+QfkpSeBhLn5MZzqb0+LLfSUmnk8rIUOuQU2kBBRil3w3PnXhLtNKdPG8GeM45seKSKyGQuaAE02ImI80gZWt7PmA+dLOu59y0KiNvTQLEjFwvfK/wk50iiRzkzWGyfPn6+PN9TQ/RComG7LKBtd1fydyqrAdgKdeReaXO8+ok43XdDyjE3V6J/xPDQymDyF/dXqAHoyqVb3wmjz2SUpBLJGXNP4BLXrDWk0G+S+e3H7RnbHcRLosALvISOQod4fGKPHi4SpfoW0rj3qeI/ZMfSwzt9+UGDs4EgY4Vd45wTOj9XX/8LYnO8tkELIsVfB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(64756008)(66556008)(26005)(2616005)(76116006)(66446008)(66946007)(316002)(66476007)(91956017)(71200400001)(54906003)(4326008)(6916009)(8676002)(6506007)(8936002)(6486002)(6512007)(478600001)(31686004)(4744005)(2906002)(5660300002)(38100700002)(122000001)(31696002)(86362001)(41300700001)(38070700009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDJXOTREN0Zoa1hnYjg1bEhFMlNRakRqNlFLT2RnMVFGMU9oRHJlZCtZdDk1?=
 =?utf-8?B?WHFMTHF1ZFdGdVVxRUk2aEZJSnN3Qm95cjFzNzhSVmpKRWo0bmtyMEV3WVNs?=
 =?utf-8?B?SHVaaVJQa014azdGMWdRRzRZa2M2VW5UWDhJV1Z6NjM1V09rT3F5dTVsMmRJ?=
 =?utf-8?B?andnd0lTdnBTTm1tVm90cDVtVUp0VWExU3pYTEQxUFFPMWh3Mkh4ak9ub2l4?=
 =?utf-8?B?aFRicmpBVmZySUxZUmVZZGU4NUMxeHFCM2FKcVRqcXF1RkNNdlF2UnJuakIr?=
 =?utf-8?B?SFQ5dTVNMUZNU2xsSGQwUktiRy8rN1J6SFFpNGQ0WVBmTFN6bnN6WSt1UUhO?=
 =?utf-8?B?TGpWTG95L1hXZ0gvS3NMT25vM1VheDBNcXlobm5HV1I3MXhMYlhENE83YmFn?=
 =?utf-8?B?VFAyR256VWo1YnRORE83ZHBqU2VGL2R0TVdySzIxK2gvRmNoZGtMdlQ5RERw?=
 =?utf-8?B?c05lWFp2ZzFJNVZrckJBa1gxK3NtZUhHK1dKNmt3dnpVRFJ4c3pZRmYwNkYx?=
 =?utf-8?B?SU8rUlptd3p5UGxrNHBabnl1UHpqcjZsL1FLdW1QQUVBbkxvenNEYXdPeXpZ?=
 =?utf-8?B?THpSczRvQ21lUHFNQm5NQ1dHdERUbGhUR0RObEE3S2M1Mkxjc1hFU25JYUdH?=
 =?utf-8?B?aTNJT3hnSUVWZGUvakwzYjEyekFXRXpUbHRrYXpXRnUydUZoOGlVQXB2RTBm?=
 =?utf-8?B?cXEwaXF5UjRkeTU3Y1JNY2FZeTBxZTNvajVYVS9vamNBemJTQ1NwNGpRckk4?=
 =?utf-8?B?OUdWc1VrUGl1NWRzVE45S1JTZEpkQ2ZCaFlLMkI5ZCtNMFJ4alptRFNxWkNl?=
 =?utf-8?B?TjYxNTVrSUFhZ1JXU1I4MmxmWG11Rnd3a2tYQ2pEb0U0RTZOUFNNOGR3ZDQ3?=
 =?utf-8?B?ZDFkdUdEM2doWGRtSk9uaEd1OUFKak12ZDRJclZMZU1pUkk4V1JTUG1uYS9a?=
 =?utf-8?B?blVlb05ORG1yLzNvTy8vNEJhWlFiN0tRaTF0YW02bDRpTC93TGtzeTNFMUU5?=
 =?utf-8?B?S0xNRlJLZ0hDTDJVN3BBNmFQTE9mOHZXbDBJQTZjc3JNVTBZakRlZnNld1Q2?=
 =?utf-8?B?OXMzNVN0RVZrWldGV0d0Vm95ZUUrSDIwL3N1NXhQci9MTDdscUU5UmpHSFk3?=
 =?utf-8?B?ODkzcnExRXRId0FMMDRSNjhTbm5laS9HNFMvSXdHRXlzcm1Xa0FMelRIUFo5?=
 =?utf-8?B?WEhib3JSZWxubzkydjBMM3JFa2J0dSt1dVhMNjNETVRmKy8wSHVIdDZoK0JL?=
 =?utf-8?B?SU5yS3JtSXEycldEcEt5SVR3bGJUUWs0L2ZsZkozZ05rQVRVVER3ejdpWlJU?=
 =?utf-8?B?QmdabUhHWXVubEFYc2JabXhFcitpNEFJcndnWVVaVE5PRENGVG84SU44L0Zl?=
 =?utf-8?B?MkpPVEU1NjN3SkdNT29qbzZJSWpsWExMN2loNzFubVpCdllpYkkva0FSVDFF?=
 =?utf-8?B?NzZ6cjFXaFhzREZvcXFydzlMY2M3TThodzVYdkRjcW5xSEpGQ2FidURzeVBK?=
 =?utf-8?B?VzdRYUV4T3hXWXNLdyswTHhQdngxaEYzekZ2RXo5S1ZyWHUrQUJqblZIaEZ1?=
 =?utf-8?B?Q3A3Q1hNMUJiOUVjR3l6N1VHSm8rWUF3Slo3bUxpRHJLYkNZRUo1eWpRdEg5?=
 =?utf-8?B?dlVwR2N3L1BKbU9RYnlGNERuNkZlMGVnRElqK1ZNSGNXUEV1eXpiL1ExU1lN?=
 =?utf-8?B?dHgyN2lnQ1Z3eDFUN2ZnUU1WZDZxSndFaVBLcXhGVTJyRS9aelBIZS9ST3BB?=
 =?utf-8?B?eHB6bHVuNHI4WWNGelNqUWlwVWp0TzNuNkdsNUZ5UTNIUXVxSk5UTHlLa3Q2?=
 =?utf-8?B?Wk9WZkRWRU1wckpEWFI5azVuNDJPN3Y0M3NCZjhJRE1mTEM0Qnh6cmpmc0s2?=
 =?utf-8?B?RDg1dnM5L212TTBLSE9VYmlXUlRtQjQzOXJOb2FEbXpWUTI3dXMzTkFrTGpa?=
 =?utf-8?B?UEEzSmFBVWRuMlNHaXF3RXNYRS85Uy9TVmVWcmhWUmljOUxUYUEzVXY0RjBx?=
 =?utf-8?B?SU1pU25Ed0lzVU0vUVFiRXRKQzVnMkRNSHY4RXJ3cDhNOTRMcEl5bE1PVms0?=
 =?utf-8?B?cTVWc0Q4QUQ4MjZkV1dlZUtXUm5VcjhsYlNNaDBacnNzTXNURExUdTNvSWI1?=
 =?utf-8?Q?+7QaFwALu7EJCRv7QburIRLdw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA12912B8A2D904C909984B88DF8583F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7407e677-c493-41d8-372d-08dc16d8f68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 21:20:28.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDqE1wHTMlMHoP83+zg1p4LlJTytWIaKG9FfUq0+Z7jbJehcxg2Xv5tlxDZbz41I1CDhlAOI/E8CX2hZqjzVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_132040_583036_48E47EE4 
X-CRM114-Status: GOOD (  12.25  )
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

DQo+IEkgaGF2ZSBudW1iZXJzIGZvciB0aGUgbmFtZXNwYWNlIHNjYW4gdGltZSBpbXByb3ZlbWVu
dC7CoCBCZWxvdyBpcyB0aGUgDQo+IGFtb3VudCBvZiB0aW1lIGl0IHRvb2sgZm9yDQo+IGFsbCBv
ZiB0aGUgbmFtZXNwYWNlcyB0byBzaG93IHVwIHdoZW4gY29ubmVjdGluZyB0byBhIGNvbnRyb2xs
ZXIgd2l0aCANCj4gMTAwMiBuYW1lc3BhY2VzOg0KPg0KPiBuZXR3b3JrIGxhdGVuY3nCoMKgIHRp
bWUgd2l0aG91dCBwYXRjaMKgwqDCoCB0aW1lIHdpdGggcGF0Y2gNCj4gwqAgMMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNnPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAxcw0KPiDCoDUwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDIxMHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTBzDQo+IDEwMMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0MTdzwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDE4cw0KPg0KPiBJJ2xsIHByZXBhcmUgYSB2MiwgcmVtb3Zpbmcg
dGhlIG1vZHVsZSBwYXJhbWV0ZXIgYW5kIGluY2x1ZGluZyB0aGlzIGRhdGEuDQo+DQoNCmludGVy
ZXN0aW5nISBwbGVhc2UgaW5jbHVkZSB0aGlzIGRhdGEgZWl0aGVyIGluIHRoZSBjb3Zlci1sZXR0
ZXIgb3IgaW4gdGhlDQpjb21taXQgbG9nIGZvciB2MiAuLg0KDQotY2sNCg0KDQo=

