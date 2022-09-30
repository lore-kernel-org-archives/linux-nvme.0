Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A9C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hVvKSQMGplUmgAjUwxFvT6Hi/ZEgXAO6/QsxloFDMAQ=; b=lbB7B0CAoH/PAx05B41jsfjAAA
	GgjlaPcxrH85SUEbNWsJL/vFm1YBou//RA2V11CgXNm94qVYDfgnP1R2uL1LIW6hynimHBlaIB/i4
	H5ZuiNpGzn7hTJ/Sk7se8VV6Ycq2tp1pq8bD4qzYLU/6CSFY2sj3Dz7OG+0PV3lhu+QtimJ+Zl6tU
	g+ZmMw560qocJtgBHLP9GAaTI8zGXCEv/MqZ4cbjZy00lTm9XAsGSCBjzVVbVQUyt1OvmdOItp970
	RVB4VlJUEGKntVVYw0bWdmq9EQgfViPAmFNYqNkfyRIUuL8MSOULwJhMu89AgvCTVK0ZiuS3OGvLs
	qp3CKROw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe4sk-006ZuZ-Pe; Fri, 30 Sep 2022 01:32:02 +0000
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe4sg-006Zt2-Uh
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 01:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQNiYh0KiC7sw8UGzmHlliZ+H4m8ZuujJAjnDP1ZadYw3rTM0mE+GRCesPeDGnijwwx3adTLvT3CNJMqXFN7cV8CdtvQIooWAcU/hkvKrI0FyF6bOrwXjsrO9ZHldmsqc00th0lY9/vInmRgCOXUhIgFo7N6DkKwfDmaGclDnzVpyydHz61DcYAxvsvG8+Tk9ywXh6IZJY72nJ3MkTFNuPpe1O+VHhAsR4cuO2YhuaKKReOLBwB5NjpanYGibob3KDzZ19iND6zHWAmouxrUSQR85jxTw+WPe/LmZ7CF3VHTuQTJUtXCnH6mkpnkKjQuTvVKGF/EpCAFY/RhFUh7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVvKSQMGplUmgAjUwxFvT6Hi/ZEgXAO6/QsxloFDMAQ=;
 b=Bjwm0Fip9gWUyE4OMFjaJybFTnYHH8HZXopLUKAwDjyvZwdNTdFNcqArdJnacdgSV6wv/5jdgXldf2ZOEyKBchnb2Ow37u248mX8CU1RpeeBoQ5oPMre163FHI2niHy3lpZshbHmskcvRLCCM7OoVdW+L88A3XnrGVy9KQHGv7eol6pnXqmFuv6tn+B3A5ZgLHOtvVut1E+WhDB6a68fpxHdore2WtcnrQW1NlLhYbSYyPiCyUX773BbhKM6bBq2kYNEPkF4UMew1OsCy/kba+iUnxC3IEmgZsJMZ2TW6HZMGezbVTUp+vx82Xe42NrwMURsc1LHfzucYDuWx17YMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVvKSQMGplUmgAjUwxFvT6Hi/ZEgXAO6/QsxloFDMAQ=;
 b=d11CTd7uIo2tYnRIL4r5JSB8D76DoeUeGfIMmtSvj7nord6tmB+leLSZktPqcXqGIhmeBZ81Eaow78D/tWE8EZmjjN3xvEiDqW5qBqmrXWH3oo/nTY+AseHwYZN6Ywf/LWkpSwkx0v6IVdoPA77EQSnFDG1OncnNMWNFVWHU0mWsrlHcQZJrIYh5B6Q6UdPqVudD8RxPgjzn4xWiBQ/Vkt4pZtRSEuEayxsyzheEwuq/UMBTDswQ1DZ1HpxHRQUTURY4pMPYutapWS6S8nt+6HbLXsQIemedFuOBC+u5U7IDu3S43MMUPSg+yGu6VPDzjECiv4UpLsUEv+vNYokIyg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 01:31:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 01:31:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet: fix workqueue MEM_RECLAIM flushing dependency
Thread-Topic: [PATCH] nvmet: fix workqueue MEM_RECLAIM flushing dependency
Thread-Index: AQHY0wUhsyyp7+VGlE+i81k1Jcx+Gq33MsxJ
Date: Fri, 30 Sep 2022 01:31:53 +0000
Message-ID: <2883182C-D1F2-44FE-94C8-DDBC983EDFF0@nvidia.com>
References: <20220928063910.46862-1-sagi@grimberg.me>
In-Reply-To: <20220928063910.46862-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5790:EE_
x-ms-office365-filtering-correlation-id: b3b1344b-4b8b-43a5-7fc0-08daa2838dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  fJGfBYE846O9Q2UUy+Vz8XjVc0H2Lam6so7CbkRfS2Y8+mD/NugW5HROtZcUmCdnaLdFjWZ5zK7Ss9xFZTHBYd8ImaBES3yuB+2qDTLnv1EgtqT/GpjNcM2+DdZAIFbFtwIsOr+PHzB7CVubCr37mWypW5PWj6F7yYD3iCWT65gG1hWdj6bEjRXE9zjES6xMbLPPIhSrvTsXAm/tv/upwY4gFIeiFomSvTEwb3dkM6BKlXjkBXo/DE0M0W3qocZA22xcQNpjIKnfVKAbEO+j0fJ9hG0BGqmJnop2zvjeIa85NouYRt3sJVIbIWDDrj4mpKzviSuHjtYpyh0AFl50X84Mr04Av3/hWfIOBN7J2aedShko7mv1H9tfdfiu1sOqXnpe//KZpvCQMVwPd19tOKjLb0B41ZDBp2OxjKxV0/ZgrpaXJhel3eP1N79B0MZQDNNjAzWT+QmnbLii5maxPEVx2Sy3z/6rlBNxRk5xzTSFFgJqKPxCuHhdHrb3lxsjlks1IHKwgu7qho34M/n/+FGBIsyki0vwXPEgCmKI/j6dsGfZwC+3lYczDKpZ516Ud50XmWvAZ4BU8a1zAwyZE1uVxT6c4K8A4oyQqwVt6g5h/4T0I2Tg2ocdHEq5IfRA+Qt0xZH4OH9H9w7Ecc1kmE96R5kHlvPMS2EK+fGYtoILmL74mRFlDdvTXeueQ+PaXNyU5l7uz7hW81AylN46QPdtEXk59Hj7WtOymB9MY1Rat+oLkAKetJSvxJY5k93eNDjIfhMGIyib337sl1F4S+7FaumMfr2ws5Cz9ukmjbo=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(478600001)(8676002)(33656002)(122000001)(36756003)(38100700002)(83380400001)(38070700005)(2906002)(2616005)(8936002)(186003)(41300700001)(53546011)(66946007)(4326008)(71200400001)(64756008)(66446008)(4744005)(66476007)(316002)(6486002)(54906003)(6916009)(76116006)(6506007)(6512007)(66556008)(86362001)(5660300002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?d05tdUxyN3l3dWQrYng5d3BWUUZTdlFMdlFJMDlpT1dRYzZKdEc3VmswNEdr?=
 =?utf-8?B?RTFibFhXM2VKaFpJbWM4S0FDckRFWDhoTUhycTMzQkZlZkd6VTRnQkRzSDJU?=
 =?utf-8?B?dkc5NVZSb21CRE8vdVBmUElGT1dtM1FGV1pNbUU0UGp4MDZnL3VmUEdLREhF?=
 =?utf-8?B?ajRnTHl2aUp1cHNyWkcrWldNdklOVFo1QStoL1pzOVZkWWUwbnhFZStTb1RZ?=
 =?utf-8?B?N0dtYUM3eGxDVFNBbnNTU0pQUFpVNSszeEw1NGdhYllnbW9CcURUdzR6dHlI?=
 =?utf-8?B?QjR1NmZZL3ZyYXRoOWlUWUVCb2s3R1kxU0swU0pCRVNwb1hBNy9VNVlReUcx?=
 =?utf-8?B?aURxRkF2b2IrNmFhZS9qT05TZWlRQ3pWQ2p2S1FuaWwxV2ZzWXpONkRmY3lL?=
 =?utf-8?B?WE5nODZ5bkgyS04zd0FzcU1YWFJDQUMvUGthaUF0WFlVY2xiT0FvVG9oMkF0?=
 =?utf-8?B?ekNnUlMwTndHOHRrU1B6b05CbCtZUFQ0MTM3UUxqVGNCQ1BGVUp5QjJ6S0dl?=
 =?utf-8?B?TVhOR2dtLzBTa0JlM0JsczVHUjNIamxqdUFmU1JxUjhOOTNlNDBRbGhwa2wy?=
 =?utf-8?B?QlAwTEdIZDNKUkFiSzRqMDlhT3FNL2xycy9qcU5jdVR5NFpTY2JBUFpFOWtu?=
 =?utf-8?B?ckRNc0R2TkxveXV3Q3NUNjlIdnBBU29QT3RyM0g2WkxmUWFLdHJiMzEzQkZo?=
 =?utf-8?B?aVFXL2d6QWFmZ2lnWVl3SjRmeWFNcFd3SVBvQnZ4WVdvU1hWTjFiVlFiL3Q0?=
 =?utf-8?B?VDg2M1FkOEV4WGY0MVpuSEVXQ0EweWFKcGRoOHdZRFRwMkZLY2ZlZ2hzUndm?=
 =?utf-8?B?NTNDQk9KNjMyODdnMTBicUtsZXI5NXlWWWFVa05qUTBTQUQzOXgrWS9MV0lX?=
 =?utf-8?B?ZU96ckYrRTZVRHZmRGF6cHJJRlBYbTBBWk9hTWNzVUhlc3hCRXZ3b1lrUkR3?=
 =?utf-8?B?bnFTWFlPS0lhQmZpSXVvK0hIZkd2WGdodTBQdGtBTWZNOVVHdzlNUDJXakNG?=
 =?utf-8?B?YzhLb0MzZ2dMVFBka042ampNMVU2QlU1c2xMNXQ2U0JiTFpaRU1RV1JtaVpa?=
 =?utf-8?B?SUJtaEFiQ20zQiswaUZ6dDhraTlWNjV4YVp3M2I3ZjZiUzQwbHhHTkttdVp3?=
 =?utf-8?B?d0NMMW5jRUJ1VktlMTRjMUNXdldjWlpTenk1T202VFJKbmx6MFVuRzJXckRn?=
 =?utf-8?B?M25vb2loaVlIbEhYRnJ5LzRLMzlIQVA4T0YycE5xSDluTUZBQ01EL1VvZUFk?=
 =?utf-8?B?aXMwaERTMjJkalJXaXhqaC8xOWtNMlNMVC9mODloTis3RnMwb2JnNWx2enc2?=
 =?utf-8?B?K0dsaEdocWFUKzRITnkxcWNwQUhxSHMrbkpKNm5XZW5PTnRZUjJabkplTHNW?=
 =?utf-8?B?Z2ptY3ZDS1oybkFXN1lOdTErd3hxMlZSVWhLSVFIdVlFVVptRDNYbWJtOW04?=
 =?utf-8?B?M2ZBeGtWMHNmZFBkNnV0OS85UTdFUkhhNnhBV0R1WVN6WmpnMVU2VHcraTkw?=
 =?utf-8?B?NWFXeTFQendxalFYQVVmWkdEdjZ5YVNsa0lQV0I1cDJqYzRJNzU3QnV5dy9I?=
 =?utf-8?B?VzFJWm8xSFFqVDF4V3dpS1JxMG9iUy92VmdkSmJvQUVOcFF4bm93UDBiWjJR?=
 =?utf-8?B?V1pEaDFFRnh0cVpXakF3d1BtNmRJZ0MrYXNIRFY2Q01ZOTNlU0M4bzc0SGhR?=
 =?utf-8?B?Zk5HQnl1dklNMDV1VkJ2eG1BSy94ejZqb3NkZjlmTzE1SDM2YVdaQmdqNGo0?=
 =?utf-8?B?ZWZXZUNKNTBKUE5wZWdCWUtuWmYvbG5sVzM2NW1INnRFcU1WcXF6bFd5TFdX?=
 =?utf-8?B?UXQ4UlZyUmlPV3Y4WGtIbWtXdkVCSVF6OFVWQW1HRU1BWHZFWVJsVmFOK2xl?=
 =?utf-8?B?NDJkc241L04zWk5MK3JhdHBlNHBtNEZNdGR1THR4WUZNOE1tN1ZmZjhxMWpK?=
 =?utf-8?B?ckpVeWxGU0ExM3hDKzA1bDJ3Nlhaazl4T0JGWll3K0pxaXlPTUwrcmtWTFFE?=
 =?utf-8?B?OEpqTmNRQVRYS01VYjc5TFE4VTBpSVFVOEx3VlR6Vk05ejdRYTVWbjJkZmd2?=
 =?utf-8?B?MFRQM3hBTWFVdXlFcDdkOFh1aFRta2dCMVBRZE1CQTl0NTdtL0dvRm8zQVFt?=
 =?utf-8?B?OE1FMHZuSnRNQzFPai8xcXlMeGlkSWRWdC9YaXdYOEFOcXN1SS9JbkkvUHk0?=
 =?utf-8?B?bmVpRGlXV01oTWVEUjVmcHlxbDVNYVIrM25wbVc1aHVJTHNqSGV5aVg2aEg3?=
 =?utf-8?B?TWcwMGhQNVNyNisvOHk1MllROTFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b1344b-4b8b-43a5-7fc0-08daa2838dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 01:31:53.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NKIE3OhXJNPq5qWYOwGfmNkp9wzcebdsSBpy0u8EM5SvXAOXZrGfZws5EWSto2hPOoRwbvRfJpplRSJ5f1uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_183159_033764_3163D9FB 
X-CRM114-Status: GOOD (  11.86  )
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

DQoNCj4gDQo+IE9uIFNlcCAyNywgMjAyMiwgYXQgMTE6NDAgUE0sIFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+IHdyb3RlOg0KPiANCj4g77u/VGhlIGtlZXAgYWxpdmUgdGltZXIgbmVl
ZHMgdG8gc3RheSBvbiBudm1ldF93cSwgYW5kIG5vdA0KPiBtb2RpZmllZCB0byByZXNjaGVkdWxl
IG9uIHRoZSBzeXN0ZW1fd3EuDQo+IA0KPiBUaGlzIGZpeGVzIGEgd2FybmluZzoNCj4gLS0tLS0t
LS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IHdvcmtxdWV1ZTogV1FfTUVNX1JFQ0xB
SU0NCj4gbnZtZXQtd3E6bnZtZXRfcmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFd
IGlzIGZsdXNoaW5nDQo+ICFXUV9NRU1fUkVDTEFJTSBldmVudHM6bnZtZXRfa2VlcF9hbGl2ZV90
aW1lciBbbnZtZXRdDQo+IFdBUk5JTkc6IENQVTogMyBQSUQ6IDEwODYgYXQga2VybmVsL3dvcmtx
dWV1ZS5jOjI2MjgNCj4gY2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDE2Yy8weDFlMA0KPiANCj4g
UmVwb3J0ZWQtYnk6IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPg0KPiBGaXhlczogODgz
MmNmOTIyMTUxICgibnZtZXQ6IHVzZSBhIHByaXZhdGUgd29ya3F1ZXVlIGluc3RlYWQgb2YgdGhl
DQo+IHN5c3RlbSB3b3JrcXVldWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxz
YWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCj4gDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

