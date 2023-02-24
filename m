Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D42C6FA8E
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Feb 2023 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ouYEbBppEz/hofYubxtiC255vLO9ZADYUHnASjPvLE=; b=f9j4v/Xb3xT/Og+j+7+TSPKByI
	2KWjZ6o9vrUt9DXaCGpE39x8rWwlEAhhnXDbUqkHiy+a62aTfVHFelR0u65lfIWppONAo66+0nClC
	VvYU+LyPdcXoPQz195MqHWFFPHgxXBOJUswb+e5lQph+Pk960cFtruF8Zb8cYnsnmjtV2Zb/FbtpQ
	xGuxRr4SEuhsDWKgjH4OazfhFRUZiq+nSq+n2cmgXJbskHh5olZ+pnpYBE4K2qhTUhcPZO+ioBRyI
	GRkZLNpsABAeIxrBqxOUwNyso+IFVjWYxcrYJYq+g0ezOfK60qk1yxEbKOVXvfjJd8s0D5GTjSyVe
	+y+PtMng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVhrJ-004LBQ-OO; Fri, 24 Feb 2023 23:52:13 +0000
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVhrF-004LAP-QD
	for linux-nvme@lists.infradead.org; Fri, 24 Feb 2023 23:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEHvp4lbQmiTQot3GI0R86PojnC0iuzvVTNOhSK1bNWvygkcN3YjmdN1vjyk0aAH62sFKjJ6BAzD3SCsTrol5hH27Vgb4QFXROveBNpVC9NnqOMNHSVVGaQ8dSmnI9B8HVR9A6+9GxCIa+2WSNX5MINYhk5WQZFR4THAtjEx5NxqkL/wCz8BT5+b62FwDEca/f2VgMlunWTYPFV/XGlu7HQiA7V/A+LvTPAW3MruJ8yO27BNmsY9/bo/QHtesUynvFbc6Br6A+5tZTqJk8Hqi0xC0ADoIVvFZ22fWQMIeG7fOvWwhhzJ8ZRfCF4GaGGJ0sBkQ/BHvMEUzh2pFZVatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ouYEbBppEz/hofYubxtiC255vLO9ZADYUHnASjPvLE=;
 b=MIpdfSBZQ6zeI7hsuDqndN6IPWK/KigJmg6XmBBq8/T7EBbE4LZDRiNzzEdKgnfxWo1wBiRRiEygpqXv5AFCN2vzubGbsYPrRXiXyD3un+APynkZ72GDT2b1LQ/nY58diURQ8QgLwWJtGxwTfPhIPcR7Hs5Zgxb4Nb4WwiUfEEun+XLZhNEwwhUZLd5cDRsJP+wfAPuHJ+oCMc6Bh9UpPyPMZzEgTqoS3SvdMkWEg1wXtC7wXcUYWUfQYHfWr+7V6B35qZVLlzHf5OA0p1rheyXmh4xeQu4CXyfy85h6viyMBVki+jYh65/muS6mnkUA9T62TF/VkfgLVf7vs/ff6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ouYEbBppEz/hofYubxtiC255vLO9ZADYUHnASjPvLE=;
 b=Z+XdlUEhiZ0wsfvTqAME60GMGrzO0aVBb/nGvYMpUV+e0Wp4QjF7efO0mXfEcgkclq8y/g9zUv4jv6JD/dbxGkNvpcdiECfgb3B8rRC56MosRuqpuJjKfKVoYhovs/Sk5Gm/nnYqEsxd/pAqOyhk/FJQn3uRCUCrW1krlErtQ8Z2YUJGlvCumuSVu26+6iQJJPexlTWs1GX3NoW/zHQ5FUex7syKGDdD7lyXqZHfP8F12oNyE7OjQPwLmaneVt5q15K8zVRwBZoI0x9F2Vd1XqRXIEkzC5KBsPZs0unry6iEV40UZjX5/xqrZ4DbQiCS4U+9JHff0TPqCbPfNdMfYQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 23:52:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 23:52:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme: fix sparse warning on effects masking
Thread-Topic: [PATCH] nvme: fix sparse warning on effects masking
Thread-Index: AQHZSGWq5jr2RX70fkivSiFqVWASBa7exTGA
Date: Fri, 24 Feb 2023 23:52:02 +0000
Message-ID: <17b230f3-fb84-d389-250f-9acd54507c00@nvidia.com>
References: <20230224153424.734731-1-kbusch@meta.com>
In-Reply-To: <20230224153424.734731-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB8139:EE_
x-ms-office365-filtering-correlation-id: 8f23843a-492c-4716-06c0-08db16c22043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  BJHhsU7dDyQ+YmwfCOEKtjFcTnBmkWMFwGAS6iGL/Tn8vWHwsspekFxQREp7tyKna67HIXTrO0reVKvkaVHbeG1k2ObQGly1ZFx70jQd6BCOin8xsm28uAPmuYIOH5kRk2Rli+7h5QdMfwJ935AFBgX98wu9oxvCaHUL5dpnsT+EHzi38PGZbXLoKzi3MeKFKZ8lBd4/1D21RSuQsZHkrGDhFTKbX+h53tXUoTisZtPbLD1TAx0vsj2wJFVh5JdLgdetAbScJuEPF8WpYyQmjqJoum3LMiswNP6Sw+tPmgtvARD95f5aQe5m9t89iU1uOPVSb2FHLfm13RHRt1CXaD0LZxTYxi5yTR7qMQXqTnW6i85isSNUhmR7RCQ8UiUPnlg5nhkhoFwjv4Kv2aSygUITpHLi24xVEAx3pB516m6X83jp47BmxrTZbA3R/qgivqf8sB264bdbfbaeS2wNZiwlM6+4uTPYGOTd9YnCQ4wuoGDF9Eu4jvheKXGIhXEOK2RYMVbHNnVxvEw2VRMCu9GU04gsvU6fNaLyfkdVu+BqqnkbezSURA5y5rHl40ybEMwBYXWnrOrn19Cn7poiGp9SozB/hs4HQ9iHxi5PQwCkxIEcWBAbH22RXIKUoo//lmNnva60ltus7sbzwc8Ty3PTnXgJkloiOgU56I2TFqXf+0UCpdtwrvqMlv2L+Z11OeqNr6Pw9MoRmasGELa1j71PnDeyOh/8pbbdzlhtS6er3egXKZxA7FG5RkqYvExqekqj61+3Be2M+fKBNs9pAxqUkfF3JwvifpoRYkLaZEoxbXXrJZpZb9iPXEZRzQBS
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(91956017)(66946007)(41300700001)(478600001)(186003)(8936002)(38100700002)(86362001)(110136005)(38070700005)(4744005)(31696002)(8676002)(5660300002)(54906003)(4326008)(6512007)(6506007)(76116006)(316002)(122000001)(66556008)(64756008)(36756003)(66446008)(6486002)(966005)(66476007)(53546011)(2906002)(31686004)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M2FIMjRnSTFmZlcwQjJ0U2RMZU5KcGZrMXQvOWFSQUhqcm9udmtLVDVCemxk?=
 =?utf-8?B?Q1dod2VPemU4Sjdmd3A1QnZ1TVhNMHBxM3BwWXFyalRrcENCWDRUZ1VzZUFE?=
 =?utf-8?B?dmVISjVvRWM1UHk1SUg4U1JranVZTS9WcUk5emRHSHBnVXd1ay9RVzZtV0tN?=
 =?utf-8?B?RVl5aVEwNzVqYWJ6bzBkYUlPNnVCRk40VlBMNXUzOHo5Nmt2QnFEUWVxZGMz?=
 =?utf-8?B?S2QyaWgwMjdpQVRIcURMZlk3R3d1Q0NRenB2V3EzSlV1bXlyY3BSb0VnSmZJ?=
 =?utf-8?B?Q1hZYVZaQTZUazd6NzlZQ2NtaGdWR3MzT2hjK2I2YS9aWHRjU0RsN21DK2dh?=
 =?utf-8?B?QzZ2UzF4eTQ4RHZTdjlPNjh0ZGJWYllNQjJwVmxUMGd4YUtVUDRRM1Q1QWEy?=
 =?utf-8?B?bnF0SjlZZTdiZ3ZpeU9nVVE3TW1BVWY3TlN3bTVYNzV2ZjcxSVV6cktmRytD?=
 =?utf-8?B?K1dZWitNYWlaVHA3T3g0NERoZ2ZsU25lRUl3QTFqYXZMVnJobVR1eFVoK0ho?=
 =?utf-8?B?RVFKeWlTVTM1MTVhak84RGVuSWdZeFU0dDJwY2hEdTVKRHV4dWY2QnRCWnph?=
 =?utf-8?B?K0MxUnV0VVFERGdxNUJDZDlBaUZ4NitpYU4wdXRGVFNSYjBkQ090eDBham9P?=
 =?utf-8?B?b3NpZC94MkJWU0ljT1VoR2llbmo4WTJNdzRvdUlNYk94Z0I4bmlFcnhFVVRP?=
 =?utf-8?B?TFRiK0tUaHpxQnNVUnF1b2RhQ3RDQUtpMzFqSVNLQk9kNE40c04yb3RvMERa?=
 =?utf-8?B?eWZRaThOc25aYllmZStiTXVXRDd0bFNIOFBwMjN1aGN1aGZnMVdYSGFEUWRj?=
 =?utf-8?B?VWJPMlBhM3ZtQmRleTg2RDlrcllDL3V2aWpZVm1yRjhXNWJ0TkNEb091UjQz?=
 =?utf-8?B?TXhqMHJjMkc1eTNEZFJGVHhCOUYyRzdqWjdjMitmU0hSK3FvUEJwQWE4Mi91?=
 =?utf-8?B?WXBHaWdBaisxVTJPSFUrcnFBTDA4bHF6V3VONFhwY1NEekxSUlYyVndFbk5E?=
 =?utf-8?B?U24vU2I0RkRKeDg1OXhVcGtGRHljbUdkeTlpOC92dEN5YUtsb1N1aEN0WFhy?=
 =?utf-8?B?SGF3NUVOZmFwaWtMeThHam51NUQxZEUwdjhMajJJQWVZZGdJTXc5RnFBL3p0?=
 =?utf-8?B?TFJlbDd5dXpESUZHMEl3NXJQdlFVTDNwSndvaktMS2dCeExpWFhkUGdWdmp0?=
 =?utf-8?B?WkwrYllMMFJmdTJrK1A2MjFmMWxBTHJwb1RYeXh1MjlDMHJJVkt3Q3JWSUFK?=
 =?utf-8?B?TUVNQ21YZVJIN0dtT2RSUGh5QWl5enErY3ZMcDBHVEY1ODlrR0c4dU1lVndI?=
 =?utf-8?B?clEwVkF5OW9ISGtnTXJQYjVINW8zdFhzcjVVSmJiK1d1WnQ3OW9vNDVQVE1h?=
 =?utf-8?B?blE1cW9pTDdROUw2MzA2TXBFYzRKbEl0VDRBSC9LaEZjcUkvcUJGZ2ZlUlZC?=
 =?utf-8?B?YmdHdERwUURPdlJSVHBtQ2c5OFZ3emlMd2lXcGkrd3JyK09DMlY2S0xJODZD?=
 =?utf-8?B?cFVHMEVJSDFGM0JFcXppQXc4d3BnYXVmWmdjWngyVGJDZitvc1hPOWdOaFor?=
 =?utf-8?B?dUpPeU9NUURiWVpQY014ell2VnFZV2Y0OFA5NmRNTUl0Tnlrb01sMWNQeGRT?=
 =?utf-8?B?amdmU2MreXE2bTUvdjBLdnpZcS81T2I1c1VFU0V1R0NzOUo2U2FmdjZyclRp?=
 =?utf-8?B?RUpIZ2tXdFhGc1h1TWRiVE8wWjdGcHM0d2FlZW1JKytzeDY0ampkdlVyc01S?=
 =?utf-8?B?QitrQ2pZWmh5bUpPUXJObkFVN3pRRldZM0JsRXlITHhZTTYxMm42QXVOeURP?=
 =?utf-8?B?WEQ3dm9sY3NiRXJIWWNwdkMvL3VTWG5OT2dtSmV5Tk5wak81MDBPcjVLTm95?=
 =?utf-8?B?blY1UlpKN0l1TUlySUZKdkJaRlM2cWJYUFk5c3VvS29TL0ZHK1hLa0lhaHcv?=
 =?utf-8?B?eHNtbXJLdExBcUNLbmF4L0xTRjN1aEtMclNadTA0TDZoQXMvdzJDK2dLa2xV?=
 =?utf-8?B?d2dnc3FVc0dTeGl4K2RQRlJCVlRGS2dNN3Robkc3M3VMaElKaXBsY1M2aENV?=
 =?utf-8?B?RmRIanl2NWRBUkZ4bWQrc0Q5NkhBZE94U01ZRW9jU1Bkelo2S05qUkU3Um1M?=
 =?utf-8?B?VC9RcFhEWTJLMkxYWWRvRUozdExKUEdpUW9hSStPY2I3RGJOQ0pGckhBZ3d5?=
 =?utf-8?Q?gdmM+BA5ayoeFzrjsbBEjgBJIFpoDo6fMdq1YYK45k+2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB27DFDC9F65FF4DAABF8C75B70E4973@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23843a-492c-4716-06c0-08db16c22043
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 23:52:02.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mrNFi6+W2sikKJdKjRlqpAsxb5QKqe2s863wMZQrSO3ZMD2RFee2Xwz5Db0fStxOmzUPSknnupDdFAIVT0XRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_155210_083290_181559C3 
X-CRM114-Status: UNSURE (   7.57  )
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

T24gMi8yNC8yMDIzIDc6MzQgQU0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBC
dXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiBUaGUgbG9nIGVudHJpZXMgYXJlIHN0b3Jl
ZCBpbiBsZTMyLCBzbyB1c2UgYXBwcm9wcmlhdGUgYnl0ZSBzd2FwcGluZw0KPiBtYWNyb3MuDQo+
IA0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IExp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzAyMjQyMjIyLlBl
dkJoenZDLWxrcEBpbnRlbC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVz
Y2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg0K

