Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C22EC3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rapIbQ2MMgPyC8dzQRmHBHvj/CHCTXu6vq7n+FvbuNM=; b=HP/JrLdY49XN6uxh62S05ydOqO
	5ZsWbO5zNGwDUfBxc9Uw6f8hVl2gqP4zhS1jfaF4RfW8ldCSLfLtqkw+/5BBsUrfsBvR4pnt8qZcO
	l2Chr/lAc4LGUjaffRiQVfmmaYOijwEG0tmRU0eT0wMGwouSOtSUfj+ZRlC2VGFF++NoLc9jwyx7u
	NqgPfxfL1ZGjhGkHZLZd1BWefiQ1I/0qUcuR76s2+ygYYFfokrenIIflx/e7YU+/JmATQqy5lkCc3
	uUXGx0uIIkiRBpqN8Yqw7/4q0VNgrvFc2se8Nu6RpIFz76CGpG87YZnYy5PrOXG5ZU+pvqIpw2L9G
	P+yplFUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPVBK-00AHHF-0y;
	Mon, 15 Jan 2024 22:11:46 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPVBH-00AHF8-00
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 22:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVi6dpU9R1W/rEdw4/7GN7niy1en9bn3kDf2ksLOGaHBTYK0Sc1NEVopJTpJkXzkgxCbVzbxZf0Zxvdw2DQ31q+8WzJwfZIjsNr3/HBf+LJNJ9xl/cWGrhki2IGAP5R4quX8mOovq5Kko2Zb31Y6Zs3aJPOgk+G1DVM0AVZWA2CVuFcxc+8Y49tqmgMky0Ty1/Oy4Dd5OiXQTLbpI6egx1OqY3vnn+3pOLztQapYajWe7u+x16fhbVJNEq0Zt/XrdEEh37HVjQ6+/3pxDANWw1I6Lt43exNsjWqiOTZ+XncEvC0r8Zqi8gTxC/VLKUpzhlQ7eYYmOW0InyN2kyao/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rapIbQ2MMgPyC8dzQRmHBHvj/CHCTXu6vq7n+FvbuNM=;
 b=bpE/dQly9+2DzSYdZRUoxylWYC+kb2qfnWe06jIubmnohde/JMpqtD5wZQcQlpUejR58aCXEC1Ep7Dig9dqK9sZpyckwRAyJmRa1dLd5ttAxaAXvGntt4DHUUf/BseAHtoWWTQSH/9gSroei0igyNfLps2sOwUexfmywoQtH6iQXuTVU3cVKFu4yfMcTLFrc0l2KtzqI3weuUtmqy7ZVxMhLceySxYXgfAwxkdJnPyoq1G9KMZWJybfbUFc2eJxA6lqM3X/x1TEN08ES5B07Q8sfXS3ES6bq67zS5tgwZEVTcbjOJJOyPCtpjNLaW9H5MUXskWabdDm40pQ4gzcTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rapIbQ2MMgPyC8dzQRmHBHvj/CHCTXu6vq7n+FvbuNM=;
 b=Ws060DRTU8Xs/C6m23qeLQU6Tk2LqBSAM0t5PeHaHPXOyEzqUNu9d4/0rMdaT5RFK9rnymA1snmnOsfaioIDy1+gheZzsbNDFBiTxCSMujyVw74++kLQ1dRKj94wIK0QLwFc3rBrcWve6i/n/M8L/kTR812EHyCX1i4gJkLUQIF3613PTi5mMZflulOLuN1O7mtOi68NOlttT1vYw6LpMhg+D5lOwyxbLz3udlraNGSSUW0BjkV5718Ts6UTPBZNuNGo6vaArxePXH1zM7d8Whrg/6HO7BqVjKbUOhbKtyDw0haOxnpLMOcFCd94S4SiFEXDwPZ7rzJSecRMgLorlA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 22:11:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 22:11:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@kernel.org" <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-tcp: do not continue for invalid icreq
Thread-Topic: [PATCH] nvmet-tcp: do not continue for invalid icreq
Thread-Index: AQHaRShHiB1Qgpnd+UCAfEIhgpub37DbdUsA
Date: Mon, 15 Jan 2024 22:11:37 +0000
Message-ID: <7594460a-8eb1-4d87-b5df-08e6beadf98c@nvidia.com>
References: <20240112072303.141891-1-hare@kernel.org>
In-Reply-To: <20240112072303.141891-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8149:EE_
x-ms-office365-filtering-correlation-id: 646048ae-9d66-4704-c7aa-08dc1616f129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6dfgAXj2zaKKFVzACpetrncZYlbgji4JavFxaZ/xrDL+LIauzxTQ5sC7UZPp1TNRVFHSo6ZM3E4zUe2EyrPDTJNEt2kESDDUjCQvEmTUBQZwFGe6s23JcOURdEvOhy2XS/NfuM+zqoElGB/mBOjGV6P7tG88f6OYKSvUke7uXsr2o5e8ZIVC7NLu6dKSE0ewcu/jHDpnavyMD9eTPb+K1ftyDdG+vl5f58kTC97gGamtEJxCNjvClT6TlYuNaucFSjTpxmgepXzor1uxmtAIIyTjt3lsiChvWgnNXa4pWbZd0aeC/tj6xTga2Sb9fZIZhertbGYEVBLWyQsCJR8YqdFlCZS8kM0GOtMJLuT7Ji0K4ZTEInZ3d54iLtf4UeRWqr20ChNXAfxiUNejmLVnpP210Ge19AcXp4iOl7V/kiO0jGUt4oNS2YGqcjeKU30gITpwLmErwreiffIpK23JfV1/LcZi+ZZOg1pP27KOU6KyycXF/kIdWYq/fg+HqDr0esPyOwKlr1hPxIafx4FEQjE5xbQjpw8TeLFGoN+DpkYZM83OgNCznYcPPQ6hCClhnT3JPZH8ouZlcVnsvuqPB98OsKco1GpZ0jiQbcLJ89wjeLi1qR0vHwq1gyDIWrt3h+SE5GSeGSCtaAX7VPwHlTO5fgdGcNrU1c3XDNDYJiWONmtnvuW+Z5c29AGw1+e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(6512007)(2616005)(26005)(53546011)(71200400001)(5660300002)(83380400001)(6486002)(8676002)(41300700001)(4326008)(8936002)(122000001)(2906002)(316002)(64756008)(91956017)(66556008)(66446008)(478600001)(110136005)(54906003)(66946007)(76116006)(66476007)(36756003)(86362001)(31696002)(38070700009)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T05sTzRid1ppR2FpT0lHTXVuS0lvb0w0cE5NYnRHdWZRT2d5bncxTXM0VnJ5?=
 =?utf-8?B?Z1ozOGp1U3ZXQzVkWFllMkUxdk1pcWYzWnEzUG9pZTBQN0d6YXhJOEorbC9x?=
 =?utf-8?B?dVZpWW1XYXpDVU5mMlpQNnpuQ2RYc3ZpdmJkSlhhZXZYd1pzVXQrSnBUVDE0?=
 =?utf-8?B?NE82Vk1lUG55NlJ5UUFlOXgxeUtYL1ZjUHlIZ3RUazA4dUhRWFBXUExGVHU1?=
 =?utf-8?B?V2dHc25DaU9aaEg2alRXUVBpekFLakRSbEQyaDEzL3U5V3ZIVi85SDRWU1hO?=
 =?utf-8?B?SytqTFBMeWNjWTUzczBTWXBCVm5pZUI5dTNGSGg3STZUMjNubEN6bjlsQ2dU?=
 =?utf-8?B?cmdtVFBESkJRaFF5UU0wNUdaVjdqQ3lPK0NqNTI0MTk2TUU3N2cxVlduVGlL?=
 =?utf-8?B?elIrN0xIM3p1dXl6a1p0ekVTZ0FRakh5NlU5dkNad2FoTzZ0UnFQQWs0bFZT?=
 =?utf-8?B?MCtBelJScTdFc0dsVVVkdEx3Q1pTMUlHc2RWR0xFWE1oTCtPTzdUblVUU1Uw?=
 =?utf-8?B?RDBMaWw0NTl6L2NreW0rUGE4TlpMTTBlVTI1RDZIRDBPbi81a1Z1OVE0SzJ5?=
 =?utf-8?B?VG9MVk5DSHozQ1A3SG01NXBpSzVNdmU2RU9WcHlEdVZrSU10a1daL2JyRFMv?=
 =?utf-8?B?dUg3NzRWWkZlVFovNXVDdkNhby9FQkRYNTROamdvNm9FQ0tkZzdXNURwWVFH?=
 =?utf-8?B?dlk5SnpHcXNhZGJLelJpVHdaZ0I5ajlHUERVS0R0a0tldUZ6THdrT3dGK3NL?=
 =?utf-8?B?am1MOERzSFd5ZHZBV3YxMU5ZaVMvZmx6NHdoVTVKdWxPb1BFWEFLY1hXWUE3?=
 =?utf-8?B?ZWV3K0RXTllyMWFzSnEwUFRsQ0dwN3hCYXZaRWJTcU5sSzVtWXRCQTE0ZzZM?=
 =?utf-8?B?SCtkbThyOXk2ZXhsRVhJM0hwS0U5RzhrVUZYZTN3OHJJeUpjYlkwQWRFL2t1?=
 =?utf-8?B?VzNNcFlPaExoQnFKMmV4bzFDclYwdTQ5Q1JkODFaSFBFVGpzN1d5WXRmM09v?=
 =?utf-8?B?QldQQ3VmcVZSWjNINjg1ZkFFN2VBQVkrK3UvT3Fnd0pMeEc1RFd4UjdrUkhY?=
 =?utf-8?B?dmtqT1hlOENEWnNrU0hCNlo2VWRpcTkyRU1adXM2SE9kNzhkbTZuVmtkczda?=
 =?utf-8?B?WkJkQnc1c0pFOUd1ek1JVzZ5ZUhyTlFzcC9Rek1YYjQ4L25PRGt3SWZ2VUY0?=
 =?utf-8?B?cGlHRVc5bTRYKzJ4R0JVdzRxTUliejVvbHJHSWRtanp5UTNJL0dJSVg2ZERv?=
 =?utf-8?B?RmZuay9vbGpsQ1lvTFY4RnFOK1c1U2dWTlFreDJ2ejc3aGYvSmVOZ1ZlQ3ZS?=
 =?utf-8?B?VWJITkM3QWR5NVpLZGttUEdkTk11ZFlmUndSQ2taZ1lacUVtMURua2ZNeW5y?=
 =?utf-8?B?QkpkM0tJSWxaMHdPeHU5NnF2eFo1U2EvVEJTTWkrdkJ0WGRVNm5Zb0g0UTVY?=
 =?utf-8?B?YVNnT3YzZFk2cVpUMzQ4WFFHVzY4QVJ1YlNaa0dEKzBlbVBFMzFWSGdQNEVB?=
 =?utf-8?B?c2JpZE5rZjVDRmVxVFkzTWNON0FJbVBtL2NmZmU4QnR1elRiM0dBWHEwVHE0?=
 =?utf-8?B?aFRHQzBhYUphVkJJS1dmNzl1UEtLOFo2UWMydVJEa2RVdExPd0Z1MVBCajBD?=
 =?utf-8?B?VjlHZndXd0RTVnZqZnV1TkIyNVp3bU03TkpuQ1lJMDdHT2tmUHMyNjE3ZUVl?=
 =?utf-8?B?dEtxVkIrOEl4OXJIaSswRWZBOG1sUnA0ZXEwRWRmYy9lWjhSNnhncHNjODRC?=
 =?utf-8?B?Q1U4c1RScUZpRGFyZCtlLy9LRHRzNmQ3QkdGdGZuODlPOFRwdnQxT2ZCMkFE?=
 =?utf-8?B?Z1AzbVRHUnFXQThCVHJQNmNUUTRTcHhxU1g1WE9nVEhGOGt5blVZeTYrYXNG?=
 =?utf-8?B?VjNoaTYxaFFqYUFicnBqeDlWODd2Sld3UjE5YWxqaHZheFF3S1VoN21TUTYz?=
 =?utf-8?B?ME5xY29DV0h3TWNFd3lmaGU2SHRJeDJobVo2TFUzZ0hySURUazBJZUJjVlhM?=
 =?utf-8?B?OEl0SXN5WlFLMzRJdzhkMEpBOFp2OXdrVW9STEY5MnBmRTRFL05USWUxRUNm?=
 =?utf-8?B?SmN2Rnk5ZEZKd1JjL0VBZEJQRkZ5VHlTdFFqNDlrdnJsTnpnRjhVdFMyUFhD?=
 =?utf-8?Q?6vch0p1isxwMXgHcaGLVOfd97?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B147368BDA58324089C09B4D9C70735A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646048ae-9d66-4704-c7aa-08dc1616f129
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 22:11:37.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7KKPsu61QCsXHN8oKlXFbjvUt/IhLpTDKv8rCPpYWh6jdQl/PV2rpZhNJ5NErXpTGoJKN8k9VhQLrylZdtQ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_141143_048450_2AB5AE12 
X-CRM114-Status: GOOD (  15.59  )
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

T24gMS8xMS8yNCAyMzoyMywgaGFyZUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gV2hlbiB0aGUgbGVuZ3RoIGNoZWNrIGZvciBh
biBpY3JlcSBzcWUgZmFpbHMgd2Ugc2hvdWxkIG5vdA0KPiBjb250aW51ZSBwcm9jZXNzaW5nIGJ1
dCByYXRoZXIgcmV0dXJuIGltbWVkaWF0ZWx5IGFzIGFsbA0KPiBvdGhlciBjb250ZW50cyBvZiB0
aGF0IHNxZSBjYW5ub3QgYmUgcmVsaWVkIG9uLg0KDQphYm92ZSBjYW4gYmUgcmVzdHJ1Y3R1cmVk
IGF0IHRoZSB0aW1lIG9mIGFwcGx5aW5nIHRoZSBwYXRjaCA6LQ0KDQpXaGVuIHRoZSBsZW5ndGgg
Y2hlY2sgZm9yIGFuIGljcmVxIHNxZSBmYWlscyB3ZSBzaG91bGQgbm90IGNvbnRpbnVlDQpwcm9j
ZXNzaW5nIGJ1dCByYXRoZXIgcmV0dXJuIGltbWVkaWF0ZWx5IGFzIGFsbCBvdGhlciBjb250ZW50
cyBvZiB0aGUNCnNxZSBjYW5ub3QgYmUgcmVsaWVkIG9uLg0KDQo+IFNpZ25lZC1vZmYtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvdGFy
Z2V0L3RjcC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIGIvZHJpdmVycy9udm1lL3Rh
cmdldC90Y3AuYw0KPiBpbmRleCA2YTFlNmJiODAwNjIuLjNkNjA2YWIwMTUwNiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L3RjcC5jDQo+IEBAIC04OTgsNiArODk4LDcgQEAgc3RhdGljIGludCBudm1ldF90Y3BfaGFu
ZGxlX2ljcmVxKHN0cnVjdCBudm1ldF90Y3BfcXVldWUgKnF1ZXVlKQ0KPiAgIAkJcHJfZXJyKCJi
YWQgbnZtZS10Y3AgcGR1IGxlbmd0aCAoJWQpXG4iLA0KPiAgIAkJCWxlMzJfdG9fY3B1KGljcmVx
LT5oZHIucGxlbikpOw0KPiAgIAkJbnZtZXRfdGNwX2ZhdGFsX2Vycm9yKHF1ZXVlKTsNCj4gKwkJ
cmV0dXJuIC1FUFJPVE87DQo+ICAgCX0NCj4gICANCj4gICAJaWYgKGljcmVxLT5wZnYgIT0gTlZN
RV9UQ1BfUEZWXzFfMCkgew0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

