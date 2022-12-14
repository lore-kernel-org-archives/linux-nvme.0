Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427BBC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N3dKeIM3kxYbxpYY8g1yKeb3r7DpnTj/cgzBQvfSpuY=; b=5GfPCAIuSX4GGDgSD/Vc202lNY
	TVIk9dMnm5iUPggaVlm9NIWon910ntxheyJryB/SxpTxm++PCfCQeDkPByP2y4GOCU31lyxTX/7aS
	tdnTwUn5Vk7jHYbEBQ0WBm/Ikv8YbI3XKqqkC5XYxgPD1h1sqd42Oehc9IbIf+ae4OrEqiLpzi6SY
	cU/ruQKTJwQokE0Hmn+uTnyqFwbfrUWjvinm22+9qXqbBpP4pVdYlzbyJRWQtIDtzKhs8rDwYSJOw
	iiRtSCPL9TAk0rGz0iJ2peEJp/X9IobS7kC+19cBOWT3yRQxXEIJbIpM6lq0BCT4RjYtLunxgFaGZ
	76jgWWlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5JnN-00CIwR-MF; Wed, 14 Dec 2022 04:55:06 +0000
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5JnJ-00CIse-8y
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 04:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgCZ8pTEPWQvJqiMXjQh3ukUe067yhpgcWH0YA0l7JU+eo1r9i04zY9AZEYqBQ1uN+ktqyVgFbVj2qoMNy8b8SKGmf8H/US4o9Qem0bM/Y+QfVPIIVqKcQxMPQah4e0TEUj51fHIYXGKrWPNj2aGjbF2+dpghIE2wmeSDnAxxAU/unVHcgDtLaDBugq/gmx1qUSa4NWPAbAIXL2ifktOrUyW/AihiCrgbEuRBaiKrnnFZW8KIkIsa375k7vG7TEWSebS8jjlVIxImeKJJtwuw89s/WoL3h1ABYXcZI7ktYPAvTXGDe4If7vZaV7pZZ4oVNb/4S2+THKPrczwua6AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3dKeIM3kxYbxpYY8g1yKeb3r7DpnTj/cgzBQvfSpuY=;
 b=b/qnVp5Ui+TMiEjMNgXyiHkia6yJbVVmJIJBuLPFgNKo2FvEMEOwB9uRtsjdckdrOZsy/l7XzhBgOcPMarKWVZ1wk9CCLkVSZVhFC9w1CgygP1Uyr79oQcqmr0Q8REurZ2R+k90NxOEZqVCtcFz+65YM1PNGS0ft6uquWcFbbZ+JiI+/6xlI9gAwJrTg2lM6atz8yyFLz8MfO+UbhsG2IXIQyI0+/Q0ZhHJtQ9NZUPAplwosteDarWhEYJm33fai78sY86nbW9iHoWcs+TfeaxoLHmmTsvBI8TdIJHJMFq1WYW+0Of+ms944sqSBoLtM+Rm0LBhB3W0E20e1b2lnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3dKeIM3kxYbxpYY8g1yKeb3r7DpnTj/cgzBQvfSpuY=;
 b=CytXg8bdZirWHNezPywgGtJKNlpsSoJNNDMfRDfENBS+ieliWmq/VEs4FgTB98KnacrmwKZOPfOrzN3WEAiW80Im1lzqlH/O6DKWiBSNlrZ6NCfLzdvKgA3ysGKlrBFHX99h3oYRZEqLjRaqqpdlL4Vxb33ryPDjcT+jMlznjNxm05my3nXN2j0oeoxwdinHc69b/XopHQXGi08H/O5BsqbcDOnHhh/h8K8pa0aMn/QvIARPkwONQAJoT1ioyhKDBVGSVjgtt0WIO19/RE4MGYyXgtCH7fIwLqjEjySB80T+qH7DU0kyrbEQF5KAUyC8+VElFmi8NJrUOCHVuQI8hA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:54:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.018; Wed, 14 Dec 2022
 04:54:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/7] nvme: remove nvme_execute_passthru_rq
Thread-Topic: [PATCH 4/7] nvme: remove nvme_execute_passthru_rq
Thread-Index: AQHZDw95yMBayh/KBEiK7OEMcA1nB65s0k6A
Date: Wed, 14 Dec 2022 04:54:57 +0000
Message-ID: <ad01476b-98dd-a588-33c4-031243e985c6@nvidia.com>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-5-hch@lst.de>
In-Reply-To: <20221213162453.584965-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW5PR12MB5597:EE_
x-ms-office365-filtering-correlation-id: 722b64b6-972e-4897-8621-08dadd8f5960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  QJ+39zHrdijJKW4DfyveBZSrUCO0TMVZl/NHFclMQMNNVfMJCko7B2kathKP+d7PsEW/2PfBjbmdHhBx2g6uwLYDmxY0eDuSh5Q7BlT4VMUbvHUwkgSWLsZ3AiVQ/vywhqRYurzilKmlevpK05jTIfqgUwJk6LRUwCPDiCl67xVU4Re4LY7Lrq22mqBCFX+AAWg54bupGpezRnSfLUIGRu//kkGH/t9BkmR5yc1PR2mDacmXugfwrALuNWI59c0E8md+TE4Dzyz9hqPaz8sEqDWL98CWmdbHH2X90EXk6nzis+PiCzcaOiByAVNKXzpALfoAddPxrzs4A9ijV/2rnD73kEN0xnfVgui+SHdqIxCtqpLwMWomBpz4pm5JJ5lcqAU9oY/fhtk/VPiPlZ6k/EpViYcjoVsPck18LLkrUhSxDkSsDWnN9SlNc8LZEq2qbo/jl3y5oprmo+6VJGOx50spVCVt9d6yJozsCBi8Pes0HJgDJGUFYCG9VlHsKtafyNxvO5L4qUyOM4SAy5hMPEnD+8AXlZVip4oFjwETtxW4cDSiI6uP4zBC8ChdoWIhvCHJhuMxUzybzYrRsKEhFZNnGT0HRblWCjoxonzPxqFTBV+2AfJQFl9a4TYCuMDnjEh7jqIgd3X+6KP6aHhfxTzjeTkhjJTYQ2+5BA//8UMDtqZPKbsxN1gtISvgA7yjNPL/5AOIMOWToPSqEgrXchhXBqj1RubFs+W+mOPId5hC428xaPn9PCt9q4ie4dJx3gUee5cJUsAtJixKE4DwxQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(76116006)(558084003)(8676002)(66556008)(66446008)(66476007)(64756008)(91956017)(316002)(54906003)(5660300002)(4326008)(41300700001)(66946007)(36756003)(53546011)(8936002)(38100700002)(38070700005)(122000001)(6506007)(2616005)(478600001)(31696002)(186003)(71200400001)(6512007)(6486002)(110136005)(31686004)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cVh2MS85V2Z2aUc4bHdWam1xVnhnWjNMdXRLRHlPeERvMDRJZTJmTzk0MVJH?=
 =?utf-8?B?QmZwM1VvaVRMdWkvdGcyRTVpY3E3aGxrVHlPU2xwSWZjemZSQVZldElMd24v?=
 =?utf-8?B?Yng5VHUzT0p6VTJkMFp1NDMzTURzalRMKzdCWEFKT0JCZEdmT29zUWtRV09K?=
 =?utf-8?B?UlR2YmRtb2NvLzhiQm1vb29FVWthSWR3Y3FveTJXQjdOenpqU1lXdlpTRHdB?=
 =?utf-8?B?b243OXBNRFhmMmswOVFlcmdyR1B4SmdtM3ViVElsc1BjQmk5ZDRZMUtEQjRD?=
 =?utf-8?B?U1h1ZE00RzhmcUp1MS9qL2JCemhpRUhpN0dtVXBQdDgyc0loRjMvV1hyc1VS?=
 =?utf-8?B?MjcxRmZ4Y09LZ2hSZVFmZUFDcmI4eXhkb0JPVG5ZblhmVm44Ym9XOVY0WW4v?=
 =?utf-8?B?SzU3c3EwaTYwMThaSlR2ZmVZRXRMWGJxSW8wdEpyMUFJVnhvenNPNE8yRThx?=
 =?utf-8?B?c3JnRCt0anlRRi9jRkJ4RHJQNUFIK3BINWVnYzdrWFFaNmpYeEZnTEpaNC9C?=
 =?utf-8?B?akhmYUNXajRxQnlobDc5ZkRRVUYrNXd5NERhcVpaQWdxWlVVYmJsbm9Ddnp2?=
 =?utf-8?B?Nm85Q0I2TkRoSHNBZ2w2MVNORHlPQ1Rjem5iczNEdlQ2c3FYQ1JNbC9ZNnVV?=
 =?utf-8?B?NjNKdURDVmdUWXphTWk2N3A2QlhXbzFXVGtsVCtyUjIveEsvZUlXa3RnMlhq?=
 =?utf-8?B?d0Rtb1FXVGh2bVBNS2lFbWhEWjZFRUNwUGhTUUREWUlibEc0NzZNbUNlTEw2?=
 =?utf-8?B?QUNVUWZhUlZXWUlIMzIxV0hZRWs0c2xRYUY1T3AzenluaEFzaTBMT3VvRDNx?=
 =?utf-8?B?RGlYb3FDajRKTlhORHZBWU5VV2dSbjBvdEpRcUxwVUJsQmI4VENWSTlKZS8v?=
 =?utf-8?B?ZytOaGxkQTB2ZzliRmZ1M3JJRStRWmM3dUNMYVpnbjV3Ym9vcHlpeEg4Mk5l?=
 =?utf-8?B?WEw4ajJnWDQ4Yk9RdWZ1aUxaQU5udlgxZ0lVK2s5L2pwT1ZDdjFVeStLZmha?=
 =?utf-8?B?ZEZiS3hlOHpYRUc2ejZXVHRCNWVwQ3pmN2t5RnNJTWFBdlQ4VDZsNWxwQk4z?=
 =?utf-8?B?ZUpPSDdhNkpDdVp3MzZvWmV6bk5mSXFxY0o4SFlVTWRBd3ZEeExBblZsUVBw?=
 =?utf-8?B?WHVZcW5Bcmcxdmx6OHo1VVorS0pMZUV6UHdZeFpBWG94RE80UmtTVDRzTVdv?=
 =?utf-8?B?c0RjMjl0dVZDSUVqOE9JZnk2VC9SVnlkUGUrV01xY2NKZDRjQmp4MUQwNW5r?=
 =?utf-8?B?MmgrQWtHYzFsUkVrZmx4RzhzVDdaQ2hWVGVLUy9VMEp3amRHMmwxTEtielhy?=
 =?utf-8?B?N01aSHBWNVZleWc4blV6VVdCL2h3OFFKSnh0Y1ZmckgyaHZVSks0aUVocFBS?=
 =?utf-8?B?T3JMYzZjUWxkcUR2VUxpUmJHZ3dYRDhmT3hvYzhVMXhXcVJHVUNKcG1sTmJz?=
 =?utf-8?B?NEtLcUxISkwyL1Q3MUhaK2F2aS9FYlZQMUpteHNMaXN1UW5xRHlFcnVXNTFx?=
 =?utf-8?B?d01MR01LRFRPbnBlT1E3b0RsdjBZSm1tcUYrQ1ZLNmRlN1VZSGx4ang1TE9B?=
 =?utf-8?B?VmN5OU9tR2JYUWRrSDM5cGlLS2ZrTHFWUDl2U0RmUHlWRTdvT0c4S2dmS1Y2?=
 =?utf-8?B?YTYveXpyVDJONmVtZldkOE9XOFdvbWZZWUVFUHNYR09Db1c0QXlrb1NiQkd5?=
 =?utf-8?B?enlRb2ErMVlZSk5rRTVoY05uYTN5VHF0bGk4OXlNeExaNHZOMVJFdm1lZHJZ?=
 =?utf-8?B?R2R3TVpoYXQ2QWJ0aER5elZnTFNKUzMrcGI3T3V0V0c0YXZ2TTlXTTJ0Yklv?=
 =?utf-8?B?S1hSV1h2cmp3UDdMam5LdVN0OFk4aFo0dVNrZW9RVGYyY3RreW5BcTdYRmFO?=
 =?utf-8?B?SE5nUFZWL3czcGgxUG94MnMrUjJCUStaSDFPZDhyOUcwSzRSWlZIM01TTjM4?=
 =?utf-8?B?eXdEdkVCdThLL3lnYTcrVXV5TVY0UHkvcWw2ZEgzQm4vNHRGbE5ycWQyZklJ?=
 =?utf-8?B?OVpxc2NPaFBseHJ0anh0aDA1SzBodzhJRFRkK0hPekVtWG52MG5KdjhVTDR4?=
 =?utf-8?B?b1JuMCtEWGdBQnREMzRJYXQvTUcxZDM1cy9ZVXRxK21xUlArOXBidFhMNUlI?=
 =?utf-8?B?ODhWVVBsYm8yWGpYeFBPcjdGVU53eXBnb0RXZDRnSmh2c1RJQXNSOVZlNUxM?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7969637677EF9B47A7BECE35B9A5A222@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b64b6-972e-4897-8621-08dadd8f5960
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 04:54:57.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUiSVxlv1ZKjCAUHBk3Y2vKZ4nHdFyk4gBEA/joeIYiJQcDIe7t4dVHhrMSIkbSbda2ARKNJOWz23cn4rs5+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_205501_358719_5361DC74 
X-CRM114-Status: GOOD (  11.09  )
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

T24gMTIvMTMvMjIgMDg6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBBZnRlciBtb3Zp
bmcgdGhlIG52bWVfcGFzc3RocnVfZW5kIGNhbGwgdG8gdGhlIGNhbGxlcnMgb2YNCj4gbnZtZV9l
eGVjdXRlX3Bhc3N0aHJ1X3JxLCB0aGlzIGZ1bmN0aW9uIGhhcyBiZWNvbWUgcXVpdGUgcG9pbnRs
ZXNzLA0KPiBzbyByZW1vdmUgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K

