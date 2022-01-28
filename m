Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0291BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6vyoTg5kHlY9r1jLn/Px0X7uxuGSqEOQTf5zDfsyFss=; b=wyNnofDwlTjAR4P0WGdAO6FASt
	yAOHb9/fwNaiL2NtXDQYcGqluR8UolVofWqcVyySSkXQB80+yQZQjFT2+QIbfzvFIHoRpPbuFa+gR
	x/oz/U3mQHpX3UuLsxsEVrD+sdb1hqLaGg6mhxvmg5WDwR9uCz1Jqf1gq1AsnjExIrW4DUaryAhA9
	idw1UPT0u7ar1ay+CKAoKZ1O3x5WuPnqqYC8Rfx/tOObKgXv5cQZxi/u4Nt7iTNOQlWcHhV285O6O
	dUssamrzFdK/YEz+SuE1BehQvGEHztFs/ktlrffQdegC0oI8Tbr6gTuHQdIjJNuC6GFkCtY//jzlN
	dKmmN99A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNf7-001Gm9-Sv; Fri, 28 Jan 2022 09:35:22 +0000
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com
 ([40.107.237.43] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNU4-001Dvb-D1
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwXr4EPLhKJ88stXrmojcJM5kQE3RsdgVf6lsvxHYUANE8CLiXYSt+g0UB2F9f5AijT0srRiLbCZxloIZ+2MxlwhJjEizxkSBdEsK9ILTEBPkDXCMMBcOl+qAcIiYxX7Sf98EpN/dydAyY9KkBsUtlVasTD3JOa02CUHMZgb2apP4vCMRpqON3OI3LsNLSZtH0G9JyhCUSRmhDgu86waIGdDYNDc2i+10k/zAu+PDQdCrAkTq34FM9b0m2umbw3nrk37EYPUkWdjqCKBYbGtQqyvX+sjT1oFb73tOvlLQBPw8K410CVk4KuFWq2Vn5VyEfyFo1ojfqI6gTITgV1Y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vyoTg5kHlY9r1jLn/Px0X7uxuGSqEOQTf5zDfsyFss=;
 b=jpqeHVp6NyOBhDuha31yntwZeJZt6EMxs/MB1e6/oti3lnZ7YPYZFH+bE4W6xGJPzeUUjmlfrTo/X0rFALMakcDzTI4Xjw86xgVhDRKlHbeKAMYvcgZF1BdenKXdTuUoEX3nJQOK8bBN7l2vncSGPWBMSb7xj4qG0ij9l7iC+/CgRtIevjk+ix4JRmP0nI9V88WcLD8BQTacIDf7JY0KtfbribiWU074WQAhKZtR7iuNlfbCKL6DpJc2tv3fSBonN6NB9HRURpzI+W7l2biV11Q9frCxJPdChV6eqpUdH3H5XjyxptppvQKo+ZptWZj4EvapqM8AO1+LoEZi3VPdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vyoTg5kHlY9r1jLn/Px0X7uxuGSqEOQTf5zDfsyFss=;
 b=OJxPT7y6Kak/8oUI02Nf2I3AQRqpxVHM7xv2TbgiitSZRR6dE7CeoMjuTQNEj1+h8b2hyfv8TtyrCUFeT4IZNcTxjH1fJ7QSc4Pz5ptjSfbvsui934OqiqzSjm2cY3r+g3+dWM7sAzgJvFHv5AN7tv+rDemtDROHL1WssoRbfSNtdbv1rlt08fTrkXFRjuKjBAUL8k4+9Fq1UfUw8XqS8/SR8s0j3EPQslCUaf8FVOVOaA2LSd2Logea1uM5SaLo1Z8aEv2VLSYYzlrFJ4Y1Q2YFAu19IXxX72uyjrK6uGudCOjfATMdFeVr5WLbj9exwavFRXoCxy5XiBm5FIacFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 09:23:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:23:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
Subject: Re: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Topic: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Index: AQHYFCh95lgiCCmEvUGD5FramLij8qx4KTeA
Date: Fri, 28 Jan 2022 09:23:53 +0000
Message-ID: <e5566c46-708c-504f-f35a-39a1ef11786f@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-6-chaitanyak@nvidia.com>
In-Reply-To: <20220128092015.19289-6-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39b94ea-e35b-49a9-203e-08d9e23fe722
x-ms-traffictypediagnostic: DM6PR12MB3658:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3658C039D2DAA5F3ED4DBD67A3229@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mK3ANGTgpdCnqlPL6qG/jn/WqoPYINpXX6PfOnAoKyEClNzT59weilJk+z3Yuy/6u/ZpJpUL9SJttD5tcHmUBe9aVc8P7jrnl4C+TXrB6umH/R+guUwLMx7wNBnAg+E4hx53EAWGuCbTb+UGlO2SjbNZyroBez0nQwdNXqsiyPZENJwGPkggg9I9ByKNisy08owsI7khSZbANJp9W2ZJ8OpTZfDworjiwvyyWQ1k0USPrn0fZ8EnkOg5mMe5l++uaroQ8m+WPWOG5tQnQ8tw7D6AjeDV7Hktc2YleQmjFyrbmD3wn7RnmoBInFC6fAPtoFsnkH24vI9q9TlJ4yTBKXgYe+AuR/RSl5g4hOm6Ftbl4HBy5gRUjZw3B6FHjQlL/A+U/GkNx8nx4+zzAwgW0/tr8EgmI5q/Cj7S93fxOXFh6qI3xP6TF9Os2xqFIzHF0AD4Hlm+gVIWxrs0FvA/ICZiRQydLl41/ku20QrhZ1evwh4QMbBEKdr1NOpb52UUOLFm3EVSaGAJtQv5s+HQW/WbSOPbzXHF27MW514c1GtqTI09CgVRBGP+QS2JWa9XhHLZmK4DDIwi8hXbeJvReSl7JOeX4CyYwKxNSEF/Mvy/rphPhAzL9qBeuCwvDsEgKBiGwiPtu8kJVrOKLMmytGsr/QqWmnC5vkrnNV9yhvp9rjBQITU64JdlzSXwktt4Ked/qzkIZZgAUQKAhXwZqx3D+jIGpNvdbQTio06GyNFiDNLJjRlYgrKP0goODb5ej5rKcKetDPGF4pAh6eJJow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(31696002)(86362001)(122000001)(66476007)(66556008)(91956017)(76116006)(2906002)(66946007)(4326008)(316002)(54906003)(66446008)(6916009)(8676002)(64756008)(8936002)(83380400001)(5660300002)(186003)(71200400001)(6486002)(2616005)(26005)(508600001)(31686004)(6512007)(53546011)(6506007)(36756003)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3kzZ0JkYUlhN3JFTThIVGFoRjVodFJHSEpJenhGZXM4ODFlekpPSmNOdDNW?=
 =?utf-8?B?akY5cGJCUlN6eXBOeE1CalhsUUlyNEZ4Skg0eU44QmdZNUZvenVSc3RWckdZ?=
 =?utf-8?B?ZHJKWmRZeU9TNWpBRDRlcWp6V2E0alhtK0FTWkpqRk44OFlpa0R2eE9MVzAr?=
 =?utf-8?B?UXJkWGdEMnQzdDlXRzhsRllFcmVtWWlndC84OWFIbjU2ekpVNW9KbE9XREI3?=
 =?utf-8?B?bXF4QVF0bjllV0pmQzJCdUc1MjVRc3FHcFpVQ285OUllYlMxL3IwZ3orbG9B?=
 =?utf-8?B?bkQxc05EQ0djaWhWSWtoY1V4V1hOYVRCd3NadTAxNUw1amFtYlc2N2VnR1Q5?=
 =?utf-8?B?TnRadVFmbjlKaDdCN1ZjbUw1cktjM21hVjBJVE1DZTlTK2U5N1JyU204ZjF0?=
 =?utf-8?B?VmNRNUdoc2t5V3k0YldZdVdqNjY4T2xiTGI3NFgzWkZ3MEpNL0tmTVhSTnQz?=
 =?utf-8?B?R0JmekRFamlJZ1RzRlpmNkZZRFk1cHM5MUZSaWFzTFRSVTFlTjRCMHYrSXpJ?=
 =?utf-8?B?Tk5iTWp6bUV3NFMyK2tqdjN0WVRhamdaN29FaWhnZnI2M3F2WE5FejdvRUlh?=
 =?utf-8?B?VFdORmRJdWxVQ3huQ3FqbDNXaWxFL3V2QnE5NXJucDZuUDUycXZtSkdBSUxp?=
 =?utf-8?B?S0JNVitNcDd1UjJadVNvQXFINUFBcUlONmRNTkdVMEladWltWTZzQjBKMXpz?=
 =?utf-8?B?Ni9BWUNJWGsrck4rSlhRMkNkbDFVMWpJTFV6RFZRNTlOeW5QRFJ0NnBwQ2ht?=
 =?utf-8?B?TERZMERaMGVlTnRDN2N0cUZJWDFyZ2hSVjk5Z1UxSXZnb2taNlQ0S1FtbUhI?=
 =?utf-8?B?MEc5bGxueVJVOVlqWVhKR1l3NHhHZzlydHl1NDhpYTVVVzd5dWFpVzQ1cEhS?=
 =?utf-8?B?RXpCN3hLS0RGNHh1WVBXT0lXOTlNTll4cnhxYlZGeldGRnowc3BUdTVxN0VE?=
 =?utf-8?B?VURjT1d5a0o0REVTeVgyWm1BZ3ZNQ09KWGtMNlRhQjh0Q0xpVFRsMEU0S0Rs?=
 =?utf-8?B?RHlGbzdzMy9mNEhBMlAxbkNXTjBEVERxTFNvUW5kdDBJazFsSHJtS2N5UU81?=
 =?utf-8?B?SjBPMGg2YjVRZDJDWEZ5MGRCWTF1eEMzMDNNMUVxZW1NTDY0a3BIMWtPRFpJ?=
 =?utf-8?B?TGczQ2JuQnZOZmJJc3ZSZURCV3hHSG9HRk15VnJTeW5iTEV5VG8vU3VNbi9n?=
 =?utf-8?B?S2ZVeUxqS1FTWElkdVo0Tlg1SnFJNnJXMklVTjRDanZvc0Q5ZWFXRG9Pc1Q1?=
 =?utf-8?B?R29mQnU5Vzk5cHg0dks1Q0wwSXdmWUlpT1g0ZE9WZGpHanRmd1puTDJoK01Y?=
 =?utf-8?B?a2o4dUt0Z1ZJWThZTXIvQzgzazQvNGx2Q3U1bUdteHlJUjRyUTREb0dFSUJ4?=
 =?utf-8?B?bWkzeC85elIzWGJkNDVtTkVUei9RaU95MTVGZ1pBa2dLejZmWm92QmJFN2Fq?=
 =?utf-8?B?a0tFWXRuRGtLeVd4b3V6RTZZYktPNklBaStTVHVzUWhCZC8zL2xycXlNVm02?=
 =?utf-8?B?SzZDazQzSWZmTmh4UHNGanNSN1VQaCt4YkFtd2F5cUNTQ0Y5VktsV0NlWElx?=
 =?utf-8?B?eEIrVFNsQWt5NlF3aWxBRm13bHY1aHVPOHRsUUdoUXpxN1hEcGZWU1oxUlQv?=
 =?utf-8?B?djEzL3hjSERuY0d4dnRJRmFyOUdsRmVuZHgzMTd4Si9SOHNHU2FEd2gxb3BV?=
 =?utf-8?B?OXBSckRFYi9odWZTTzlFQVJwME9yNGF6WWF6VCtEWEI3NFNETVRBS2lhaG0r?=
 =?utf-8?B?aFliYlFxcnE4UWFBbkhvUU5iaVZHTzVxWHN1eTFrdGpNclMwdktxOWJjRFUz?=
 =?utf-8?B?eEM0ck0xbWJUaFlhYlJkc0VuVG9PZ0lmbGtJT1FQemR5aWlqbDR4OVgydW90?=
 =?utf-8?B?K3BEZ0FrNUw4dmpQNDg4S0tUTUtwNTJMazhSRFQ1L3NHMmdMRCtwZTJUUXBN?=
 =?utf-8?B?UkFyaitxMTRLb2htcE5PUU1UWmZxOFhZRmNwTVJndUY3alFaRWJxYXdxV2hn?=
 =?utf-8?B?aHYzZFV5aDBtU2Z4VWlKOE5EZWFjbWdQVm9vS3hMcTVJQmNiRTIzQXUwMTVQ?=
 =?utf-8?B?azhyaTBYU0NlWmZEcDB4ZXY4eXEzOEN1L2tIZnZzcXpiUWxrR0lMTmhNL1pi?=
 =?utf-8?B?bno2MVFGY2JtVWtGZm1SUkZTVGpFdmQ4bk9aYVBYYU5iNVhuTkFlTkRKZXY5?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72A92BEB882D674E980A6128AA1AB336@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39b94ea-e35b-49a9-203e-08d9e23fe722
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:23:53.7132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVWxsi6UkkAtZkWB6xGmPhjgItC7TW2DP1H/MYraYwmm+SFhDs+B9Ya1Mb6jHH6Aw5flaIyO6c/7xnCeYpFOyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012356_487167_05033943 
X-CRM114-Status: GOOD (  16.97  )
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

KCtDQyBKYW1lcyBqYW1lcy5zbWFydEBicm9hZGNvbS5jb20pDQoNCk9uIDEvMjgvMjIgMToyMCBB
TSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBGcm9tOiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KPiANCj4gQWRkIGFuZCB1c2UgaGVscGVyIHRvIHJlbW92ZSBkdXBs
aWNhdGUgY29kZSBmb3IgYWRtaW4gdGFnIGluaXRpYWxpemF0aW9uDQo+IGZvciBhbGwgdHJhbnNw
b3J0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgICB8IDEyICsrKy0tLS0t
LS0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDE3ICsrKysrKysrKysrKysrKysr
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9mYy5jDQo+IGluZGV4IDIzYzg5NmExMzhhMy4uZWMyYWZlZGZhOTkxIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Zj
LmMNCj4gQEAgLTM1MjksMTggKzM1MjksMTIgQEAgbnZtZV9mY19pbml0X2N0cmwoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMsDQo+ICAgDQo+ICAgCW52
bWVfZmNfaW5pdF9xdWV1ZShjdHJsLCAwKTsNCj4gICANCj4gLQltZW1zZXQoJmN0cmwtPmFkbWlu
X3RhZ19zZXQsIDAsIHNpemVvZihjdHJsLT5hZG1pbl90YWdfc2V0KSk7DQo+IC0JY3RybC0+YWRt
aW5fdGFnX3NldC5vcHMgPSAmbnZtZV9mY19hZG1pbl9tcV9vcHM7DQo+IC0JY3RybC0+YWRtaW5f
dGFnX3NldC5xdWV1ZV9kZXB0aCA9IE5WTUVfQVFfTVFfVEFHX0RFUFRIOw0KPiAtCWN0cmwtPmFk
bWluX3RhZ19zZXQucmVzZXJ2ZWRfdGFncyA9IE5WTUZfUkVTRVJWRURfVEFHUzsNCj4gLQljdHJs
LT5hZG1pbl90YWdfc2V0Lm51bWFfbm9kZSA9IGN0cmwtPmN0cmwubnVtYV9ub2RlOw0KPiArCW52
bWVfaW5pdF9hZG1pbl90YWdzZXQoJihjdHJsLT5hZG1pbl90YWdfc2V0KSwgY3RybCwNCj4gKwkJ
CSAgICAgICBjdHJsLT5jdHJsLm51bWFfbm9kZSwgJm52bWVfZmNfYWRtaW5fbXFfb3BzLA0KPiAr
CQkJICAgICAgIEJMS19NUV9GX05PX1NDSEVELCBOVk1GX1JFU0VSVkVEX1RBR1MpOw0KPiAgIAlj
dHJsLT5hZG1pbl90YWdfc2V0LmNtZF9zaXplID0NCj4gICAJCXN0cnVjdF9zaXplKChzdHJ1Y3Qg
bnZtZV9mY3Bfb3Bfd19zZ2wgKilOVUxMLCBwcml2LA0KPiAgIAkJCSAgICBjdHJsLT5scG9ydC0+
b3BzLT5mY3BycXN0X3ByaXZfc3opOw0KPiAtCWN0cmwtPmFkbWluX3RhZ19zZXQuZHJpdmVyX2Rh
dGEgPSBjdHJsOw0KPiAtCWN0cmwtPmFkbWluX3RhZ19zZXQubnJfaHdfcXVldWVzID0gMTsNCj4g
LQljdHJsLT5hZG1pbl90YWdfc2V0LnRpbWVvdXQgPSBOVk1FX0FETUlOX1RJTUVPVVQ7DQo+IC0J
Y3RybC0+YWRtaW5fdGFnX3NldC5mbGFncyA9IEJMS19NUV9GX05PX1NDSEVEOw0KPiAgIA0KPiAg
IAlyZXQgPSBibGtfbXFfYWxsb2NfdGFnX3NldCgmY3RybC0+YWRtaW5fdGFnX3NldCk7DQo+ICAg
CWlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2
ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gaW5kZXggZjg2NThmOTg0ZDY0Li42YTNmZDc1OTQxNWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9udm1lLmgNCj4gQEAgLTkzOCw0ICs5MzgsMjEgQEAgc3RhdGljIGlubGluZSBi
b29sIG52bWVfbXVsdGlfY3NzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAgCXJldHVybiAo
Y3RybC0+Y3RybF9jb25maWcgJiBOVk1FX0NDX0NTU19NQVNLKSA9PSBOVk1FX0NDX0NTU19DU0k7
DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGlubGluZSB2b2lkIG52bWVfaW5pdF9hZG1pbl90YWdz
ZXQoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQsDQo+ICsJCQkJCSAgdm9pZCAqZHJpdmVyX2Rh
dGEsIGludCBudW1hX25vZGUsDQo+ICsJCQkJCSAgY29uc3Qgc3RydWN0IGJsa19tcV9vcHMgKm9w
cywNCj4gKwkJCQkJICB1bnNpZ25lZCBpbnQgZmxhZ3MsDQo+ICsJCQkJCSAgdW5zaWduZWQgaW50
IHJlc2VydmVkX3RhZ3MpDQo+ICt7DQo+ICsJbWVtc2V0KHNldCwgMCwgc2l6ZW9mKCpzZXQpKTsN
Cj4gKwlzZXQtPmRyaXZlcl9kYXRhID0gZHJpdmVyX2RhdGE7DQo+ICsJc2V0LT5udW1hX25vZGUg
PSBudW1hX25vZGU7DQo+ICsJc2V0LT5vcHMgPSBvcHM7DQo+ICsJc2V0LT5mbGFncyA9IGZsYWdz
Ow0KPiArCXNldC0+cmVzZXJ2ZWRfdGFncyA9IHJlc2VydmVkX3RhZ3M7DQo+ICsJc2V0LT5xdWV1
ZV9kZXB0aCA9IE5WTUVfQVFfTVFfVEFHX0RFUFRIOw0KPiArCXNldC0+bnJfaHdfcXVldWVzID0g
MTsNCj4gKwlzZXQtPnRpbWVvdXQgPSBOVk1FX0FETUlOX1RJTUVPVVQ7DQo+ICt9DQo+ICsNCj4g
ICAjZW5kaWYgLyogX05WTUVfSCAqLw0KPiANCg0K

