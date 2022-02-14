Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXf/unXPk2kFvND7PBCBnyzZm88APh3dwcYrLzrikIU=; b=lsbbrJWOHphmuaUCZvaN64kVam
	5ZlBHgpQH864Y+1BkV0Hvoa3Vqfhi6v5BqXLCkKfGsTQktzJMaluCpKhaZzmAwjMq5fVohKwGF4Oz
	7XYK0i3h900RhKCtHBaA/p9dRU9o9cgNw1y/q9VEd86SY2p/k2vDmt2Ex5Xbs8pB6oav+WCRtfHfg
	32nz20aIBGqBlZRdeTecf54TsIzuOQMGSsbKsRBdCO09lSviYqFBlxotHZ0QKYQeNNq/KI2XHcd8W
	C+OAmP87IUHbf11S1gco9S3uChZuUjxkQfF9R8QfJqS2Fo78V25/L/Uy986x87lfEiURMngX6U3BN
	0umfloKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZQm-00Emkb-HP; Mon, 14 Feb 2022 11:22:08 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYCr-00EOke-Rt
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj/xLwUSUvBzYEnC1wkh0qQLL4KYBxspyq8aCCPbCeR+T6PXZxaJTBH5dY5ZzdY2ZdtTJT6FHJxaBe7vXPi0O4WSigSuMXHIPQlUNaVECcU0WSZQGai7JJB/z/kvp0Llzd+zUkR16CJrN7iTW4N69RiZOB4sTw6WPFcwyJ5MC291wVOiVEvuFgf7ooRuLk7hf6ZJwRquDeu9HNGjFNciLjN1TLv4nnwvFPgUjVS/heyMP5tEsHsmMJVsRolk9NqcyRIK+WYDgfAsRIbtXRKP8AmEJKvPZSPrSrKVD/hpbzXLpqvXAR3y1LQbWpIa2E9Tar1E5T3tv0vvsAV0aA1BfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXf/unXPk2kFvND7PBCBnyzZm88APh3dwcYrLzrikIU=;
 b=XjWZ4X+hAJZr2qonPM4QdlvANR3i3F5Ctsd+terGFUsJOXMEe4fV7In5pZCzHGq1QcQJNZAXlYXPvznRbjWaWG0izvxOftuXZdTiBIYyKSXJQM75aazl4ptrWlG4+asIMHgkR3pBueSC1FVfBDM9zvKqjyeos8v8/wU218bF0QXumKw+TQ8q/SQHypS4c4Jfl9gELR054r5wgdtRCrDRFGAi2U1RL7KJZBpRNhJrphDwMKxKh2imCGuq5ysvQaCVlO6GEub2L7XPOIg67lBcVkE2VEu3absOoUUdvTY9UBUqAzrIc2s+6CuvadSOeW75xxeRScdB2jy3ERCQfFK4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXf/unXPk2kFvND7PBCBnyzZm88APh3dwcYrLzrikIU=;
 b=Uuj79dFG5rYd3e8ASdenitOVc9GC93mtUm5ULlEsyw9kbsv9IFnWazP4dPNMmqTo478nu9GpAU2ksGQP4EcLse05NOidKsSjCt1eg+S+9OdpCCXoHFmcA8vTY6aV6mqTriNIvj7ON8FjY7p5no2v6e6Y3coLWR3GtLtitJgdovpSUMgpL6eNd/YuRBNZvOdX8bGDa85RGjF0e1yxZlyo+1ej3KahJT63B7Q+1XEC2VPNsKwNXEVpftOeJ46jy6b+MRNu33Nf6FjkRtzThmWDjrCWvkA+dQAMsWpvwkgky5w2hQf/mBKeHVtp0F7QwhLDcsSgCx6DuNtz47QDpWYg3g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1142.namprd12.prod.outlook.com (2603:10b6:903:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:03:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 10:03:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Topic: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Index: AQHYIYRxGili+sccbEWgjaiE4nwfg6yS0TuA
Date: Mon, 14 Feb 2022 10:03:38 +0000
Message-ID: <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8ac882-c148-47f5-5eea-08d9efa14571
x-ms-traffictypediagnostic: CY4PR12MB1142:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1142CC90D2E31337693E26FCA3339@CY4PR12MB1142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBA/fT2+bBDNoIdHkIdDxhhjafVvzvIlTa3dhiaqPCtuIIo6K0hIsb3+bxL0qVW1+D/N6XUSbQ1DPliWQOSes2AUBhoc4JIw2K+cJgI8gY62qEE0cF0DNPZjaRO89FpqOgmij27qZ8cY3BfPNC7CLqxryp4oI487jPk+f5pVp6EH8OI2z91zgupDbApatIjrhkJ9WV9drOQ5omXfyK0u1UBcErdMe28nKWw1Tmjpjk7snecYhdwpqQnhGyWW+KF2RodpqkVIYuIOUG7cMzpZS2JMy6reZLgJU+Xuiy4wOBByNzujYpUvjmw9MV7ohmDbrcp6/Zq7dpLnwrTLSgxh3qZPwo2mM4qm+SN2CnTj9OtFQ8XqVjJKYiXkqrvbCSqwwfg0QpCt/gKiMLS24vDLbgM+GSqYpsCEs1T+H79stHzbYcQAI6UD0jrJ2MwAf3Xo40qAqgOdO0bC9E8/lvvqu24BLhepihWwCdv+b1KYOTZJZrCC+hgquOKB0iMTP6HMmVdgrWJICiUBjMLd3zowq63f78HpM/2b7AeM/fayZa9lypRvMGN2C+PSy+g+5CU25cBHsWaj0HidNmgUWGx7vt53hBgFfcofByrv67FC9YoDs+9E4j+4usCR4m0vUIjq42m4DHzEK56ISM4W6BOkhHdKZvV5yU0NKiKdILLHzsSoBmbzVV1ohrbNm6TtMzBd+FzM5rVLoUSKw+X64zRtb4QnDGmSMy7SRs0oexOfXlRRXIjWGOeERdoU2KXI1CBYH4LgtJkqx+ZoSF3pcOe+Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(66446008)(64756008)(508600001)(54906003)(8936002)(6916009)(91956017)(76116006)(31686004)(8676002)(26005)(4326008)(122000001)(2616005)(186003)(36756003)(38100700002)(6512007)(31696002)(53546011)(6506007)(2906002)(558084003)(316002)(38070700005)(5660300002)(6486002)(71200400001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGlvRnM1SHdlZU5uZ3RMWTM2azFxSEhDOHZMeFAvclR1ZGNMNzRaUzNKT0Rr?=
 =?utf-8?B?cTlRWGlHZWdacTEvS3B2WFFUSlJEWEw1LzJEY3Z4V1Zpc3dCbWJqK0pxR2FG?=
 =?utf-8?B?aTVFRXQyOGpFNE0yckh2MFlMa2ttZDBaZzQ0eGdsbUNzcktQYlRNWFZ2Y3dx?=
 =?utf-8?B?QkpqampJNlNndGFlWWxnN0tJeHgzeHFCMHIvaGhEU1pkdHhMZ0NRUXFlYmZ3?=
 =?utf-8?B?NkU5MUN3SWo5UDBRM3dOL1l3YjVHaG1CcGx0QWl2dzhIK3B0R2RPMDdCczVZ?=
 =?utf-8?B?RzNkTkVXTDM4anpUOUM2VjlMZ2l4UHd4MXJyU2xwa0ZLdE1TV3VodTFaTys4?=
 =?utf-8?B?MGhoVThOMHJCeUFLbTUyNVNxclRJc0NWRXdWNCt6dG9obUg2V2syNzRvaTNu?=
 =?utf-8?B?cDBSREZNQ1lCUFBpTE5HR1psMnFiNE5MamwwWEdiNnVXNmlPVzIwZElJUWta?=
 =?utf-8?B?a0JGaXdlNXNtd1hUUGJzelpGaDNFU3IyUkhwSXRIcDVrUTFBRHQrNVFhN3V4?=
 =?utf-8?B?LzIzeUhYRE5XWUFHSVVYZGNlbGhwckliZ3pJUWZKa0Z5a3hpVEJPenN0enBV?=
 =?utf-8?B?bC9WRkUwTzg1S1ZRb1Rncmc5ekpQMVhXcGcvdXhQb2ZaYkZZa3pLc3VTTUli?=
 =?utf-8?B?djJDeGxDOVg1STllWitxTTNBQXg1SGpXc2RkMGVvQ2piTmg0Nk5Sa1RDZTNV?=
 =?utf-8?B?bHNnR3NOREFrM2VYNU5EOVowU0xyMHVqSHNjanBFWmFrZndOUi9lalRRVDV2?=
 =?utf-8?B?RnI5YWlTQzlHd0Yzbm5CWmh4Q0czOFdlVlBuM2tCclNHNUpLYjBYZHBHOHVq?=
 =?utf-8?B?bVNyNTg5N20wRTBWT3ZMRWpaZHJWMzdWdmFQS2dFNExYUy9WOEtZK2FRb1Qz?=
 =?utf-8?B?WFE1cU1lL2U5dWFXbzVuSGJST1JRQzRseVlYRi9McUczRlNxUm05UUJ5bmtr?=
 =?utf-8?B?LzJ0aHp3MXJnaGd1bGVyZU5uZytvYlNwQmJiZW9oMktwRjNJVTdBUjJWMHZt?=
 =?utf-8?B?K0VKckY4UnpMYzdwekV4YThaUkVWcWN2REN6MWIrR2tIZkJjTWVXc29tdGwv?=
 =?utf-8?B?S2h1TkVXRzN3M1ZSbXZwUEtMTk52TFVkZkZGbDRUTVVVRmh5SDg3M1hENG9C?=
 =?utf-8?B?aUp4MmlwVlR0RmR1cThTTUQ2SXBHYUFrVmFyNzF5cDUxZThWV1BtYUtNMDQ5?=
 =?utf-8?B?cmFxU2cwaWZIRi90NGVFUDRST21kSlFrYXU0N2gvRStSTG1USGVwWjJCNVdZ?=
 =?utf-8?B?SW1JRzBFaEszVjM1VFJuaHJIL08rcEY0L2Uvemt1VHRWd01kWVpQbzBMZU5Q?=
 =?utf-8?B?UkVVVkpuL0tyRWtYajlnV1NlY2dUd1lwNDRjaVZvK3k1MjBXbCtDV0t3ODkx?=
 =?utf-8?B?R2NLWFRHV2RtYWFnNFVhNVhGTUJDdFpxdU5uWlljbVhaUU5rMWxSZmh6cGg4?=
 =?utf-8?B?RkwvYUMyZDA3UHdXUnBWWEFSeExpV3RjbGx6N1FWWU9ybnF6Y1B3NnBQcnhX?=
 =?utf-8?B?d3JTQ3VYVU5WZWNBTWpMQTJwV2p0UUNjK2FGc2F3OXY5a1ZUbGg5b2J2TExa?=
 =?utf-8?B?cE9DV3RmUHZEWllhUkpKV0RncWpDbVkya0p2dFE1Uzdrb1poU3hNYlZYenBG?=
 =?utf-8?B?S0dDK1lnWjZUSjQ1RGQ5Z1lHN0t1dXBUN2dtejdLZXNyL1ZtVCtJMG5lTi92?=
 =?utf-8?B?YzQ0aVZ2dHg2M1A3TkFtRnpyY1cwczVlNXgzYitJZE95RUlvSndVRkRPbDZz?=
 =?utf-8?B?dzd0WTByVmswK0gzMXdiVzdBaFdPYzRmNERQdG1Odi82OFJmekhhMlVHM2lP?=
 =?utf-8?B?K04rNWxOUGYxVjM0dUpBRDFHeTNxWkYrb3FFVHpqNkt4NWN4aCtiZkk5cFNJ?=
 =?utf-8?B?OFVrbjBsL0VtaTh6UWZsd29CcXpsV3UwVlV4clBjckZlQlVBd0hGK3JraDg5?=
 =?utf-8?B?dTVBMm0xSW1Da2Rwc203bXVTa0QvNGxSQ09odnVpbWlkNzFPa2YrL1VBZVFz?=
 =?utf-8?B?eFAydXFIV1lUV3owNXNLYjFIWFpEQUZ4aEg1eG04bWxqQXZLS3lxTVRhcHdk?=
 =?utf-8?B?ZlZhcDJJeUlNdzh2NzVVYnhWbWFZUUtHUHVGcS9QNWlRWmFZTU9uQ3dNTE9E?=
 =?utf-8?B?dFh6ak8reldjUDc0dEc1ODQwNEFDZDNKaHVQQTNpaWNlZjMvOUZHUlhIazcz?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5159418EAB5E864BA8AFC5FA8555EB6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8ac882-c148-47f5-5eea-08d9efa14571
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:03:38.2373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rRT+STkjXZCKzUGFDQ6mb5LIdUSGhSybMRuX22zH3tHrJyEMg+ytbKcKZRQbeJFlxOHBRXf22/pItX5Yn7lfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_020341_957836_2D5A106F 
X-CRM114-Status: UNSURE (   9.41  )
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

T24gMi8xNC8yMiAxOjA3IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBXZSBoYXZlIHRoZSBz
aW1wbGVyIGFuZCBtb3JlIGNvbnZlbmllbnQgaWRyX1thbGxvY3xmcmVlXSwgdXNlIHRoZW0NCj4g
aW5zdGVhZC4NCj4gDQoNCnlvdSBzZW50IHRoZSBzYW1lIHNlcmllcyA6KSBlaXRoZXIgd2F5cyBz
ZWVtcyBsaWtlIGEgdXNlZnVsIGNsZWFudXAuLg0KDQoNCg0KDQo=

