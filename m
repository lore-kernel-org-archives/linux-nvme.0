Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B917AC77B73
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jun 2023 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGrWZElKo+I6afcMcFed5w5WfZnZh5S2ttCWLucUw8c=; b=iOFYqwq3QPtBn31e92C5tZbck6
	L5uddFeHq6AkFsu1YmXReeisJPo9uq8eEzyA+GpO9Qh+E6pWOTV5t+GuSNiWM8OGlcx80/OeOeciX
	CWZ2Cozx4nuVvICFDQjiO65+lWZjvPt53CR3b28bCjenMmkca+ZUp2zlpQZ9yGb10Y93MhhdEi1wK
	lgb110GH3rp2WT4LQ+dKzCA2J0YsXPIs2b/6ZDMZw6vK4KMfY6eFz1DDHPNBbU/CpihCH9a/YJ2dt
	ceC6GKXH7S4A0s6mEYOlQDIB/zsyfJWJP0O73A1EXXWNAaAYYBdPtXEURSm+g8qfLsqttqpZ65LAa
	3l52AHlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5hRq-00BTeS-33;
	Sun, 04 Jun 2023 06:42:42 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5hRo-00BTdx-1O
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jun 2023 06:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjET4vOofvNsGbvNcmSGUPmMgI9gzvQ9q2i7cki9tefVQDgx32AcWoI/VhHBAlNxQj9KpS8z723Xt6pZaLriJgN61bxB36NQm+teccczdIFj006do5v3SPayiDg9RtEv6W2HGjCzmS3O/Q+idTB2KzjgA9oOL9AFICxJ3QYfShBtMyTPrJZ/bxArqEgq/JNVXRRUa4hyWyUylvjUWSurg3LcZ9qK0P+85JpjXG612Vwu4xBZneng7z3eJ9BBWczrpo1CiZ5eBR9xx1VQVf2HyImJME8aI4Pc08bM2B6xK6S2avEah3WovaPq+aG22lVdr3DEZOmjyQaD2zFFHDBeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGrWZElKo+I6afcMcFed5w5WfZnZh5S2ttCWLucUw8c=;
 b=BjgVXT01V8Clt41xoOnexcR/mU4MaPohNm04AEP/BIqC0+hu+Ar6WITI0aqgAkXcjHufUNNw0HvzChnLXpkoY6wuzwpPwHKzwiBlYGtHn/Pplmf/BYH8RIuZ6bcxF6Pttc3t3zYSSYL9F6EgDxaajTeVOnuwR2lOHr0sJthk0DwE348JsAQ7HaHlvrMyIppbPEm6MFEwRefMghPONlarufl7W4evDX3QdIE10XkCYLlqMJ6ez+6Iq5T/CYnD/0v/7kqBRsVoBpR5KUCjEKHd4aJP3U18Pq4+Be0qDa5fDu9W6A4hUqQHyYbM8Et9iXUfeZhXzPosXGZzPvHB79Ff+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGrWZElKo+I6afcMcFed5w5WfZnZh5S2ttCWLucUw8c=;
 b=ko03IHQQtSK6kbdFrMCMT91dgJmPkfOkuR+fEl21S3kOyM1MR4+/1WyYevzQNvJRnJ5FU4tX3GH5/O9F0WgZFImAZ1TCcCuET4rkXwoZ6lFgZM7asMWHZ49OyLBC5z3/KzFH5R0enaFQL+Jt7Y91Z9eNBTvZugAtlPVjbnKRlDW3LWOmAu+u89S/j2S1u/73FXAHa/iOBUbX9l+jAqXTKc78N4K6WkrlKD2w+wMkcAY70+jRiGsBjouWCPOb/Nma8f+yjOVCqcNGlyXB85h5yOhUOFj19g7s2Y7eX4xStlYwH/HsoNxWAuvg+MA6PFxWB2Y7dSqZiwQPqqcobFT4cA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 06:42:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.028; Sun, 4 Jun 2023
 06:42:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Kmemleak on nvme-6.5
Thread-Topic: Kmemleak on nvme-6.5
Thread-Index: AQHZiIFVFfUBMZMSrEydo+0HkKqpwK96TVsAgAABIIA=
Date: Sun, 4 Jun 2023 06:42:36 +0000
Message-ID: <de01e3d8-f3c2-e4c5-1227-d7635b904030@nvidia.com>
References: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
 <bcc3382a-9e28-f6a0-8bd1-76646872c4a7@nvidia.com>
In-Reply-To: <bcc3382a-9e28-f6a0-8bd1-76646872c4a7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4134:EE_
x-ms-office365-filtering-correlation-id: 4a746a4b-b456-4b1d-c96f-08db64c6e20a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9MBlBoD/p073bM83dt9Xq6l49VfxoqbL5ko6nB3SJ0imBjV8tILBH7wUhicY+Ug6Sp/9dGYnEluGehlgv9oeNFXbHLhfwDVgxcEyHnitdSedjpeeAuhVFun1HexVAzkUEfvc+QXCcfGzW89+r1ceryOxk1gPHwy383y7nFinq5atDF5bLUJtHl3uf0aKHsRIAWP+hzPYDnHrT9VvGJqXeMRz/6OoYWTvULnMOJccFm3ixZ49VGPVRig1+1nHczOOXBzgeZX1mGwPormlQFam1Riyj+kSm3MfjAM9/s9gmEvOhE7Wk7Gb11bm0KCnfLqC88R20hDlF9QCOlb3yHIU7gff7BiRPKsLm3GUEfE9JpoI/r723Jz6SSuySB9IFRhdTyFrzR8eQMfLuTlcDtS7Ws3cogfVHQVrjzaf++QYaSdyjOSbQeO0wyfQvmYBpNbHZRUsW4h8YV6MlV34o3d/Am90a/PdIUHwYo3g+mkl8HX5uwy5C2EDFUd9rgI+pq9jVwkDkSRVdHRlzkEMuFGrz/U0kkKcBQiWG9p0uPglA8Lkd+nR3Iidzj5i/+qhHDnti8UWKJNrng9tKQ0reXnKKHTJRRufjZv9ioluOMlEuJE2HUOSzt0E8PEDvrVo3YgwxSvzdaP6k47w0poUXYC89lEtgw2w5PSwJNKk8mr5GuGfUgeuuk+o452XA9FjLmRCToItl2rPFyGdeYFYguoLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(8936002)(8676002)(64756008)(66476007)(66946007)(76116006)(66556008)(91956017)(66446008)(31686004)(316002)(4326008)(5660300002)(41300700001)(6916009)(2906002)(478600001)(122000001)(38100700002)(53546011)(186003)(6506007)(26005)(6512007)(86362001)(71200400001)(6486002)(36756003)(2616005)(38070700005)(31696002)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZ1UE5DSy9YdXIyMjlaUEMxRXdqMndrN2pNQ3JRVkR5Nm5UeVltZDQ4Zkpw?=
 =?utf-8?B?VkxlbysxN1NDOTFScXcvMFRPajRXVkhXOEEwQlh2RVptcG5xZWVMOHJwT3R1?=
 =?utf-8?B?ZjhONnBod2RLSjVxcDlzYktGM2lHdzRBbFVFbmk4TkFUMFVHRFdBNm9Gd0Ji?=
 =?utf-8?B?WTExNVJFZktzYkJkOEwzMGZ0Wmtpd2VLSnY2MlgwQS9sZUVxN3VkZGZPUEh1?=
 =?utf-8?B?RlhSU05ENkJuVGxKck16bDRJbHpXZEJPTm4zZWJTWmpLeXZ3R1Brb2xqWU54?=
 =?utf-8?B?ZU5CVktaY1hHc3VRZUVFaVdYQjRYRUhCMkRFN05xZGxGalFPaDdBRzdYTTdQ?=
 =?utf-8?B?Qk5WTjZ5eDRQRWxhR0ZVMk0wLzVyODh4MzQ0S1VQcWFBZk9YSitXZ0tyaFla?=
 =?utf-8?B?N2Q0M0F5My9wRnJ3MWNoZ3oxTnZkclNSQkpEZlRCekg4SVhJUGY5Z0ZKL2Ra?=
 =?utf-8?B?VGpwUEw2aUc1RTZVTmtQNnNiekFjdU9yMjVSdm9iMkl1aGpCbU1WRG5DUkFI?=
 =?utf-8?B?U3FtQjNxcHhGdXNaVk1PMWpESlBza0lhWHhVRDd3aUMxa2pMaDRvbkdQQzhR?=
 =?utf-8?B?bFdHZEFKQ09MeHdSVFExZ2l1cThjNndVZkFIUWdLRFplYWVxSnVoU1Q2U0xi?=
 =?utf-8?B?Z2hmMXhZcUw5L2NJY0ZKYTVWcUdEdWp2SCtKWmU1TmhzWGxXWDBzZUZiaDB2?=
 =?utf-8?B?cDgzajlGOXhsUFpTQW40SzE4SWFmQXhxWmpMOUFQZHhWWVBUNTdLVzhiYXRQ?=
 =?utf-8?B?VnY1YVI0RGVoZlh4K0svc29IWm1meU5SVE8rbG80UHEvUDBZeCtlZjF5YzZY?=
 =?utf-8?B?WTRsK2toeitGV1hON0FuM1I4WFZyQU1xQXd5bUZ0RkY4MVhMOWRvN1l2MzdV?=
 =?utf-8?B?RW1qbW8vUlFseDVHa2xhOTFXNXVoZytsR2JNVG5GeFg5cUJReVgyWTdHYXA4?=
 =?utf-8?B?OG11b2JvWWlET3p3a3A2QjZUR2cyeG9HY1hyREI4ay90Y0tqSVVBdnM2VE1X?=
 =?utf-8?B?Z3VXVllONUpJc3JERlIvcjVQeUJkbjJiTDltdmxiOHAybndCUVpIdk1lRXNG?=
 =?utf-8?B?S3V5ZWI0VXlUV0xML1lIZ1ZHVlpFYUZMeXBqd2dIa2thMTl4RW1vZnQwWkhu?=
 =?utf-8?B?dGVoUGl0S1czUHNtWkREK3J5YVB3RFpvekRkQnpWMUU2aFlIUlNabWVSY29D?=
 =?utf-8?B?dG5Rb1UzMkZ4M09KaUNrRFJyeUIrNlNMRTdqeFBqVllDd1l5bmo4WjU5SStI?=
 =?utf-8?B?bXByekRvckVqUVdOaWo0S1F6SXZKbHFVTnlGODJ0ZW44bXhEdHZqVTNJYjQv?=
 =?utf-8?B?N2prdXlYRUdER25tWUZsSmhzRHlTSDY3STdhdTRZcjVWSVhMOVBmWHVpMTRS?=
 =?utf-8?B?aWF0NlhiVkxLdU9MYVk1U1p0WENrbmF5dmQ2WDIxMW14blRKd1BROGp5M3ZU?=
 =?utf-8?B?aU9JT1hMNG9xbllGbTRVOFV5NGw3NXpLSXpud0JkZE5zODh1eGFQd2ZrSGFj?=
 =?utf-8?B?TC9wZEhzRWxmRDJJQnlWUDA2d09McUdMWGlPZDNTWmxreGpnZkpoMWhuSHdJ?=
 =?utf-8?B?UWtoMmRCaVJmakhxR0daSmpwQk5JVnd1ZGExVzhaUThFV1lGcGNYV3hYS3pM?=
 =?utf-8?B?T0Z0TytRS2NwMy9CWkFDQkVROHpvOUZBc1k4WGVmMnlTZGgra01zcTdoN2Z1?=
 =?utf-8?B?djkyYTZOWm1Bb1pPZkdnRlQ2OEVNVVZKMzQ0RkRJbmx4a0VZVXdDZlhjclVP?=
 =?utf-8?B?dHF3Zjl0OXdzTFQ0UkVYMWxHYzFyL0FkWmJlckdsNHkyWXRtWXVWZy9wTEJi?=
 =?utf-8?B?aUVxanF4L3RBcVVFQXZ3QjVHcUNpVGNNMUFnazZ3eHU1N1JQelZQTjNWYi9y?=
 =?utf-8?B?aThkeU5SZzhoQ3g5MTkzbmFISWs5L09Mc0ZCRXhNdUVzMFBiM3gvcnZYZnNU?=
 =?utf-8?B?VWJoVXJLMjVWWlJjQzhsN253MWtnV1NscmtwZWxFd1BjS1NxU2ZnNXFYMkpX?=
 =?utf-8?B?OGM4dVRvYVFwVFl4SUxMNHZaOHBMRHhCWm9GVWtvZHdCaG5ER0hkTXlEa1BW?=
 =?utf-8?B?eFk1ODhYL3Q4UjZlZW9MU0J0MGF5OXRyQU9XckZ5aXpUYVhaY1duZVZtMjI3?=
 =?utf-8?Q?kj7aFhfJqaLS6WEgpaFbCQ44u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB9E491D6EB25341B1335A0D8CE49AFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a746a4b-b456-4b1d-c96f-08db64c6e20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 06:42:36.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr2AmPGx4IdDjyqsiLd/wBHZm0KSgy0dkDwGFzqMDHMMc8v9jeDP+5uxfDhHxmk88UBDmVSDOjA4JGVIRiNk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230603_234240_476946_39C8336C 
X-CRM114-Status: GOOD (  17.41  )
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

T24gNi8zLzIzIDIzOjM4LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IFNhZ2ksDQo+DQo+
IE9uIDUvMTYvMjMgMjI6MzUsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEhpLA0KPj4N
Cj4+IEkndmUgb2JzZXJ2ZWQgZm9sbG93aW5nIGttZW1sZWFrIG9uIG52bWUtNi41IHdpdGggYmxr
dGVzdHMNCj4+IG52bWUvMDAzIEhFQUQ6LQ0KPj4NCj4+IG52bWUgKG52bWUtNi41KSAjIGdpdCBs
b2cNCj4+IGNvbW1pdCA4NTFjMjNiZTZmYzk1YTQ4ZGJkYWM4NjRmMThiZTYzZjlhNDFlOGE4IChI
RUFEIC0+IG52bWUtNi41LA0KPj4gb3JpZ2luL252bWUtNi41KQ0KPj4gQXV0aG9yOiBNYXggR3Vy
dG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KPj4gRGF0ZTrCoMKgIFR1ZSBBcHIgMjUgMDA6
MTI6NDIgMjAyMyArMDMwMA0KPj4NCj4+ICDCoMKgwqAgbnZtZTogbW92ZSBzeXNmcyBjb2RlIHRv
IGEgZGVkaWNhdGVkIHN5c2ZzLmMgZmlsZQ0KPj4NCj4+DQo+PiArIGNhdCAvc3lzL2tlcm5lbC9k
ZWJ1Zy9rbWVtbGVhaw0KPj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmY4ODgxMTRjNjEwYzAg
KHNpemUgOTYpOg0KPj4gIMKgIGNvbW0gImluc21vZCIsIHBpZCAyNTgyLCBqaWZmaWVzIDQyOTQ5
ODA3NDEgKGFnZSA0OC4yNjBzKQ0KPj4gIMKgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQo+
PiAgwqDCoMKgIGMwIGU2IGEwIGMwIGZmIGZmIGZmIGZmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IC4uLi4uLi4uLi4uLi4uLi4NCj4+ICDCoMKgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgLi4uLi4uLi4uLi4uLi4uLg0KPj4gIMKgIGJhY2t0cmFjZToN
Cj4+ICDCoMKgwqAgWzwwMDAwMDAwMDQzMGU3MTEyPl0ga21hbGxvY190cmFjZSsweDI1LzB4OTAN
Cj4+ICDCoMKgwqAgWzwwMDAwMDAwMDIzYWZiYmUzPl0gY2xhc3NfY3JlYXRlKzB4MjEvMHg3MA0K
Pj4gIMKgwqDCoCBbPDAwMDAwMDAwMTg1NjkyOTI+XSAweGZmZmZmZmZmYzBhMTEwMzkNCj4+ICDC
oMKgwqAgWzwwMDAwMDAwMGNhNGQ0MWFhPl0gZG9fb25lX2luaXRjYWxsKzB4NDQvMHgyMjANCj4+
ICDCoMKgwqAgWzwwMDAwMDAwMGNiODA4MmJlPl0gZG9faW5pdF9tb2R1bGUrMHg2NC8weDI0MA0K
Pj4gIMKgwqDCoCBbPDAwMDAwMDAwMWIxOThlNTE+XSBfX2RvX3N5c19maW5pdF9tb2R1bGUrMHhi
NC8weDEzMA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwMzczNGE2ZTg+XSBkb19zeXNjYWxsXzY0KzB4
M2IvMHg5MA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwN2UzMGE4ZjU+XSBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRjDQo+PiB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4ZmZmZjg4
ODEwYTM5MmEwMCAoc2l6ZSA1MTIpOg0KPj4gIMKgIGNvbW0gImluc21vZCIsIHBpZCAyNTgyLCBq
aWZmaWVzIDQyOTQ5ODA3NDEgKGFnZSA0OC4yNjBzKQ0KPj4gIMKgIGhleCBkdW1wIChmaXJzdCAz
MiBieXRlcyk6DQo+PiAgwqDCoMKgIDAwIDJhIDM5IDBhIDgxIDg4IGZmIGZmIDAwIDJhIDM5IDBh
IDgxIDg4IGZmIGZmIC4qOS4uLi4uLio5Li4uLi4NCj4+ICDCoMKgwqAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgYTAgYjMgMzcgMDcgODEgODggZmYgZmYgLi4uLi4uLi4uLjcuLi4uLg0KPj4gIMKg
IGJhY2t0cmFjZToNCj4+ICDCoMKgwqAgWzwwMDAwMDAwMDQzMGU3MTEyPl0ga21hbGxvY190cmFj
ZSsweDI1LzB4OTANCj4+ICDCoMKgwqAgWzwwMDAwMDAwMGFlMTcyZGU3Pl0gY2xhc3NfcmVnaXN0
ZXIrMHgyOS8weDEzMA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwMzVmODYxNjQ+XSBjbGFzc19jcmVh
dGUrMHgzYy8weDcwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDAxODU2OTI5Mj5dIDB4ZmZmZmZmZmZj
MGExMTAzOQ0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwY2E0ZDQxYWE+XSBkb19vbmVfaW5pdGNhbGwr
MHg0NC8weDIyMA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwY2I4MDgyYmU+XSBkb19pbml0X21vZHVs
ZSsweDY0LzB4MjQwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDAxYjE5OGU1MT5dIF9fZG9fc3lzX2Zp
bml0X21vZHVsZSsweGI0LzB4MTMwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDAzNzM0YTZlOD5dIGRv
X3N5c2NhbGxfNjQrMHgzYi8weDkwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDA3ZTMwYThmNT5dIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNCj4+IHVucmVmZXJlbmNlZCBv
YmplY3QgMHhmZmZmODg4MTA3MzdiM2EwIChzaXplIDE2KToNCj4+ICDCoCBjb21tICJpbnNtb2Qi
LCBwaWQgMjU4MiwgamlmZmllcyA0Mjk0OTgwNzQxIChhZ2UgNDguMjYwcykNCj4+ICDCoCBoZXgg
ZHVtcCAoZmlyc3QgMTYgYnl0ZXMpOg0KPj4gIMKgwqDCoCA2ZSA3NiA2ZCA2NSAyZCA2NiA2MSA2
MiA3MiA2OSA2MyA3MyAwMCA4OCBmZiBmZiBudm1lLWZhYnJpY3MuLi4uDQo+PiAgwqAgYmFja3Ry
YWNlOg0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwZTg0ZTRiNjM+XSBfX2ttYWxsb2Nfbm9kZV90cmFj
a19jYWxsZXIrMHg0Yy8weDEzMA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwMDE5OGNlMjA+XSBrc3Ry
ZHVwKzB4MzMvMHg2MA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwNjFmY2Y2NjE+XSBrb2JqZWN0X3Nl
dF9uYW1lX3ZhcmdzKzB4MWUvMHg5MA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwOGMzNGUwZGQ+XSBr
b2JqZWN0X3NldF9uYW1lKzB4NGUvMHg3MA0KPj4gIMKgwqDCoCBbPDAwMDAwMDAwYWU3ZjMwNDI+
XSBjbGFzc19yZWdpc3RlcisweDk0LzB4MTMwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDAzNWY4NjE2
ND5dIGNsYXNzX2NyZWF0ZSsweDNjLzB4NzANCj4+ICDCoMKgwqAgWzwwMDAwMDAwMDE4NTY5Mjky
Pl0gMHhmZmZmZmZmZmMwYTExMDM5DQo+PiAgwqDCoMKgIFs8MDAwMDAwMDBjYTRkNDFhYT5dIGRv
X29uZV9pbml0Y2FsbCsweDQ0LzB4MjIwDQo+PiAgwqDCoMKgIFs8MDAwMDAwMDBjYjgwODJiZT5d
IGRvX2luaXRfbW9kdWxlKzB4NjQvMHgyNDANCj4+ICDCoMKgwqAgWzwwMDAwMDAwMDFiMTk4ZTUx
Pl0gX19kb19zeXNfZmluaXRfbW9kdWxlKzB4YjQvMHgxMzANCj4+ICDCoMKgwqAgWzwwMDAwMDAw
MDM3MzRhNmU4Pl0gZG9fc3lzY2FsbF82NCsweDNiLzB4OTANCj4+ICDCoMKgwqAgWzwwMDAwMDAw
MDdlMzBhOGY1Pl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzIvMHhkYw0KPj4N
Cj4+DQo+PiBGb3IgbWUgaXQgaXMgbm90IHRoYXQgc3RyYWlnaHQgZm9yd2FyZCB0byByZXByb2R1
Y2UgdGhhdC4NCj4+DQo+PiBUaG91Z2h0IEkgc2hvdWxkIGRvY3VtZW50IGl0Lg0KPj4NCj4+IC1j
aw0KPg0KPiBwb3RlbnRpYWwgZml4IGNvdWxkIGJlIHB1cmVseSBiYXNlZCBvbiBjb2RlIGluc3Bl
Y3Rpb24gOi0NCj4NCj4gbnZtZSAobnZtZS02LjUpICMgZ2l0IGRpZmYNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3Mu
Yw0KPiBpbmRleCBiMWZhMjdiNjA5MTcuLmI4ZGYyM2IzY2JhMCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuYw0KPiBAQCAtMTQxMCw3ICsxNDEwLDcgQEAgc3RhdGljIGludCBfX2luaXQgbnZtZl9pbml0
KHZvaWQpDQo+ICAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+DQo+ICAgwqBvdXRfZGVzdHJv
eV9kZXZpY2U6DQo+IC3CoMKgwqDCoMKgwqAgZGV2aWNlX2Rlc3Ryb3kobnZtZl9jbGFzcywgTUtE
RVYoMCwgMCkpOw0KPiArwqDCoMKgwqDCoMKgIGRldmljZV9kZXN0cm95KG52bWZfZGV2aWNlLCBN
S0RFVigwLCAwKSk7DQo+ICAgwqBvdXRfZGVzdHJveV9jbGFzczoNCj4gICDCoMKgwqDCoMKgwqDC
oCBjbGFzc19kZXN0cm95KG52bWZfY2xhc3MpOw0KPiAgIMKgb3V0X2ZyZWVfaG9zdDoNCj4NCj4N
Cj4gV2lsbCB0ZXN0IGFib3ZlLCBpZiBpdCBmaXhlcyBtZW1sZWFrIHRoZSBjb2RlIHdpbGwgc2Vu
ZCBhIHBhdGNoIHNvb24gLi4uDQo+DQo+IC1jaw0KPg0KPg0KDQp1Z2doaCB0aGlzIGlzIHdyb25n
LCBkaXNyZWdhcmQgLi4uDQoNCi1jaw0KDQoNCg==

