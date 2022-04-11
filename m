Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBFFC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3+eQXBTxbus8YbpvchtqElj/8NonTTbijb+/XeBI+E=; b=R2XM0G4A8FwReOoTg66nIUI0th
	lXgIMr0XK2DZqwXPaLZgsRGOlHG4ZmDfjyurzJQc4O+w/vliR2u4hXPnYqh1m0UmvLvB89Ld1tKr2
	P3CKdGMPse2RkbEPDWn1AfZ1nyzqDe92EoBSUgdGi19Q0dmBMAYx/lfZEkbbro+F3Tbrma0ev5Krs
	jKb5PP1DNKajBEBVZsZlx2j00Ewz0Zx9MKl+HhEGCStIzZxHhmoT+fGZl9jRRuUfuoUVoOuoO2aC6
	PSIhmPVTZRnfJHWVs1w8O7c399+TjCaDqi5AZeZR+VTVCyC6+b6t1MY5/sBcgJnOCrXwiEFESm/HN
	DfwdwXLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndtZM-0093AE-O8; Mon, 11 Apr 2022 12:55:00 +0000
Received: from mail-bn8nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::627]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndtZ5-00931S-Hv
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 12:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/agjgnfhGevTLqA7dnCxomLofVBdnfBeHvePCosjM7NM3rnrTz4r4YmX7PdLmjala6JdQEgqEs95YyKmJ9IIan4jCeUZK+ceJyICV03zAB+mEBOkABeQ0HcElylhTz5KHvgRoXFpggTwDVHb7G2/Lz9Uyn/29WvROdxzPYjO9q4eFO94vYDvOg5OBHc8GKlpiymWFswwinl3j3EwlkXxoD4BMVUrK72Wimoxst8U6ndM4IA+b8EB1Csos42AMkmOmDt/i66lNB5EnYnQ5VSvgigXN7LwzI/fTxQ6u5MJ/ryy/jHv14ren753t16yzXWj2lcJmrr/pC/ElJ8xIa/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3+eQXBTxbus8YbpvchtqElj/8NonTTbijb+/XeBI+E=;
 b=mqM0G82qUkj/1mQsww4Co+S7puC6EbjVutIjpucSNjw2Kn3eJUIIkFaofDNShE/V3OpMMv28j0Svh4C0ZQJG61VjF/tXOeUUrIPoDWLqJEozRONO9/6ThtAewOIt04uV8kr08CeLvpG1ItE27CWKan4oFxTM36/3bpPqIo3QJTVUrb9g0cwk09YA/C38lhoiKZ40K6ljLc62cbd6NHH//slCTvne8nyevApmpKi1cHkAN0H67IhFxxPT6GypNq0u16ERodzMUmUDgSzk4w/52SHB+dbfXyq9VSYk1iRZjBYDtwifG/FjYJNwPEagqAZWa19lxerUQ7k2qTYqX8PX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3+eQXBTxbus8YbpvchtqElj/8NonTTbijb+/XeBI+E=;
 b=FvBnYXk3eadmHVYssZ7EH8npXug2LFM0SSbLOOX+3nZeqtrti+EwOLdVA9+5TSthywvB7IzAVbyUtFSZvB9m9mra9YzkjFU/Xzi5QQNogOqo55xrD6DIM6XGAjZucLDDMvHee36MF5thcyJWLAoX1BoXrdcMyogInuPNC5apRH+czE12J9YhV2mgVIDWQolynFBg4+Fk34QB5Cs6bYhFH0z3tjx0YQHJB/ae0GJ1TwL2kHDdbM3kua8KFZFl2XL7xI5ncGr4ysf46ZgFQrE+8lAF4Q0LpM0wIN20BtPI0NPbEPgKEUZFT0t6Og/cmgzYj20o899S9CDm0uCpHeoUaQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:40:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 12:40:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Topic: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Index: AQHYTVIa6YR5KcbjpkWDxqSgwxqmEKzqO8CAgABHEQCAAAY7AIAAFk4AgAAAvYCAAAfjAA==
Date: Mon, 11 Apr 2022 12:40:22 +0000
Message-ID: <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
 <20220411121209.GA21711@lst.de>
In-Reply-To: <20220411121209.GA21711@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea3731d-a293-44e2-e966-08da1bb87236
x-ms-traffictypediagnostic: MN2PR12MB3949:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3949345E76D8360926AD370DA3EA9@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9wh+Gu6uch15uTj2EY/2/R/isDLV5USOxd1aRBxNASTmcIe27Dt2OEPk7GQOQ/+nKqpO2xjvuIPOXY1vECTlB1/zS2O2Es2cBNlQG9CVfraA2ARgdIPSPG7JPtb38zuDKxTn6G8UJsRsgJcupqQE4cbhQ617vYbY53HjtL3vZyyV6pqd6G/uhLzANCf4YnukLqpYnR09KPJu2nCouZz5LYhEOTKkRU1AfnREj1lT5OXnQA64A6x+5bTga7n6DSwwrUqO7LDr6149WiBw9mW81e6AwurtYD1SmDgtAaQtyhDAAZ8Ezfmcsu7hD7jGwgBHyQ06FLrYqBpB+e5v8JotPmrCcP8km5bvHR0Dlpsakkw+5C33P/t93UQ0YMu69/i0qz8Q7BQH0eFB91bvcjVxGSzlLABEjLqaWS0dZyiM0Y/HyQ5TuUwd6ggLWasUcn9Rh6PdH/nJX0mSUCCEdhegTvgvulOCZKuoLJlN8Ds280wj+XYtsWwG/UhxzLmHdm/qUkLmCt8/nVdHLnstEeGKdQIoXYBUMsKppflz8coFEeqMN2vBh6aHyXolcT3ly9iAY9Lb/U/Mqa93kvkKBwGDXxJxbjkK/ox8PsMwb2uQWtRuknmQcDcs8iz53fOEzrb5/izHQ2ie7ZtWetGz6WFA5PIJcspciw/xv3SAqxPykmnZSGoxwiqoYFAvH/SuJQ7EcuHNAz3NCzlwhxPV1Mi/f396cD8nKCqIjbbd7t1WqAIa7NnlqVZZTd3UyNo23Kh+tEdRqUqX1QFuMBZGovVCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66446008)(64756008)(4326008)(8676002)(83380400001)(2906002)(66476007)(316002)(8936002)(186003)(53546011)(6512007)(6506007)(31686004)(508600001)(2616005)(71200400001)(31696002)(38100700002)(36756003)(38070700005)(86362001)(6486002)(6916009)(76116006)(5660300002)(54906003)(122000001)(91956017)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eklMTWJ5MXlIOTN4T2xhb2FLSHBkLzhjWExpT21rZlhDR0RTdzUrcllsR2ls?=
 =?utf-8?B?anZaMlpyRVpPMnlqRjd6b3BXVjFITnFLR1l2Y09STEQ2WS91M0R0RE5KUERE?=
 =?utf-8?B?b2VBSjFBOGdLZzRaSEp4MXMwdjIzYnFDN1hSTk1uMHhzd0VmK0Z0RHN6cE92?=
 =?utf-8?B?YkMwWG1yemg0bDd6YVhBVTVSOTE1YXhPMU1ManY3WE5ac0c4Rk9CaWpsMVpF?=
 =?utf-8?B?cVJnZE84bW5WODB5NnNRTEpIcDNRejR4OXZnakxZSURiNHZNQStFY1FWVXdy?=
 =?utf-8?B?aEUrQWZIZ3NOSkR4UjU0MEZQTzZaSTJtbkd3QWJISDVMUnloeHJ2eW1TS08y?=
 =?utf-8?B?Ujc3Zzc5NDgyR3pwWDd6Q1AweEg1OWRxYUlYN2xSMHRLVHdpTnpZeThQd1RD?=
 =?utf-8?B?QU5ldy9Nc0JwVWNuNXY0c0FZRlRPcllBemc3TGYxVDdydWxmVFR4NU9FM0pB?=
 =?utf-8?B?V292OEsxUE9RSm5TOUFyeHVscVhqSHRSWENMdFpIOFI5N1VqYktHSlgrZ3pD?=
 =?utf-8?B?ajA3VExrUlhrVjZNRWlyUHhYR3F6dTBjd2VNRDlGUVc3WDlMVlluMkN2YkRt?=
 =?utf-8?B?MjdWYzJTOWt0OHArT0crTUJFN0xIcW0zZGNwRzMzdEZBRVFCMk5NR0pnbE5x?=
 =?utf-8?B?N1dCSC9rYUpvOWtRUkUzYjNDbkdJS3Y4cHVhVzAzT2VuaHhpSTRucjc0Tm9X?=
 =?utf-8?B?dWVyUmdmbkRDUmtPMGpjMjhHSFZxNmFiNUFlT1RtM1czSzhaQlJMbDNHMlNi?=
 =?utf-8?B?Z3k2eGxML2ZZNHdVQWkwUzk3MlgyWmhYaVJNdXBFU3JqbWZESlZubGVGUWZZ?=
 =?utf-8?B?VGNDSERKT1ZCN20wZjlqeG5EUGNpTGZVd0NydDdzQm8vVFRQSmh2WWh6N0Ja?=
 =?utf-8?B?emlpOFpNT3dIRVpGaEVNOGIzMGV4Tk1QbUpIL3V1VDhUNHQreXhiWE9zZmRD?=
 =?utf-8?B?OFRJOWIyVzMrQkIwSEVlM0FhTmNBVUY1U1ZjOVBUYjAyM2tyYmc1eDl3d1Vv?=
 =?utf-8?B?VzhmQ2EzOG42RExzb0hFZVFKTXRlZWc3ZDZjd3BmYnJVaTZya3kvNEgyR2hG?=
 =?utf-8?B?YkRTSW5wdHNGZnFOQ2tLa2NWdG9UNXFnNFRKVHc1R2tKTDlXaGpqdFdvRGhK?=
 =?utf-8?B?c3p0UWk1Z1FnZHdNTDVSQXM3LzdHb3BsV21LNnR5NkhVSERLNFBGWVVRVGgz?=
 =?utf-8?B?dWs5VXQ0L2dZckF5N3d4SnowN2g1d29QdHpTYXdaQUhsOWFpZGN0Z1ZiUmZS?=
 =?utf-8?B?WjJ5b09aSWdWcXBSS1pOTHMxMWovTVlUUElYZmU0emtHdUROUGdKWXhBTW1B?=
 =?utf-8?B?N3pjTER4MitreHJJMmUxU3JNWmlNOXgrdE54eFNpUmN5dmw3NFM5YjVVMWwx?=
 =?utf-8?B?RWluM2UyVWVQM0FIQy9Qb3Z5OXRVUitYNGtPRkM0NUFqQ2Fud1Qzdjg5aTBq?=
 =?utf-8?B?NlYyMWlZVTBwa2xhbmJwam0vS2dMMkxhM2htWXpOTk5GL3Nqb1FuVi9ZQ1Iw?=
 =?utf-8?B?QVYzK2VodGhMRlMwUjBNd0tTMytWWmljVUlYZVBoaDBxQlJHV2R1NkpFVDlF?=
 =?utf-8?B?RnRoUHV2b0p2Q013N3BhWGJkMkVQZzlpUUVIdzJoTEg0VnEvVmF3U0FuVUJj?=
 =?utf-8?B?ck95cnM3QXU3RGZrT2llTnJjZmEyZHhhdVU1a2V4TVBvOFcvL1ZLYmRvV3U3?=
 =?utf-8?B?a3lzdWdWMTQwWTZrc0xIWGNDTEh2NDBoNnF3OTRCNVowMFR3R0VGV25WTFlC?=
 =?utf-8?B?ODdJamJiQU1TOWtqMHBTd3AyeTlUOUd5ZlM2ZXFIdXJkT1RMWWtSYVJyWlVj?=
 =?utf-8?B?aVhzSkJoOHJ6ZHdBMlVrdDVHcnE5SERSWm9pTmlCZiswUjRrM25zWFFjc2lM?=
 =?utf-8?B?cldTa1QwNjJFTFl0aURpOTJwSXF1TFdYU3V3K2IxZE5lVlByMUxhTzBJYVlm?=
 =?utf-8?B?bUF6dnRyLzNVcFp3cGwreVVrWDZFNDdBRlNnYVZqSThweFpOV2Z3YWdWVHYr?=
 =?utf-8?B?bzZZM1p3ak1rak00d3d3VVA2YjZ5b3I4M1U3Mms2QWsyVUdaWmhHUkRYSlZt?=
 =?utf-8?B?RFA4dnFhclgvV3Q0ai9JbldzRjZKWXpnYkJQcHFMdHJWQkFTdkFERHZ4bExx?=
 =?utf-8?B?ck5PaENOZ1MyamVoRFVwOXlTeVJTUVptcW9ja29OakcrWkhoZ0tuZDBxOHdI?=
 =?utf-8?B?bWdxRFlOM0tsbmlpcVYveEdEU2FxcWZ3Zi9xZzZvUkM3bXNNbUYvcDhiZGx0?=
 =?utf-8?B?MGt0NTdxclFIa2NYbmZZRVhzYnFTTExWN05pNVNacm5sSG5PZVY2aVpybnFl?=
 =?utf-8?B?LzNJRWpkd1g4dXZOQVRzc0pwSHVrRGk4NVVhVVZHQktic1FBREFqNm9kQk1l?=
 =?utf-8?Q?S1PjvKIL100ll26+3QMAWPaE0GpvmIFE88nk4sxh9kWTM?=
x-ms-exchange-antispam-messagedata-1: sy6QLE/p4/tJ/A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E52AB96CDBD71A4082ED00932B6D659B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3731d-a293-44e2-e966-08da1bb87236
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 12:40:22.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYqO+JMDoiqtGqrIFMKfvOGVxyJu/P1Hb2NTo35gLAXUPld7+MHjWaKbDyEwmDLO/jkFvXRV8a87tAXD2zAV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_055443_640974_AD349FCA 
X-CRM114-Status: GOOD (  23.15  )
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

T24gNC8xMS8yMiAwNToxMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwgQXBy
IDExLCAyMDIyIGF0IDEyOjA5OjMxUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IC0JcmV0ID0gbnZtZV9pbml0X25vbl9tZHRzX2xpbWl0cyhjdHJsKTsNCj4+IC0JaWYgKHJl
dCA8IDApDQo+PiAtCQlyZXR1cm4gcmV0Ow0KPj4gKwlpZiAoY3RybC0+Y250cmx0eXBlID09IE5W
TUVfQ1RSTF9JTykgew0KPj4gKwkJcmV0ID0gbnZtZV9pbml0X25vbl9tZHRzX2xpbWl0cyhjdHJs
KTsNCj4+ICsJCWlmIChyZXQgPCAwKQ0KPj4gKwkJCXJldHVybiByZXQ7DQo+PiArCX0NCj4gDQo+
IFRoaXMgbG9va3MgYmV0dGVyLCBidXQgSSBkb24ndCB0aGluayBpdCB3aWxsIGFjdHVhbGx5IHdv
cmsgYXMtaXMuDQo+IFRoZSBDTlRSTFRZUEUgZmllbGQgaXMgbmV2ZXIgdGhhbiBkaXNjb3ZyeSBj
b250cm9sbGVycy4gIFdlDQo+IHNwZWNpYWwgY2FzZSB0aGVtIGluIG52bWVfaW5pdF9zdWJzeXN0
ZW0sIHdoaWNoIHNob3VsZCBtb3ZlIHRvDQo+IG52bWVfaW5pdF9pZGVudGlmeSBpbnN0ZWFkIHNv
IHRoYXQgY3RybC0+Y250cmx0eXBlIGlzIGFsd2F5cyB2YWxpZA0KPiBhZnRlciB0aGF0Lg0KPiAN
Cg0KaG1tbSBJIHRoaW5rIGxldCdzIGtlZXAgaXQgc2ltcGxlIHdpdGggZm9sbG93aW5nIHRhZ3Nl
dCBjaGVjayB0aGFuIA0KYWRkaW5nIG1vcmUgY29kZSB0byBtYWtlIHN1cmUgY3RybC0+Y250cmx0
eXBlIGlzIHZhbGlkOi0NCg0KDQpudm1lIChudm1lLTUuMTgpICMgY2F0IA0KMDAwMS1udm1lLWNv
cmUtY2hlY2stbm9uLW1kdHMtb25seS1mb3ItSS1PLWN0cmwucGF0Y2gNCiBGcm9tIGVlODQzOTQ4
N2E4OGIwOGU1YWJiNmM2NTU4Y2E2YTkwMmEwZTZiMWQgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
DQpGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KRGF0ZTogRnJpLCA4
IEFwciAyMDIyIDE1OjUwOjEwIC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0hdIG52bWUtY29yZTogY2hl
Y2sgbm9uLW1kdHMgb25seSBmb3IgSS9PIGN0cmwNCg0KVmFsaWRhdGUgY3RybCBpcyBhbiBJL08g
Y3RybCBiZWZvcmUgY2hlY2tpbmcgdGhlIG5vbiBtZHRzIGxpbWl0cyBieQ0KY2hlY2tpbmcgdGhl
IGN0cmwtPnRhZ3NldCBtZW1iZXIsIGFzIGN0cmwtPnRhZ3NldCBvbmx5IGFsbG9jYXRlZCBmb3IN
CnRoZSBJL08gcXVldWVzIGZvciB0aGUgY29udHJvbGxlciBmcm9tIDotDQoNCjEuIG52bWVfZmNf
Y3JlYXRlX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9mY19jdHJsICpjdHJsKQ0KMi4gbnZtZV9yZG1h
X2NvbmZpZ3VyZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLCBib29sIG5l
dykNCjMuIG52bWVfdGNwX2NvbmZpZ3VyZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgYm9vbCBuZXcpDQo0LiBudm1lX2xvb3BfY3JlYXRlX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9s
b29wX2N0cmwgKmN0cmwpDQo1LiBudm1lX2Rldl9hZGQoKQ0KDQp0aGlzIGFsc28gbWFza3MgdGhl
IGZvbGxvd2luZyB3YXJuaW5nIHJlcG9ydGVkIGJ5IHRoZSBudm1lX2xvZ19lcnJvcigpDQp3aGVu
IHJ1bm5pbmcgYmxrdGVzdCBudm1lLzAwMjogLQ0KDQpbIDIwMDUuMTU1OTQ2XSBydW4gYmxrdGVz
dHMgbnZtZS8wMDIgYXQgMjAyMi0wNC0wOSAxNjo1Nzo0Nw0KWyAyMDA1LjE5MjIyM10gbG9vcDog
bW9kdWxlIGxvYWRlZA0KWyAyMDA1LjE5NjQyOV0gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vi
c3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS0wDQpbIDIwMDUuMjAwMzM0XSBudm1ldDogYWRkaW5n
IG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTENCg0KPC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLVNOSVAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Pg0KDQpbIDIwMDguOTU4MTA4XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxr
dGVzdHMtc3Vic3lzdGVtLTk5Nw0KWyAyMDA4Ljk2MjA4Ml0gbnZtZXQ6IGFkZGluZyBuc2lkIDEg
dG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS05OTgNClsgMjAwOC45NjYxMDJdIG52bWV0
OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tOTk5DQpbIDIw
MDguOTczMTMyXSBudm1ldDogY3JlYXRpbmcgZGlzY292ZXJ5IGNvbnRyb2xsZXIgMSBmb3Igc3Vi
c3lzdGVtIA0KbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IGZvciBOUU4gdGVz
dGhvc3RucW4uDQoqWyAyMDA4Ljk3MzE5Nl0gbnZtZTE6IElkZW50aWZ5KDB4NiksIEludmFsaWQg
RmllbGQgaW4gQ29tbWFuZCAoc2N0IDB4MCANCi8gc2MgMHgyKSBNT1JFIEROUioNClsgMjAwOC45
NzQ1OTVdIG52bWUgbnZtZTE6IG5ldyBjdHJsOiAibnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3Mu
ZGlzY292ZXJ5Ig0KWyAyMDA5LjEwMzI0OF0gbnZtZSBudm1lMTogUmVtb3ZpbmcgY3RybDogTlFO
IA0KIm5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzLmRpc2NvdmVyeSINCg0KU2lnbmVkLW9mZi1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCi0tLQ0KICBkcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgfCA5ICsrKysrKy0tLQ0KICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQppbmRleCBlOGQ2YTFlNTIwODMuLjJl
NTc3OWQyMzNmMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQpAQCAtMzEwMSw5ICszMTAxLDEyIEBAIGludCBudm1l
X2luaXRfY3RybF9maW5pc2goc3RydWN0IG52bWVfY3RybCAqY3RybCkNCiAgCWlmIChyZXQpDQog
IAkJcmV0dXJuIHJldDsNCg0KLQlyZXQgPSBudm1lX2luaXRfbm9uX21kdHNfbGltaXRzKGN0cmwp
Ow0KLQlpZiAocmV0IDwgMCkNCi0JCXJldHVybiByZXQ7DQorCS8qIG9ubHkgY2hlY2sgbm9uIG1k
dHMgZm9yIHRoZSBJL08gY29udHJvbGxlciAqLw0KKwlpZiAoY3RybC0+dGFnc2V0KSB7DQorCQly
ZXQgPSBudm1lX2luaXRfbm9uX21kdHNfbGltaXRzKGN0cmwpOw0KKwkJaWYgKHJldCA8IDApDQor
CQkJcmV0dXJuIHJldDsNCisJfQ0KDQogIAlyZXQgPSBudm1lX2NvbmZpZ3VyZV9hcHN0KGN0cmwp
Ow0KICAJaWYgKHJldCA8IDApDQotLSANCjIuMjkuMA0KDQotY2sNCg0KDQo=

