Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6350FA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RH53WtS4P3s9vjwZBBsZAfGC6Dwbtdi2FH/ouqUSl2o=; b=XfeOdeGFOLc9h49ldV+XqJ8rEi
	BlYoPFT+5lIXMBCSCAjKnhoK0NYQsRpr+82q4Y36o4wUOR37jRC86skRin2/a4FYS8ch7NCJJkewn
	cQjLcWJ06NRdkTMJ+FiaODKa0+OM8tpb4NuvQxKLnAWYPQDvg7pvnygIVOHH2O/hc6WjZ8AETeAO/
	7QWwLhDtw+BSY9EQmm0sRt5cMC4fI+Xehshe2ERTmgAvGm0odVikKmaqjlJ+XgrtJrrqOVMpikUK1
	Da4kGcLkjUhJe6CgCnylK3BeGz38xgjUTW8Phz+XUXsHlXXwqsn9iw7/ku9uvv3f8kh2Bo3f/gRyK
	ZrrUX8mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNpC-006Uvc-7G; Tue, 25 Oct 2022 17:34:50 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNpA-006UuP-3G
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuePL5x2/+ixc/1t/wQEUIr3VjviNNyjr4PqFdPVEvmV2hS9aWb6IY7RKu2A+CSzFCjhRYNzGeshpmqY/l9ZJNAXMfZaCDwC479X0gRlLHrJd0WEpdzhWVduWgyKBr2mFSYZLhCdifacqfmM9wbOlJZEhQaG4hxgl6/JQx0bTmb60J/BjYEnA4hgwOLZa/z6mA2b6XL3zzgSXFVR56rk9DU7uDJjH8+m8hoEnKh4kd/o870JcrUBSrNukDIqa2yo79gniWNXsnXJve3QXSj+JJ5lMaUQ7Xpoa58rEoRrsvSMU6GH9XFvtwhZ3lZbJaa5a2129X17eZJ8rUHxKO+0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH53WtS4P3s9vjwZBBsZAfGC6Dwbtdi2FH/ouqUSl2o=;
 b=mRsxog3gBJPPWdmXCjVM0YaRWjAvPqlvRkD6s6U6kJd9+UWIEATtb//ZO9BPkF01WmuENsgcA+j5v/VMubakK9RR2dkCq6/z0GTnSMJgyEd4TXcb9a0DUWsVj1Roz5TV71iQzgNWg5/ZiuRkPEBeLXgBnslEIWqCc7zm7aEKLWTMx+LKJTg4JWNIpTq6NLWSMgHBkA03IU2JQat/4LBf0oBCA0N/k6pi5Pm2jKdf1KOBsFDe/q4iWRc5L94bz3Bqd4SXEup964WqPCVHvaMJ2QH0adxGo5rcB8u1wv4JRklZzg643bEZ0VJt1dpDJ9fq+8yWIAH0nG0W35sWcqNQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH53WtS4P3s9vjwZBBsZAfGC6Dwbtdi2FH/ouqUSl2o=;
 b=X6+hTzn/BcscnD/BGSGKM9LsdFAu9TYzo0qi3G2UckoBuCjfRlXFqR9B9+Cw7+Jj9deKflc0jYUroWoHAr3COFZ4C56i9qSYAuH4Ig/o0e+WtSHkI1erwmsg70gBlHfvabND2iNmdc1wuLQ+L0aLjMP2lnwFuyEX7b8aHdEROywmZk/cSoG7MB7adkGipjNUt13xV5a95PmNLrvcGF7qP3qnBRIbT27W2iBRiVZaQucrOCufOtyv10LiBi9qtVxnovZpErLICiiNHhRLQZbKGVqYZg1he/New4ej7/BwdA2tsnZpjXvJgzLSn1Kx/J1jYJm7IZjqOUfpURhSlEQc6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:34:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:34:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/6] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
Thread-Topic: [PATCH 1/6] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
Thread-Index: AQHY6Hf2EExpQ8kAV0mIRHFpz+zgxa4fXzEA
Date: Tue, 25 Oct 2022 17:34:42 +0000
Message-ID: <640c0852-0904-f968-995d-7f2640c3f1bd@nvidia.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-2-sagi@grimberg.me>
In-Reply-To: <20221025134330.1028352-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7377:EE_
x-ms-office365-filtering-correlation-id: a1ac1159-9690-4540-cabc-08dab6af3397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  6ZOjueQ2yIa7KKLM3icAUkFTqYE3q3EzqdDBzISDID8mfG/MgjvNqZ3E9geYuH/slG+NOaeS4E1GeXOycuHXAHcbn+478448LWMApRD1wRQVk5l24JnuXOvUNMf8/52s/7XB8cHSNZwAIJLqpio67mpBEttFbxF2kdHq9Zzp8FSbHtSvUyfuxIMMrqWo443ugqL3KgqYezme0IAj0MHHcx4BtMYxJ2m0Z1RH2L1+/Rgq+ozWjJly8CJjcx6dOFAd+YwZxGY7makhKI5UFLFUeuE4WiGZURChB7jxDI3wj0UmHrH5558cC70OVqM+w4HzjNin81zpytXT7A6s6+ywxn+U7z8BlC1IUFbui2fo8cPMKvl5PmF1McThU8Awdc7qUcHkqbJtwfrn7z9jlHhEgIRkn1BFdfqyrWBE1W1AWegk/a/ZX7Qdn4TV1pT3yb91o6ldLTYJ3H89JpiZlyjvqcUokU5zz1J9D6k4j02KBf5b4g8NCC8gCEnycVewQy5zLhK4TrZuXfg6ek7tmcMONcX33mqGc4f1Oox83KWhBQ/3ryC9RrowANxw6p6CP+B3yu325KcrI2TIYeHY28Ytd/ZQB8Sxn1m4dfBUgpd3oKQgA/DV4fnqp9zhYmQpgvzueoM4UAM7I3CnA/pcH+iHpt0GDQIFuAon7I8PkB0N9SHw1rhAJzDIii25yRpA0nKsLraiS3zhxMhMyj4WWSqPxKL+vs7nRrp2NhG5LXeAtkKgT47i37kzyEhgOhonnkKOdBXBvUF04EKrTzodg6df2xWbJglBfXU8QLMamvUoyWK08XGzcx0rhn1VQLx+2M2GCAu8Iru+LE/StBQGKRQoSA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(71200400001)(38070700005)(8676002)(316002)(54906003)(110136005)(558084003)(2616005)(186003)(478600001)(6486002)(6506007)(36756003)(6512007)(26005)(53546011)(122000001)(41300700001)(8936002)(86362001)(38100700002)(5660300002)(31686004)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(4326008)(91956017)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Mm9hMXBjMWRMcnpXY3QxQllaK2tEK0I0UzlsTmJvZTdYVmVtOXdLUHMrWnRX?=
 =?utf-8?B?UmpBaDdHcXZmMjhxeE9vVmhGU3g2OGR1MnJpZWcvNW43TThYQkQwS08ya093?=
 =?utf-8?B?eXVvZE0zSHF6NFhFVDRDQWJzVlJheFlEcHJETXVxcDFJWXlscjFFZGZXR1V6?=
 =?utf-8?B?UTUrVTRzLzVqeCtlQWFQRTRWcnk1Sml0WTZKb00xYkd0bFcxdnRYaEtPNTRO?=
 =?utf-8?B?K2lUbTZIekJrbkJyVkdJYjJocURZQmRLZ3BqdHE3Rmw0SUJkS2NDRjZmSjRJ?=
 =?utf-8?B?WmU2YllPYVIxaWplanpTZ0xzOWFTdUIycTR1SGhBY2x6aHNMRGhzTnJJUEt1?=
 =?utf-8?B?cHhWb2xqbm01NnpIZklBMFZtUjhRWXNiRUkxdFNyVU4yM1dEbTEzMkVEOXFl?=
 =?utf-8?B?bWJvTGp5TDQrZk16bWRFb01XSWUxenRYdEVzL3V2czVuRG9ieGFtQmRLcUNT?=
 =?utf-8?B?WEJUUit2cmZyanZvUXRaS0tiRE5rNzExa3VtTzJiOW9QWVRiZzQrRVo1azlC?=
 =?utf-8?B?dWIxaEROd25UNW1KbmNIelIzZjFEeEtZMStCaU9zSHpNSmJyT3JkN09jaytI?=
 =?utf-8?B?UTMvUk4xSjVpL0NtS3Z3d0twUzZwclREL2JzSDRQQnQxdThkblNoSXIyK2hO?=
 =?utf-8?B?NytPVVhUU0M4VWg1anJCUVk2WDhzdUZaR2VKZ0ZHNDA2UEg0ZGlRQlNQK3Bn?=
 =?utf-8?B?RzJYOWZJc0JaQ2d5VzA4QXNRcVRyMWxoY0Y0R0xacHltbEZyQW9UQUVhKzlY?=
 =?utf-8?B?NU40aUZUa3J6c3NZdWdxb1dVWjZhNDIvMXVDMXpldDNyT2lmL0loWjh2Z2lO?=
 =?utf-8?B?Wmg4VGttdFZWb2Q0VllodWsxbHl6OG1yc3FqNDdUUW9vVCtOeCtXNG5leHZ1?=
 =?utf-8?B?YnllWksvVUlCMkJ1K2c4SWUyZGtTRVNJZTVEeHNUNDlYcEVFa0lrM3lxYkdk?=
 =?utf-8?B?Q1dkWTJwK2RlZFBkQk9mWEVFMnBFcFZUQnZwc3Ewejhwb3FLQktUVlU3cUg0?=
 =?utf-8?B?R0Z6VENER1hUTE1GeXRiT3dQbmoyQ3NmV3cwS1NJblQ3YitxbHpudGVWd2VD?=
 =?utf-8?B?MmdrYnFQSTQ0QVVsWFd2QXNFYVkydndlSVpiWFBndERROXRFLzQzcGEzaUtG?=
 =?utf-8?B?TUtneWhzdmEwT0xYWldqcVlkQjFQcEJCQmdYU3NSaDAybjVXK1h0NUVtWHNp?=
 =?utf-8?B?d0lpNVpuM1FoN1IzeERQcUZOTHo0bXJrQ1NZNDFudEcwTVpoTXBYVGMvRlkw?=
 =?utf-8?B?b2NLU2pIZTdPQkl2bkxKaWMyNzR1Ym5ZcVFRNzJQOUc1Z0o2UXN6eCtIMndX?=
 =?utf-8?B?QTNyY0RIcG9kN05IOTZvL1lVUkJNaUQ0eXBadDUyZXNldFIrUkw2Um9ENjhX?=
 =?utf-8?B?S2NVSWYxajlXa0w3RUtqeFE2bC92WDZsc05oMWZCK0hHZVlhZnNBMkIza0Zv?=
 =?utf-8?B?YVo1bW1aMjJ5NmVxeEIyQ0d6UTQzcWhFSC9aQjZOUE9UK2VPbXZONExURTk5?=
 =?utf-8?B?UHlHdzgvMzFKRFFWbyt2T0dodjZ6eDNSY1RCRFJQQ1JNWmNZVktBK25EVnF0?=
 =?utf-8?B?bTh0TEcrNk1SY3BOWXRrNnB1L01OZnlqZVdKR09OTkx0U2hiSHgxaURtM1M0?=
 =?utf-8?B?YVptZisvZW5ZZ2Z1d3Q2ZWwrTkc4VmxYalFpbDJqNzhYcEpWYUpFUlVzNTZ0?=
 =?utf-8?B?c3JBbFJvcFUyT0l5Zk9zeWVONS9mbVIzWU52bFNFcHN3YWMrcUZUenRIbFpX?=
 =?utf-8?B?QTBrMEp5NE4xVmxWSEdCeGU2WW9zdnJTZjd3OGpRZzZha1ViSW93UHRXNlRW?=
 =?utf-8?B?aUMrWm0vbkpFRU1oSkZIb3pkSU8vOE1uTElCeVMrbjRNWGtYYmg3RWVFYkpL?=
 =?utf-8?B?cktiUHZwRjdXRW9kZWFxY1gzamRMM1NLRzJnWFdQMEUrb1dSUkZsMTZWcUg1?=
 =?utf-8?B?eWpYMWdJUzhUS2JEU1E5WGtmT2drZWRtd05rQUNJalVkME8vc0FLUUpuRWdj?=
 =?utf-8?B?MVJhOWRMMGNNaURvV0lIRllmdzkwYVBFdlBoMHRLL2ZtNGhTSzBlMHlUdS9D?=
 =?utf-8?B?dHBWSDMwT2YvYXJGOE9XbFZ4cTdrR3d0YXZmT2N4SzlNNXdyRzU3UkFyMVBP?=
 =?utf-8?Q?C6EfsNBPPZriTkTuNM5wcKZkj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B114568058685A49BDB933FA42FE7494@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ac1159-9690-4540-cabc-08dab6af3397
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:34:42.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmgNjU6octRRNB+DDsxgcBOtMrJihE+akOe3Mhq9bjsn9pcrDgs1jfyZ0mYX8/HBcO5qR97cup8vsvFBs0+Pzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_103448_159627_254D2E57 
X-CRM114-Status: UNSURE (   9.33  )
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

T24gMTAvMjUvMjAyMiA2OjQzIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBudm1lX2F1dGhf
W3Jlc2V0fGZyZWVdIG9wZXJhdGUgb24gdGhlIGNvbnRyb2xsZXIgd2hpbGUNCj4gX19udm1lX2F1
dGhfW3Jlc2V0fGZyZWVdIG9wZXJhdGUgb24gYSBjaGFwIHN0cnVjdCAod2hpY2ggbWFwcyB0byBh
IHF1ZXVlDQo+IGNvbnRleHQpLiBSZW5hbWUgaXQgZm9yIGNsYXJpdHkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCj4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==

