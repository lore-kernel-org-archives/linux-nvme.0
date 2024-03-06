Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094BAC54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 05:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cglqgi9e6pXSrtlNZzDlfRSmgvmhHxkv+oaeaQxYtu8=; b=QxRAeorNkQccljHjrbk90FsRJx
	Q/94KnU8rW6WuVKSP9dRinORDQ5AhcsmPN2Ho5kInlrdTuxI0g6QnAx8cL3MmhiFKLzMPzL5603SE
	TPPL2XgcU0ILSq7qYXj0JwXseGf1STVu5/Pu1TiaTndLG11NXBzVoVec8odOZxEc/66zqsDybGcML
	C/r3ZW0Dn9gLZDxbX89Kz3dK3TKGpOfAFElmh3SK2zdvc6G2nbn7zTpPghsAHf75J9DM/RklbiP8V
	Ow6H8zS3+UKQah/FFXap6j0NAenLJd0A8mUzHGxFwjY6Rbg1Tzs0yUl3jp9x0FUa8AvHeLerbFV5d
	lLb8kUzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjtD-0000000GPQd-1lrC;
	Wed, 06 Mar 2024 05:32:27 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjt7-0000000GPMh-21Xm
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 05:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9JLOFR+cyRhle2az+g+mzD99w3Z6b7Cog+untbT6ikbCjcnGGvrH/17RM7/9IFHsT3BI/I2mqAlYBBCaJAezRqYRIU5lp3e6TQLJsCh71KM5vFi0IrhG3WPiNBWSNMTJ8C2wZtiuMg4B81Kquhh6yPQkAAG2+N3bJzANG2taFY/Bqc4ScAct0bOypblFOpxgTQ4kw/JIrHCHgPk63tgbTm3ImYqQVYL0tTAxDddtth2lKkIrUxgQcYKbBw1ILW9G0RJ39rDVjSRvc5UkQgJA224rRr1kYA01QJ6duAP70zgYTc9+gfcoioZG3SiZCHyVS1Ztn+DN7ruBt+Vcvxssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cglqgi9e6pXSrtlNZzDlfRSmgvmhHxkv+oaeaQxYtu8=;
 b=GK9ts+39pp9ibbfmDoyDxCqVQoSbfFxs+3KMazZjWa9aBUWMfsuAAYT7vj/B2hq0dSV3Va1B0C5k2CXBdzLrgcJbtfgIu9vEeR67UmzT2Ml9ioTB+ZNQupJWfbb0m/jhLu3ICE/IBtnM30iiRB0uu73e+b8O+M3FZK6oB73kVWNOjHUzZYjO6jf1D6NyZctlxrUf1ck6MF7/fL5r7EhyHVdvwqGgPn/7qVUAXIv1BgmQUMzE1BsWRaHC5naTVNi8HvdKITclCASqhrBbxDWlOAIRFCzG7FdmWO/z5vOhc26ojTFLzeRy86GSv0M3mVjKbeOFYa8PONGLm7aQsNepSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cglqgi9e6pXSrtlNZzDlfRSmgvmhHxkv+oaeaQxYtu8=;
 b=a8f2F8kirtL+G38IAnZsoizwuzHMFZhxC4y2WspTtPxAdTqHQnhjEWD5LKjERgVFO+KAPrQGWqHy+CT83Woi8irjbvcg5uqGEmuiAStKwgnmuE2rR8lI5xqK807HomQV7Yte4RlALZi5ZLS4EUnAQV1vG+fhYXDVff0sOE1lh3lrBfwY2njAgVtTS/slsezfBZbN0nBnaU4EYEHIchlT+SIPIBzsmZ1CaJfzxXwAU8riTZ4zi80m6xNhLAlGlNnuNa90GR6JLZ4hNMGnPV1YYfNlkk13BznpX1WTRRLqou1vyJP3tsw5OW/xn8WQZ3xLNshgkxfU9e8iN2aPLxrPMw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 05:32:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:32:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Topic: [PATCH] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Index: AQHab4IJVkovDmgd+0aNOO4/prUIm7EqMEeA
Date: Wed, 6 Mar 2024 05:32:15 +0000
Message-ID: <32483687-bde7-4c55-bedc-1bd292138d20@nvidia.com>
References: <20240306045120.2605223-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240306045120.2605223-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6209:EE_
x-ms-office365-filtering-correlation-id: 395803db-e5fe-4eee-edd0-08dc3d9ec89e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /083AZJUr6NPo4mmKfnZyvhWua2aZTGkidsWUG2Nf6s8Dk42/GAWaSYMOicyBFZlXijdQYv6Jgx0p/cVdkvpKX7QMe4Cz3JaMdGWj7c5zK6Hh4acmOZxjX7BEpHSCaWpCQdByp5aWXjvx5rIow3dVw1D0lJBdc2D8XavdOSeVaNHhW5xqvsRc2s6IfZdrAIXuEfSq1xJORKtQJNurETvEvgZOSn9vGYlzm1MekCWIeDcFjBmWVEZh5K4kLIRNcOFLc3KCa0Ic/M+hgjwEdJvIV2s23Ok7uNIfm/V/cBOCN00WfHAzu4+BMX1kzajgHsHUkUF57bDVJt4yMqlgTD++Bm5Ds57hI4Za9VnTbgd3Vr9c1xHw6Ze3ySDoGIOelMUUJ5RvdbO94WkHcGPY3K7CtQ0p7p5jGxChm41nsNpChihPqhXJZVpoCm3szvgFkwRbMuzceHOcRLULbY7FLsr+aXtAi/syWfU0Sb7foMQKoGr44XoM17XKuAMJTU/2MGBjbK4KHVY6KRjTzzFDCqheVxdog2ZCvSId5+I8vSDZViisl11Y4krKXltMDt/ZgmlbJnufIZzomOUrYfCtQVLvtJsoU4svgXVVfknOHuyKZQeVOQ/sLElVhcDeP68RNbqMm24gzcjYrvLcJ8hMsIyaFTOGuwbl/TgFp5yr3+tUoHhUNSNjBZIoq/C1Hhc6nHsOKuNnWyfub/tsNcnrjZ0mZW68aOxciGr8NKXsowjnXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFZMUU9Ka0tnWCs4d1hna3ZUUzUzK01HUG4zUmxseHY5LytoblpMRk9IVzk4?=
 =?utf-8?B?ajUvenZGQ2ZUMmtlalR3ZW1xTnZJL0ZTZXFxTHNvMVMyaHUvLzhUSGgvRHMx?=
 =?utf-8?B?S2VxalN0RnRJU0VFUjJUVmxkczBpemI5YW9vSkpyYURiZ2M3elVzbTBYY3Ev?=
 =?utf-8?B?SFlYMU05dEp1MlVWODF1czdMOTd5QkhTM1VQTU1IRU5lZFBXeHBnQW16aHUy?=
 =?utf-8?B?OGNpN054S0NmRTdjVS83NjBmSG9BT2lKeS9KUUxyUFl6bzBubUJ2OFA1KzhZ?=
 =?utf-8?B?NWFNdE9kSjhpci9wUnVkQ0UyMVgwdjJvTHhBUW5tNGNYVzZzYk5wZm9xZVR3?=
 =?utf-8?B?R0hLL3YyeDNaMmJZRXJOTDk4ZktEbCtUbC8vNEMzcDhoM01pRmhqT1FCNXNt?=
 =?utf-8?B?eHZ3dHZRKzZ4SHdUM2RKNkRLYzMrMDFhZE5zMmRhckRKanBNSkpZa3dqUlFI?=
 =?utf-8?B?SENKTlkrNzQxZVJPekNvcVJUMWtOTTgxUHVpTVd3RHp0V1JtdHJCZ0tPRXdC?=
 =?utf-8?B?WHRSd0w3VUtvVi9tZGRoU2ZMNXJZenBpakdXL3l6TTJmQUVZU3V3SCtqbFMy?=
 =?utf-8?B?V2sxRE1EN2lqdmhlcms5M2tvL0Qyd0wxWG1HMWdoNi9oQUJ1R2RtMkh1Rktn?=
 =?utf-8?B?eDlBZGlKNytVbjVpaXorbUhtc3JpZWJZSHI3RGdpVmhuTVlyWG8xWDNtK25H?=
 =?utf-8?B?Znk2d0ZUUVBKN0t4eVk0eXdmY2J1VVpMcUVqZnpvaFVsT2VEakhzRjB4TjYr?=
 =?utf-8?B?Qk9icmo4SlhDRXF3RXZDREo1ZFVBaHJOendVRk4raGtselF4YVFZRHA4NC8w?=
 =?utf-8?B?dzJ0dDVBK2RJMDZCbGhaQ0VidFhTNEdMbUFPRUwrYyt5aUNNb2E0b1ovR2tq?=
 =?utf-8?B?Uk9qSXd5Vm8vVU9aSnBYK3cvMUZqZHpDTk11bm81TWZwL1dWcGRPNGRBOWFT?=
 =?utf-8?B?dlNDemVLWnYyc2l0N3pGOUc4YUI1VitlNTY2Ynhhby82bGlIeXhkTlV6RHVZ?=
 =?utf-8?B?dWx2VHRDandsMTNPd2pZSHdyMzd6VDZVVFpuTnNGWVBrejQ0aEVhRGdUeCs1?=
 =?utf-8?B?WEliWUI5WU94UDY1bzM2ZVF4SEttTjNkTlZCU1FuN3VtS2J2OXp2Q1NBWmhs?=
 =?utf-8?B?bGo3V2xvT1NjRWhzR0lUN1pBZytRdzFVajRhOG8yMTZHOExXWWhBclhVcWMr?=
 =?utf-8?B?RlA4WlVtS2FjQXBSTzltVDNwd010WlE0RXFneGIydlFzRWtwZll4bG92ZDRR?=
 =?utf-8?B?dTRJVHR1ejAvT0FaNW5rWkdWTzFjVzE0OEszcHFXMWg3QzBnMFFWRGdJMDJm?=
 =?utf-8?B?a2UrRXdBQWx6d3EyeVZPa2p4THo2UUFmVkpjYW9wMThRSkx3MExaVXEvTGUz?=
 =?utf-8?B?T0NFbkwvRUI3RE9IUUhHSTc5OWNYY0ZxTndIelFyT3poQWhkSGZycWdUd3dq?=
 =?utf-8?B?bC9xVHcxQmE1VGRxNytnQ2tscEF3c0VpMkJQQk94UkRVTFExOVp6d05ucnVz?=
 =?utf-8?B?Tk9LSE5ya2djTXdSa3hENUQ5TStST2Iyc3YyVUVsM1JnTDM0azkzSUpSZW9V?=
 =?utf-8?B?UmpiUnpZV25qTjdJSHFubkNDVlV6aEZuc1g3S1BXbkhKa0E0T1AvYWRaYm9R?=
 =?utf-8?B?WWNrYlNJRGVLZ2twNkpobmV1TWYxZDRqZVJSWVVZUlhKelFoZklGNDRFc0Y1?=
 =?utf-8?B?VGRrTmNCNFdDalA3VlM0UTN2aG5ZN1N4am1LN3NRcTdZVHhHK0dWekNLVCt3?=
 =?utf-8?B?UDVGME9HV3IyTkRQZ09mZER1bjVHY1MxQmZxaFhtQlN0VDhHMEhaV2szakNH?=
 =?utf-8?B?Q21teEpNeGJkajQwd0FEVlFKUmtEY0plOHpva2JaclVCbjhsWm1NWTFsNTFC?=
 =?utf-8?B?RTlrb0VCcmNjK2xXS0VTaDRVQm1MdWpIWldteEEvWi9CaEF1NkFFbnR3Ty9K?=
 =?utf-8?B?Y1JpN3FCSVlCMWpOSkZnamVaazFBcUd4c3VwTC9XNVZvcmYxT1R5K3lBNk9J?=
 =?utf-8?B?TU4zYWxETFg4L0JjRUZ0Z2pieFd3YkowaXFTSEV0M1FPdTJFZW9WOTFrRGYx?=
 =?utf-8?B?TkZxSTVSdmFaSUZOYS9WU3VFdUdhWWErd2IrejAwU1lYRHBXN3J6L3h6WXRM?=
 =?utf-8?B?NDFYbHdRazZlcGM2YWVlTHRxMnZOVW8weSs0VDZxMDRHSm5BdnFleSt3V21Q?=
 =?utf-8?Q?3riTOP7QgHzggqf62bEPHQOZ+d4S8GwjeFtn2jg4Kw12?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AC2D4EBC81DC044A179AE916C69F6D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395803db-e5fe-4eee-edd0-08dc3d9ec89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:32:15.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVakUmi+buNuRXrOkMXrfLoh2ohLJGNjylU6F5beOAyNuHUaR7taVTPVZYOP7a1QIMYQzN+FgcfLgBLaT/XadA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_213223_035592_FE2562A2 
X-CRM114-Status: GOOD (  21.10  )
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

T24gMy81LzI0IDIwOjUxLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gV2hlbiBudm1l
X2lkZW50aWZ5X25zKCkgZmFpbHMsIGl0IGZyZWVzIHRoZSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QN
Cj4gbnZtZV9pZF9ucyBiZWZvcmUgaXQgcmV0dXJucy4gSG93ZXZlciwgbnNfdXBkYXRlX251c2Uo
KSBjYWxscyBrZnJlZSgpDQo+IGZvciB0aGUgcG9pbnRlciBldmVuIHdoZW4gbnZtZV9pZGVudGlm
eV9ucygpIGZhaWxzLiBUaGlzIHJlc3VsdHMgaW4NCj4gS0FTQU4gZG91YmxlLWZyZWUsIHdoaWNo
IHdhcyBvYnNlcnZlZCB3aXRoIGJsa3Rlc3RzIG52bWUvMDQ1IHdpdGgNCj4gcHJvcG9zZWQgcGF0
Y2hlcyBbMV0gb24gdGhlIGtlcm5lbCB2Ni44LXJjNy4gRml4IHRoZSBkb3VibGUtZnJlZSBieQ0K
PiBza2lwcGluZyBrZnJlZSgpIHdoZW4gbnZtZV9pZGVudGlmeV9ucygpIGZhaWxzLg0KPg0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDI0MDMwNDE2MTMwMy4x
OTY4MS0xLWR3YWduZXJAc3VzZS5kZS8gWzFdDQo+IEZpeGVzOiBhMWE4MjVhYjZhNjAgKCJudm1l
OiBhZGQgY3NpLCBtcyBhbmQgbnVzZSB0byBzeXNmcyIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4n
aWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMgfCA1ICsrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L3N5c2ZzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jDQo+IGluZGV4
IGYyODMyZjcwZTdlMC4uZjMxNjc0ZDIzMzk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9zeXNmcy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMNCj4gQEAgLTIy
MSwxMyArMjIxLDEyIEBAIHN0YXRpYyBpbnQgbnNfdXBkYXRlX251c2Uoc3RydWN0IG52bWVfbnMg
Km5zKQ0KPiAgIA0KPiAgIAlyZXQgPSBudm1lX2lkZW50aWZ5X25zKG5zLT5jdHJsLCBucy0+aGVh
ZC0+bnNfaWQsICZpZCk7DQo+ICAgCWlmIChyZXQpDQo+IC0JCWdvdG8gb3V0X2ZyZWVfaWQ7DQo+
ICsJCWdvdG8gb3V0Ow0KPiAgIA0KPiAgIAlucy0+aGVhZC0+bnVzZSA9IGxlNjRfdG9fY3B1KGlk
LT5udXNlKTsNCj4gLQ0KPiAtb3V0X2ZyZWVfaWQ6DQo+ICAgCWtmcmVlKGlkKTsNCj4gICANCj4g
K291dDoNCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQoNCg0KaW5zdGVhZCBvZiBhZGRp
bmcgYSBsYWJlbCB0aGF0IGlzIG9ubHkgdXNlZCBvbmNlLCB3aHkgbm90IGp1c3QgcmV0dXJuID8N
CnNvbWV0aGluZyBsaWtlIHRoaXMgdG90YWxseSB1bnRlc3RlZCA6LQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMNCmlu
ZGV4IGQwOTkyMThlNDk0YS4uOWUxMmI2NmM0NDA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1l
L2hvc3Qvc3lzZnMuYw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYw0KQEAgLTIyMSwx
MSArMjIxLDEwIEBAIHN0YXRpYyBpbnQgbnNfdXBkYXRlX251c2Uoc3RydWN0IG52bWVfbnMgKm5z
KQ0KDQogwqDCoMKgwqDCoMKgwqAgcmV0ID0gbnZtZV9pZGVudGlmeV9ucyhucy0+Y3RybCwgbnMt
PmhlYWQtPm5zX2lkLCAmaWQpOw0KIMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQotwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9mcmVlX2lkOw0KK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCg0KIMKgwqDCoMKgwqDCoMKgIG5zLT5oZWFkLT5udXNl
ID0gbGU2NF90b19jcHUoaWQtPm51c2UpOw0KDQotb3V0X2ZyZWVfaWQ6DQogwqDCoMKgwqDCoMKg
wqAga2ZyZWUoaWQpOw0KDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCg0KDQotY2sNCg0K
DQo=

