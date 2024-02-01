Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97FC4828D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6JHvKAciZtrX/7z5HV3JnQDGxJrjSHeF2Yk2Qt49YO4=; b=tjro5Cz1++wH4Y4GAs1tzkcmjo
	QNkGXytMM6Qn7GXxtcimssnTASdV54fWF8k+bdonN7Z81lFD3JoSxG0fj5aU7wOCEJCndUXNQmu4P
	jEiXzP2mEncCh04bqBWiEisExlHJT9aRe4EQHdSK520gsB4+XbFSNNKndTyJ5jYz0nt11D8Me8qal
	u1JZWSDJFoA5hKlQ3HgtGbSiYAXVMrJhXNfuVRsv3k377YYjfyi7dNUqTkJe46GSxPSObLGYGU3cy
	XjI7AY8uzUsHxIK5/7265kvmSPQgxibJfN4UYO9KJz+m/dEl/SoipTBYzIWU0LN7q5ZCZTJ6WQMeu
	OHvuI36A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVbci-00000008z3O-0rzL;
	Thu, 01 Feb 2024 18:17:16 +0000
Received: from mail-dm6nam10on20627.outbound.protection.outlook.com ([2a01:111:f400:7e88::627] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVbcg-00000008z2i-0TXp
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 18:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAr8k+Dc6FThPIvm4QdzZv2pBJ5U0oB+HNyE5Zb5vLFR//VamYYdUbhnyYgjqTpJT65/Go8xb8DWEIymIoPwADHR6X6fQKJ2h+06PlI3XeukBcygqWhC52MhPhZru28c2qlgngjuRCNnvcs6mQNzwlkMPb6tQCe3v+5OGAT8b4zdmeRSz20ygGH9ZyljKfiIybBSG5AZFl0Oef+cM4g9Qqu1um69DAqzBMoEMEJSPnq7Yes/cIGwAQ9V+LmttHvtQ6YfimG11d2fl8SffIQOgj02gG+BmfjmdcjRIVN1XFpSI97qvrsdSaQ1Mi/CIbgqTDik9uUWDr9UVjK7B8gupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JHvKAciZtrX/7z5HV3JnQDGxJrjSHeF2Yk2Qt49YO4=;
 b=fr28I+wCgjty3A/wr1PEPnHZhUM7KLTETsaFpWxfPdQN6hrxUrhTj0Diy3ffnDuYg2HZqRIIy1xDpxBWxfr2Wr7ki7cS/o8wTmdHRjigysoT2rFvSgxyDzyXNpmVFLkv2PBnGHEPNzLycRobnE6LT07Q+EbZdN+EkkwyRXvy0TQVUwJdemQdyitNql02Wg5L85NWanW3z5KMo3YiVeJWCD1ourefKDb6F5c/dxXYdwLy8Q2abWZiO6YBhO8TFyI/ISydm6BZ0V/4zslQpdp6RhzVlnqs1OeL5dRn9vKzIESPl8QXZBxFXJbUEVreDAEK0WdHvDyKe2CcHGZnLMpq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JHvKAciZtrX/7z5HV3JnQDGxJrjSHeF2Yk2Qt49YO4=;
 b=fEM8pmK/q/M+sa862H1s0Pkv6RPn8H5SHvJ8QcF9uyq3r7A3brw8snX3Ua9U74NCV9M8+isRCytE/XYbViiIIzHHwN1Z2VFN4De56xV/hsjaqKeIReTJAnwFMoPu6oFhWoUHWzOLNiY8on2GoIKR1IvqCMUCf55ZTYEuR6ObW4P3j26m9ks4Nt57UpzyPUDvIoSXVHpKgH55NbEI/8BUTZv1eyZecGAndqvS7I8594zFgxRcmGJ+hzWbOROuMRQvxNi6hAY/rIEv0wArB2fNNrd4IN346z2CyYoXggOmNQAGV6+JpbqqQES9Z3HvjhA/JA/Fj0s3tH0A++CbCT2AfQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 18:17:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 18:17:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
CC: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command option
 from -o to --opcode
Thread-Topic: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Thread-Index: AQHaUB56uY8Rnm69G0qKlLC7merclbD0BOIAgAGfKACAADFsgA==
Date: Thu, 1 Feb 2024 18:17:01 +0000
Message-ID: <232e910f-ea57-4532-a24f-9c461507146b@nvidia.com>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
 <rbpa7bx5rfhnlhnrzucz5hi5szflkvihdtdmuksuccekwy53qf@nbotapgudm6r>
 <Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM3PR12MB9390:EE_
x-ms-office365-filtering-correlation-id: 7c8ab870-34b3-480f-3734-08dc2351fc80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgdkPjiHWMkZj/9ADZQyhPH0ahdI3T0HwV/e8Bn2p7dzsskODRkaGUHK8ZX2b9xxjdkLbpP55Vv2Z5p2qwpof+HlXHWYGK8LFbUlT0wbKBO5FO57fKgWg/gD9BwgJXGVDH0r0rJhxQ1yYMIEka81eImFFdX8bJqXRUT79w4s1wXxo6W0CPQikuMe1C9StuNyjnPiwIrHmxeR8/xvOtjCPlGmFkWD+vqw3fb6O9BROSVgPlvYc5fL5NFhd/gKZUonEzVIzTjU/22bek2HTTMTVNe2v/z5l2b8RoK/PNJWottReLyJMes/EaVODWKOjPxq911kO0daFSivSp39ckjENRH9U4st1raXHZR6Hs/3pAbcnOWJ8duC5E8PN4BwxNhsi/pbeh182ODdqESWxfsR4azc1FBunABChjyje8u/HGVfZy7+Fv14KgFDhAcdIMfuQVmTIfQcXUYXAD4tsSGS02/WQYh3grGvTiIhdGDa+LejFOoMR88ryrahK1WPtUjNztZqaISv2c6615NpmABudaY7Fh8VNmbvckgi4w5Sh/uztsZZWeDw5C3LjMV99gbzD90TFpGJSXIcPXd+DDf+9ewb1v2+rextO1FcQkVjgsV7ukXKIbmNM6fEHcSwqtdcQB5ZwJ32oFLJtMLROKsxMlVCuKZU/uppIC4dQLhG7+ahznAAOEFSjyahI9Z5bQ4h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(38070700009)(53546011)(2616005)(83380400001)(36756003)(6512007)(71200400001)(6506007)(122000001)(31696002)(86362001)(38100700002)(41300700001)(478600001)(4326008)(8936002)(8676002)(31686004)(5660300002)(110136005)(91956017)(76116006)(2906002)(66446008)(316002)(66556008)(66946007)(66476007)(64756008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JWRWp3OGIybHJLOHo0RFVDRmRzenFEUWkyZzIzTmVvU0pWZlB5d3lqQ3dS?=
 =?utf-8?B?Ty9HS2NyNDRjdFJ4Uk1HZmo0QlZqcitxWWxiSU1rMkJYVW54ZnRnMm56am5I?=
 =?utf-8?B?V2JxTUJISzMvc0MrQWlUL3k4OFBPMENKU1BBaTRaWENyRW93cXo5ZjVnN3dw?=
 =?utf-8?B?cTQwelNvS3QrSUtKUXI5Z3dibklwNEIyOCs2N0xTY1BOc1gzY1AxMnpCSUtn?=
 =?utf-8?B?VkJybEQxTXNidWpnS0ZFb3U2MDFOaGV6bStYSlZweFMxVXpiS05qZ3lROGRs?=
 =?utf-8?B?a0dPdEFFNCtHK2g0dnhLcEYxdFdWaEFCa3ROdXkwOE1ubFpKRk9xQ2lyZDMw?=
 =?utf-8?B?RHlDdHZ2V0NMa3dENGUvWHVwWTVvWnhVZ25kdC9BaEMyM3Y5ZVBrbkZoZ3NX?=
 =?utf-8?B?bDNGTk5aV25vTDJYTi9Pc1BtZ3IyZUR0MmJyUm5ubFNvMmF5VzV4bk02NlJB?=
 =?utf-8?B?V1RTZ3IvclcvMWJoOU9Vc3B4czQwd2duNzRUMnc0VjRMNE5malc5ZlpCWHJT?=
 =?utf-8?B?Mk4yU0hjai9HVlRuT1ZUNUxiekxQMlY0ZHdzNzNSTXlTcldHRjNsS0tIcE5u?=
 =?utf-8?B?dUtFbWVlUkYrdGlBaUpUWTdIWTJ5ZUh1YlY4K3F2STNHaHBNdC9Mc0pjK28v?=
 =?utf-8?B?WWxWdUdhSlF6NGUxakd6YjRyTTc2cnJNNmNmTGV6Zlk1TGl1cU5wNkNqS1pl?=
 =?utf-8?B?N3JxemZ6bThxNGZoZ1FLRDkzMy9VbGVpd2toQWVUU1orOU5PcHJpaGJ6aG1i?=
 =?utf-8?B?d0p0YmV2T2Qzdkpld0IraSsrZDY5TzVlM3VzeWNORld1RGpSZmY0bXorVWFu?=
 =?utf-8?B?TTBiOURJVGNCMzVXR3ByQWluNUppSk1VdzFZSk1qMlNueUFhOFl6T0NKQXdw?=
 =?utf-8?B?L3Vmd3hiekpGTEpNbTR4d3VPNjZOYUw3TUFYcVlvY2t5MHVWV01MTFEzRVcz?=
 =?utf-8?B?djRRZFloWWQyV3R2UW9KanZ6NmVMdnNaU3BnbWd1RW1xbU5yU0IvSkZYeG42?=
 =?utf-8?B?ZUZNRzU2QkxqSjBEdVZLeFgzT2xTV2N4REpBQlJZZ3NXNjRYWWNjMVNqR2M1?=
 =?utf-8?B?TlN2NXVxTUZFeGovQ3FpZE9rWGZ1UDJQYzQzbEdDdzNhRHhoUlBpbWFmWHJr?=
 =?utf-8?B?ZEd3MzM4aTZwNU9mekphbUU4YVh0VzV0c094WWMxSkNDR0hkSW5NWWJoeWh5?=
 =?utf-8?B?ZkxqS1dHR2R2QUUxT0tQcnNMZEJSWmxISjBUNGNPR0hMZHF3anBlVTVmZVl1?=
 =?utf-8?B?YWtyeTJZWGE1TXNRWUFPeDZrOW55MjlMTnJNR2dYTjQ2MWRwdDVWd3dMa2tR?=
 =?utf-8?B?eWpwenNOUlBMZmNZVW81WXpRMGJNT3k2TGlQM1d2YzcxbjBWNDBISGRULzBn?=
 =?utf-8?B?OGhFNkVhVUVmazZhZDBmQ1p6MGhGMFlOekRyeVEwWmMwMGFlUDNGaEwzY1Vo?=
 =?utf-8?B?Y1VsdEFtRlZScy8raS9yajVsOUUzcG1jRjJaUllka0luZFlJYXBWMjBOUmU4?=
 =?utf-8?B?dUtqblRwM3N4aDBCRlo0Tlhpei9PUXozWXl1dUU4L0M5TVhlNlZoY2VQamVu?=
 =?utf-8?B?aUJmNXNjRUZKclpOWXBmRjM4VnM4ZUFpeDNPUG51c1NRN2NqOGFsRDJTWldB?=
 =?utf-8?B?UVgwUndkR2swZGpibFpoT1ZlTUVhNUhYaVR5Q0htOE9TOVZYMWhlNG5TMFdS?=
 =?utf-8?B?L0xmbnUydXZ3UWgweUh1ZnQ0bmlaYTZBTG1VWkduTGVUQVRub1dZMGZwcVdo?=
 =?utf-8?B?TzFaZ3ZmV09NcnNlL0YrUmlpTFVDWUx0SDVjNGtiS1VKblptamJFQ2Z1K0xi?=
 =?utf-8?B?K2JWdXNwMjZVT2t2R3llOUg3Z1VNU2RaeUhVeVZyaWZxYVhleEw2UjJvajdI?=
 =?utf-8?B?U3ZKcWtJQjJIYzZZNFcvMGNFSThiWk9DMk5qOVNjWjMyMEE3bkRFY1UyUTVZ?=
 =?utf-8?B?VmdmOVJLa3EzRGtGWEdJK1lMM25rdWdvREZOdlhXS1VWdUVpUWdDZ1Nwb09w?=
 =?utf-8?B?cjAxS2RPL29zcmE0SzRMN2NCTUFjcTBvSDhlMitrRzJ1bUFENHpiRTZ6SlNa?=
 =?utf-8?B?dHRNaHVEeG5yQUlJVVJSVVh3eVg0ejJocndmRzlCaXpXY0d6dngzN25tdUJk?=
 =?utf-8?B?bTg4eE9DS3NtZlRMcGdzSmw1WWRjQ1FQdnVOVGN1REFFbjlkSkhUWGVSNGkw?=
 =?utf-8?Q?Hgm+zbI78iNaxgCmWa69+zIG0ElgZeVHnk7mWhXjPqOt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEFAD5CF1EDBA745B5B404413299B940@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8ab870-34b3-480f-3734-08dc2351fc80
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 18:17:01.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj3D6S4MPYBiCVuTkLYXPG1sJAvl9eHPQjkFpshK7v3dwBklP3Bxo24CCW9O/YLrBK/rdMZarMBVgILx1hU7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_101714_186767_972213AB 
X-CRM114-Status: GOOD (  18.05  )
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

T24gMi8xLzI0IDA3OjIwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gV2VkLCBKYW4gMzEsIDIw
MjQgYXQgMDM6MzQ6MTRQTSArMDEwMCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4+IE9uIEZyaSwg
SmFuIDI2LCAyMDI0IGF0IDAzOjEwOjM3UE0gKzA5MDAsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdy
b3RlOg0KPj4+IEEgcmVjZW50IGNvbW1pdCBpbiBudm1lLWNsaSB2Mi42IGNoYW5nZWQgdGhlIHNp
bmdsZSBsZXR0ZXIgb2YgdGhlDQo+Pj4gLS1vcGNvZGUgb3B0aW9uIGZyb20gLW8gdG8gLU8uIFRo
aXMgY2F1c2VkIHRoZSBmYWlsdXJlIG9mIG52bWUvMDQ2LiBUbw0KPj4+IG1ha2UgdGhlIHRlc3Qg
Y2FzZSB3b3JrIHJlZ2FyZGxlc3Mgb2YgdGhlIG52bWUtY2xpIHZlcnNpb24sIHJlcGxhY2UgLW8N
Cj4+PiB3aXRoIC0tb3Bjb2RlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8g
S2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4+IFNvcnJ5IGFib3V0IHRo
aXMuIFdlIGludHJvZHVjZWQgYSBjb3VwbGUgb2YgZ2xvYmFsIGZsYWdzLCAtdiAodmVyYm9zZSkN
Cj4+IGFuZCAtbyAob3V0cHV0KSBhbmQgdGhpcyBjaGFuZ2VkIGEgYnVuY2ggY29tbWFuZHMuIFRo
aXMgd2FzIGRvbmUgaW4gdGhlDQo+PiBxdWVzdCB0byBhZGQgSlNPTiBvdXRwdXQgZm9ybWF0IHN1
cHBvcnQgYWRkIHRvIGFsbCBjb21tYW5kcy4NCj4+DQo+PiBJIHdpbGwgcmVmcmFpbiBmcm9tIGRv
aW5nIG1vcmUgbGlrZSB0aGlzIGZvciB0aGUgMi54IGN5Y2xlLg0KPiBDaGFuZ2luZyBpbnRwdXQv
b3V0cHV0IGlzIGFsd2F5cyBnb2luZyB0byB0cmlwIHNvbWVvbmUgdXAuIE1haW50YWluaW5nDQo+
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgdnMuIGltcHJvdmluZyB0aGUgZGVzaWduIGlzIGEgY2hh
bGxlbmdlLg0KPg0KPiBJTU8sIHRob3VnaCwgc2NyaXB0cyBzaG91bGQgYWx3YXlzIHVzZSB0aGUg
bG9uZyBvcHRpb25zLiBUaGUgc2hvcnQNCj4gb3B0aW9ucyBhcmUgY29udmVuaWVudCBmb3IgaGFj
a2luZyBhd2F5IGF0IGEgdGVybWluYWwsIGJ1dCB0aGV5J3JlIG5vdA0KPiByZWFkaWx5IHJlYWRh
YmxlLiBUaGUgbG9uZyBvcHRpb25zIGFyZSBtb3JlIGRlc2NyaXB0aXZlIGZvciB3aGVuIHlvdQ0K
PiBoYXZlIHRvIG1haW50YWluIHRoZSBzY3JpcHQgaW4gdGhlIGZ1dHVyZS4NCj4NCg0KSSdsbCBr
ZWVwIGluIG1pbmQgd2hpbGUgcmV2aWV3aW5nIHBhdGNoZXMsIGxldCdzIG1ha2UgdGhlIHBvbGlj
eSB0byB1c2UNCnRoZSBsb25nIG9wdGlvbnMgZm9yIGJsa3Rlc3RzIGF0IGxlYXN0Lg0KDQpEYW5p
ZWwsIGlzIGl0IHBvc3NpYmxlIHRvIHVwZGF0ZSBudm1lIG1haWxpbmcgbGlzdCB3aGVuIHlvdSBy
ZWxlYXNlIG5ldyANCnZlcnNpb24NCm9mIG52bWUtY2xpL2xpYm52bWUgc28gc29tZW9uZSBjYW4g
cnVuIHRoZSBibGt0ZXN0cyBhbmQgbWFrZSBzdXJlIHRoaW5ncw0KYXJlIHN0YWJsZSA/DQoNCi1j
aw0KDQoNCg==

