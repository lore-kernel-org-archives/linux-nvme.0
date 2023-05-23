Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AD7C77B73
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acAfsdlIyZs7Pqw9Y1fOwgtFZq38UbGSbB5I7sk0THM=; b=t7Qi0JyyyTKqXRp3n3eMS1Ii3q
	H8HnYQ+iSArUW50/sfezIc6j3E1iVzLme4XCD1IForDN/Wtf3F6UU4REPzfQ5cpMJGJeyDYih8Wk4
	vvNMnioWXBwbmppkh5mYwE0os9SIxAmuMqs4nSX8fGh6LsQgUhzocqGFkr/Crhvz1ZbxdAPwZC+cu
	h0H0lkXSz4VNu9ke42/ettYxA3uJxJceorUXBORbimVApVDKm/eg3RGMrHbObYoItDLM0bLlf9aF/
	plDPdLsApz2S8433EZNTAsZcYHZZPJV79NFQZJVdY8L7S7GaqoYminX3spltEHlQxucyBb1XtktRC
	3z/9b/iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1FhV-008RNb-2d;
	Tue, 23 May 2023 00:16:29 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f400:fe59::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1FhS-008RME-2k
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 00:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXS4fXKIBSkcBpArG5CfhaaSx212s0ZyecBvWjd7i3U7d3eKUOv69C7p7dffzFD6Pn4AqQ0LvA5Ggrkl8qPRxYfq57ixjn6hxIMmdwM70ttmzxedCGhqVToI2Yernt7ND/5CxmyscQ7zxWLGn/muTNu7WELTqFMO1b/0VVQVMeVrKqv6qj32MXnXpQLjaKU/Z3B6Dn9j5x/Ge5yJVoqGqmG60uvVOBDA+YDq70PI2GXybrmpWO/d0Brleq7MQNRewIcwNEs9/3EN2ld7ii76SydtSjcluIoi12IFXVPDDQWXoa/S3vbE1k13xAsjfuChlaU3oygQmK3pePbV2zBy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acAfsdlIyZs7Pqw9Y1fOwgtFZq38UbGSbB5I7sk0THM=;
 b=Zn5S1fo0zKU2ygQuIkhrs6tAnzAFfxUMdLWgxQG3NyaAs9o6nQ54XFJdh6J6TFrfvZXuisbHpM1CBCJOx4NvIudutllJYPwRqac5UH0f1Y7uF4rNSQcesscXNmXW2b8q9e210LchmxqLuVkPJ5YXmMuM+iBHfLvr9VfLy8ja1zMOK96QVsIN8nDp/pcN74JG7NWd4M6FnSQsPZzFp3SDicsbBUYHGS8Gp+S0S5xw6jxrCNVOc2dSBkrN4/owIHnweGlgnMedzsWudcWEkpEJ6FGCMawNwPbVP2/UnOHrKzvhyA19FLNHZH/amcF1c7jjHxyI1R97DY+m+HrGo69Pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acAfsdlIyZs7Pqw9Y1fOwgtFZq38UbGSbB5I7sk0THM=;
 b=LXITFCyI0KdsiwO1IO01Diogj9cu19cPmiCZQVKzURlOr93ouYSLOuoYv3JH+mpXCXVCRBbWwY0BYnPveHECEvpGruzlXdda9vlFRX3err8B571WMSS3MugMcL4WLfp3GWi/ehtnosnqlyck7+pIUdaVCgeOZgV7a8cfpg9em66PkfrEFQzZDEyWfRXBk0MphSK7n3t4R8JMLGSOzsBWrBJYfo3f4n29S3PMGw1nE62EMqds+6YkBgb8I7uj8A7CP/3zt+ir5A55GQER34n2+TLpAWSo5zS0/B+libLwrUGfNsicSqn8vk09Zfgb2UtftCEzTuYhWSUBvpqfxlCboA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Tue, 23 May
 2023 00:16:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 00:16:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chris Leech <cleech@redhat.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: fix dhchap secret memleaks in auth code
Thread-Topic: [PATCH 1/1] nvme: fix dhchap secret memleaks in auth code
Thread-Index: AQHZjPhS0a4ph85HT0OPbIDrlA0mBK9m/aYA
Date: Tue, 23 May 2023 00:16:19 +0000
Message-ID: <8066e1d6-3197-6127-00b3-a3a2b8eae369@nvidia.com>
References: <20230522215347.2031483-1-cleech@redhat.com>
In-Reply-To: <20230522215347.2031483-1-cleech@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6837:EE_
x-ms-office365-filtering-correlation-id: 0a809a9a-332d-4199-062c-08db5b22ee74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpPjL7Ikz/N1DcEi58M6kTo18HcXt4tn/qXojrzkLn1KHYK1U8D+LYsyOfcCb77KZoMPchgOrejwkweljKT4xQ/BCsaH/3F9hqVtrTd/YHz5fHA1oOzqSKWFGD48SMhFKZaMXCZSq8fyK2RUJreAau60yME1O8w4i8TfGGc02+FJCyZwSRSF1hmcgvXz2AMDHjhnrXEXD7L87waJBGeVROimvLaA4axVR6DOZnPzOqNsm6enUo8w9pfhh2ponCBvz7dTCmFWFF/98yHnN6isQVQ2ZXSNwk8CqeFg05m+hw+YVToWUvRPL/xoDS0fD+GECPFVEuv2172d42LC70KJjuG1Dan0xp3FHYuXwiCei3EMsxDlk4UwOPWg3f4yPRjGyrei93zhLCF3vTAZ/IYrWQoJtG4EqUjHKfQ2fPD/+2W2GvGGx5gEje5/Z/UmmgOcmog0Qe6elzaPlxMu8MrZ3guZDZZM0VnS38XDtFKxlZwY0XlKrAH4wXm1Wfna1kUHOBz7Iie/JbABwLWki230vudyXclSqialL8DDvEGbGCgwXZBU+FXGXm9QJuNy0PJrhXylrugRpiydbtcSzY5f6hF6sxQkNEqpo1eCd/9HT/J9LoSh6We/tQ2MtOe5a5hCfuZk2s7XvRRCevpzKhmAxzpNzBYBSmbiac4EcHZcqXs3Rx6RwWndz+e/qmAeR2o3IjT5NCPYOuZOyqKWhXtiNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(31686004)(64756008)(6916009)(66946007)(4326008)(66476007)(66556008)(66446008)(478600001)(76116006)(54906003)(91956017)(316002)(86362001)(31696002)(38070700005)(36756003)(6512007)(53546011)(26005)(2616005)(6506007)(186003)(2906002)(8676002)(4744005)(6486002)(71200400001)(8936002)(41300700001)(122000001)(5660300002)(38100700002)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhQditOcEVlZndXZVdIQXdOa0hXeVdaZ3E4NkNCaVlZSU5Sbmp4Y091eWhk?=
 =?utf-8?B?KzZYVGprd3QySzE0WWh0MnVQZWZWMk1CY1BMYnJVUldsU3cvRnlKQ0RCcm5t?=
 =?utf-8?B?UnBGaG5tVXMzVEVYK3R5TGY3NGZFcXNYLzNnd1M2Umk1a2c3L0dsQWtCMEVs?=
 =?utf-8?B?bXgydGYyREJEUFd6MUJzU3JETlpUUERicUp4WFY1Z2VtWjVabS9nTE5HSmND?=
 =?utf-8?B?b1orYUlaUkYzeS92SFdJcFN0NUpBV0pTQ29JV2RrMVR2Y3NIMGJPRFd5VVpq?=
 =?utf-8?B?REY0U3FIV0VBK2RHVmdUV0czL2hQeExmY2VwVXdKajRUenlEdUFIYjBtWUgx?=
 =?utf-8?B?K1VWazR2Rkd1YkJZMmN4QVhBV0RiOHJnL09TcnZnZjRpSmVHOUE0WmljNnZK?=
 =?utf-8?B?a2krV2Fqa3pQM1pOeGNNUWRRdHRQcWh5dnBWZW1TcDBibk9GaUpueG9MZk9j?=
 =?utf-8?B?RThJUDZwNmNXQUUzVUdOR09KWE93NnVnNkI1THFadDAxQXkzWm1iNUVjYlVk?=
 =?utf-8?B?YmNpTEtRS3drQTNIZkx6OUtRVTdHTytDRlphYTFKckllZFFBTzNYeXJITThR?=
 =?utf-8?B?OHFUTkhRM2srS3VocmpVbmdsV3hxcEprTWJMTW1DU0FlZVg1Z2E1YmhvQTgw?=
 =?utf-8?B?azBzdE81Y0RLMXBtTUJ4UlhhSWN5WCsvcGgzVkp5a3BUbVRIMVNIZGxoRUpz?=
 =?utf-8?B?cDM5OXVCZHl2TmhreHRkOTJhYmFTWHE1TGxleFk5S1lnR3JDbHJ2aG9DaFRj?=
 =?utf-8?B?L2xpeFFGeE1LaW1aNEJmaWFtejQ4Q0VaREppdUFEQWo4Mnd1Q3VpMmd3bnpu?=
 =?utf-8?B?WDFwTC9DM3ZKLytLdWhKTFZsN3B3b0NrZjMyOG9ZdUZrcW85SlpDK0VXemZy?=
 =?utf-8?B?TCtwclNHM2RESThxRmE3TkRreXhUckExaXpxNmV3SnFEeCsxQmNyVmZJRG8w?=
 =?utf-8?B?eTRqL1NSdTNDNHZhYVZid0JBRnYxTCtaa0pDWTJVTVNqSS9hWThLVVdvenJJ?=
 =?utf-8?B?clA0YlBpNDVZWlBBa1NCeDRuVmcrVmlnV1RpMVBYYmRHQUl4aEd0QmpDT3dY?=
 =?utf-8?B?WGdhdjNjS05mM2diamJGcEgyZWw1V0w4a2dvVmF3bGFqZUlpcEFxSytWUDR0?=
 =?utf-8?B?QXhyK2lvSXd2MGpyRXgyNHQ0WG9takZFc2ZIOStjV1BQcURpYjJFQ2g3OWtm?=
 =?utf-8?B?TnltS3pDSXM3NFlDbHVrTEFhOHJUWWpUNCtUbGR1eXJtKzlyMG9USjl4RS94?=
 =?utf-8?B?QWlPbkRrVldpajV5WU1vODZIRHZvN29GYlE3K0xNaWtsRzdZVEw1UDVtUGF3?=
 =?utf-8?B?R25hTVAwUWtlRWhzVmpHdTl5amtybEUrenBCd0VRL08wVzM4NFJDMkQ2U1FD?=
 =?utf-8?B?TTZKSEtBZ2Zxayt4NEtjMGVoRTgrTzVNd1JFOWU3ZVpBTWNYNmVrMERWWU9y?=
 =?utf-8?B?NnhZRjhQK0ZoSHBRU0YwcHNlWDExSlpoaTV3bEo5ci9Sa1BqOUZJa1o2c0JJ?=
 =?utf-8?B?ZytMV0swbVlRS1RFNHBsSnVmblNtLzdMSUJEMkZweUtaTUsvSlVTRnc1YUg4?=
 =?utf-8?B?dnZLdkFtTmtuamYrK1NhTzB0VTV0Q0VWL2RLYktGUjFUR25QdUhNZW1ydHB1?=
 =?utf-8?B?Y0FjbkdWay9qdlpwZEdHSXdPdDNadk1JNFlCSU9lcGFNSFNuNjdQSnovVVR6?=
 =?utf-8?B?aUxPb1U1Zkd0eE0xeFRWNUVNMFdiblVhRlVMdW9hSmM3OE1FZHhWYVFicVZ6?=
 =?utf-8?B?OThETWx2M0x4S2E4ZmU0NzdMODFLRnlzNmtnaCtuSXU1c0pEb25oR0puYUlL?=
 =?utf-8?B?d21HTmUvVmM3SzhTU09TMmtMd1lIWUMxKzJxSzBqL0w0LzEvOXUyaEFpKzZZ?=
 =?utf-8?B?TEl2a2tNYUdieGhZd2RuOWVYaDlOL2VZbWVRcE9GcGtjZncyMVg5eDl3bXN4?=
 =?utf-8?B?RlZ3VnZtUmlIUUg1dXZIcm4xa2RBZXpnSmhzT3BSVTZuT0RUVm5VSzhWQlBX?=
 =?utf-8?B?TkVMOTJMdDNoTGpUUWUvK3JWWElJNGQ2UEdkZUk3UzVVUzMya2dYR3Q5bW96?=
 =?utf-8?B?cThTVm5sdjVYcXZEdE8rOUFIQTVCeTEzanpqOGFjaTZmWmNHYzBoTHRWSERp?=
 =?utf-8?Q?qlT6sigr5WzdYQShB+n0aksQm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB81C5E8271E84D9DF3DFE146AB1D40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a809a9a-332d-4199-062c-08db5b22ee74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 00:16:19.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9sqiwmrV0nnIfsdvCWy7ZdS6GeONNd9vHeaSAWQPgK6fbStflXUydnCisYcvtRmjmPSTL7PsqG3UNhsPpscJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_171626_918506_845EE094 
X-CRM114-Status: GOOD (  11.33  )
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

T24gNS8yMi8yMyAxNDo1MywgQ2hyaXMgTGVlY2ggd3JvdGU6DQo+IFJlLWF1dGhlbnRpY2F0aW9u
IHRocm91Z2ggdGhlIHN5c2ZzIGludGVyZmFjZSB3aXRob3V0IGNoYW5naW5nIHRoZSBQU0sNCj4g
d2lsbCByZXN1bHQgaW4gYSBtZW1vcnkgbGVhay4gVGhpcyB3YXMgdGVzdGVkIHdpdGggYmxrdGVz
dHMgbnZtZS8wNDUuDQo+DQo+IEZpeGVzOiBmNTBmZmY3M2Q2MjAgKCJudm1lOiBpbXBsZW1lbnQg
SW4tQmFuZCBhdXRoZW50aWNhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzIExlZWNoIDxj
bGVlY2hAcmVkaGF0LmNvbT4NCj4gLS0tDQo+DQoNCkkgdGhpbmsgaXQgaXMgYWxyZWFkeSBmaXhl
ZCBpbiBudm1lLTYuNSwgaWYgbm90IHBsZWFzZSBsZXQgbWUga25vdyAuLg0KDQotY2sNCg0KDQo=

