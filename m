Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6219AC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAuqIoeYP89p0L6t6k+/E5duaO01SaEm38Ijn8Ixe98=; b=YeZ1WhrXTCiPMzQUfroDVBbZP/
	R3pEVX1tpI2pt6teFoQwblj3QR0zPRge3tUO/xSSC1oUpAuPzkbStSXo3vFFwqY/4D4G3Dq3rxZ/H
	VZS1+jzCo8LG97YQKr4HoBXQ6i/9Ylos9/aZHquQESptizXaq9eOsh/bkaWpH/2npfRzCuRSauh9y
	NVIMMdTX4vYp+OnROdM2cVnez6xsxxOYgy9Zx0kDRzROgIo+Rn9xvWyusmxyfJMt91SA80MkwdERK
	sie6STHxC4trdWkMWaZNDyB5WMmglpORTp8DXf2Y+Ky5jNGRSRsX8aOxwVFlAq42MPquieOV0b1UN
	3s/vp0eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0eCo-003IuK-1M;
	Wed, 08 Nov 2023 08:46:34 +0000
Received: from mail-bn1nam02on20612.outbound.protection.outlook.com ([2a01:111:f400:7eb2::612] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0eCi-003Its-2z
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 08:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1VjXhv/lsdYU/bg4zrlLX/P2VcxCV7dZCxoDqMyALAyIEnyUp6pYHXhFmFAzSIwk3B/gK2bgdq8U68AafTNUeogsZgtQ7NvWF9KxnM7GFiB1xuhyV2jHglQUzHZPQcccS6QwKEIbJPfExTug2A+6e0UGUSlCOJ6nGSlftoib4QXwBYG1AUMF0szXo7hnFlfiacHVI5eFNrI/sQUoSHv6opfuEuZ2hAbmhyyFQ6wb5f8vZpaXqBWggEVGQVllSUy+XWMI3lqT0Rv5LwdwLUGbLwQSn6l3ZqegLxccn4DprkWeqGdxq13Ke8e1X7OOQ3BgrQ9kRTt9ntj3rKEzs9e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAuqIoeYP89p0L6t6k+/E5duaO01SaEm38Ijn8Ixe98=;
 b=EVWG2qC5yO/Pto4/AwbRL1M12phUY8Ot5F1a1PbcjdkJu5sXpXZEdVZXs3CvKmhkGvSu2+lWNpCfSrSuY6a1bxdjZiCLbSOnW3fME1t4fjCd+QoJ127Un1/Po631jkVvMnnN8sN/vpTFR1jHyXkABI+frag8MOTe2Do/X8O7sQkTM730s3PFiDXKmFm85ekMc3iOlPiB/9CxRKHo1k4Fm4T8HcsQshIJqxZpvuujHUUsB564enXVkuOEErYN+qzPgTM0FbFHjSSQCcUJg1Jjgaga7HPQZdpZ9/LkfdmEMxetpoUgEZzhwb2/j2yndTnsKeq07L9npCL+K8GrIkgGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAuqIoeYP89p0L6t6k+/E5duaO01SaEm38Ijn8Ixe98=;
 b=PhKI1p/bpTZqvlOpgb6USLsAeBQDbFhMiiv/vnj34P4YecjmsHIeS7OllpMTgCPRVVZGbPn51H/AdbHyFVN173eLkeLaGuOTBQ0mIo/4okEwuE22STnuymOmHjsGSd63NYbnLE57YKtI1cnAKRitWqE5jYrcrg0ltvaqc327spJEBfsDF7oIyjt3x7hblb6OnoyoEQpHOcBW/HirV/U5zxF8Uq6tDnfB+Rsgeuback0k53+qapfP2O5NwmGWESoVXbvpWuptn8vgrKAeb6/eJxbxNWhSuBgadpJDHTtsooIAhKIGpIN+Y5qKIC2e0y2jH0gykPrN21KQ0UwXYjPSiQ==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Wed, 8 Nov 2023 08:46:21 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 08:46:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alon Zahavi <zahavi.alon@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
Thread-Topic: [Bug Report] NVMe-oF/TCP - Slab OOB Read in
 `nvmet_ctrl_find_get`
Thread-Index: AQHaELZzBoRn8E2uo0yWhrH10lGud7BwHqkA
Date: Wed, 8 Nov 2023 08:46:20 +0000
Message-ID: <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com>
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
In-Reply-To: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB6304:EE_
x-ms-office365-filtering-correlation-id: 6e5ee8d1-4f96-4bc8-bf05-08dbe0372e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhQBHG/RYRcjIYRbPAUwKEk1DdTQM4mUC9PBQ3btNPHAPJakOr/YAjUL8rnkdBTgWIGSISividBGLOa1ngvNLXHH828B7yOIgcnALDAIR4NPAfiBoo9yQFlsq2QKJ2/1arE0XL5wStc5KRKjQtXrN1R6uay1E5sg3bnBFlz6dxzEKCxoPulIjLa24/LMG8n+foZ7CK78o3RAnEQPbmnz/k3Xx8tQbUALpPjD9SioIs/xkc44hBBxTqyW8plvd//i8mINFaDEAtQ5dpCiKT403jb4BB9fChQ/+59HH8859fE2rNghmf3/1boHOdkuyiM8NMsbzU/qW6HLDDApzEBJU0mJyEnQhKEwbSTZ85jn7Y7IXOx7qikatSHI1QVtU/9UMrKs70WCXdhFk1HFAbqFS/IBjus18+Dd4e6ccKRgfqMt5ojGHBTqQi3ZzVPN7pKfzFWu2lkCpjzLjCeVWhKeE4AQz1QWrm+/eGmSYV1kUw5xZKFpLuVCRJKGZoKTszf6OJX2DT/hozEArMcG7fj/j1BnNbc9q6IPNl6mVshXxABV1xkHHKfKS1svnaLDDO1iXIFElvzSQZt4TZ4C47UF8bP28gcSknMbq+tNxjsxSu6MqdaH2cBasV1j9OgU4bbX+o4aJbCIfqXLWBoE6hOTyQvWVeY3AynvD8CQzLR91Yhv3B7k85yKKVU5PVQe2ykRJyDBJ9OTIUacNwDvV6j3IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(478600001)(6486002)(8676002)(4326008)(71200400001)(8936002)(6512007)(5660300002)(26005)(316002)(6916009)(66476007)(54906003)(91956017)(66946007)(66446008)(64756008)(76116006)(66556008)(31686004)(2616005)(2906002)(41300700001)(83380400001)(122000001)(31696002)(36756003)(86362001)(38070700009)(38100700002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejJpc2NQMzNwWjRubFMvaDhQNVEvaUpQZ3lwTXpUajVzMkVSMFFKc080dElH?=
 =?utf-8?B?bGgrVnF0OUJ0WEtYd0Rmako3dXpqTzg2UDRoTTRPak45T0JtbGdDNHhzRW1a?=
 =?utf-8?B?Rjd0dlYwUFdjQVZNMzRzSytNRDFFeVA0Nzl3cmQ5RUE3TmhQMGFFbktjOEV4?=
 =?utf-8?B?ZVBzZktLR3BYV2tMOVJSZG81cnl3Mm5tc3hycjBRWEo0UFRzL1BDMTlDQUc0?=
 =?utf-8?B?bUZQZWozMzNuSFYrTzFZM0xHakJnR1IyUVQzS2FXeEVqU3pzMzZqd2tNVmd2?=
 =?utf-8?B?VHNieUhkaEduOWNqcnRLNVhrSXVoamFhRnFGcHZyYkxKYkl2TlZ4VWFHc1Jy?=
 =?utf-8?B?NDg5eXd5bm83MEh3RGpCZUNRMkdQZVgyZlZ0MkJodVhQd2Z3N0g4WG0xellt?=
 =?utf-8?B?SVN2ajdOV2VnTlZQYjJUWEFpUFpTS0x0KzZsUEVpdEZXV1BGTEpjMks4aHZ5?=
 =?utf-8?B?RFlVUno2Z1pBb3I5c054Vlhycit4RFRJMExpbVFvcEQwNU54UUJqd2lreDM1?=
 =?utf-8?B?bE84ZzhMdzIrSDVWOEtYSk1seXQ4VmR4YXlXMHRxampablZqcnhDamdwN3VH?=
 =?utf-8?B?eU9jbDQxekd3ZHFOcUxNRS9xTUprVW5lajhnQ0d1dHZMUzQ5TGFkblVsUG1h?=
 =?utf-8?B?U2lpcjlERVRicG51OTB5d3IvUnJQOGsyREp3SkpFdWFTUVU5dWZ2RTYxY01K?=
 =?utf-8?B?KzBETS9nTVI2TmxaL01aeUFzUTlQcG9oTFpWL1pkUGZXUm42YVozYlFOeGZB?=
 =?utf-8?B?ZEJ5WXlFbHhQVEZOTWFGaFlMNzMvUjA5T0VFNnpNZTVzYktZdGY4MW5tbkVl?=
 =?utf-8?B?M2VlUHNMclVXQlRJcWxYUDA5MlpNWG8xOTNxNnQ2VUlYSGtBaWRtSXVXSnhh?=
 =?utf-8?B?S1RaQTVCRURuSHQwdWVuclhIMjg3SWkwcmx2R0IzZU5KQXMwY01UVVV6Ykta?=
 =?utf-8?B?bHVnYzZnRHhsalBQQlRXNDhreEJlU3pYbHBoMGVVcmEzOHMvTnpmTjY2bE4w?=
 =?utf-8?B?VzNMNXBORjJwZmxDcUpYVDRadW5yYXVMeFZ0RnhOS093d0wwWFFacmdpS2F5?=
 =?utf-8?B?UHFHdUpjWWZKRkcrVEg5dG0rM0gveXVoUng5UGFRcDlUU0JPNjZ3YnNjTDc2?=
 =?utf-8?B?emszY2xueWk1aGdhNUlVWmw5L3JuTU5XSCtjM1RRQWxNTkVVMW43cFp5RmhQ?=
 =?utf-8?B?Wk5sbVBEQTlLZnJEcndnYUZGemdwb2xJOEdvcTRSRmcvRlliZjlwS00zbEUr?=
 =?utf-8?B?YU1ZUlU4MStSTWxhYnpIbk5VT080YlpqbFRTdTV1VUlZY25VMGxLRGIvcUFZ?=
 =?utf-8?B?QTdlU2V2WTlxMGVVRTI1WG0zdkN5cGhCWUFjSWx4MnBhdS9yUUg0cGRCZHBG?=
 =?utf-8?B?ODN1N0grY1ZBQllxWUVjQURyQ0FtTzhvZWRxdmpBaVhob0JVYVJiSHFqVG1v?=
 =?utf-8?B?WTFtZGVMQzE3WjVEZGg1Wk9Mc3RuZGZvbmM0YnlieTVpakZtWnVuenJEbEhJ?=
 =?utf-8?B?VUdSRkJ6SUNXc1lWQVNGY0pVZ0x3a3d5WlhXbWVFM09wem9FWmRhVytmY0hV?=
 =?utf-8?B?RzRTUVdmRHErV1JGYzYvMGRKN0lpUkdnQ2I0ODVrUHpnVWZGMmtTWWswdktx?=
 =?utf-8?B?VEdTemVvY1JaZTc3aGNaMC9vWm9UeXJhN3lPWkh2K0Z6NmlLU2J4RVRpSXc0?=
 =?utf-8?B?STgveEhhb09WQlhOMjhKbnlTb3JBMG9iK1czODNmK1BpSC8rdDdDRlp2M3JJ?=
 =?utf-8?B?OUFON29IMmtlcXI0QWhRdFE2WWNpYmNoVkk4dEdQTHRpSFpTRURpWDdDSlFx?=
 =?utf-8?B?VTBhQ0dncHAycGwwWXZoREU1TTYrTWIzd2d6RDg1WGpTNldaOFY5WnhxNGo5?=
 =?utf-8?B?UUphV0JwVktwWTRMUy9aUmlVV2tGTGxBVEQ4VkpwamVrVFFZUGF3ZFNHQ1c2?=
 =?utf-8?B?TlFMQnVxbmY1KzRTUlRTbGFNcnhPZENkdEU5UUpsU0pHNmhWekpkbWZHVng0?=
 =?utf-8?B?Rlo4WHlaamVtYUNDZW9iakV0ck5hNDZoRjVtb3Z4dFlzTFQvRUFPVEJXSHZF?=
 =?utf-8?B?dy9UallsVzdXSWJsVzNZdllINnVqYWZzckhLbTQ0TjNYZjVSbFBNUHZQbzl1?=
 =?utf-8?Q?wnvEALASZ8iblzr4MLsZyQGCW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC899B34FF1D64DBD8EE683C6332BD1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ee8d1-4f96-4bc8-bf05-08dbe0372e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:46:20.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyWPxfSk5TVIsAhNXa5fJuriLvLooXYCXV6zk1y+CJdYY8Rziqz9Y3I7GqslNvS4j42w3PEa1EiAZ2z0Vft8Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_004629_107148_26D83A49 
X-CRM114-Status: GOOD (  13.79  )
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

DQo+ICMjIFJvb3QgQ2F1c2UNCj4gQXMgZXhwbGFpbmVkIGFib3ZlLCB0aGUgcm9vdCBjYXVzZSBm
b3IgdGhpcyBidWcgaXMgdGhlIGZhY3QgdGhhdCB0aGVyZQ0KPiBhcmUgbm8gTlVMTCB0ZXJtaW5h
dG9ycyB0byB0aGUgc3RyaW5ncyBpbiB0aGUgb2JqZWN0IHJlcHJlc2VudGluZyB0aGUNCj4gYHN0
cnVjdCBudm1mX2Nvbm5lY3RfZGF0YWAuDQoNCkNhbiB5b3Ugc2VlIGlmIHRoaXMgd29ya3MgZm9y
IHlvdSA/IGl0IHNob3VsZCBhdCBsZWFzdCB0YWtlIGNhcmUgb2YgdGhlDQpzdWJzeXNucW4gYW5k
IGhvc3RucW4gYmVpbmcgYWNjZXNzZWQgYXMgTlVMTCB0ZXJtaW5hdGVkIHN0cmluZy4NCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmMNCmluZGV4IDM5MzUxNjUwNDhlNy4uNTY5MDQ2YjZhMjY5IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29y
ZS5jDQpAQCAtMTIzNSwxMyArMTIzNSwxOSBAQCBzdHJ1Y3QgbnZtZXRfY3RybCAqbnZtZXRfY3Ry
bF9maW5kX2dldChjb25zdCANCmNoYXIgKnN1YnN5c25xbiwNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN0IGNoYXIgKmhvc3RucW4sIHUxNiBjbnRsaWQsDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQogwqB7DQorwqDCoMKgwqDCoMKgIGNoYXIgc3Vic3lzbnFu
X3N0cltOVk1GX05RTl9TSVpFICsgMV0gPSB7IDAgfTsNCivCoMKgwqDCoMKgwqAgY2hhciBob3N0
bnFuX3N0cltOVk1GX05RTl9TSVpFICsgMV0gPSB7IDAgfTsNCiDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbnZtZXRfY3RybCAqY3RybCA9IE5VTEw7DQogwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWV0
X3N1YnN5cyAqc3Vic3lzOw0KDQotwqDCoMKgwqDCoMKgIHN1YnN5cyA9IG52bWV0X2ZpbmRfZ2V0
X3N1YnN5cyhyZXEtPnBvcnQsIHN1YnN5c25xbik7DQorwqDCoMKgwqDCoMKgIC8qIHN1YnN5c25x
biAmIGhvc3RucW4gbWF5IG5vdCBiZSBOVUxMIHRlcm5pbWF0ZWQgKi8NCivCoMKgwqDCoMKgwqAg
c3RybmNweShzdWJzeXNucW5fc3RyLCBzdWJzeXNucW4sIE5WTUZfTlFOX1NJWkUpOw0KK8KgwqDC
oMKgwqDCoCBzdHJuY3B5KGhvc3RucW5fc3RyLCBob3N0bnFuLCBOVk1GX05RTl9TSVpFKTsNCisN
CivCoMKgwqDCoMKgwqAgc3Vic3lzID0gbnZtZXRfZmluZF9nZXRfc3Vic3lzKHJlcS0+cG9ydCwg
c3Vic3lzbnFuX3N0cik7DQogwqDCoMKgwqDCoMKgwqAgaWYgKCFzdWJzeXMpIHsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigiY29ubmVjdCByZXF1ZXN0IGZvciBpbnZh
bGlkIHN1YnN5c3RlbSAlcyFcbiIsDQotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3Vic3lzbnFuKTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdWJzeXNucW5fc3RyKTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmVxLT5jcWUtPnJlc3VsdC51MzIgPSBJUE9fSUFUVFJfQ09OTkVDVF9EQVRBKHN1YnN5
c25xbik7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KIMKgwqDC
oMKgwqDCoMKgIH0NCkBAIC0xMjQ5LDcgKzEyNTUsNyBAQCBzdHJ1Y3QgbnZtZXRfY3RybCAqbnZt
ZXRfY3RybF9maW5kX2dldChjb25zdCBjaGFyIA0KKnN1YnN5c25xbiwNCiDCoMKgwqDCoMKgwqDC
oCBtdXRleF9sb2NrKCZzdWJzeXMtPmxvY2spOw0KIMKgwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2Vh
Y2hfZW50cnkoY3RybCwgJnN1YnN5cy0+Y3RybHMsIHN1YnN5c19lbnRyeSkgew0KIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3RybC0+Y250bGlkID09IGNudGxpZCkgew0KLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzdHJuY21wKGhv
c3RucW4sIGN0cmwtPmhvc3RucW4sIA0KTlZNRl9OUU5fU0laRSkpIHsNCivCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RybmNtcChob3N0bnFuX3N0ciwg
Y3RybC0+aG9zdG5xbiwgDQpOVk1GX05RTl9TSVpFKSkgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImhvc3Ru
cW4gbWlzbWF0Y2guXG4iKTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCkBAIC0xMjYzLDcgKzEyNjksNyBAQCBzdHJ1
Y3QgbnZtZXRfY3RybCAqbnZtZXRfY3RybF9maW5kX2dldChjb25zdCBjaGFyIA0KKnN1YnN5c25x
biwNCg0KIMKgwqDCoMKgwqDCoMKgIGN0cmwgPSBOVUxMOyAvKiBjdHJsIG5vdCBmb3VuZCAqLw0K
IMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImNvdWxkIG5vdCBmaW5kIGNvbnRyb2xsZXIgJWQgZm9y
IHN1YnN5cyAlcyAvIGhvc3QgJXNcbiIsDQotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bnRsaWQsIHN1YnN5c25xbiwgaG9zdG5xbik7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjbnRsaWQsIHN1YnN5c25xbl9zdHIsIGhvc3RucW5fc3RyKTsNCiDCoMKgwqDCoMKgwqDCoCBy
ZXEtPmNxZS0+cmVzdWx0LnUzMiA9IElQT19JQVRUUl9DT05ORUNUX0RBVEEoY250bGlkKTsNCg0K
IMKgZm91bmQ6DQoNCg0KLWNrDQoNCg0K

