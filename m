Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B10C6FD18
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Mar 2023 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKtmhP8Rj2GP8JGOfdLYgDxLvEHWWF1FHciRfwMBQyg=; b=uD6Pvqh0Nl7+d0e6bAXzPShCWr
	G3l/wMas2tfr/9kqZBGaruVk2pUqxj/FnKpYf1lvc178tEBVEbWOS99LKgEE3564H+gt7xvQu997/
	lrYgfWZA1M7PUC9/i0QJ9tiLqhujVAu6jDvyZIyBgpQJpUqdfWGvp9jgBxck7HKGdnDYwXTmGAWaX
	LHDvN3SsQ6RFI4t7whx2gWYc2rovZy7PEc+/IfxQW/BwzDorGzkHWnZ6Q0+oFhdCUmZj1uZuL/yr7
	g9OIQ0kc/Rd60MMye7N6P14Jz4GcS6bOlBSChw5Ikg5brfyzKDd+A/gd7hQxXClH+Lv12xVS85cnu
	JSKIU6Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYvu2-00Ag9h-Ih; Sun, 05 Mar 2023 21:28:22 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYvtz-00Ag94-RY
	for linux-nvme@lists.infradead.org; Sun, 05 Mar 2023 21:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/+oTpMV8e001i/CRWezXPpcPY8yld0jnPYQldGv1rH1QwbC4P5wsDOwbUP7gXLJH0ogEGwPtInUJrFXWT+2Quje9V3yUCLBU2Qpdbvxd5b2UoVQDXz5Lmfnw3s21aXN+i8c068/FYofu4g1ChF4yBszpLUi3zlycZvtQOzu6F/WNa0J16Co47SakyMwlFVN3qmvM/JCPI2AqCuMkzIDqah5WU0Atq8/FBAB2RG/R7EyiVvEzcrfd9QjPL0A8VNFqRFkaJSK3JVu5tllFCPpOUE0oGbJSm5xIkBHIUXRr2uMC10U4TQpPZpdCC3L2VGQe7w9vBR5cuEbJPsWPcUwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKtmhP8Rj2GP8JGOfdLYgDxLvEHWWF1FHciRfwMBQyg=;
 b=fIlx4y59d7iezgknRrpG7dN5P0tC5iL8qmkutNG116/5i2G4iFAy5tVO2Cr2snLAedC31cGelbCbMv0kRWsyB9EdxoFiwVv8PoduOG+NRpFrlIrzLgY9zHnPRB+PJauk6uLT0+kIo31ezHRO1CEe1DDj9wRDiMU/rGAkm6SZk4lIF7a4ejVdB8ZqVoIxCXu6U6JWXMOVu+YDN0+hTWS0ANId8TDwAYen7CXEWkGpNrqMiaSq6flLWHi1Vxdl3/GbDyohCKn2PFNYZrnJbb4/UO5DNRhpUOoat+dCu0cXMFBl2/82hg2MY1qi5VsqNOuJqu8FLzmsIcUkiJxzaIiYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKtmhP8Rj2GP8JGOfdLYgDxLvEHWWF1FHciRfwMBQyg=;
 b=f5qTixMg0hf0KxQrCXWSJW48MmdlibH24dnFGVCpcQAc4XZd4wjZEcq5o1MdyRMhq/ck4YJeryrwZXFqDUgX0RXjsVTCC4mVUft/GgOXBbCXC9RHIzujcoF9v/u4ir3Vrpr7T5AYIMni54IHdlZZr8Ckj/up/+WZSTMQ6mwefEX/8GAbhhtcYBHK/BD8Uel0TxP6zCDtJ6U1tdDTy0fK3diLZD07oUP2wa+R+xdhVuoaexPFjdJnERHl56JOi591qSe+i9bSbV4sIOKBrxDK65nOSjgAgOYt7RZ9CXdV8XGG459xU5Eb6jmvyqSDD8ir2jyaXzDVraHP7A2tvLMPvw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Sun, 5 Mar
 2023 21:28:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.025; Sun, 5 Mar 2023
 21:28:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Mike Christie <michael.christie@oracle.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "james.bottomley@hansenpartnership.com"
	<james.bottomley@hansenpartnership.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v4 10/18] nvme: Add helper to send pr command
Thread-Topic: [PATCH v4 10/18] nvme: Add helper to send pr command
Thread-Index: AQHZSHgd2MJJ6g9ezUqZKojk4EqGsq7sweAA
Date: Sun, 5 Mar 2023 21:28:17 +0000
Message-ID: <b4b5feb7-521b-fc5e-8c68-a05bea292ebf@nvidia.com>
References: <20230224174502.321490-1-michael.christie@oracle.com>
 <20230224174502.321490-11-michael.christie@oracle.com>
In-Reply-To: <20230224174502.321490-11-michael.christie@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB7864:EE_
x-ms-office365-filtering-correlation-id: 3c392887-fd09-4c97-960b-08db1dc08978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  oFD2Q+jI49t2G5MZAJswVYpRAaNws7RxxyHoCAIchu20mc3T8+n6SGpu3h7ivLQfGaIECijBFeYWRE31vgm6qOPFz3Qun3JoM8/gUoojXJ8uSk3XIy/xor3uxh7cjqbTmkXjk1GSCqEt+778xVgPy1OLaxKFdm1Op3828D92tIckoEHJGrLIIuef+ULhUles+b13oNzT4Ha/+MrdrZIBseTkWtMBQZmPHTgUWAUD7h3IVeJ764q6lyCxomSykt0Uu8v2BsqgGgr2UCL6PJqCqyPb+/dZcf3uMNdm/X1rNmun9Z34ezz3pHKtnHxM4mrvHqpFt5NEUy9YHmq2hdcJ1b0rpQaZCe0nCPzq7YmsSf2pXlML4C3ZEEQQhdLd41mjXJwYPV69uBdVSWIDuozGGty6djD1f+zU91RAaUVxlSb8iDOPoa7Nbh9GfsUhbQBSBGAB/pnyNyvrCEUVEJ0FQFUrLLSyXt1Y8ZJphNTLo9Hu1BCZA8wHN6e5fvzGVhi4KWF8y5hh52NGL5Z42EknxCNCCBJERBHIZMwm7uZ4LU4k3YyPLQEAHIKzQbC8lXinpFV43Kq1hj3mBISdKpV3MJfRv2S0QqJIx6dktfAKVLFloG0zGzQ1AJIGMYHgWtoSfcdd+n2aHx7HYD7L8Ar4RBV9tSul4opMDASbf4VZiifzA55A2jmfjAO+xC17KQ5cWXSWBvtra6OAjw1yNwmGnl8O9+ssVgsEiaVWDXgVxcpQkIePEl32zChO+pnmvaWUZyQTRRCzecT6XzKpNrjJZw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(186003)(71200400001)(6486002)(38100700002)(478600001)(91956017)(66946007)(110136005)(83380400001)(64756008)(76116006)(66476007)(66556008)(66446008)(8676002)(53546011)(2616005)(31686004)(316002)(6512007)(6506007)(41300700001)(8936002)(7416002)(5660300002)(122000001)(2906002)(921005)(31696002)(86362001)(38070700005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YUs3ZU4rNjVaUWxXTVFoQnFjWmk0TjVhRDJyOGJIZXY3VHhIRnZmL2JzZnhY?=
 =?utf-8?B?SEtVeWh2YmhBdWFpUVJTektxSDg2aklrZkVrb2NOcWVsR2hVcFMxTFczdDk4?=
 =?utf-8?B?VTAzelJ0cHl6Sm52c2U3a00ya3U3TlpCOGJwdmtGcnNFbnVUVFdpajVpYi93?=
 =?utf-8?B?K3FGS1NaTndpb1J0aEZGMjZZYWxqZ29RZVZxaExhWmgxMVNyZi95NlFma1p6?=
 =?utf-8?B?WTlsNnhzdHM2bFFmL0dyNTh4eDhUKytRbHM3cHhac2o2NUVVSHBnYVZDbkdo?=
 =?utf-8?B?WGR5TVZKTTFsSTJNWGZINmdzVzJiQzlZU2tXT3JpYUQ1OTczdyt5K3hVd2pw?=
 =?utf-8?B?ZXJzNGRHQUxYQVhOTTNDRGpYOGlBRFdZR01zeVkxbCtjeEVOWUpHK1h3WlNs?=
 =?utf-8?B?L2VlZ1pMaVV1eVZieElzRnV2UWhOVk83MFk4VFN0ZXk4S1Y1THNZWlNLZW9h?=
 =?utf-8?B?N3k3SElKd0VYSXhiUHlTQ25USkpkdzVMaE9lU1U5c2VvdUhrYS9yUktCT3dP?=
 =?utf-8?B?bVFURUpxMFFUVnFPTFV3Zjdjdk5acmtUTkQwOUcyODVRUUVvVFBKSjhrT0NC?=
 =?utf-8?B?eFA0dDIrYkZWNTdRSEh5aENFVncvWVFndmhDVFdCL28yczVwTWcycGJHclds?=
 =?utf-8?B?T2lkckxVelFNWVltNkl6STlsdTVVZjVBTzNOcEdsVnd5RmF2M1RHcnRuRHAx?=
 =?utf-8?B?Z3pnb3g0aloyZUFBTnppS25qb1Q3VmFDOGw2SXd0dDBIOXQyRlZRZGY2cnZu?=
 =?utf-8?B?TUZpMWF0alJZVmxlZ1AyVExKdFgwV1RpNzJMWWRCQXE2RzkyUnpWZzhkdzN6?=
 =?utf-8?B?RmZFSUFPTUhnUGRjWTI3TVhIV0VoWlpUc0NrTHlsWE9HVDUyNEtpTGlPc2cv?=
 =?utf-8?B?U0VqVk5qT3RnSnJIR2xkUjRDWVZvZzN5dkpjSHkyVUF2QmcweUhtMkdxbHFB?=
 =?utf-8?B?OXJRODFJT3BvUVlmeWo1V0luVkpwRlNwUmxVWi80eUo2WnhiYTREMUdvUnYr?=
 =?utf-8?B?WkRGQTNMZDlpVXNBT0xuNGtUMVBBSkszZE1BcUpRaGV5TDlhTEJyY01KZURM?=
 =?utf-8?B?YlN0UUtIcFdoYVV4QTNwS0lBWDZ1TWZKMVY4LzRaT1RRMHRhSUJYN1E5U0ow?=
 =?utf-8?B?NkMyVUhFa014NUFVNjRBTVRJMWFrZXpnRHU0cThIZEhYcVZUdk5La0xYak9T?=
 =?utf-8?B?bGxVcHZPMTk2MVUyR3JCc0VLdVRaNTI3ejhvQ2x4N0krZ3lRSWdHbllnU1k4?=
 =?utf-8?B?THRhZXFPUGQ0SVNKaWVub2RGejlwTUY1Ty92NWdGa3V5SjRGOFVkTEVyN0Qw?=
 =?utf-8?B?TzVzeW1HcmFLTTlCZStwdVJ5aytOOVdGVUtBRVJ3aVVIRmdVU1dZUjJEZzBY?=
 =?utf-8?B?R2pMVnl2S2FlNjM0RDZvWWJVMGFWTFVhS2xzczBHOEZzZUp0Q09xTWZjRHhr?=
 =?utf-8?B?aUtNSWRwK2NuZFg0Y3Q2WXJZeFp0NnZKbWt2R0RiUDJoME5xak1CWXI3NkNm?=
 =?utf-8?B?djFNa1Foc3llbVhvUmhIZG1VK0JKMnZsemtIUHlCSHpxZ3hIZy9tQnRuRGcx?=
 =?utf-8?B?WXVCYmxPNnZQcnNqQlhVN2RQNGRrYnFrdVBWZ0k4S1JBZ3o1bUhXUE16L3A2?=
 =?utf-8?B?T2xhUTEvYzg3MmtQN1duckVsRlRoamtGa0VMVmJ3QXltNlFmMjNzTWI2RTNL?=
 =?utf-8?B?T0d4WUVZZ09tcWxSbndsY0djRFdKNjVkeTBoMkx6VFVFbWU2S1AxMUoyZFV5?=
 =?utf-8?B?OXZwbG5hMHBoOCt5R1NUaEswSUZSS2VqZGN4d2NIMlJhRGFjc1N0bW90c2Mw?=
 =?utf-8?B?MWRQZ3oxcUZRWit3VStLYWNDS0N0OHcrSW5QRklJQ0E5RytGYVBxN2tjbzUz?=
 =?utf-8?B?NnlGQUFFYjhaNi9US3ZSSGw3WFplSUJOUWVtN3NEZ0c3cU5qL3hTWlFPSjJt?=
 =?utf-8?B?ZkV6VUo5UEZCWVozMitqbk1neWM5OGo3NmhLVXorWmxudG9pblY4NVJxZy9h?=
 =?utf-8?B?dy96VlhxekRpcWx5cDhNcUU4MGkwQWl4NTY3UXJLRlQ4RGloRk1VZjArT1lh?=
 =?utf-8?B?TmZETGZyOTNqbzJmeWJxdkczUmNCUHRML3E4YWRLNzZnalZvUGhWSjBOZ1Jy?=
 =?utf-8?B?Y0pXWFdjZEN2TE5aSVhZQmlrWEpCSDA1aFVEOVQwazFMdHZaTGJGRlVQcW0r?=
 =?utf-8?Q?fuW4wDHbYNhk7qrdQww01r+SUTqwf8cVbxSwPiJ+TwGF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F437F6FA2D8B43BEF11B000F99E526@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c392887-fd09-4c97-960b-08db1dc08978
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2023 21:28:18.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odQPkmqF9wWFzD1K0Mqja0u6bgYjOOpLW3h0pN5WWUPGpMENNhUh+XiY5rabS3t2jPCA5JwCs3BwbI/eT4KdxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_132820_038029_5A613C91 
X-CRM114-Status: GOOD (  17.21  )
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

T24gMi8yNC8yMDIzIDk6NDQgQU0sIE1pa2UgQ2hyaXN0aWUgd3JvdGU6DQo+IE1vdmUgdGhlIGNv
ZGUgdGhhdCBjaGVja3MgZm9yIG11bHRpcGF0aCBzdXBwb3J0IGFuZCBzZW5kcyB0aGUgcHIgY29t
bWFuZA0KPiB0byBhIG5ldyBoZWxwZXIgc28gaXQgY2FuIGJlIHVzZWQgYnkgdGhlIHJlc2VydmF0
aW9uIHJlcG9ydCBzdXBwb3J0IGFkZGVkDQo+IGluIHRoZSBuZXh0IHBhdGNoZXMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3ByLmMgfCAyMyArKysrKysrKysrKysrKy0t
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3ByLmMgYi9kcml2ZXJz
L252bWUvaG9zdC9wci5jDQo+IGluZGV4IDI2YWQyNWY3MjgwYi4uN2ExZDkzZGE0OTcwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wci5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3ByLmMNCj4gQEAgLTI3LDcgKzI3LDcgQEAgc3RhdGljIGNoYXIgbnZtZV9wcl90eXBlKGVu
dW0gcHJfdHlwZSB0eXBlKQ0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgaW50IG52bWVfc2VuZF9u
c19oZWFkX3ByX2NvbW1hbmQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4gLQkJc3RydWN0
IG52bWVfY29tbWFuZCAqYywgdTggKmRhdGEsIHVuc2lnbmVkIGludCBkYXRhX2xlbikNCj4gKwkJ
c3RydWN0IG52bWVfY29tbWFuZCAqYywgdm9pZCAqZGF0YSwgdW5zaWduZWQgaW50IGRhdGFfbGVu
KQ0KPiAgIHsNCj4gICAJc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCA9IGJkZXYtPmJkX2Rpc2st
PnByaXZhdGVfZGF0YTsNCj4gICAJaW50IHNyY3VfaWR4ID0gc3JjdV9yZWFkX2xvY2soJmhlYWQt
PnNyY3UpOw0KPiBAQCAtNDMsNyArNDMsNyBAQCBzdGF0aWMgaW50IG52bWVfc2VuZF9uc19oZWFk
X3ByX2NvbW1hbmQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4gICB9DQo+ICAgDQo+ICAg
c3RhdGljIGludCBudm1lX3NlbmRfbnNfcHJfY29tbWFuZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0
cnVjdCBudm1lX2NvbW1hbmQgKmMsDQo+IC0JCXU4ICpkYXRhLCB1bnNpZ25lZCBpbnQgZGF0YV9s
ZW4pDQo+ICsJCXZvaWQgKmRhdGEsIHVuc2lnbmVkIGludCBkYXRhX2xlbikNCj4gICB7DQo+ICAg
CWMtPmNvbW1vbi5uc2lkID0gY3B1X3RvX2xlMzIobnMtPmhlYWQtPm5zX2lkKTsNCj4gICAJcmV0
dXJuIG52bWVfc3VibWl0X3N5bmNfY21kKG5zLT5xdWV1ZSwgYywgZGF0YSwgZGF0YV9sZW4pOw0K
PiBAQCAtNzEsNiArNzEsMTcgQEAgc3RhdGljIGludCBudm1lX3NjX3RvX3ByX2VycihpbnQgbnZt
ZV9zYykNCj4gICAJfQ0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQgbnZtZV9zZW5kX3ByX2Nv
bW1hbmQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4gKwkJc3RydWN0IG52bWVfY29tbWFu
ZCAqYywgdm9pZCAqZGF0YSwgdW5zaWduZWQgaW50IGRhdGFfbGVuKQ0KPiArew0KPiArCWlmIChJ
U19FTkFCTEVEKENPTkZJR19OVk1FX01VTFRJUEFUSCkgJiYNCj4gKwkgICAgYmRldi0+YmRfZGlz
ay0+Zm9wcyA9PSAmbnZtZV9uc19oZWFkX29wcykNCj4gKwkJcmV0dXJuIG52bWVfc2VuZF9uc19o
ZWFkX3ByX2NvbW1hbmQoYmRldiwgYywgZGF0YSwgZGF0YV9sZW4pOw0KDQpiZWxvdyBlbHNlIGlz
IG5vdCBuZWVkZWQgYWZ0ZXIgYWJvdmUgcmV0dXJuLi4NCg0KLWNrDQoNCg0K

