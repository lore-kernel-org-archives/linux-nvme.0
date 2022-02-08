Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7831CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 23:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvX6IlpulwD5QbIwB/99R6IQzBNl9nHgmkiLGqXBYgE=; b=U2J5W2AT0OdqtaYKe+zVJcvHQ9
	f5Yr5y3lRWM2/KeChgusl8YDGrvSWSyhXHcsKk0HdepUFrxgUVr5e1K2/2D9D+eb2+c8WZRSAtGJu
	GF227fJAvn/Ji4h3Ysz8H1M8PctzH69mNoXylPBoyZPveLgf6IWOsrKXOpIQ5TJMyrzM/3SA1wj8n
	wCayDZqf4OUvJYhsIT53HqWZNejqED+QmKm21dCv7+vc84yckNuqj+FAhdzOM2gE/i3pOPHwh/5Vb
	Ix/zEBl0zO766ucA+nbYhuWTIpyrVUKd8hCnJUPqp5JZFbKd6RkJWu9PfwyX+3ucepX6V3em5J/RB
	cAoPBDqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHZlJ-00Fmzn-6S; Tue, 08 Feb 2022 23:19:05 +0000
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com
 ([40.107.236.70] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHZlG-00Fmz0-NP
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 23:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGna5vNU2r+Fvpv2aqj65yzeCL75uyklL61EoJD6bv9uyrcBlJZdxVp5YZg+dtk2Tl7+waqFhQ99Npp5EhdOgixFeALo2NqWZmB53KS5Lquv++IYdaSQHV13w+laaccvQxtDKhVTDzA0IVbuQ4VOSjbPnkR8Cuu0vpykbSU6FvaSrD25WQzdpDMe1bupIaPpHtV6sMEZyiX8ERDJninDjAS+doaKJ5Rxu8AppCjZOBzXMlYHNiseqtUAKxnuFTq4xU728ys0dgPijS6pdW4QFvAmK3wl8z2V1uOQWpc6PtJgfWKmCjd9MPYFOsmom348/47kZv0CT01yt0OO+VKfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvX6IlpulwD5QbIwB/99R6IQzBNl9nHgmkiLGqXBYgE=;
 b=ogfGZgiyFfdF14ghxedGskdeAYVHVYlhE2ozxfOnplzyShwsOt/mq1Bt3n6PoB+zwgtnjx2zcu/3DI+s350iHKgbL1k+7S5jaqSV/ev/sPymDlPbvbFr1kpkVBKg9c+BEWMFcMZKkdSMIVpbcx3tJLjiYPSJixKDp5L9uK8uHAGilBt6BVygc2h4LTk+5ZyVpIDnSKgGJZZSOv0iC+4An1QMqalOjHrx+FbqI9xBrRWUlcfc35w2HUVGRL8dr8RUX7GgvWcnGv04ZNgf1RAqeH0xQgTjLPFKGZs/v0KbAsGxkQc4t71VIHD9Cls+VsaDPFNLXmexzhN6dhUps5g1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvX6IlpulwD5QbIwB/99R6IQzBNl9nHgmkiLGqXBYgE=;
 b=RlNUyz7rxI6s38syxP5TzkB3vgoPL0bg05Oz2xg7RBkG8TgZgy4Lc19NwImj19L39gIKJ6XZEd5cXC5La/fRwTsCcMJuhRmYAeBhu9ymwKqgJmp+j2VZO5sA7948k5tP8wqIAgk1RxuhgCR8gmuBQCqkhL8RUSBda7tQo2shY71HOun11YHSw3KBSRy2NtxuuLvNJdeD7u0GUVAKilrZE+B8fI4xlDWy70KU9ViMdSCJ/NNIxXEcc1sMO5tvMmy0JseqiH7WoJ44VqX56WWtF1TNdnS5zY8ZOVIQvCUrc8mhCsVUvO4LXXSZeF9RhVREDIP0r6ZS9QruT6Af0wOgSg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 23:18:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:18:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "stuart_hayes@dell.com" <stuart_hayes@dell.com>,
 "charles_rose@dell.com" <charles_rose@dell.com>, Martin Belanger
 <martin.belanger@dell.com>
Subject: Re: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Topic: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Index: AQHYHSM49++cF75LEUW3CdjmyS9B4ayKSjgA
Date: Tue, 8 Feb 2022 23:18:58 +0000
Message-ID: <e2e5c43c-2434-493a-97f6-aeab5acc535c@nvidia.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6e08abf-63ce-4b1b-262e-08d9eb59629e
x-ms-traffictypediagnostic: BY5PR12MB4033:EE_
x-microsoft-antispam-prvs: <BY5PR12MB40338A41854659D183FFC383A32D9@BY5PR12MB4033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sqtIJoLWdStCRNEYxwViYYt5wBPSiFcXMdWiJGnH8vx2fmhkcDWTQTxBA2P2tH+dlBqbnWBHy5M4SOAqhufqEFOj7kBKMq248zqIP+0/kcJ8H8eDbwoqPY+joiGM1i8wA09pBvMb+lRZWwzKHAAqwZtLtHvy0A6DZJiVMXoTm+B/kKy0gEK/Ax63LefKBA5wNCHgC2jB2H9dYguqdBdskdTYTDYTINl2WIQuLm4jcwaYanP9H2gCzFfcVPIpcvCF+NkANGpZQtM+xURfjb0P9APum8b1j1UEYPO20QWehTIKHiIQP5J2aIm6KJtZf6CDEyQQoFdKRcIjqFUN8cDcMH1WGIJ05dj4ZEs+3bT8spKdkOCyZ4DYgdweZQToeg+dKsG40sxIQrg3R+mOD8P1WYEfrkL2DDpvrN1cGKwNKNBXEWkVaQcR8nEkkF3QsAmNIZC5WFEBtFhnZLPjutDPDlJ8vxmQw8DRHZHNUNBi7CO4YLc6GQqS2+5zkoyRW6sdbxHHVbqwXdfhiigq7hXdx/y5k6lpXpxkEuLgbm/Ild8BSHku2LzJxvzlBvFGwqsparmHBw7l764OLkMkeQ3jezyOPQh441ao+pI/VHaxT98E67B+O7vioL+AxXh57dIsF9rpEcBRre23NBMSENEB5Nf7jaMLnk0fXJYGixI57ofebtwlB4ozg8XxRjV7K6dx7ljKQI3jiTddW5sQkg5Csw5vn06cKEyK9gIVw/uegkD4PHGya6wEgDfQrK9KhiVd1RjysJHbLCWeECBTLuOHXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(66476007)(66556008)(76116006)(4326008)(8676002)(64756008)(110136005)(83380400001)(36756003)(54906003)(6486002)(5660300002)(91956017)(7416002)(66946007)(31686004)(508600001)(6512007)(6506007)(316002)(2906002)(122000001)(2616005)(31696002)(86362001)(66446008)(53546011)(38070700005)(186003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1l6NEpoRUxWUUhUcGJrS01nZnc1QVpQRlNYWHJuT2JQVEVDRmE5Vm9nQnV5?=
 =?utf-8?B?QVN4MkVkNmZ1K25vZlZiRWF5R014V1BDWW14SjZ5VzgyZm5YVms4N2t1WDJD?=
 =?utf-8?B?QWJxOTBPc1Y1dWNVOVlXN1NqQ29zV2VlUUcyQXVuZ3BYNkZQUlphbno1THps?=
 =?utf-8?B?ckxoNFZWYitIR0JxMHNhQnY5MTFVSWNxWWs1dFN6NFdYSXZhdnQrUjdoMWl4?=
 =?utf-8?B?SmtFWHMrMzI4SCtSbkpTdXJCaHJaZ1BEck1HL21qeU5ZdURWSFFBZ3lVVDFU?=
 =?utf-8?B?cjFKSGhCMHArTGZFYWMvT2dQb2Y3UysrcWtDdndzY3MxNldubVhLWnBHVVE3?=
 =?utf-8?B?TWhYSmpJVWR4eE1BTml1azFhZCtQNFkyWGpUdzdMank4bjVoY3hTNHduU084?=
 =?utf-8?B?V3UzbGIvQTZlN2REMFVVa1N4UnRBbURFWCs3cnlvb0E5OEw2Y09iV3JpTXJE?=
 =?utf-8?B?S3NDU09DSHlQZEt2ZFR5ZitNN3ZiRDUrV2k4RlpqeW9yYStlU0k4NWRxaHR4?=
 =?utf-8?B?SThJUEtsSXA4eHV4ZERFMUI5MEdUMnBFa0VJV2pPTjdpdEJiZ1Bia0xhWHlW?=
 =?utf-8?B?UFFlOER3ODY1M1ZTYVNjVlVJdUFHZE1oLzFsRGpKclBKQkNVbUhrc3FsWlJw?=
 =?utf-8?B?SFhkMnoyZUptcEZ1K3N5WkZzdi9Ya2puSDNwU3FwUm1FLzNoRzIzbmhIM0FT?=
 =?utf-8?B?Yk1CK0NnellER0hHcWdockpMRktWMnlsTkJ2bC94cU1YZnIvcTkwNmF6SVRv?=
 =?utf-8?B?YVh4dGY5ZUFYZTltWDkxNFI0eEU3UlpsSzg5dXpFRWhBU3RzeHVNUzc4Y1cz?=
 =?utf-8?B?Rk9tZkp4dE9xMWg1aDhrSFlEanplV1lWdmx2MjR2a0E2L0J5T0xwTnFZN3JQ?=
 =?utf-8?B?WVM2RFRqZVFiWHNkblhyeFdyNGgwb3dKb3VuQkU2eHJmc08walYzeUdhMnE1?=
 =?utf-8?B?U1hTUDJsOEt5VG4zS2Fuck5MRHU4Y2RrNCtpWnBtdmFpenFVTHJOY2hzNlJT?=
 =?utf-8?B?SjBHV3hFTUxINkVlWDBRSEFiRWNydGNOd2NzcFBBbjJ6M3VGdlRsb3F0UXZG?=
 =?utf-8?B?RUVRd2hQSi9PRFRha0Z1OU1TN2UzbHo4Y2ZHdTZJMmFEbzlIV1grN1Vlc2pk?=
 =?utf-8?B?cUJMcDhCOFEvaEhDY3k3ZlBMS04xSkQ1VHBBWTVPK0NSZUVWZDVZUHJmWDBp?=
 =?utf-8?B?SVZtb0lsMEhadERDVTV0Q1gvZ3VoeVo5VDdMdEthOUk4VUNHWUdWYTNoVnhW?=
 =?utf-8?B?Q25TZEc1QTJmTzNtVSt4VWExR3pGcWJKdy9qV3dZRXZxbnM5amtDRTVoV1lZ?=
 =?utf-8?B?ejlUSzZuYmIyZWk1c1ZURTNkV0VwaFF6dDU0UUhmYmk5d1hNdmFUWnE1UE1a?=
 =?utf-8?B?aGNCRlJRREoxdmhXWnd4S1J0bDFQQXVpc0pIYktackQzK0lGNGIwc2FEWm9n?=
 =?utf-8?B?ZlRFWnFLWXhjVmdHMHFQVFpoYlZ1NEhQbDlNOTFXSTlTSndYam1PUlRuNzZZ?=
 =?utf-8?B?RjFhOFlPVit6OVUzNVVhbm90QWVzWlhnMlZlMUk3VW1VdHNaK0RSa2kvSGtC?=
 =?utf-8?B?eEd6Rm5peUJQU3N3VnBQS0w2ZHUxQy9lQzFHTHVNckZFSlVuc2dFYXVEclla?=
 =?utf-8?B?ZzFETzdObDdZRE5SeHNBVjkyYVBtUUdpUVNxOEMwWVVkb0wvZS85eGlqNW1l?=
 =?utf-8?B?aVBJNFRTMGNjSVFkWk5UQzZVamVRaUhTbWZQbGhqWitIMHYwblJqZS9Wclps?=
 =?utf-8?B?ZUdJV2NXYWRBOWhLUFJxRGs4d3M3QWlTK0pKcUVINUhJSnRMWkhMTGdvVENC?=
 =?utf-8?B?eUY4UkIzOG5LbEFNTmVxYzdKY3V3cmFDZXB0SzE2djUzSkQvZWhENGJNNkpN?=
 =?utf-8?B?dGhzU3plcDlqQ1U2ZFRpZzZuckl6akVGdjRSQVZGTW1HTE9UUUFKYVI2Z29N?=
 =?utf-8?B?TVNhV2htQ1RFSkpVeWh5YlVSUmhYZnFaRCswdGtKSnp6bnhQQlFETHg4Ni9a?=
 =?utf-8?B?L05tdzNCSi9TV3lteEp1QmdRWU43dUdDek1uL244Z3c3WnZtM0xKNXQ0MmhR?=
 =?utf-8?B?bDc1QUY1QUtCNk9LanJ6YUt6ZVJBais4a0tCWlFpeGZLTnF1SEdNSUtnVjlD?=
 =?utf-8?B?WHpyTUdFRThiekprS3liSkorVnBrdmZmYU9NOU8vN2FKdlgxVjVFbnM3bVd4?=
 =?utf-8?Q?yA1P0wbpAGpgHYIembzfcKzon+ZOWqzMdgbDbqI24VWl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7528E05941B661439707715E749C9AC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e08abf-63ce-4b1b-262e-08d9eb59629e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 23:18:58.7690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtxWle6buswbVD5xRC4v3wY8Vy4IBdmBCzUi/Ynqp55aR26fzcotTCO8sRE/CsXdDj4fNFmTiHVeAq+PpEmvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_151902_816647_5264408E 
X-CRM114-Status: GOOD (  16.86  )
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

T24gMi84LzIyIDExOjMzIEFNLCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+IEZyb206IE1hcnRp
biBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiANCj4gVFA4MDEwIGludHJv
ZHVjZXMgdGhlIERpc2NvdmVyeSBDb250cm9sbGVyIFR5cGUgYXR0cmlidXRlIChkY3R5cGUpLg0K
PiBUaGUgZGN0eXBlIGlzIHJldHVybmVkIGluIHRoZSByZXNwb25zZSB0byB0aGUgSWRlbnRpZnkg
Y29tbWFuZC4gVGhpcw0KPiBwYXRjaCBleHBvc2VzIHRoZSBkY3R5cGUgdGhyb3VnaCB0aGUgc3lz
ZnMuIFNpbmNlIHRoZSBkY3R5cGUgZGVwZW5kcyBvbg0KPiB0aGUgQ29udHJvbGxlciBUeXBlIChj
bnRybHR5cGUpLCBhbm90aGVyIGF0dHJpYnV0ZSBvZiB0aGUgSWRlbnRpZnkNCj4gcmVzcG9uc2Us
IHRoZSBwYXRjaCBhbHNvIGV4cG9zZXMgdGhlIGNudHJsdHlwZSBhcyB3ZWxsLiBUaGUgZGN0eXBl
IHdpbGwNCj4gb25seSBiZSBkaXNwbGF5ZWQgZm9yIGRpc2NvdmVyeSBjb250cm9sbGVycy4NCj4g
DQo+IEEgbm90ZSBhYm91dCB0aGUgbmFtaW5nIG9mIHRoaXMgYXR0cmlidXRlOg0KPiBBbHRob3Vn
aCBUUDgwMTAgY2FsbHMgdGhpcyBhdHRyaWJ1dGUgdGhlIERpc2NvdmVyeSBDb250cm9sbGVyIFR5
cGUsDQo+IG5vdGUgdGhhdCB0aGUgZGN0eXBlIGlzIG5vdyBwYXJ0IG9mIHRoZSByZXNwb25zZSB0
byB0aGUgSWRlbnRpZnkNCj4gY29tbWFuZCBmb3IgYWxsIGNvbnRyb2xsZXIgdHlwZXMuIEkvTywg
RGlzY292ZXJ5LCBhbmQgQWRtaW4gY29udHJvbGxlcnMNCj4gYWxsIHNoYXJlIHRoZSBzYW1lIElk
ZW50aWZ5IHJlc3BvbnNlIFBEVSBzdHJ1Y3R1cmUuIE5vbi1kaXNjb3ZlcnkNCj4gY29udHJvbGxl
cnMgYXMgd2VsbCBhcyBwcmUtVFA4MDEwIGRpc2NvdmVyeSBjb250cm9sbGVycyB3aWxsIGNvbnRp
bnVlDQo+IHRvIHNldCB0aGlzIGZpZWxkIHRvIDAgKHdoaWNoIGhhcyBhbHdheXMgYmVlbiB0aGUg
ZGVmYXVsdCBmb3IgcmVzZXJ2ZWQNCj4gYnl0ZXMpLiBQZXIgVFA4MDEwLCB0aGUgdmFsdWUgMCBu
b3cgbWVhbnMgIkRpc2NvdmVyeSBjb250cm9sbGVyIHR5cGUgaXMNCj4gbm90IHJlcG9ydGVkIiBp
bnN0ZWFkIG9mICJSZXNlcnZlZCIuIE9uZSBjb3VsZCBhcmd1ZSB0aGF0IHRoaXMNCj4gZGVmaW5p
dGlvbiBpcyBjb3JyZWN0IGV2ZW4gZm9yIG5vbi1kaXNjb3ZlcnkgY29udHJvbGxlcnMsIGFuZCBi
eQ0KPiBleHRlbnNpb24sIGV4cG9zaW5nIGl0IGluIHRoZSBzeXNmcyBmb3Igbm9uLWRpc2NvdmVy
eSBjb250cm9sbGVycyBpcw0KPiBhcHByb3ByaWF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cnRpbiBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiAtLS0NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCg0KDQo=

