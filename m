Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D84C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+32/fiYDgjJlRZWYVHTtnLOBCy70EKZ58GkZDAv+cd8=; b=KBH7mf8KXlhFz2HGS7j2/NKv3m
	i6WKMgDdTyjuyeN+cAr2ZIIA85uSAUQxBcmvr4GBCfsBG/ey/RKOvP9ONWEAIdUW2zg3vyW03CJ+w
	qvHIpNUSeYg2ZEBRudDQAV1wIsNj7Svp9q2G5nvRu8cHRiDcAE6tG6Ksi9rQuiA4x8lGfgDSFATff
	iOqUEju4kzPs3B67wdhX5kin8uHdFsRZS3Y/yU0WJ1ql2wvsBDxt0qVRwXeEDfOFOvYh0OE4aMfUP
	BQCymbkOx0hSGNDWBrF4KiMqDbXWOvXycqtEzLwqrwJ4r/tpt8zWO0v89KxP0o/G6sdjgraiACJt2
	mE3Q2T4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r07Fx-00Hawe-0V;
	Mon, 06 Nov 2023 21:35:37 +0000
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e88::62e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r07Fu-00Hava-2v
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 21:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnEVNykzAfnhAH9m+vmfSCc51Gwnavqio+xWKj/+WJDUULILcwlHvB7dfhh5HD7ktDRHnK7AGTjqq1tUzoZ+iuyHWd4VEIrY0d2urW+SxOhy5KUb1wIEpnqwnjP/2vfybTdSLtOYyVivkKhbmrmCOe+ioMNHzk/fMkVQ4IqjOrZj0c13dKVfUYdj0YjGVbR/2WQ2pbIBu8aUK1Z/Vq0td860R1BqYGRNUdEcZRX+W1t6GtFRlsiPz7vMpXJVpIJ9bqCnv7YNQErali8D9paRJv3slKjrKveR11h8AMcohZX5NqjtoAEpkkEzrvQPQDRdRKe3RpgAkNfH8arxpz9P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+32/fiYDgjJlRZWYVHTtnLOBCy70EKZ58GkZDAv+cd8=;
 b=dixCwAhwEDElbSer0TC4yJB9/oC80x+lDDCSoICbyjKNDHyBi6R/jfFh7xH2lr7OMe7UOVj3DhIK8PwLoOIaucSPTtcpkbYgFrfnxu5ttEkTae1Uv8ZZigi+SH2K5DwCtv6eClJjLKVSL+ibjHJBXi/oCm5TjWfahm80z3UgoHjXxp6G63qYtb3YYQnwKNHC0iG8OuoovgwsSNG0EFzvUIysZB2M7+Wi9z7FIjatm85XaWrS1RJfyzvzkBY78eow+DSqdMLi2/LS1+9kbo9ahugudB7FkCePtkJY9wwjy/OpBbtz3WCKVPdN7umSFS8xe0nZJv3qf6q9yz4nfwr0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+32/fiYDgjJlRZWYVHTtnLOBCy70EKZ58GkZDAv+cd8=;
 b=BL0HdLi9sERCjqKvTo3CtGs3edo2/diWeoIq97ckYEHYDKmaFLS8rnF8hRBvYezd1IMeO/6pGSvjEQ/nRkgN+2qSi5irHRre5PpqU6H3CnbE00ksoyu8KZpn48mH8vIUj5gZAmHIqQj2P5+Ltadw31Lr/vblNH5Ju1+HUUjoA4zl9gwVflCnRSxtRVpf4HntpHgdLaCC/F+kfB/mf858zVHUtOCO+KouPdhgaG4QjkDmwsF2uYjkcCNg7EF3l4bPYM2rNLYFp5/ZECN5VO5xUpUvHoPesMj/DSODBUK3RB4uXwMETelKhVoIUXBCIPS51bU1BAtpbFy1hw0ECSOTvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 21:35:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 21:35:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alon Zahavi <zahavi.alon@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `__nvmet_req_complete`
Thread-Topic: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `__nvmet_req_complete`
Thread-Index: AQHaELcLZl4XXAFMGU+liCdaZhkgSrBt0N2A
Date: Mon, 6 Nov 2023 21:35:22 +0000
Message-ID: <09b82685-bde2-46bf-9d16-e854e358852d@nvidia.com>
References: <CAK5usQuREC_n2dyTrv740v0PiddP2sdKKBqJG3kwbogZh+pv1Q@mail.gmail.com>
In-Reply-To: <CAK5usQuREC_n2dyTrv740v0PiddP2sdKKBqJG3kwbogZh+pv1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6473:EE_
x-ms-office365-filtering-correlation-id: d7c5d433-63ef-435e-9385-08dbdf104806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwA0sIG4Cl3CnfxhwnbcSOW0Iu/aPW9q+JxxC/zuV+I0JCrkY+QCa3b6G3RXoVPv62MeDYV50qJz5uf5DlWeXXklG51M29QRqYilC1DxazMMwh69yzPuX4TX9vdSXBjA+FE6lWQNnh++0xbU/ukD2E/mEPeyt0PUo1C7c8uDjkqaO6HCiZ1mT8rTOaT8otfiy9e1JtSQYhQFKmG28dI6b0xgsuRr6f6CedJj4F+v6FyKlou6IftlasW0I5Hwz7mQCXDL1rPj6bRGaRj14mxiNB9WHLi2KQyKJgdZJPfPVvWilzP319fMLC3EhkZkuOcn5CmLLRXm2RQKjCTnz/PUNb4ZvUGXjbRpjaClFvSll6jSbfIneMNKeClaJ+LCd4S2ZmlvELQMvgR0/7f5PB8escJmiau5hs/PtVX0KUZJ8B57JhhPG0tgceMrKbtRLIK3QU8lUpJIOfy6M2EhJ1AukEeSycfkqxw82ByHVON3afhi8+jWGp7FWMG7qCkZIUePJu6735JsaxP8gIVAUZz1hXuTLhaUcXi/FlKw8TkTLmCkC+iu6s2uNyH+wpz1D+eF2AbfacYrSMSHgWIZ7fPm7WbicHZa9MsqdsLkPwJypiEaPXWPK4fdZJF74G2k3kV6PkyrpHSoolVCcJQtvFZurS3ydlXTJxED6bHJ8yoaq8NxHBjRr1EWK6N7H+1NJ/dNwMBnDaGzSe3UkA5Q6/xkzFKFHzvDo+2jnV7vRdRE1n4YVm0V9ERwkSdShMOsbMpf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230373577357003)(230473577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(2616005)(53546011)(6486002)(6506007)(6512007)(71200400001)(478600001)(83380400001)(41300700001)(110136005)(5660300002)(64756008)(54906003)(8936002)(316002)(76116006)(66556008)(8676002)(66476007)(91956017)(66946007)(38070700009)(4326008)(36756003)(86362001)(38100700002)(31696002)(66446008)(122000001)(31686004)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkwydVhrYms4KzRkRXpyZk5iZWZOSnpiNlpQbkhKeHQ4RC9nZHV6M1p2c3Zp?=
 =?utf-8?B?Y2UyeWpkMzRrWnpaUWZ5VjQwcm5FbWZVZmFMOWN1WW1hQmtXRzNiUlhsUE1P?=
 =?utf-8?B?ZmpncHVtSEIzTm1WcjRjbnRuZ1BSbmoxTWUvME1DTHJGS2FRTWZqeXZjM1RI?=
 =?utf-8?B?Tm83a29Hb0JIcE9qbWxLWjhOTUxsN2lIUnJHT3AvMUxvdzFtUGFuM05jbm00?=
 =?utf-8?B?NUtDU3NwODY3alkvL05OdG0zVDJCd0laMExBNU1HZzZ2NHFFK0dsSEllWGI0?=
 =?utf-8?B?ZFpPTXRqSzNvaXdkcllWWXEweTFhbDN6b3RWMVdOVUZNdVFsY1FyNVB6cEFv?=
 =?utf-8?B?b0JSSjlCQVp1aUhyZ2kxeUd3NWQwVzMxYnRUbWxpeEoxUDFzb1JNT1dsV3J5?=
 =?utf-8?B?bHk0OCtKbUhFcEIraUwyZ25YemVDeWxrRHlaQVlpZEN2ZXJaRHYranBnSDZO?=
 =?utf-8?B?R0o4T1I2K1ZHeC9xVGJLd1d1amNYc3cveFArcmpPL1lOWUU4RVdZS2JDMUhs?=
 =?utf-8?B?dlZ6c0U5YmhzaVJUejZJcDFNOVRmelhkM1V1UUlIZkNSVzR1aGh2SVNrSG9n?=
 =?utf-8?B?Z3p2WWZidFFoUTluWW12UnlOVWNDNHRCWHlGaHNYWW5VeXp6b1NtaVhtSVRs?=
 =?utf-8?B?b05adzVJTUpGV0dVdTY1Tys1eWFYMzRITVBQQnFOVVRNamQ4Y1JOcDdXc3Y1?=
 =?utf-8?B?NmVTQlZXNno1Y2hqUnlzbEhMclB3R0l1aDI3QnZNTm1mQS9ha1M3QmlVY0Rh?=
 =?utf-8?B?cUNMVTZFVFFLSlZQQVNmd3VtakkrRmUva0dUQ3d4YXRFVTh6WlI2T2w3amlU?=
 =?utf-8?B?bzNlWEtHdGZyQzNBbGtyUzB2L1B0ZUNYQnJwM0F2eWhBNnIzRFhoeUxwbFZT?=
 =?utf-8?B?TTJHVkRGSlFGb2JIUG5aK243V3BsKzN4ZU5CT0hmWnpNMzlFNnNYRkNlYXN0?=
 =?utf-8?B?Qkt1Nm90K2RrU3ZYRy9FeTFOTlJxOXVGbFBoRWpWcXY2MlM0U0JnVURhZTkz?=
 =?utf-8?B?UjRSL0RLbitwMnNaODhjZ3VhSFpsSUZKTUVuNmoxWS9aUmYxeWV0cFpwNll2?=
 =?utf-8?B?d0crTk9nVCtxbkZMRXFKRGFaQTNEWEtrRXd6MVhjT3JmOG5TYlhldTZscDlt?=
 =?utf-8?B?bjFuWkpiRHptYThFdWZSVFFtNG9odktkSG1zMDl6bU00ME4xYWp3S2ROa21x?=
 =?utf-8?B?QVVPMnVEbFVBMzRUdy9qU0tkSWRUZCtQRFNLYy9YY3ZIN1hYSTFuVzZKcUJz?=
 =?utf-8?B?aG50OTJUOG9GVGlPZDBsWGk2T2R1Z3V2OXF2ZEx4c2k0NFJQbUY4Nkp2MWpU?=
 =?utf-8?B?aldtTG85T0ZzU05qVjh3TTVkZU4wT3dNbzFHUG4yZERoaE9BTzVaWSsrbkx6?=
 =?utf-8?B?bEgxcWJwQzZSaUtobGpRYytlM3hucW9CSU9idkRnNVJwbU0yMU9LSVVmSWpV?=
 =?utf-8?B?b0RTSE5vUmdQOUt2L1hwMmpzcDhaUTZQNE50dVE1d1VnNWMxTWpSbDNyOC9v?=
 =?utf-8?B?cW5vcU1ZYnEwdEdnYUo0bWRIUGsxV0g0NlQzQ1BKb2VLMGVoOVdJYjBXUjJs?=
 =?utf-8?B?a1E2OTNkU1BSVkE5OEplc1AySE9zS2FHR3Jkc0lFK1E1bVZNRHo3WDZwczJt?=
 =?utf-8?B?clo3TWgxT21Cdk94Z0NqdzcwZ3dqT3grTlkzTHFycnYrcUVGcEdHc1ZWZngz?=
 =?utf-8?B?R3hTV2NuMHZCWUw2OGowVG54dDVrWmFWMzhWQUhpRmgwbmxMaXRhMEpCVVVu?=
 =?utf-8?B?RUhHNUYyc0FvV2pSVUFDNXVxd0l3TGNBeUdBMC9iOXN1b0k5ekoyRlBHMFB4?=
 =?utf-8?B?ZzlrY3A1anRWUEFPTTl2SVpyU1F1ZmxXdUNCa2dxN1Q0QnV4STI2cEtQOHBY?=
 =?utf-8?B?MTR5Y0huV0tBOFo2Q2x0R0dQOGZwUU9DMFlQMkQrWStWdHM5amVmeDJERFdS?=
 =?utf-8?B?RUhMUnJuVy90UjlYRzNScThEN0IwV0dZNlpZWVRyRnVJTW0xRVBmbGMvZ2or?=
 =?utf-8?B?V1R6VFd1RXJVL25TK0V6WEhNYzM2Y0R2VENXSXUxMWVYL1BKNEYyZFQ3UE9p?=
 =?utf-8?B?T1JPU2YrclgvcXN3Ukhoc05hQy9WWmJ2emJObUpqZUI1aEhDNW1LTkp6eUF3?=
 =?utf-8?B?dUFOb3doV2p4NmxiS1dMVTAvWVdWbGZLVHphZ0szdmllOEFRcmxJQThmcHZs?=
 =?utf-8?Q?NUGd7EUkUGzkSC9m8GpPH3BeksBjN8mxQRdq/YQ7cg/e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B23067D7556B1443B880567DA7CB7593@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c5d433-63ef-435e-9385-08dbdf104806
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 21:35:22.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1P4wjLEzVandXmGTp6bqXMUuN0DJrhYVeB/4iXmmcj1sBm2FlPGqg8D+0mgYbnL8KjorOBuOOcdUG9S3VdjNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_133535_018193_03D7CC42 
X-CRM114-Status: GOOD (  12.80  )
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

DQpPbiAxMS82LzIwMjMgNTo0MSBBTSwgQWxvbiBaYWhhdmkgd3JvdGU6DQo+ICMgQnVnIE92ZXJ2
aWV3DQo+IA0KPiAjIyBUaGUgQnVnDQo+IEEgbnVsbC1wdHItZGVyZWYgaW4gYF9fbnZtZXRfcmVx
X2NvbXBsZXRlYC4NCj4gDQo+ICMjIEJ1ZyBMb2NhdGlvbg0KPiBgZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmNgIGluIHRoZSBmdW5jdGlvbiBgX19udm1ldF9yZXFfY29tcGxldGVgLg0KPiANCj4g
IyMgQnVnIENsYXNzDQo+IFJlbW90ZSBEZW5pYWwgb2YgU2VydmljZQ0KPiANCj4gIyMgRGlzY2xh
aW1lcjoNCj4gVGhpcyBidWcgd2FzIGZvdW5kIHVzaW5nIFN5emthbGxlciB3aXRoIE5WTWUtb0Yv
VENQIGFkZGVkIHN1cHBvcnQuDQo+IA0KPiAjIFRlY2huaWNhbCBEZXRhaWxzDQo+IA0KPiAjIyBL
ZXJuZWwgUmVwb3J0IC0gTlVMTCBQb2ludGVyIERlcmVmZXJlbmNlDQo+IA0KPiBCVUc6IGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMjANCj4g
I1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ICNQRjogZXJyb3Jf
Y29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiBQR0QgMCBQNEQgMA0KPiBPb3BzOiAw
MDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNCj4gQ1BVOiAyIFBJRDogMzEgQ29tbToga3dvcmtl
ci8yOjBIIEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQgNi41LjAtcmMxKyAjNQ0KPiBIYXJkd2Fy
ZSBuYW1lOiBWTXdhcmUsIEluYy4gVk13YXJlIFZpcnR1YWwgUGxhdGZvcm0vNDQwQlggRGVza3Rv
cA0KPiBSZWZlcmVuY2UgUGxhdGZvcm0sIEJJT1MgNi4wMCAxMS8xMi8yMDIwDQo+IFdvcmtxdWV1
ZTogbnZtZXRfdGNwX3dxIG52bWV0X3RjcF9pb193b3JrDQo+IFJJUDogMDAxMDpfX252bWV0X3Jl
cV9jb21wbGV0ZSsweDMzLzB4MzUwIGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jOjc0MA0KPiBD
b2RlOiA0MSA1NyA0MSA1NiA0MSA1NSA0MSA1NCA0OSA4OSBmYyA1MyA4OSBmMyA0OCA4MyBlYyAw
OCA2NiA4OSA3NQ0KPiBkNiBlOCBkYyBjZCAxYSBmZiA0ZCA4YiA2YyAyNCAxMCBiZiAwMSAwMCAw
MCAwMCA0ZCA4YiA3NCAyNCAyMCA8NDU+IDBmDQo+IGI2IDdkIDIwIDQ0IDg5IGZlIGU4IDYwIGM4
IDFhIGZmIDQxIDgwIGZmIDAxIDBmIDg3IGVmIDc1IDk2DQo+IFJTUDogMDAxODpmZmZmYzkwMDAw
NTI3YzAwIEVGTEFHUzogMDAwMTAyOTMNCj4gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAw
MDAwMDAwMDAwNDAwMiBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gUkRYOiBmZmZmODg4MTAwYzc0
ODgwIFJTSTogZmZmZmZmZmY4MjE3MGQwNCBSREk6IDAwMDAwMDAwMDAwMDAwMDENCj4gUkJQOiBm
ZmZmYzkwMDAwNTI3YzMwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAw
MDANCj4gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZm
ZmY4ODgxMjkyYTEzZTgNCj4gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAwMDAwMDAw
MDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCj4gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDAp
IEdTOmZmZmY4ODgyMzNmMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IENSMjogMDAw
MDAwMDAwMDAwMDAyMCBDUjM6IDAwMDAwMDAwMDNjNmEwMDUgQ1I0OiAwMDAwMDAwMDAwNzcwNmUw
DQo+IFBLUlU6IDU1NTU1NTU0DQo+IENhbGwgVHJhY2U6DQo+ICAgPFRBU0s+DQo+ICAgbnZtZXRf
cmVxX2NvbXBsZXRlKzB4MmMvMHg0MCBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYzo3NjENCj4g
ICBudm1ldF90Y3BfaGFuZGxlX2gyY19kYXRhX3BkdSBkcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5j
Ojk4MQ0KPiAgIG52bWV0X3RjcF9kb25lX3JlY3ZfcGR1IGRyaXZlcnMvbnZtZS90YXJnZXQvdGNw
LmM6MTAyMA0KPiAgIG52bWV0X3RjcF90cnlfcmVjdl9wZHUrMHgxMTMyLzB4MTMxMCBkcml2ZXJz
L252bWUvdGFyZ2V0L3RjcC5jOjExODINCj4gICBudm1ldF90Y3BfdHJ5X3JlY3Zfb25lIGRyaXZl
cnMvbnZtZS90YXJnZXQvdGNwLmM6MTMwNg0KPiAgIG52bWV0X3RjcF90cnlfcmVjdiBkcml2ZXJz
L252bWUvdGFyZ2V0L3RjcC5jOjEzMzgNCj4gICBudm1ldF90Y3BfaW9fd29yaysweGU2LzB4ZDkw
IGRyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmM6MTM4OA0KPiAgIHByb2Nlc3Nfb25lX3dvcmsrMHgz
ZGEvMHg4NzAga2VybmVsL3dvcmtxdWV1ZS5jOjI1OTcNCj4gICB3b3JrZXJfdGhyZWFkKzB4Njcv
MHg2NDAga2VybmVsL3dvcmtxdWV1ZS5jOjI3NDgNCj4gICBrdGhyZWFkKzB4MTY0LzB4MWIwIGtl
cm5lbC9rdGhyZWFkLmM6Mzg5DQo+ICAgcmV0X2Zyb21fZm9yaysweDI5LzB4NTAgYXJjaC94ODYv
ZW50cnkvZW50cnlfNjQuUzozMDgNCj4gICA8L1RBU0s+DQo+IA0KPiANCg0KVGhhbmtzIGZvciBy
ZXBvcnRpbmcgdGhpcywgd2lsbCBzZW5kIGEgZml4IHNvb24sIHdvcmtpbmcgb24gaXQgd2l0aA0K
cHJpb3JpdHkuDQoNCi1jaw0KDQoNCg==

