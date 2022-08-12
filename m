Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49881C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+XdZY47RdjyIiF78elPWbhPI2uddG+WImhr6h2mhu0=; b=WwMmsGvbAkTUlLWBo1VUKwcdgk
	Z3Q/wSHpA2kA/xCnfwKEFkNG6eKCethN/3u+Rmnk/Y466VEsb9ysO7QBS3vCnBm6vxU5Nfvs6x2x5
	jGHDe7Co83RQbLpFkFTCov74Rn88qb5/xV6NnxW0N/Ru+DILVSlxHFvKD17y6s96nR+FzvQ9hRttw
	opqjjUW9M5RY4I+PJee1Y6gAEkzUiPEjxkEXsUI+y56TGrwdHZFPZSYUc0AKXijTAvMJySMgfbqLn
	zCxAFXgStIogwxsBN+IRGdbhH8V/DJhTv8k9R665/ZOposLMPF81aMCGD8w8KSXfa+pJRV305LLwj
	3h44aRzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYiK-00BgAd-JG; Fri, 12 Aug 2022 17:44:52 +0000
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYiF-00Bg64-SO
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 17:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY3jOuKrXQmNN41zHviQ9T8AyqRmIG37cmjQjwBv//Yc43/ELafuY0B0z5/sYgdfWVP86SeOZXi1gcWWyTyVGyb/9JsSFBqys6M3SPOmxHCz0xTTlksH6F45WPsmo+BlB2klTmAkkX64FKBUBwyvdDPkscxFu4bX+/L+VlSjBgjdl0zibwoHMeuDak+qfE1cK6x3POdtrC5nX8Eo8PmWI1VkjQ5phwlZfOVPeq7FKK34p188usqDfv2Jdd1nNGvwAaifwX0mUvzQt+SPOgVhg10ua8f3ejJ6UJxJyH2uyg4v6Q7eeeX0pwdD8XKbB2YvU+GAsBDUuzEtWlsmzuoDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+XdZY47RdjyIiF78elPWbhPI2uddG+WImhr6h2mhu0=;
 b=jdKMH7k9zM8rY3/5X/a8pExbHXh1VGEyrRltBGr/w0/ARViFiX2WdsbmOxQhBgslKylsnXH3zcY6GWGAHEUKB+N/EPqhWMsyQWU25hc6kE1ZcQb5d9pzNojJIonjMM2vwv+PdS65j/DdHjqnlPWbR9XjY1NC2umwFtuN8RDWiCFKbhbPcQX4MYbWlSxPGORzwToA2xOMh4f4gTvPrFtaTgTkmnCBHEWSEs9vZX1vBgjTrtHgsD0IDOL0TVWI2GeiTGl2P2P06XZY6rfRImaGtKLnrDvitMjNLLe7+gWkamfQRJjwuSBf5vBLWWmcZQNOhKoNVuqrScJs4xaVBkYuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+XdZY47RdjyIiF78elPWbhPI2uddG+WImhr6h2mhu0=;
 b=NWRRKDN4sY2PT4/wfSIUvzVRlRuaSZMBRSGMHvbmlcZt5U6OngoT2IpQsycKA1hyKMBxp2HLkUJJMimXKpBjMl5glIFitj28t1r7g5jbTyDMbTLq/uwHyzkmr5XmFEGJtHpShl9VYFLrAzw1RQQAnIPus9zfsLRMv+5MDHlcSAZZJ+xDoO8+9EqKwLpndru65m2RPmeCkr6Y2W4WKiuD6Y7Z8p5FGAVf2akA3nksL3vnc8dXv1SFPzFYv3mCH/N1y8+q87eYYn24qX7FuMTbaoPSPhzDgcEVV/92xQGY7t/wlU42QsrbWbrGP9CX17X/S17+i+KI37ekzUZ/PyhCVA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN6PR1201MB2515.namprd12.prod.outlook.com (2603:10b6:404:a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 17:44:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Fri, 12 Aug 2022
 17:44:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jackie Liu <liu.yun@linux.dev>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-auth: remove the redundant req->cqe->result.u16
 assignment operation
Thread-Topic: [PATCH 2/2] nvme-auth: remove the redundant req->cqe->result.u16
 assignment operation
Thread-Index: AQHYrflvRGmrH81sOkym56uSDX78Rq2rinIA
Date: Fri, 12 Aug 2022 17:44:40 +0000
Message-ID: <0e7ded6d-1196-70b7-11aa-f4a0abd1c101@nvidia.com>
References: <20220812031231.3386953-1-liu.yun@linux.dev>
 <20220812031231.3386953-2-liu.yun@linux.dev>
In-Reply-To: <20220812031231.3386953-2-liu.yun@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b94a91-f7be-41d0-5875-08da7c8a5534
x-ms-traffictypediagnostic: BN6PR1201MB2515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nAniR1rJnGn45jNPvRQrMqadzbGfaTHKMq89G8PtGWgDLmSTPLlTSqYkJ6hQ0/XQEIAUfQcXgPoPVPb8y5AnyzR7Hg26GWxpU6nwkmFPrufsD7CshX2TcX6l1QCAImdturAwRx/pwZpfQ9JBRGT/3FmNbo7xX5SvcOY92n9mey42UQSFiYr9/zP5ybOom7pfHiLnH/YgCIZdxzaQdinpbw+dnI2C7G2e///+8uO9YqFDDRAYE/QuTQAxuchutUbss/aFmaJBRDY5SgJsJTidByvw3vYBWkTm6sP0jhXDAR+PzJrF8AkY0kVxMZHgnBTFYRc598AoXiGuVjZgFX1lM2Iy/HmdjF0WIYblEBCUy5kdBMIvP+X+C08AQ5tCmdc7jIVxzu1fdMd4RFcn24nB078oWVCbFt9Eci9As37dnVqRmR2DQJI2mH906HZuqpXJjy4fOMX6wMQ/d2hCYKiwbRpHF0T+R1JauJEdkDOfEDhlPxDo90xiJ1P4qnsm0kgvrZgqasdxIE6onfPEKHKDYL9PaUUglyV/gXS3Qp9ONuCB1Bs+Nxq4vjRYNqb0AVmdHadEzvYS5acWHqiKzOAZwbAzRcvZUNHa1w0bRsdZ8+PDzanwmUyew6f/rPMszJSBsb7GZR0Hzi5it0unDjZfJag37gPtyV5rrwJfmHfuhu21qJZjmJLq0nFTt0AEsoI9Eh2VMRqwB9jzwCHmlBuhvUMhuLCMSdEE5vvRP1dOfV9wFq2OPOqTwGQp4Ubl62mHiG5J2Am9244anLgf6B4Ejs1q/NiEQW0jrx6edfIDTi6zyAYyGLMaRRPQrNmQWAOSAuJYNNMSRsjf77e6bynqAGXrVx9Ib9prEv0YmP+vVFontdbTx2M1EB/sUPW+n5IP
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(2616005)(107886003)(478600001)(316002)(2906002)(38070700005)(6486002)(122000001)(6916009)(54906003)(6506007)(38100700002)(36756003)(31686004)(31696002)(5660300002)(76116006)(66446008)(91956017)(8936002)(71200400001)(64756008)(66946007)(66476007)(186003)(53546011)(8676002)(4326008)(558084003)(6512007)(86362001)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YzA2UkJXYk9XRitoMEwwY3JXUmhqUnFQbGJMdmRPOVl2OXFUMDA3aWZSUWl6?=
 =?utf-8?B?TFl6YXcrS2RNTnJVNVZEUzd3ZmJRSWUxWlArUWVzeFg0alJHUmRNeUc4ZXRh?=
 =?utf-8?B?SjlhSGdmVGlGeXpkaTdMWlpxSE5OK0JGWGhOeHE4TytJMUdEWGpGazU0SFNx?=
 =?utf-8?B?a2dQMkJSK2VUTUtGUzNDcXhXV1ptZm5jWnJtV2laVE9lMlVESzFQUXpnMXhw?=
 =?utf-8?B?c0pSVEs4WE8zbHovS3lHR2ZObVFOMFQ2RlN0clBaY3dNVnVBajNKYTBZWklK?=
 =?utf-8?B?SmdOWWxGWnRKRTR2Vk8rTDh6aXlXeldseFhqTkVGMjJkSDU1dStOSHd6dG54?=
 =?utf-8?B?LzFqMzBiZDZmUHZSd21uWTk4ZzY3UHFnUytUTm1GNDBRZTZRb1ZWOG92WC81?=
 =?utf-8?B?WjZ4VjN3NEIvRHBOdWczVnVDckZ2NGp2R0RDY0lzZDNIZkJ2M0FZYWN2V3Iw?=
 =?utf-8?B?Yi9ZeUp5cHVjYU1sWG9zN2tFenhFVlI1dVhWQ0VueHlFM1QyNmkxdkJDbjl2?=
 =?utf-8?B?ZERyR2pXY3hFQjYxRkZxSitnckp4MVdXdmJPcEpIUEQrdmpNb1VTQy80VHJU?=
 =?utf-8?B?VkNNR2dsc3J2TnJZTWpIOHBzZG8vV2U2bWJaNVJwQVVTNXk2QkZMNnQvaGQ3?=
 =?utf-8?B?RUNpNWZoUXF1bDRuNXNYVUs1ZFdkc2IwUlIrTllqbHA2U1p6dXE3RmZxanV2?=
 =?utf-8?B?TXFubXJPbHVlUTdHTlpweTIzK1lVRHZtTGdmV2J1TEFFbnVhTEl2TUtpbUwy?=
 =?utf-8?B?cGw1M1gvaElZYjk2c3JpVHlMQ2lqekZJMi9yUkJDckdQVUpQbnJPNVVVVXE3?=
 =?utf-8?B?ajF3c3hRUzRSeGk0TnQ5ZkFZZ3U0NS8zTkg1K0s4SGVLdWsrUzAyYXdTN0Zr?=
 =?utf-8?B?dC80OUs2dVQxTWNXbnRHUHVTZ2lsOUhJRTdpdFVPamdpWk9wODdCZm4zQzJn?=
 =?utf-8?B?aXVkdGZXQ1h1aUlzNVNxVS9Nb25MRTRjb3k5RHZrM2N5VmVYalNxMmpET0F0?=
 =?utf-8?B?c1ZWQlpoeEtFRzNMUDJtejlSSjFCc2YzMFhhSmJ6RER6RGwraC9kRzJOcmVz?=
 =?utf-8?B?T1JZeENpdXNvTS83Q1U5ZEVEVUgzR3BPSndtZ2JYalN6VWJhQnlDZm9MMm0r?=
 =?utf-8?B?THRVT2NDajZrZ3RqT0tRSUwraWRQZG1nNHZWd1lPWFFaMWVEaXQ3N05kYnZu?=
 =?utf-8?B?RitCekhZMGdvMzRwWFVOeUdHc2xGajV5eDdWYk91aklhQTB0Q0h1bnFxM3FD?=
 =?utf-8?B?dTVRb1ZTSHVHN1YzQTk3VzY2UE1jZnpnMVgrVnpHS0xOOHBSQnZQc3Rvcmhy?=
 =?utf-8?B?enVvaVdiOEwza3NnelhiU0ZlV2JXUWpUUHJuWE1CNEJUZ2pya3k1TDNYY3Fx?=
 =?utf-8?B?akhMdlFrWVFnRmxERW1qSERhWU5mVlFHajdmSzg3QnFJZU5HbFRHYThaS0Jl?=
 =?utf-8?B?M0JzS2FKMXlOVW5XTExZMGx3eWVZWmV3NS83a05xcjBKVmRCUkpUbldRRzJI?=
 =?utf-8?B?QWRFOXI1YkNRNXJ0aWxQSUNLMFhxK0g5U1BUdndJMy9rSkwvQkh4bEliOXhz?=
 =?utf-8?B?YzRIN0U0NDBxYWFPMmJWaUNNcTlzWS83MGxjdDB5d3dOQVFzU3ZWeEdKVXNp?=
 =?utf-8?B?bEN0ejJPK3VLU0szN1dTQmZwelVyRHF0alVrNFovSXVta1RkTjY3b290MTN6?=
 =?utf-8?B?THNCazhYNk9vcHl5SW8xMVJQWDF2WVlaWTgrdjhwdEw2VHFYSU9sNGNkanU0?=
 =?utf-8?B?WVArVTBHNkxUdDBYVGNObXVUVEF6eHBPcjVNS01kQ1FBWldMWlVmZllkbDFC?=
 =?utf-8?B?MGtDbU5ib1J3aHNLakdzRXlKcWFqOEFzYmMzYk1FQktjMjRPWVV6K2RKUjZB?=
 =?utf-8?B?ZlYrMGVDdWEvV3F2WDJhK1NnT3p0NSsvbnI1MlZnZW1qdjY3YVIraDNmMmR0?=
 =?utf-8?B?UkxIWE1LWkV1VWc2dmY2L3F6U1BVbWNCa3JaWW4vVCt5N1Bwb2dVVUZiU1dy?=
 =?utf-8?B?S3VQOVFBeSt2dDA1RG83SERUdVdPdnd0c3ZWWldSUnpMV0xIdTVaVFI4SU9a?=
 =?utf-8?B?Z05MVmNKNVBucnhNUWRrdm1ONlMrdnEzcFk4WHFhMTBpYUcyMjA5Qm12MVZK?=
 =?utf-8?B?cVNqWEtEVXExR1FZdEIybjg4VWdFT05FSHdMN0o0T0I1ZTNub1RWcWZLSXdr?=
 =?utf-8?Q?Gp9bRuT+PpOyk2PZm0vZrrykh6Agi8n11040XJUlXfex?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E484B9B252D924BA53143F3340FACF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b94a91-f7be-41d0-5875-08da7c8a5534
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 17:44:40.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f90qE/DZzqzJvNAedh0W2iBOuKtNDMliOmZ6qmSwTM5ME1xag2Ht50iJf/f4Nf6fGAfLifBoC89y8yKWB9ww0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2515
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_104447_943107_F873BD90 
X-CRM114-Status: UNSURE (   9.62  )
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

T24gOC8xMS8yMiAyMDoxMiwgSmFja2llIExpdSB3cm90ZToNCj4gRnJvbTogSmFja2llIExpdSA8
bGl1eXVuMDFAa3lsaW5vcy5jbj4NCj4gDQo+IHJlcS0+Y3FlLT5yZXN1bHQudTE2IGhhcyBhbHJl
YWR5IGJlZW4gYXNzaWduZWQgaW4gdGhlIHByZXZpb3VzIGxpbmUsIG5vDQo+IG5lZWQgdG8gZG8g
aXQgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNraWUgTGl1IDxsaXV5dW4wMUBreWxp
bm9zLmNuPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

