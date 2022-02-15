Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CEAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxBzSYnrgREB6JDeNRQVitNOqn9fJa0++53TQwa088o=; b=fIw9o/Y9eZ8QFXiZT2TtxL0K7i
	9g68pjw8B0vY2fZ6CdmFSUtgcjYqDRx1G0NNGllcbbRXpKYTYRBCW77T3F59HnRRFHYwqFqyHiPoO
	zxDHb9QCh0IAUAvkHfSIEVfRGqJJQzIvyl8OmORhr2XI9Krnjgt/Sk/mQA4Qc2NvDloI6hnAg9HyR
	bLgVRYoeO24oIcYsSqtnad1oKekwUFWn9Xm/OH5/8QXgNfGkPOmHxR/OiwKUVtN8WwiTDwuXgUAK0
	Tof93LEpZNIPIKQKmMFZvTHSazSZcfDGjvcg7ZOaFXyL+hqcozY+YV8PFhL2H3jUaEY6yaS9sQbQQ
	ShZVJ/wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK3Ws-004KL6-B3; Tue, 15 Feb 2022 19:30:26 +0000
Received: from mail-dm6nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::628]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK3Wp-004KJd-Aj
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 19:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eymqw0YA/ktv2ITRMrU7AL8ceuCAp1b0Jo5zSq2WOLmKkewuuRRIDMGPB/1WAJDKHTydQw5TRa8ime77Li3dw/tR9xSDQULH3NnspwiHFiJAvBMkuu7Ssg7NgQ6nkosAnnDP67eUXf9LyYBXmEeX3rvSGQfGQF5EglFU1MJq2ARPxigOAp5yW32F0houwMc1liSphqIHqSliu1uKjFHUb5h5DgmMB+xgHVOU/hAAlCEjVog1DR8slgvbtO3s834zIocKpX8+NfDlJYVDFyoZUWeRN9OrwbaysaNZfdoZHoYlBC6rbZmsEaypscjfIreGhPRzT6n7kM1RjLwMKkmsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxBzSYnrgREB6JDeNRQVitNOqn9fJa0++53TQwa088o=;
 b=bBKTfM3cNtwhDsJlCAgSCI1h4ZdUHHhz7aoquwxdPBGqUHSho8KR9lNYUizvLBBgX4RqaS5AP0WoJ60B18SG9GqKWevKR24U2p6m9Dnd5ysvRx97K8XAVVEpjffX5YUZ3ECyuSWSgj/bg2g5CDL1fXJ6rcldG0p21Z5j6lRsLbCLFdutTTU5+fhJoZq5W+qhtjYPZRSJohtO0eEBsYdJsBBvN/CYY0uVzumZ2H3nXtTxwX0T2Iw9EXrYvHSUx3L+IgJzDEZ6YO+ka2XPltYIX3Ca+IQkq3K3ErribZEvJNB4aE5MZkQyzzyRn9w7zqHvgDDJ0TEbhhh7pSbUaAfPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxBzSYnrgREB6JDeNRQVitNOqn9fJa0++53TQwa088o=;
 b=XiQ82XLotJXuaz4grMIvp875tsr7CtdRc9t69cbS6SJFIgW1KroyI89eQXkAHUXecpnJkwX7BExAris7wNJEq0F5PtAoQpQ9gyw66QRNvtvo8joFNHJrJofFGAB7D9hL+82W7/iRAb+38fAXsNweubvlWI6igdOkt8Pgs1Xz03pj59Fot6dMlPNRHGVq4QQfWuXiqnCjS7qOvkWod0xTobX5MnOTtv3If5XMuDc8RPFPjyIVBEL2b9HEY5qy6VJhy1yfiCJbPZVQdNYx60/n1TiMEnyYPsQvVld4JGmqsFvUr6BZPOdLPykdsvvlpchPJ6ij+jlZscAghSmh16jxXQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 19:15:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 19:15:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Topic: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Index: AQHYIYRxGili+sccbEWgjaiE4nwfg6yS0TuAgAAFLACAAAZEgIAABESAgAITj4CAAAlSAA==
Date: Tue, 15 Feb 2022 19:15:42 +0000
Message-ID: <4b749d42-2246-c16a-9c57-14c81f304141@nvidia.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
 <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
 <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
 <705ce6ee-3c1a-c4a0-1662-2f0794b1a6fe@grimberg.me>
 <20220215184221.GA24543@lst.de>
In-Reply-To: <20220215184221.GA24543@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05c0c9dc-f7ef-4f05-5e7d-08d9f0b78fa5
x-ms-traffictypediagnostic: DM5PR12MB2485:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2485916EEA0BA480BCB84BA8A3349@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5T4mBXeaqkiaDKChmETjlDgXdDq+KhAgRKEdv1tOdMsq8OHOetmAI5vZvLZxoMp2dH0Y8tf0XMvg04P9ApFP4y8zJ/PCgJh/6X8rZajmET2AqAphM89epnWJeqGZUI0LD6ZkAYQXb4eHyYR2x8bDWmngCg4ITSeHf6Mdt1dJIsngELPRShFdquRWo4LtMWnMeNXlVyZ7TLiTZgvrdf203bFAUs7WsRxJVmngjG3nsImDhYqU4VVJFkMsZeFsvo5CpmRWYFMg6QAJ/SnjKfuzxrIEUZqKvZdRycBs0olxnikcRytEOKPyNUBE1PkOhNAoMueuG1n5+wxoOEIHvNTUu/B4b81RdTx3mwqt7lAPz4fqn8BfXmJrHriRPoPLLfXJrIpA+QGMk6WpFxwm7OXPFs2tMp1TJavu4t3Fnhxy07lJ74yOHwIuBpGKpB2+FK7hv5b6Og7oiZ/CzCFcOj8YK6Wmz8+4+8wrp7aNVlJExNnpLRe5rBDIX0/JPx3zSYqNystuHXPJ0e/W1UQ4cNHAgookEPVXyj9yp9m+3WpBZpAyUk+waN2b1rDpuyY6nPWH5Mze74K60V3LxNv1Xura3H0+7DI/XwDsuCHlAO7pMkiGVVIRmBoMjmzOiM2X3wCvgqZ5p47Eh0mhYJTFOdFmfem0IZZFuc8Bi8bRF5CBSKrIgPh741AxrbNATbAdF/LCga05Mf8St65kou8t+CGZJVERAvkHW2hQqYV0GgKaEiHCfIUrxG8FbIEQ31W7ueYcZZmKtgcGxYaL3bAb9o5wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(66556008)(66446008)(66476007)(64756008)(5660300002)(76116006)(8936002)(4744005)(83380400001)(38070700005)(31696002)(91956017)(6486002)(122000001)(38100700002)(110136005)(316002)(54906003)(2906002)(2616005)(186003)(31686004)(6512007)(6506007)(36756003)(508600001)(86362001)(53546011)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZIaWcvVUVTU2dRK01TcHFZNjJpa0FkUG14N2NxMXQ1bWNzRnhuR0VQRlc0?=
 =?utf-8?B?K3hIVUx2R3djSzdMOVNZNmV0UDRlTjloZVQreDcxUVU3WHNkdVVsVFczQ24w?=
 =?utf-8?B?eEZLMk9Ld1JVdkYyUUxJY3g0MlVNZDFqT2NSV0tIdTZaOC9DSll2d3JsTFkr?=
 =?utf-8?B?RjBtNU03cW5yWUtvQ2VmTGxxeC9NSlUwSlpHQ1VMajM3TWpZc0s2UTRRczRh?=
 =?utf-8?B?VWtVRFVabWxaNjNFZEsrekl6eGVoTGRmWTdnbS9XaUQyV3RHNE8ra3N1SzRH?=
 =?utf-8?B?NjV2V2tNcXB6eEM1Y2V6N25QZFg3cjJIWldtNXBoUTArdTFnK0tUZ0w2VmJS?=
 =?utf-8?B?bUI5ZVNiK2JNc0lYMUJTSXU3cThPdThsWlJZb3ZYQVNMZU5yaTloT3FXdmVi?=
 =?utf-8?B?NHVQRDZkVE9xcGlPN3VxSVRRT01SQitSQ3RCNHAxQml1SVp4VU9GNmo1YjRV?=
 =?utf-8?B?MjdLOTJZVlZDOE40dFRtN0xINkx0eStqWitPcjUwRjA4M01OejFCTy82aWZT?=
 =?utf-8?B?MHo5dU1RN0ErMzhQV1AwZEV1RDNDV0hpeEJNbHU4azJneE1yTFMwQzJUZGxi?=
 =?utf-8?B?c2prbXd6RlpFdHFoMVBnTDhGbWVheW1uc2Q3TFNOeGdrSUd3Zm84eEMxeDRS?=
 =?utf-8?B?RFNLSEZNcC91VGFIZkduQURRTjNlNHhiTFNTczVEdkp1dU1wWmdPOCtjT3lp?=
 =?utf-8?B?d05BWWlFb0xmZktwOFByczJMcmZxdnZHd2RvWFdiaWIrcmR0N0sxTEtiSVdJ?=
 =?utf-8?B?Rkk0TjJoNlRkOUtuUUNqQTZ0aVVMRUN3bGpVeTBPSDI4aWFkTmcyVHQ4Si8v?=
 =?utf-8?B?UzVBRDNna2lOeURTbXE1TGFIVSsvSDFQUHYxNm1yOUVzRndNemZRemNZRHFT?=
 =?utf-8?B?eGowSlVHRm9HYllkUGp1K1FlT3hCWHQ2eXpxWWZ5U05tOStUUTlZRWE3OGhp?=
 =?utf-8?B?OTNGbjk5aUZOV09Jdlp2WisvRGV0V0k4aGlEZmgycWVKc09ucWpEVlV4TEc4?=
 =?utf-8?B?cjZ2K2kyeFRvZG1uYUpoUUd5WmxJb1ZmUDZVZ2pPNmJSaWtOUVJhMW1MSkc1?=
 =?utf-8?B?RUo3QXFnbTdJQkZveEgyVE1pNzd4L3U0SG5EN3dJUlJPQWd5YTY5MXRqUW9L?=
 =?utf-8?B?L3F6TWRxQUkxYWNoV1duck9ZbVl5R0JVelVuNGs1Zm11NC8rdzU0ZnRYQ0ZI?=
 =?utf-8?B?cVhDdDJHZ3BISU41eEdEUmZRVnhnTWFpaGliR000aU1rRUpQUHZiREhHWUtK?=
 =?utf-8?B?K1NkemJ6VUxPY3MyTndzUnpzOStLOFVMOHdvQ01hazlGMGl3MjhPdHFPSy9N?=
 =?utf-8?B?VURyL3NkZ01DZVNrNEI5REN5M1VaaDdJbDlJNmxqcmdSa0lhci82bWY3cU9D?=
 =?utf-8?B?V0FMWUtLcG9pL29QQnZSTGRGUmY1ZVRHU3ZZQ3J2dUdWNjVsbEw4cnBwQmwx?=
 =?utf-8?B?bmFmOEZDNFRnQ1BHTnpjZ1hjYmVqYWZxK3MrcjlpUGhzWUFTZHp6NW1ZU0VI?=
 =?utf-8?B?eFhDRk50SW5Dc2RqUFUwUkxoY0puS3Z0QWsxRytITzkxSEZrZFFQZHF4TXZN?=
 =?utf-8?B?QUxxbTJDK1A4ZWs1SW54WklJbzlkck9WVDNUM2k1dDF6L1FSNCs0VkJtdTFS?=
 =?utf-8?B?RU5tQWpPNnpJQURhVHFLblVNSG93dWZnZElOK0NSd2F3dktzYWloOUlaOFFy?=
 =?utf-8?B?MUtCeDVrNlIrZm9JSVp3WFBWUFBuM2ZKTDgxQklCUWs4Tm1VemdpdHdPeWFL?=
 =?utf-8?B?MTBFVHA4YUJXRzA4Tnc1SFVRZXdTODc5KzAxZzNSVDN2VFlQQ3VDSk1BeTRH?=
 =?utf-8?B?RE1vdlVpa1BlRzl6STlYMlFhSGNNeHFiTm9hTmJLYVBYQ3pmQ0t5RGlNQXdL?=
 =?utf-8?B?MlAxZW11OUhLR2dMYWlQYVZUcTZPSHI4bHRRS0FuWWlLWWhXZnU3Z0dLNUUw?=
 =?utf-8?B?Ukc2WTBxb3hyalkreGhzL2VVT1FIL3Z2cnY2WFdwUGN1eHNOaXhyR3RjazU1?=
 =?utf-8?B?dDZocG82amVVWUU5RnluSUI4cm96VjFmOGh4Z0U0VXN0dUJibEhuODJENHZJ?=
 =?utf-8?B?VmhhUy9jN3RKSThWZlpqQ1hBRXNaQ0tHcHI3VVlVV3pabnpmZXB6c3F6R05M?=
 =?utf-8?B?Y09DZDJlamp3RzgwdDhWcXVaVjB4ZnZtZjFmVWUzQnRYNkN5OWJrWjRPWGEx?=
 =?utf-8?B?L21Da1NPR1p5NFhFOVhFaGV0V3lyb1I1T05Hb2cveXVrTEdKT0pXOW5HR2Qw?=
 =?utf-8?B?NmNxWU1vWVJRUFJHWENNVjU0S3dRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FA825D883A9D141AE770BF0ECD3E0D6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c0c9dc-f7ef-4f05-5e7d-08d9f0b78fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 19:15:42.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qMZBMPQ3BHa4NiFK2PbT6YvI4d6rppycSjI/N4yKofBFWEW62U4dfFUsPOXfq+tWXsyZUIhaAvNw/Zm2e9l+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_113023_394243_C6F44776 
X-CRM114-Status: GOOD (  13.35  )
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

T24gMi8xNS8yMiAxMDo0MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwgRmVi
IDE0LCAyMDIyIGF0IDEyOjU5OjQ5UE0gKzAyMDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4g
SSBkaWQgY2MgeW91LCBoZXJlIGlzIHRoZSBsaW5rLCBzb21laG93IGl0IHRha2VzIGEgd2hpbGUg
dG8gYXBwZWFyDQo+Pj4gb24gdGhlIG1haWxpbmcgbGlzdCB0aGFuIGl0IGFwcGVhcnMgaW4gbXkg
bWFpbCBib3ggOi0NCj4+DQo+PiBZZWEsIGdvdCBpdCwganVzdCBhIHRhZCBsYXRlLi4uDQo+IA0K
PiBTbyB3aGljaCBvZiB0aGUgdHdvIHZlcnNpb25zIHNob3VsZCB3ZSBnbyB3aXRoPyAgRWl0aGVy
IG9uZSB3aWxsIG5lZWQNCj4gcmV2aWV3cyA6KQ0KPiANCg0KSSdtIGZpbmUgd2l0aCBhbnl0aGlu
ZywgaWYgeW91IGNhbiBhZGQgbXkgc2lnbm9mZiB0aGVuIGlnbm9yZSBteQ0KcmV2aWV3IGJ5LCBp
biBjYXNlIHdlIGNhbid0IGRvIHRoYXQgdGhlbiBoZXJlIG15IHRhZyA6LQ0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=

