Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51A8C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zxiCjrOIRdvl6G0DurrF1yK7QQ9lShCoIpOI/x5P1yo=; b=Caz+iNu2u6+CPn4L3XFau3QBcl
	Us5NY4Q2ilTKw1pP0SM/LF2DK9O3hCbfwfW63Rg7r8QPrZxmDTap4GguqY1By1QVJ75NbKLIbG0uX
	6fKQOc1SRbMzitoAwaMZuQvQFEGcpCEBY3WHmqetexvfj6O9CIBNMcV4aKFfDCrm/gviJAp1rl2fZ
	ELETxnFnUCE/hVi7eijDzT4FWqHzoAtaG4pq7XITbl56UrCEULPCg2tavYv8+SDMXhyj/bucbOseG
	7/i/Zoa+9x5nsbgg1lzM5HYMxOAV32w05Gs5mn0Jbp0JPkEzAiP4ZNs5o0V58nWgzCfQpWnPIz4zp
	5rBM+4aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptxS2-002g83-31;
	Tue, 02 May 2023 21:22:22 +0000
Received: from mail-mw2nam12on2062e.outbound.protection.outlook.com ([2a01:111:f400:fe5a::62e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptxRz-002g6v-0w
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 21:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARTWMR5pMwBv+mhSGCS7yJHTUF7YOeEdcSVqfq6xxUMGTtGK0vVbc5shCg/ppg0Es1Pbo8gSB9lppsS1XUhN5uuL28GGkfpyrO8xAMO6ebRTfBuMhEr/OTi5t0RQzFxx6E5+0GUxtDu9JRAjtUzV4Ek3FVI7gVoKvr/z2Rm70ghRqk1qfd8i1/1SHLl++5+Z81ijwT7atYTEojUrVmCY6pkWV1UhRbeh1Yv0tNWoVVK924tuJriv+m9IGEZ2LTtsuWPhj5AfS8/jWMM2+fmORn+sKw3vHLDMoa3qHd0o4ocOIX0Fkp4XqaGXB0QbXiuUAu2hsg+njIFb01LNXZ7Mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxiCjrOIRdvl6G0DurrF1yK7QQ9lShCoIpOI/x5P1yo=;
 b=jNzgll15zAzFVavWd6B1qN2hF2CmPc4N1dOAR1G8f3cTydrMA8Azj56JprVpFTVH0FZ4zHjXveLGVyXBWehzo9ae9vsgVx1+cMJITHEIQg6PH/LYW8BijrW0BqT2s+OoNzI2dt0bLVz+zZLhS5s4OR4UVnEL/0uf5ylA4UHbriaQ9LlmOkz48/ZPHa8cK4yQcQo6QmeFIQ9zCXwKecYFwc2wj4hLlmQO7SVCChrhuUohDk9CujNtikBxOTaFsfwdLnjY6ODvJhKC6pr1G4RSIWrHt35j0x4tiXzquBsDNPMCABqPCybArre14gPXRKje+dCjZbz9GyyaJwf17krltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxiCjrOIRdvl6G0DurrF1yK7QQ9lShCoIpOI/x5P1yo=;
 b=fAJWSTfSn6NWdkIk4herj81cj92kMfnbKe67PbQhbrCV3r4ewZ6yil8AF3RVfKqORXLeeibOZ6s9JHRDw1AAQdZusu87Ww9xhKJ6W1KrELtIEAgHnyfLL0CFMqtc9yCndhZJ2A671p6EV0pRppQlmH1eBNRLno0EK64cGcXG9Jdutx7iK9ljW+lD7dqIew9nwEhNBiGs2koFbCaXcZYp14IVLGq3KW16PO789QB4tABU5RHMThItPFxvaLJtOfrKdCPO2W/cnEKNbEYbzEcAjirjxIJL0qkfdpcQRnIeau6dI+JK/CAeud8qRP6q/wFMvWLz0ohZ10uYyYtY/edmUA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 21:22:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 21:22:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Smith <dansmith@ds.gy>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] Duplicate IDs for nsid 1 on another drive
Thread-Topic: [bug report] Duplicate IDs for nsid 1 on another drive
Thread-Index: AQHZfLDqljHGSVovQEOhbZG1BBZJQK9GizKAgAB5SACAAHp0gA==
Date: Tue, 2 May 2023 21:22:11 +0000
Message-ID: <13c8f177-9d18-b18d-d44f-e4c649b1e219@nvidia.com>
References:  <CAKv4OQ08jfk6r-c0T9U-WtZ6ORt2kbR0ARiH1isav-uFZYoYpQ@mail.gmail.com>
 <e092dba7-5e7d-7306-683c-e9d53228cce0@nvidia.com>
 <CAKv4OQ0twOgJ6wfaHD-tPwTNEBwc233H-751Ya2W98qHeNkunw@mail.gmail.com>
In-Reply-To:  <CAKv4OQ0twOgJ6wfaHD-tPwTNEBwc233H-751Ya2W98qHeNkunw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: c6b3ce10-c501-4e2b-5486-08db4b534afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  j/FVpP6D8zOtksymnWqueYZXFO0R0+TDAYx0O7sp5vDcmY4GKYL768Zv5MXLFVV59PerlwQJYhD5X3OuLC//6UfaBDujyM3zzYf7BtWG/Im9ro9McAchaOLRtpvrFNhYogIpwaLS2D0n9AoJEMDq/ES64D1UbvjxFRzjQEI+ctMwn+97WyUOHDQOow2M9F2h+azBn79/XmDXFo/bogYZyTu3DnXTxY81La7bZo705sRWxmCvqoLmZHnBp3L05ui50DlYp6C7a0qZnFi3/8zMNURcHi/G1vS3Isu7VTi38qqr/auNUmUmF5dQMlM7LxCzEHcNgtTFuX3kPewyIHdg1gu6mMnY91QGzJZYLGl+OhL9Zr4MHsWCTkwkfkjtV02NlGL/kKyRHrT8f5xnsohtRROJYmoMI/8uHgKHv1h0d3y0bVSchIWhQU3VKFjz7s0nWwojIWoFlzBBW53JNKXWbAtXKIk6dB2pXO9S1Um4DdzwUHNj+zR81SRcGeAy0W2SPrLWzMdrFp2asjgEx7mRpxOUVuPA6Y1MoT7vZZjfcVpTDn/nnuAXp5UYjNRNBpSbKh5CbEE4mv/XfVyH/UBocsPufXBzu2c2COEkQFCursq7ST6uyKYuxRhAuRdW9+FSPALOnAn/lUrV9mVcTmgKiu9Ixm+a1UXAeo4Ivdtt3h1Fk1XHc0833lCOm3ls1mKK
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(71200400001)(478600001)(83380400001)(6512007)(2616005)(53546011)(36756003)(6506007)(122000001)(31696002)(38070700005)(86362001)(186003)(38100700002)(6486002)(66946007)(66446008)(64756008)(91956017)(66476007)(66556008)(76116006)(316002)(8676002)(8936002)(41300700001)(5660300002)(31686004)(2906002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MUJkUWp3STlGalROTGRST2tGdUlxcHdiVm93QktvbnlJME5ra1lhdStYZlZl?=
 =?utf-8?B?RFJmYlluMHNzbmRGdnREVW4xTk1IdzIxMVBXTjdxdzEzU1ljWGZ4dVNYNE8w?=
 =?utf-8?B?TjlrOTVwWjZ2MGE3OHhvMDAzeEhENmxxYTV3TG1ORzQ1NmxsMnY1b0o5aXFR?=
 =?utf-8?B?czJJMEdGRkFya09OMFJpaFY4M1YrY1BsWU9ZM0dzNzVGaFdQVFFPMUxmL2tP?=
 =?utf-8?B?aHpOVmZWUy8zcDNvbHZYbmtaTzZoVWRGNm01TzJFZlZnWHBGZkVUSmdiQmov?=
 =?utf-8?B?bXREd0VGNTh1MjlXMFZudGlYVHJMUUNoUU83eCt1dFJSbnF4am92bnljaGlV?=
 =?utf-8?B?UEZuaDFnd1VFRGZlMCtIUWZhNytQczJ0dHJHLzJXQWVJVmdzZTdWRXZrNG9K?=
 =?utf-8?B?azBwRlhiV2RxMUFmYTUzQ29xRmMzLzNKOW5RY3dJS2VITUxyMURqQzhPZC80?=
 =?utf-8?B?c1pTZVlISm1kV3VEalNERHZoT1NiT0NRRCtpVUJ4RjFmK1JZa1RwVHE2aFhw?=
 =?utf-8?B?SFk2TnZCWEtzcFlzNWh6dGJpU2QwTzE1T0pvYnQ1VXd0a3c1QjQ3TnYySDJN?=
 =?utf-8?B?a3pDa0p4K0p1OElkQXFNcERHSkNMWnBvc0UyUFN5K1M1MHJ1Y1c4ZUhGc0dJ?=
 =?utf-8?B?VXpwYUV0NUFrWCtXSEtPUWZ0NkcrZUl4a2JTclA2Q3JNODZGU2hKZXRBc1Ew?=
 =?utf-8?B?YXRuS2VUc3ZPcjM3Nm5NVFBVQXlXYWVZZXJCTFFKaTFMMnU0dnQ5Wm8wUm5p?=
 =?utf-8?B?NmZTamhSbDZTYTVkYlc1c3ZocXc3eVZXR2laTUhhcXFUVHJzb1BlZmw4NStp?=
 =?utf-8?B?OURWWVIrQVU3OU1jS3RRM3JzYlI4U1BxckREMHB3eWVCYmZVbDNLUzhpREVr?=
 =?utf-8?B?R0pmKys2Wkg5NlVKS0NmSnZzemJVWXpaZUhhWi9Va1RORHJXSkVSbUU1MHFZ?=
 =?utf-8?B?cExwWHc0VlRZeW9zU3J0V0Njb1ZoTXB4NzNmdHNwRG1ha3Flc3NsRWl0U0dl?=
 =?utf-8?B?U3pJbmtQbFUxdk44cHozeHMxWDhpdzg0MGFIdkdTcVhqQTViRGtFb29hMllC?=
 =?utf-8?B?RFlDZGgyRjh3MVZsbDB2eXNocnFsTTNobmNwZGNjTmlmdEs4N0Roc1FmK3NC?=
 =?utf-8?B?Z1diZFdGTUxXZ2czM3NKUEJwQmIxSjBQeVIzeTRJbkpYY0l1ak9nL2pQRCti?=
 =?utf-8?B?ZlY1cEhsaG5hMmllUHJjRmM2V2R3N2FZSTdqUHpIek9UU1RXNDdjTlZVR2hl?=
 =?utf-8?B?Y2VYTUFyYzc4WjZhbXNZMXMxVnlkakUwSHJmL29aeGNZTEdVQm5Jcm9lOUhj?=
 =?utf-8?B?ZkorZzBnUVNzZWswN3N6QitLR1ZSN09SL0kxTE0wRUdSZ01zbGFJeEw1Yy9M?=
 =?utf-8?B?dWxoNDAvK3A4ZGNsQVJ3ZkN0ZEJPYTM5a041N3ViQi8wL2c5cXRSdUhMVUNm?=
 =?utf-8?B?K1d5SGFxTUwwRDlHUFZtUVlDczBtdi9lSlR6M1c2YmRCT3NqQjFEVWtpcHJJ?=
 =?utf-8?B?VXozMnN4TEZnb1UvRG5IeEVBdmVNUFM1dzd6OEFTejRzOUhwUlR3dGpNVjhZ?=
 =?utf-8?B?aEFBcVZtejJDMG9UV1V5OTI0OGVWMlNpV3NqMkN3Vmhib0RyWWtOLzJkQmJa?=
 =?utf-8?B?djFIbFBDclFRbGRXSlVPRkJKbGRLVDVNWDJTVGxoTEYvbzkwMDRYa3VSOThZ?=
 =?utf-8?B?MXJ3TW8rN21WNGJtcGVQdFlJQlFJREZBajlUN0dLS1lzU0xnMHlURldwTUtL?=
 =?utf-8?B?Uk5jN3R5aGo3QmVKVjc2TzdMQlBONitQZDZBT2FUbHlZVVQ1UElIdkIzVERx?=
 =?utf-8?B?VWhlbTYvV3g4SGNUaTJrdTRlQko5Y0pVdXVoNzhjOU8rYnFXZ2RGQ1hvcm9T?=
 =?utf-8?B?cmRaUXJOQkEvUFJZT3hEYzd4Y3U5UStYMlkvdzZvblE2N0NjNXA0d2ZGZXRu?=
 =?utf-8?B?VXJaM2JKOEdMaWZNdkNhaXYza1dTU1MxdDFFQmlDMlNwSEZERGxPQTdhc3Fr?=
 =?utf-8?B?emZycGVKVnBRd0lMZ3NYaW9OTUIrVUlqY0RQT2RxejB4OHpab2UxeHh4blpZ?=
 =?utf-8?B?Nm1GYUFEYjFsN0I5bmFib3Uxc0o0eW5iTGxJUGljQm1RaThQVXpnSklwazdu?=
 =?utf-8?B?YTB0Qk5Ua0xFU2J1NTJMQWduMHJ6cnlZNExoamFOeXFhOHNESHpaMlhURW55?=
 =?utf-8?Q?RWxiA75ciccetY6H2mPmjpk0t035cCGXp2WGxSI0qECG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF833C5162928D4BB8F59BF1ECB098AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b3ce10-c501-4e2b-5486-08db4b534afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 21:22:11.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xoNXh7f39NKJWW7773SX9+Nt+bdSaeZQyGfjZ/yuCvTYtjAcpZlOiDycJDTTfpqwp7aRBnxH7PyuJJN7+gfRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_142219_411513_A14364E9 
X-CRM114-Status: GOOD (  25.90  )
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

T24gNS8yLzIzIDA3OjAzLCBEYW5pZWwgU21pdGggd3JvdGU6DQo+IE11Y2ggYXBwcmVjaWF0ZWQu
IEkgY3JlYXRlZCB0aGlzIGRpZmYgZnJvbSB0aGUgbGF0ZXN0IHN0YWJsZSBzb3VyY2U6DQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L3BjaS5jDQo+IGluZGV4IDdmMjVjMGZlM2EwYi4uYmU1ZmE3YmFlMjg1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2ku
Yw0KPiBAQCAtMzQ0MSw2ICszNDQxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkIG52bWVfaWRfdGFibGVbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5RTiwgfSwNCj4gICAgICAgICAgeyBQQ0lfREVW
SUNFKDB4MTBlYywgMHg1NzYzKSwgLyogVEVBTUdST1VQIFQtRk9SQ0UgQ0FSREVBIFpFUk8NCj4g
WjMzMCBTU0QgKi8NCj4gICAgICAgICAgICAgICAgICAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJL
X0JPR1VTX05JRCwgfSwNCj4gKyAgICAgICB7IFBDSV9ERVZJQ0UoMHgxMGVjLCAweDU3NjUpLCAv
KiBURUFNR1JPVVAgTVAzMyAyVEIgU1NEICovDQo+ICsgICAgICAgICAgICAgICAuZHJpdmVyX2Rh
dGEgPSBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwNCj4gICAgICAgICAgeyBQQ0lfREVWSUNFKFBD
SV9WRU5ET1JfSURfQU1BWk9OLCAweDAwNjEpLA0KPiAgICAgICAgICAgICAgICAgIC5kcml2ZXJf
ZGF0YSA9IE5WTUVfUVVJUktfRE1BX0FERFJFU1NfQklUU180OCwgfSwNCj4gICAgICAgICAgeyBQ
Q0lfREVWSUNFKFBDSV9WRU5ET1JfSURfQU1BWk9OLCAweDAwNjUpLA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55
YWtAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDIsIDIwMjMgMjo0OSBBTQ0KPiBU
bzogRGFuaWVsIFNtaXRoIDxkYW5zbWl0aEBkcy5neT47IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiA8bGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW2J1ZyByZXBvcnRdIER1cGxpY2F0ZSBJRHMgZm9yIG5zaWQgMSBvbiBhbm90aGVyIGRyaXZl
DQo+DQo+IE9uIDUvMS8yMyAyMTo0NCwgRGFuaWVsIFNtaXRoIHdyb3RlOg0KPj4gSGVsbG8sIEkg
cmFuIGludG8gYSBzaG9kZHkgbWFudWZhY3R1cmVyIHdoaWNoIGR1cGxpY2F0ZXMgSURzIGluIGRp
c2tzLg0KPj4gSW4gdGhpcyBjYXNlIHRoZSBkZXZpY2UgaXM6DQo+Pg0KPj4gVklEOkRJRCAxMGVj
OjU3NjUgbW9kZWw6VEVBTSBUTThGUDYwMDJUIGZpcm13YXJlOlZDMlMwMzhEDQo+Pg0KPj4gSSB3
YXMgYWJsZSB0byBzZXQgTlZNRV9RVUlSS19CT0dVU19OSUQsIGJ1aWxkLCBhbmQgdmVyaWZ5IGl0
IHJlc29sdmVkDQo+PiBsb2NhbGx5LCBidXQgSSdtIGNvbXBsZXRlbHkgb3V0IG9mIG15IGVsZW1l
bnQgdG8gc3VibWl0IGEgcHJvcGVyIHBhdGNoDQo+PiBmb3IgdGhpcy4NCj4+DQo+IGlmIHlvdSBj
YW4gc2hhcmUgdGhlIGRpZmYgdXNpbmcgImdpdCBkaWZmIiBJIGNhbiBoZWxwIHlvdSB0byBnZXQg
eW91ciBwYXRjaA0KPiBzdWJtaXR0ZWQgLi4uDQo+DQo+IC1jaw0KDQpjYW4geW91IHBsZWFzZSB0
cnkgdGhpcyBhbmQgbWFrZSBzdXJlIGl0J3Mgd29ya2luZyA6LQ0KDQoNCiBGcm9tIDdhOWMxZTg5
NjFiMmJiMjcyOTVkYWIxZDI3YzBlZmY0NGQ5NTdkY2QgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
DQpGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KRGF0ZTogVHVlLCAy
IE1heSAyMDIzIDE0OjEyOjA0IC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0hdIG52bWUtcGNpOiBhZGQg
Ym9ndXMgbmlkIHF1aXJrIGZvciBUZWFtZ3JvdXAgTVAzMw0KDQpGcm9tOiBEYW5pZWwgU21pdGgg
PGRhbnNtaXRoQGRzLmd5Pg0KDQpBZGQgYSBxdWlyayBmb3IgVGVhbWdyb3VwIE1QMzMgdGhhdCBy
ZXBvcnRzIGR1cGxpY2F0ZSBpZHMgZm9yIGRpc2suDQoNClNpZ25lZC1vZmYtYnk6IERhbmllbCBT
bWl0aCA8ZGFuc21pdGhAZHMuZ3k+DQpba2NoOiBwYXRjaCBmb3JtYXR0aW5nXQ0KU2lnbmVkLW9m
Zi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCi0tLQ0KIMKgZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMgfCAyICsrDQogwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3BjaS5jDQppbmRleCA1OTNmODYzMjNlMjUuLjcxMDE1MDc5NDBkNyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2ku
Yw0KQEAgLTM0MzMsNiArMzQzMyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCBudm1lX2lkX3RhYmxlW10gPSB7DQogwqDCoMKgwqAgwqDCoMKgIC5kcml2ZXJfZGF0YSA9IE5W
TUVfUVVJUktfQk9HVVNfTklELCB9LA0KIMKgwqDCoMKgIHsgUENJX0RFVklDRSgweDFkOTcsIDB4
MjI2OSksIC8qIExleGFyIE5NNzYwICovDQogwqDCoMKgwqAgwqDCoMKgIC5kcml2ZXJfZGF0YSA9
IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KK8KgwqDCoCB7IFBDSV9ERVZJQ0UoMHgxMGVjLCAw
eDU3NjUpLCAvKiBURUFNR1JPVVAgTVAzMyAyVEIgU1NEICovDQorwqDCoMKgIMKgwqDCoCAuZHJp
dmVyX2RhdGEgPSBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwNCiDCoMKgwqDCoCB7IFBDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9BTUFaT04sIDB4MDA2MSksDQogwqDCoMKgwqAgwqDCoMKgIC5kcml2
ZXJfZGF0YSA9IE5WTUVfUVVJUktfRE1BX0FERFJFU1NfQklUU180OCwgfSwNCiDCoMKgwqDCoCB7
IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9BTUFaT04sIDB4MDA2NSksDQotLSANCjIuNDAuMA0K
DQpPbmNlIEkgZ2V0IHRoZSBjb25mb3JtYXRpb24gSSdsbCBzZW5kIG91dCBhYm92ZSBwYXRjaCAu
Li4NCg0KLWNrDQoNCg0K

