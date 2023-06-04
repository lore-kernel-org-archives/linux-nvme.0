Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B212C77B73
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jun 2023 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3reADW55LpQ6HCy9CNIxO7xPwNa73+EMhRmMrM/ykI=; b=W/tRaMSb2+TWYa5DkaWumnAuP5
	3472lP3EEZ7b+eU3d4yQcy1wBt+viYUiCOJWs+30jmiszKmzqjuMLUl7l8av4if9//TuIPs+cnNSw
	KMg7mWk6RVuyzqZ17YuALxGKFNYj9O+aXub5w5pBYxnw4ccJQVm/rpocMvS23SOvrLQPlyEy3VSvU
	aazD7ibO8ub5vvxlVy0B54dVhNRErbrlb1vB8N2RMaJc1UDaN58mJyBsqOs003brWPNZLkIqsLEZ5
	7R6oM3CYDdViwgTB7rQaQNJVx9oPBGgJqWbI3yirI1czhecqOH2JgksjQCl1/lIM/hw0VcKf2oEgq
	m37RKadA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5hO4-00BTCC-10;
	Sun, 04 Jun 2023 06:38:48 +0000
Received: from mail-dm6nam11on2062b.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62b] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5hO1-00BTBS-0f
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jun 2023 06:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiT2s7rqnOknYpcnyaNxQU9Y5TPGx7/ezfbpJjS77FfPwb+UnexNwybrUU0FJ8xtI23qAf/V540YwFBT/dN8uZkRvnkTiOOKZbn1cUK/S9C9ese2/F7zAggn10a8PAcwArh4lN+U0VO3TjwKHGGC8/WizYQX+PF7JKWy/CozFZ1mMUdSPdFVhvxA6N4Y1FH9RLWdFWnbD/fTy+VsGM8SOcjprRFo2xpTmYMKP8OSox8p3F78Y6Ywe1pZikCvMy0pTRsAteFuJYfLKREk86tD/CGp4jrSrQ+lX9Eq2SWiQq/mNei4xl52KP6Nt+yfLjw0WeixCekixfl9Z6dGVSa6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3reADW55LpQ6HCy9CNIxO7xPwNa73+EMhRmMrM/ykI=;
 b=KwMDIdotkZ0fda40OazDdJAD5Zij1Zanr4+6q5XfHpnP2Ye1Ee13PpHzjnazNAj1r9OErbb/Upv1/JZXoXTgtSHZhQXDRX3k01hRP0EwkQclSoaJ5L1XlLfmXxsbmP1TQznZDYG93OdSSIVlOafKIniKLv9grLJ4AOa01BqUEEJ5pT/FNJzhz2DPfyAIwkxRxb5X5OAieDzlhXHqCr7Pq0atCc/VQlU6wlCBSPtgaCCy2RypFndKetS57YjKAKwGOL3j3aWu+lF8Cej27AcV/dZw0QgH0dmFrt6w/7ruAUV7/hj+E9068h9t4nABJgoE+MGNo0zZ0TDigevb1T4tNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3reADW55LpQ6HCy9CNIxO7xPwNa73+EMhRmMrM/ykI=;
 b=N32Ev0P4CeqHKl98OpjGq6gNv185eJ3a5oyPZdzYDbcJlh87gl4fpAj7wol6WHwV62wJomcnLEP3pjfQ1yl0QTf/XdHkEiEhQkkrsx4eOOLrvhTXIb5K9YrPaZ/ShEBF7Gm9Br/40LkB+H7mNMCLUeaw7MxfE2ZmxJBApRyjlhs+WdpFuZrD/6ConIbVrohWCw8/E0T8WEwRfTgAIJ8jAqBBcJ7thSG3stBvsbGiceZR3DfbzD8CeRDtbiIbz3Itw/ofeJAE79fnrrRRQFleb/PWyiUUVNEm1T48U2oLh53qaDkKWDR5ua1jqcw1PnwEnPe8HkqQJT390otHfNEC0w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 06:38:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.028; Sun, 4 Jun 2023
 06:38:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Kmemleak on nvme-6.5
Thread-Topic: Kmemleak on nvme-6.5
Thread-Index: AQHZiIFVFfUBMZMSrEydo+0HkKqpwK96TVsA
Date: Sun, 4 Jun 2023 06:38:34 +0000
Message-ID: <bcc3382a-9e28-f6a0-8bd1-76646872c4a7@nvidia.com>
References: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
In-Reply-To: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5083:EE_
x-ms-office365-filtering-correlation-id: 6299b697-b5c8-495c-3296-08db64c65235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZXKUs1zQl+bgL5hTCWdJQQQhuWFgDLNMreB6ewlcCo5yzBq+y/J6x7Wl4MvxpG2LT14V9HN4nOtF/0z4xugsRqWus5YJMhH/flRF0rDygrSoXzIhaxQb7qVBAI5TdHDesYtLt5PAx1Q4xFJCTZSXOI0ROnwwJAiF1mNeQfrAt8nTW7U9PsWr71dUd21M+3rKvig1m3+kAVfvgkW3pEJ2Y7N/lszOCAkAlHYrnbQDnvCGDSWNEOWoL/g2DcVI2VVkKO7nqvtcNFjEgylg/f+PtrQg15CwZ+J4kwjHVgU7ftNPiakmSQyH4cB7v8z0wKzO/Cnb3LL2FajKfXms/MkrwEG/1/6ZzefiP228fO5GySmCZ/4wWWUrr/WWm1q6tZPZIvt94VKqTY4R9ZpF1180/Qp+ofC1nRiy1Xhgxzr66bTtRJFIKOZxRaQP6fkhhq62x/C0EeZN+Fp5Hrl/VVSWNn/Su/JentQL6kH4r3zjvAamiqAkQaOPW4rv/3+rrp2isM6jmHMatHe2kw/HsNNKtVS7stWTfE7LRH5OBzVIFeaPkkLl7AlrbDZDmSELCHtZr8ZuCbH4vnwBKk/UutGseoXNlRKb3KEt3yrxqHeBYDrTPNozanMExB3WJKNCRdy43hbujT4j57iHxSEW8IX2FVSreuSWGjG/6c+0yux9+hcPvRqjqFd7X2y3pzybdvw0K3yqKG/naN1r9XvbWLf7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(6506007)(6512007)(91956017)(5660300002)(316002)(122000001)(53546011)(186003)(38100700002)(64756008)(66556008)(66476007)(66446008)(6916009)(4326008)(26005)(76116006)(66946007)(31686004)(6486002)(41300700001)(38070700005)(36756003)(478600001)(2906002)(2616005)(86362001)(31696002)(71200400001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVMrVTU3WTgxcTMzMGtBdThVUmYrU0NyRzd0Qnk2Q01aZXFWWlJVWEExa2Ir?=
 =?utf-8?B?bmF2RDZoVTErTUJDOC9QNnIxZWhOaGpnZXVPMzMyZVlGUWFjYit0aFlWWk9V?=
 =?utf-8?B?SlBCcVpmKzA5TWJQVkpMdTNiZStnaGtCUENCaS9sbWZFZDdKTmFDTnlIRFcw?=
 =?utf-8?B?Q0JSTWhtMi9qYUMrUXZoaEZWV1RVVTl3MTJUT1lWZEdzUlVKUnlLL3J0ZldK?=
 =?utf-8?B?YkJod2VpNVRpN3F3N2FJWlJIVXMzekZEaW5RcGdIbHhwQWdxTXd3bnB0N2pq?=
 =?utf-8?B?STgyZ3VldXQ5RExOTHNVRElrcHo3Wk9KaVh1aWJLWDhJdWdIVU1RcG12S1J5?=
 =?utf-8?B?V3BOcUdsNlFicUhoRkFNTHhJb2RINlR4ZWNYM3dMaE5Ga25yNlFDZmduSW9q?=
 =?utf-8?B?RUkzNTNQOTRWaTJwdXNwNTRLUWZQTHNLRWgreHJvMG9peFNuME41cWZqMmh4?=
 =?utf-8?B?YzFjY3loS2xsRG1KYUtSSWJMK2ZhR3FaNkVMQkx2YXkyc3JKSUxIdEVvdTJ2?=
 =?utf-8?B?cHF4MFhCV09nWXQ2QWF1VDFLQ0FraEpnRjlnRU9TRmpJUm5wRzRtSGRrVTVL?=
 =?utf-8?B?aXMxZGg4Q2tqZzBaNUJFWEgxVWFSZ1lmS1FPNkRINnc3VE1lN3VJUUZyc0xZ?=
 =?utf-8?B?YlE4Y3YwNkZ6Q1RzL3JXVG5ITURRMzVvNUtTQklzaEZxTVpDNWtDZmgzVW4z?=
 =?utf-8?B?T2hUak5renAvUVV0Q2lKc01pVXJ1VW5YOFRHQ0dGN2luZnJKa0lUWDNaTzhr?=
 =?utf-8?B?MlVRS0k4bW5RRTBVcURiRWdUYjVMZjJweE9KcUpNQ1pHbjU1MW1HSkdLdG5q?=
 =?utf-8?B?QmxhRHBSQTQvMkNsRS9NQ2xRVktVakVadzBoSk5ySVZhekhvbXZoNW9tU3ZV?=
 =?utf-8?B?MkcrV0NMSCthUVhRR0U0T3B2cWtJWDlCMWo1Z0RKb08rWGVLM29hckNCS1Ez?=
 =?utf-8?B?WWZ1d3h5bFVHcVQwb2VYUmhaWE1kcEFNN3EvcnA0VTBnL0VOYWZ0amdJUHVm?=
 =?utf-8?B?dnNPdVVtTS9OWlpoMjNYbXBiUzEyd2pEVEdqLzJrUVNCaVNwdlpXbDF4WlNW?=
 =?utf-8?B?L2VLZkg3SnZ5V2ZkRzl1Qks4NHlVcU1KN1VLWmpkdWRhVWIvVUY2ZkVGQStt?=
 =?utf-8?B?YU43SklHM2U5NmMwdngxUktGeFJIRHdxU2hKWDE4SjdsdzV4eklvamsxanNY?=
 =?utf-8?B?ZFlDSWwySUFwZ3pkR1ViamlFWXFLcVdDNGl2SnRTUGh6TWozcExDZllwbzcz?=
 =?utf-8?B?Z0cySGZRSGVlOXBLV2h0bHVGOSs4bHQ1eGp4MkFidlh3eU9kczdZVCswWWw2?=
 =?utf-8?B?N0VTc0MzTGNWTnZRbmZFWG5FVW5rVEFSQWRtOERmKzVMbDNkWmltZzFneEI4?=
 =?utf-8?B?bS9BWG5WMGtGTHArRlNQQVM3M2Q5Q1MvNzl0amZFTXJuMUNBY0xMYTNGYjNZ?=
 =?utf-8?B?WHJEUTd3VURJWWdTY3dGMzRuTnQ1MjRDQitsRUFjcFJER2g1V2dGaTJxWEhi?=
 =?utf-8?B?SXNoeEdVd0k0dHBETjIyRjBPQUEvSHBzandZWkRveEhJUWhvUTVZUG5hV2U1?=
 =?utf-8?B?TkUzK2hJb2lZR09QV2VDVEhrR0JKdnRkZHN1M3M5U3JTKytINUN4VXBlRW1m?=
 =?utf-8?B?d0JHSU9NMHNrSDc5MS9LbmFaRzIwLzJWaHF6VjhBRzBrYzM3WlUzb2FjdDBG?=
 =?utf-8?B?VzkwdW1RQTRHUjMxWkdXVVJ3Y1YyWXpHV2g3RllTcTZNMEVzMHZwOGg4dEpo?=
 =?utf-8?B?WEVRaUpWZVNOSDZFY3NacnlEZ3QzQzFqOElweXFwSnUvMXVVbE8rQ01kZmJt?=
 =?utf-8?B?LzVzQVljTEcrcVFLVEVTK2lCSm8rekZLQUJYNFphdjZzYStmdVVBZWFjcjlt?=
 =?utf-8?B?NjM3cVhjL0t5ZnBoMUpCVy9Mc3NVSDM4ZThGWDl6ZEJna0R0Mm16UDRLcDRt?=
 =?utf-8?B?RkpGekpKeFF2QXNFbGF0RFUwU3k1RDhzcU9WcE5BaHoyRVFVaVZWbmJWWFZ5?=
 =?utf-8?B?OWlwL2NqeHdRcGs4SFFGSzF2TDRDWGtwTHhJUks3T1RTYUh5a3ovL3NMWXMw?=
 =?utf-8?B?QnVmcDNxc2FZTzkxMTNYU0kyRXF0RC9VYkdkZ3Q5UHBDVmlReGJvbXZ2aEhV?=
 =?utf-8?Q?7DlVeD9/3CoKlElTXorE6kyV6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B81EFBF4AB39747AA4D5D2149663ADC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6299b697-b5c8-495c-3296-08db64c65235
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 06:38:34.8536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rkcf76IxtQihr3j4ws2IpycsDmJoEN5eApd4TBNA1OFfbOiyjWtuWtdfJMADxtfrr5Jv+yWE9LJEZ0kirjeo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230603_233845_335289_4B6E4284 
X-CRM114-Status: GOOD (  15.65  )
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

U2FnaSwNCg0KT24gNS8xNi8yMyAyMjozNSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBI
aSwNCj4NCj4gSSd2ZSBvYnNlcnZlZCBmb2xsb3dpbmcga21lbWxlYWsgb24gbnZtZS02LjUgd2l0
aCBibGt0ZXN0cw0KPiBudm1lLzAwMyBIRUFEOi0NCj4NCj4gbnZtZSAobnZtZS02LjUpICMgZ2l0
IGxvZw0KPiBjb21taXQgODUxYzIzYmU2ZmM5NWE0OGRiZGFjODY0ZjE4YmU2M2Y5YTQxZThhOCAo
SEVBRCAtPiBudm1lLTYuNSwgDQo+IG9yaWdpbi9udm1lLTYuNSkNCj4gQXV0aG9yOiBNYXggR3Vy
dG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KPiBEYXRlOsKgwqAgVHVlIEFwciAyNSAwMDox
Mjo0MiAyMDIzICswMzAwDQo+DQo+IMKgwqDCoCBudm1lOiBtb3ZlIHN5c2ZzIGNvZGUgdG8gYSBk
ZWRpY2F0ZWQgc3lzZnMuYyBmaWxlDQo+DQo+DQo+ICsgY2F0IC9zeXMva2VybmVsL2RlYnVnL2tt
ZW1sZWFrDQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4MTE0YzYxMGMwIChzaXplIDk2
KToNCj4gwqAgY29tbSAiaW5zbW9kIiwgcGlkIDI1ODIsIGppZmZpZXMgNDI5NDk4MDc0MSAoYWdl
IDQ4LjI2MHMpDQo+IMKgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQo+IMKgwqDCoCBjMCBl
NiBhMCBjMCBmZiBmZiBmZiBmZiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAuLi4uLi4uLi4uLi4u
Li4uDQo+IMKgwqDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAuLi4uLi4uLi4uLi4uLi4uDQo+IMKgIGJhY2t0cmFjZToNCj4gwqDCoMKgIFs8MDAwMDAw
MDA0MzBlNzExMj5dIGttYWxsb2NfdHJhY2UrMHgyNS8weDkwDQo+IMKgwqDCoCBbPDAwMDAwMDAw
MjNhZmJiZTM+XSBjbGFzc19jcmVhdGUrMHgyMS8weDcwDQo+IMKgwqDCoCBbPDAwMDAwMDAwMTg1
NjkyOTI+XSAweGZmZmZmZmZmYzBhMTEwMzkNCj4gwqDCoMKgIFs8MDAwMDAwMDBjYTRkNDFhYT5d
IGRvX29uZV9pbml0Y2FsbCsweDQ0LzB4MjIwDQo+IMKgwqDCoCBbPDAwMDAwMDAwY2I4MDgyYmU+
XSBkb19pbml0X21vZHVsZSsweDY0LzB4MjQwDQo+IMKgwqDCoCBbPDAwMDAwMDAwMWIxOThlNTE+
XSBfX2RvX3N5c19maW5pdF9tb2R1bGUrMHhiNC8weDEzMA0KPiDCoMKgwqAgWzwwMDAwMDAwMDM3
MzRhNmU4Pl0gZG9fc3lzY2FsbF82NCsweDNiLzB4OTANCj4gwqDCoMKgIFs8MDAwMDAwMDA3ZTMw
YThmNT5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNCj4gdW5yZWZl
cmVuY2VkIG9iamVjdCAweGZmZmY4ODgxMGEzOTJhMDAgKHNpemUgNTEyKToNCj4gwqAgY29tbSAi
aW5zbW9kIiwgcGlkIDI1ODIsIGppZmZpZXMgNDI5NDk4MDc0MSAoYWdlIDQ4LjI2MHMpDQo+IMKg
IGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQo+IMKgwqDCoCAwMCAyYSAzOSAwYSA4MSA4OCBm
ZiBmZiAwMCAyYSAzOSAwYSA4MSA4OCBmZiBmZiAuKjkuLi4uLi4qOS4uLi4uDQo+IMKgwqDCoCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBhMCBiMyAzNyAwNyA4MSA4OCBmZiBmZiAuLi4uLi4uLi4u
Ny4uLi4uDQo+IMKgIGJhY2t0cmFjZToNCj4gwqDCoMKgIFs8MDAwMDAwMDA0MzBlNzExMj5dIGtt
YWxsb2NfdHJhY2UrMHgyNS8weDkwDQo+IMKgwqDCoCBbPDAwMDAwMDAwYWUxNzJkZTc+XSBjbGFz
c19yZWdpc3RlcisweDI5LzB4MTMwDQo+IMKgwqDCoCBbPDAwMDAwMDAwMzVmODYxNjQ+XSBjbGFz
c19jcmVhdGUrMHgzYy8weDcwDQo+IMKgwqDCoCBbPDAwMDAwMDAwMTg1NjkyOTI+XSAweGZmZmZm
ZmZmYzBhMTEwMzkNCj4gwqDCoMKgIFs8MDAwMDAwMDBjYTRkNDFhYT5dIGRvX29uZV9pbml0Y2Fs
bCsweDQ0LzB4MjIwDQo+IMKgwqDCoCBbPDAwMDAwMDAwY2I4MDgyYmU+XSBkb19pbml0X21vZHVs
ZSsweDY0LzB4MjQwDQo+IMKgwqDCoCBbPDAwMDAwMDAwMWIxOThlNTE+XSBfX2RvX3N5c19maW5p
dF9tb2R1bGUrMHhiNC8weDEzMA0KPiDCoMKgwqAgWzwwMDAwMDAwMDM3MzRhNmU4Pl0gZG9fc3lz
Y2FsbF82NCsweDNiLzB4OTANCj4gwqDCoMKgIFs8MDAwMDAwMDA3ZTMwYThmNT5dIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNCj4gdW5yZWZlcmVuY2VkIG9iamVjdCAw
eGZmZmY4ODgxMDczN2IzYTAgKHNpemUgMTYpOg0KPiDCoCBjb21tICJpbnNtb2QiLCBwaWQgMjU4
MiwgamlmZmllcyA0Mjk0OTgwNzQxIChhZ2UgNDguMjYwcykNCj4gwqAgaGV4IGR1bXAgKGZpcnN0
IDE2IGJ5dGVzKToNCj4gwqDCoMKgIDZlIDc2IDZkIDY1IDJkIDY2IDYxIDYyIDcyIDY5IDYzIDcz
IDAwIDg4IGZmIGZmIG52bWUtZmFicmljcy4uLi4NCj4gwqAgYmFja3RyYWNlOg0KPiDCoMKgwqAg
WzwwMDAwMDAwMGU4NGU0YjYzPl0gX19rbWFsbG9jX25vZGVfdHJhY2tfY2FsbGVyKzB4NGMvMHgx
MzANCj4gwqDCoMKgIFs8MDAwMDAwMDAwMTk4Y2UyMD5dIGtzdHJkdXArMHgzMy8weDYwDQo+IMKg
wqDCoCBbPDAwMDAwMDAwNjFmY2Y2NjE+XSBrb2JqZWN0X3NldF9uYW1lX3ZhcmdzKzB4MWUvMHg5
MA0KPiDCoMKgwqAgWzwwMDAwMDAwMDhjMzRlMGRkPl0ga29iamVjdF9zZXRfbmFtZSsweDRlLzB4
NzANCj4gwqDCoMKgIFs8MDAwMDAwMDBhZTdmMzA0Mj5dIGNsYXNzX3JlZ2lzdGVyKzB4OTQvMHgx
MzANCj4gwqDCoMKgIFs8MDAwMDAwMDAzNWY4NjE2ND5dIGNsYXNzX2NyZWF0ZSsweDNjLzB4NzAN
Cj4gwqDCoMKgIFs8MDAwMDAwMDAxODU2OTI5Mj5dIDB4ZmZmZmZmZmZjMGExMTAzOQ0KPiDCoMKg
wqAgWzwwMDAwMDAwMGNhNGQ0MWFhPl0gZG9fb25lX2luaXRjYWxsKzB4NDQvMHgyMjANCj4gwqDC
oMKgIFs8MDAwMDAwMDBjYjgwODJiZT5dIGRvX2luaXRfbW9kdWxlKzB4NjQvMHgyNDANCj4gwqDC
oMKgIFs8MDAwMDAwMDAxYjE5OGU1MT5dIF9fZG9fc3lzX2Zpbml0X21vZHVsZSsweGI0LzB4MTMw
DQo+IMKgwqDCoCBbPDAwMDAwMDAwMzczNGE2ZTg+XSBkb19zeXNjYWxsXzY0KzB4M2IvMHg5MA0K
PiDCoMKgwqAgWzwwMDAwMDAwMDdlMzBhOGY1Pl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NzIvMHhkYw0KPg0KPg0KPiBGb3IgbWUgaXQgaXMgbm90IHRoYXQgc3RyYWlnaHQgZm9y
d2FyZCB0byByZXByb2R1Y2UgdGhhdC4NCj4NCj4gVGhvdWdodCBJIHNob3VsZCBkb2N1bWVudCBp
dC4NCj4NCj4gLWNrDQoNCg0KcG90ZW50aWFsIGZpeCBjb3VsZCBiZSBwdXJlbHkgYmFzZWQgb24g
Y29kZSBpbnNwZWN0aW9uIDotDQoNCm52bWUgKG52bWUtNi41KSAjIGdpdCBkaWZmDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jIGIvZHJpdmVycy9udm1lL2hvc3QvZmFi
cmljcy5jDQppbmRleCBiMWZhMjdiNjA5MTcuLmI4ZGYyM2IzY2JhMCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmlj
cy5jDQpAQCAtMTQxMCw3ICsxNDEwLDcgQEAgc3RhdGljIGludCBfX2luaXQgbnZtZl9pbml0KHZv
aWQpDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQoNCiDCoG91dF9kZXN0cm95X2RldmljZToN
Ci3CoMKgwqDCoMKgwqAgZGV2aWNlX2Rlc3Ryb3kobnZtZl9jbGFzcywgTUtERVYoMCwgMCkpOw0K
K8KgwqDCoMKgwqDCoCBkZXZpY2VfZGVzdHJveShudm1mX2RldmljZSwgTUtERVYoMCwgMCkpOw0K
IMKgb3V0X2Rlc3Ryb3lfY2xhc3M6DQogwqDCoMKgwqDCoMKgwqAgY2xhc3NfZGVzdHJveShudm1m
X2NsYXNzKTsNCiDCoG91dF9mcmVlX2hvc3Q6DQoNCg0KV2lsbCB0ZXN0IGFib3ZlLCBpZiBpdCBm
aXhlcyBtZW1sZWFrIHRoZSBjb2RlIHdpbGwgc2VuZCBhIHBhdGNoIHNvb24gLi4uDQoNCi1jaw0K
DQoNCg==

