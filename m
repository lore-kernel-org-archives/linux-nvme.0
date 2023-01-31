Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45DCC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Um1xSdA5MS8D4sDiju7JOrb9WcimGQ0N4yLubUfWNk=; b=zqp8QHUem/9DLR0AUnJV8u+/Zm
	WSunZYgAaXD7+vr5dK5oKViBl39dEw8lRoUgwKjxUK/Ue/mS4WQrns8c8Kv6uahRnx5+1o3XVIhYd
	jyHT8jHuIkFwCbV9PkLBPnv5sb1MIHSVllf29CLCFc/e2ERx5nq2LLXt0mqCePuOXl9bNxnB/dgQd
	/e910x7nbN+6U3q9FtIbXl2iSNWD4fRxR+0tsfw4B4B8hXFqYVghx/8S5SYFitColu9AGr2TJw8m2
	GlWOwHCY6co8pU7c9KFJjBMfC4lU+Od433c0phFG6vgWoX1O7rObKwYxHDfcPfmNvjv1KJEi8F2lS
	mIw2uuVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMyMS-009Qe6-54; Tue, 31 Jan 2023 21:40:16 +0000
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMyMP-009QdV-IV
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 21:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZFBIMWS+lM5BSYrLume5EHHLGGHsx0FcUBvN5oawO2bMio6SrYiHizODQyJ7rwPmldXWuHPvGMHyR0k3Xz8fSQgT8zUqb4g+Vd3bdsoBLxkBEmDod0DSx7sLgHWW8wnWsJkxvHFof6XDvb0lJZOu+Qnj2CNAXxlGAOiX8VF5zNHWs+qE2E0mWy6EhqSgyRcJTwq98kKZjvaeyVjouSk48Pac1qETbjinzw1rHbHrjtFAWfeFW+kROZswpVsS3CNyoYoAvZOKFMXBPK67CzPRcq9m1Jnu8uM2R5O7ZrlgZyi6VHET+aLDSUBKxYj9aRq36fZ358sOM0S7w+84zkpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Um1xSdA5MS8D4sDiju7JOrb9WcimGQ0N4yLubUfWNk=;
 b=XEKG+M2Nh0Ll2xFk0hVFlRoOqERsQpHZuVrfqsTwBbh83Xbt962Dit6sRb+Av9SGqZtYLELELngisSq2RIN9Mc2uLpO/tBxCcFnSqWIsTkBASEr6OkOfKHeFfYTgVLdjw6pFjR1S8+i9VxCvAocVZWdH1XOBxryGqdkSiz41dU4BShQKDLL/eUkTS9aUxFhZUw+7n6rwXVPJORyej4zXLsjAxNvkp0VM2YM/lPesUZ21obNfZaI0xwzxQ6TQSWFcMVkUagHl+/h6m5BJsFOXAg36vegVoGseY1X0n6hf2xB/hCn6RE7Mkjc3gXt0RdHMW/Z8Q0wd7mywMCDhpr+9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Um1xSdA5MS8D4sDiju7JOrb9WcimGQ0N4yLubUfWNk=;
 b=W22vuDNfws5IrDFbIjTLdjVjmjlrVegn3y/e/cwF7h/DV5vFoc27upkCb1LkUQEHyrFmKZJ7azIt+OM+JaImhSxkHgVKGI7909Fl8jJZii1msCtQKeeWPzw2yhwlZfN4KDtcDlvRRo6NeLOj/We+N1IQaAnjWD3lYkt5hyPdqrYoiYhK8dhUesFpA6q3J15SG+qdX0POVKFJGQqOMH/FDZgxr66BMM4i2Dbm8yslqXERFht5w441V6GSEE63Ks1DSk1L82cIGqzxDSAVMcwpbot2sYo4gq5yzFzhFmaK6Dt2GL1uMp4CRi+7NeIEOKUuzFmjt91vQEkVVWuca4iaqA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 21:40:09 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:40:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [RESEND PATCHv3 0/2] nvme effects handling updates
Thread-Topic: [RESEND PATCHv3 0/2] nvme effects handling updates
Thread-Index: AQHZMnB1SsJpq+J4mUOL6jEtPh892665FE2A
Date: Tue, 31 Jan 2023 21:40:09 +0000
Message-ID: <05321404-f51d-a1e5-d75d-1b37502ba0a5@nvidia.com>
References: <20230127165620.3487918-1-kbusch@meta.com>
In-Reply-To: <20230127165620.3487918-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SA1PR12MB5657:EE_
x-ms-office365-filtering-correlation-id: ca77d805-92af-4cba-f927-08db03d3b9eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  lRV9jlc5zeeirAZzAis48MTzU6P3ZmooTQHrsejv0ViD+qhvIiEWHkxNWbdlfc5FpCaJqHNNEjBlz3TGhvHXpSW0iLR++lJG6jgloQrLDzHbrdwJHJ6a+oSzo9WWT6PgdiNN3Yc6lk0050R69T7P0rVI3C0Gh5KDrLPwXQWpW4nTUKJW7TGJqBo/XCYyZrsX40i7OfGELdGNuNkK2qguJhXr/YGGnloitXy+FzSIKzScN3UuVTf4qd/bbsqLCQz0BgojyWokTt9zRtWoJh52EjYvCLPLTCSdy5gAGv1oXUQ7sOg7zKM1SNq2AAZJ2RsP5wYstCJYVOySZLLkU1IxHbCKjbmr50WbEDkXkBCtn00RN4q6Gv2ac9qHHmiRUQbv6q7nfuiga+QhjdjWiBcm/aU20HVxaMtPLMuZNTQvRBz4ewpmONAxts0OKpSZGMl0LwXZ8q22icisMM2bqZPEYFv2DQV+gUgkG++1wUCX0HGaBIaZKQ+FKw5ENPdF1lkA6AlP1+fjZf2jO6x01omby8ePHIdlb6Vxxxzed5VDkCguxVrOQNUL4Ye1khWoH3AsRX/H3gDewcDLazPN8LgeSM9k86s/cS79TaJPN4oONeQC1A6Ha4bNcfq6wlWe0ZyLuU+PqpFXpNia0lqUXxNIpQMsAvmZ3uvWdBlo7Q6ASfmUiFabQ1dcgxtRRuNpXtorhJINuoHfC2XfQtVNgjQCGl1rfh+kzV1mQ5KFj/8QFViaLJyByoHd4GHLZWKVWNW6heJaBur78EyyeGOk+7VJHQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(8676002)(316002)(478600001)(86362001)(4326008)(6916009)(54906003)(83380400001)(36756003)(71200400001)(6486002)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(76116006)(2616005)(31686004)(53546011)(38100700002)(6506007)(2906002)(186003)(31696002)(15650500001)(6512007)(38070700005)(122000001)(41300700001)(5660300002)(4744005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QlZsdVh0RFVWK0U1RGtNZmx4N2E2SE9mTURoc09tMHdlSnRaS28rVzJadnpS?=
 =?utf-8?B?QWFVWVNkVUp6MkFaM05hNU5IdVIrbE9WVDFFOTMxSkhDS2didlI1Rnd6dVZl?=
 =?utf-8?B?NGdMeFFlZS8zVkhERDJZV1BCcE9OOHJPeXMxU3BTUTZINHNnbXZ3WXQ1a2x0?=
 =?utf-8?B?MUxMRDl4NURCWHRkdVhRSG5TL3pCMWY3Z1F2ek0rMDB6djVHYVJYTXhqTWJQ?=
 =?utf-8?B?SmVuL3c0ejBuQm5sRVJKeitwRVBqN2hHanoyajNPY2NTS2k1ekdxN2dBNEVw?=
 =?utf-8?B?bmc4cVMxKzFPb0xGN1BPVEUwSStyN0tOclZGRnc2QkVxK08rZzVVeUtZb3lD?=
 =?utf-8?B?dm9OaFRabll6RDJjMlNPYStncEFIWGlFc2t5YnJZckF5ZGZISU05bndhZFZE?=
 =?utf-8?B?cmhrcTB5Z21pbkhmWE14RkdiK3JpTVlGL3kxTFZwNWg0TURITlNtZzNwZEYy?=
 =?utf-8?B?bXBjSWs5ajNDNkc2NDI1RVZKVlhLT1VXY2FMem9sdFRVV3RsK2VteGNiUVRl?=
 =?utf-8?B?RWhpMlhUNFVpYjF3YVZ4MUd1QXVucUQyWU9Fd01teGcvT3Z0ZXA1RHdlYTVV?=
 =?utf-8?B?aitDVnVGaDNLMDBNVGpUQVNnYzN5Rzh3TlhJYmNqdjlhWG9wa2hnRkJZeGdF?=
 =?utf-8?B?UU9aQThxUXBERlVPZm1pTEVCZDdFME9XWkhxdm90NVpJeC9UajBXdU9Zc1Z2?=
 =?utf-8?B?akZSeHlMRUdzUlBLTTA5M3RvT0w3Z00wZ2dHSDRlN1c3MndYMUFaenhsekNE?=
 =?utf-8?B?MEREOXBPa3dhMDVUVUd4OFlTZHhzTWRsaGY5ak9lN2ZWVlZHZEFVSEFvb0tu?=
 =?utf-8?B?cENVRHhyK0Z5TXpWOGhMalc3YTFvME53eThmNDlVa3JET3p0bk9wa1g0elZr?=
 =?utf-8?B?S29TMThrUWZ3M3hjeGtlSEdSaXAvMC83aXEvKzk5SWluc1Q0cUF5RjBIRWJY?=
 =?utf-8?B?amMrSTFraHJ1OE42ZXBCb0gxN1pzeThOYi93YU5zMDhmZ0Y4cTdFVDMvcGQ3?=
 =?utf-8?B?cWtjSzd1emZvNzduY0d3L2QyczNxd3ZZRUw5WXlBM05IcXNiM29IckdkRnFG?=
 =?utf-8?B?dGVqMGlMMCs4a1B3M1J1STRkVmRBMWFoKzVzRUlobDlwQTRQZEtOVHdLYTBp?=
 =?utf-8?B?c2RIaXkzTTQ5enUzd0FRZ2dISnZ4M3YvdkFYTXBNbWg5VVgyaXk3d2g2WWJM?=
 =?utf-8?B?cXZqVVJ5czVJMG0vUU5pWStzTXQzNjFmMzNCYnJjMU1RKzIvNDJWTDRjdGkv?=
 =?utf-8?B?SEFTMkRlS3RtbEpKK0hLR2prdUlmVGNQc2JrcFlJazQvQzY3MFRNbjJsRnRi?=
 =?utf-8?B?ZzFsUEtNdjJhKzJYSU5IbDlKOVU1N0c5Y0JIbnVZWlVXVW9rYXFXejNGTytC?=
 =?utf-8?B?Vlk0OTVob1BSaFVBWWd0YkJPc3I5TVhZbkhwWStqUEdrWEVPb2cxVk1mUGZq?=
 =?utf-8?B?bVN6N3ZRQ0pJNkozTytCU0dPSE5vclA1TUdGSmFtUGxkRFRuVGQzcmtkTlFi?=
 =?utf-8?B?RUk3M2wveEh0M2JabVBxQ3pqMnNqZWsxbXQyQStVQ3VuSExZdUxZZkZ4Vlpo?=
 =?utf-8?B?WmJPT1lsZTV4Ujl0aldrQ2hleDJtTHVFM2hTQ01RcVh6ZWtiMWxsQU5weXBh?=
 =?utf-8?B?NWhrSFYzbEg1ZjBDWDdNQmtzQnZ1TGptYU5ZOFprVnpjVXNhSmd0UiswVEFX?=
 =?utf-8?B?eU1LQkVqSXRYcEU1aWltL2h4b1NpdEJyNnZVRnRkb0E0M2hvMS92Sm85VDAx?=
 =?utf-8?B?cXlpUE9oRUsvRFlVTG85aWpXd0cxZkpHZlBBNTFDaS9adnNCWHBySWczaEN0?=
 =?utf-8?B?anpDSmlvVnhWZnU4eHRQN3FHMzBneEIvU0xkRTBjZHczbytqNW0rQU44MGY1?=
 =?utf-8?B?SGgvTENPbUVRK2VWVkMyWlNWWXQrdHZBY20zWTlYQ1FHZkFaMEd3QzNxa1FJ?=
 =?utf-8?B?RUNqdkc5OCtISnZVS3NQeHVPSEdocDVRdElkT2dhQzFHcTVQSGIvS0N4MFA1?=
 =?utf-8?B?YWJXdklhci9Db0Vpc2xtVXRSamlDRkROeTRaeTNIakVWVlh1Z054N0xycnVi?=
 =?utf-8?B?N0tlT0xFNisrb2ZTVzBtSmJJVHI4OXJha0tWRTJSeVJidWc4Z3V2amhwbXFJ?=
 =?utf-8?B?bTlEZmVFTHdLMjFsWUJmNmxWaUpiUnJUbmZjRmdmQStYTm9na1lEQzlJWlpH?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD18ECCC589A214E8FD2AC1CFE7F0A6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca77d805-92af-4cba-f927-08db03d3b9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:40:09.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ac/J9SDtqhRU0CB9ekz+X3E/zYn6FH63C+YQJa7yFMLpH7VrMBG+l6qdDWuXQwIrWoOQkhKQhHMteOup9DpjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_134013_656380_B9139E27 
X-CRM114-Status: GOOD (  13.12  )
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

T24gMS8yNy8yMyAwODo1NiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFJlc2VuZGluZyBkdWUgdG8gZXJyb3JzIGluIHRo
ZSBwcmV2aW91cyBlbWFpbC4NCj4gDQo+IFZlcnNpb24gMyBmaXhlcyB0aGUgbWVtb3J5IGxlYWsg
ZnJvbSBub3QgaW5jbHVkaW5nIHRoZSBkZWZhdWx0IGxvZyBwYWdlDQo+IGluIHRoZSB0cmFja2Vk
IHhhcnJheS4NCj4gDQo+IEkndmUgaW5jbHVkZWQgdGhlIFNlbmQgUmVjZWl2ZSBmaWx0ZXJpbmcg
cGF0Y2ggaW4gdGhpcyBzZXJpZXMgbm93IHNpbmNlDQo+IGl0IGRlcGVuZHMgb24gdGhlIGZpcnN0
IHBhdGNoLg0KPiANCj4gVGhpcyBzZXJpZXMgYWxzbyBkZXBlbmRzIG9uIG52bWUtNi4yIGJyYW5j
aCB0aGF0IGluY2x1ZGVzIHRoZSByZWNlbnQNCj4gY29tbWl0ICJudm1lOiBmaXggcGFzc3Rocm91
Z2ggY3NpIGNoZWNrIi4NCj4gDQo+IEtlaXRoIEJ1c2NoICgyKToNCj4gICAgbnZtZTogYWx3YXlz
IGluaXRpYWxpemUga25vd24gY29tbWFuZCBlZmZlY3RzDQo+ICAgIG52bWU6IG1hc2sgQ1NFIGVm
ZmVjdHMgZm9yIHNlY3VyaXR5IHJlY2VpdmUNCj4gDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jIHwgMTAxICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkNCj4gDQoNCg0K
VGhpcyBsb29rcyBnb29kIHRvIG1lIGFuZCB0aGFua3MgYSBsb3QgZm9yIGFkZGluZyBhIGJpZyBj
b21tZW50DQppbiBudm1lX2luaXRfa25vd25fbnZtX2VmZmVjdHMoKS4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

