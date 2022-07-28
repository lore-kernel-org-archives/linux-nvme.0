Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15932C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=se0195ADE4eT9ZMUFGBZzcuCU2XVCd9ZHrH0P83uWAw=; b=ivzxgY1ussYUgZ7gS8g9xlv3yW
	Bw2NLpVu3bi48yIOvW4r2IOHPRrTyssXa87PuOZdIzpVlZGMPwT+QQe5Kzl9yqeo2VEdimLWtoYzL
	CethmgasKYhweMwaX+7DxiCvws/HT9KDcblhcBVJ6fGeIMvICjj9JTcdSxzFoilne1kKBV26Jvvlr
	0HIDEHWPBeZ7frXdc3JSqnygZqv/H/AM4Wotqol/aGZ+Dqu13mw+zdWasO4terKaTP76Edo+xjJ22
	hi97Lo8MTNbEu/zYmgJUODlriJ80/X7K46+dAm/zvKH7Tc8Ue+i1S0efANx48MZSJa595Fed70fWX
	uf/qx9+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCiS-00Fgyc-Ec; Thu, 28 Jul 2022 23:14:52 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCiQ-00FgxU-4k
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 23:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EinJlUua3CS62n74KfpfW2ybr3TsrehMIY0/umsbNMRrdqXEMtZeESsLIqNzQpJ5nAGhYmRFj2NxwlhwUto0pEMeXWUQGGnAZbyWqUoyA4ti+Kbwq8oYJi89Mcsnxs/iNX1ja6F11i+dtMHznxREnlyMd+nIn34Ah/guarOwQ3O/LnKnVkKVDyYvmOutbsiPwr5YupPZ1k3+9GrIHkTaNp6qLsrlMJ1MSpl7FfTqEcwbzJ9nAB3sP5qFLU6Q/TGGxI51Mm9zI/YOrqLuLmZo/RPFlc/u0mc8BZ0KU48znPgrpUyHtwemcVkCKTvz0TnQ1QO88B3riWXJ/vss8ChFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se0195ADE4eT9ZMUFGBZzcuCU2XVCd9ZHrH0P83uWAw=;
 b=Fw+uqb4qE8Kd4WrMtO7V4JICtew23ggWJtsz+R6vvhOxkLHUIs9g9Iek99veg9xzVTSo/M8bO5ydkP0IGEnl23ySEeQPqVPjsxnMRUS1leEpT34dwde54BMhU8lRqOuzhq1656SdkjYQNC4B/RvivFOzm3XevOCSctSyi5S4fmOnxxxAC29QlBRboxlbP73nSPRwdPwAuw7iKlZJmE2o7vEtIpCDYXh0/yawd2B7X1pk1SIPSvi4cQCWhw6Mx8DAkYIqa5ONgTrgSkkNcCtefmM3TNGAe9yIE2b3FF8BWG171j1YaZXJTmIXqhjY4A7MkKOe41F5j+xUfM42EEg+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se0195ADE4eT9ZMUFGBZzcuCU2XVCd9ZHrH0P83uWAw=;
 b=IC3Uy4Tu7KrfwjlEFiiOyn7qMqAyg6N6vNDDiJJZAVp/8yRcfD9xoNO65hBWlOrM8h5ddXCVIKpaI+R0A5zovaR7jDsD9xERRcpASN1NVEp+uea73bPxolFnW8gcZw0+zwSyCUTQM88T7mRv0tZ3nhPEph3En0zBHLKDawfOemQR+IxRaLqVXzn8y6IF7q5jwAuBmF3XGda0btJfpwAGASh8n6mEqgUq1+mrAAO7oV7jloxeaTusV1DixP8gh2Ji4MUltew6vTWMKmqN+gPFFoODMMel8CzKw7H/rtSatpbf+uzCOT0ogLkFZ2ctejQo+Demkt/GXSBPOgAldvIMyA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 23:14:45 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:14:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme-pci: iod npages fits in s8
Thread-Topic: [PATCH 3/5] nvme-pci: iod npages fits in s8
Thread-Index: AQHYos87YZww+ge3PkivlVc6ghO3Hq2UagYA
Date: Thu, 28 Jul 2022 23:14:44 +0000
Message-ID: <63c351ab-672b-c2ec-cfa4-ff7250b958ac@nvidia.com>
References: <20220728221152.538648-1-kbusch@fb.com>
 <20220728221152.538648-4-kbusch@fb.com>
In-Reply-To: <20220728221152.538648-4-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e78f8fbf-3009-49f2-ea40-08da70eef574
x-ms-traffictypediagnostic: MWHPR1201MB0062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  66LAh/mJVpmoCaVBaYcEuQDE/huyZUP2xp+CNlMO6RC3mYCwu1R25pZCT7ifeOtQePZcs42Y1+4OnWbFp2C13p2C80TG5BXicxKwrL02Krv8ZLRnYnB3T0sM/fZ+QYTj4LarrCQVb/x6Du76kgMCkVIkB35GAT4Z35XQSh3lovoaVQILOOOy5MZ8X6LLyuSRowpcp1TCceJXQXD8/PSk5tVNgt1Aqjk6moztiRD4rBvWRK2DxI5Z0aRIWyec8DH+NrndB7euG9fyTm5g4hD1GF+ItVuxUYjh40xcgyC2qzLnIT3k0iWvCwkhUBvQvOFwQWvCbLCIJbpyeopeNOYjVcxw3upxEogJyaNWMCm45BtuccIq4LriOBHgBGaocgdaWUqOsW0yNURiMBynKsGr7dBPX1e+ZFH0yHWnp5ckl+vRVwlo6G5hRjdFbFB2MLiCpYY6W5Jhp6PPAFFQQOhbQO+gJIT+IHlpzhSBDZxnzrYhCVrZp+t95CCaHCDrFH5aIfUAAy3II8kJKpJaVgxFqkUwPy22yplS3a4JYEqf7uWk1TfVjfpZAwUfonf+i1Kdj4AUON+1yUk7rDkuqOk/WUlnbr0YmiQJWd6Bq+uS0kTOfAfIX/52zCSOxrtu/ciR5tkG9E9fe5m9zqBDR5UPPm89D+THcPAkswZ47dXPk6s1ll+r6IvHpxu4Ng+RwkN0CrzcBGryXBgXQtmRPNOs8D5Swar57PHjB4WlHmI0ifhYwx8hp9hvyRSTu++RoslizmGFDbLJ5zpwQNPGate30LWxJ2cveqLINfggwquotz31KarmQhnlerorwTR8s43J/TtDD++hXQclTOalRuwaVAQdo1DrbNPh8ca558WJKB6BtoFZTJLjucPjXjxCvmKm
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(31686004)(478600001)(6486002)(31696002)(86362001)(71200400001)(122000001)(38070700005)(6506007)(36756003)(66476007)(6512007)(8936002)(41300700001)(54906003)(64756008)(4744005)(6916009)(316002)(2616005)(66946007)(38100700002)(5660300002)(8676002)(186003)(66556008)(76116006)(66446008)(4326008)(91956017)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V2EwRS84Mm55TVJxVE9qVGVhZUp1clZNVzIxVE5MUTVRYWJzZU9TWXZjQ3M0?=
 =?utf-8?B?OUdLdlk1QzE1aFJsRVlpWG9QSnVzK2dFZ1J6VkZxVHJ1Q0YzZ0g3cGxuRXc2?=
 =?utf-8?B?dTQwT3B2akpYYW5uVEJsZlhWL0I5Z3BDMXBJU2d5a0duR0hObkY1bnV0dFB2?=
 =?utf-8?B?N0xEOHZiQzNxNkRXWjQxeUV0ak9BMUd5Q25SVTRkWnpIVzN3MlQ5ZW51Q05P?=
 =?utf-8?B?Uk5lRkFVcktqVWxGL0hSNjRwQnVVSXNoaTI0ajlBZ3A4UWUvMnVYU0Y2Rk1B?=
 =?utf-8?B?TVZOVHUzaHpwN1hnTEgxUUxvOWFOUS9oN0Rwa2JoaEpEWjRnNm84QnZrQ0w3?=
 =?utf-8?B?Znc0U0F5RUdjMW9BOSthZ0N4NHBxUW4yc2ZCR1cwdDlNdmZKRktOYW1UTzZn?=
 =?utf-8?B?QkJDbnFmN3luOTVPNDdpZEZzY1dBUTErNWY2WnBuOEg4U296VXJ4ZzNSTGhZ?=
 =?utf-8?B?OENFMTg4TmFUN3MvSXhwRDNHL2lPcjZ4MW05RHduOFo3MjlZRmpCVmlsZUls?=
 =?utf-8?B?cE9oUEJtbnFsb3FZTWFQaktncVJIc1Z6NmZ6MTd2eWhvTkJMNjBnbzdqOTU5?=
 =?utf-8?B?WG8wR3pIQjk1TlI5UnBkcHB5NmhnRU9GalBSVFRuMSt4U0U0dzJ4TDEvcnR1?=
 =?utf-8?B?SUtEUjdJOEp6WDlwdFdhZy94YkZEYjgyQVc5eDVRQVZ4Qkc0L1hGZ1lxdDVl?=
 =?utf-8?B?R0Rrb0x6bXNaNDg4bXNrb0hRakZObjY0L3dHdTlPaElVekJPKzhiY1NGVFA4?=
 =?utf-8?B?WDdlL1g5Y3dGeXVNaUpESWJ4QWRuTUFYKzNseDczUGZLOXhxSUdsWnZ3Y3A5?=
 =?utf-8?B?L0FXOVJyTjNrTmJ2RjMrY2FSWlFDTFZXWk1yVVRKd1IxYVJmbUQ3Qi9idE5R?=
 =?utf-8?B?STRwRktqOFV3ZzZoOFBCVkdjWnJ6Z1lWTncwUWp6RFB1eGRtWUQzVEFFZFZS?=
 =?utf-8?B?NjBDRlJsamJzUTlXSlo5K3hiOE1KU0p4RmFGZlZvM3laeUFFRS9BSlpDblB5?=
 =?utf-8?B?WEE3NVhWT1hkZWlvS2xldGNqc3ZxUjZqODFEbVY1eThHMU1LZU93eFZpckhh?=
 =?utf-8?B?czJNL2pNRGxRdjNUa1NzVGxReXpKTkp0N1NzWkhldnR5b2J0Y3g1SzVlQ0Nn?=
 =?utf-8?B?amd6RTdyK3hUUm9nYWkvQlkrRUlTQS85TWo1RE9PTDhFbkxCQkpMeXBxSEs1?=
 =?utf-8?B?anRyQXdvSGUzSlpRYWJlVGtwOTVsak5RSGY0NnJXYllqRXdkL0JnSnc4U2Jj?=
 =?utf-8?B?VkhISHB2VWU0Qko1UkFIMitFK0U5bU80VzRGWHVLdkxTOHh4ZklRVzRrM29v?=
 =?utf-8?B?akJRbm9pcExJNUhyUkFkSmpsUllwTVVVbE1FdDF1RmxaenhLQW5oZUtybjhP?=
 =?utf-8?B?VmJTbkJPRm0rUWVGMjJidlpnUXpvUnQ5SEVNRVQyUXZlWjJNckRPNmFJLzJp?=
 =?utf-8?B?OWlMYVVZenc4cktIUTVQS0VNVnhML3p0ZG9CU3BDOWo3RkpTRXdKY09lYnFy?=
 =?utf-8?B?bFMwazcwdmlzaWZpK1k3YmRwc1Y0d3V6aC9CZ1J1Y2R5VHJ3MUVXRFZJSmZ0?=
 =?utf-8?B?bnBwalgzclZXNTVYMGhpSU5VOHZTb3ljOGhTQjhBUVVndThzVVRncDJ6Vkxy?=
 =?utf-8?B?WmNEayt5WGsvWUVEQXBtTUdMNTJ2L2J1ZFBrd3FNUGIrRTRiZTBkZXhwMnlo?=
 =?utf-8?B?NVhycDg0Sm9Qdk9rUW5paGZnRm9BV3VUTzJNQlkrNDZLeUlXdGx2MGFXdnlq?=
 =?utf-8?B?SW51NmZIbEJHL2RjVVBycnhON2l3NHlhaE55N1hiU1c5eUVoSk5LQVowdXY5?=
 =?utf-8?B?K0REcEZJTjVWNDByVzROMW5DUE43ak8wTU1tLy90TjVrak9TL0dUZ05raGZp?=
 =?utf-8?B?a1dBeE1uU2s3Wi9OMFVjV1c0SytRbGFONDBrcTNrajhxS2pCbENndWlsTVEy?=
 =?utf-8?B?RkdBdlJZUEh3TjlkK2JTUVZwMmdaZkYwb3dMRzJqMmJES2R5ZTl4akJRNlA3?=
 =?utf-8?B?WDFERTBvbEorOVBVVEFCcHZqWUc2K2dFNUZMK0Z4b3JoZjIybWhJVGJrMS9H?=
 =?utf-8?B?dmZZRWNoWnZ6TDc4TnBIMks2TlljR0xSTFBhTGdqdk43SmlRUzhIUWZkdFZk?=
 =?utf-8?B?dW90M0dRdTJwcExIUHJSNU5DaG90S25Sb3g5NEU4b2IwYVl1NmlQSmhUMzV6?=
 =?utf-8?Q?qq5WLZ4DFVKp2TTqXTpPnqg94MeIoMBsrtWTgWIzMRkZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D494815A7CCA354086A7EA6554E10E24@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78f8fbf-3009-49f2-ea40-08da70eef574
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 23:14:44.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adbzHw9ermE/7YHWvzvlbSTKM+IrwBA/Tcmu79FMEU23wtks0I3eyn5p9HyUpVzSVTnIM9kKoOWz767CUvjtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_161450_200318_A412640D 
X-CRM114-Status: UNSURE (   9.30  )
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

T24gNy8yOC8yMiAxNToxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBsYXJnZXN0IGFsbG93ZWQgdHJhbnNmZXIg
aXMgNE1CLCB3aGljaCBjYW4gdXNlIGF0IG1vc3QgMTAyNSBQUlBzLg0KPiBFYWNoIFBSUCBpcyA4
IGJ5dGVzLCBzbyB0aGUgbWF4aW11bSBudW1iZXIgb2YgNGsgbnZtZSBwYWdlcyBuZWVkZWQgZm9y
DQo+IHRoZSBpb2RfbGlzdCBpcyAzLCB3aGljaCBmaXRzIGluIGFuICdzOCcuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

