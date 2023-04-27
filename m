Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33054C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4kl0MTe9SFzjNZpICU/w7xHflGj1I/iizCnOnVpLNVM=; b=whwPA7aijK3ZOO4kw+Zvkttc11
	tjzn+ooCK5VgtrxvAeFzT6xlCgS1f3fXGV0b+M8uLPEgWRbAfVZkZQGsteCGQbpkTvTPlDO+XbM3Y
	PRY/x1YZl6EIz58ikyxO7jBBJyfHfrlor6e+LhwkfZD+94Ovq5QmGK14fghBhQef9+KtVvSbt+K52
	TewA1IYNwylnQLIrrVtmOFxRVkgWHdAn5TIBfcfm6yL9M3FAfhLzbbMGKQHMhfyWowDhS2WglBs03
	Z+DCAfHbrnsWOyY/0OsC/NxEgB5MwMIOzGJTuC/AkiXncB8BfcKUDdu2Kh08hOvvm68hV+sKlbN2D
	hOD5EM4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psAaL-007kF5-1I;
	Thu, 27 Apr 2023 22:59:33 +0000
Received: from mail-bn7nam10on20605.outbound.protection.outlook.com ([2a01:111:f400:7e8a::605] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psAaI-007kEG-24
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 22:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbOjMKmcwWkBwlOzTHrGyrnHDoPXNkYiS/eqzZALTwyXTEBsxYqvr0+FgaNGfmI4KuQyKKdZEJU2qG367AM2wKMV/4YBtE90U2br+HQ/JtFrndpPuCzYkRxFpAFO70FgWH+hu8lf5xGz9liAd9IVuZjKoiGX1XRPoBfXdSU/9K/uLPvAJNucehtwBJxF6ALKJ6ytRWRO7GrDk0csTbo3DjMYsCo2rcbb9h5sUY6XptOoj9yfY0WOxRpz5f8WvlMSpGU2/sK/ypSv7k7913B49mh+9mnvylnFD5xgSmYqFj0gcMx6AuzOwYusvFKzJT8Th74D/FTlAYzA6JReaPoL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kl0MTe9SFzjNZpICU/w7xHflGj1I/iizCnOnVpLNVM=;
 b=bfK7IlpWqud7XDgC0QbARQ2ahwS2LhIEc1cOZ4+gVF4oNkD6ez16CjH5eiwj8U7jkkXd95TpITS+hjDnRFD2JBs/bG144D88r3sihVulyU/80qpjHCFxib4w1uTEKsUs+A3YSQj1S3jSnPGrBnOBGPqN6+yQaMbRv1Br4d6BHF+KUronOiNqZGy7oadJEhmyj6/0BwBb6O3r5nT3z9EMPuYo4ny6T4gB4SOUOYZF5Qq6b+5MgldjEDtBN1etW8EzhAF+4NvuMxaIybx/DzfN+H3CklTY0ClwgIHuE2ZdTh9y6kLVnJzm7WYHZFAnkm8IHO7RBjsysfkG79O1w/OhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kl0MTe9SFzjNZpICU/w7xHflGj1I/iizCnOnVpLNVM=;
 b=B3mf3KyiiOHxIZiRQ2RDNCGgrg9YM6r2Oi3e13UrJMVcr2Qlm0v4r0H9jJWWT8U1NudJQYyQz4xAkgnmQYX9vHa7MJHw6u5I6vQsKrk3mLQq235vKkxow5VrAnLgKPkJcAoeOLVFAmumP2RX8V1TgkwF+uqyWdc8yZhUSRRiyPZeSEMi/s5gHM6o0MPjHMcU38nP/xEhL5SaPdvZUO1D7eWczzB1dRmDS7s9hhgVCtJGT1czRGnrRDRDUO1dv5/JvKZcNCXyaMZMgXne9s+AtLzuAWw1fu6wk70wCsNalFJ3w13p2aIxdl1mPxiEhLTH8cBfoqZE0EgjrnwxhCJzeg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 22:59:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 22:59:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Topic: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Index: AQHZeUEoV9vRcEcRDUeYawN1RnJsFq8/xVEA
Date: Thu, 27 Apr 2023 22:59:26 +0000
Message-ID: <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
References:  <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
In-Reply-To:  <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5815:EE_
x-ms-office365-filtering-correlation-id: 0518450f-6451-47a2-78f5-08db47730ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  r8DhI0f0o4DfwZoFXb8nlZgBQm/zrZP0iDMXFCGiCDKTxo0ckLY95+065OpPafgHe8tg1HYSRhJ4h3PNE/jxEIc/HIi2vrhaQwPenAAgcu/ZYv8EYfW+Q2OA/1vYL8mbH1w9NzSSYI0PinW3iYpG6bDxnNhswTwxVFPO9fCjoU9ZcsG2EN+mP8ddE6Mtg+A4piy+31ep5czrxf68xBsyIfIX5zVmgACyzhYVtCG32MvqDtbv2H9DUmv0Ii1UGWoN1zZnE2fSvpOwL/k9/H535I70bPIzsVLOsvZR7fbV785R4nO6IqnIs+kSDWT0MQEf3KoSzIW8wghY4sGabmC60kd6BcxC9gnITpM/RmmBl9azUVv/+iwPpfiie4ZKkSzDhlpn3HwtSTLLKE3ozLP6x2Oxw3SaQaT+MS6cbofWxr4wrfjB+8qnlIu8V3hhbd5kclIjgqW75NWSFLroSw7IrL71BBM75tVmmqlmJ7aMPl8U+eX58a412jOUKAFnZpzhks/Rp+QzrqvJBwNhmA9HQthU7XbYb3sLKLYtZBHdkmB6qsWPVHVxyx2iJPbv0zVuHA0BgZWYaA+acdmfp+0M4JLdYcjuGd0Odqln24VJK4l8ApOdOfKH5gPsME33bCdg2UK/DvXVElVudC2K+qWGD1EMG6ZDzGLmIQ8ks4PiJKAXWbJ+hxoC9Ym4GAhvqo3f
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(54906003)(36756003)(38070700005)(31696002)(478600001)(86362001)(38100700002)(122000001)(8676002)(2906002)(4744005)(8936002)(6916009)(4326008)(64756008)(66476007)(66556008)(76116006)(316002)(66946007)(5660300002)(66446008)(107886003)(41300700001)(6512007)(91956017)(186003)(53546011)(6506007)(31686004)(2616005)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?S2MwMkVDeFh0YU1SQnJXL3VqUlJzZys1Z1p2bFhHUHN1c1huZzM5YzZ2Nndz?=
 =?utf-8?B?RytCRHRRQ2x1L2xCS2p3U2orL0pUb2N1YUZhVWtMTUtuN0lHZlF3UHlKdDRt?=
 =?utf-8?B?TkdNVXBtRFlHTzNDbWFrY1lOMkxldjRheUc4UHFjRnZGc1pVOG56STVLZEZ6?=
 =?utf-8?B?SmlzRTMrM2lFblVVdWp3eVNFWGhvSkxQRmxzaTJzQ21NcStTZ2FZa25vKytM?=
 =?utf-8?B?SDRHMVFXWENMSXYvWWhiQTl3V1IyVExuZVljOHlGa1kwOGFpVllXang2KzJM?=
 =?utf-8?B?R3gwM0JwOXBvMXc5VGo5YlhVQjhNNUdmTmZwMFhUbDVzdGNSZmZKNFliVkNG?=
 =?utf-8?B?NHFWL3liU20wUEt1ZFZXeEZSclhXK29rcHJPckdOR05aM3lRSmpvSXhjeUdV?=
 =?utf-8?B?YWJFMTIyVEdwVHdpT2FNTlRLVHNaR2dBdWVpejZGd25mOFhwZUh4MFZqaU9n?=
 =?utf-8?B?b3crT3pWc05Eb3BIbFRXM0l6S2hNdG9VT0UyQk8rY1hndXdLK0Q1UzY3am5w?=
 =?utf-8?B?bFlSNmg2R1l6bWlJMTcwbFQwVEkxWTd0SzJBL0I4dnVFelNRd3NRcTRuZkdS?=
 =?utf-8?B?WldKMEdQemhpaUVKTjNITkRMYmtrNlkwMkp4U2tjZVF4Q0tJS3prN1BTVFlr?=
 =?utf-8?B?TmMwc25qalI3dGlYeFdrK3ozR0NvWm5aTDlzMXZTeXlvVkg2L2xwWVJSWjgz?=
 =?utf-8?B?TWJRNFdhamo0Mk9hdjN1VnpTZjRobGhiVHRSTG4wZDdJTVZUeHI1TmRzSUYz?=
 =?utf-8?B?V09DZUxhYnpnaTNWMURxYUJEZVYrTnhNZ0VBMWh1SXIyV1g1eFZsbWdCWWxN?=
 =?utf-8?B?dXI5SVZXczNOY01scWZaTUJCMHl0Q3BXak85VVNYUEpwdGZZQ0xTNytuQlFC?=
 =?utf-8?B?NWRqYmNvZ3EzcHY4WjkxOTJSQWZ4STBldXpPeXBwOWpoS05Vc3ljYldsUnBj?=
 =?utf-8?B?blQreEkwRFVHMXNFZlZLMzFIVDFUb2ViRUp0SWJ2M0xIQWVuV0NsZ3JMTFVx?=
 =?utf-8?B?VkhXb1ZBOExRYkhRR005M0FGU2NCU3dUV01YcnVVV1h3WDNUOEZqbWhqbUdB?=
 =?utf-8?B?Nm4wcFRhNUdxZEFBUGxqbVpmWUk5OEppcWtCRENQZ2RzTFZoSlZDZ2Rtam1z?=
 =?utf-8?B?L2daamQ3Qjk2cUtuaUNVUVhMWWRJYzFRUDNuZlBLUURDQmJ1RlcwalJ3WUJB?=
 =?utf-8?B?YW9aMzVkSDJwWFBhVXBnMGc3SVJTdHBKZm05MTQybDYrdjB6VUFiaWxzSTJ4?=
 =?utf-8?B?d3dBcU03OFp1V2Mzc3RqSTZLZXF2bnZKdnNtcVNQbjlXUUNPcWJCQ2VKbTVm?=
 =?utf-8?B?NTBYQ1lCMmllaTRlN0pZQlNyQ1E3YXFVT29ocjZnQ0JCcEhDeVJHZ0N2QVRl?=
 =?utf-8?B?aUxibVV4cmRxQnkxY2ZVdW5MM2JSNEJNWlh5WVhTQmlPMVlMWCtvL0tJeXI1?=
 =?utf-8?B?Ykh3c3YyVzNkV0orRU1KRzU4VlVCMUNTanV4UW1KUmNRT05JM1ZYcHM5cHp5?=
 =?utf-8?B?VjJWYXlhYitnU09XYStlaFBRMlpDaGJ4aEd2WXFJUWxOYXhjZ3VQSG5rT2FC?=
 =?utf-8?B?UXVJdXVpZGdOYjJxMStYRm9icm1RK2tYK0ZYQnRwd0VpbitoVGFvc3JSTEJI?=
 =?utf-8?B?K05nbjVtUTNTZjlrQ1NSUjhDYVJ5V1BpUFIzbFBlNGVjMnJVdWJ5UjFFRkoy?=
 =?utf-8?B?VGZkM0V5T0xRK0pOcVJXWkNVLzJYTnU0N3Z2VnZIc3NSYkEyQzNxYjl6d3dJ?=
 =?utf-8?B?eFNOYTNEVHN6TVVzR1JDZHNaRkZlWTlyVDNodG9LQ3BUdE85QS9lOTlHamdv?=
 =?utf-8?B?Nm84dmxDdVFmSHlZcmg0VTVTczk3b0RjRkhGUm1hVjNMZjFxUUlvd3NUUFNN?=
 =?utf-8?B?U3hBSFZ1dU56TllISGJZRkljTWpXdy9Dc2xGbTJXL1NUZk5KdmcrdTFDNE9B?=
 =?utf-8?B?RFJJS0ZtLzIyQWp2bExGMlVzNWJCQVpTdmNTc05WdFlZMG4weStac01ZVi9w?=
 =?utf-8?B?Q0IzOWlDRlVmN3ZqbHU1YncxaUpoUVgxSU5rclRNaE96c3RWQkZ0TDdJUTdn?=
 =?utf-8?B?VkZqWlB0Sm93djdUcmlCTkNHWDVqQWQwdW5wTDBiclExMmxLbXh4TmpXQ0pX?=
 =?utf-8?B?YTJ2V0d1YXVEcHBqMDNqUW5jcks3RHlxMzRNNDdFNUZMSXJXNktMcW1IRkZs?=
 =?utf-8?Q?w9V803KWSk0FxS3X7n3vFHvcBSAE5f78QiOfuGfdqpaW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B64E854DA81E49AACC72BEC5D12C22@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0518450f-6451-47a2-78f5-08db47730ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 22:59:26.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciWXSPkW4osnPqFtDeghnbZ3A8dgXqbB+eoDVO+LG2zIq0J4v6s9HsmS8uISp5vb1y2JP72l7RKydelubkluTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_155930_686414_5E74674D 
X-CRM114-Status: GOOD (  10.78  )
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

T24gNC8yNy8yMyAxMjo0NywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBHcm91cCBzb21l
IHZhcmlhYmxlcyBiYXNlZCBvbiB0aGVpciBzaXplcyB0byByZWR1Y2UgaG9sZXMuDQo+IE9uIHg4
Nl82NCwgdGhpcyBzaHJpbmtzIHRoZSBzaXplIG9mICdzdHJ1Y3QgbnZtZXRfbnMnIGZyb20gNTIw
IHRvIDUxMg0KPiBieXRlcy4NCj4NCg0KQWx0aG91Z2ggdGhpcyBsb29rcyBnb29kLCB3ZSBhdCBs
ZWFzdCBuZWVkIHRvIGRvY3VtZW50IHdoYXQNCmhhcHBlbnMgb24gb3RoZXIgYXJjaChzKSB3aGlj
aCBhcmUgbm90IG1lbnRpb25lZCBpbiB0aGUNCmNvbW1pdCBsb2cgPyBpcyB0aGVyZSBhIHBvc3Np
YmlsaXR5IHRoYXQgc29tZW9uZSBtaWdodCBjb21lDQp1cCB3aXRoIHRoZSBjb250cmFkaWN0b3J5
IGRhdGEgaW4gZnV0dXJlIGZvciB0aGUgYXJjaChzKSB3aGljaA0KYXJjaCB0aGF0IGFyZSBub3Qg
bWVudGlvbmVkIGhlcmUgPw0KDQotY2sNCg0KDQo=

