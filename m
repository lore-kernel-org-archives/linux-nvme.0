Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C0C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=USb167NpppRr+NMQI5IwNxTmhZkxssbXc7gzJEa3d3w=; b=jkKMS35b6O/UA58fFg9nmmw1Fa
	syBm4Te+wBhtxD0RysAIKdN7wIu5GpmVb7MB0cWG2Iv8dhTFEUf4LiVDztmsZbIX7zJS/vl5NOiYe
	N0xqaFqyNul+bEJKVV9Y0/BlnYGAmr5zc0XCrfbzxH9OlnkRYo7cICY3K/0Pk5fahSBk5pq59OM0f
	UwkBGCK7i/3aH6kyHzB/I2OSk1MOGgXhMVL9TYo3lYVSkmaUZ9wkf6stC3e3yJBjZuKS1l0uKwXna
	cuWEGn0Du7RuXCrvS3qNPruRcL+r+pDgIoF2OdoK6sbQffAoLNFsG7ULTck4M1AeNzvAXTVjuamMX
	m0TUY+fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqjD3-00ASrv-83; Mon, 16 May 2022 22:29:01 +0000
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::61b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqjD0-00ASqx-Pm
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 22:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLbGjbz1TWRDoXSa3Nq+0xidCTffaurtomhhcL9hfJ8lDAEGFvNV6mjFD1WdsXYmwiDcP/6AYRoevrqIq4Yic1Xe+jdl7aOvju4R889XpgK0vyqA5QB5BOkqg88r16xVJKAAW/o2SME+JueNmPzvF+08KjMMv6eiLiCQKWLuCuup5u6CGolpHsiiSvgjWqYi5OZ6bVmNIa3F5jJUvNsx/Q85tnvU6MpLHZ+VUgOYtYqR235nH0PJlwNaPNL4hCu931l2qG25sD3iWvHA4W9+PVzTAwAoDDwBknVlQPKh+J5n2mGFLhK9iyOzf5LBzPDKYW4/QDPPWqy8DotyTf9u9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USb167NpppRr+NMQI5IwNxTmhZkxssbXc7gzJEa3d3w=;
 b=kr6cYPw44K+G3HnCO4iO0L7wAwrK6KOTwE528Owoh10jzQCWB1spMAyVjojHHVujL9Bgvlq8hgxfwC/gC04NBU09tHqD5jg0s8aJ9t9Ki5IuhbW+cNiT2306+FtYWJHyAasSJcrx+mc+2FrVjT4Wxh3ma8W6+6J7LJIbjJ9/hruoBEcz2Gaf1wQFM1D1lG+/+GmGYpatuGYj/v6c+n/jdEHAT3Apbd7nl1IzMRgMudC2OmHcMhVkmaXywJqbR8ZgwJiXdqOw2LFhN1HCkGj3xBHTZUAsU3QCApU2p09hOSfNJxQ5Ml2Yuc3VY9jZbht9OZd8A5+heETMT2mtj8EEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USb167NpppRr+NMQI5IwNxTmhZkxssbXc7gzJEa3d3w=;
 b=pfADF4WQsRYvBmETNO5KEJhcGRqYr5jC+D+mQxY9UShab3OFrhzjGp/SThhd+Fq1xnIzZdyNEnaML2ssiWp7y3gLoh9VVAw9PodpNhlHdPN6mlWANAsIa/v4hAXnsIj8gEtw30Bi6fagPX7fDKiU2KVByevJQkBMaOg1O6nmR0D1LauS0IGBTTnvd04LB2mZ0ax8NFMHo7sBOShLwnAG88KAqqaS4c+vTTSF/wgcPYCxota9XyHL+OM4sZoxbbMEEk5UNJu7yAt6pPUMRsXriFBhv0rgDssWnkyzOB94G4sm3vbwDro4aIrdnrk9Fn+Hb6MT7xApHw2kjsmA8Fm2EQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 22:28:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 22:28:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Israel Rukshin <israelr@nvidia.com>
CC: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM established
 event
Thread-Topic: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM
 established event
Thread-Index: AQHYaG1VhEe8/N3x+EO3BL7N9slYYK0iF8qA
Date: Mon, 16 May 2022 22:28:53 +0000
Message-ID: <1d6de8d2-0675-95f3-9ff2-40af0415b046@nvidia.com>
References: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
In-Reply-To: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 810c79a3-1b95-4403-7084-08da378b758f
x-ms-traffictypediagnostic: DM6PR12MB2828:EE_
x-microsoft-antispam-prvs: <DM6PR12MB28288C24CD7A56213210EAB7A3CF9@DM6PR12MB2828.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSxzyh81UFL4zz7KQasjGP4o9VdtmQpa3LbE2OjJT8onnftHvw4Bu79+gyaSEw6MaWjvUM+/bmabdrEcqWy8pnqZvT4qp4laX5YO2Nweeh0vJ7nC1TaYcdXYZxxD6oZs8DgsqR6rKD9cApjxGMXIE7E8d626WZOuRKUdtfsXjkqxHLTaPrD+1Y3M7zEx/kJf8NF7xnc+k8fp2Sx6Twzg51Nfo1vbAgYXJuE1nxM4oYIiy5jiuvJFW6rJ4v03bukJk/7uUcY4gtfY1Jq9Cx079TbcBOGxPOhdA6iSuPpncU3rq4gSuX4UPD6sjDaMz9iG8L8OPhTKwfTnt+kT1BcRR076rcr3IRzquiZH21Ytp1JZXyb42rasNIu3UysNibkTdVgvhigd81ShXBCmVYUOc8W0qrzAJnmysS2sWOGOLQGjNruLtPd+omPiNzI3p5nZSAnONHFHpWtlD3IHZrNLXMBqe3xJB7L5doO9EbDgUJ6N7BkBurUlPnpNhY/B8V7AA9ntTWGAW4ZXRjvDpOnrfQkcxjsrDX2SG5KJzD5KnWPFxxJuJ5vCdQ/30KgpdDgkMRQY/AMHtrszjvimbSA6g8z8nn9sJKQ8PT4rtGbX/ZXMW6fQvYy52RkwXom5M1/wQnIqAqN0mrLiFpdglxhkyRcQYJUEXCgBXA2lwQEyUbcqM5DfnfuDI2XwtfTiql0InPwAB334fly9FbsA40h0WYQI0t6YrhQsHC9EPJ8e++jmpYzUy+ET9qTsumEYjQtm0aegfcBjg7Kxe2itBiV1BA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(508600001)(186003)(66946007)(122000001)(38100700002)(83380400001)(66476007)(6512007)(38070700005)(66446008)(91956017)(66556008)(316002)(31696002)(86362001)(6636002)(37006003)(8676002)(6862004)(54906003)(4326008)(8936002)(64756008)(71200400001)(76116006)(36756003)(6506007)(6486002)(31686004)(53546011)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1M5QjBaVGx5YXozaXZ3SEloS1ExcjYzRHJGU1RCOHJnYkMzTGxYV3NhcTZa?=
 =?utf-8?B?bU5rM1hTd05aY1JhQXJGczZPOEhra3AvWkNTbFZzemZFczRNNjZrdk5MQ0JY?=
 =?utf-8?B?MU5RQ21Xalh6MkVjMGtxT1pXeEdTemVibGk3eXhqUmJNUVdQb0pzTFpkUXI3?=
 =?utf-8?B?MEJPemp4eS8zYktKUnc5N2RXN2NpZHBJWE9DUjcxNnFGT0dTZEhLNVgxWWpq?=
 =?utf-8?B?T3dzd0Zvemx3SXlYRTdBY281U3crTkpsZ1VHaUZ0VU9OTC9rNUNqc2hZdkcv?=
 =?utf-8?B?V3ZBWkhWM0V6VjZuWkxyTmd6TStGd0dmZ0c4ODY1Rm4rTm1xdTJROS9hVnB3?=
 =?utf-8?B?Z0ZHQkltTW9HZkpmRDJEcEsxZkU1TWZsOFJDNzJTUk40MUlwWlBnVU1rTWVK?=
 =?utf-8?B?SG5CQkZsV1cyTnV4OERzenhJdGg4bUJxbnRSY2NNNGwxVjlmRGFtM3lpNDAz?=
 =?utf-8?B?dFVlaEZ0WVR3SlJJT25XYVRWRzFYQWlVN3RaV3NuZnl0M2ZncEpJY25aRjVG?=
 =?utf-8?B?VkZqUk1pempLRTFPQVlwK1NaMTZzdHk1UHV6bkRMcG1PQ1Jzcy95UElXOHlM?=
 =?utf-8?B?RlVUM3BDL1dHaWUrOGpFSVpacFFHcURRWGNqdC9manRJRDJISnp1a1o1SjBT?=
 =?utf-8?B?MmtpQkF3bFFqcEd0TUQ5RklJWnhZY3hXM2xheVNkTzlPWFRsMHdGVUZqTzdp?=
 =?utf-8?B?c0FkNk15UUdtdVVGejhKNVlpNjVCekM3azFKajgwN1Zkazhyd0N4NFdFWTEz?=
 =?utf-8?B?ZUN2V1hlSTFxSXdQQ1ppMVQvTnhTU0F3MG9XWDk3VzVyL3RsV2JqQlFGMHRN?=
 =?utf-8?B?Vm5nNnAwckUwNzdkbjlIVkNreFFmV29IbUI2Wmc1SWNuQlMreDJjbVcyelBw?=
 =?utf-8?B?Z0F0eE00b05Mb0NKWFJleVk0K0pyYnJabGtucTczWEkrZFRob2J2SkpNUDlN?=
 =?utf-8?B?VHRzYk54MFEyQVNPNkhVYUR6UjgxQm5YOXhKejBUdUxsR0VEL1lpdGNGU0c4?=
 =?utf-8?B?OWZEQTB0WGpQOXh0L0pha2t1TjlmdDlLVjFtTENJajZJWWZqR2tRdkhJOEEz?=
 =?utf-8?B?WnR2cXdDVTV2Qndzckc5YmpweWY2dmhRME5DM1dnUEhpNUFZSUpLUUI4b1o2?=
 =?utf-8?B?NjNXby92d09qOWVmUGhUL3pGL2dJeSttM1lMSThCclNjL0lkMTlid0t5MHNh?=
 =?utf-8?B?Z3E5QjNNQUVrdU80Z1p2eTBza1F5K2M4VHE5VE14NEVHb3YyVDRIeUYwOEh6?=
 =?utf-8?B?NVRJN1ExU292UzFwd3NyenEyRGFra2xTdmQ2L05CcHVxMVlKTUVIZ3lrUmxz?=
 =?utf-8?B?V0xaOHl5dWJEaytuRjQ4SjVvenQvRjdQMWZrREtSM0VnNTZxYU5wVFZQMk5Z?=
 =?utf-8?B?cytzMGxHYzVxc0hkU1FqZ3VBblBqZVJUSjBnZ1k4V0cwWHFiWXNoM245OGlD?=
 =?utf-8?B?cllBZVg0L0NYRGwxRFRmeGlhdGNQMWQ2VFZ0SnU1VGRhbWVqc2FzTVZ0akVG?=
 =?utf-8?B?SVQ1Ym5ZbVpUYVRMcHZRamlDSHdoRWhVMUJoelBxcWFCcTFKbVhoWnlHNWNT?=
 =?utf-8?B?ODZhamRVRnhWTk1Hc0hOYStQcVgzQzg3dHFsT09QYmZiRk0wL2JkRXdDTXVG?=
 =?utf-8?B?dHhiODQ0c082UE5vSWJlbFZLN1B3azdWNXA1QTJVcGt3UTB4bS84a0NaQXFK?=
 =?utf-8?B?RUNjR2dYd1VtUy9udGVnSU5kOFp3OEhIRHBYaHNMWlh2Y0dzTzBnT2RsQ2xB?=
 =?utf-8?B?bzVmVFIzSW9DOU90NG4rQnloYm51TTRWTVZZWDJQUmdaSzh4K1A4MXcxL3Qy?=
 =?utf-8?B?MERlNTdYMEJzSVphckQvRUo3UExUNzN0TVNVVVBtS3hiR3YwSzB3V3UyWVJY?=
 =?utf-8?B?dDdMS3JvejlZZDJtakNiNVJNb3JiZjg3Qy9kOHNlU0t0ZW9UL3NvZE12UUJk?=
 =?utf-8?B?TVNDeWZNVEdrbmpYaUNWSDlPZGE3cE9ycWxIOGhXc0VTSDQ0RTBpRlhtdmVU?=
 =?utf-8?B?Sk0ra0lTRFlnZ2ZWQUUxZ1ZkdjMxS2M1eHFzYisyaUtKbTRuN1RjdW0xSE9B?=
 =?utf-8?B?MGU2SUpDeTRTK2kweWNqeEhTakY4QWppQmVyQ0RsLzJyb3lLRWNqNUJVMTZS?=
 =?utf-8?B?NVcvdU9ubmtkU2I1SnhuRUNGYjcxWlBCNklkOVhZdVlhUXAxaURRRWtHUzZ5?=
 =?utf-8?B?bFpqQWZGWFNzV2hudlgxUUdaaTNJTXpGRGpGNVZXZ2dPL3JZN0NLbUFCOHRI?=
 =?utf-8?B?aThtb0p2MStYK2FQN2xBcXd3RU0yMFFOZThpQ3AweTlaRm1iRGpKVHVCRkt1?=
 =?utf-8?B?WXV3bHBkMEpIWWRIcC9pR3pkRE5VQWIrQytkbytoYkdqWGVwQ1Z3a3VFeGQ4?=
 =?utf-8?Q?KpF/wjOlKVI3WavsDMQvqPJKhsQAA7wQgtdJPnlAE1PgI?=
x-ms-exchange-antispam-messagedata-1: kbYu+Jkl4zsHug==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A57A72F2A520C740ABEE59C143BC766A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c79a3-1b95-4403-7084-08da378b758f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 22:28:53.8350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+FD2quXwrEBvV3bpmroFz7k//hdZlkLeJ57IZqh6e87ktLVkD4hnZuOgDX2RC0Wp8c7qiGjR8c2RgLh+gbRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_152859_143288_553A1196 
X-CRM114-Status: GOOD (  14.11  )
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

T24gNS8xNS8yMiAwODowNCwgSXNyYWVsIFJ1a3NoaW4gd3JvdGU6DQo+IEluIGNhc2UgbWFueSBj
b250cm9sbGVycyBzdGFydCBlcnJvciByZWNvdmVyeSBhdCB0aGUgc2FtZSB0aW1lIChpLmUuLA0K
PiB3aGVuIHBvcnQgaXMgZG93biBhbmQgdXApLCB0aGV5IG1heSBuZXZlciBzdWNjZWVkIHRvIHJl
Y29ubmVjdCBhZ2Fpbi4NCj4gVGhpcyBpcyBiZWNhdXNlIHRoZSB0YXJnZXQgY2FuJ3QgaGFuZGxl
IGFsbCB0aGUgY29ubmVjdCByZXF1ZXN0cyBhdA0KPiB0aHJlZSBzZWNvbmRzICh0aGUgYXJiaXRy
YXJ5IHZhbHVlIHNldCB0b2RheSkuIEV2ZW4gaWYgc29tZSBvZiB0aGUNCj4gY29ubmVjdGlvbnMg
YXJlIGVzdGFibGlzaGVkLCB3aGVuIGEgc2luZ2xlIHF1ZXVlIGZhaWxzIHRvIGNvbm5lY3QsDQo+
IGFsbCB0aGUgY29udHJvbGxlcidzIHF1ZXVlcyBhcmUgZGVzdHJveWVkIGFzIHdlbGwuIFNvLCBv
biB0aGUNCj4gZm9sbG93aW5nIHJlY29ubmVjdGlvbiBhdHRlbXB0cyB0aGUgbnVtYmVyIG9mIGNv
bm5lY3QgcmVxdWVzdHMgbWF5DQo+IHJlbWFpbiB0aGUgc2FtZS4gVG8gZml4IHRoaXMsIHJlbW92
ZSB0aGUgdGltZW91dCBhbmQgd2FpdCBmb3IgUkRNQS1DTQ0KPiBldmVudCB0byBhYm9ydC9jb21w
bGV0ZSB0aGUgY29ubmVjdCByZXF1ZXN0LiBSRE1BLUNNIHNlbmRzIHVucmVhY2hhYmxlDQo+IGV2
ZW50IHdoZW4gYSB0aW1lb3V0IG9mIH45MCBzZWNvbmRzIGlzIGV4cGlyZWQuIFRoaXMgYXBwcm9h
Y2ggaXMgdXNlZA0KPiBhdCBvdGhlciBSRE1BLUNNIHVzZXJzIGxpa2UgU1JQIGFuZCBpU0VSIGF0
IGJsb2NraW5nIG1vZGUuIFRoZSBjb21taXQNCj4gYWxzbyByZW5hbWVzIE5WTUVfUkRNQV9DT05O
RUNUX1RJTUVPVVRfTVMgdG8gTlZNRV9SRE1BX0NNX1RJTUVPVVRfTVMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBJc3JhZWwgUnVrc2hpbiA8aXNyYWVsckBudmlkaWEuY29tPg0KPiBSZXZpZXdlZC1i
eTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCj4gLS0tDQoNCkJhc2VkIG9u
IHRoZSBjb21wbGV4aXR5IG9mIGNvbXBvbmVudHMgYXJlIGludm9sdmVkIGluIHRoaXMsIHBsZWFz
ZSB3cml0ZQ0KYSBibGt0ZXN0cyBmb3IgcmRtYSB0cmFuc3BvcnQgdG8gbWFrZSBzdXJlIHRoaXMg
Z2V0cyB0ZXN0ZWQgb24gZWFjaA0KcmVsZWFzZS4NCg0KLWNrDQoNCg0K

