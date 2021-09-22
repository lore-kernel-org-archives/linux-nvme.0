Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BFAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 02:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB42610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 02:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FB42610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uBurnvJU8PMxEwuUbDRNol0JAi643IlZRjUA+EBUC/4=; b=x01Q8GsgbG6T26
	OX4MCSbjwzrc6LsKfkBTzh7WiofJH495kIeSUCUwQbAYbtwlKEOwbdLXN/oIjQ509U+8iDoA3tRMJ
	KvNeoIQDKmgMlOksDvzHlN+NRoBW+w40DPkleuNgeQTTZSQKU0jTOeInZLGSLcu4vWeb1sweVyrAw
	snQMC2M8RmVpRDu8VdM+WifhUL/OWL08jpbbyFK8q6POAnscGiaR5r1cXNCmD7ErkfYE7Oaaajv6k
	8++MTv2xo6iKby/rSssxJ4LC3/j+gTHe1LRIYszV5kGVo9AlUWO0PhWwjvxEYVlnDUaQFp3GI0k23
	ee7ILgOF4CcsyAWgBb3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSs3y-006ccm-4a; Wed, 22 Sep 2021 02:32:46 +0000
Received: from mail-co1nam11on2071.outbound.protection.outlook.com
 ([40.107.220.71] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSs3u-006ccQ-Ky
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 02:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME0CDabVrvGkLRNZlvQgmALVF0/00oidtMvh5NBwL6hAtkGLAva3TeuM2Dwga1Y81463gXMjM4sxlMTDTOEVGBDPpyNhqYegKkGwcrP+DMemYTa6H54NdyDtQu7u64lYq2K6zVdS/ToUkIGQFgYKKqaHTIVM6D5iloTNB1DqI1SKtrSWh+dKce4gm8HKBgqLqBMdmqLt//CV5Dsu0N6Kk8dXei1+eGtHbTFTHVqdTe7yIvaiax+NXB/dxedK/WCC/3YOYwUK/Zgwvfn7yKsprL3+kRWndddiYTL5ak1ccXUgAkxO4bT4oascGSmIp0Doddf6JtjL8joo7u7IrAJ6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8tga+XbcKmFGi8EXKl6tZnWctgik3ruNprUDDuZUtMI=;
 b=cl5Oz/1mCVlyoQ0b2298wqI3YHAVYLU2iolF78vWiCmejRvTscIyuEBLb2V/+OuE1w+37TYyGzCVw6C/WMh5zWOJMUdUD7QWYrjuG8NlKPotJsLvJsg8+19xUXO7oRQvtozCJKATCC/R076r0iX//yf5bhH2jc7dK0Mm1Q708oIx5+L/tEnPzom4MpM3zFgV0/OeHVejdrlcXvDeemm24rB+DPmnxNq6sDZlYTYpgSbjGC3ZIuWlsHB/yzR2T1eEflmScJIjYeMPCrp04HrVztYb8xnUPmj6jrg2dFwwoQKFnGzRwiOKEoUGIuInmQj2sgGAQ/2xtBQtuosJZzpnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tga+XbcKmFGi8EXKl6tZnWctgik3ruNprUDDuZUtMI=;
 b=roLKvwp2ODbXWV8GWpj8F/o5ghv6Qu/oFQE5ZlvenWGhEjpxHuPzOG2QdxqmE6BFGKv27p8DacVP2DOsW15Cjo0uF01Pwxqj58qZDh0849jsXSSuBc5FetD0niTcUMnTLu9x4K09XBg2cT4kKLmLBbpf0RJ1KWaO4KFpqYZsjlPYL7CKyp2HmdLm40H9ZwydXmFnaIypGwW9d9q4/FNVkG3ye9LixnbFnr36FCYa7C56KPhkNUCBFlTe3jC6rAppcNCU3B61rCWV1+4v7JBzyY1u6agAUYQSl0NLFZHShk3o1cuzDqn0LCeivsoY0wM/n8+8KAV5uveXUbZ1CraOjw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 02:32:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 02:32:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Topic: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Index: AQHXr1Vq6mywUOLpZEOhSJpv0bwHBauvVYwA
Date: Wed, 22 Sep 2021 02:32:39 +0000
Message-ID: <a214017f-8287-f281-b296-3424aba0131b@nvidia.com>
References: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
In-Reply-To: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb6ff6e-b16a-4679-343a-08d97d713f30
x-ms-traffictypediagnostic: MWHPR1201MB0224:
x-microsoft-antispam-prvs: <MWHPR1201MB02240009B57C9CB22FAEECC3A3A29@MWHPR1201MB0224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SQkwl4hddLyldtvqo1ZUxG/5Xo+sGyLVXuhgn6zl8fCknHgURgMLVKIzK5qObuOyIUo9j49a6Pjg5A8fBJgmCjaa1Gm4yABle6FMzCxRmJATZU3WbkNig7NNpHh/H3i7Slf3ZTm9NkXkLci6oZXMQcOmBbhsGpTZmWr89mbDfzSpC69DoSfI1/JimyQTys7kJc7uN934tpD7w8M3/cftk2Dh4ksrrondkhUxaiSNludJgGsPZa/lX/2l1dURDlM+rmEtgBV1fmLeBLK2uBbgeap1Ar+E04W3IkUAx7L2GUdV5ux0vRoH9XnRtcw2vacA/HvxYLCC29WYBRC80cllQDOwE8hlIRCV+6MI+Mp7k1A8AWmjkNUWMwjeqj5sID82aeW/C7GOJeSIIFhySTMF1xpoDPiC1H1cgLuj8XKLmsb2zUkhBO91fKIYSh0h/ayVuJdjUxCRQIw15Ub3/nfLRa3qYWCrT0vPFCG9WWX6QNGdyTtOirsqW4ghADH/4iSXwlcIBgip3RCXJdh+aHPIeXX0trBUBeqnEa1gbIW59VsDVdjeiIADx1wicWj0F5IjOdYtyFcrLN69dXfd9wpLdKgQDCbvJU/AqL/6yEtI7aZ3z93WVKeVbQsT2exU4Eq6STwbDnmMCEiAO3VhKRuiWEn3yoUZyuQlwukH9Tdhgjw1UM5xCNEEUYxpjgL2BO+o1Z3PGWhusyv7HVNWlfKJDdcN5NTH9pisc64tlnUTsNSAxn9HtNHmD2DR1xcNVL5PU7RCDjg0AC2zTvpUmDPZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(86362001)(186003)(110136005)(66556008)(26005)(8676002)(66946007)(38070700005)(6512007)(64756008)(66476007)(66446008)(2616005)(76116006)(6486002)(316002)(2906002)(71200400001)(4744005)(53546011)(6506007)(8936002)(31696002)(31686004)(83380400001)(508600001)(5660300002)(91956017)(38100700002)(122000001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1VyZ005N1RhTXRWbHVnWDN4VC9PQkd4RUFmS2wzZUpnMnFuakZJTWNPZmR5?=
 =?utf-8?B?dGpJNjZLL1FkeXhSQmUycnJiakEveGRFd2cwOGlUc1pjNVZPZFVUVlpwTDBJ?=
 =?utf-8?B?aXljTjRMeEtKVWNEYzN3SjNzK3hGS3R0cDdrbmtKcVdrUC9oUGEzWFNwMXYy?=
 =?utf-8?B?SitMUnFTdS9WekErZHBwbWhOdVZDS1k0cFRTUUhueDJVR09HTWsyYVVSeVJ2?=
 =?utf-8?B?N0g1Tm8wUitvMDd3a0tuTkR3cG96SU1PZlI0NHkwVXEza2pnZjY3aUlLUTJS?=
 =?utf-8?B?OERUWUFnQ0tReUVNSHJaaVNvUys4TG9HZnhRWTBqU2NEc04yZzRHYUY0V0w3?=
 =?utf-8?B?cVc4OU5TcDQ3UkFORmxTRk5TZWRRQWlvclZzeFZyL29aMExLL01RYklnaTYy?=
 =?utf-8?B?dWNuM3ZnT2NQMVB0K0VDQUJoVVF5MVZqRTMzaHV4QU15cWNSaDdBTmRnNGwv?=
 =?utf-8?B?bllYcFR3cnpReEczSmd3ZmhYckR6R1NVVG1BSEdadHJiZXdtQlJQRWpYSS9N?=
 =?utf-8?B?L1BaMy93UWlXV1JWbnI0elNMb2kraE5RWW1GajF6UjJMRDdNbGRqbFFGS1Rs?=
 =?utf-8?B?U1Uzcng3aHM5VCtZODBFMURSYmFqWVBxMDRpeURDTGhjOFcya3RwR1E1YzVk?=
 =?utf-8?B?M3JvZnpGeG9MeDRNSjBKNlk3UWNwdVZCS2xCb3RJRWMzSmJBTGlDTG9qMzVz?=
 =?utf-8?B?VTFNYVhvWUdEK1BzYzB1MXV0YkJ5VTBMbW5MYloxT3ZPQ21LQ0tRYUJvSk5n?=
 =?utf-8?B?eHhiNG1ZMkd4akh2YmQzS0gvV2NEdzVTQWdkb3h3WnlVYVBIVi9QYmJDc3VZ?=
 =?utf-8?B?dkpCMjhpdzFWS1NDOWtXZURWekNaY1BHWEpsY3BUOWhZMStweXV5RGJrcElD?=
 =?utf-8?B?SFltKytCMFoxL2JJWUo2em1pZmtyZE53bjY0UTQ1SHlqUlNzZFFabTVIWTIz?=
 =?utf-8?B?cWJVL0Q2Q2s2L214NnlhdHNhWGQrT1pIdS8wREU3RTI2RWNPTjhvRXc0VURm?=
 =?utf-8?B?WHlWRWFiOE9IM2FDbzgydzUvTGdid1ZNTHdBaFNnVFJQcXJXSzM1MHB4UGs0?=
 =?utf-8?B?YXo5WWtGQVgyWkhhMUFoaUdNb2JwU21IVXQyRkViRXFEb08xT1o3MXI5TUdv?=
 =?utf-8?B?SkExQ05KZDhJQllwZjVOKzBLOERlYno5Y2pEaWJKaTBQQjJUWklEaTU4NlJr?=
 =?utf-8?B?bHMzdUFoQ0pTOTVINGxoUnFZa3VWWkpNeWdsdzMxaVJkR2VKbUdsWUdKOFR6?=
 =?utf-8?B?YzdOS3VFcWdFeE9DdGZWdmFYQm96SXlhcEp1ZUxGSFkzM0llVjc4OUc2THlj?=
 =?utf-8?B?LzFCc2ZMOXo5SnB4L0lMTXUvZ0tvT1psRVdSRGUzMG1TUThheDE0K3k0ZlJ3?=
 =?utf-8?B?akp6SjV5aXlSQXhVNTh0TTlUQTlQZk93S0dMVjdxaUVObmtJdlpFRUxHeHVt?=
 =?utf-8?B?eTl1aFJKbm5aS2E2TnYwR0sxeFhzRjdvcmZWdFBMRUw4NDFWRFcvYlQ0V2RD?=
 =?utf-8?B?a2h2QlJPMEZJais0ZXN1eTJidVZDNlFkeFFiejJPS1FyZlZQMXdqZFdkU05K?=
 =?utf-8?B?eVU1aUYxNnA1YVA4aStGT2tidVc2WXlJVkF3OEZqRW1kWGpOeVZVaVRJTEpF?=
 =?utf-8?B?Yk9HdU9pQ1FkVGRMa1dYdFpLenBDSzFZSTUyMXNTYjJjM1ByOHlEbHVKaTkx?=
 =?utf-8?B?c1pBVFZsczZieDVqUnpYdHpGUjZ6aVNiWHVkQThFZHBDRjMycGQ1Ti9kdUlx?=
 =?utf-8?Q?PAs11M8OT5yntqo3as6uKPoSRabQicBN/rnDIrl?=
x-ms-exchange-transport-forked: True
Content-ID: <CF89D87DF454E744B0D1F4594D911FA0@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb6ff6e-b16a-4679-343a-08d97d713f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 02:32:39.3526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSlFJfLbKnLcGqJsG5xLFXESP4JyDXzltkepjJYqsHku3daGvW+9lCWEqE0SZxzOY8fcM7fJjY8fxMmmbQW9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_193242_919658_FC19E465 
X-CRM114-Status: GOOD (  11.22  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yMS8yMSA2OjU2IFBNLCBZaSBaaGFuZyB3cm90ZToNCj4gSGVsbG8NCj4gDQo+IEkgZm91
bmQgdGhpcyBpc3N1ZSBkdXJpbmcgdGhlIG52bWUgcmVtb3ZhbCB0ZXN0LCBJIGRpZCBzb21lIGRl
YnVnIGNvZGUNCj4gZm91bmQgaXQgd2FzIGZhaWxlZCBkdXJpbmcgbnZtZSAiQ1NUUyDigJMgQ29u
dHJvbGxlciBTdGF0dXMiIHJlYWQsIGNvdWxkDQo+IGFueW9uZSBoZWxwIGNoZWNrIGlmIHRoaXMg
aXMgb25lIEhXIG9yIFNXIGlzc3VlPw0KPiANCj4gDQoNCk9uZSBlYXNpZXN0IHdheSB0byBpc29s
YXRlIHRoaXMgaXNzdWUgaXMgdG8gdGVzdCB0aGUgc3RlcHMgb24gdGhlIFFFTVUNCk5WTWUgY3Ry
bCBhbmQgdXBkYXRlIGV2ZXJ5b25lIGhlcmUuLi4NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
