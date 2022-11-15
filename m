Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A087C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OG8psakOxERHKehIXx4X/hvH+EUmDG2LFLuVU5rJKgA=; b=fzPqDUsKUfBQXmxC6I7bNvZBvR
	x8rDTjGIOFJ1MZjQ31hyL/xd33RtDYiwqJL8fPKJd56IMTaXAnz7YR/bh3NuU+JTuesg8ohSuS7nn
	hW+2fxxk/DGWhD+0UjIhqH4yoG1XcTLvJbGQUyPPXnxwue9J263ffZMI/Z7U8lcO9/G51eRbE+I0e
	BON1cUly6VecZA20xDT7OMr1JIlEf0Yq4TnnEhphwJCXusZUrxdwye6xBGC00biSuOM6PSCotS2a9
	wYNjg+4yF4U0Nr9KdFFKedYKlK7YzGxXM9Pw5ffMwHTlMO7ydErW8IQnyypQXHM23Owxa0KOXKrza
	WL98sWaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounDR-007QfH-B8; Tue, 15 Nov 2022 04:06:29 +0000
Received: from mail-co1nam11on20629.outbound.protection.outlook.com ([2a01:111:f400:7eab::629] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounDL-007QbN-UL
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ5i70zNwYMxXzQfnAxrXbtkedSIP/GNVLYCQKhx0Mt5G8BcjjKoqt/XSqtXgimkfb0zyTV93cYWZZc3Qn6Gyc1AO4y2inA7w0wMmF6gLjRePXyQxAioyjdKvuPX5FvvEN5GexUHz1dzP/nb2iQYKrb8z0vBxfwMd/RzrD3KqgbJYdQw5Qic4fJw9ZmRk1zS9r6CnYjcz1OckVlP/7AjNelTR6CvB1bbtimoKD0nDsRxa89rAqg1Zhw37KlS24kqRFd24dj5qfOFqeeIoGG6ipfX+kIvyKzUSO24sBQBX699MQPQ5ZruKGlHZfzj3hfUTdU/kqxlzH65QOQZtWyM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG8psakOxERHKehIXx4X/hvH+EUmDG2LFLuVU5rJKgA=;
 b=mkH4GMpdj9Hju8w//qhyysWt2tkr3dc9MuA3q4a5XETbvuAC8DFLp8kFkVnuKE5fP0Cef+/5rz5zTY2iVnwHTArnncMX56cAducQ5kc0LJlxCQQ47O9nmHJvV1VMqF7Gzthh/iPOsN4g3bDO+0zmyi7CHZh3RhvLkxTVLy6eluCn9IdtIxpYK2vLk+qmKS7+Rfy6DX1WyYysmE8XqmEZVncEAnI611sSxDtDj2RFsJIuDCilCLZyEDJNtcmG+UC9sFMWDzMcoDKS4gRfGWTsSMyTJnlsNxi6HeC9RGMQlU602LB2HDvvyELvRETHCFC/Tx/Tox6ZL+VRNNHAqCCfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG8psakOxERHKehIXx4X/hvH+EUmDG2LFLuVU5rJKgA=;
 b=fGbSMe7IYnQZZ4pDsEJDZDXWJPyDQEDVZ8ImW3qYZrCAfki8kT29x1rzpi70ZBIufV6ldG7LOV/ioptDIXF3rZvFUxD4XokU8L9n2XuLlDSYk7xRY2C0ZAj5w2mvwUA+frBg3FSTY2A+WVsdNbBRub969CPD+dccAy8b4RHBKWDH7Ybq0YQWYFJNTixgMFRGBy1Pf0LHXrtDpEgyjunLxzwmbybVnx+pGfelWD/USWNxiQaLRU26qUL45WhXfDeNjbmpOtbXKhDkX5WDOTaqol/iGL4Bvg9QxugdKfF2bj7xzmpb12B/97Cf8Ch5JIL4pRGLID7Uw+4ci6+36/1Kxw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 15 Nov
 2022 04:06:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:06:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 11/20] nvme-auth: clear sensitive info right after
 authentication completes
Thread-Topic: [PATCH v2 11/20] nvme-auth: clear sensitive info right after
 authentication completes
Thread-Index: AQHY91LesiVfROCtGUq3s7drJWuxxK4/YJMA
Date: Tue, 15 Nov 2022 04:06:19 +0000
Message-ID: <3ff345e4-05f0-03b0-cb1e-d5a2c2d50e86@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-12-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-12-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5191:EE_
x-ms-office365-filtering-correlation-id: d10a6e00-5e3e-48ca-a4e2-08dac6bec019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bMngEDxfyzU5Lnp40UUsiqXnM2Hzv1IscEJm6/rEyABkhliL36ITc6pvfbH5vxllr5vTXvzsTwC/Wj4QIMmJRh8iNBRFH45f4gGXgYz+bfP72SgpGEgyNPlwomPtpGhXc0RqgrsyWfUmQVYJ8LXOYVCm3DrKu+CbUUMeo+lVErU15ZCtTb6wBIGozLKAKCuRYZnxTx6/jCQwQ7KG71MndCfsvQFWxPzAGx7+KkpF3TPgoc8YGs4OUyFPd2smfOLPuDkSoJGKiLMAg2bx/eKR7G7eO3o/yyPOrG5/mUt4aTYGtoRWhC4/vl/88opoJdth/M6NUlyKpGVLx/FqffSDk4Rdjm6lSXtCpen29K47QSYzFZdF0SxbHaecqwlNQRQ5wzKQEf6IVYl+uju9gnK6/lyQeK3AURMkj8QLON+hxLt52e3OSHDrwHONMYq1czkdb2SGEGqjfIP2LF8GNtjIY3htszpLwYBB9uFtWCG7V1wia/np4jtx8oZoHbNZetc0zQ+N1LP2O9jkTkH4U8Hba0/FXeHTJR7DrOMRaMVs24DeP76C79Tt251pUKkSOkFjSIgLz0CRuYp0pT+9pfFTmiEcQ4bsh4d+64BBGASm2HUwDZPa4GQp7A+ZWmle/9TZcwWGRB9A41WyvvzO+6bOGbgOeGQioRLH9uBhcL0yOLyJvMoC3QyEhHjBLGfCS1ryLBoLyJk6LuZA+Z9JY5cnaQb7Gr5i+xljbnCcJnnUFrLO9GsDImhsbH0iO3eYeBUwDLceA/eoOfGy+kWX7whw/op76+1n/cFKekkw1tWjDlpI6IW1KGHTIDgNQszVZcNBE29xQdPaURWQTC3KLX0cMw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(38100700002)(186003)(66899015)(36756003)(110136005)(66446008)(41300700001)(478600001)(6486002)(54906003)(5660300002)(76116006)(8676002)(66476007)(2906002)(66946007)(83380400001)(64756008)(38070700005)(8936002)(66556008)(4326008)(71200400001)(53546011)(31686004)(86362001)(6512007)(31696002)(2616005)(4744005)(122000001)(316002)(6506007)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Rjhva0QyWWFCWWRZS2ZQd1UxN0JsTEx5UW42MjlseVNYT3V3RnpZM0Z3VURE?=
 =?utf-8?B?cFBnYzNNU0cvMVQwNzdNTDFyRHlGRFBDWnlzR3BSZEEvVlJDNGNtYzdOMHph?=
 =?utf-8?B?dWEzN1VmeEs3YTkrczFKNVo0VFVXbmhDNytsZkhRNDltelFxaVNTZWc0Z2Zt?=
 =?utf-8?B?R1BFUTYwZHJ5Rm4wOVh4SGc5U0E5WURBSnM3SUF3eFZFRVlHTXNWR1cyNUcx?=
 =?utf-8?B?WGQ2cmd5Zys1QkZlNjdxamJZL0VrT25Ha1V5T1RTWmVNYVZhQmRUUGUzREFS?=
 =?utf-8?B?ams3R01LNEhvVU13V2wrTU1ZbFFhbEdYMzdKbnVrZEpFRzFGaEhvS0hXYnNw?=
 =?utf-8?B?UXduSUJOZjh4REtxTGtObUtBb2NzMmFTY2NWWVFORDlkdEJpK3RETm9GaE54?=
 =?utf-8?B?SUVzTytsWlpkNm0wMkswL2lQWnhDemRoT0ZTYmRkZHJQc2FPMXJiUnUwaG0z?=
 =?utf-8?B?NmgvSnZ2SHkyY2gzL0IyVjdTNXRibVdHclhWTHpPSHlNL2tYb3lvcU5sZFhH?=
 =?utf-8?B?T1Rmdk56RC82azVLRVliNkh2TDZXclo4b3B3OGE3OGdzcXlJdC9pcHV3MWxz?=
 =?utf-8?B?dTVINlRsTTkrTU4zUTJnZEVzUWcxRGRtNHhXcXRhTmV3dTdaakxiSEpIZDU3?=
 =?utf-8?B?SnAwNVJKWmdmVXFjcjBXQVVkWU4yc3B0cjM4RmpnYnBDL0luTmJpYXBjTVlD?=
 =?utf-8?B?dkE3cVNPUnpNM0xtSGxYVnRjUXlhTGlnN3VpT0wzOTdDZ3dUT2lkWkRzcGxC?=
 =?utf-8?B?a0ViYlp5THNmUGpreThxVnR5S2F0cFJkVXNzK0wyV1FUdDRLaHFMVnE1Wnhv?=
 =?utf-8?B?c0NFdnZ4OFpiQWpkQm9qR0hDU1BDNnRiU0djV1pDbWNuK2NxOFA0RDEwd3NF?=
 =?utf-8?B?ZTR2ek51ZmJpUlJpb0ZRTDBPWlhtUHlhRTkvbHE5U0VnNm9DZWJjc21scUFV?=
 =?utf-8?B?RHNKZTAvVjdmTXV4Yk8yVlhXWDZlU3hQeHlEYkpqb1pQZEJCUWZzbkhwOERS?=
 =?utf-8?B?K2VzK29zNDBZZFI2TkVaSUpWdE9VVUtlc0lTU1BRWHdydWlENVRRTVU5T3hm?=
 =?utf-8?B?MFJCTEpmdktrT0RiK1l6b1BxeWwrbGdseEhCRllJWExGdTBxVWtLUmdxcTV4?=
 =?utf-8?B?NHduK2RuVy8wck5xTDQvdWlTRURSZUVheGY5REgzWjVwVCs2SE85YWIrbjBS?=
 =?utf-8?B?RjBVbFlIY0tNZ2dzcmp3M01FM3J6WDByTmJiQ1lROVVJeDVybFhVcXp6SGhC?=
 =?utf-8?B?OVd0a0RUM3V1UE9hSVF2Q1ZXSXhoK0lsbG41M2NDNHVIejdiZm45RHN4K0E3?=
 =?utf-8?B?UDFkWGVUenFJNUVSMkh0aU1mdUlmN1lqZVhXc296WEs1NWQ3RjluaHlKRkZ3?=
 =?utf-8?B?TkxrcDA2NlZvMmVHZlBzRU90RkRwZHZwL2RGRVBySGVEWE0xVE5SMlFueG1T?=
 =?utf-8?B?a242NU51ZnZoQ0Y1OGIrY2lCSUZmREdiSyt5dDVPYnVRS1c0NSs5WjlkM1Br?=
 =?utf-8?B?S3RrRHNWTjBBUnhJdFIvRmx6Wk9sd1BhVlg5RHF1eWFzZnVHMEZ2S2x0TFJ0?=
 =?utf-8?B?alI2YUZjSDZydXgrV1VEbkk4TUk1Q05wSGdWMHZyaW5FNTIzQVBnZWgvTldh?=
 =?utf-8?B?VGhyMVBvZGM3MUxYUUdnWklFeTJSZkE3MEhNZUxVYkptWGM4LzNlM3IyOEhH?=
 =?utf-8?B?VlJ4VVJLSGtUYzd3ekUxNjUydG1VaHMzblExaGFUSVdlbUo2cDVPSUtYZ2Zp?=
 =?utf-8?B?VjVVMHU4dXd5dXdna0ZsRk9yNG14RXRyY05keU1NSDh2cmR4ZFVDeS8zcjNj?=
 =?utf-8?B?ajZSOC9lVDdqODdBeldYYURNWFVQb1RQeXh5eWRvY093N1N4QXdITi92YnN3?=
 =?utf-8?B?Zi9HUUUzWUY0bUZxTlZMbEVURmtQUDdoOEthWEV4SkdkbjNLSkVsOVM1ajJ3?=
 =?utf-8?B?VXkyNEl4VXhXY0dYUTNMN3Nvanl4UThOWS9ISnBmRW0zQlFkbzFmRFdvS2N4?=
 =?utf-8?B?c2UvSVZib0QweW8xbFVNUUVsZmtMUGpMWkdHTzRRajBKQWMvMlBjUmFDemRo?=
 =?utf-8?B?WmRaUEdCa0NPUEt0QzlYOHVKM3dDcER0Q1Fsb0x0b0xmWUpDVGF1WGNVSis5?=
 =?utf-8?B?WVZtYTdKNnZ2OERBT2QyUGNac3VXL0MvNEo4UlFvTXpvWDlBZkNPK3ZLYmxB?=
 =?utf-8?Q?MDWgoyPBsV7JsnYsg9NaQdhC3u42hKY1TrTd0c3r6utx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23CAB6D5818E664CBF6ED9D3A0788C7B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10a6e00-5e3e-48ca-a4e2-08dac6bec019
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:06:19.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkhDwFRRo78iSgmf1hYZuxHTT0ePAIeTczdTDERBsCFIBqkpt1m6SfbbyqXIKqKETi18EEgFSM70XfZ3YPj5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_200624_020559_73EE0A7E 
X-CRM114-Status: GOOD (  10.72  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFdlIGRvbid0IHdhbnQg
dG8ga2VlcCBhdXRoZW50aWNhdGlvbiBzZW5zaXRpdmUgaW5mbyBpbiBtZW1vcnkgZm9yIHVubGlt
aXRlZA0KPiBhbW91bnQgb2YgdGltZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVj
a2UgPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT4NCj4gLS0tDQoNCm1heWJlIHdvcnRoIHNwZWNpZnlpbmcgdGhlIHNpZGUgZWZm
ZWN0cyBvZiBrZWVwaW5nIGl0IGluIHRoZSBtZW1vcnkNCmZvciB1bmxpbWl0ZWQgdGltZSA/IG5v
dCBhIGJpZyBkZWFsIC4uLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

