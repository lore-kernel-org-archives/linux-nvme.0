Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690A7C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iC2NbHb1qju65Y7oNmCJuh4wJonqo7smUgI7isC22mw=; b=n44dJTxccWpx8qLlyaiRqAl3OS
	iCB7LNyZsaiRxczqtd3v2TzyBwx2tbg8/vxi3ncd0u73N+0KmGnGdtTkZlZPbFH0zGv9fI2s60l7X
	gpVOm3r+YOc+JiODF9u6uOhWN7CsTq6O/aysV4M3q6E9peYBq54/eT4smQ6REQjDR1avlOTcMPFR4
	Sqolkng0joqUfNht9wOkqb7UI/1ul70mqoEjtkpsZZUXna0ipwn5ua0tnH0PtoiK2AtZIi/WCKCGE
	OlIc5UNPr3zSsLsI3f2wn7P34fO+8mmGYIoGj+vwb/Sf4K73kYGnMS95tpmP1sng1VdFiA4zdAwG3
	XM5J+R9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovYhX-00Aw2f-Oh; Thu, 17 Nov 2022 06:48:43 +0000
Received: from mail-bn7nam10on20608.outbound.protection.outlook.com ([2a01:111:f400:7e8a::608] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovYhU-00Avy7-Jj
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 06:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HThh1qO4qwhxacqQ/CAGbH/Bf2z0CK7ajNR+Ge27MR+m15ei5nNMkBubDQyozDZ0wm1u7J/FIn5OAamMgO8O/hsajA89tvJ7v+EkrgnRBMGo6THb93KxS9WEFOiiy46SJ4YdR67+y4nYj4p3Rz3oIxOAjZQ9yiINaPNZQOieiiBHlSnfI7xYUu0VTYyG2ruuthpfrIZ7vwr26W8r8cyJ3eRcJSfOqE0oBdkt5K8/aV6ag08VKMeTjAgXShMOTFrQyycxLy7HQHBbE3MW60xu9bUY9BbkQUuOxC60Q8/GvHgxwd9H0WlAWLdCZKasUhUWYiRJ2tcgRD0+/zXnB0621g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC2NbHb1qju65Y7oNmCJuh4wJonqo7smUgI7isC22mw=;
 b=K4Oxr+8zKdiuyVTV2yD/HH3AxQ4lcfHHzzepMPngALiWfRvVkNYjZZ8o3kG5ZpI2HT1RbNHYuw5d9+vADinL5GcDa/uvK4aIILhQ3yVHZ/4SKvqCuk4mB+mckZVAeCc9D3+T4xzKHq09WyczR38G0X/2kag/kVY7l5P2N2moq/Pz4gM2x1Fs2qQnrylZJa1oTEyPofcVaoaeXZNsoklMWUyakR5BuR8w9ZRnkfv5CfAR0utR5iD5qc2iWR12/bk0GA8vPgsbcRpKylg2kfR61rz221HuHRcGJpx4LmRFbydUDENUrsCCl54gQNlGkwW1SF4hFOIRc6z9hWIujGj6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC2NbHb1qju65Y7oNmCJuh4wJonqo7smUgI7isC22mw=;
 b=PHqmjO32B7hThXRnss+baj6i9SqcQSy1wNJkSYg587F72vVyIxZeCyp79nPwnovpE0182/M4Cxql8e2ljU7kXlK62EO3NJ7K3TvVzdgzzeGuY3RnujCvegTzepn3XZiNsG8K4PmM04G/AHpOZYKVqTisbBLBqYAM7k8DA1JcxXzzEsK2b1EJPsFEtMt8Xrkp/mXsKFbGUQBljLM0TIR1X/531lP5LvT9J4NJhTACbWhaUhRw+ivarKprn1bKcdsnwSONle5S8/pvITsKfuRAHQKRjn7rYoxCwdlXBo9NqFi+z1mosgNhJT+1OvBrGPMjJrLxsWUNTUpG4HzdXwcyag==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 06:48:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 06:48:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: block dangerous passthrough operation
Thread-Topic: block dangerous passthrough operation
Thread-Index: AQHY+bumeMR8fr/vJUObWyxxKbdRWa5BuOIAgAD04gA=
Date: Thu, 17 Nov 2022 06:48:36 +0000
Message-ID: <f22696cb-eefb-66fd-9062-c91fd2800669@nvidia.com>
References: <20221116130104.2186334-1-hch@lst.de>
 <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4118:EE_
x-ms-office365-filtering-correlation-id: a91acd40-61fe-4dfb-9985-08dac867c0a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TigERJO9EgdgKq/O9FHyOLX+J89j/wn4ZIAcqdYYy6LD3iZI+iljaeuqAwbiN4stG42R24xE/7AsG/2h2xwlZ3m05u4p8ipF3Wv4rCUKoEu3RgOcCYX5ZRjvnci8Aq9+pI0b87TaqCzFPMVYz4I3Umt3BG80puaDC4EDmntZ56wnv/zTLJMBtkft7b4HdbkOBjs76fi82mKa+0n6nrnOjPhTR5AZFpiqyNMwIokMEZBtoO8WnPlEED+y9mcKmwwfhkOL5U1hu/8bZ705jkn98xvcXeNZGlIdBtL+CjGqmyKpMdXkD9ZmkfB6VlGbLb8nc0BlV/5j4qGkNPWyucQy2WvZzFcY5Qk760IMcFp/Ikzs5OF7E1uhGlXkUQR0AcfTascnDv1q2KlgGYDxFhRatENpzrJuaJTorNLS2OUPGMj0etD/bFwEB3gQNCaFrdXkkop32Ojcbpesnn3TxQPM1AE+VEkEbm0quSS1SbDOWumWXulO7g/6OpBIHU7qTZ9l/VPpiAn6S3tC01HgoRu2coz+GYkvWoTFBjgVYgJQwP+jc0D+FnsAMlV002QottTkeXMN2Mnr5g+LZyzoUiu8MqaoezVVgdcbua4RzwEZ88vn5PWLrorg50XClJxCdpmYR6ynIKJDnUb7ZQaDAC/fRYfakU0DcXY9rNUH2Vjj2oisqn8n+HehDWH82+B8H+btfZ/MeeN5N1s750GP2y3tIKVQPX2D3INj9XZ06l7+qS4PqcGV9nVGgkdTE3B6aiGd5NdKHkgVBPr/tAB+5Lirrg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(3480700007)(31696002)(86362001)(36756003)(122000001)(38100700002)(38070700005)(6486002)(316002)(6512007)(54906003)(6506007)(110136005)(66899015)(31686004)(71200400001)(4744005)(8936002)(186003)(5660300002)(83380400001)(2906002)(66476007)(66446008)(64756008)(478600001)(4326008)(8676002)(66556008)(41300700001)(91956017)(2616005)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aksxR3UrbHB0TmJjRTI0eTlHc3BySG56VU85a1o1ZldEVmczZHlqUnBkLy9F?=
 =?utf-8?B?OXRnZVh2T0ZsS2xLT1BnMW4yVWVRU3FmSDBwQ2M4T1ZnWlpSVEszZ0NuL2Fy?=
 =?utf-8?B?ZW1RYWJIL1l5NUdnV1Y2d2lDYUhQUGxrY2RSU3NyYTlDNnYwYUlGRENReHB0?=
 =?utf-8?B?MDN2ZlluRStoMjZIS3VuOTFjYm1hRDlLMi85M1VhQTBObEpSZ0diYVN2WG82?=
 =?utf-8?B?TVFpUmdWK0x0dFEraXVJNnlkZUNsYU9TYXlReXpsNVZ1ejVQM3lhSHJYN0JX?=
 =?utf-8?B?bHBtQ2hXdE1RbnJxSUtacHY4L2N0QnFjVGo4eE5xOS9Vc2N6eS9hTVVveWRv?=
 =?utf-8?B?QXpsOTh6V0JFa0l6ZXpWdUZ4Q2tVeHFXT00rK290VjFFeXB3dSs4am03L3Zn?=
 =?utf-8?B?WVFiK1NJd0RPaE9MRjdrN29BdFdyUWFsMC9SY3FYOGVqQUhwUi9CcW82cThU?=
 =?utf-8?B?d1F6QUV3TFdYVFdMWHpqeHovUVNGODZLdHVUbzRNQnNtcG1Dc3JScEJNWFhH?=
 =?utf-8?B?WEUyNHJPU0pPVEJHSzdERlFyMjh6L3lacUFtMHlkTDhVWmZ0UlRxeEZyaCt6?=
 =?utf-8?B?akxURDNzWmJXRTdZaWRUUmlkTDVScEhGZnRQQ0o4YmVjTXl6SUVuSmtvcTZZ?=
 =?utf-8?B?QURxYW1ReGRnM2VMRUtzV1R0Z2R4ZUZuZkw3MGJTb3ZPL0xLOWU3VUZyTVBs?=
 =?utf-8?B?aC95ZXNWaWNKOFljcktMM3lsQmVSdWxZZkdVOFBKdmJzTHd2a1I0RkNGYkow?=
 =?utf-8?B?bmtjeTlZUncrci9hc0F0Tm1INFRyajBtSXNOQlJhQU9yOWZ4UGhxT3Y2UklB?=
 =?utf-8?B?UGE5VUFaRzl4K0VLYWNicEhpOHl5WTQwRGxSNUlpTTFUZGtoa3llNFV3ZjJB?=
 =?utf-8?B?TzNZZTZZWXBxOE56T0RzdnlCOUJQYlJrMkI0NVhDZ0RJQ3FmYktUYUdJTk1G?=
 =?utf-8?B?ZEF5NnEranpHTGJtVzRTSEcrcGJneFdZQjJsQ2E1R3gvZGpwaWJObk00UFI0?=
 =?utf-8?B?NWUwcE13dmlKWEFCZ1NCRCtQMlVJTk9wcEFReWhNOGhQRGtlYnRyYjU2bjFk?=
 =?utf-8?B?WE13U2tJQXIrTDd3NFhjOGlTbkNxYVpOb0FpODFqZ2hxNmRqby9VL1g3YWxX?=
 =?utf-8?B?andENzdFRGxnb1g5Ui9kTFNHQmgyb3JiQktzZHBRdzVYZWVsUHdGeU5VR3hU?=
 =?utf-8?B?dldybGFiaEZiTm9jRlhUQ0FZZmdwb2t2TmJxWS9DT3FwSlZRU3VCZmdnUGls?=
 =?utf-8?B?a0VkVWdsNEZJRXpTQk81dExISVVJOGIzMGRzODZ3NkpaaWxJeDlRUVZvS2Ix?=
 =?utf-8?B?UnpGeWU3VFliYis3cjd5b2UwSlpkblp6bmgxS3QyNFF5Z29FaHMySzJMdlhS?=
 =?utf-8?B?eFpxU3FIelNFWTRsS1ZQYUl6RStYS3pFN2k5aW9NbW9KSko0Ym55c0g1eURT?=
 =?utf-8?B?SnREeHBocUpvL2UyYklXNis4ZWxpRXdaeXNlQnI4NnBFdEJzdEdYZThkWnRK?=
 =?utf-8?B?YzBxLytrOFM4RUVzRjFucVc2T01scG9JNU83emZQOUJHL2kxdWhaWTFESVlO?=
 =?utf-8?B?RnE5NExlTnZmTnc1TmF6clNzenprTG5EWGVFdVRGQ3RVMjVYVjJxcEY1dlM5?=
 =?utf-8?B?WFFhWjEvTlFUbEtkVkhESDZrZE9JemJNYVIwUVlEcmpLOTM0Q1VCUWp3VGox?=
 =?utf-8?B?WC9VcThYRFNBVjVyVmFrWkp6aGI3RXhycGFIOTM3UytwVXcxQWp4NDlja2Uv?=
 =?utf-8?B?WVI4UVI0QmZPT2QwYnFoQ2JUeDU1azJlbTlGUmJ4MXo4VWZpZ2FYYVRXdTZM?=
 =?utf-8?B?QkpSSWRxUWhmdzlyRmJ0OG5lYVNLQjkvbzltOHJqU1J5SUNoZTQ1MkI5Z0ZZ?=
 =?utf-8?B?L3dPV1lTeEd3UTAySUY3MmtTR0xSdHYxajkyYlhURXNNWjdKZGFvS0l1VTVP?=
 =?utf-8?B?a2EyWGd6Z0tLREZSQVdXUC9NTGlJRTQ2M0JFY3JvSDN3NXc5M1oycGNoN1Bl?=
 =?utf-8?B?YWg4ZmdqNElZd0JJZEowMUtBWlV6SElRRGNDL3NYM0ZWWUpNM1dLcjhsK2gz?=
 =?utf-8?B?RDRBWExVenVMcEtTL0pncjVwUnRnckpDdFM5aGtPVGhkbUJqUmZTb25ReDJ4?=
 =?utf-8?B?N3ZtT2pGczRidXl5VXl3VEFiMGpZL2pCWlFxTzBUMklHUU1NVHUrR1pzWTBj?=
 =?utf-8?Q?WpxJ7d2ZgcDNbni4XuQQo53VHDP5a5Qzgx4AElZyvJup?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6FE46F943905E4CB9AC48473787815D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91acd40-61fe-4dfb-9985-08dac867c0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 06:48:36.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7Hvpi3ppRFeH64JBBEbeHX7zutfHIyLHc69MdmoBeNDJwngpU3MIqv9rh9Lsbq/ZMqTkopcWw9bLXlAoHul2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_224841_010751_1735B1A4 
X-CRM114-Status: UNSURE (   9.08  )
X-CRM114-Notice: Please train this message.
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

DQo+IFRoZXJlJ3Mgbm90aGluZyBwcmV2ZW50aW5nIGEgdmVuZG9yIHNwZWNpZmljIGNvbW1hbmQg
ZnJvbSBiZWluZyBqdXN0IGFzDQo+IGRlc3RydWN0aXZlIGVpdGhlciwgYnV0IHlvdSBjYW4ndCBy
ZWFsaXN0aWNhbGx5IGZlbmNlIHRob3NlIG9mZiBlaXRoZXIuDQo+IEkndmUgYWx3YXlzIHNhaWQg
dGhlIGRyaXZlciBzaG91bGQgbm90IHBvbGljZSB0aGlzIHVzZXIgaW50ZXJmYWNlIGFzDQo+IHRo
YXQgaW5ldml0YWJseSBnZXRzIGluIHRoZSB3YXkgb2YgaXRzIGZsZXhpYmlsaXR5Lg0KPiANCg0K
VGhlIGxpc3Qgd2lsbCBncm93IG92ZXIgdGltZSBhbmQgd2UnbGwgaGF2ZSB0byBkZWFsIHdpdGgg
YWxsIHNvcnRzIG9mDQpwYXRjaGVzL3NwZWMgbW9kaWZpY2F0aW9ucyBhbmQgZXZlbiBpZiB3ZSBh
bGwgZG8gdGhhdCBhcyBtZW50aW9uZWQNCmVhcmxpZXIgSSBkb24ndCBzZWUgYW55IHdheSB0byBi
bG9jayBWZW5kb3Igc3BlY2lmaWMgY29tbWFuZHMgLi4uDQoNCi1jaw0KDQo=

