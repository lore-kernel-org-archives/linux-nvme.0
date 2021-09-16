Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC78C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CCC63262
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53CCC63262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSccLeR+xJkEjE1tPFqotVrbedcjm9WM0CUktePpEKc=; b=Q6pg/uxTVz8sXh
	IPIueDripIcqpWkC7HJhoARrJ2UFKoy07uP1zXkmYSgvgNdyIWTXZBSosNftYOxgbmGVbSqdnVc2f
	w6IybJAGvbLuko8krrt4G23sKbb8wKT8qdZNZLSlftP2t6sS9N6Mxf3RyV2ulm5CjiGWanLPJ/1mO
	QOeDautGQ5jYp4Mw2fl6XWQYzlqUqG/ykZUnx6W5nch1bGR0XmonxTbiQDW1YaulD0r9yOsy0h49e
	l2fSLdgeqLpunt6EWDb1Xo9+4mFZYQoUkDNjtqOA0L55M9unDwVmoX/RKh0yew1CFT2xf1Vbu5Xn4
	ntUuZ+QBmCSO1n5838fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQudJ-00Blh2-2l; Thu, 16 Sep 2021 16:53:09 +0000
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQudF-00Blfs-Tt
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 16:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgbDUUn8YYBZCM5idPcLJdX4hm3qDNrHeznqIIM5EHRTUHS9qE1//dHcilHNNKYCA3WAd3O9FKGxJqeHQJ2D77AUH51Rs1/Or/pZ2bx4ROCaiPo7w9S/bZaUcoB5kNR3agaZz9SsveWyijGD5RHl3ULtBDk1unt0hzoj3mjAVw8JftH1f8eUaWZ6Nvda4m4EmW0QWsUMFwWiGcAaqp7i+PY+rtG0ejSX4IF/c/4uFNIL9rxgaWEFCwdDW5z0D7vrNDOSI4rWJAes0GrOWPCPx+/pt44Z1ODeQZPPrMIQkDpFf0RwL9qqua3lWnPPCeXn7Rk6W51I0IZoQ4ebQRJRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IP0syNm2IAHvNDVknmEXpeeNwurW1dVugjVdmBxrqM4=;
 b=MwOfBPfjoiFxm7ULdjkIX+OK3ZYFwsHgBsM+WZlD4AHr7Tz8/u7vQv3wygEcqbtIdgRISQmjTR9JI/pjVKjUeSMke3FHtnQwBz+aMKmO5HL+JgE4HkF05enE+BKONMpbhRRouk/3H4CSRa49DHb+B2LvOKZH7pwdD8/VajijRSrSMU+fUO5LYT1/YhS2PhLks8b3a5AijG/pO7zcgmrzU6oKm/iihYYFukfodg/a5K02h/QodmUBTatPWjyojtJytdpw95MwVYEQJWOJcEify+lCjDCDdgS9+bryewmabBhwphKgQuvUC+vAnLVVkpnI+JfByjSva1SGjBFy6hij8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP0syNm2IAHvNDVknmEXpeeNwurW1dVugjVdmBxrqM4=;
 b=oAdzBkcwqLE31/F0YCQlj7GIulx+YRKRVBoEF6vVDs3eGOvUCDin6/932chcbWg1zqaNeU+/NGkB/H6s5XCEclTx1RakYor5i8uvrJVTeEx8buqzx7Wv9fGJp/Ejda8lIRTlwuBkMmjMZ0Ol3WXFvdT+iaw/gAmemtjDYkJMAGOoaqMoR0HbkuKhYdEuZBk4mExDddyOhKZlYvxAH17Fik1Opo6PD383ni4Iholi44HkHjUdcWec/hwZtjvVMHQqx+ucVDJyUwTfgGtr7TfsuMW8i7iL5znXzin0rNoScEkFugmAPpJWRzzMhGHyjO8op5kBJF+99Jy8hN+3BjZ3Fg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0095.namprd12.prod.outlook.com (2603:10b6:301:4e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:53:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:53:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Topic: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Index: AQHXqkf4+f5LmAX72UW/QwltVS4yiKum4g8A
Date: Thu, 16 Sep 2021 16:53:02 +0000
Message-ID: <07e9f0f5-75e0-0f94-1af8-9460cd6a0b67@nvidia.com>
References: <20210915153751.1457173-1-hch@lst.de>
In-Reply-To: <20210915153751.1457173-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93dbf42a-ee7d-4e5a-5363-08d979327268
x-ms-traffictypediagnostic: MWHPR1201MB0095:
x-microsoft-antispam-prvs: <MWHPR1201MB009595DD59A545C872A6AC02A3DC9@MWHPR1201MB0095.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUQs6d+UhALpBXq1hp/rYp1ltQeHl1s7YTA5qAwXyv4Osh3a52j/v2EXwLEmZrqtoSmCbOiUD/uMHABRkgXBfclv31eeMtmqaTXNbiYeEWN/mTR9JlYMxYgSq5LyaDOPA82xAOGmvh8saTQMoN8iO2w2yWaTgplDiAjnmh4x1HiL59Hsnu63smySbpv6nE+3f2HU5XGNQHJe2fa/LHnDIsx9oBxYFjPHu2JA13aDifQQuvqbrIQKgmwoAOuULF9DbUOFuEFP/6RM210+Hwdiaw4q5I+zHP+h2oELVtiQoPjTVU2c9zxyvMI4YyW1ayauDhBiWw5CzXs/yaUemqrcbsdLvSdexnVK/rv92RhZPDAg0I5npnsnYdLzRD6nAtSdGDsqINP9vCY+JmD/aCyKV0R3l91yYEPIcZU9wPvYV0HwKVc7oneoPuh+FUJqQTzLZz+NN7DCn04RCZb/yiEtFotg9m7qFLJaVghtC76u25OHNFilVtWdk3brILHdCc+Fx5l9mRPb9AsCU04t9BDvnoeZhcqEc6/a7bp1ZAe6p8g+swZ2/9abGxeyGEaFWNGxIyFRW7eFd0q6UAs/NibN2dwi8FbNMhdwKZm19ra9t/8DkIosfS5b5p1cJVgeBb5HNVtvC+coPUOW9iYNlAMIcZrDNCNJ34StTXjuus+clAwM0LVSK0Ox5AFPzHQd9Sp+YjiYtBiOGfp94TY8YMHHufxGpJt9Y2jvYxENg0AyO5gj7avfmlruVUVI8ZSOLQ/gCPAqrNqGriJOpLrykGmDvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(76116006)(91956017)(64756008)(31696002)(66556008)(66476007)(66446008)(2616005)(66946007)(478600001)(122000001)(38070700005)(316002)(6512007)(83380400001)(36756003)(8936002)(8676002)(71200400001)(4744005)(6916009)(6506007)(2906002)(53546011)(186003)(5660300002)(31686004)(6486002)(38100700002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWVkeVBua0FVYzFnNzUvc3FyVjVmcUMrejB3K0Y3ZUpsVHd6dUQwelNhRzZ1?=
 =?utf-8?B?YUZ6Y2JyUG1JRGNTYzJFV1ZDQjFza280V3hmdGVCUWh1VXFqeU9jN1NvT2Np?=
 =?utf-8?B?VXFYK25JT2Rxamdrclk3QlpveUZlTWRzU2ZGa0g1WHI4RGVDUlRDeWJhWVVZ?=
 =?utf-8?B?RktTbGk5QWw2MDhHeGlWYXY0MTBIUWhNdjdkWXFwRFlERXNkZ1l6MWt5Wlpo?=
 =?utf-8?B?di8zeXRHWlJmdHI5VlJlWjFwbkRYdWlHM0lIRXE3QU96RHVoK0pXMFZVVUVa?=
 =?utf-8?B?aHA1NnJDZHJydEU4ek1QbVVQNFliT2lUdjVTUm9QdFNCc1A0RitWN0VGR3R5?=
 =?utf-8?B?cWpHd2k5R0g5U1gwaUJ2SUFGV0pSS3gycCtkTlpZbW1WeHRmU2RlUU0zbVF4?=
 =?utf-8?B?TkNUOWhwNUJkK2NaVUxjTFVHTVIwOTZsWDd4THBPSDRPc3BtYmpCV3FXUlBO?=
 =?utf-8?B?UUhYdHFzNEN1QkV2bmNhTURTVmE3RW1oODM3OXBRZkdBOUtvMm1XNWlzQUkv?=
 =?utf-8?B?U2RrZHU0TytXV2lpbVlRcCtrczR5WWJsSFNtaGFYYk8va01mT2pxUm4raC9a?=
 =?utf-8?B?MjZzY1NrV01hY01oWVdYMklicGM3TCtMaE9lVlFZaURPUU1MbzlTOGJiU3pv?=
 =?utf-8?B?SUFhRkw1ZVU0VG1CbTQ1TlhUS3Q5a1krYlROUUY3bnkrajY5SGJsK3JHb1VQ?=
 =?utf-8?B?WmVOTXBvMGsraEsxS2JvN0hmV3prd3E4blJQdHk3ZnNwUVdzSGJTMktOV3ZI?=
 =?utf-8?B?TjlYZVlWWFlXaC81dWlvNEVxbDVQUG1FbG02VHZkNDJJK1FGTUhhZk9SR0pL?=
 =?utf-8?B?Sk9DRklFTk9ibkNPWUErN25mL1o0aUZuUEZpdS9DeEVIU0c4TGFlRzhqTWEw?=
 =?utf-8?B?UGtVZTBpb3pDSDNYNUpxWDQ1QVl3cUNvMmdWcEdiRjZGcTBuSStKWkNkL050?=
 =?utf-8?B?aXpveC9rLzQvVER0ZC9KeDdra0htWXhXaHFlZWtFS0I2UmpwOHJIOGozTDNL?=
 =?utf-8?B?bUlzeHdEY0xzVE4xRGhXOVlabkZ2ZmllRHZUK0k0Rjg5Mkt1ek1NWHA5TTBk?=
 =?utf-8?B?S09NQzRhME5ZbEtsQzhka0ZhVTNROWdGLytuRGdzZm1RSmVLWE1RRGRXOXFz?=
 =?utf-8?B?WlhjcDdNZDVMTWRaNFlrSjdTbEVWT2FpTWExTjBCUDJLUHptakVVeUlwZS9O?=
 =?utf-8?B?RktML2d3R0trL3YwK1ZqeVZaeThiR0RncHFzbldMMmYyUm8vbWZqUnhRQ0NU?=
 =?utf-8?B?YnRQaTl0RHk2MzdjMWNhb0pVV2t2QzhLQWFpeEoxbWswblNvS1lWeUYyKy9R?=
 =?utf-8?B?emRRLy9pTXk0S2loUTh5d2MrYWlVY2k0ZDY5cDVJcjFGTU4zalJRWFYyaVFt?=
 =?utf-8?B?WnBienNvR3JhdkcyVmdmRW9HZ3RORWRxRHBEem55T3U5UlJZeU5uYlI2N1la?=
 =?utf-8?B?azVHQmxid3g2ZVhQWUtDNUhON0dlR0tGVWtrM2lXejNibHNaaWNYZG16Mnl3?=
 =?utf-8?B?enRNa3dPandUeE5lbGxxc2MzVWthMnhaMG1zVUJrYlFoeVluS2Z0b3kyQ2lO?=
 =?utf-8?B?ZXRxQmlZZFV3ZXpMVzJQNVBlVmRzbld0aU1QQnpyVldROE51b2VqdldLSlVu?=
 =?utf-8?B?V3hIckRuZXJMSjlYcHBlT09tRmR5aTNPTlhBd2dZYUo2NDlPRTZzYUZoNzJM?=
 =?utf-8?B?UzU1aVQ1Vm5kVXFNMmRvblV6dnQzM1luUnp2QzNXb1ZLNTJIQ1VSNFJ3Ky9q?=
 =?utf-8?B?Qktzb212VFRlTVZhVG5PT0tQdk5xaUJhUWFESmVXNmE3SHdoOUwrbTY5NUtn?=
 =?utf-8?Q?EQ6OpRrM5n5lU9wk7pav9428Xyp2BYg733GmQ=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <0541D26008630C4896DC69B1BF62CBE6@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dbf42a-ee7d-4e5a-5363-08d979327268
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:53:02.3022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzJHR/qHbgsGbtIOBcMssGya1M/7ADUqkzghVe8vC9Psa7nsY3teTh1rhWsB3XskAyiIe7CgSPWfbDnBFXjYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_095306_082995_4A49281C 
X-CRM114-Status: GOOD (  12.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/15/21 8:37 AM, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

No sorting logic anymore :).

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
