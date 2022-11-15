Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B27C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZ9qlD3ML5f781ajIIAa3oKh+7PhYp8WScvmU5kv414=; b=oVORpMCGx2kvG09/D6b87Y5tCN
	rJ9W3pFH6ZWRsiS2uGCVDA++3pDXoUwEbZaJqdrEG0ILxrQpIXHQ1uWFVnoAsx2crea/D7S7Ut6pK
	3/VON81vKzhN/62quvjBxDKCuNNgxpU+eTcerfmQN2LNqGshOmNGRsL5skgHMGVGwo0Kv7zO/VsJo
	NQNWfGVxFieTk5GyZi2RDqHeSR8nHkT/PPXdWe17/vt6oIeTgpSVZk+tB2TnXmoX7DbdkwVA1wgIy
	gl51XNk8voQdvNHT0iUmgAjgDIYuqVNbS9Z52iynK/+7IYx9epJHD29hmenS4LaXSXKSS36UV4FSQ
	3wxrfZPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounJq-007Xl7-T6; Tue, 15 Nov 2022 04:13:06 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounJo-007XUR-1h
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnkW/tHwQv6rm9xjnrLnYjUXzVP/6ustlipOggC04DJVmMA0u/cqMd4WNVmZrl8Bz/ukmyWLKs4ek6sgCCyt5E5JnR8hB8rjv5ZZiHW5fIeXaiTF3BZLPRcD6BqvjyCNROPyrXPWNhRoWuyEGpJC8GqmNZKLgpaCE3y0V2b5f5YDhHphUkA5Q/tf76oCV7Ozx/fqjqyyvi08CZMjgZ4QzyIq2sfsa7A9ASFCKgABJE+JM/rHCMEqcN/aWtZyuRL4ZiBINkjy+EuNm1+tFGSaYoeu3KMYCpKTT+2xUTuQ9lout0n1UjEjAkohQcFGIowIBQx638/+m1ux5WCZmllD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ9qlD3ML5f781ajIIAa3oKh+7PhYp8WScvmU5kv414=;
 b=haWslB8b0yfT00b0Wt0+qT8X09Aw37bT/jlvg1Uj69EJwWUa92SOwfo02jhizOsZn0e97I7Msg9BOsCtZ0GKOffIDqsAzkMMrk33Ba3WHqdbNP8CnOY2GlR5hHRcVNeD4ULKkbc6e3yZML0B9syDUu5UL06kOIBF5bgIDPZlnudvW4xDZLO1IultWph+MeGN6ziQJRuCwY9Ab37729FHbH5QM8nXaskQERZKH4h30/Oy7c24U02JaiXw+EBz0+8n7E+qshBlj69f5klEwwAEv85dxWXqyhiZ7Bnq8Jib8K8tkfFiYoO3Mn6yXE1UA81136tS8jkf9UylKnXPpiGPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ9qlD3ML5f781ajIIAa3oKh+7PhYp8WScvmU5kv414=;
 b=BhoCRSCxW0DNNbOX+Bn3iPVlWahJJ+hc1QWvkPnwrPtB6nXrRroRCqbV86cQOCfteylr7Byg+7efpjiM2upN4Tt6kTujVnVeOvWnJymBO4A4QqFBxeWxHFefPPyKOa+trLQyhQb+rv+6XC5M7MfFjDqwuvmdAolISGdh5iSSUICBZGRt+s0nJI8V7z1+wpaMd/68yuCQqJz2eMtLUtjRBXe92k7hU2oKxAFbkCIboPjjIdPLeidrie1Q+K0x24X3IoSY5F3FUxTz09OkzhQcIoF4UWs01QhYvYWbGNNHO+hPR1ooVOKgt5gk5K7RHzjlddYf7X2GGOJbIVaT3nGZjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:13:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:13:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Thread-Topic: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Thread-Index: AQHY91NgBR8AU9uY20eZH7y0lFSO7q4/YnEA
Date: Tue, 15 Nov 2022 04:13:00 +0000
Message-ID: <1298ed0f-304b-d806-dc2b-0419795932c4@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-15-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-15-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5997:EE_
x-ms-office365-filtering-correlation-id: 884edc9c-3a49-4ae4-3557-08dac6bfaf61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  AWQEmrC5ZvHzWtK/d692tw8kFqJQ53Yl0lCWET5qQhI0mnF94CgDYCCjaC72kNprKjrAQ/wlXTM/RltGoABvCgaZ2rehni/GHvurw3pMTUx+K0PkSEIjRzaIhaqZW2DYo3M9yzKE+2J6gWgh5fidDdSC3gaPzhH2k3qUJkkMRaQEx4V2u9VEb+hQoXSQSDX0xM7/B5UvTYAYK7Kl+sG4IwMSsmDB/VojnJTZnL4c0UQzkJmA4zmk3dkoWi0a1Zv7HROksgGgSL0JRop/6iEQpMfEBWqfqA6Kiq6ifWvZJpISp9HC03g0ayOQTHfl0Nz4nvvBKgc+1vlVmMm4IJ4bS69yBrbt/HRH2lTYWw+3eRWiq1tRjNQvTJVp6JN30jPOeKpI94zlXijjz1l+NHKtETMXhTH45z5pIUh0iqTMGdHh1lfUy6czStwOFrtHACU+XF5kJEj+VZmKgrTLxbKaQ9mjoDsqLa76UVSdHgjeOdz6JS9ONfoI9nKWZsX5WwcCuE8uKGki2oaIvOqE2d47spsCTV1M7PjnMcU3K5bI4qfrAzNBh4kC5HzOIy1T0VxX3soS7vbaoaEfozAOj5iElZSlbhxvjqoqA7NYz94jYdMzWMzk9WvpsbASVraqcMqCnCIfIwED4S5yS766lXwPX4QkHfuMBZr9/3eoepQ6scgltJGEtMn5gyVGLH1e8ECPCH5hFURAzwglU7Haqry0umPbyDT8Jg+qS4/fVmq23xdpnVIcztWtKmrv8bXAp5bXDFpVOg2vkMZr09+TJE+JtEFB+qKBXcSScp7Kf21hUA8s4PRmgo5Jk/r8vCJvUia7qM0tZjHWUXmwNcB+Zbe44g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(36756003)(186003)(83380400001)(2906002)(38100700002)(2616005)(5660300002)(31696002)(122000001)(8936002)(4744005)(6512007)(41300700001)(86362001)(71200400001)(478600001)(53546011)(38070700005)(31686004)(6486002)(91956017)(110136005)(76116006)(4326008)(316002)(66476007)(6506007)(64756008)(66556008)(66946007)(66446008)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?b2tvMWNIVmVZYzNXemxIYThQamVRaHRsaVRxWlJxeDBXMzhVellWWlk0NjNI?=
 =?utf-8?B?WmszZnhUZDVQUlVySVZRRnBST3JQR0RRc2h0c3FRcVptTHNMWXdNK2VqK2FD?=
 =?utf-8?B?VUtjcTFBVEFYekxpR2RDMlUrSUtXNDNmMHE5NU4rdWdYQXJibm8wK1dtRE1X?=
 =?utf-8?B?cWo0cWUydXFiZnhHTGdxOGR4MFM2eWJmSXJaVW84MTRTa1dhSXE0bEZzOFMr?=
 =?utf-8?B?WXQ2SnJWcGN5Nit0ejBMOWlkcysyT2g2N0JDYjhEK2dUVU9DalNlOVVqRElp?=
 =?utf-8?B?TjdRR1JscFViMzliNjUxb3gzcTJiVWh5WGdmN0w0VlR6bnllWVBHOTB2WnVL?=
 =?utf-8?B?SDdUVWFxQ0dvUGVIZ0w4SGVBbHdEVEhTVTRqcCtZVjZ6RjlBWEQya01iZDdw?=
 =?utf-8?B?V2pGaUtPQVYyUnBoSHhLUEdKcElTVlJtcTZzZzdKVm9BZWFIZkFhKzRram9V?=
 =?utf-8?B?c0hFMVJ6Sklaanl4cWJ5ZVRTUndKd1RoU3R5dVRwejROU2pMb1IzZzg0eDRl?=
 =?utf-8?B?R1pvb0JFQ3FXVzk0M3hTeGVlbUI0WVFwSEZyVHg1eUI0cE9WajdHemM3WXNx?=
 =?utf-8?B?YXhLZHFmZTUvNlBDZVZHZ0tTamI5TWtBVzV1WEM5ZWFtTmEzTGpzTCt3c2JD?=
 =?utf-8?B?NEd3R0ExRWtabG1OTzNSU2FlZStNdko4dmllckpvTFhWeEo2amE0K3JON0ZL?=
 =?utf-8?B?ODVDRkVjUmd5a3ZGM1ZQd2dvTTZnU0lmblB6TVUxbVpaOWxEaDBhandWVjhE?=
 =?utf-8?B?RWFHbnpJUVpxaU0yTnM0MzBaY0xFbS92RUtTNnk4YitPOW5oUW90Q1o5Wkpa?=
 =?utf-8?B?VHI3MktLdllpMWZqbGdvV2ZmWFR0QUgxdU9KbUNudm9yZHBScmF0TjBEU1ph?=
 =?utf-8?B?WmVreTNhaTB5cmEwS05jcWt0M3BBbkJIU3pWZTNnaGJ3dGpSVmFRYVJtRlpV?=
 =?utf-8?B?UmVJOWZ0Rk5Uamw3dWFFVzFxT2hpWkxmUUNXdUx2b0VpSU5zR0VnWGRRZEVx?=
 =?utf-8?B?SkJpSFN1SnVVd0Jkb3VSRWs2VDZBeTRDN2hVNit5N3hCQldFcVJMUXJ1Z1kw?=
 =?utf-8?B?M0FEVmV3TG5oWFYvczhxOXpSV08vbEx3TWhRUWpMVUFudUNsajBPU0tUcjg4?=
 =?utf-8?B?R1dKOGt4UWd3cWJtYU9Nc0R1clBqdlZHS0VzZVhWeTBPTGJMNm9UdjhITjRm?=
 =?utf-8?B?NDd1R2t6ejdKQ0JDSjJoZEhYS2Y3TC9kS3FIazNDNnROWFJIN2tvR3BjQjZu?=
 =?utf-8?B?Z3pjcllXRGNPVDZnZ3R1WUs3NEo3aWF0OG45bHZFRFEzMXl5amNwa1pQdnpP?=
 =?utf-8?B?eitjODN6aGROc003RjRKdjZDdDNWMmJLMjV4NHo1WUJRRE93OG1lWjFMQTNH?=
 =?utf-8?B?MTdHSm9CclY3QXZHR0JrdHVnTnJQdmxFVVdHOHRRYjhzOHZpOG9RWUJJN01L?=
 =?utf-8?B?Yi90OUR1eXVLMjcyU1F6YlVKWDdKQ3ZFZDlQaUtWZU5Nb0xmdjlydXQ3VnFz?=
 =?utf-8?B?bC9UWlNtUUJvNTRVL2J0Nk84WmlLNkJNMVYvWHBURmlYMi8xeDVaVk5jdFRY?=
 =?utf-8?B?NzJ1L0FkRUlXQnhHZUpENkVaTmRSV1ZNS2FGUG1SMWRsVjRMaldWVlNQMTRk?=
 =?utf-8?B?TU0rMVlCQVM1YTRkbThlY0xPaml6VTQ0Z0RmU1VjT0FhYUhId3pMbEN2OFVt?=
 =?utf-8?B?NWlUV1dyWjJmV3h0dFk4dVIyQTNFOW5zSlhkdVZiaDgrTzNIR1VadC9VZmxC?=
 =?utf-8?B?SlFDajNuOCtSUUx3M05hSG5iUUp6MXZwd1NaUWxBZTNxUktPNkJwdXhhTEQw?=
 =?utf-8?B?Z1pGZ1pKMnZkdzFWOVcrZmo5NVBCK0tFWG1vdkJSYUdrNGlBaThCckVRVnJU?=
 =?utf-8?B?cnZBdkI3anJRT0NBTzN3eVpnSXJVQWU3a1U4MTIvRHlpNVNjQW9WSjArNmtK?=
 =?utf-8?B?bFBhUDR2bThNMG03c3J1NjJlT2J2TU9FNUNycjBoWWNWUGNNN1hxUVc3YmpV?=
 =?utf-8?B?bnhjbjVzZlVpS29yQm50T1B4dmE2bUFad1Zray9WeE90aGJGanR4Z21QT1VE?=
 =?utf-8?B?STE3UWt1RjRHSnJobS82aVpzRHRhVmNVZzEzR0N0d3A4L0U1cXJoaHAzWDJj?=
 =?utf-8?B?SG1TcTUzUGNONVJUR3E5R2VXYUhhVHB4Wk43eGNLcmdaTGU2MjhxT0Q2YUp3?=
 =?utf-8?Q?s6A1exOjt6vrQC8crplNLiYDd1Be6q5vjTZdV45J7qnh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F05410CBCD6DCE448A94A1C06E95E141@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884edc9c-3a49-4ae4-3557-08dac6bfaf61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:13:00.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufV/47o3Fp14DuQ0/TtiHUpNg9dX4vTcktN2RYc1n8si+ihbeGx/rESP0COZxLCKhnSJdavgFvGoOq1mn94F7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201304_123526_10A6830E 
X-CRM114-Status: GOOD (  11.11  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IGN0cmwgY3RybF9rZXkg
bWVtYmVyIG1heSBiZSBvdmVyd3JpdHRlbiBmcm9tIGEgc3lzZnMgY29udGV4dCBkcml2ZW4NCj4g
YnkgdGhlIHVzZXIuIE9uY2UgYSBxdWV1ZSBsb2NhbCBjb3B5IHdhcyBjcmVhdGVkLCB1c2UgdGhh
dCBpbnN0ZWFkDQo+IHRvIG1pbmltaXplIGNoZWNrcyBvbiBhIHNoYXJlZCByZXNvdXJjZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0t
LQ0KDQpTaW5jZSBpdCBpcyBub3QgaW4gYSBmYXN0IHBhdGggZG8gd2UgcmVhbGx5IGhhdmUgdG8g
Y2FyZSBhYm91dCB0aGUNCnBlcmZvcm1hbmNlIGltcGFjdCBvbiB0aGUgc2hhcmVkIHJlc291cmNl
IGxvY2tzID8NCg0KLWNrDQoNCg==

