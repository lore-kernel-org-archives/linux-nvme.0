Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F26FC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 22:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjQ2nv+6OJQDFIWwwHBVPJxfN0/Xr8QLqypmabpMVb4=; b=adN95wvI/J/FNXtyMfqoQOLIR9
	HTlvB98qN0X9uPtMpIwQKMjyWmbWTG9u2P5yj00BW6J+V4rA2iHjVDmOEUaaDysiPY3HeuVRaiE4x
	ZoyIVoQbu7wQtoRZCzz0L7BtGBylC7swOkAl9Mdwqt0h/71EoR0m1fQAv1HbNTuPeh4BmiZWusKDt
	v2cf1IdKYKI36bGXzQGUR2b7VKW+iIv7uvF36+f9Xn3KSuAZ1H5nvtMWZN/llbvx6ne/zqrDwU039
	4Mq1qxv/KvZUSZI0BZPR7hyyFgLNQbRqRR/5xCmsRT+xEa5TjTWxu8JgRqnZK8vV5GAjtoDGB+ED0
	URhn2FXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruK97-0000000451W-0By0;
	Tue, 09 Apr 2024 22:40:53 +0000
Received: from mail-dm6nam11on20700.outbound.protection.outlook.com ([2a01:111:f403:2415::700] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruK93-0000000450h-2eYP
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 22:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4fKypFy0O5B4g2otkTXH6D3IZp5Hcc4meKO74s8ZHYGdu3j81sOCfOFKcNzGd7KMcQUkW0GMcXhaozP09nJm0RWGLyCCmDHuoZtldTeygsfVMEq/0B57AJZFzu5H22pFva5EvOrOZ+3dMX58oiIFDT1kgITPODAG6yaol+Lgl+twQj8VvfXvZtu6OlT2TzIJoZvOAlC6wYRc8EFjXkf9zdvDJ4EPOjyrqlY8Bb4FUfyLMMxzPrc2DTkU8FcgiQrrFIWVWM6x+C4FPUmox2mwdaR0GqsjkVPnpFJewTvVS5MPc3jWcgYXHyro40ixSZ+/0rOWSzi5uhRbDotKpcqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjQ2nv+6OJQDFIWwwHBVPJxfN0/Xr8QLqypmabpMVb4=;
 b=YJbNRgsTREGsDO/aSj+L63C3oIdR+sq57XSeJEEzpRcPdNdlQ5OUsbC33SDNe6PrfmxVmodn3zP+NPn84RHg6kJF06M7IueKUDmDSFBSGHQTi7YYSjL8Slzx26ywycGjeuxKw1wcu4F4C5K+jcN4HVK0UGBIL0YJUO6CqIDxG/SGsK9suLjWuUW/VKiXTegVaV57f9eAtyNLJHP/STCOcK6yDrzucLNQERkDqiwhqtkN6JTLjJlKNn11VjkBh+LExSS0ptoG7PqafQ7Kz+BRsX4XVMCqi4QFyZUFlZScWBva4qbu3SA2mTka5HtgSA8uqeJBH9qN+OSlMu1rPLAy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjQ2nv+6OJQDFIWwwHBVPJxfN0/Xr8QLqypmabpMVb4=;
 b=Rh8/AKbK/4kc+Nhybqfug57hPO/+yNh2VqnlqZWtj7C0yPXjg7h/CP1qeXqxUzGql4xYFrCLKbV3B1vqgNxTen3yEN5BCN2I+j5K8SpJSYkQp8PKWAOMpf1S4rFHBVazit9c9P5VfmgSGbPQuV26qIh+OZKNrVXcbtFcY89j6GW21lBu7+CLtw3lla9JiZkDgWhm0C5zmXCRDw9NW5wCftqUeiOGWUnufXnwALPGr6AExtPv7A7T8LQfhx+K0a2OaiKPFyGS4nbZQuECrV5kDMPRB6OVRMt0zUmmseI70UawF92r1gLu/QoA4Uai9GI2XAg11eCgcfBXrHq7bN8VzA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 22:40:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 22:40:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Thread-Topic: [PATCH] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Thread-Index: AQHaiXys6b7agcQ0tEWpZJimhZGiprFgivAA
Date: Tue, 9 Apr 2024 22:40:42 +0000
Message-ID: <55aa5526-ab31-43be-8ca2-d554fc22603e@nvidia.com>
References: <20240408061809.4010087-1-yi.zhang@redhat.com>
In-Reply-To: <20240408061809.4010087-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3px64sLTNehsynS6Jrr+eaHQMTdiyKZl55Hz+IxV1UCAipyFpxQDRzuTNG0Uu0jkYNflQg36r6Ri20bnpQioc04luroyII5TqZxHGPq+P33i6nXVfqE5+bz7cpNOOJsxz6J2+2RhE0Ah1oAT+JpDixBYxzb4AVSUARZks9EuArpAinnG3KUxxvfsOF7PYmJE5v+CVA9MiExs2OKfE7GGbHaglCNzWTw/qbkbIPIbbrIbNQNr39kKN9yU2piR4zhGwSQooSWfwPE1TC/diOMVu8y6hzoL1HHoKkWcc2C86oV6UpFhnDq8uG9YFKwtu79AYnVmxDW8u4FqPSBN+FsaYAcN8ZRYkKKxO8r3vv+oNPv8XLGrKNUKxn0e3zQhPtblxHICQZCumAhV96GsJXxkdzRRsPuKljysHESMptFvnFcxX6105PozZhDWDwwJzy5qGgoQoLnITg27NWWJUCDAPc5r48MmRYCb2G1MvNL3SsB2QGL31QiNFOkN6x9WqMMpPazxmI93ZGmbt+S5mVIH3fKx677AWMrger7/TcvBS2SfouE/hoJF/aAzxr0uMfafxlC4Zt4w48nJR86vAoKM6h8mps8GxvQkRYsPgICKa6a2ibVckepKqTFZMuAlYbBgvkZU6qwbJRhXF+ApqqBMagkTZPdyZAIoVMhdLndH2Hk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0hPNGJxUk5jU2YrTW9OMlpDNUoyRUp6RVFYWmIvZkFUQzMzc0F6SkI0VGRr?=
 =?utf-8?B?di8wMzcxM2tYcXQwQlJXZ1JjVU43TUVIRVpzOXQwaGk4dUdrdkk2NDNDWGRV?=
 =?utf-8?B?T1NHRU5CaDhXaFVEVUpMek1vTmdEeXhYWnVvTjFJQTJVbUdpNU04TmlkWUZ5?=
 =?utf-8?B?b0Z2REFaaWhVY1M4aTM2cTNMSG5sZEhyTGw2YisrdWo1anZLSWk1VklKKzk4?=
 =?utf-8?B?dEZCSWJoRVIwQnp6Nkc3dFliL1FCNy9qV2tMS2VPbUM0N25lTlJWWWdiZEJH?=
 =?utf-8?B?MG9BYVNEMzVzamE5dTMvYkRheE5oZ1EvUnU1QUMvRVZYYXhVRlpJZjh1VG56?=
 =?utf-8?B?aU1IeGxCUTJXeE1EY2RnUEwxM29jQit6TzZha0MwRGs2cWVMVDVqTGFDTm9F?=
 =?utf-8?B?bEhwRUNyYmNhUDJ2NG84cURmS2xKZE5sVnVSc1BVNUtIVEhYQ1VhZFVKQUJa?=
 =?utf-8?B?eVZMZng0dWU4V2lQTkdYbmpycGprQ0JQVDgxbkVlSWp1bmVPWlQ1V1BxQkxw?=
 =?utf-8?B?RlFHZWF0bmtUZXQzaE51NDNielFuVFFmTEhrZHUzRmhOd29OWE5wT0Y5QlI1?=
 =?utf-8?B?cTA1U1k1NXRTN2hWVVFXWVFTVTJKN3hCZlBlbGhJd2hUUEFQYmFVZFQxditq?=
 =?utf-8?B?ZHhrNmZKcXo5cjhzbE4rWUNBQlBBODRBYWFxeWlyY0I0aUxDMXhOWkkwQVFh?=
 =?utf-8?B?bFFneURUY2NiWjVnTElqQkdXeFQvcVhyV3pjUUdhL0M4bWNWV0Q3YmFoN1Rk?=
 =?utf-8?B?d1Yxa291OTh2Vk9KZ3JlSnYzK2JKWFJkMzd0bUhDcERnYzhneWRUS1QyckNn?=
 =?utf-8?B?VW9oNldnOEVKOXl3RXNLVjl3MFFHZ01OWkpXVkdjSkVybWhlVEt4WGRsSUdG?=
 =?utf-8?B?K2NuRzB6L2JQN2YyRnExOWo4VHp3TjVkUXAyTWpHby9jNkpXRjVKUVVrYVRX?=
 =?utf-8?B?NkdjM013TXEyQmlRcDIwTmdKZXExa0dKQitUTitDL3BiWWw5NUhmc1JTVXpP?=
 =?utf-8?B?Q2N3Z2hyQVh1dkVlakl3NDJETXoySU5RMGtjOHhFMVNrZ2xWMFlTTGJOcU5p?=
 =?utf-8?B?UWJZdXdtcHZ6U1VDRG5YMFlsMGw4QlRIT0JOaUVHOW1pRzllb0tXMUoweXBS?=
 =?utf-8?B?S1JBVFltem5HSWx5TnhRZ1ZlRVYrMFpPclhXbzAzUTQ1RDQxUWpqR0hlS05S?=
 =?utf-8?B?TWlMc0dzM0JUMDBZT2F4bk9kMzJmaG8zWTVQbHV2NU5qa0hqTVllb0xoenF5?=
 =?utf-8?B?QU1OQlFQa1RtZ3ZoZlNmODZFaURNZVRBbWkxQlRka1hybGdTbnVQbkMzUDQ4?=
 =?utf-8?B?bjBXTmZRUmdxY05IUGlVL1MrTHhNQVgrcDZqU3lWWEI5V3VGTDArRTdESllS?=
 =?utf-8?B?UE1VZG9HbEwrYStvVEFBUkZYMjZNd1ZqVEVhbWhDbTlCWFdlbjEyUm92VGM1?=
 =?utf-8?B?RUttUUV6M1FpdEQ1TVJTZEhtWnNiK3drOUFrZER5Nm52dnNaZGp2ZkxZZzhC?=
 =?utf-8?B?M3VMejB3blZKaitycTRsczJzYm1iZnhlUTRDbHI3L0JvUGJCOHVzOGFxYlVQ?=
 =?utf-8?B?bDA0MDlHLzRucnM4YTlkN3RVTmNZNzZjUDI2dkwwc0c1ZFE0UGtUU2lDSFR5?=
 =?utf-8?B?b2N1dXlxNXI1eUF6UlRjU2U2OVRnTXdLcmM5VjJTWmtxTnNETzUyWmU0L2FQ?=
 =?utf-8?B?UkdrZnRKZHp3eVVyOXNsRnc0Z2RnaGFJUWY1S0tZVVA4VFdzU1ZzSjU0b0tY?=
 =?utf-8?B?S2NkNytENjdEWU1CUHZhbGNBQUtqVTF0bjNRQ3FuUkZHREcyNVJ6NGdHekRH?=
 =?utf-8?B?RE9PWGo1ZXRRWjFYcG00My8xUElJOTVKc1VIcU9tQVNIeWNsWFVmWStFUDlt?=
 =?utf-8?B?dUFUc2hKNVZFSi9VTzZjTjY1U2ZXb2k5SXo3UG5QbWVSeThKL2s1N29XWG5D?=
 =?utf-8?B?R2FMa1pkbWtFRlVLTFp3NUtDcHZYRlNBbHpaRG9sbStaYW5yYTA3QVFweHdB?=
 =?utf-8?B?M1ZFRGFVc2JuNmtmL0JjbGFpcFMramF3Q0gzTjBZcWphTXQ0bUhBaVA3OGJX?=
 =?utf-8?B?eUNwQjNxa2tRTmtqMW5jOU1UMlFqVDlDNXFzSWNqZEVnN2FqUG5zYkFaeUZM?=
 =?utf-8?B?MmNEcENUMnRPL2dES3dJTjdORGdFUkVFNWM5VFQwc3NEKzJDd1UySjM5cjM2?=
 =?utf-8?Q?A7j/StP+BT2ZS9KEF+iE0+KsJ2ehMWebzT2olbttAcfW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE374295D6364408A9D132210F91856@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe6d873-46b1-404c-e142-08dc58e61698
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 22:40:42.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUzzCLu5Km+ayGBPtNB1YzYOJpL7wjgnVdbyjBWFKeXWOUYmFuXuDJsUusEvK1rPgce4dtEdZxtTgBz4TuIWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_154049_703171_090E5598 
X-CRM114-Status: GOOD (  16.09  )
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

T24gNC83LzIwMjQgMTE6MTggUE0sIFlpIFpoYW5nIHdyb3RlOg0KPiBPbmx5IHByaW50IG9uZWxp
bmUgbG9nIGFib3V0IHNoYXJlZCBuYW1lc3BhY2VzIHdpdGhvdXQgQ09ORklHX05WTUVfTVVMVElQ
QVRIDQo+DQoNCkNvbnNpZGVyIGZvbGxvd2luZyBjb21taXQgbG9nIDotDQoNCk1vdmUgdGhlIHBl
cmlvZCAnLid0aGF0IGlzIGN1cnJlbnRseSBhdCB0aGUgZW5kIG9mIHRoZSBsaW5lIGFmdGVyIA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXds
aW5lICdcbicgdG8gDQpiZWZvcmUgbmV3bGluZSBjaGFyYWN0ZXIgd2hpY2ggaXMgdGhlIHJpZ2h0
IHBvc2l0aW9uLg0KDQo+IEZpeGVzOiBjZThkNzg2MTZhNmIgKCJudm1lOiB3YXJuIGFib3V0IHNo
YXJlZCBuYW1lc3BhY2VzIHdpdGhvdXQgQ09ORklHX05WTUVfTVVMVElQQVRIIikgPiBTaWduZWQt
b2ZmLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBpbmRleCAyNzI4MWE5YTg5NTEu
LmU0YmVjMjAwZWJlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBAQCAtMzY4MSw3ICszNjgxLDcgQEAg
c3RhdGljIGludCBudm1lX2luaXRfbnNfaGVhZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBu
dm1lX25zX2luZm8gKmluZm8pDQo+ICAgCQkJCSJGb3VuZCBzaGFyZWQgbmFtZXNwYWNlICVkLCBi
dXQgbXVsdGlwYXRoaW5nIG5vdCBzdXBwb3J0ZWQuXG4iLA0KPiAgIAkJCQlpbmZvLT5uc2lkKTsN
Cj4gICAJCQlkZXZfd2Fybl9vbmNlKGN0cmwtPmRldmljZSwNCj4gLQkJCQkiU3VwcG9ydCBmb3Ig
c2hhcmVkIG5hbWVzcGFjZXMgd2l0aG91dCBDT05GSUdfTlZNRV9NVUxUSVBBVEggaXMgZGVwcmVj
YXRlZCBhbmQgd2lsbCBiZSByZW1vdmVkIGluIExpbnV4IDYuMFxuLiIpOw0KPiArCQkJCSJTdXBw
b3J0IGZvciBzaGFyZWQgbmFtZXNwYWNlcyB3aXRob3V0IENPTkZJR19OVk1FX01VTFRJUEFUSCBp
cyBkZXByZWNhdGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4gTGludXggNi4wLlxuIik7DQo+ICAg
CQl9DQo+ICAgCX0NCj4gICANCg==

