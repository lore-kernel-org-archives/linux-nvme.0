Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BA8C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbOpw4BLTEJeeWasULHJZCulyOT3DYB52rqtSRFdZo4=; b=vpY+VrPy1gEmuX6QE6F17vrTVL
	r5tdUrU7AjlW9oO4a/E9VuGPGjiTnWSrU0xzmMdEudfo4XROup/mmdq6Riy0dwde8eYvw59Zuwgui
	U+wCiEarphvD70RmLUOGuSrlG8Iy4Z4PRCwH4NHV+x9jogJG2LFwBggfh6LIfdChsogc2QJWTVPqu
	5ueLmnFZfnTLw99U3nFQIklPUTvSuFh6Ca7QiEcAyte0WycB806FXcSz9TkvG7w3kG/mg9kI5x82D
	9M6VVZ+OY5q6zT1z6H0gjcwKCClnFUPqmn40I/i5Sn+tbh3dKr0JtEDdpwjimIctxoxma+t1gTkvm
	hKIw46uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NQk-009Riu-33;
	Tue, 23 May 2023 08:31:42 +0000
Received: from mail-mw2nam12on2062b.outbound.protection.outlook.com ([2a01:111:f400:fe5a::62b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NQh-009Rhy-2B
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 08:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/LJEB3ba50sHVLn+1i/9A6h43s9/pY/yMKLH6xdkeX3cuefT/VNfZddjy/2guW6i2l84IrvVMLUnBN101+RtsfuzgIzOwDD0tv9vPygdb2txLxPEzrhg7oD2u/py0qHF6FPsJoFdiytSUCSyNPu89NFaIfS05RCuRSsTtRHzpedeTZi6UZUlPaQpYvzs/WsMRgLRhh6KTGaGTmR7Iz0hZa7TfWkqjvZ6G23F7iVSr+LX1aRI+bTS4t2HXfiSk36LSdvWZ8nR3PD+rltdB2tdnY6OcFxydvjNHO88wksE968Tl5p6W1G91IqWHie/Au32o7BbeuJOsDdtzhTp1e/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbOpw4BLTEJeeWasULHJZCulyOT3DYB52rqtSRFdZo4=;
 b=D4No7yPGAhbWW25fxKhy1R41MwAR56agnlDZfKPS8jmJ9rTZyJu++BDs5LkLb1etwN61bEuolJ+igl96uO2eH/6aULsLpj4wLOOs4CxvYtcq067PAZqDbNdgwyLzpkeYiFXr6dgIyt4p22ETGtYEdcMSmSRSozHf+SK0HT+BJRo0Jvc37eFfLg7BOLE2z/L2IxRQe0TCCDF93j+SE/J6jiTDD3UptzLpJiHqUegZzTdoIDbvROB1aSjApgnaObMmyTSuDDgI8h7uaZJgrTEayT3S+dvSdYa6cNUMh2715g4C0asqgadrxpDEgSmVW9V9hGjHZfGe1ZsD49rasYGExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbOpw4BLTEJeeWasULHJZCulyOT3DYB52rqtSRFdZo4=;
 b=Kz8BoFULiTq6v8q9C13NDfZCk+VRZYNdW7GsF6+KONybHZpD21pBSl1Nuy/Q9Lo1Ia1b0W3BoFRwSQAZZV/y2Oy37JSvU+yPSRnwhm1r5MISlNkFIEvHQVDwxFjP6kpXWuYjyckW9br8KhgK3Oczf6BdoNxDXKOlNmaOivJbYGANV3ugMzfZ4xHhAG3k3hddvircImJ9Q94Zmn3VhoObTiW5tC/gT7MHILUUNvwSNiihx67QIkkIkpt856XpQzc01tV+7J7cmO0Ym77Z7XNsccKboaStt04oYenuam+RhtFs+p3TDAvElYNvVw8edho12GkTTwJ5OAaNuYoY7b2PhQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Tue, 23 May
 2023 08:31:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:31:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hare@suse.de" <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvme-fabrics: factor out common for auth
Thread-Topic: [PATCH 3/3] nvme-fabrics: factor out common for auth
Thread-Index: AQHZjK4Ff1be3W89R0yr/Da49E+nlK9nbzAAgAAZaYA=
Date: Tue, 23 May 2023 08:31:32 +0000
Message-ID: <4425b03a-bd62-b18f-c260-65cb44b53561@nvidia.com>
References: <20230522130408.105328-1-kch@nvidia.com>
 <20230522130408.105328-4-kch@nvidia.com> <20230523070036.GA8599@lst.de>
In-Reply-To: <20230523070036.GA8599@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7856:EE_
x-ms-office365-filtering-correlation-id: ec67795c-d5af-4ee6-958d-08db5b681d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ik4tgMkpsmmOVL3mY/bkBRPNy7unVYmWuSrgbS11vXtWsVrLACSLUnakKQ52htURcz8fhLfxDhZb3ySW2VTOAeyGjM2uSLao4PJgVv7gtCVIDZgVpc1djokVpD9EtR6E1j3CbOkxdPe0pUlzFu/Q/+bBPQvStxKvA4eALeaGGc3heCYFGxXejHssy2dAEkrjYt+dcRKBAuAt1aZKceBX/lk7medGQjUsaqvmo9a/aRen7vWHzkUORmF92IKEfCiUoBYR7cUHXkKrqsdn4CvIt2ftmQ1NI637YF3+URHhf/MBNRabhzk5x8HRTYO6Nm8oOtcx3tQIjSVBqnkniNH8PCbRCWjLhR4AstMORqBF6hC1PnJSztkPOdQhZmpVR+QnHEBlvXwCf/P32Qk9+4DGo1pZfq91CQd7SUNjf+Q2mLGu49Z7Iu6V1+ELTU7HkaLAl+LvHH7M9NaDCqd5lGII919H+52j16QJFqe/n0mGq2ZkjO5UfJGUUJRQSIx2NQ9HFw5I/H/cG/KoX1skfQciSej/WZsbllTdVors/I2kMTSqyMRKeuKkW734R3Dw9KxWFqbUmNY5fqPVnsZVyHxTdUlS31I7RIIt8kHmPXFRCrjjUGAJd7pP0ybnrogX1XKeui5gtTcXp6HdN0riYBtbW2Kvf0chj1Wuc/y4eKkaAyAfrVn6gCL6fFwDub4+Z6C7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(53546011)(6512007)(8676002)(8936002)(83380400001)(38100700002)(86362001)(31696002)(38070700005)(122000001)(36756003)(6506007)(2616005)(2906002)(41300700001)(71200400001)(76116006)(66556008)(66476007)(66946007)(91956017)(66446008)(64756008)(31686004)(316002)(4326008)(6486002)(110136005)(5660300002)(54906003)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVzZjlyRERIdzd4alBGT0VaR205bnlFaXZjeldSSmp2WTZZNi9qMWVkYVhF?=
 =?utf-8?B?Vm53eTIzaElZaDN1b2JCUUQzWEZGQnFYSVAvZWJvcGlsTzZONUpMUHBwNEFZ?=
 =?utf-8?B?T1NJRzFyTngrQzlKV29lQ29SN04yK0l1RDJPajlpTENwRUZIU2g2YzVMTkQ1?=
 =?utf-8?B?MDlYamJsRTR2T1MzT2VhMU9KeDNCdllqbjRkYm1IRFBZWi9BMUlBUHJQNE1U?=
 =?utf-8?B?RGl2aXhubnh1Um81YmR4UlkyWWsySlEwaXJUUEJBZVJvT1JUOXU3aG5CRjFW?=
 =?utf-8?B?bkJrWXdSNGNGb2lFL294citMaEM3eUE2cWlGLzRTdzNGSmtmZGkzbEZLdXZ2?=
 =?utf-8?B?bjFFS2NTSllKMkFxMjZKdGRqY3FhcHVpRlZrY1pYK2RKZTBqWlFGRGJ1VHpD?=
 =?utf-8?B?WlAyNlVWT0VoS0hTdTU2NFJSZ3J6YXdhMVY5MWpvL05RdEtFcnBrVCtZdk9K?=
 =?utf-8?B?MVIrUHdmNDBZMjlLdE90ekVUY0dpRHRSVy9KSEpwb0ovdjdSeGJoYUhOaHhm?=
 =?utf-8?B?dVlTUkxLdGhWa2FkUzk4cCsvUjcxOE1ERlBSWjJrQmI4alA3Umc0YksyKzJk?=
 =?utf-8?B?eUh1amdlN3VQUjJNYWFwYXgySC8wRjRIWnExQngxSVdoODFoR0I3dlRKbXJB?=
 =?utf-8?B?STRIQWpOeGZueUpjOTUrUDQ0TmpmYVFqeitRNHA0emh3TUlKSVpHTkRNSTVT?=
 =?utf-8?B?bDdzVzVaeEJBQi9SMlZoYUY3RFBDbGVRdVdLU1JLL1FUZVFkbUJRckRJT3hw?=
 =?utf-8?B?YWFtNThNd2NOU01ETDZmNktFby9PcDA3ZXdRL1U2dHZkdGZncG8vNkZxU3Nw?=
 =?utf-8?B?bWlGU1BockRuT3NPZWh1R25HV0tBR0orWnN2c1NlNXptbmlXTE1MU3dWdGlp?=
 =?utf-8?B?TnZNdUJtQ1FseFZyN0hPT01oK05Za0JUdUlmUkRZSHhPY0NKUWEyb2NvZGNO?=
 =?utf-8?B?N2NKeVlmMEZWdWhNRGZzWXRjbi84aXk0c0FXRDI0R1NmQWpYUmR4UVF4ZWZK?=
 =?utf-8?B?S29PTDJ3S3JlU0wrd1VzQTBWeGthZFZwUyt3eXVmdzY2MDlUeDlVN2RRalUr?=
 =?utf-8?B?QjJ6a2h0WDhyaHZ4bE9aSExvOTVzbmY5SmNqOXNRTWkvNHlKTFRmYjVLWnJy?=
 =?utf-8?B?TGJaYW1TNTdJNjdQRWtiODFCQ0UybDFZRTd5Njl6TXpNMW16L0VpSkN0N0dy?=
 =?utf-8?B?WFVxRzVOalowUmIzWjVHUWpHN2dyNklmc2pVcHhTaVlhbWpsUC9iN1FiczFU?=
 =?utf-8?B?cVJJcU9CK09haXdta0dYeFVGOHNVUTNkcGFYQVFodmloSVUzYkdRYXViQjBJ?=
 =?utf-8?B?NEpmN2VobDQ1QmxDejhCUUNuNE1rSnpiQUFZaEFKeTZWWCs5Y2FDaDl5Z3hr?=
 =?utf-8?B?VEx2Rm9Jc0x5TnBVR2JlaWFIdElTWmgzRVNsYXpXbXF5Z08yMW5xbkw1Uy9p?=
 =?utf-8?B?SVlQRnluZ1N4b3R6MnUvaUNLRHhERW1mK2NuNHc4UGdEdGFDdVRkcExtY05B?=
 =?utf-8?B?MU04WStjWmVPeHpGSTV2T0kwSmFzRGtZTzFUVjJXUHNIcnEySE1QTWw5YlBR?=
 =?utf-8?B?cDA3Y1g4ZVFGQ3hNQmN0Q3lZRU55S2Z0ZGNXRUZoMC9qVDA4aGdSd0hLcmh5?=
 =?utf-8?B?NWN4MnpwODJrck8yR1RSb1drU1FXTzYwdjlYMFQvVWIzSlBsMGhRNzZhdGF2?=
 =?utf-8?B?NVdQQm5SaWd5eEh6U3hGMDhTY28zRWk4MFlXd3hWOS9ldCtxdTRaelVLdzBq?=
 =?utf-8?B?MUZJYWpLbEc2bzh6b0hRWXJnRUcwZWNkRitIMUZEblJaZTRLRGFqbEFmQXRv?=
 =?utf-8?B?OU9FMG84S2ZZOWRiRzlTV1BYVWtRTGN5dEh4RVFOTlNpYitnNmhRRjRxZHVj?=
 =?utf-8?B?SklGeGFiWnBEbkxJM3I2R2VKOXhUTURwSjU5ME0zbTdmSFduaElkNWx3bG1v?=
 =?utf-8?B?a2REZzJxOVI5Uno0WjNDSlYycGpSY2VncndnRWxyekw2NHQ3MHNhUmhaaUsr?=
 =?utf-8?B?UHBpYzBveFpUMEFJN2phUGl5MXpzbzF5ZWZ5MzNLL3N5QUZGR3NaL25KR21H?=
 =?utf-8?B?b0FIZWlURXRPeFZGeS9QOTBBMmcwZ0E1MTc0TWQ5ajlUVEtLUzFQcExhcFJE?=
 =?utf-8?B?ajhZdnBNRVBtWWJIWUgxN0I0SlN3VnE4ajErYm1udnpxc0g2NGthNUZJZ0R6?=
 =?utf-8?Q?xEv9d0ncObEGh/3L+xryQRn4GMHmn7vKbWqk992EmW0i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F39691AEF5DB24E90918AD3D3F6803D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec67795c-d5af-4ee6-958d-08db5b681d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 08:31:32.9866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXm6m3hAG1Uj0x/u3IZh+6uLQuDMixhZOnEgOhB6Vo8AoXpV3xXUsSdZm3AyC1feNzbAw2vbvf2v1SuEXaj+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_013139_741876_1AFAA7B8 
X-CRM114-Status: GOOD (  19.40  )
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

T24gNS8yMy8yMDIzIDEyOjAwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9u
LCBNYXkgMjIsIDIwMjMgYXQgMDY6MDQ6MDhBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdy
b3RlOg0KPj4gbnZtZl9jb25uZWN0X2FkbWluX3F1ZXVlIGFuZCBudm1mX2Nvbm5lY3RfaW9fcXVl
dWUoKSBzaGFyZXMgY29tbW9uIGNvZGUNCj4+IGZvciBwb3N0IGNvbm5lY3QgY29tbWFuZCBhdXRo
ZW50aWNhdGlvbiBwcm9jZXNzaW5nIHRoYXQgaW5jbHVkZXMsDQo+PiByZXR1cm5pbmcgYXBwcm9w
cmlhdGUgTlZNZSBhdXRoZW50aWNhdGlvbiBzdGF0dXMgYmFzZWQgb24gdGhlDQo+PiBjb21tYW5k
IHJlc3VsdCwgYXV0aGVudGljYXRpb24gbmVnb3RpYXRpb24gcGVyIHFpZCwgd2FpdGluZyBvbg0K
Pj4gbmVnb3RpYXRpb24gcGVyIHFpZC4NCj4+DQo+PiBBZGQgYSBjb21tb24gaGVscGVyIGZ1bmN0
aW9uIHRvIHJlZHVjZSB0aGUgY29kZSBkdXBsaWNhdGlvbiB3aXRoDQo+PiBuZWNlc3NhcnkgYXJ1
bWVudHMgb2YgcWlkIGFuZCByZXN1bHQgb2YgY29ubmVjdCBjb21tYW5kLg0KPj4NCj4+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlcyBpbiB0aGlzIHBhdGNoLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9u
dm1lL2hvc3QvZmFicmljcy5jIHwgODEgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPj4gaW5kZXggOWQzZGY2M2ViNDlhLi4xZDQ4YzBi
NzdjZDAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMNCj4+ICsr
KyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPj4gQEAgLTQzMyw2ICs0MzMsMzkgQEAg
c3RhdGljIHZvaWQgbnZtZl9jb25uZWN0X2NtZF9wcmVwKHN0cnVjdCBudm1lX2N0cmwgKmN0cmws
IHUxNiBxaWQsDQo+PiAgIAkJY21kLT5jb25uZWN0LmNhdHRyIHw9IE5WTUVfQ09OTkVDVF9ESVNB
QkxFX1NRRkxPVzsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgdTE2IG52bWZfYXV0aF9wb3N0
X3F1ZXVlX2Nvbm5lY3Qoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdTE2IHFpZCwNCj4+ICsJCQkJ
CXUzMiByZXN1bHQpDQo+PiArew0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAoIShyZXN1
bHQgJiAoTlZNRV9DT05ORUNUX0FVVEhSRVFfQVRSIHwgTlZNRV9DT05ORUNUX0FVVEhSRVFfQVND
UikpKQ0KPj4gKwkJcmV0dXJuIE5WTUVfU0NfU1VDQ0VTUzsNCj4gDQo+IFdoaWxlIGl0J3MgYSBt
aW5vciBkdXBsaWNhdGlvbiwgSSdkIHByZXBmZXIgdG8ga2VlcCB0aGlzIGNoZWNrIGluIHRoZQ0K
PiBjYWxsZXJzLiAgVGhhdCBtYWtlcyBpdCB2ZXJ5IGV4cGxpY2l0IHdlIGFyZSBvbmx5IGNhbGxp
bmcgaW50byB0aGUgaGVscGVyDQo+IHdoZW4gYXV0aGVudGljYXRpb24gaXMgcmVxdWlyZWQuDQo+
IA0KDQp3ZSBhcmUgY2xlYW5pbmcgdXAgc28gbXVjaCBjb2RlIEkgZ3Vlc3MgYWRkaXRpb24gb2Yg
MiBsaW5lcyBpbiANCnNlbmQvcmVjZWl2ZSBjYWxsZXJzIHNob3VsZCBiZSBmaW5lLCBJJ2xsIGFk
ZCBpdCBpbiB0aGUgVjIuDQoNCj4+ICsJcmV0ID0gbnZtZV9hdXRoX3dhaXQoY3RybCwgcWlkKTsN
Cj4+ICsJaWYgKHJldCkgew0KPj4gKwkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAicWlkICV1OiBh
dXRoZW50aWNhdGlvbiBmYWlsZWRcbiIsIHFpZCk7DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKwl9
DQo+PiArCWlmICghcmV0ICYmIHFpZCA9PSAwKQ0KPiANCj4gcmV0IG11c3QgYmUgMCBhdCB0aGlz
IHBvaW50IGJzZWQgb24gdGhlIGNoZWNrIGFib3ZlLg0KDQp3aWxsIGZpeCBpdCBpbiBWMiAuDQoN
Ci1jaw0KDQoNCg==

