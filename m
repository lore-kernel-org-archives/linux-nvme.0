Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41F7CE79A9
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1v4brYCzM0OJ5zx8mYJ+i5ekCOhAM4l310KMIEWUJ0=; b=UOQWKdOUjSRrTRmSO9xNHEOlut
	HMM8OOCcOIPjCn404yEXkujC/iPhawwNJl9+GSFMAAVx39va73aZqp9ecutq3RWsRV0D/OeTPC2st
	GXjASGtzFCx3ilr7ekumqZNQK/3zMLBPUk+WdDNv34uoYyR60bllASweI9T5VVT8zw+khpAlKVq+U
	Gkn2ph42jqh36ZTI+Nig2+CEwnDTwF5lNgPUpwq8fjVYq0Q7jRQA32mvstWfUiTA49+Sxz+Blydwv
	E2dYkJjRiZjZVomHAFreCFYr9BJbOjv2TaeVTgZpb4kd0JBOgUzwUIu96SrkgxBIUbet0ukp/vLCP
	lMB/52HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidE5-000p64-17;
	Tue, 19 Sep 2023 16:05:25 +0000
Received: from mail-bn8nam12on20610.outbound.protection.outlook.com ([2a01:111:f400:fe5b::610] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidE2-000p4n-23
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 16:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUXh+8k4XyymaWk3Z+aGOaX8GFN9A3T9VrGqFLVhUHm9NAiWtDurM7zjKbs4HbvbNERow7+3MNmSfrCcgqgpgmTtkTddTWeCGi8rxkUJpISzBCUDVmyBzEBr/SHK60xvrqsxQzuyfPeYHlakVaWgOS8XXOD9XOTV9EmT5L242tuIf4DDP7FT4OmsEiFC10slovBwKCIaz5OoiVKnCdY4ZO8pZacbbfhxt/DdOntJVbqcoHZYP9W9GW3zxUTG3JpR1c3G3zm66w1CZU4e0kVJr9WxMrcHkJClQVdiCqoZ+IXycGP3jMm6rtJF3MIDasCzO+6Q3QZMzC2cQv16WhkhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1v4brYCzM0OJ5zx8mYJ+i5ekCOhAM4l310KMIEWUJ0=;
 b=DA9X1Pi/h6DTbCmFza1b5lsOfanzJdiycHakAc9LQ/yx10+9nEhtol8hEEqc2NYAzqlVHQZMSVb/DIkCwzgPfEaiKY8BcCrZh7xsUflKmo7DxvSF6Hxl2RBHys/YIKWTbXLQaNu+d5V/FVv0S60m4ZikzrqimjblmuDz6LbDUpHu4rJmhQ1oleL+o7Ht0tZnQcimE8LIaoWN8Ja4PF3aXlT7BEJRLdQxTKpwRzklfUhLrhc8Yp2EAKpxht1KAaUwp9j1FkhoKoAnmT10SFDPOQLa9S20zAcu3K05Of2ZnvY0OODVgrftrfqurPA1W0gU2gMoLQVkbpnXmhQqi+Oivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1v4brYCzM0OJ5zx8mYJ+i5ekCOhAM4l310KMIEWUJ0=;
 b=cBed3/keb4LG2lDcoEwj3lH10tYk+SEWfkKvY1JIrnsS4dfPf7IXM3pZCJHecWl+XQUPRuIMc08zpL40FNUnA7ihBdblF8loOgaxoYR1I8/SutKzGZB+J8+sbfz6yqu5sMRnbLbZfvUSuJUT3V3y3Z4LoZ8iBofqdoJkqKwTZZq8ANH1wOmD2sx5bBTH8/Jg/LwqOTeGu0/GnMdiVtzGqhw7qujkBwMcb+AZzVJuYq4PnNKuJsLaYeTH0u5liJZAIcwEHdwHyvzzQQHYgKsu/HQ1TnkIi+tazfFyupnM/isdot/IGYWJR8iI9lTdbdeTHQee8yViplXOW7tfVEuDfg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 16:05:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::80bb:9b5c:2c07:a983]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::80bb:9b5c:2c07:a983%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:05:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Grupi, Elad" <Elad.Grupi@dell.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>, "Zinger, Eldad"
	<Eldad.Zinger@dell.com>
Subject: Re: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Topic: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Index: Adnq7iO1RAClALWAT0iWmuSPClnDIgAJPGwA
Date: Tue, 19 Sep 2023 16:05:18 +0000
Message-ID: <b6b1565c-e887-d7e1-1235-36206d4230e3@nvidia.com>
References: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9213:EE_
x-ms-office365-filtering-correlation-id: 30721c7c-ff73-4b3c-c640-08dbb92a37dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FX0ijYyUKNRHKPU/WK5BEZKPwrYtxSvqqjMuIaJRi19aZiEtizneUJmrluwP1rkESVblX9rc1viKY8erpBxDpmb3j6ultYDlia7KWt6ys48dMDDDf76d5qa2necs0ae9g5h58AcjgKbOe2wql79PV7DgYLk/rh0m3OeZaQceP20lnWWnQ9a/ugSa2EpUTKqI4NFAeb0rtbq0twSLN+M0ju51tQkz0E4syxo94V+JEpEWgoSEC84kEA6h5XxrNidPTCMYdRSAkAOKCFKMgeamI2crbar9S6msywSqhd4p9x2v6tcR8qqlUgMq+p+E7dnGQ/MMJIcM7FVP5bdgwkzQmJDmBxHkf03v8A090c5BCVpAy2wNtoOQr7W00Yo9yofB5JqBUnbFAjr7P15e5X34w8Z7lI+hZLRwcs2nvgpvhj/2uD4u+7pAT0frz+FtcakS5YnDzt3QlsWnSzwYLy2j1465cNB4XieTBV31FNQl7uqKpuiY8XKf7F1sr+fWriSGP9xIljbrrggPOTR1sQr5Tmp5+U6jrcmNFj0QHFo2dcVuAqy/ZQ0Kc3KGF8AwMhvZj21+JovwkEIyiSyITbu0lx940hpIulHyX95NeWboOr5aR/jP7L7GnlBCYfVnuW8MJq+7N3VY7Lb7EAPmMyhr5J+xHPIfb+KGUPph5s5bkkgCw8cSdfv7icQT1DwE9EHP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(186009)(1800799009)(451199024)(66446008)(54906003)(76116006)(41300700001)(66476007)(66946007)(316002)(8936002)(8676002)(122000001)(110136005)(478600001)(6486002)(6506007)(6512007)(91956017)(71200400001)(4326008)(26005)(2616005)(86362001)(31696002)(38100700002)(2906002)(558084003)(38070700005)(5660300002)(36756003)(66556008)(64756008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU9HdDh6a0FyUkJkb0RuK1N0d2pvM1VYbDNZOXJabkltd3YvREJRZGpGZnpu?=
 =?utf-8?B?djIwZXk3OFhVOHNKbXpPaTViR2JBc3lDZ2tuU2R3RElVbDhOTFdKYWhNcUZF?=
 =?utf-8?B?dlVSQWN2bGUrV2J3d0Z2SUdWR25HM2VDVUYxanV6b2didEhoME9JeVdlRnQ2?=
 =?utf-8?B?SXdQbFduTHZCbmxqcWdldUpyUmpLRVRCWU1NblRmamxncEZqVjhYZEJnYm9B?=
 =?utf-8?B?b2NRNXVCSXQzamI0V1JOcDZ6MjVKM01kTzJCeTlBV05yNHZGbWx2emlraHpK?=
 =?utf-8?B?cHh3YSs0ejVTN2FXOFlxRERXVDk1WUFvdlFWaXFla0t4aFVxZ05iY0VmN1Ju?=
 =?utf-8?B?RG5RMisvYkk5dE1OaVVCRlNQZkoyeHEyaGhiR0pGNlRjOEovU2JLL0wxaGxz?=
 =?utf-8?B?NDhNRnBGeUdJWi9lbUM2MzhmOXVqSWM4Tkd0a1AxT0dTRmpJL2x4aFE0djRG?=
 =?utf-8?B?cDdxRjlzUHltcStMNFJ5ZUdKbWZCdWd3M2w4L2tGN2RvNmZ0L05Zek4wd3FL?=
 =?utf-8?B?K3RWTEZxNHNFdXprSlF5TzhHY2ROMEl2a3ZnTm5MNkMybnJVVmpSRHdWUlh2?=
 =?utf-8?B?Z3ZvMXNtNkJ4Slp0ajRlTlJteGM3TlZ1Tmd6c0kwdXJ2QlVrTG0xR2d1b1NJ?=
 =?utf-8?B?SlY2ak9GMG1FNG1LRGpHK1F0UW9YdmczME1JemNHeVpDV3FzSnhTZ2tTcURq?=
 =?utf-8?B?clc5eEJQaXptd1Bnb01aSDEvbzdWbUVvTDVVM2RJSklhYkRtNGd4V1NKaUNl?=
 =?utf-8?B?OTRGTTdsMXBodzVhdlRlb2VMeVVUejlrVHBSRzJVRHp2TFNGTXU0UG5IdG53?=
 =?utf-8?B?NFdQVzRWb1huU3VXcnVIaWpSTjQ2TEx3UDkzMnllUytJdUxwMkJiWlgzQWZx?=
 =?utf-8?B?ZlFjTjRCalo2endvQ1JrbFdvYXY5RzBCNXdQQ0ZINXdBWU1CYXpwU0hvWGNu?=
 =?utf-8?B?ZE5FN1hDMkJWTkcvLzN4YkhHbGF5OXRvRi93cWIxL1F2bW5wV0tLT2tqN1VM?=
 =?utf-8?B?bFM1VWFwRzBvazNIa1dCbVo1Z2c4RXM4VVlWWndLemFWenhQVUw0SFVvTDM5?=
 =?utf-8?B?eU8welpyN0ltMDdvVXRwQnhCWVFJYjZzazQ4K0MwWHFhOGVTZVI4V0o1Tjhq?=
 =?utf-8?B?L0xmdmpoMkI3Z3UyclJJNnFhUWdMT0xIUlhxNjR6cWV5QTA3NTNlSjF2YzF1?=
 =?utf-8?B?c2VSS0VFdFRxeWpqdnQ0ZGJaVE8vL0JBWGFBbm9POS9nS3lZNDVTSXl2eXRI?=
 =?utf-8?B?RENIVFAxanN4dEpRcXhIZHhxRVZEazlYVnJIK2pmeG9BYlZ6Tk1OTnBIY2U2?=
 =?utf-8?B?QzhxNUlTL3hndm9Sa2RWeGR2TTgxK2NQWFF4NlhhY1hONlZxL3VuZHZvdVdJ?=
 =?utf-8?B?ZG1wRDJGbmVmbmlzMzBhWEVpUGRodWx5RFNObUpwN3ExOXkyeWpmVS9WQjNn?=
 =?utf-8?B?Z0NQSEJIVjlkM25xb3M2Y1FLQWVYMW15amluMkdLNkl5ZFkrQnVoeGNJOGF1?=
 =?utf-8?B?NTJlV2Fram01ei9KRWJxaEVrL0hjdHdINHUrRGRUYnRrMzZ0aFQwRS9HT3hw?=
 =?utf-8?B?MWhUSU0zd2R3VEgrVDhMYk9zeEY5dmRNS1o5bTdxOXlzR2s0eXBzc1Yrbk9K?=
 =?utf-8?B?c1dKR01MdG1RVGNydFRqeHNzcUhPYnZTWHNYQjF5YlVVYVdWelh5S253aGRa?=
 =?utf-8?B?YXBtSjZtZ0VpMENpOFVOTGF6MVpXODUvN2FqTUcvQjQzajdnNHZSend3bzZo?=
 =?utf-8?B?TUhWTks0elRub203cDlrOUUrY0Rib0szU3NsUERBS2NieitVTEpqSmtrdUZL?=
 =?utf-8?B?cWhsU25uV2RyM2RubnpVS2hTMjR3bXlNOUR2VDkrMW9LY0J5MEJIaDlIaEp3?=
 =?utf-8?B?dzFNWkdadjNJZEFIaXBKdlRGcVpIQlNIbXN6K2s5MlRXMTBsaFFMOTVwc1RD?=
 =?utf-8?B?SmRwMjZScUFFZ3JQVFJFKzErcEExZk5NVFhPTE9WakhOOUJaaWM3T1EwRkI1?=
 =?utf-8?B?ZTNoR3YyNk54RC9yU0tiOVY3dWxjdFZTUTVMWFhCYmJCRVE4N0JlRjk1c0R2?=
 =?utf-8?B?SDhtUE9Tcld6empSRmJDNVJrYzV6d1g5V3RTYTJQcjZIbWRFNHpDYkZUQWJZ?=
 =?utf-8?Q?SFfDY+WeiY3NyA4aOMCN3zM+/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6122BE6129B0479A503B862885B5B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30721c7c-ff73-4b3c-c640-08dbb92a37dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 16:05:18.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8EJ9O++XuD5Ddniu/AQQCIrT7V58kfBSgshD49/b4alR3ogikU0IWcZx9EVg74pz+iLyLxMGj7R6W3D4sJmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_090522_700201_4B0AB9A8 
X-CRM114-Status: UNSURE (   6.61  )
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

DQo+IFRoYW5rcywNCj4gRWxhZA0KPiANCj4gDQo+IEludGVybmFsIFVzZSAtIENvbmZpZGVudGlh
bA0KDQpQbGVhc2UgcmVtb3ZlIGFib3ZlIGJhbm5lciB3aGVuIHBvc3Rpbmcgb24gdGhlIGxpc3Qu
DQoNCi1jaw0K

