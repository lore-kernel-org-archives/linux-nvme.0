Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A00BC6FA82
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=271vvUCXSgNlfij0m2PG9WJ3HtHaGD0Z4/Loqr/o4sM=; b=hcU3WnOaxBsvj6PBpOGKeuwZPG
	cP4+2LIV+TiaWB0a8ICE6cONQIZm9etHRNe6J7+gLO6pdjTukBJ7b7bW7sWh+O3fbiWAD+VVYNA7u
	Ps2frFq6gM1i+P92RbRzkW8SXvfDST7I2kmjs1+l3RMSDtyYw7nMRXLqtDuMwiXyyD4JRR2TKjUAL
	4nMXF1HXQyWpylWA+Pqcv2S/T+kKnxClZsufob2JfB4GCcR8BnZHG7HSOcZEn55eQCxYvuALhYn4m
	b1s4BPOxe8I1C/3BGvnMTfjOSS7SG7y6xXFVM7rtrjl2rMPCnNfEZgIU7d4ioT5at02ZY5O9EM5Rh
	C6RJe0kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaPou-00G7io-Kv; Mon, 19 Sep 2022 23:04:56 +0000
Received: from mail-mw2nam04on2042.outbound.protection.outlook.com ([40.107.101.42] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaPor-00G7eP-SZ
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 23:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXPZQMvE8YIhV38R0Dke8d0EEkLn4z3ElM2R5UsYGYuMs1vTFcKujRn9DBRbUdjU8J2Bh4wOZQXEUchhLSHlcNjxtssEdKtTlMi4Sx/oIvLWIc4nuYMuT/XDOu7BQBMSEOBv2F+u3SJgaaBInfjMLnd8aiSODlt5JGf0Hq2SlgozIKLSkSTTdy5uI0sxRyjki6NysHxIbzdZODdZuIvTDISs8e5QzXmebPwzpwiMByfzwdktKGAUcufuOvgRx2fq7+rf4fyqC4LLkS79XpGm5W2hs47cCDKTe0a2uvZr/Uyq8/oafSvMS4vsUTeuqQtijSZ18HjD/zA9lkVR9AxThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=271vvUCXSgNlfij0m2PG9WJ3HtHaGD0Z4/Loqr/o4sM=;
 b=YwX76KXL+tD6ZBO0uw+4orP09OKGvqflkHNmIprQhkHks9xHT7ASR2NkXjwu6L6m2olP8eM/64YdKpgxJaMGLVJ0GudobEogs3M53Nb3Fp5afNWKrx1ieTRPow4doEV2vYQMFfM6Zxz3M31yvRzmdLKEE1dF4ofzAbUdnsEGIwLARxK5BEhX+N3tOJx72D8aUewApwlhozIXe1HVOl4H2dQlrjB80CanvgnnDU7BiPlj3maWCzUnvWeEVBSyB8E2gnQ309iDrhxf1Bp5cG7z8y/0IN/Pc/ZuyGUoIjTUaLIcabCwp/p5NT+DZQLIYEs6dbT+q1RyPmVmpbh8N4yTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=271vvUCXSgNlfij0m2PG9WJ3HtHaGD0Z4/Loqr/o4sM=;
 b=EU+bfvz7ZNLmVRyJD9sDD0T/i8Zoqs8rt95IX+T8en9Q5OGum2GqEYYnomKb2VUJKJmR5rCxeGThsUbSq7DiHq++yANsN+L3SBjJBmGfv7T30qqICVozlLfuVVsiUuGqGi/Xctfy6lHBKad5VyP1oiM/CmS4/pWpA0MglVQuNDqPTP6xT7yT+5mIoLFCdMKMZ5sNIJc2Zb+d560ShOCNUudAQ68O+8ZVF6DCOcgaxySUn+GHf/UEE0OsdmdvJ3dkFDhbhralGv5Yk0Qz+AU2ETKxBNog6GB6DQBw0tcLJEsd4jkHsTuRNPYRdTQHQ4ZSh9VzVeCnyzYCtXZ1nNX5Ow==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 23:04:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 23:04:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: copy firmware_rev on each init
Thread-Topic: [PATCH] nvme: copy firmware_rev on each init
Thread-Index: AQHYzGCLpy4iw8DUk0eZg8STqlRfBK3nX6mA
Date: Mon, 19 Sep 2022 23:04:45 +0000
Message-ID: <a849175f-82d9-7c06-f606-0020a752d20a@nvidia.com>
References: <20220919194508.1704346-1-kbusch@fb.com>
In-Reply-To: <20220919194508.1704346-1-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5390:EE_
x-ms-office365-filtering-correlation-id: d0881f5e-f9b8-436b-a4cc-08da9a93584f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  KT6QfNtiLPm+V0nHb1WP8dy/9ABF3t0LGcZH5FafLZDz4VnkYS72NZZSaFTnQeCwyiw9xxkPQFKd9QQWwPQA3pTxG7Da7ajcV3ZSKsfXLNabvseoXAc6XvTSsoIGyKSV/1x9DrWRfGsMajoDgT9H83pZGUKFZSQoAMPHUYyoIxZ3Awz1RqUQfnuoq6NhzTQrUdyevRYcV8VdMZVPfc4CItFJ6gUVYk86VcppB1DRyMns8w4a1moQT38JQ2ccrCpSyUatfRlZ52RNmAxAb09waJMG8Y1bpBLjNUtS48BNeliMxWssSJNDEdhaEY6AsXnyRs1jRff8gxoY9q8tQHG1Oc2tthTe1/tvCuXPF4tpdB/UxrPAOxD9wfauzfvDlvaFNjvaVCeROw8Ea5xr1dfO6JaPf8zFsPebakwrqGxfvMgNU1HPkRNxmaPCUxfyZ5wTBbRD2WuQD1L+FFZfId1bTzqQsXYVMyHp4y5TkeWFL0va6c4HZIBMGjBEzxqjQd/oMNOgsQ/WzffKEPRDojtUJQ1FAWlF5hQnN4ZvRlZbzGyOmbQOssLSXbt1yc9j+61LHb+39ibKHwJcpXYAue8GF57/LWOBLS5nzlcMnK4WnJVuBYBj9tzf+cEWZ21dg8Ay0mFTrGjZTey58zbgW8kIPTmvBhh5/sT7yWxvwNauZjYbOtr8uTFbqWqzds+VOX93o066etfiUhIhr1oRNugKhlbYdANs4cSN+3P4zcPzPnUO7HJYknZH3ppBIZ872UvR2pCFyAgfOr6KbrpEZlOi0pk4AfMiJx/fRTcwmPznoEMQmF0SEL5M0i6W+nsOvAA+xeiWuAw6+62MPn4TOkaK6w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(2616005)(2906002)(4744005)(38070700005)(53546011)(41300700001)(6506007)(4326008)(91956017)(76116006)(8676002)(66946007)(6916009)(64756008)(66476007)(66556008)(66446008)(316002)(54906003)(71200400001)(6486002)(5660300002)(31696002)(86362001)(186003)(8936002)(36756003)(478600001)(6512007)(38100700002)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bUF3R0UxK1JYWU5vL2pqQ05CemkxYU55R3Bxc2U3aHA2ZTNPa3diUE9hZHFr?=
 =?utf-8?B?WWZaM1YvUmlvMWNuaGdEOVlYK2V2VDliVlR3b0hRWExPMnp3UnMxLzVWaXF3?=
 =?utf-8?B?MEhTM0tsNzNNZGZoWmU5VUtEelc5ZzJtTnN1SmpTem11MitQYlJ2eEg5UFdJ?=
 =?utf-8?B?SmY1d0M4MHpTVDREZysyRHNpeXhrMDlCNk1YdnBRcHMxQVFkSlk5c0RFRmh4?=
 =?utf-8?B?V213UWdIeFV0SzNMWXQ2eDU4TjJYRmN4Zzhydm9JSlpSV3dwR0Q5citsYTZl?=
 =?utf-8?B?NmRZZWttUFRueU9pcXd3Sklsa1ZsaU1DRmxyTmNobk9lTkM2SVZoL0d6ZW4z?=
 =?utf-8?B?eG1UcjI3NVhNTStGNHlNMXJkNTVCRnViNDVHaUFRek1TS0pWUGVvVHRwWERm?=
 =?utf-8?B?WTdZR0I2Z3VSbm9QVGJHTkI5YWJ1QjNjcXpHQkFrS2pYZll1R0FYUzY1VHZx?=
 =?utf-8?B?Z2JUTENTNkc0Zmo1Q3FXbmFmUmRxWVBvU3Q4Y1hqdStMUDJwR0ZybmJwVVdo?=
 =?utf-8?B?WnAxVkxQVm9MMFpSRytFY3U5TTJqRGtGS2d6VU8zUmZEaGJ6VVdteUdzL3lF?=
 =?utf-8?B?aGlQeGQwM3ZHemhEL3NodVR1eWxtV0gwMGhEczJFYVFqR1liRlVqc3ZvcDNh?=
 =?utf-8?B?VkxjaUhoblVpZitTYnNQT3NNRVI3dCtqSWxqYnZWa3pQVmFxL2dLMk12L3F0?=
 =?utf-8?B?WTRYK1M1dUxYUmtBbStuNVpwN1VKQ2l3M3RqS2crQXpVcXpERXcyYnM2YlVk?=
 =?utf-8?B?aGFKNGsrN2VWWEg5SG9yN0p4TWVmbUJ6WXVYMTJWYmVXVTNMRHFINm95c3Ft?=
 =?utf-8?B?TG40U1htVDBpOHkyVkw2UFpQNFczR1hIT3A5RmVrbW5tMHlndmpYaWMyUTd6?=
 =?utf-8?B?Z1JJbmJ3SzUyYWhpNmcxclBtT0tlL1F2WitaU1FlbkFqeCs4UkVCZlovYWdC?=
 =?utf-8?B?NkxIOW1MOTR1Sk9kV1BJRHhxcUZ3bkZWdHNwbTlZbW5lMEJEWkJJN1Rqc1JW?=
 =?utf-8?B?b1U3N21DdWhQeEZGcFZKRkQxV0lySEE1WmxkakQ2NW00RVR4K1ljUmd3UDJO?=
 =?utf-8?B?ZkxNcEtna2RyQ3lBaEo5YkNqbGU3UUFST3UyTUtKOXpzU3JtaU5KMjI5ZTRs?=
 =?utf-8?B?SjIzL2thMGo2Njl2YnpEWWc5N09oU0ZQVTJXcGYwa2V1dTBZU3dkYkpGS0o4?=
 =?utf-8?B?TjR5VVI0bk5hVTdRVnh6MFQyL2gwWllsZUc1VTluTmM0OTRQT0hDd3prWEdn?=
 =?utf-8?B?V3RwTzc4R1RmUzRpK1EvQjIyUDNYZENyOTBwQWdzNUFGRkMvVkJKS1RBVXEv?=
 =?utf-8?B?dFBPTHQxOEYyVGxOc2tSdDAyZ0t0emVkcEUzbFl5dmVRTWRDcWsrUDZmQXQy?=
 =?utf-8?B?QTc3TDdOWkJsUE9lYXUyOEtHenZIbHBxSFhlbzhwQVR4Z2xTMTkyREZKUDMr?=
 =?utf-8?B?VnQ1N2ZYUTAwL0ZNaEo3OTIyaUhEbVlFeXoxOWVSUTBsblVkemd0NXRWNWpM?=
 =?utf-8?B?M0srcU5yTWNyNThuRnZ1L3NsYThtQUlCQzU2UE4ySFNWMS9rYjVoWnBXZUlO?=
 =?utf-8?B?YVdoZm5VUVRhaFNJemxxUGRjUGtXUkVFL3dsM1RVeTM1cDhUbkRDbUVreUNo?=
 =?utf-8?B?ZDVoWVo4Mlk2LzVLOCtHNHJKY1ZKM3hDV3NhUXpvQmU2Y2htdmp2Z2dQaDNC?=
 =?utf-8?B?NklPeFJEc2lmSXFVYW9KNzQwRW1QVGxxanNub29jR2EvbE5JT0NiVzFDN3lP?=
 =?utf-8?B?WURJTDRCZXo2UExPaXZuTHpXZHFBY0Q5L0RNSUhTNlpUYVVreWMyNVp3WmJL?=
 =?utf-8?B?WEppUDc4K0JFTTNlay9sVmNVU0thVGxFTWFCazBpS2hsMU5YQ0NkTVFadzBv?=
 =?utf-8?B?UTJCQks4TEkzTG5JUFlLbDVFVU5TMVpSYWtnUVFRV2RudFNpM1VIa1Z1U09s?=
 =?utf-8?B?SHlidlJKNkxqZmtIa0ppek8xdHBEb1ZQS1I0RXpVVytSRFN6WVVHMUZpejBU?=
 =?utf-8?B?ZGNRdlJkc2hkaE4reUtWRkwzYXJsTTZLSngyZnZwTG40U2dVbUY3NmZud0tI?=
 =?utf-8?B?N0JSZjEwS0owVk9IKzZETkVzNlVkVHlTbW5tbVR3Z3lRYWk4RnFjaC9ld3Nm?=
 =?utf-8?B?ZitVaXpHYUw1QUtlUmV3RjdCTFhQTVJWRWRmRTFROWo0MnlaTkVqeExQMzRw?=
 =?utf-8?Q?eBSGdL/qRVdYB3dYC/f+deLs8mYsnHioLNzcO39Dbwom?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74835930D38B1141B583944C31ADC7CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0881f5e-f9b8-436b-a4cc-08da9a93584f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 23:04:45.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKm3fWDWiHbvDNQse26KCoEfjSltdk8XA2ObmpwjkL3/GNqVExZu9vJ8fOwKV/2m5VwP+0k1e/pYXCaDJYReCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_160454_167495_66792070 
X-CRM114-Status: UNSURE (   9.87  )
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

T24gOS8xOS8yMiAxMjo0NSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBmaXJtd2FyZSByZXZpc2lvbiBjYW4gY2hh
bmdlIG9uIGFmdGVyIGEgcmVzZXQgc28gY29weSB0aGUgbW9zdA0KPiByZWNlbnQgaW5mbyBlYWNo
IHRpbWUgaW5zdGVhZCBvZiBqdXN0IHRoZSBmaXJzdCB0aW1lLCBvdGhlcndpc2UgdGhlDQo+IHN5
c2ZzIGZpcm13YXJlX3JldiBlbnRyeSBtYXkgY29udGFpbiBzdGFsZSBkYXRhLg0KPiANCj4gUmVw
b3J0ZWQtYnk6IEplZmYgTGllbiA8amVmZi5saWVuQHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCg0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

