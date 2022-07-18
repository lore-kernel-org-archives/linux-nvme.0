Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC5BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hm0jws/V970cFwzEC+huB2Vu76kBMmtytU9X8ZC34i0=; b=EC32xtM1/Tek96cu9n7im5sE7d
	CdekLomGqxSW4/K+oza8aefjFO0qRfAJnhy0rCGcUYJpF8i719jaYyaZ6jU1FfYzd6koIHc1DcTcb
	/8z6ha1FYZ/2GvQsVX5LxuDkPUrap6FzehvdHN2KGiQPV+YKwBnecJeuJTHtK4dgmZDNyviAAOddo
	oiE0fdcfKoEoaIpD/XpDI2KSJBVwJ29MtpNIvKJTUtjILhl4o5iaXxRjxfSNWnoZQFUmr3Xq1R8qE
	WdxztK6C4EPCmId6ZUifdO+U1gqIEtNkgua7g+B1XUiBJ/5OoXainQPOQdxFR68p27xeZtG7jk5xK
	n3bGkAYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYMS-001Ysi-MX; Mon, 18 Jul 2022 21:33:04 +0000
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYMQ-001YrG-7s
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 21:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiA/GbrE8uHf3LJMOS6VkwTS4C1Wbklr4ttbCcDcALVU0gtfvEtD7AtDKYVXkU1ijQY/PtcoOQps9irY8NZKnDs7rXBGHxuJga6Xov6+yI92R6toWqG5eC0y+DkwSMwZLlJw6QUcjAjd1obpDVIsmLU3gZzdVVXBKWrCR1qO28dSYrVf5fNYZ7vKIKewPUjyUNwLH8B5MOEqV1iFtZy7le6HsuoxDtHxy2OZe3fXFPZugMDvcuPO214KIaQZTbkc3TmTi39FziixQgi42Th1cEJwNN0EL0939aW3ozbrkP6KFW5Io5/sb0x9P8nmkzyjuoYwNnYNBJ+Gw0f9sl1EpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm0jws/V970cFwzEC+huB2Vu76kBMmtytU9X8ZC34i0=;
 b=lbfVCvM/5fk29NYH/s0TTslAphVNAaZV4xPyn2X1PxsfKiYt3NoFVWG4VX4F3q8V+OJ8DxfAjDMody/UhUBrREZZJTkS+SDA7JoO4AFJLtjFmKEbty/lkBpUI9/jKaVKZDY4f5U+isD57UcR+iAtr4fgvtuL0KFc3HIZCL/k4qZYmySCoUI4YpRmIsEhGFE1Qe++GqxsRr5cxJhVfDolZVRNK9/qk2aXZzdYiBBq3DKmXD6YNXgIKp+UkM2YWhYgRiy1cv2oyNQYk4CfOwL3t20prWtPpMrTeJcLyWLmg7eC4JDnWAG2eKVQpuKokTfvYRY1rzhEg41bGg2PdHr1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm0jws/V970cFwzEC+huB2Vu76kBMmtytU9X8ZC34i0=;
 b=J9WFgAc89FKWtdLqAvB/1n+0/Op53sQlktvJmVqS9s5dl6HGEVFAxblI96TC+BSPwvFh29P/10mJqglUMP7erNTkZ7FtgF6jUH6VTGPi1uMQiI278MFQNJvhQ4V8eX+WtUHq5z6u+9Ax0dXDxEyy7Fb/kjpuObUWTHFcGJsGO3PCSrqkTR7n8OOrJM/QZd2Y2vOPVTGyXQvfH6RhAMFNHnmNwAZ9xCvpJZ5aQINTAaS2adiKzeV1QS/efUzA2+VsGiiJo7rhxxv/ZPogY2jd6YxcpS8yvUk2CG7QsDorPmP7tcFQEbY2EEgzG2y40APmyy+7TilNZ39bSv5YhOCzkA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 18 Jul
 2022 21:32:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:32:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Thread-Topic: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Thread-Index: AQHYmmPjeWiG+60xUUOXgWD/3jdZvq2Epx0A
Date: Mon, 18 Jul 2022 21:32:58 +0000
Message-ID: <f64c08f9-2e7b-f3e3-d24b-d12723406272@nvidia.com>
References: <20220718050356.227647-1-hch@lst.de>
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f06085-211a-4e60-5692-08da69051593
x-ms-traffictypediagnostic: MN2PR12MB3535:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  OBRdTHSuEW9s/s1RiHzfgQ2gapw15QUD1M+tBq2oKC1Jfu8DwPGA4cQdjKluJcQMgb11FVm1iejjEzEE6YAV0uBW/eN5j57z+PbcYmKwS36RcVCZPnuqNIUnoiXFeChhDqQw+/fuTEGoMFkMFHwqULiYPYuilr+BtCOpFtyH+8v2VZ0tkTP7b/upwymERGjdpLUzgb+PIoVGhJBFoxDOpuEjuWP+93eRcNi22FXLRjehvq3Q2beSqrWqWh1bh1G1Cf4HUPEmjznfHjcH/XBiCawpNVUZqtMnEGj0mMSa0zUkeXWeYq2FwtBvM/nSn6K51TX3gJI5VryzLMWu2+sPF768UkDKSttM2uTgUHhicehsORU4JV1kNwZFLV9fRA0LicMvTEQchHIqWXw98SjbfLcbRkYfWsSrJ0exEjbs+/prOzZjIfmTICL17RFz8x+4QQulkCO5pSuF3Sh4xElRAC0xEo/YQjcuc1evXv1HIU2vZOwZ7WKoHttsh0xLULfvhbHsCChPEns/TJAIdtwpgIhH/NEl8CwRPSxaFwBQodMK4AdMR9R7kQGxKGabD6gmy3fqI5O5Tb9qGSVy2QW2z5TPsT3jQucYgJ/aApt+Flj8EkAx7tkyd5sH+vfOhtNhlDQXwOBlrKkY3iQIP0dVlgwqghej+0KY4k8XIAXaxIFKqzIlWg+V5+xezlFuNtD4dFhlhWkDt+C+0nNQZuW/I6aUM2YxS5DQyLejSv53IPZlyQ7L6kKDw5BroUTe8/A2GwMrV/N5avA0Kq2VEHfChzdOjgmzE2/V9e0xSgHwf0mxUBJiXUvdqMeBZiue0IccmhWoYRBpm+ro0dWQyimKcJPeclJw6U6weToMTx7PxE6jAYkW9TZUgdAhHAE/tLhc
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(31696002)(53546011)(186003)(6486002)(478600001)(71200400001)(316002)(38100700002)(2906002)(6512007)(41300700001)(86362001)(2616005)(558084003)(5660300002)(122000001)(6506007)(4326008)(64756008)(91956017)(8936002)(66556008)(66946007)(31686004)(76116006)(38070700005)(36756003)(54906003)(110136005)(66476007)(66446008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VGtSdWE3Qm9ObXVDa3RBTkt3bWt2Y0Z2c3BmUGwxa2xSU1RsK29oOFhUWTZO?=
 =?utf-8?B?aSswbUxQTVdCQUl5ajM1WFFMRDJtMGZsNHdNZGFpS0E5RkZrZWwrcUlidjNS?=
 =?utf-8?B?ZlVYZnA0UFAvNEN6UnR1SHFJV3ZabmYyQllLbXl0Uy9pMXZUbEN1YjNxeUZ2?=
 =?utf-8?B?SE5nRGd4WDJUTG1EY2hLa2VJajVTY0FETzgzVzh6bmo3WklIQ1FQRGRMT2dv?=
 =?utf-8?B?RWx3eEJkZW9vck42cW5QVmlCb1U3NW1RVVR2cDRWeHNERkRiQ0ZES1pkTm82?=
 =?utf-8?B?UngyTTBnRFZGK0hpUGZlaWFjLzRnaUhWcFFFamQzanRGdlp2OUV2WWpjU25y?=
 =?utf-8?B?MHpwY0ZEcE1OSUp1aXQvTDFPbTVlN2tKUzkwZWdSVGxHSnVSd0R5ejJOTVZa?=
 =?utf-8?B?UjZhNThmTzdzOWJqUEhKcVVWZ1RUTlYrR2F0K0RZL2N1VXVUUC9CL1lzeHRx?=
 =?utf-8?B?NjhscEU5Q1hLZ05XWnordWxmUlhPVEVORmt3ekVuKzFWNGl5R0RMRlE5ZkJZ?=
 =?utf-8?B?cjF2cE53aHd3TnNYL1FqMm9XRkJuS25xblVIVGYzeW5BVTczVW92NDlXMnZj?=
 =?utf-8?B?ckZZZ1ByN092OU1YQUlHUDdSQkN6WHNtb05QK3ZBcUNOQTdja29qL0o0OWI0?=
 =?utf-8?B?Z1NSY1ROZjRWNXgzaWxmMGdFWUdqaUFRWlBROW1qMXpMZGxsbWVTamJsU09Q?=
 =?utf-8?B?ejJ0R0I1bDFsTGNUQzNtYkNEZlRoZjRzL2JZNC95b2ZJczE1MlhZSHI4M0Vl?=
 =?utf-8?B?TmdTb0IrTmRselNUR2ZaZlBjZlY4bDhGUkIxYi9SRDV3SDZtbGtUajhyWi9J?=
 =?utf-8?B?ZG1JQTVhSllGaDFLTEZTSmt3ZWNyK0RaSENlVUd4YlBVZWJ0UzBCVVpBYmdC?=
 =?utf-8?B?NXk0cng3M244WlEyZERuTnkyakYvU3g2Rk5vWmRVeGdBNVVLWUVneSs5dnVu?=
 =?utf-8?B?Y0pHck1yTXpsVTRyWUxsRlpqa3ZhRHRYTXpwNGQyaTdXV3BHaktSRGlkeUFO?=
 =?utf-8?B?bzAzWURSWmVpME5PRGZ5MVNQTzlhdERTdVAwanJNL1JwNHcrYmgvbWFESHRY?=
 =?utf-8?B?bHZWcUlmbTlQR2FhcnRFSUFOcTNBZXhWL0M3ZGIvbDJKMG84MitidUszeHJ3?=
 =?utf-8?B?djRVM2RJcStzMHVaeXk0bENwT1hIeTlPNzdCKzVPVzVFYU90cFZENlRDRXlj?=
 =?utf-8?B?MXFsemsrZ1ByR0wzZlRMU013NzZJMEVFQ21ObXBEdzNrcWtpS2hpSDJhdyt4?=
 =?utf-8?B?emllbVVVZ21UUzhtc05DMkFJVWljYzY0RnBOMUthbHpRUmY1R01oUmVLc09o?=
 =?utf-8?B?ZVVreUczZGw3YjJUSXZNWlhqWVhMcUtKSzJ3VGlJbWJYWlBIaW5BVnZBNWJR?=
 =?utf-8?B?bnMxS0RMdHF1WTJvbE43bWRsTUZjTDZsUTRqRXhHQ2VqeWlpT3JhYW0rMnBr?=
 =?utf-8?B?RXpUTjZlcmE4ak9RSVRSNlVBY0NOdFNGNFdDZFd6TlhCSThkYUNlc2lwV2xL?=
 =?utf-8?B?OUJ5SDhvaGJrLzZNU3ZkdFFNS29haUJXNnFBNnlDcmxQNjFTaVZrMWxUQnhG?=
 =?utf-8?B?YnZCbENSSTd4Q0xWMmlzWUY5eTQ3UzZSbmcveU1sOHlrY3FScFNpNzJzcEtS?=
 =?utf-8?B?b3JOeGhJaWQrZlZDeFN6R2w5bVI4clpoRmU3dWdOT3VaNjVCdG9xN2pUQXhU?=
 =?utf-8?B?NEpuSm04cDF3WlFWL1dSMi9RbHVhVWU4NTBrNFZIT0x1WEZlejd3TFN0R2JN?=
 =?utf-8?B?L1FXcnY3NWFHRXM0WG8vUFF4MTNzNTFjYXNwRkVpWTJTY3pXQzRuck9pTmRE?=
 =?utf-8?B?K3g4OHhESm5JWXBMYVpxQmtaa2FDQTRaYnF0dnM4VjZwd25tT0M5SGlvRHc2?=
 =?utf-8?B?TEdlcndZTU4zd1hnMFZQVjcvZ0xSUndYc2EyWnFRdVkraWl2c1lCZERUUzNP?=
 =?utf-8?B?N0FuZ21PTUZJVjliQlRpMEZnU2pJcXBWaHhiNzZJeHdnMjlpem54VmorUFdK?=
 =?utf-8?B?cGl3SmFRUXZpUmdDQm1pZUZid3dBSEFQV2UrNnFJazRtb3k2ZHNHbXN1N3lV?=
 =?utf-8?B?bWNSSGlURTBleEVMZzAySHNxbUcyZ2M4ZTlaUjVoQURVN1ExMHUyY3YzUGVK?=
 =?utf-8?B?TXBSUVFBQzZXclVEdTlXUlpZc2NXSlF6amttUk9ta1hzMzFXRk5tUmxieCtB?=
 =?utf-8?Q?YH95iy0lgEgdN7qT1KvJRwZ13+f1Vm1Ddd+eBlHhlGAe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8E70D410E628449B3C6572C6E7C62CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f06085-211a-4e60-5692-08da69051593
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:32:58.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXVZrczDh/N4iCPZcvkeQl1+uAntJm0Hc38uznDVSICtnK4dMK/TvOvHU9br3dO4ntioS3K7Ww9VEc6l8+kZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_143302_302535_462A8F99 
X-CRM114-Status: UNSURE (   9.76  )
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

T24gNy8xNy8yMiAyMjowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IGRoX2tleXNpemUg
aXMgYSBzaXplX3QsIHVzZSB0aGUgcHJvcGVyIGZvcm1hdCBzcGVjaWZpZXIgZm9yIHByaW50aW5n
IGl0Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5l
dD4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

