Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C343C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3OpK0yihw2/UlcoTQnpAnVMOc+4IzcnSTZO7hSGCfRo=; b=bjcbp0abl4pipzKX1qFnO8ipNi
	/B1uszJvYpvZNyLHd58tBdpBT1+7rfIlgH4WQCiPwvd4P256Xilnp1qDRNKBAEowaz6wAbhSyyFCT
	ISIz9eozsNH6cyk9x/kevRtVQmL+73znFGHikJwCQ62TaQvT1T5vVtHoFNEERIPHDMj8h80Z+h8zf
	iVlFE+otkDDbRy8VfpHZNgZ0nEPv/cnmOeOvyfwWUYAzpzFe8XVLGUVY/bhTNMFCAVzIi+wf1QUJl
	1ZyOt5zFOABvYQbmVSUNmaxQ78iZHsI4Q5EMN4ISj/tkaPrvW1sxAm8XjK3sXn60E4dfaQNj27wbw
	6Om564iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVK1P-00000005v7r-3JK1;
	Wed, 31 Jan 2024 23:29:35 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVK1K-00000005v5b-374H
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR4Qoas30grY/iNMgWBfckQhR9YGRqwsz5tU97HgmOvRJj1oJ7+olrsRv8eRU3Gafbg8nZHtF+I41SOiqIlCOwz0l+fQYKnqxL82+JCkUmXw3PR+wuOO1GaVepY92VHUDtCgDBmo+ULKu6vhqeR2pGaAG6CWBTm3UfrQ9xlmeB6DsNhQhye/myrvO4J5Uqs7mnAzr81x0Sb1IZdCe7T9oZnSywihaqxwhbCgY2p7bwlBVRUr3wLKLZ1VneQHeE3/h4qrkKV5yWEZUi2N2fhrzGrmT28pyd871qHDebR1qwlGpAWtYZloWeHurMravfyXz8ovOVJo2WTFJssVwZNqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OpK0yihw2/UlcoTQnpAnVMOc+4IzcnSTZO7hSGCfRo=;
 b=U8a1LIQ8PUTvTzJScbCYuzaZRcddpiwpKKwbHK5b3KmtFAQdCPU6371SMEQwsnWH/Y+qP6b9iJPq1ZGx2BzL6BMQZI14WWkdbwMD8ReSAaVY6TWiMANzeu/bVDRCOOcid4tOgGNBOBvSUG3p1qzRgFJa/5KTKkTXzQMeAa3XN8ejaF3PNEQY+b6naRDEvtFuNwq1pLuFED5Vzc7Fg3vgcA/TIN/kjC5878gKBS8LavVYGcafb/3RKC8m/PHK1MDJuH+VLgCtssf09Pwdh0JcjO5uFhyrn8tBbIglF5l6rpJPkaXvUuCNpPZndjcp9BgO8VijFZuktYNh43bbT+ybJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OpK0yihw2/UlcoTQnpAnVMOc+4IzcnSTZO7hSGCfRo=;
 b=VnKhEn0HTs3DcTdEwM3m4kmBvyJ+yIi8eskKERPVgkJLuxDkLv9wgC5fi16sY3SgqjjgRb6TLbW4GkL1GJy6aSvSBTXeHIUn7vAiq2EpLET6x+tTBZZ7B5/Ns4sQ04LZhfDRTla13krDlq7xIPxXPoXDjkrOd7SYmQW98oY9AugoJhH5ycp9Z9IYGhSegoVD0hPomnJDZUVNuMkMBb4+fHsh23xUeY04YBgSInYH0PQVo7zHfl//mstdlB8soPFtMZfmQhkeZj1ieIZVO9GJc8M/DzzO4zBp2BmB3wOm/MoNMwGYCNIbzXN04/7FLMGNXDQ5idSQb8rDosm9Tu5rFQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:29:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:29:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 06/14] block: use queue_limits_commit_update in
 queue_discard_max_store
Thread-Topic: [PATCH 06/14] block: use queue_limits_commit_update in
 queue_discard_max_store
Thread-Index: AQHaVEYS4wyl4wqFBEiDI4llfJgeh7D0khwA
Date: Wed, 31 Jan 2024 23:29:26 +0000
Message-ID: <1a75a49c-e26a-4536-9a79-e42cacbc2e38@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-7-hch@lst.de>
In-Reply-To: <20240131130400.625836-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6317:EE_
x-ms-office365-filtering-correlation-id: c8eaa568-2a98-40b6-e89e-08dc22b4773a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLX0fq8u2aXBttQaEujrmq54k4ROWBsIcWMlhck2jaUWNUBYkWmfgI/FZBSnnh4zvZVmqhlMjHYAoJclfmob6sPDZudCmLez8E35DxjXs/pL+V+MRcQJTmU85TTXTyMfIN00YepZ9DwL5aDsRKJAUiPCDPLNTjl760nhKOYaJW352N0dE7djbaIV6D7uG6KhrzssIdNIbGqTIr3jOrIHk8YSdnhVHMqEyVLEfoL/Xo0FO+cto4isAp9AwAc+QnXO4bGSg6y9i+RcmE6BKxlVSce73Yw+tm1o6Lnd8Fip0UhYFCxuZoWh9ogYq5huHupYj/FLamkhUflOeHI571n7rPXJLqQf9iRSwn0SDgmxoYk4yQno1/XtaUZbVqsjwqbNNZqHFg0Uwb407qoN0NCSZIuKgtRJvn5RN/bNNeefJlyLyjuxr70r1/l1SEv/vS6RZXWz5VRUEKs0KVdBrpkDYHwyY5Z67Zz6GStduBZ2gvwKj5b3o4wU3NGujsuOzSd7sthOd9yg6ixWCtj4LYn4n3UH/6XJmbWOct6aguaRG1PDegAGRlu/J+f+2VJbarnitJnMV41J2jAosmjMDLuxeZbamPMJ1wcejtoHnnFuc7BE8/BlqD0QH5dihBqGWh4eETdMKj4T/SpPNCd4cAJ2DrhZ2v8SlrjzMZ8pW9PKXTVN/wKoQzsoCPN6DLDDlRHE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(2616005)(31686004)(316002)(38070700009)(71200400001)(478600001)(53546011)(6486002)(6512007)(83380400001)(38100700002)(6506007)(122000001)(64756008)(54906003)(5660300002)(36756003)(7416002)(86362001)(91956017)(110136005)(4744005)(31696002)(76116006)(66476007)(66556008)(66946007)(66446008)(4326008)(2906002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azl4aU9WbUQvWWIyVVgwNEtobzRKV2RueUtGdzI0ejNhcVlDNjFoUWdBdVhP?=
 =?utf-8?B?aUt2LzNHSnE2QWsxK09IeTBaWk5DelZYMVFqY2tDb2FEYitseUhTV1lGeXVG?=
 =?utf-8?B?N0srVzREdVpacUc0SnhRbW5DNStJUjNqYytJcWt6WTZDNGloU1VSUDdzM1Ru?=
 =?utf-8?B?Tm1xMk1vU2VmMkt3MHo5ejJxTmo1YWJMZmFhek1EZVdES1luSDYzb3o4YmNT?=
 =?utf-8?B?enpyRDdvSmhOR1JrbWtMYk5FWTlmekplQmgwUXRycnYwK25zRzA3bzVFZXVn?=
 =?utf-8?B?bzJHcmpJY2JqT3RjL25PNmFOdDBUZG5CNGkxUzVRT2V3Y2x4eGdaVXNHNnRK?=
 =?utf-8?B?RmNUNUdibFgwdXRHazBSOTNkNDZpM3JxUmdQY3ExVmdSZEx1cForTVBISDRi?=
 =?utf-8?B?RXZ2dXVWQnNIbDc0S3lmRlRZQVhrVlBGNmtvdmJ0aVNqSjF2ZzJJWlZNTjdM?=
 =?utf-8?B?VUV1aHFDaE9VSXRMMzZoNGgvc1YxZGNyck5KRWJKQ2FsYVpQTk5rRnlMVWZQ?=
 =?utf-8?B?UG9BQjdkcXpBUm0wNFNqWCt2NUg2ck45dzQ5UVhDemNGcVhzMzkrQVpGNmFV?=
 =?utf-8?B?YmMvMktMYmJpOUVvczdMa0FRNm1tSGVNMlZFYkVJdzVRVTV4RVdDcDNaenF1?=
 =?utf-8?B?OTM3WjMyNlk1eUdQMDJLOEQza2pZNERsSDM3WXM3ZWtubjhnM0JuY295alhT?=
 =?utf-8?B?SWpoOTZtYitUN2JPTUpFSGdIOEZJS3dWc29PRjZDNEVVMDVZM2Q5UFZjM3o1?=
 =?utf-8?B?NnJCQWlGc0F0RjJIQ1R1T05sMkxYYUFuOWc0djdNWlpnQ3FrZmh6S094Mlhu?=
 =?utf-8?B?Sm94QkZMSVI0KzFMMGZCaFJrRjZkZDQ5Rlo2M3Z4b21mUXpSMEFBNEgra3Qr?=
 =?utf-8?B?b3hENUg4a01tbWhzRC9NZ0IrR0FTc09VWEtFNUp2N0RKaUFPcGtHQVhCaHFk?=
 =?utf-8?B?ZVlmZm5WRlZBaERCQ2xBeXhmTUIwUDRrQVZRc1BOOEhjTnJsOWV4a1NiMEtL?=
 =?utf-8?B?M1MydU52VkxubGFWdjdGeDArSHZESCsxWE1IdkliVFBqTmk5MjVqTDl3UWVB?=
 =?utf-8?B?eUVpcnVGbU1iUFZEdFdId3VhMkpmSnZYWUUvNG4zeDV3Mkc5OUthYVFOL3NX?=
 =?utf-8?B?VUFjNC9HZS9XVmpRVFc3VkVjRHZLclZCUi9PbWtUZmpVNThxb3h6ajJhSFVE?=
 =?utf-8?B?em5NYUFhZkVUQncwQVc1R0k3Ukdyc1dsbVVRRzBNdVBCZFhyOGJFZVA4dkp4?=
 =?utf-8?B?a3ZaaGQxVVJKYTdyWlZ6aFFqU2hHckVOdzRSbDV4M2ZORDRpQXZtUjZXZHM2?=
 =?utf-8?B?UWRCM0tpakJtRHk1UHFhZVQ3aWlsSk1BOWRnMTJENFZUVmlOaEhXYXhRRHBM?=
 =?utf-8?B?Q21ON09ZS2FRSE9XUzBtN29MSEFUV2lwZGhuNm9MQ0hNRVRJU0YvK244ZktD?=
 =?utf-8?B?bGZRRjB5L0dQU2hDOWJDSXlmdjd4WGhSQ3hVZlBJSXphK3Q0ZGtWdkwzZGtC?=
 =?utf-8?B?SGdzV2NOSWR3dTJwWXBMK2hWS2Q5YlBMWU9vdjFaMXcvUDRPM3BNTW1UMDVI?=
 =?utf-8?B?MU9XWDFIdUxkaTVpZ0U5bGZBc0Z5RDdBL3Y1VldKWUc3cGd6bjdkQ2dqQUMv?=
 =?utf-8?B?d2s5RGpuTjM4OUR6anhkdVRMa0NvTWU3bHo2MytKcGRtSlFrOUhrQURtZDZq?=
 =?utf-8?B?KzdEZ2xyeWZsczVTbnk5RUhPWE15N3BEdWtXMzlXYnRQUkQ3cHJBTW5PNFhj?=
 =?utf-8?B?MnpxekFDSlgvUTdrL2RFZG1wZ21mcmZYbEs3dDBxZW1rcXdic25VV0g4Q3hX?=
 =?utf-8?B?M1l1Zk84Nys4a25sR2p3R0thOWwvQlBodjgvSlIzOVpQL0UrRDJKTitSYlp3?=
 =?utf-8?B?azM3SnByNThHdVhvWWhhbm1VUWI5S21Xb2Z1M0h2R09HcjFsdUlmaDZGWlEv?=
 =?utf-8?B?d3hqRWRSUnkzWENKQzVXRWRJcTBoS1dLTEJ3bDdZUlIrUlhRSjBvd2dhM1do?=
 =?utf-8?B?VkRodUdzN0dFU1Q1eEYxcFFIdG40WFVHbUs5bDhiNGllM2ZpYmZ1enBTYTVT?=
 =?utf-8?B?d2NEejNVMFZNVnN5emlqUS9haVpoZFA1VTh6K1FTWUVWZStIdEt1RXNDQjV5?=
 =?utf-8?B?ZExUc2plZU50b0U5YkpQaGdjR2dDbDRDWllDK3poMjk1dXhVNWxVajdtZldR?=
 =?utf-8?Q?8fDMY5mLh2pxKKw0Sak4FVsjkIM+SywA5SZYYRrJCnlq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D9A0A5FFCEAA4DAD6E520862B62963@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eaa568-2a98-40b6-e89e-08dc22b4773a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:29:26.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxIgo7Pd1zKsim6PTlbR/cu00ggH01Se1AOuU+SZEpQbmDQpnLsKygZ3cEKEVdBXSxpkUN41OmkSlomeIcTDJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_152930_899141_240D585B 
X-CRM114-Status: GOOD (  11.18  )
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

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IENvbnZlcnQgcXVl
dWVfZGlzY2FyZF9tYXhfc3RvcmUgdG8gdXNlIHF1ZXVlX2xpbWl0c19jb21taXRfdXBkYXRlIHRv
DQo+IGNoZWNrIGFuZCB1cGRhdGUgdGhlIG1heF9kaXNjYXJkX3NlY3RvcnMgbGltaXQgYW5kIGZy
ZWV6ZSB0aGUgcXVldWUNCj4gYmVmb3JlIGRvaW5nIHNvIHRvIGVuc3VyZSB3ZSBkb24ndCBoYXZl
IHJlcXVlc3RzIGluIGZsaWdodCB3aGlsZQ0KPiBjaGFuZ2luZyB0aGUgbGltaXRzLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQt
Ynk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=

