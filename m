Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01305C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 03:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QdkZA6FfHkmWvXPp0NX3aR1ttA78FgUypYPCtU67RWo=; b=VN2RqAe30Q5Rha3pPP4GhFr9RZ
	UtUFNNcVNQZKeGSkLB5l8R5fo7TvzFbclbYntieU1X/QaWkF8p0bkLBkVR6QingP54PPC+YHEHJvB
	slZQ5vr7++3kOsj9e/Gc7eOuX0TNYLmBblaLtEISe5aHcJT3Ex6AuuRdoYuYWgTqrO3FNe1W6uWuo
	/O8+IJJDa3YK0Rojx1ctdp8IntaVLcsNMB8uMc/LjhWh4w0miKCwuUOX2+ZYm8XWsH0uUrPgmzjGn
	3AesYn0gs1f2gBXXDm/wW3UfCb42s12pzguiZTnpSco+fmkVJZfqSs6RL0fkB3e4x5BqZzmZn65oy
	eCL65x1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSU5a-001LxT-1V;
	Wed, 24 Jan 2024 03:38:10 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSU5X-001Lwf-0g
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 03:38:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpquHxRd/i1Y6HmzBG2c0I2NdFfrFs/mXoeaNau0Rss6+KOfRwM5m7NvWjx7KuwmkRv6az8x8EyypO98kFQbjkP0Ujhbn+PARBq5YSWbssZBYV/3bRmUqkN3moVB55NQ3W6aOPD0tW0sTS13mLhKrSnF9OeNx8A0W0sukZ25BkEcbVQIM9+2VHU9zA1y9E7BYEhJr38RiI2RpHOnxsdhE1T+epswAJiCM0kwNndKiTh9pV+ccVqcTyLRWEZOzqqJr7sCca+KAnXuV6ic6E4hM1JOw2YONkwwdsWXaOkgY5WFCrFIFqXV9EGuxwYJvX3ftzhvT7b0RotixOW12UugcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdkZA6FfHkmWvXPp0NX3aR1ttA78FgUypYPCtU67RWo=;
 b=Sydd1om78/X4rRKtcjZ6hK5UpbTfMkaVJNxfc2nyBDpjrihwo+GpvWHWBTRP8VmI1ZeT8Z/Kn0q38eghGKACWgWUtobsrl6GcSIQd6pM+gVrCr1nZZt88x0/mmtD+ILBCrhnxIdcs0CJ+12O1qzTLwWmMOdvxPAtZg49AIL0OTY5BNDKKMhtsdTP7FxtQKGYrcT8uTjGCIWTuLhZwozn1sZaXli+GUegCh9AhT4w0m5EJY3g0hajGhPaJ4wO2ozJIW5Z9q1n/W5eCkPTEbrC3jWk0c73j4vYHctxMb2ukArYObAsLLNflk/BlUxcoYOx0zx6sUyA4A4o5laV7E2Vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdkZA6FfHkmWvXPp0NX3aR1ttA78FgUypYPCtU67RWo=;
 b=Au2wX9u6e3wdfnO45pd3D2SrGbu5nyiW0fyrO6rtDbZeTE+lO7szbe/GO1YsoijYkaQzWwm/J+p3Z5oj9kCSvlukQBhmUNBxf+zeKq0xX1xOuPFVcGa4EVnR4ue9RBSTjEfMGUlPouB+XGGwRLYlNcCvKkMF3Cv3JZEdKhQ9At351EwLMDie8sKuL1+alPzWu10MNwBdmR5Xs/3T3zCwzvmvX0omhEz9ySUfKQ1vqCWR9lyzQjPxPZjOguhdMcT3o8/YXXY24UchCTVc3fr6owTf2RWUr+2Xf/GhExtz2iVY0+B87L0Xm71Fz0i3mCa0DLFPIcuRTZPbF+lnxRebiQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 03:37:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 03:37:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Alan
 Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHaRCI5o/0gWRRNpE6eYNPv+sWFV7DUMKEAgAk2uICAAK87gIAA3ueAgAhiSoCAAQ1mAA==
Date: Wed, 24 Jan 2024 03:37:57 +0000
Message-ID: <d23d6b6e-a2ff-4938-9f06-7da9eb07f64c@nvidia.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
 <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
 <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com>
 <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
In-Reply-To: <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: bf882c84-b9f3-44ed-ff0b-08dc1c8ddb41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xFbAugj1PL5/rNuRaE3EHRSxUjm7cqc3EOdxoqvqjniduTqUu2hVftvMokCpsFi/VT9fIURxWlZ3Vmcmkk+W/AxIujd2tbpP0H9blMxc3R8RY5VcWHtDfIxKEqM3+8cSxAn0IIVu9BXWY4p3hwXCShtjAbeRdDQbaA5LgPDoM9n6QYZ38Jh9Y40hEANO2NrYaACe4gDUz0x8Ku12wKHptjcxMQi5B5k9ThY6GCuXe0TJ0KbJmsklr5t5etPfcjTnM/tIxyp3RSqFL+04+wnVXGqkhAq52gNtUL8bfWBTMPzzs6r91oTnwJUcxoYN3mQuEBFypvBR98h+1NLSJ2hv6i8qYlt3nAeOq2vtV4YDq+4I45m2Ppv6Jzlg+kN3rBcbMzy9PKHH4SYBPAIzARmr893S/4AhSpDLZ52fHCNRDMeerzDQMSIsh1l7Di0z6kLWDuWxMVIoHkEYVtcFC6I4DrY8GDJG+sCa+A3eogKm4T5WnKDQkH2Em8zVwX/K6g9FjH9LFLzSPDq8asEt5zODR54bEo4VbCiZ9Kl/CB73pslCZD8U7m7cXOnQUEk6DohWWKCV+RY8wOpvdcu/AbHjXQ8WTCflFDhoa5W1Jr0ahmS0Qz7eoasp8j8cGs2w7lwB10RwHnvt+5AweXjhcAarE2nRVQl/ePKAURnwIujD5pSxfncdxynYRW34GA2S+gO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(478600001)(6486002)(71200400001)(38100700002)(83380400001)(4326008)(8936002)(122000001)(6506007)(8676002)(2906002)(26005)(5660300002)(86362001)(66476007)(31696002)(66556008)(64756008)(2616005)(36756003)(53546011)(41300700001)(6512007)(66946007)(54906003)(6916009)(66446008)(38070700009)(91956017)(316002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjg2MlBGMGpNamswSGdmdlQzOHRPNk5hUVFWUmk4Snp2WVZMcWFOd0lZeGhR?=
 =?utf-8?B?cWwwUzk3bUpFMDU1RlR6ajdKQ3l4K3JVYjBwK3AwS2tzL2sxSGdTb0JiQytJ?=
 =?utf-8?B?emtqZjNYNjFpU2piUDRzUm1GdWQ2QWFFMVZNY1lhNVQrekpncDcvZmF0c0E5?=
 =?utf-8?B?TFdLM2Ruek1sZzdtTEQ2ZGFvWGdrQjY3djZqT0k5aVZPckZKSWNGdVJkVXQ0?=
 =?utf-8?B?Y001MzQ1YURRTWRnTStTRG9aVFNySGZKU0JGRXVJV3BHcnc1RnlDblhLYUtZ?=
 =?utf-8?B?d2xWOGI0ZTk5UWtaZkJrdkpzNjBmc1BXSEJIeThGRGNjWTlQbWRwQTB1Qndl?=
 =?utf-8?B?ZWNEODhiREJIQWt1UVgrWFF4VXpISEFNbXNTZlVBMzhqYW9jSmU3R3ZxVWtx?=
 =?utf-8?B?UXZ6ckxMOXdzRm96NU9jU09jUnVJUS8rRXdTaG04eTI0L3o4Rk1Fb1QvOElC?=
 =?utf-8?B?UVJEOGhBNWc3ay9ZK3FrUVBoUk8zOXhySFpYcFNnNUJPeHhYZ0x2VU1Ecmh4?=
 =?utf-8?B?MHJvOEZMZjFucjVieWkwNDVlT2VUREtXR1Y1TlA5ak1VaVIxclYzeStoYWtP?=
 =?utf-8?B?RDM0Uk44UlJINWlFZWh1UjlhYjZodjN3cDNqdS9KNEtZbHMxaEV3N0oybzBK?=
 =?utf-8?B?NnFCa203M0RlOTdkY055V2E2V0lkMTF3UjkzZWxhc09BOEJjTWZGZnBMOVAr?=
 =?utf-8?B?TUNSb1hCODVaK2Y3MU1LaHEzZU9pYnpwRjJUekV2NkkrRm5jK1pieXBJWVJY?=
 =?utf-8?B?cEZ2MnZtZ1lFN1AzNlRxZFNnN1lVdVFxM3dIME1OdE45WVdRUys5bzY5WFV4?=
 =?utf-8?B?QUdUQ3o0NERrZ2s3SWN6a21ZZXQ5ZW5zTlY1OTdmSlpWekhwSUVTMmZlZG5B?=
 =?utf-8?B?MWdJQkVURjJQRDdoZUQ3bHRoKzNGZ3hvQ0FGZnpDT1E4ZldlaG9FZW5CbHBr?=
 =?utf-8?B?L05xRm5lRDJMeUY2SUJaRlkzb2QxNEM5ZzZGT0Vrd0xnV0x6VDNzOVFYNkpD?=
 =?utf-8?B?WFhkREVxZ3VFajBxQk5NWllVc2JmVDYyZ1JYNmNicld6VWlaQWExZko5eXRP?=
 =?utf-8?B?UC9zUG5tUHBxRitoclhkTUNOU0JxYkFDR0gzOUlPZE5mTWxXVy9tTFRDMnBR?=
 =?utf-8?B?N3ZrREN0Nk9ZeVR4a2d4dkF5MDdTYWYvZWhvS0dBeU5nZFNQNXRYYy9zb2cz?=
 =?utf-8?B?Q3RXMEViM1poM1Bja3UyN2dHUGRPZzVHOFd2NkRwR3cyckN3MUdxM3JXNlJI?=
 =?utf-8?B?VTFsK01mc2k4Z1NSNGgxT1BwRHFIaVNKeUVOb2JaQnV4RTBkRTJoZDU2M24x?=
 =?utf-8?B?ZDhGN211eTdEZEFLZU9UaEJ2ZmlUNzViNFZYUUZSaW5qQ29UZEZoRndDZzZz?=
 =?utf-8?B?VVpkNGhqenJrSS80TzVJa1dnV0dzK2Y0UGZ4TjhFNjBpYzZjRzdBRStvUDNJ?=
 =?utf-8?B?anVPeFpBWWxva3FtcUV0VHpMK2hHbkZKeTJOZVZzQWRYN2lsQU1YYlFwTzF1?=
 =?utf-8?B?NWtTRjQ1bWhxRjRTRzF1UkJCMCtxazVYVWJLaWEzdmdYZ3A4ZVNjekpnKzZB?=
 =?utf-8?B?OXozSjc5UGxrbE5hSGF1dUhUQXNidzF1a2dmb0RxZmI3Smpia3QvTG1Pa0hP?=
 =?utf-8?B?K0NZN1A0ZTJORzJ6RzJ3cVhnWEM4NHNtWWhuTU5XakN3UjZya0VsclJEalA5?=
 =?utf-8?B?cmo1aCtFNmJGNGpualo1VGxMeDUyMGYxU01nZEtCMG5UNU5FWUl3QlVSM245?=
 =?utf-8?B?Z0d6VVg3MlRvV01namUxLy9wRVZQNW8wd0tDdWJQYk4wWHZyTHRQOWdUNnJm?=
 =?utf-8?B?dkVFZWJLZEtRbS9CQUp6WjNvZXh0b1B5cEVVZ0YyNk5naDg3NTRoQko1M1F3?=
 =?utf-8?B?aDlqN1JCYWdiUjVrelpSZ2ZpRU52WWVvNjlPL3E4QzhXVklqVXl3cUlWVkt2?=
 =?utf-8?B?L1NJcE82S3g4MHp5U1pZZW9MaXVrVDhEalM0V28vMFhhNjRUMVlvZFpZU1Rv?=
 =?utf-8?B?Sk04QWdGMnNsdTg1TEdLYXJONk1uT1QwTng2RDJwVnZUWHU2cDlpNkJOYlZw?=
 =?utf-8?B?MzFtRVM0Sy9xTm5lU3RmaVJ4bC8vbkRVQXEzdE5Ja2t1S014TGdLbXJ1UGxQ?=
 =?utf-8?Q?xlF9emvCJRgTZ60rATowQKmBm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32E02C56650A94C93726F78E58EB625@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf882c84-b9f3-44ed-ff0b-08dc1c8ddb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 03:37:57.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VICXO9OHuYyDG2Rlt8mpQbAE67XCg5nxTW7wTjPkIKARgEACy2ZmUHy5fs0RfSfpP3gr5kWzwfrhBM4rfuEmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_193807_297104_4EB6D28B 
X-CRM114-Status: GOOD (  20.37  )
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

T24gMS8yMy8yNCAwMzozMywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4NCj4gT24gMS8xOC8y
NCAwNTozMSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gU2FnaSwNCj4+DQo+Pj4+IG52
bWVfbXBhdGhfYWRkX2Rpc2sobnMsIGluZm8tPmFuYWdycGlkKTsNCj4+Pj4gbnZtZV9mYXVsdF9p
bmplY3RfaW5pdCgmbnMtPmZhdWx0X2luamVjdCwNCj4+Pj4gbnMtPmRpc2stPmRpc2tfbmFtZSk7
DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoCAvKg0KPj4+PiArwqDCoMKgwqDCoMKgwqAgKiBT
ZXQgbnMtPmRpc2stPmRldmljZS0+ZHJpdmVyX2RhdGEgdG8gbnMgc28gd2UgY2FuIGFjY2Vzcw0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBucy0+bG9nZ2luZ19lbmFibGVkIGluDQo+Pj4+IG52bWVf
cGFzc3RocnVfZXJyX2xvZ19lbmFibGVkX3N0b3JlKCkgYW5kDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCAqIG52bWVfcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkX3Nob3coKS4NCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICovDQo+Pj4+ICvCoMKgwqDCoMKgwqAgZGV2X3NldF9kcnZkYXRhKGRpc2tfdG9fZGV2
KG5zLT5kaXNrKSwgbnMpOw0KPj4+DQo+Pj4gSXMgdGhpcyBuZWVkZWQ/DQo+Pg0KPj4gWWVzIHNl
ZSBleHBsYW5hdGlvbiBiZWxvdyAuLg0KPj4NCj4+IFsuLi5dDQo+Pg0KPj4+DQo+Pj4+DQo+Pj4+
IMKgwqAgwqBzdGF0aWMgc3NpemVfdCBudm1lX3Bhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZF9zdG9y
ZShzdHJ1Y3QgZGV2aWNlDQo+Pj4+ICpkZXYsDQo+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpi
dWYsIA0KPj4+PiBzaXplX3QNCj4+Pj4gY291bnQpDQo+Pj4+IMKgwqAgwqB7DQo+Pj4+IC3CoMKg
wqDCoMKgwqAgaW50IGVycjsNCj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoCBib29sIHBhc3N0aHJ1
X2Vycl9sb2dfZW5hYmxlZDsNCj4+Pj4gK8KgwqDCoMKgwqDCoCBpbnQgZXJyOw0KPj4+Pg0KPj4+
PiDCoMKgIMKgwqDCoMKgwqDCoMKgIGVyciA9IGtzdHJ0b2Jvb2woYnVmLCAmcGFzc3RocnVfZXJy
X2xvZ19lbmFibGVkKTsNCj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPj4+PiDC
oMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4+Pj4N
Cj4+Pj4gLcKgwqDCoMKgwqDCoCBkZXYtPmxvZ2dpbmdfZW5hYmxlZCA9IHBhc3N0aHJ1X2Vycl9s
b2dfZW5hYmxlZDsNCj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoaXNfbnZtZV9jbGFzcyhkZXYtPmNs
YXNzKSkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybC0+bG9nZ2luZ19lbmFibGVkID0gcGFzc3RocnVfZXJy
X2xvZ19lbmFibGVkOw0KPj4+PiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX25zICpucyA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPj4+PiArDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5zLT5s
b2dnaW5nX2VuYWJsZWQgPSBwYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQ7DQo+Pj4+ICvCoMKgwqDC
oMKgwqAgfQ0KPj4+DQo+Pj4gV2h5IG1peCBjdHJsIHdpdGggbnMgc3lzZnMgaGFuZGxlcnM/DQo+
Pg0KPj4gc29ycnkgSSBkaWRuJ3QgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uIGNsZWFybHkgLi4u
DQo+Pg0KPj4gSW4gdGhlIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIHdlIGdldCB0d28gZGlmZmVy
ZW50IHN0cnVjdCBkZXZpY2UgDQo+PiBvYmplY3RzDQo+PiBmb3IgZm9sbG93aW5nIGNvbW1hbmRz
IGluIHN5c2ZzLCB0aGF0IHNldHMgc3RydWN0IGRldmljZTpsb2dnaW5nX2VuYWJsZWQNCj4+IGZs
YWcsDQo+PiB3aGljaCBpcyBhbHNvIHVzZWQgdG8gZGV0ZXJtaW5lIHRoZSBsb2dnaW5nIGluIG52
bWVfaW5pdF9yZXF1ZXN0KCkgOi0NCj4+DQo+PiBlY2hvIDEgPiAvc3lzL2NsYXNzL252bWUvbnZt
ZTAvcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkDQo+PiBlY2hvIDEgPiAvc3lzL2NsYXNzL252bWUv
bnZtZTAvbnZtZTBuMS9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQNCj4+DQo+PiBudm1lX2luaXRf
Y3RybCgpIGFscmVhZHkgc2V0cyBkZXZfc2V0X2RydmRhdGEoY3RybC0+ZGV2aWNlLCBjdHJsKS4g
SW4gDQo+PiB0aGlzDQo+PiBwcm9wb3NhbCBhYm92ZSBjaGFuZ2UgaW4gbnZtZV9hbGxvY19ucygp
IHNldHMgdGhlDQo+PiBkZXZfc2V0X2RydmRhdGEoZGlza190b19kZXYobnMtPmRpc2spLCBucyku
DQo+Pg0KPj4gVGhpcyBhbGxvd3MgdXMgdG8gZ2V0IHRoZSBjdHJsIG9yIG5zIG9iamVjdCBhc3Nv
Y2lhdGVkIHdpdGggdGhlIHN0cnVjdA0KPj4gZGV2aWNlDQo+PiB3ZSBnZXQgaW4gdGhlIHN5c2Zz
LCB0aGVuIGJhc2VkIG9uIHRoZSBkZXZpY2UgY2xhc3Mgd2UgdXBkYXRlDQo+PiBsb2dnaW5nX2Vu
YWJsZWQNCj4+IGZsYWdzIGZvciBlaXRoZXIgY3RybCBvciBucyByZXNwZWN0aXZlbHkuIEluIG52
bWVfaW5pdF9yZXF1ZXN0KCkgSSB1c2UNCj4+IGN0cmwtPmxvZ2dpbmdfZW5hYmxlZCBhbmQgbnMt
PmxvZ2dpbmdfZW5hYmxlZCBiYXNlZCBvbiBhZG1pbiBvciBpbyBjbWQuDQo+DQo+IEkgd2FzIGFz
a2luZyB3aHkgc2hvdWxkIHdlIGhhdmUgYSBzaG93L3N0b3JlIHRoYXQgb3BlcmF0ZSBvbiBib3Ro
IG5zIGFuZA0KPiBjdHJsPw0KPg0KPiBXaHkgbm90IGhhdmUgYSBzaG93L3N0b3JlIGluIG52bWVf
ZGV2X2F0dHJzIGFuZCBhIHNlcGFyYXRlIG9uZSBpbg0KPiBudm1lX25zX2lkX2F0dHJzID8gVGhl
biB5b3UgZG9uJ3QgbmVlZCB0aGUgYXdrd2FyZCBpc19udm1lX2NsYXNzKCkgPw0KPiB0aGUgbnMg
YXR0cnMgY2FuIGFjY2VzcyB0aGUgbnMgaW4gYSBub3JtYWwgd2F5IGxpa2UgdGhlIHJlc3Q/IE9y
IGFtDQo+IEkgbWlzc2luZyBzb21ldGhpbmc/DQoNCm5vIHlvdSBhcmUgbm90LCBJIHdhcyBqdXN0
IHRyeWluZyB0byBtaW5pbWl6ZSB0aGUgY2hhbmdlcyBpbiB0aGUgcG9zdGVkDQpwYXRjaCBndWVz
cyB0aGF0IGlzIGEgcmlnaHQgd2F5IHRvIGdvIGZvcndhcmQgLi4uDQoNCi1jaw0KDQoNCg==

