Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4E0C00528
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzhBjH048xNvfphSbvBiSa5QZc2Cugqea2nkVW+L2r0=; b=qIrqgdW7eeBjRoBhjk/UvLtLGE
	iHT9oJTwcYjgBUs7XeoBidKViuIl8h4FZ+COFzLZMDx8PKbibsIrt+5aGq+G76wkChrl5eg1b+WnB
	uccxMXi2OBiRJJfUZjdu7N5RBsgOAI7Bt4UhTuzljTpNnAIg84k3Jl+N9j3/ruLV7jvgn+NaMmKqb
	oOQ29lYinS0ZACd95QCbUlA9yoZkpHYWJVVgsUbrsH4Ers7lfCxYRiWB0XOtBdrYBPIDaY+Q+n87Z
	plyKFWTA+fpknEKJoGvG4oKdNKmDb89WO0fzZWmYynY6M/cFD7+QGdFd3dwBEgsa5CSC1pT+VN8s7
	fT+fiNUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT1v9-0001fX-0X;
	Mon, 07 Aug 2023 15:13:23 +0000
Received: from mail-dm6nam11on2072c.outbound.protection.outlook.com ([2a01:111:f400:7eaa::72c] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT1v5-0001f4-38
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 15:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR1ZZeDLwdkku/r+W8VKIYuIxm13ymcnc1xPkFBG+CCxzad9YzoRNsjbfY9zV6zoSJ880mImsv2XpiWDzcm5DZ7Z0Bu43Et6vWMeh1iR1aficXtsIeDswkQSNDG8R+yUJeKN2TtjB37JC27jT3D7k1/nH+NTNaC0wxjb0WzHbF40ZmjKkh5l/QoLA54QluN+vLlIEcUKXOyUeT2fS3+OShrtJFF+wZQKE19b6pLBJd85bbikRnGbFkd4cPgFNaGWrqjEdFPbKH/daN4IiYij2cccgmwD1g7rVjcHEKWoG3SITGoFuPTHvcxaksU0+yMlXOUZ4v8kTk5HBdfhs7nZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzhBjH048xNvfphSbvBiSa5QZc2Cugqea2nkVW+L2r0=;
 b=J/R1eCsZiU72BYGlmsJH1OuzTUk+xI42JVoYIALu53YiY7qnW073B/eNzzUfE7CMYef43XIStPWPmpNmHdFb/t5HWatPEcZyZGPDvpiBHgfMs1B9PPrG5S2hnAqygmcACzfafGQctMQFncH2NoGIcJ0KpK1CS9NDfe/BqYIDAFLt3m/uyK7q2cE2wGJTQI7IkIz3NngIdiN2vDrB3bckJNW7vdSGqRv0cui658YN9Y/YIRDunt4gLWAMLCRgzvaUWTBB37aAxDRpmHiulYY+54my1AWiIicZvTDDHluddDKdztJou+1ITiOkkU5aYA6rumSCakrC6lNiDrt4wu4BlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzhBjH048xNvfphSbvBiSa5QZc2Cugqea2nkVW+L2r0=;
 b=JddVhds/FKX58DmnC1ChXmOTjnHGO5LiJhfZt0wGKG7VQGnhp52IABhac3tTsw574xC40+tPsvjkISEsm/le3JY1VRYviFt8IirHHZLzgtvK05f28l5Dxk73aKI73E9G6zu6JcCz7v2SRL2x+x1ysGJinTxJLME2NnW521aJnqM=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 15:13:07 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::5bab:f7fa:3d6e:2267]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::5bab:f7fa:3d6e:2267%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:13:07 +0000
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: RE: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Topic: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Index: AQHZxfXezBBlNj6SSECn0Sdt0gsgnq/eueEAgAA77AA=
Date: Mon, 7 Aug 2023 15:13:07 +0000
Message-ID: <BN9PR12MB5324E8DC829612DD1463116BBC0CA@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230803105839.6139-1-varun@chelsio.com>
 <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
In-Reply-To: <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|SA1PR12MB6800:EE_
x-ms-office365-filtering-correlation-id: 7e6beee7-377c-4693-950b-08db9758ce02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqmtqYEmSFhcLCu+4gveeEaAoJrnaqNK8wWhObTIqip4dSsT0kBn4z5BqHur/C/xBwpnIKldmOsvws1loN8x1NL6e0KR91K3df5ZIV1nCuA9MbedGSAvXF0yk1sWDOpm2gOE0FvZxsWCmrsXfamRH8fv7x+Us1BxpfOcCL3wh0ASmTYVJTmYilIDJMgUMFUh0AUHda4Zg5qM18EocK5eBgn1q2MxXKCtr2HmjJeYYmhXi98+So0AoqBJdh2j2D5FJiJavfckBQkSmecoCULS00GZ9OSPO9NmroLZYyqPUx5QElygzz9bHrgOjsTszf6DqY4eNfnzFx16Dg5MyLdJk7YgpcDLS1gCpek/mFaD1hn8EBvbmkEktjrXQBNQfjw0e/ijIJFeaftWtkTXLQ8+XpriWiLoe7f49dHzM2j5nxOSvujMnixqc6WrmoX15iF9ZPidHdTjNCVuMj7YmAGmonpVqwbjAxt8ZaPDx8j7bWHsngEnwO7CASQZdnCAgmE+nmMVmie1KcxbBuYLlj64en+FgtXO5jFcNKiHQ4iMoQRUsDlLBJaKYj9NxqyeQyQfY8ZopqD2f9YslGUdgEKSlxxwrxPiyy5RQAoWGHZzXxp2PS5XjGxeKGLZG6vkwGhO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39830400003)(1800799003)(186006)(451199021)(83380400001)(55016003)(54906003)(110136005)(2906002)(4326008)(8936002)(316002)(5660300002)(38070700005)(52536014)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(38100700002)(86362001)(478600001)(33656002)(122000001)(71200400001)(9686003)(7696005)(41300700001)(107886003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aiszQm5XT3QzdTA3TmhFbGJERzZYWmtmTzVrUzFFdEZrMTVjTWFLN3ZsejR5?=
 =?utf-8?B?cFhGazF1aTc3NDczMnRMNVFPWFluWHA3VnE2eTJuTG5YSFVVdzFyYW1wK3BC?=
 =?utf-8?B?enJZMGs0OHNXVDhpN0ExWXUxc2lLRHpGbVlBUjEzOGh6eHQ2dnp6M0grRnI2?=
 =?utf-8?B?T0w2M1F0dUsvdDFZa3R6QlFuL2RiRVdXa2QySVBJVEFYN2ZDZkl5dnl6ZDg1?=
 =?utf-8?B?L3VYYmxyZW02YkpTUWlRWHk0SjJoUDEwbzdqNlQ3cCt4M1loVnpRM3ZESjdY?=
 =?utf-8?B?dHBBUDdybThPcHVIUkJGcWJ3WFRTOVp1dFZjZTRMeGt0RDZMUXFYVWtId3Ni?=
 =?utf-8?B?N25mYVAzbnUxMFBWNTd0YUVYUDRiNldQNndJVldsdEE4WHVGMXFITHIzK250?=
 =?utf-8?B?UHhURmI5dXVhVWJ6Z21ZVjFKakdQTFJLTHk4WWtweDJzdGtPalBqUVRZWXRa?=
 =?utf-8?B?aVloQzlmcFN3ZTNaalBHTUlucTJkUnN2MHJWenA2b2haTlJFV3FWNDdIWnBz?=
 =?utf-8?B?dDFXWmdHVmthaTVLbjBWOUhUMjVkMmlLUStmV1F4N29EY0hYVFVoQldZVzZ3?=
 =?utf-8?B?ejA1M0NFbzdZdVBRRk5YSlBZYWcyWXRxQXBDSjRiRGF5Q2VxSkUvdDdnV2Fl?=
 =?utf-8?B?WFArOGNMbnZDRHRUMm1QL2dPOEdUanNRbWlVeWRhdWdkQmNNZmJ1WXlOenlk?=
 =?utf-8?B?SnhjQmNDUnFtTVNvWGQzNXRjczI4VHNFZHNuN3dSaXBpaXBiVlpoV1FBL0lL?=
 =?utf-8?B?Um9ML0N3RkFsci8vZ1BmNzVoVkdqYW5Ec3FGNXcxaTNqQ2c4ZFA4ZnU2K0Qv?=
 =?utf-8?B?TzhDZXpFYmtaNTVhOFZpYk1ha05YQ0d5Q1JGUkt2VUdlWC9ub0VoVFRUUEIy?=
 =?utf-8?B?b1ArcGFYV1o5Q1NXc01aZkRzNUZMUGlobk9pZDlhZExSY0VzUFpranA1Z3Er?=
 =?utf-8?B?UG96eE1UT05rbnFzMFVmdmM4TFhDNkxuY2QxQmhrb2oxZjVaZUtGeEVBYVRG?=
 =?utf-8?B?ZHBCdHJMdXRtWnBSUEpFYTJhR3J5bnBtREl6Rkl0MUp5OHd4bUgvRklIdmZa?=
 =?utf-8?B?K1MrcE5HQ3kvcXpwK1RKV2V2SGYrRkl3a2U5aFJNY2NtSklQTnppZGJzSnFN?=
 =?utf-8?B?NjM0T2RWbWhaYUF3a0lNNVM0R0pPUEQxYTJrN3NOZFVpT1dQQWJCV21laGls?=
 =?utf-8?B?M2k5bEtBMG5sQUE1UEM3Uk85NjhrdHFFQlAzV3JPRUJUN1JZWStzMHUzSlMz?=
 =?utf-8?B?U24wNFFGZDlXYmRxVVl5UkZnaTFtcXVZUm53YTBvNzNkWUE2a3VpdVF4WEFl?=
 =?utf-8?B?MWE3M3ExampWcXdLdm8rdnBBYkRNa2FtMno0eit1Wkxkd1RXV0NZZE1rRFVC?=
 =?utf-8?B?OFcwSCtnUEw1U0VuTG5Na2RVS0xsNUE0VCttMXRwVVMzS3pDYzFNazduM0hu?=
 =?utf-8?B?bzl6MHgyZ1VwQlZNVVNRZ0xZeTdpbkR2WUxsM3FDeWV1NDBLMkZVUnpQTndK?=
 =?utf-8?B?UUdmQTBmbnFCdXA0dmRUVWt5WWNwcUV0Z0JMaGMzSHI0ek12aGZXOXkyUVVH?=
 =?utf-8?B?eEt6MktQcmlGL2lJVi9SZDJBWGFJMVVnQkV4V3hwVm1uWE5BYnJ2RThaUE0w?=
 =?utf-8?B?U2tFejdZbHFOSEVNOWtxclJFUXJJNkpXSkk0YzVDUDNZc1htY2JXK2F1WHV1?=
 =?utf-8?B?Ukl3MkdzV0M5bVBFRW5vY0lNR0daTFpUMDZMLzlPdUR5QUtCL3lMR0IvWnBi?=
 =?utf-8?B?Z3VvMGdhWkZ2UlhBaGY3ajh6eWJSOERmRStZcTRjdVNXL3B3V3UvU2NqNGtS?=
 =?utf-8?B?UHpqazJSd0t4WUdpVXVHWElmcnBZVnIra3NoRjJDUVNKMWZybmhoOERGVVRh?=
 =?utf-8?B?TjdPalYwUGRBaXlFOFhuSkhBcG84aC9raHZwbmNWQ212ODI3b2JrTUtJRzI1?=
 =?utf-8?B?eDBUVEVPMGU0cFFmMnV0YkNzQ00yL0JTT2NZVkw4ZEd0Vld1ZFFuQStiQnZI?=
 =?utf-8?B?M2ZLODJyZVFnVmFvVkZNUldJOFQ1QlhNUHFXSkVVNHZ1dzJVZ050eWdSOXZK?=
 =?utf-8?B?R2V0R1o2cXUvMUlvd3ZOVVlPVmZsV09WWHAxbTV0M2JhbllBRFJIWmJJUEVV?=
 =?utf-8?Q?9vN51sm1RZP+d/77r4tv2I4X6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6beee7-377c-4693-950b-08db9758ce02
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 15:13:07.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gW9us75nwY9Mz7i5dWZfRrJxoYx2LHYBXqgQIXa6WzBEeO191CKLp5pyDcKJzRYuUfjenj+lHYqrHzYnlJngBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_081320_209563_D3787D54 
X-CRM114-Status: GOOD (  10.39  )
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

DQo+PiArew0KPj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnID0gJmNtZC0+cmVxLnNnW2NtZC0+
c2dfaWR4XTsNCj4+ICsJc3RydWN0IGJpb192ZWMgKmlvdiA9IGNtZC0+aW92Ow0KPj4gKwl1MzIg
ZGF0YV9sZW5ndGggPSBjbWQtPnBkdV9sZW47DQo+PiArDQo+PiArCWNyeXB0b19haGFzaF9pbml0
KGhhc2gpOw0KPj4gKw0KPj4gKwlpZiAoaW92LT5idl9vZmZzZXQpIHsNCj4+ICsJCXN0cnVjdCBz
Y2F0dGVybGlzdCBmaXJzdF9zZzsNCj4+ICsNCj4+ICsJCXNnX2luaXRfdGFibGUoJmZpcnN0X3Nn
LCAxKTsNCj4+ICsJCXNnX3NldF9wYWdlKCZmaXJzdF9zZywgc2dfcGFnZShzZyksIGlvdi0+YnZf
bGVuLA0KPj4gKwkJCQlpb3YtPmJ2X29mZnNldCk7DQo+PiArDQo+PiArCQlkYXRhX2xlbmd0aCAt
PSBpb3YtPmJ2X2xlbjsNCj4+ICsNCj4+ICsJCWlmIChkYXRhX2xlbmd0aCkgew0KPj4gKwkJCWFo
YXNoX3JlcXVlc3Rfc2V0X2NyeXB0KGhhc2gsICZmaXJzdF9zZywgTlVMTCwNCj4+ICsJCQkJCQlp
b3YtPmJ2X2xlbik7DQo+PiArCQkJY3J5cHRvX2FoYXNoX3VwZGF0ZShoYXNoKTsNCj4+ICsJCQlz
ZyA9IHNnX25leHQoc2cpOw0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQlhaGFzaF9yZXF1ZXN0X3Nl
dF9jcnlwdChoYXNoLCAmZmlyc3Rfc2csDQo+PiArCQkJCQkodm9pZCAqKSZjbWQtPmV4cF9kZGdz
dCwgaW92LT5idl9sZW4pOw0KPj4gKwkJCWNyeXB0b19haGFzaF9maW51cChoYXNoKTsNCj4+ICsJ
CQlyZXR1cm47DQo+PiArCQl9DQo+DQo+V2hhdCBpcyB0aGUgY2FzZSBmb3IgZGF0YV9sZW5ndGg9
MCA/IEknbSBub3QgZW50aXJlbHkgY2xlYXIgaG93IHRoaXMgY2FuDQo+aGFwcGVuLg0KDQpUaGlz
IGNhbiBoYXBwZW4gaWYgSDJDRGF0YSBQRFUgZGF0YSBsZW5ndGggaXMgbm90IGEgbXVsdGlwbGUg
b2YgdGFyZ2V0IHBhZ2Ugc2l6ZS4NCg0KRm9yIGV4YW1wbGUgaWYgdHJhbnNmZXIgbGVuZ3RoIGlz
IDMySywgcGFnZSBzaXplIGlzIDRLIGFuZCBIMkNEYXRhIFBEVSBkYXRhIGxlbmd0aCBpcyA2SywN
Cmhvc3Qgd2lsbCBzZW5kIDYgSDJDRGF0YSBQRFVzLCBmb3IgdGhlIGxhc3QgUERVIGlvdi0+YnZf
b2Zmc2V0ID0gMkssDQppb3YtPmJ2X2xlbiA9IDJLIGFuZCBkYXRhX2xlbmd0aCA9IDJLLg0K

